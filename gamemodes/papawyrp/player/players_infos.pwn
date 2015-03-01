#if defined PLAYERS_INFOS_INCLUDED
	#endinput
#endif

#define PLAYERS_INFOS_INCLUDED

// ----------------------------------------------------------------------------

#include "core.pwn"

// ----------------------------------------------------------------------------

#define MAX_PLAYER_PASS					VERY_SHORT_STR

// ----------------------------------------------------------------------------

enum P_INFOS {
	pUniqueID,
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

stock IsPlayerRegistered(playerid)
{
	#if defined USE_MYSQL

	#else
	if(!fexist(GetPlayerDataPath(playerid)))
	{
		return false;
	}
	else
	{
		return true;
	}
	#endif
}