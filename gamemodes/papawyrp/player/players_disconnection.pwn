#if !defined PLAYERS_DISCONNECTION_INCLUDED
	#define PLAYERS_DISCONNECTION_INCLUDED
#endif

// ----------------------------------------------------------------------------

#include <YSI4\YSI_Coding\y_hooks>

// ----------------------------------------------------------------------------

#include "core.pwn"

// ----------------------------------------------------------------------------

hook OnGameModeExit()
{
	if(pInfos[playerid][pSqlID] != 0) {
		orm_update(pInfos[playerid][ORM_ID]);	
	}
	orm_destroy(pInfos[playerid][ORM_ID]);

	return 1;
}