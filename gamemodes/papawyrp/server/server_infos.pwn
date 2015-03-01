#if !defined SERVER_INFOS_INCLUDED
	#define SERVER_INFOS_INCLUDED
#endif

// ----------------------------------------------------------------------------

#include <YSI4\YSI_Coding\y_hooks>

// ----------------------------------------------------------------------------

new pConnected;

// ----------------------------------------------------------------------------

hook OnGameModeInit()
{
	pConnected = 0;
	return 1;
}

hook OnPlayerConnect(playerid)
{
	if(!IsPlayerNPC(playerid))
	{
		pConnected++;
	}

	return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
	if(!IsPlayerNPC(playerid))
	{
		pConnected--;
	}
	return 1;
}

// ----------------------------------------------------------------------------

stock GetPlayersConnected()
{
	return pConnected;
}