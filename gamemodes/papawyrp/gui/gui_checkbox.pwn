#if !defined GUI_CHECKBOX_INCLUDED
	#define GUI_CHECKBOX_INCLUDED
#endif

// ----------------------------------------------------------------------------

#include "...\core.pwn"

// ----------------------------------------------------------------------------

#include <YSI4\YSI_Coding\y_hooks>

// ----------------------------------------------------------------------------

#define MAX_CHECKBOX 					50

// ----------------------------------------------------------------------------

// Try to implement Iterator with y_iterate, later...
enum CHECKBOX_INFOS {
	PlayerText:checkBoxText,
	checkBoxTextStr[VERY_SHORT_STR],
	PlayerText:checkBox,
	Float:bHeight,
	Float:globalX,
	Float:globalY,
	bool:checked
}

new playerCheckBox[MAX_PLAYERS][MAX_CHECKBOX][CHECKBOX_INFOS];

// ----------------------------------------------------------------------------

hook OnGameModeInit()
{
	for(new p=0; p<MAX_PLAYERS; p++)
	{
		for(new i=0; i<MAX_CHECKBOX; ++i)
		{
			playerCheckBox[p][i][checkBoxText] = INVALID_PLAYER_TEXTDRAW;
			playerCheckBox[p][i][checkBox] = INVALID_PLAYER_TEXTDRAW;
			playerCheckBox[p][i][checked] = false;
		}
	}
	return 1;
}

// ----------------------------------------------------------------------------

hook OnPlayerClickPlayerTD(playerid, PlayerText:playertextid)
{
	if(playertextid != INVALID_PLAYER_TEXTDRAW)
	{
		for(new i=0; i<MAX_CHECKBOX; ++i)
		{
			if(playerCheckBox[playerid][i][checkBox] == playertextid)
			{
				if(playerCheckBox[playerid][i][checked] == false)
				{
					PlayerTextDrawHide(playerid, playerCheckBox[playerid][i][checkBox]);
					PlayerTextDrawSetString(playerid, playerCheckBox[playerid][i][checkBox], "X");
					PlayerTextDrawShow(playerid, playerCheckBox[playerid][i][checkBox]);

					playerCheckBox[playerid][i][checked] = true;
				}
				else
				{
					PlayerTextDrawHide(playerid, playerCheckBox[playerid][i][checkBox]);
					PlayerTextDrawSetString(playerid, playerCheckBox[playerid][i][checkBox], " ~n~");
					PlayerTextDrawShow(playerid, playerCheckBox[playerid][i][checkBox]);

					playerCheckBox[playerid][i][checked] = false;
				}
				CallRemoteFunction("OnPlayerClickCheckBox", "ddd", playerid, i, playerCheckBox[playerid][i][checked]);
				return 1;
			}
		}
	}
	return 0;
}

// OnPlayerClickCheckBox(playerid, checkBoxID, bool:checkedStatus)
/*
hook OnPlayerClickCheckBox(playerid, checkBoxID, bool:checkedStatus)
{

}
*/
// ----------------------------------------------------------------------------

stock IsCheckBoxChecked(playerid, checkBoxID)
{
	return playerCheckBox[playerid][checkBoxID][checked];
}

stock SetCheckBoxStatus(playerid, checkBoxID, bool:checkStatus)
{
	if(checkStatus)
	{
		PlayerTextDrawHide(playerid, playerCheckBox[playerid][checkBoxID][checkBox]);
		PlayerTextDrawSetString(playerid, playerCheckBox[playerid][checkBoxID][checkBox], "X");
		PlayerTextDrawShow(playerid, playerCheckBox[playerid][checkBoxID][checkBox]);

		playerCheckBox[playerid][checkBoxID][checked] = true;
		return 1;
	}
	else
	{
		PlayerTextDrawHide(playerid, playerCheckBox[playerid][checkBoxID][checkBox]);
		PlayerTextDrawSetString(playerid, playerCheckBox[playerid][checkBoxID][checkBox], " ~n~");
		PlayerTextDrawShow(playerid, playerCheckBox[playerid][checkBoxID][checkBox]);

		playerCheckBox[playerid][checkBoxID][checked] = false;
		return 1;
	}
}

// ----------------------------------------------------------------------------

stock ShowPlayerCheckBox(playerid, boxID)
{
	PlayerTextDrawShow(playerid, playerCheckBox[playerid][boxID][checkBoxText]);
	PlayerTextDrawShow(playerid, playerCheckBox[playerid][boxID][checkBox]);
	return 1;
}

stock HidePlayerCheckBox(playerid, boxID)
{
	PlayerTextDrawHide(playerid, playerCheckBox[playerid][boxID][checkBoxText]);
	PlayerTextDrawHide(playerid, playerCheckBox[playerid][boxID][checkBox]);
	return 1;
}

stock UpdateCheckBoxText(playerid, boxID, text[])
{
	PlayerTextDrawHide(playerid, playerCheckBox[playerid][boxID][checkBoxText]);
	PlayerTextDrawSetString(playerid, playerCheckBox[playerid][boxID][checkBoxText], text);
	PlayerTextDrawShow(playerid, playerCheckBox[playerid][boxID][checkBoxText]);
	return 1;
}

// ----------------------------------------------------------------------------

// IN CONSTRUCTION

