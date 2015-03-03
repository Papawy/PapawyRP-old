#if defined PLAYERS_INFOS_INCLUDED
	#endinput
#endif

#define PLAYERS_INFOS_INCLUDED

// ----------------------------------------------------------------------------

#include "core.pwn"

// ----------------------------------------------------------------------------

#define MAX_PLAYER_PASS					VERY_SHORT_STR
#define MIN_PLAYER_PASS					4

#define HASHED_PASS_LENGHT				NORMAL_STR+1

// ----------------------------------------------------------------------------

// Why pPass don't have the MAX_PLAYER_PASS lenght ? Beacause it's hashed and it take 129 characters.

enum P_INFOS {
	pSqlID,
	ORM:pOrmID, // var not stored, ORM use only
	pRegistered, // var not stored, it's usefull to not do a SQL query when you want to know if he's registered
	pName[MAX_PLAYER_NAME+1],
	pPass[HASHED_PASS_LENGHT],
	pEamil[NORMAL_STR],
	pRegisterDate, // timestamp
	pAdminRank
};

new pInfos[MAX_PLAYERS][P_INFOS];

stock IsPlayerRegistered(playerid)
{
	return pInfos[playerid][pRegistered];
}