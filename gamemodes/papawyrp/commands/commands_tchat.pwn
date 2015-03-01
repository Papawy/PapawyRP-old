#if !defined COMMANDS_TCHAT_INCLUDED
	#define COMMANDS_TCHAT_INCLUDED
#endif

// ----------------------------------------------------------------------------

#include <YSI4\YSI_Coding\y_hooks>

// ----------------------------------------------------------------------------

#include "core.pwn"

// ----------------------------------------------------------------------------

hook OnPlayerText(playerid, text[])
{
	SendProxPlayerText(playerid, text);
	return 0;
}


// ----------------------------------------------------------------------------

YCMD:me(playerid, params[], help)
{
	if(help)
	{
		new str[NORMAL_STR];
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
			SendPlayerAction(playerid, params);
		}
	}
	return 1;
}

// ----------------------------------------------------------------------------

YCMD:do(playerid, params[], help)
{
	if(help)
	{
		new str[128];
		format(str, sizeof (str), HELP_HEADER "/%s [description]\" : permet de décrire l'environnement autour du personnage.", Command_GetDisplayNamed("do", playerid));
        SendClientMessage(playerid, -1, str);
	}
	else
	{
		if(isnull(params))
		{
			Command_ReProcess(playerid, "do", true);
		}
		else
		{
			SendPlayerDescription(playerid, params);
		}
	}
	return 1;
}
