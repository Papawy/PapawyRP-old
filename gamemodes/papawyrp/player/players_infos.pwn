#if defined PLAYERS_INFOS_INCLUDED
	#endinput
#endif

#define PLAYERS_INFOS_INCLUDED

// ----------------------------------------------------------------------------

#include "core.pwn"

// ----------------------------------------------------------------------------

#define MAX_PLAYER_PASS					VERY_SHORT_STR
#define MIN_PLAYER_PASS					4

// ----------------------------------------------------------------------------

enum P_INFOS {
	pUniqueID,
	pRegistered, // var not stored, it's usefull to not do a SQL query when you want to know if he's registered
	pName[MAX_PLAYER_NAME+1],
	pPass[MAX_PLAYER_PASS],
	pRegisterDate, // timestamp
	pAdminRank
};


/*
new P_INFOS_STR[] = {
	"UniqueID", 
	"Name",
	"Pass",						// Maybe later
	"RegisterDate",
	"AdminRank"
};*/

new pInfos[MAX_PLAYERS][P_INFOS];

stock IsPlayerRegistered_hardCheck(playerid)
{
	#if defined USE_MYSQL

	#else
	if(!fexist(GetPlayerDataPath(playerid)))
	{
		pInfos[playerid][pRegistered] = false;
		return false;
	}
	else
	{
		pInfos[playerid][pRegistered] = true;
		return true;
	}
	#endif
}

stock IsPlayerRegistered(playerid)
{
	return pInfos[playerid][pRegistered];
}