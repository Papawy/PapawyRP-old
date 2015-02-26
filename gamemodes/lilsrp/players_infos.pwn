#if defined PLAYERS_INFOS_INCLUDED
	#endinput
#endif

#define PLAYERS_INFOS_INCLUDED

// ----------------------------------------------------------------------------

#include "core.pwn"

// ----------------------------------------------------------------------------

enum P_INFOS {
	pUniqueID,
	pName[MAX_PLAYER_NAME+1],
	pPass[MAX_PLAYER_PASS],

}

new pInfos[MAX_PLAYERS][P_INFOS];