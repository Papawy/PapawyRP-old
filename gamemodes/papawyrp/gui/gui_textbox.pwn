#if !defined GUI_TEXTBOX_INCLUDED
	#define GUI_TEXTBOX_INCLUDED
#endif

// ----------------------------------------------------------------------------

#include "core.pwn"

// ----------------------------------------------------------------------------

#include <YSI4\YSI_Coding\y_hooks>

// ----------------------------------------------------------------------------

#define MAX_TEXTBOX 					100

// ----------------------------------------------------------------------------

// Try to implement Iterator with y_iterate, later...
enum TEXTBOX_INFOS {
	PlayerText:textbox,
	Float:tbWidth,
	Float:globalX,
	Float:globalY
}

new playerTextbox[MAX_PLAYERS][MAX_TEXTBOX][TEXTBOX_INFOS];

// ----------------------------------------------------------------------------

hook OnGameModeInit()
{
	for(new p=0; p<MAX_PLAYERS; p++)
	{
		for(new i=0; i<MAX_TEXTBOX; ++i)
		{
			playerTextbox[p][i][textbox] = PlayerText:INVALID_TEXT_DRAW;
		}
	}
	return 1;
}

// ----------------------------------------------------------------------------

stock ShowPlayerTextbox(playerid, textboxID)
{
	PlayerTextDrawShow(playerid, playerTextbox[playerid][textboxID][textbox]);
	return 1;
}

stock HidePlayerTextbox(playerid, textboxID)
{
	PlayerTextDrawHide(playerid, playerTextbox[playerid][textboxID][textbox]);
	return 1;
}

stock DestroyPlayerTextbox(playerid, textboxID)
{
	PlayerTextDrawDestroy(playerid, playerTextbox[playerid][textboxID][textbox]);
	return 1;
}

// ----------------------------------------------------------------------------

stock ChangeTextboxString(playerid, textboxID, text[])
{
	HidePlayerTextbox(playerid, textboxID);
	PlayerTextDrawSetString(playerid, playerTextbox[playerid][textboxID][textbox], text);
	ShowPlayerTextbox(playerid, textboxID);
}

stock ChangeTextboxColor(playerid, textboxID, color)
{
	HidePlayerTextbox(playerid, textboxID);
	PlayerTextDrawColor(playerid, playerTextbox[playerid][textboxID][textbox], color);
	ShowPlayerTextbox(playerid, textboxID);
}

// ----------------------------------------------------------------------------

stock CreatePlayerTextbox(playerid, Float:x, Float:y, text[], TextboxColor=0x20202030, textColor=0xFFFFFFFF, font=1, width=170)
{
	new id = GetAvailablePlayerTextboxID(playerid);
	if(id == -1)
	{
		return INVALID_TEXT_DRAW;
	}

	playerTextbox[playerid][id][globalX] = x;
	playerTextbox[playerid][id][globalY] = y;

	playerTextbox[playerid][id][tbWidth] = width;

	playerTextbox[playerid][id][textbox] = CreatePlayerTextDraw(playerid, x, y, text);
	PlayerTextDrawLetterSize(playerid, playerTextbox[playerid][id][textbox], 0.34, 1.39);
	PlayerTextDrawTextSize(playerid, playerTextbox[playerid][id][textbox], 0, width);
	PlayerTextDrawAlignment(playerid, playerTextbox[playerid][id][textbox], 2);
	PlayerTextDrawColor(playerid, playerTextbox[playerid][id][textbox], textColor);
	PlayerTextDrawUseBox(playerid, playerTextbox[playerid][id][textbox], true);
	PlayerTextDrawBoxColor(playerid, playerTextbox[playerid][id][textbox], TextboxColor);
	PlayerTextDrawSetShadow(playerid, playerTextbox[playerid][id][textbox], 0);
	PlayerTextDrawSetOutline(playerid, playerTextbox[playerid][id][textbox], 0);
	PlayerTextDrawFont(playerid, playerTextbox[playerid][id][textbox], font);
	PlayerTextDrawSetProportional(playerid, playerTextbox[playerid][id][textbox], 1);
	return id;
}

// ----------------------------------------------------------------------------

stock Float:GetTextboxGlobalPosX(playerid, textboxID)
{
	return playerTextbox[playerid][textboxID][globalX];
}

stock Float:GetTextboxGlobalPosY(playerid, textboxID)
{
	return playerTextbox[playerid][textboxID][globalY];
}

// ----------------------------------------------------------------------------

stock Float:GetTextboxWidth(playerid, textboxID)
{
	return playerTextbox[playerid][textboxID][tbWidth];
}

// ----------------------------------------------------------------------------

stock GetAvailablePlayerTextboxID(playerid)
{
	for(new i=0; i<MAX_TEXTBOX; ++i)
	{
		if(!IsValidPlayerTextbox(playerid, i))
			return i;
	}
	return -1;
}

stock IsPlayerTextboxCreated(playerid, textboxID)
{
	if(playerTextbox[playerid][textboxID][textbox] == PlayerText:INVALID_TEXT_DRAW)
		return false;
	else
		return true;
}

stock IsValidPlayerTextbox(playerid, textboxID)
{
	return IsPlayerTextboxCreated(playerid, textboxID);
}