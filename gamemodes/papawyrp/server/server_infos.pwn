#if !defined SERVER_INFOS_INCLUDED
	#define SERVER_INFOS_INCLUDED
#endif

// ----------------------------------------------------------------------------

#include <YSI4\YSI_Coding\y_hooks>

// ----------------------------------------------------------------------------

#define SERVER_CONFIG_FILE				"papawyrp_cfg.ini"
#define SERVER_DATA_FILE				sInfos[sDataFile]

#define PLAYER_DATA_PATH				sInfos[pDataPath]

#define SERVER_NAME						sInfos[sName]
#define SERVER_WEBSITE					sInfos[sWebsite]
#define SERVER_MAP						sInfos[sMap]
#define SERVER_MODE						sInfos[sMode]

#define MAX_PATH_LEN					VERY_SHORT_STR

// ----------------------------------------------------------------------------

enum SERVER_INFOS {
	// Infos
	sName[VERY_SHORT_STR],
	sWebsite[VERY_SHORT_STR],
	sMap[VERY_SHORT_STR],
	sMode[VERY_SHORT_STR],
	// Paths
	sDataFile[MAX_PATH_LEN],
	pDataPath[MAX_PATH_LEN],
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

		strins(sInfos[sDataFile],	"papawyrp_data.ini", 0);
		strins(sInfos[pDataPath],	"users/" ,0);

		SaveServerConfiguration();

		print("+ Server configuration file created.");
	}
	else
	{
		INI_ParseFile(SERVER_CONFIG_FILE, "ServerConfigLoading");
		print("+ Server configuration file loaded.");
	}

	if(!fexist(SERVER_DATA_FILE))
	{
		print("+ No server data file present. Creating one...");

		sInfos[sMaxPlayersRegistered] 	= 0;
		sInfos[sMaxPlayersConnected] 	= 0;

		strins(sInfos[sName] 			, "PapawyRP", 0);
		strins(sInfos[sWebsite]			, "http://www.404.com", 0);
		strins(sInfos[sMap]				, "Mapping-pong", 0);
		strins(sInfos[sMode]			, "Papawy RP V."PAPAWYRP_VERSION, 0);

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

	return 1;
}

hook OnGameModeExit()
{

	SaveServerConfiguration();
	print("+ Server configuration saved.");

	SaveServerData();
	print("+ Server data saved.");



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

forward SaveServerConfiguration();
public SaveServerConfiguration()
{
	new INI:cfg = INI_Open(SERVER_CONFIG_FILE);

	INI_WriteString(cfg, 	"SERVER_DATA_FILE"		, sInfos[sDataFile]);
	INI_WriteString(cfg, 	"PLAYER_DATA_PATH"		, sInfos[pDataPath]);

	INI_Close(cfg);
}

forward SaveServerData();
public SaveServerData()
{
	new INI:data = INI_Open(SERVER_DATA_FILE);

	INI_WriteInt(data, 		"MAX_PLAYERS_REGISTERED", sInfos[sMaxPlayersRegistered]);
	INI_WriteInt(data, 		"MAX_PLAYERS_CONNECTED"	, sInfos[sMaxPlayersConnected]);

	INI_WriteString(data,	"SERVER_NAME"			, sInfos[sName]);
	INI_WriteString(data,	"SERVER_WEBSITE"		, sInfos[sWebsite]);
	INI_WriteString(data,	"SERVER_MAP"			, sInfos[sMap]);
	INI_WriteString(data,	"SERVER_MODE"			, sInfos[sMode]);

	INI_Close(data);
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

	SetGameModeText(sInfos[sMode]);
}

// ----------------------------------------------------------------------------

forward ServerConfigLoading(name[], value[]);
public ServerConfigLoading(name[], value[])
{
	INI_String(		"SERVER_DATA_FILE"		, sInfos[sDataFile], MAX_PATH_LEN);
	INI_String(		"PLAYER_DATA_PATH"		, sInfos[pDataPath], MAX_PATH_LEN);

	return 0;
}

forward ServerDataLoading(name[], value[]);
public ServerDataLoading(name[], value[])
{
	INI_Int(		"MAX_PLAYERS_REGISTERED", sInfos[sMaxPlayersRegistered]);
	INI_Int(		"MAX_PLAYERS_CONNECTED"	, sInfos[sMaxPlayersConnected]);

	INI_String(		"SERVER_NAME"			, sInfos[sName]		, VERY_SHORT_STR);
	INI_String(		"SERVER_WEBSITE"		, sInfos[sWebsite]	, VERY_SHORT_STR);
	INI_String(		"SERVER_MAP"			, sInfos[sMap]		, VERY_SHORT_STR);
	INI_String(		"SERVER_MODE"			, sInfos[sMode]		, VERY_SHORT_STR);

	print("+ Server data file loaded.");
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

stock GetPlayerUniqueID(playerid)
{
	return db_hash(GetPlayerNameEx(playerid));
}

stock GetPlayerDataPath(playerid)
{
	new str[VERY_SHORT_STR];
	format(str, sizeof(str), "%s%i", sInfos[pDataPath], GetPlayerUniqueID(playerid));
	return str;
}