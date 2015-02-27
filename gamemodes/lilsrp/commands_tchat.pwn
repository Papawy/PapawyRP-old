#if !defined COMMANDS_TCHAT_INCLUDED
	#define COMMANDS_TCHAT_INCLUDED
#else

// ----------------------------------------------------------------------------

#include <YSI\y_hooks>

// ----------------------------------------------------------------------------

#include "colors.pwn"

// ----------------------------------------------------------------------------

YCMD:me(playerid, params[], help)
{
	if(help)
	{
		format(str, sizeof (str), HELP_HEADER COLOR_HELP_STR"/%s [action]\" : permet de décrire une action dans le tchat.", Command_GetDisplayNamed("me", playerid));
        SendClientMessage(playerid, -1, str);
	}
	else
	{
		if(isnull(params))
		{
			Command_ReProcess(playerid, params, true);
		}
		else
		{
			
		}
	}
}