#if !defined COMMANDS_GENERALS_INCLUDED
	#define COMMANDS_GENERALS_INCLUDED
#endif

// ----------------------------------------------------------------------------

#include <YSI4\YSI_Coding\y_hooks>

// ----------------------------------------------------------------------------

#include "core.pwn"

// ----------------------------------------------------------------------------

hook OnGameModeInit()
{
	Command_AddAltNamed("help", "aide");
	return 1;
}

hook OnPlayerConnect(playerid)
{
	Command_SetPlayerNamed("help", playerid, false);
	Command_SetPlayerNamed("aide", playerid, true);

	return 1;
}

// ----------------------------------------------------------------------------

YCMD:help(playerid, params[], help)
{
	if(help)
	{
		SendClientMessage(playerid, -1, HELP_HEADER"Affiche l'aide relative à une commande.");
	}
	else
	{
		if (isnull(params))
        {
            new
                str[NORMAL_STR];
            SendClientMessage(playerid, COLOR_HELP, "|-----------------------------------------------------------------------------------------------|");
            SendClientMessage(playerid, -1, HELP_HEADER "Bienvenue dans l'aide !");
            format(str, sizeof (str), HELP_HEADER "Tapez \"/%s [commande]\" pour avoir plus d'aide par rapport à cette commande !", Command_GetDisplayNamed("aide", playerid));
            SendClientMessage(playerid, -1, str);
            SendClientMessageEx(playerid, -1, HELP_HEADER "Tapez \"/%s [commande]\" pour avoir plus d'aide par rapport à cette commande !", Command_GetDisplayNamed("aide", playerid));
			SendClientMessage(playerid, -1, HELP_HEADER "Tapez \"/aide commandes\" pour avoir le nom de toute les commandes !");
			SendClientMessage(playerid, COLOR_HELP, "|-----------------------------------------------------------------------------------------------|");
        }
        else if(strcmp(params, "commandes", true) == 0)
        {
            new count = Command_GetPlayerCommandCount(playerid);
            SendClientMessage(playerid, COLOR_HELP, "|-----------------------------------------------------------------------------------------------|");
            SendClientMessage(playerid, -1, HELP_HEADER "Liste de toutes les commandes du serveur :");
            new o = 0;
            new tmpMsg[NORMAL_STR];
	        for (new i = 0; i != count; ++i)
	        {
		            if(o == 0)
					{
		            	strcat(tmpMsg, HELP_HEADER );
					}
		            strcat(tmpMsg, " - /"); strcat(tmpMsg, Command_GetNext(i, playerid));
		            o ++;
		            if(o == 7)
		            {
		            	SendClientMessage(playerid, COLOR_HELP, tmpMsg);
		            	strdel(tmpMsg, 0, sizeof(tmpMsg));
						o = 0;
					}
	        }
	        if(o != 7 && o != 0)
	        {
	        	SendClientMessage(playerid, COLOR_HELP, tmpMsg);
	        }

	        SendClientMessage(playerid, COLOR_HELP, "|-----------------------------------------------------------------------------------------------|");
		}
        else
        {
            Command_ReProcess(playerid, params, true);
        }
	}
	return 1;
}