#if !defined UTILS_FUNCTIONS_INCLUDED
	#define UTILS_FUNCTIONS_INCLUDED
#endif

// ----------------------------------------------------------------------------

stock GetPlayerNameEx(playerid)
{
	new pName[MAX_PLAYER_NAME+1];
	GetPlayerName(playerid, pName, MAX_PLAYER_NAME+1);
	return pName;
}