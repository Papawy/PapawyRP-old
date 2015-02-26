#if defined PLAYERS_VARS_INCLUDED
	#endinput
#endif

#define PLAYERS_VARS_INCLUDED


#include "lilsrp/core.pwn"

enum P_INFOS {
	P_UNIQUE_ID,
	P_NAME[MAX_PLAYER_NAME+1],
	P_PASS[]
}

#if defined USE_MYSQL

forward GetPlayerVar_Int(pUniqueID, )