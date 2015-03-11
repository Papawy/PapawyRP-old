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
	SetTimerEx("CheckRegister", 1000, false, "d", playerid); // Why a timer ? Because the SQL query take time, and IsPlayerRegistered always return false if we don't let the SQL query make the job.
	return 1;
}

forward CheckRegister(playerid);
public CheckRegister(playerid)
{
	if(!IsPlayerRegistered(playerid))
	{
		RegisterPlayer(playerid);
		return 1;
	}
	return 0;
}