stock CreatePlayerCheckBox(playerid, Float:x, Float:y, text[], textColor=0xFFFFFFFF, boxColor=0x88888860, bool:checkedStatus=false)
{
	new id = GetAvailablePlayerCheckBoxID(playerid);
	if(id == -1)
	{
		return INVALID_TEXT_DRAW;
	}

	playerCheckBox[playerid][id][bHeight] = 2.2*(1/0.135); // Cf: samp wiki : text draw coords to letter size = Y*0.135, so inverse is letterSize*(1/0.135)

	playerCheckBox[playerid][id][globalX] = x;
	playerCheckBox[playerid][id][globalY] = y;

	if(checkedStatus)
		playerCheckBox[playerid][id][checkBox] = CreatePlayerTextDraw(playerid, x, y, "X");
	else
		playerCheckBox[playerid][id][checkBox] = CreatePlayerTextDraw(playerid, x, y, " ~n~");
	
	PlayerTextDrawLetterSize(playerid, playerCheckBox[playerid][id][checkBox], 0.563665, 2.2);
	PlayerTextDrawTextSize(playerid, playerCheckBox[playerid][id][checkBox], x+15, playerCheckBox[playerid][id][bHeight]);
	PlayerTextDrawAlignment(playerid, playerCheckBox[playerid][id][checkBox], 1);
	PlayerTextDrawColor(playerid, playerCheckBox[playerid][id][checkBox], -1);
	PlayerTextDrawSetShadow(playerid, playerCheckBox[playerid][id][checkBox], 0);
	PlayerTextDrawSetOutline(playerid, playerCheckBox[playerid][id][checkBox], 1);
	PlayerTextDrawUseBox(playerid, playerCheckBox[playerid][id][checkBox], true);
	PlayerTextDrawBoxColor(playerid, playerCheckBox[playerid][id][checkBox], boxColor);
	PlayerTextDrawBackgroundColor(playerid, playerCheckBox[playerid][id][checkBox], 255);
	PlayerTextDrawFont(playerid, playerCheckBox[playerid][id][checkBox], 1);
	PlayerTextDrawSetProportional(playerid, playerCheckBox[playerid][id][checkBox], 1);
	PlayerTextDrawSetSelectable(playerid, playerCheckBox[playerid][id][checkBox], true);

	strins(playerCheckBox[playerid][id][checkBoxTextStr], text, 0, VERY_SHORT_STR);
	playerCheckBox[playerid][id][checkBoxText] = CreatePlayerTextDraw(playerid, x+15, y+3, text);
	PlayerTextDrawLetterSize(playerid, playerCheckBox[playerid][id][checkBoxText], 0.5, 1.6);
	PlayerTextDrawAlignment(playerid, playerCheckBox[playerid][id][checkBoxText], 1);
	PlayerTextDrawColor(playerid, playerCheckBox[playerid][id][checkBoxText], textColor);
	PlayerTextDrawSetShadow(playerid, playerCheckBox[playerid][id][checkBoxText], 0);
	PlayerTextDrawSetOutline(playerid, playerCheckBox[playerid][id][checkBoxText], 1);
	PlayerTextDrawBackgroundColor(playerid, playerCheckBox[playerid][id][checkBoxText], 51);
	PlayerTextDrawFont(playerid, playerCheckBox[playerid][id][checkBoxText], 1);
	PlayerTextDrawSetProportional(playerid, playerCheckBox[playerid][id][checkBoxText], 1);


	return id;
}

stock DestroyPlayerCheckBox(playerid, boxID)
{
	if(IsPlayerCheckBoxCreated(playerid, boxID))
	{
		PlayerTextDrawDestroy(playerid, playerCheckBox[playerid][boxID][checkBoxText]);
		playerCheckBox[playerid][boxID][checkBoxText] = INVALID_PLAYER_TEXTDRAW;

		PlayerTextDrawDestroy(playerid, playerCheckBox[playerid][boxID][checkBox]);
		playerCheckBox[playerid][boxID][checkBox] = INVALID_PLAYER_TEXTDRAW;

		strdel(playerCheckBox[playerid][boxID][checkBoxTextStr], 0, VERY_SHORT_STR);
		return true;
	}
	return false;
}

// ----------------------------------------------------------------------------

stock Float:GetCheckBoxGlobalPosX(playerid, checkBoxID)
{
	return playerCheckBox[playerid][checkBoxID][globalX];
}

stock Float:GetCheckBoxGlobalPosY(playerid, checkBoxID)
{
	return playerCheckBox[playerid][checkBoxID][globalY];
}

stock Float:GetCheckBoxGlobalHeight(playerid, checkBoxID)
{
	return playerCheckBox[playerid][checkBoxID][globalY]+playerCheckBox[playerid][checkBoxID][bHeight];
}

// ----------------------------------------------------------------------------

stock Float:GetCheckBoxHeight(playerid, checkBoxID)
{
	return playerCheckBox[playerid][checkBoxID][bHeight];
}

// ----------------------------------------------------------------------------

stock GetCheckBoxStatus(playerid, checkBoxID)
{
	return playerCheckBox[playerid][i][checked];
}

// ----------------------------------------------------------------------------

stock GetAvailablePlayerCheckBoxID(playerid)
{
	for(new i=0; i<MAX_CHECKBOX; ++i)
	{
		if(!IsPlayerCheckBoxCreated(playerid, i))
			return i;
	}
	return -1;
}

stock IsPlayerCheckBoxCreated(playerid, checkBoxID)
{
	if(playerCheckBox[playerid][checkBoxID][checkBox] == INVALID_PLAYER_TEXTDRAW)
		return false;
	else
		return true;
}

stock IsValidPlayerCheckBox(playerid, checkBoxID)
{
	return IsPlayerCheckBoxCreated(playerid, checkBoxID);
}