#if !defined GUI_BACKGROUND_INCLUDED
	#define GUI_BACKGROUND_INCLUDED
#endif

// ----------------------------------------------------------------------------

#include "core.pwn"

// ----------------------------------------------------------------------------

#include <YSI4\YSI_Coding\y_hooks>

// ----------------------------------------------------------------------------

#define MAX_BACKGROUND 					100

// ----------------------------------------------------------------------------

// Try to implement Iterator with y_iterate, later...
enum BACKGROUND_INFOS {
	PlayerText:background,
	Float:bckWidth,
	Float:bckHeight,
	Float:globalX,
	Float:globalY
}

new playerBackground[MAX_PLAYERS][MAX_BACKGROUND][BACKGROUND_INFOS];

// ----------------------------------------------------------------------------

hook OnGameModeInit()
{
	for(new p=0; p<MAX_PLAYERS; p++)
	{
		for(new i=0; i<MAX_BACKGROUND; ++i)
		{
			playerBackground[p][i][background] = INVALID_PLAYER_TEXTDRAW;
		}
	}
	return 1;
}

// ----------------------------------------------------------------------------

stock ShowPlayerBackground(playerid, backgroundID)
{
	PlayerTextDrawShow(playerid, playerBackground[playerid][backgroundID][background]);
	return 1;
}

stock HidePlayerBackground(playerid, backgroundID)
{
	PlayerTextDrawHide(playerid, playerBackground[playerid][backgroundID][background]);
	return 1;
}

// ----------------------------------------------------------------------------

/* relativeMax :
	false : maxx & maxy are fixed positions
	true : maxx & maxy positions depends of x & y
*/

stock CreatePlayerBackground(playerid, Float:x, Float:y, Float:maxx, Float:maxy, backgroundColor=0x20202030, bool:relativeMax=false)
{
	new id = GetAvailablePlayerBackgroundID(playerid);
	if(id == -1)
	{
		return INVALID_TEXT_DRAW;
	}

	playerBackground[playerid][id][globalX] = x;
	playerBackground[playerid][id][globalY] = y;

	playerBackground[playerid][id][background] = CreatePlayerTextDraw(playerid, x, y, "bckgrd");
	if(relativeMax)
	{
		playerBackground[playerid][id][bckWidth] = maxx;
		playerBackground[playerid][id][bckHeight] = maxy;
		PlayerTextDrawTextSize(playerid, playerBackground[playerid][id][background], maxx+x, 0);
		PlayerTextDrawLetterSize(playerid, playerBackground[playerid][id][background], 0, maxy*0.135);
	}
	else
	{
		playerBackground[playerid][id][bckWidth] = maxx;
		playerBackground[playerid][id][bckHeight] = maxy;
		PlayerTextDrawTextSize(playerid, playerBackground[playerid][id][background], maxx, 0);
		PlayerTextDrawLetterSize(playerid, playerBackground[playerid][id][background], 0.000000, (maxy-y)*0.135);
	}

	PlayerTextDrawAlignment(playerid, playerBackground[playerid][id][background], 1);
	PlayerTextDrawColor(playerid, playerBackground[playerid][id][background], 0);
	PlayerTextDrawUseBox(playerid, playerBackground[playerid][id][background], true);
	PlayerTextDrawBoxColor(playerid, playerBackground[playerid][id][background], backgroundColor);
	PlayerTextDrawSetShadow(playerid, playerBackground[playerid][id][background], 0);
	PlayerTextDrawSetOutline(playerid, playerBackground[playerid][id][background], 0);
	PlayerTextDrawFont(playerid, playerBackground[playerid][id][background], 0);

	return id;
}

stock DestroyPlayerBackground(playerid, backgroundID)
{
	if(IsPlayerBackgroundCreated(playerid, backgroundID))
	{
		PlayerTextDrawDestroy(playerid, playerBackground[playerid][backgroundID][background]);
		playerBackground[playerid][backgroundID][background] = INVALID_PLAYER_TEXTDRAW;
		return true;
	}
	return false;
}

// ----------------------------------------------------------------------------

stock Float:GetBackgroundGlobalPosX(playerid, backgroundID)
{
	return playerBackground[playerid][backgroundID][globalX];
}

stock Float:GetBackgroundGlobalPosY(playerid, backgroundID)
{
	return playerBackground[playerid][backgroundID][globalY];
}

// ----------------------------------------------------------------------------

stock Float:GetBackgroundWidth(playerid, backgroundID)
{
	return playerBackground[playerid][backgroundID][bckWidth];
}

stock Float:GetBackgroundHeight(playerid, backgroundID)
{
	return playerBackground[playerid][backgroundID][bckHeight];
}

// ----------------------------------------------------------------------------

stock GetAvailablePlayerBackgroundID(playerid)
{
	for(new i=0; i<MAX_BACKGROUND; ++i)
	{
		if(!IsValidPlayerBackground(playerid, i))
			return i;
	}
	return -1;
}

stock IsPlayerBackgroundCreated(playerid, backgroundID)
{
	if(playerBackground[playerid][backgroundID][background] == INVALID_PLAYER_TEXTDRAW)
		return false;
	else
		return true;
}

stock IsValidPlayerBackground(playerid, backgroundID)
{
	return IsPlayerBackgroundCreated(playerid, backgroundID);
}