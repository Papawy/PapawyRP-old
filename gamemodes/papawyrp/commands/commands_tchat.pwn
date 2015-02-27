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

stock SendProxPlayerText(playerid, text[])
{
	new Float:pos[3];
	GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
	new Float:dist;
	print("test 1");
	foreach(new i : Player)
	{
		print("test 2");
		dist = GetPlayerDistanceFromPoint(i, pos[0], pos[1], pos[2]);
		if(dist <= PROX_TCHAT_RADIUS_5)
		{
			SendClientMessageEx(i, PROX_TCHAT_COLOR_5, PROX_TCHAT_FORMAT, GetPlayerNameEx(playerid), text);
			print("test 3");
		}
		else if(dist <= PROX_TCHAT_RADIUS_4)
		{
			SendClientMessageEx(i, PROX_TCHAT_COLOR_4, PROX_TCHAT_FORMAT, GetPlayerNameEx(playerid), text);
		}
		else if(dist <= PROX_TCHAT_RADIUS_3)
		{
			SendClientMessageEx(i, PROX_TCHAT_COLOR_3, PROX_TCHAT_FORMAT, GetPlayerNameEx(playerid), text);
		}
		else if(dist <= PROX_TCHAT_RADIUS_2)
		{
			SendClientMessageEx(i, PROX_TCHAT_COLOR_2, PROX_TCHAT_FORMAT, GetPlayerNameEx(playerid), text);
		}
		else if(dist <= PROX_TCHAT_RADIUS_1)
		{
			SendClientMessageEx(i, PROX_TCHAT_COLOR_1, PROX_TCHAT_FORMAT, GetPlayerNameEx(playerid), text);
		}
	}
	return true;
}

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
			SendPlayerAction(playerid, params);
		}
	}
	return 1;
}

stock SendPlayerAction(playerid, action[])
{
	new Float:pos[3];
	GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
	foreach(new i : Player)
	{
		if(IsPlayerInRangeOfPoint(i, CMD_ACTION_RADIUS, pos[0], pos[1], pos[2]))
		{
			SendClientMessageEx(i, CMD_ACTION_COLOR, "* %s %s", GetPlayerNameEx(playerid), action);
		}
	}
	return true;
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


stock SendPlayerDescription(playerid, description[])
{
	new Float:pos[3];
	GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
	foreach(new i : Player)
	{
		if(IsPlayerInRangeOfPoint(i, CMD_ACTION_RADIUS, pos[0], pos[1], pos[2]))
		{
			SendClientMessageEx(i, CMD_ACTION_COLOR, "* %s (%s)", description, GetPlayerNameEx(playerid));
		}
	}
	return true;
}