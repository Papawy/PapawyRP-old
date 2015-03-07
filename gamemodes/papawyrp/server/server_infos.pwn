#if !defined SERVER_INFOS_INCLUDED
	#define SERVER_INFOS_INCLUDED
#endif

// ----------------------------------------------------------------------------

#include <YSI4\YSI_Coding\y_hooks>

// ----------------------------------------------------------------------------

#define SERVER_CONFIG_FILE				"papawyrp_cfg.ini"

#define SERVER_NAME						sInfos[sName]
#define SERVER_WEBSITE					sInfos[sWebsite]
#define SERVER_MAP						sInfos[sMap]
#define SERVER_MODE						sInfos[sMode]

#define ORM_SERVER_ID					sInfos[ormServerID]

#define SQL_SERVER_TABLE				sInfos[tblServerData]
#define SQL_PLAYER_TABLE				sInfos[tblPlayerData]

#define MAX_PATH_LEN					VERY_SHORT_STR

// ----------------------------------------------------------------------------

enum SERVER_INFOS {
	// GM id
	gmID,
	// Infos
	sName[VERY_SHORT_STR],
	sWebsite[VERY_SHORT_STR],
	sMap[VERY_SHORT_STR],
	sMode[VERY_SHORT_STR],
	// Paths
	sDataFile[MAX_PATH_LEN],
	// MySQL DB Infos
	dbAddress[VERY_VERY_SHORT_STR],
	dbUser[VERY_VERY_SHORT_STR],
	dbPass[SHORT_STR],
	dbName[SHORT_STR],
	// MySQL Tables
	tblServerData[VERY_VERY_SHORT_STR],
	tblPlayerData[VERY_VERY_SHORT_STR],
	// ORM ID
	ORM:ormServerID,
	// Stats
	sMaxPlayersConnected,
	sMaxPlayersRegistered,
	sPlayersConnected
};

new sInfos[SERVER_INFOS];

// ----------------------------------------------------------------------------

hook OnGameModeInit()
{
	sInfos[sPlayersConnected] = 0;

	if(!fexist(SERVER_CONFIG_FILE))
	{
		print("+ No server configuration file present. Creating one...");

		SaveServerConfiguration();

		print("+ Server configuration file created.");
	}
	else
	{
		INI_ParseFile(SERVER_CONFIG_FILE, "ServerConfigLoading");
		print("+ Server configuration file loaded.");
	}

	if(strlen(sInfos[dbAddress]) == 0)
		print("/!\\ MySQL Infos unallocated ! Run MySQL_assistant GameMode !");
	else if(strlen(sInfos[dbUser]) == 0)
		print("/!\\ MySQL Infos unallocated ! Run MySQL_assistant GameMode !");
	else if(strlen(sInfos[dbName]) == 0)
		print("/!\\ MySQL Infos unallocated ! Run MySQL_assistant GameMode !");
	else
	{
		MySQL_Init(sInfos[dbAddress], sInfos[dbUser], sInfos[dbPass], sInfos[dbName]);
	}

	if(strlen(sInfos[tblServerData]) == 0)
	{
		print("/!\\ Server Data SQL Table NOT DEFINED !!!");
		strins(sInfos[sName] 			, "PapawyRP", 0);
		strins(sInfos[sWebsite]			, "http://www.404.com", 0);
		strins(sInfos[sMap]				, "Mapping-pong", 0);
		strins(sInfos[sMode]			, "Papawy RP V", 0);
		SetServerInfosInSAMPBrowser();
	}
	else
	{
		sInfos[gmID] = 1;

		sInfos[ormServerID] = orm_create(SQL_SERVER_TABLE);

		orm_addvar_int(ORM_SERVER_ID, sInfos[gmID], "GM_Id");
		orm_addvar_string(ORM_SERVER_ID, sInfos[sName]		, VERY_SHORT_STR, "GM_Name");
		orm_addvar_string(ORM_SERVER_ID, sInfos[sWebsite]	, VERY_SHORT_STR, "GM_Website");
		orm_addvar_string(ORM_SERVER_ID, sInfos[sMap]		, VERY_SHORT_STR, "GM_Map");
		orm_addvar_string(ORM_SERVER_ID, sInfos[sMode]		, VERY_SHORT_STR, "GM_Mode");

		orm_addvar_int(ORM_SERVER_ID, sInfos[sMaxPlayersConnected], "MaxPlayersConnected");
		orm_addvar_int(ORM_SERVER_ID, sInfos[sMaxPlayersRegistered], "MaxPlayersRegistered");

		orm_setkey(ORM_SERVER_ID, "GM_Id");
		orm_select(ORM_SERVER_ID, "OnServerDataLoad");
	}


/*
	if(!fexist(SERVER_DATA_FILE))
	{
		print("+ No server data file present. Creating one...");

		sInfos[sMaxPlayersRegistered] 	= 0;
		sInfos[sMaxPlayersConnected] 	= 0;

		strins(sInfos[sName] 			, "PapawyRP", 0);
		strins(sInfos[sWebsite]			, "http://www.404.com", 0);
		strins(sInfos[sMap]				, "Mapping-pong", 0);
		strins(sInfos[sMode]			, "Papawy RP V"PAPAWYRP_VERSION, 0);

		SaveServerData();

		print("+ Server data file created.");
		SetServerInfosInSAMPBrowser();
	}
	else
	{
		INI_ParseFile(SERVER_DATA_FILE, "ServerDataLoading");
		print("+ Server data file loaded.");
		SetServerInfosInSAMPBrowser();
	}
*/
	return 1;
}

