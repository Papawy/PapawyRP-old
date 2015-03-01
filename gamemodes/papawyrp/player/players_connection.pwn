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
	if(!IsPlayerRegistered(playerid))
	{
		RegisterPlayer(playerid);
		return 1;
	}
	return 1;
}