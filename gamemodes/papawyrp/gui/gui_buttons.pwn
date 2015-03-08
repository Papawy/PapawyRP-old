#if !defined GUI_BUTTONS_INCLUDED
	#define GUI_BUTTONS_INCLUDED
#endif

// ----------------------------------------------------------------------------

#include "core.pwn"

// ----------------------------------------------------------------------------

#include <YSI4\YSI_Coding\y_hooks>

// ----------------------------------------------------------------------------

#define MAX_BUTTONS 					150

// ----------------------------------------------------------------------------

// Try to implement Iterator with y_iterate, later...
enum BUTTON_INFOS {
	PlayerText:button
}

new playerButtons[MAX_PLAYERS][MAX_BUTTONS][BUTTON_INFOS];

// ----------------------------------------------------------------------------

hook OnGameModeInit()
{
	for(new p=0; p<MAX_PLAYERS; p++)
	{
		for(new i=0; i<MAX_BUTTONS; ++i)
		{
			playerButtons[p][i][button] = PlayerText:INVALID_TEXT_DRAW;
		}
	}
	return 1;
}

// ----------------------------------------------------------------------------

hook OnPlayerClickPlayerTD(playerid, PlayerText:playertextid)
{
	if(playertextid != PlayerText:INVALID_TEXT_DRAW)
	{
		for(new i=0; i<MAX_BUTTONS; ++i)
		{
			if(playerButtons[playerid][i][button] == playertextid)
			{
				CallRemoteFunction("OnPlayerClickButton", "dd", playerid, i);
				return 1;
			}
		}
	}
	return 0;
}

// ----------------------------------------------------------------------------

stock ShowPlayerButton(playerid, buttonID)
{
	PlayerTextDrawShow(playerid, playerButtons[playerid][buttonID][button]);
	return 1;
}

stock HidePlayerButton(playerid, buttonID)
{
	PlayerTextDrawHide(playerid, playerButtons[playerid][buttonID][button]);
	return 1;
}

stock UpdateButtonName(playerid, buttonID, name[])
{
	PlayerTextDrawHide(playerid, playerButtons[playerid][buttonID][button]);
	PlayerTextDrawSetString(playerid, playerButtons[playerid][buttonID][button], name);
	PlayerTextDrawShow(playerid, playerButtons[playerid][buttonID][button]);
	return 1;
}

// ----------------------------------------------------------------------------

stock CreatePlayerButton(playerid, Float:x, Float:y, text[], textColor=0xFFFFFFFF, boxColor=0x88888860)
{
	new id = GetAvailablePlayerButtonID(playerid);
	if(id == -1)
	{
		return INVALID_TEXT_DRAW;
	}

	playerButtons[playerid][id][button] = CreatePlayerTextDraw(playerid, x, y, text);
	PlayerTextDrawLetterSize(playerid, playerButtons[playerid][id][button], 0.37, 2.2);
	PlayerTextDrawTextSize(playerid, playerButtons[playerid][id][button], 19, 110);
	PlayerTextDrawAlignment(playerid, playerButtons[playerid][id][button], 2);
	PlayerTextDrawColor(playerid, playerButtons[playerid][id][button], textColor);
	PlayerTextDrawUseBox(playerid, playerButtons[playerid][id][button], true);
	PlayerTextDrawBoxColor(playerid, playerButtons[playerid][id][button], boxColor);
	PlayerTextDrawSetShadow(playerid, playerButtons[playerid][id][button], 0);
	PlayerTextDrawSetOutline(playerid, playerButtons[playerid][id][button], 0);
	PlayerTextDrawBackgroundColor(playerid, playerButtons[playerid][id][button], 51);
	PlayerTextDrawFont(playerid, playerButtons[playerid][id][button], 1);
	PlayerTextDrawSetProportional(playerid, playerButtons[playerid][id][button], 1);
	PlayerTextDrawSetSelectable(playerid, playerButtons[playerid][id][button], true);

	return id;
}

stock DestroyPlayerButton(playerid, buttonID)
{
	if(IsPlayerButtonCreated(buttonID))
	{
		PlayerTextDrawDestroy(playerid, playerButtons[buttonID][button]);
		playerButtons[playerid][buttonID][button] = INVALID_TEXT_DRAW;
		return true;
	}
	return false;
}

// ----------------------------------------------------------------------------

stock GetAvailablePlayerButtonID(playerid)
{
	for(new i=0; i<MAX_BUTTONS; ++i)
	{
		if(!IsValidPlayerButton(playerid, i))
			return i;
	}
	return -1;
}

stock IsPlayerButtonCreated(playerid, buttonID)
{
	if(playerButtons[playerid][buttonID][button] == PlayerText:INVALID_TEXT_DRAW)
		return false;
	else
		return true;
}

stock IsValidPlayerButton(playerid, buttonID)
{
	return IsPlayerButtonCreated(playerid, buttonID);
}