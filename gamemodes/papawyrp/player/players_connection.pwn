#if !defined PLAYERS_CONNECTION_INCLUDED
	#define PLAYERS_CONNECTION_INCLUDED
#endif

// ----------------------------------------------------------------------------

#include <YSI4\YSI_Coding\y_hooks>

// ----------------------------------------------------------------------------

#include "core.pwn"

// ----------------------------------------------------------------------------

hook OnPlayerConnect(playerid)
{
	GetPlayerName(playerid, pInfos[playerid][pName], MAX_PLAYER_NAME+1);
	LoadPlayerData(playerid, 1);
	if(!IsPlayerRegistered(playerid))
	{
		RegisterPlayer(playerid);
		return 1;
	}
	return 1;
}