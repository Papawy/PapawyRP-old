#if !defined COMMANDS_TCHAT_INCLUDED
	#define COMMANDS_TCHAT_INCLUDED
#endif

// ----------------------------------------------------------------------------

#include "core.pwn"

// ----------------------------------------------------------------------------

YCMD:me(playerid, params[], help)
{
	if(help)
	{
		new str[128];
		format(str, sizeof (str), HELP_HEADER "/%s [action]\" : permet de décrire une action dans le tchat.", Command_GetDisplayNamed("me", playerid));
        SendClientMessage(playerid, -1, str);
	}
	else
	{
		if(isnull(params))
		{
			Command_ReProcess(playerid, "me", true);
		}
		else
		{

		}
	}
	return 1;
}