hook OnGameModeExit()
{

	SaveServerConfiguration();
	print("+ Server configuration saved.");

	SaveServerData();
	print("+ Server data saved.");

	orm_destroy(ORM_SERVER_ID);

	SetTimer("MySQL_Close", 1000, false);

	MySQL_Close();

	return 1;
}

hook OnPlayerConnect(playerid)
{
	if(!IsPlayerNPC(playerid))
	{
		sInfos[sPlayersConnected]++;

		if(sInfos[sPlayersConnected] > sInfos[sMaxPlayersConnected])
			sInfos[sMaxPlayersConnected] = sInfos[sPlayersConnected];
	}

	return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
	if(!IsPlayerNPC(playerid))
	{
		sInfos[sPlayersConnected]--;
	}
	return 1;
}

// ----------------------------------------------------------------------------

forward OnServerDataLoad();
public OnServerDataLoad()
{
	switch(orm_errno(ORM_SERVER_ID))
	{
		case ERROR_OK:
			printf("+ Server data loaded.");
		case ERROR_NO_DATA:
		{
			printf("+ Server data not loaded : there is no data to load");

			strins(sInfos[sName] 			, "PapawyRP", 0);
			strins(sInfos[sWebsite]			, "http://www.404.com", 0);
			strins(sInfos[sMap]				, "Mapping-pong", 0);
			strins(sInfos[sMode]			, "Papawy RP V", 0);
		}
	}
	SetServerInfosInSAMPBrowser();
	return 1;
}

// ----------------------------------------------------------------------------

forward SaveServerConfiguration();
public SaveServerConfiguration()
{
	new INI:cfg = INI_Open(SERVER_CONFIG_FILE);

	INI_WriteString(cfg, 	"DB_ADDRESS"		, sInfos[dbAddress]);
	INI_WriteString(cfg, 	"DB_USER"			, sInfos[dbUser]);
	INI_WriteString(cfg, 	"DB_PASS"			, sInfos[dbPass]);
	INI_WriteString(cfg, 	"DB_NAME"			, sInfos[dbName]);

	INI_WriteString(cfg, 	"TBL_SERVER"		, sInfos[tblServerData]);
	INI_WriteString(cfg, 	"TBL_PLAYER"		, sInfos[tblPlayerData]);

	INI_Close(cfg);
}

forward SaveServerData();
public SaveServerData()
{
	orm_update(ORM_SERVER_ID);
	return 1;
}

forward SetServerInfosInSAMPBrowser();
public SetServerInfosInSAMPBrowser()
{
	new tmpstr[SHORT_STR];
	strins(tmpstr, "hostname ", 0); 
	strcat(tmpstr, SERVER_NAME);
	//format(tmpstr, sizeof(tmpstr), "hostname %s", SERVER_NAME);
	SendRconCommand(tmpstr); strdel(tmpstr, 0, strlen(tmpstr));

	strins(tmpstr, "mapname ", 0); 
	strcat(tmpstr, SERVER_MAP);
	SendRconCommand(tmpstr); strdel(tmpstr, 0, strlen(tmpstr));

	strins(tmpstr, "weburl ", 0); 
	strcat(tmpstr, SERVER_WEBSITE);
	SendRconCommand(tmpstr); strdel(tmpstr, 0, strlen(tmpstr));

	strins(tmpstr, "gamemodetext ", 0);
	strcat(tmpstr, SERVER_MODE);
	strcat(tmpstr, PAPAWYRP_VERSION);
	SendRconCommand(tmpstr);
}

// ----------------------------------------------------------------------------

forward ServerConfigLoading(name[], value[]);
public ServerConfigLoading(name[], value[])
{
	INI_String("DB_ADDRESS"			, sInfos[dbAddress], VERY_VERY_SHORT_STR);
	INI_String("DB_USER"			, sInfos[dbUser], VERY_VERY_SHORT_STR);
	INI_String("DB_PASS"			, sInfos[dbPass], VERY_SHORT_STR);
	INI_String("DB_NAME"			, sInfos[dbName], VERY_SHORT_STR);

	INI_String("TBL_SERVER"			, sInfos[tblServerData], VERY_VERY_SHORT_STR);
	INI_String("TBL_PLAYER"			, sInfos[tblPlayerData], VERY_VERY_SHORT_STR);

	return 0;
}

// ----------------------------------------------------------------------------

stock GetPlayersConnected()
{
	return sInfos[sPlayersConnected];
}

stock GetPlayersConnectedRecord()
{
	return sInfos[sMaxPlayersConnected];
}

stock GetMaxPlayersRegistered()
{
	return sInfos[sMaxPlayersRegistered];
}