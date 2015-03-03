#if defined PLAYERS_VARS_INCLUDED
	#endinput
#endif

#define PLAYERS_VARS_INCLUDED

// ----------------------------------------------------------------------------

#include "core.pwn"

// ----------------------------------------------------------------------------

#include <YSI4\YSI_Coding\y_hooks>

// ----------------------------------------------------------------------------

/*
	key 
	- 0 : SQL ID
	- 1 : player name 
*/

forward LoadPlayerData(playerid, key=0);
public LoadPlayerData(playerid, key=0)
{
	new ORM:pOrm = pInfos[playerid][pOrmID] = orm_create("playersData");
	orm_addvar_int(pOrm, 	pInfos[playerid][pSqlID], 						"ID");
	orm_addvar_string(pOrm, GetPlayerNameEx(playerid), MAX_PLAYER_NAME+1, 	"Name");
	orm_addvar_string(pOrm, pInfos[playerid][pPass], MAX_PLAYER_PASS,		"Pass");
	orm_addvar_string(pOrm, pInfos[playerid][pEmail], NORMAL_STR,			"Email");
	orm_addvar_int(pOrm, 	pInfos[playerid][pRegisterDate], 				"RegisterData");
	orm_addvar_int(pOrm, 	pInfos[playerid][pAdminRank],					"AdminRank");

	switch(key)
	{
		case 0:
			orm_setkey(pOrm, "ID");

		case 1:
			orm_setkey(pOrm, "Name");

		default:
			orm_setkey(pOrm, "ID");
	}
	orm_select(pOrm, "OnPlayerDataLoad", "d", playerid);

	return true;
}

forward OnPlayerDataLoad(playerid);
public OnPlayerDataLoad(playerid)
{
	switch(orm_errno(pInfos[playerid][pOrmID]))
	{
		case ERROR_OK: {
			pInfos[playerid][pRegistered] = true;
		}
		case ERROR_NO_DATA: {
			pInfos[playerid][pRegistered] = false;
		}
	}
	return 1;
}

forward SavePlayerData(playerid);
public SavePlayerData(playerid)
{
	if(IsPlayerRegistered(playerid))
	{
		orm_update(pInfos[playerid][pOrmID]);
	}
}