#if !defined PLAYERS_DISCONNECTION_INCLUDED
	#define PLAYERS_DISCONNECTION_INCLUDED
#endif

// ----------------------------------------------------------------------------

#include <YSI4\YSI_Coding\y_hooks>

// ----------------------------------------------------------------------------

#include "core.pwn"

// ----------------------------------------------------------------------------

hook OnPlayerDisconnect(playerid, reason)
{
	if(pInfos[playerid][pSqlID] != 0) {
		orm_update(pInfos[playerid][pOrmID]);	
	}
	orm_destroy(pInfos[playerid][pOrmID]);

	return 1;
}