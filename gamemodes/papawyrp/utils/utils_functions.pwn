#if !defined UTILS_FUNCTIONS_INCLUDED
	#define UTILS_FUNCTIONS_INCLUDED
#endif

// ----------------------------------------------------------------------------

#include <YSI4\Coding\y_va>

// ----------------------------------------------------------------------------

stock GetPlayerNameEx(playerid)
{
	new pName[MAX_PLAYER_NAME+1];
	GetPlayerName(playerid, pName, MAX_PLAYER_NAME+1);
	return pName;
}

stock SendClientMessageEx(playerid, colour, format[], va_args<>)
{
    new
        out[145]
    ;
    va_format(out, sizeof(out), format, va_start<3>);
    SendClientMessage(playerid, colour, out);
}

stock SendClientMessageToAllEx(colour, format[], va_args<>)
{
    new
        out[145]
    ;
    va_format(out, sizeof(out), format, va_start<2>);
    SendClientMessageToAll(colour, out);
}
