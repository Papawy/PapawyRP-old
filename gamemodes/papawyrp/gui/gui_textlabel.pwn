#if !defined GUI_TEXTLABEL_INCLUDED
	#define GUI_TEXTLABEL_INCLUDED
#endif

// ----------------------------------------------------------------------------

#include "core.pwn"

// ----------------------------------------------------------------------------

#include <YSI4\YSI_Coding\y_hooks>

// ----------------------------------------------------------------------------

#define MAX_TEXTLABELS 					100

// ----------------------------------------------------------------------------

// Try to implement Iterator with y_iterate, later...
enum TEXTLABEL_INFOS {
	PlayerText:textLabel,
	Float:tlHeight,
	Float:globalX,
	Float:globalY
}

new playerTextLabel[MAX_PLAYERS][MAX_TEXTLABELS][TEXTLABEL_INFOS];

// ----------------------------------------------------------------------------

hook OnGameModeInit()
{
	for(new p=0; p<MAX_PLAYERS; p++)
	{
		for(new i=0; i<MAX_TEXTLABELS; ++i)
		{
			playerTextLabel[p][i][textLabel] = INVALID_PLAYER_TEXTDRAW;
		}
	}
	return 1;
}

// ----------------------------------------------------------------------------

stock ShowPlayerTextLabel(playerid, textLabelID)
{
	PlayerTextDrawShow(playerid, playerTextLabel[playerid][textLabelID][textLabel]);
	return 1;
}

stock HidePlayerTextLabel(playerid, textLabelID)
{
	PlayerTextDrawHide(playerid, playerTextLabel[playerid][textLabelID][textLabel]);
	return 1;
}

// ----------------------------------------------------------------------------

stock CreatePlayerTextLabel(playerid, Float:x, Float:y, text[], Float:letterSizeX = 0.4, Float:letterSizeY = 2.0, textLabelColor=0xFFFFFFFF)
{
	new id = GetAvailablePlayerTextLabelID(playerid);
	if(id == -1)
	{
		return INVALID_TEXT_DRAW;
	}

	playerTextLabel[playerid][id][globalX] = x;
	playerTextLabel[playerid][id][globalY] = y;

	playerTextLabel[playerid][id][textLabel] = CreatePlayerTextDraw(playerid, x, y, text);
	PlayerTextDrawLetterSize(playerid, playerTextLabel[playerid][id][textLabel], letterSizeX, letterSizeY);
	PlayerTextDrawAlignment(playerid, playerTextLabel[playerid][id][textLabel], 1);
	PlayerTextDrawColor(playerid, playerTextLabel[playerid][id][textLabel], textLabelColor);
	PlayerTextDrawSetShadow(playerid, playerTextLabel[playerid][id][textLabel], 0);
	PlayerTextDrawSetOutline(playerid, playerTextLabel[playerid][id][textLabel], 1);
	PlayerTextDrawFont(playerid, playerTextLabel[playerid][id][textLabel], 1);
	PlayerTextDrawSetProportional(playerid, playerTextLabel[playerid][id][textLabel], 1);

	return id;
}

stock DestroyPlayerTextLabel(playerid, textLabelID)
{
	if(IsPlayerTextLabelCreated(playerid, textLabelID))
	{
		PlayerTextDrawDestroy(playerid, playerTextLabel[playerid][textLabelID][textLabel]);
		playerTextLabel[playerid][textLabelID][textLabel] = INVALID_PLAYER_TEXTDRAW;
		return true;
	}
	return false;
}

// ----------------------------------------------------------------------------

stock Float:GetTextLabelGlobalPosX(playerid, textLabelID)
{
	return playerTextLabel[playerid][textLabelID][globalX];
}

stock Float:GetTextLabelGlobalPosY(playerid, textLabelID)
{
	return playerTextLabel[playerid][textLabelID][globalY];
}

// ----------------------------------------------------------------------------

stock Float:GetTextLabelHeight(playerid, textLabelID)
{
	return playerTextLabel[playerid][textLabelID][tlHeight];
}

// ----------------------------------------------------------------------------

stock GetAvailablePlayerTextLabelID(playerid)
{
	for(new i=0; i<MAX_TEXTLABELS; ++i)
	{
		if(!IsValidPlayerTextLabel(playerid, i))
			return i;
	}
	return -1;
}

stock IsPlayerTextLabelCreated(playerid, textLabelID)
{
	if(playerTextLabel[playerid][textLabelID][textLabel] == INVALID_PLAYER_TEXTDRAW)
		return false;
	else
		return true;
}

stock IsValidPlayerTextLabel(playerid, textLabelID)
{
	return IsPlayerTextLabelCreated(playerid, textLabelID);
}