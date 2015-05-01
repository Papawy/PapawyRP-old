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
	PlayerText:checkBoxBckg,
	Float:fWidth,
	Float:fHeight,
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
			playerCheckBox[p][i][checkBoxBckg] = INVALID_PLAYER_TEXTDRAW;
			playerCheckBox[p][i][checked] = false;
		}
	}
	return 1;
}

// ----------------------------------------------------------------------------

stock ShowPlayerCheckBox(playerid, boxID)
{
	PlayerTextDrawShow(playerid, playerCheckBox[playerid][boxID][checkBoxText]);
	PlayerTextDrawShow(playerid, playerCheckBox[playerid][boxID][checkBox]);
	PlayerTextDrawShow(playerid, playerCheckBox[playerid][boxID][checkBoxBckg]);
	return 1;
}

stock HidePlayerCheckBox(playerid, boxID)
{
	PlayerTextDrawHide(playerid, playerCheckBox[playerid][boxID][checkBoxText]);
	PlayerTextDrawHide(playerid, playerCheckBox[playerid][boxID][checkBox]);
	PlayerTextDrawHide(playerid, playerCheckBox[playerid][boxID][checkBoxBckg]);
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

stock CreatePlayerCheckBox(playerid, Float:x, Float:y, name[], color=0xFFFFFFFF, fieldColor=0x88888860, Float:fieldWidth=FIELD_DEFAULT_WIDTH, Float:fieldHeight=FIELD_DEFAULT_HEIGHT)
{
	new id = GetAvailableCheckBoxID(playerid);
	if(id == -1)
	{
		return INVALID_TEXT_DRAW;
	}
	strins(playerCheckBox[playerid][id][fieldNameStr], name, 0, VERY_SHORT_STR);
	playerCheckBox[playerid][id][fieldName] = CreatePlayerTextDraw(playerid, x+7, y, name);
	PlayerTextDrawLetterSize(playerid, playerCheckBox[playerid][id][fieldName], 0.412999, 1.512888);
	PlayerTextDrawAlignment(playerid, playerCheckBox[playerid][id][fieldName], 1);
	PlayerTextDrawColor(playerid, playerCheckBox[playerid][id][fieldName], color);
	PlayerTextDrawSetShadow(playerid, playerCheckBox[playerid][id][fieldName], 0);
	PlayerTextDrawSetOutline(playerid, playerCheckBox[playerid][id][fieldName], 1);
	PlayerTextDrawBackgroundColor(playerid, playerCheckBox[playerid][id][fieldName], 51);
	PlayerTextDrawFont(playerid, playerCheckBox[playerid][id][fieldName], 1);
	PlayerTextDrawSetProportional(playerid, playerCheckBox[playerid][id][fieldName], 1);

	playerCheckBox[playerid][id][globalX] = x;
	playerCheckBox[playerid][id][globalY] = y;

	playerCheckBox[playerid][id][fWidth] = fieldWidth;
	playerCheckBox[playerid][id][fHeight] = fieldHeight;

	playerCheckBox[playerid][id][field] = CreatePlayerTextDraw(playerid, x, y+16, fieldDefaultValue);
	PlayerTextDrawLetterSize(playerid, playerCheckBox[playerid][id][field], 0.29, 1.6);
	PlayerTextDrawAlignment(playerid, playerCheckBox[playerid][id][field], 1);
	PlayerTextDrawTextSize(playerid, playerCheckBox[playerid][id][field], x+playerCheckBox[playerid][id][fWidth], playerCheckBox[playerid][id][fHeight]);
	PlayerTextDrawColor(playerid, playerCheckBox[playerid][id][field], -1);
	PlayerTextDrawUseBox(playerid, playerCheckBox[playerid][id][field], true);
	PlayerTextDrawBoxColor(playerid, playerCheckBox[playerid][id][field], fieldColor);
	PlayerTextDrawSetShadow(playerid, playerCheckBox[playerid][id][field], 0);
	PlayerTextDrawSetOutline(playerid, playerCheckBox[playerid][id][field], 1);
	PlayerTextDrawBackgroundColor(playerid, playerCheckBox[playerid][id][field], 255);
	PlayerTextDrawFont(playerid, playerCheckBox[playerid][id][field], 1);
	PlayerTextDrawSetProportional(playerid, playerCheckBox[playerid][id][field], 1);
	PlayerTextDrawSetSelectable(playerid, playerCheckBox[playerid][id][field], true);

	Textdraw0[playerid] = CreatePlayerTextDraw(playerid, 183.333343, 276.937133, "usebox");
	PlayerTextDrawLetterSize(playerid, Textdraw0[playerid], 0.000000, 1.955760);
	PlayerTextDrawTextSize(playerid, Textdraw0[playerid], 161.666625, 0.000000);
	PlayerTextDrawAlignment(playerid, Textdraw0[playerid], 1);
	PlayerTextDrawColor(playerid, Textdraw0[playerid], 0);
	PlayerTextDrawUseBox(playerid, Textdraw0[playerid], true);
	PlayerTextDrawBoxColor(playerid, Textdraw0[playerid], -1717986817);
	PlayerTextDrawSetShadow(playerid, Textdraw0[playerid], 0);
	PlayerTextDrawSetOutline(playerid, Textdraw0[playerid], 0);
	PlayerTextDrawFont(playerid, Textdraw0[playerid], 0);

	Textdraw1[playerid] = CreatePlayerTextDraw(playerid, 172.666671, 277.925933, "X");
	PlayerTextDrawLetterSize(playerid, Textdraw1[playerid], 0.420666, 1.691259);
	PlayerTextDrawTextSize(playerid, Textdraw1[playerid], 137.000000, 12.859267);
	PlayerTextDrawAlignment(playerid, Textdraw1[playerid], 2);
	PlayerTextDrawColor(playerid, Textdraw1[playerid], -1);
	PlayerTextDrawUseBox(playerid, Textdraw1[playerid], true);
	PlayerTextDrawBoxColor(playerid, Textdraw1[playerid], 255);
	PlayerTextDrawSetShadow(playerid, Textdraw1[playerid], 0);
	PlayerTextDrawSetOutline(playerid, Textdraw1[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, Textdraw1[playerid], 255);
	PlayerTextDrawFont(playerid, Textdraw1[playerid], 1);
	PlayerTextDrawSetProportional(playerid, Textdraw1[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, Textdraw1[playerid], true);

	strins(playerCheckBox[playerid][id][checkBoxTextStr], name, 0, VERY_SHORT_STR);
	playerCheckBox[playerid][id][checkBoxText] = CreatePlayerTextDraw(playerid, 185.666732, 277.925933, "New Textdraw");
	PlayerTextDrawLetterSize(playerid, Textdraw2[playerid], 0.449999, 1.600000);
	PlayerTextDrawAlignment(playerid, Textdraw2[playerid], 1);
	PlayerTextDrawColor(playerid, Textdraw2[playerid], -1);
	PlayerTextDrawSetShadow(playerid, Textdraw2[playerid], 0);
	PlayerTextDrawSetOutline(playerid, Textdraw2[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, Textdraw2[playerid], 51);
	PlayerTextDrawFont(playerid, Textdraw2[playerid], 1);
	PlayerTextDrawSetProportional(playerid, Textdraw2[playerid], 1);


	return id;
}

stock DestroyPlayerCheckBox(playerid, boxID)
{
	if(IsPlayerFieldCreated(playerid, boxID))
	{
		PlayerTextDrawDestroy(playerid, playerCheckBox[playerid][boxID][checkBoxText]);
		playerCheckBox[playerid][boxID][checkBoxText] = INVALID_PLAYER_TEXTDRAW;

		PlayerTextDrawDestroy(playerid, playerCheckBox[playerid][boxID][checkBox]);
		playerCheckBox[playerid][boxID][checkBox] = INVALID_PLAYER_TEXTDRAW;

		PlayerTextDrawDestroy(playerid, playerCheckBox[playerid][boxID][checkBoxBckg]);
		playerCheckBox[playerid][boxID][checkBoxBckg] = INVALID_PLAYER_TEXTDRAW;

		strdel(playerCheckBox[playerid][boxID][checkBoxTextStr], 0, VERY_SHORT_STR);
		return true;
	}
	return false;
}

// ----------------------------------------------------------------------------