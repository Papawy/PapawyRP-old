#if !defined GUI_BUTTONS_INCLUDED
	#define GUI_BUTTONS_INCLUDED
#endif

// ----------------------------------------------------------------------------

#include "core.pwn"

// ----------------------------------------------------------------------------

#include <YSI4\YSI_Coding\y_hooks>

// ----------------------------------------------------------------------------

#define MAX_BUTTONS 					150

#define BUTTON_DEFAULT_WIDTH			110.0
#define BUTTON_DEFAULT_HEIGHT			19.0

// ----------------------------------------------------------------------------

// Try to implement Iterator with y_iterate, later...
enum BUTTON_INFOS {
	PlayerText:button,
	Float:bWidth,
	Float:bHeight,
	Float:globalX,
	Float:globalY
}

new playerButtons[MAX_PLAYERS][MAX_BUTTONS][BUTTON_INFOS];

// ----------------------------------------------------------------------------

hook OnGameModeInit()
{
	for(new p=0; p<MAX_PLAYERS; p++)
	{
		for(new i=0; i<MAX_BUTTONS; ++i)
		{
			playerButtons[p][i][button] = INVALID_PLAYER_TEXTDRAW;
		}
	}
	return 1;
}

// ----------------------------------------------------------------------------

hook OnPlayerClickPlayerTD(playerid, PlayerText:playertextid)
{
	if(playertextid != INVALID_PLAYER_TEXTDRAW)
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

// When you use it, do something like that : CreatePlayerButton(playerid, x, y, text, .height=yourHeight) so, you can set params you want !

stock CreatePlayerButton(playerid, Float:x, Float:y, text[], textColor=0xFFFFFFFF, boxColor=0x88888860, Float:width=BUTTON_DEFAULT_WIDTH, Float:height=BUTTON_DEFAULT_HEIGHT, alignment = 2)
{
	new id = GetAvailablePlayerButtonID(playerid);
	if(id == -1)
	{
		return INVALID_TEXT_DRAW;
	}

	playerButtons[playerid][id][globalX] = x;
	playerButtons[playerid][id][globalY] = y;

	playerButtons[playerid][id][bWidth] = width;
	playerButtons[playerid][id][bHeight] = height;

	playerButtons[playerid][id][button] = CreatePlayerTextDraw(playerid, x, y, text);
	PlayerTextDrawLetterSize(playerid, playerButtons[playerid][id][button], 0.37, 2.2);
	switch(alignment)
	{
		case 1:
		{
			PlayerTextDrawTextSize(playerid, playerButtons[playerid][id][button], x+width, height);
		}
		case 2:
		{
			PlayerTextDrawTextSize(playerid, playerButtons[playerid][id][button], height, width);
		}
		case 3:
		{
			PlayerTextDrawTextSize(playerid, playerButtons[playerid][id][button], width, height);
		}
		default:
		{
			PlayerTextDrawTextSize(playerid, playerButtons[playerid][id][button], height, width);
		}
	}
	PlayerTextDrawAlignment(playerid, playerButtons[playerid][id][button], alignment);
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
	if(IsPlayerButtonCreated(playerid, buttonID))
	{
		PlayerTextDrawDestroy(playerid, playerButtons[playerid][buttonID][button]);
		playerButtons[playerid][buttonID][button] = INVALID_PLAYER_TEXTDRAW;
		return true;
	}
	return false;
}

// ----------------------------------------------------------------------------

stock Float:GetButtonGlobalPosX(playerid, buttonID)
{
	return playerButtons[playerid][buttonID][globalX];
}

stock Float:GetButtonGlobalPosY(playerid, buttonID)
{
	return playerButtons[playerid][buttonID][globalY];
}

// ----------------------------------------------------------------------------

stock Float:GetButtonWidth(playerid, buttonID)
{
	return playerButtons[playerid][buttonID][bWidth];
}

stock Float:GetButtonHeight(playerid, buttonID)
{
	return playerButtons[playerid][buttonID][bHeight];
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
	if(playerButtons[playerid][buttonID][button] == INVALID_PLAYER_TEXTDRAW)
		return false;
	else
		return true;
}

stock IsValidPlayerButton(playerid, buttonID)
{
	return IsPlayerButtonCreated(playerid, buttonID);
}