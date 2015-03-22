#if !defined GUI_FIELDS_INCLUDED
	#define GUI_FIELDS_INCLUDED
#endif

// ----------------------------------------------------------------------------

#include "...\core.pwn"

// ----------------------------------------------------------------------------

#include <YSI4\YSI_Coding\y_hooks>

// ----------------------------------------------------------------------------

#define MAX_FIELDS 					50

#define FIELD_DEFAULT_WIDTH			135.0
#define FIELD_DEFAULT_HEIGHT		17.0

// ----------------------------------------------------------------------------

// Try to implement Iterator with y_iterate, later...
enum FIELD_INFOS {
	PlayerText:fieldName,
	fieldNameStr[VERY_SHORT_STR],
	PlayerText:field,
	Float:fWidth,
	Float:fHeight,
	bool:useDefaultBehavior,
	Float:globalX,
	Float:globalY
}

new playerFields[MAX_PLAYERS][MAX_FIELDS][FIELD_INFOS];

new playerActualField[MAX_PLAYERS];

// ----------------------------------------------------------------------------

hook OnGameModeInit()
{
	for(new p=0; p<MAX_PLAYERS; p++)
	{
		for(new i=0; i<MAX_FIELDS; ++i)
		{
			playerFields[p][i][field] = INVALID_PLAYER_TEXTDRAW;
			playerFields[p][i][fieldName] = INVALID_PLAYER_TEXTDRAW;
			playerFields[p][i][useDefaultBehavior] = true;
		}
	}
	return 1;
}

// ----------------------------------------------------------------------------

hook OnPlayerClickPlayerTD(playerid, PlayerText:playertextid)
{
	if(playertextid != INVALID_PLAYER_TEXTDRAW)
	{
		for(new i=0; i<MAX_FIELDS; ++i)
		{
			if(playerFields[playerid][i][field] == playertextid)
			{
				CallRemoteFunction("OnPlayerClickField", "dd", playerid, i);
				return 1;
			}
		}
	}
	return 0;
}

hook OnPlayerClickField(playerid, fieldID)
{
	playerActualField[playerid] = fieldID;
	Dialog_Show(playerid, FieldResponse, DIALOG_STYLE_INPUT, playerFields[playerid][fieldID][fieldNameStr], " ", "Entrer", "");
	return 1;
}

Dialog:FieldResponse(playerid, response, listitem, inputtext[])
{
	if(strlen(inputtext) == 0)
	{
		Dialog_Show(playerid, FieldResponse, DIALOG_STYLE_INPUT, playerFields[playerid][playerActualField[playerid]][fieldNameStr], "", "Entrer", "");
		return 1;
	}
	else {
		if(playerFields[playerid][playerActualField[playerid]][useDefaultBehavior])
		{
			UpdateFieldName(playerid, playerActualField[playerid], inputtext);
		}
		CallRemoteFunction("OnPlayerFieldResponse", "dds", playerid, playerActualField[playerid], inputtext);
	}
	return 1;
}

// ----------------------------------------------------------------------------

stock ShowPlayerField(playerid, fieldID)
{
	PlayerTextDrawShow(playerid, playerFields[playerid][fieldID][fieldName]);
	PlayerTextDrawShow(playerid, playerFields[playerid][fieldID][field]);
	return 1;
}

stock HidePlayerField(playerid, fieldID)
{
	PlayerTextDrawHide(playerid, playerFields[playerid][fieldID][fieldName]);
	PlayerTextDrawHide(playerid, playerFields[playerid][fieldID][field]);
	return 1;
}

stock UpdateFieldName(playerid, fieldID, name[])
{
	PlayerTextDrawHide(playerid, playerFields[playerid][fieldID][field]);
	PlayerTextDrawSetString(playerid, playerFields[playerid][fieldID][field], name);
	PlayerTextDrawShow(playerid, playerFields[playerid][fieldID][field]);
	return 1;
}

// ----------------------------------------------------------------------------

stock CreatePlayerField(playerid, Float:x, Float:y, name[], fieldDefaultValue[]=" ", color=0xFFFFFFFF, fieldColor=0x88888860, Float:fieldWidth=FIELD_DEFAULT_WIDTH, Float:fieldHeight=FIELD_DEFAULT_HEIGHT)
{
	new id = GetAvailablePlayerFieldID(playerid);
	if(id == -1)
	{
		return INVALID_TEXT_DRAW;
	}
	strins(playerFields[playerid][id][fieldNameStr], name, 0, VERY_SHORT_STR);
	playerFields[playerid][id][fieldName] = CreatePlayerTextDraw(playerid, x+7, y, name);
	PlayerTextDrawLetterSize(playerid, playerFields[playerid][id][fieldName], 0.412999, 1.512888);
	PlayerTextDrawAlignment(playerid, playerFields[playerid][id][fieldName], 1);
	PlayerTextDrawColor(playerid, playerFields[playerid][id][fieldName], color);
	PlayerTextDrawSetShadow(playerid, playerFields[playerid][id][fieldName], 0);
	PlayerTextDrawSetOutline(playerid, playerFields[playerid][id][fieldName], 1);
	PlayerTextDrawBackgroundColor(playerid, playerFields[playerid][id][fieldName], 51);
	PlayerTextDrawFont(playerid, playerFields[playerid][id][fieldName], 1);
	PlayerTextDrawSetProportional(playerid, playerFields[playerid][id][fieldName], 1);

	playerFields[playerid][id][globalX] = x;
	playerFields[playerid][id][globalY] = y;

	playerFields[playerid][id][fWidth] = fieldWidth;
	playerFields[playerid][id][fHeight] = fieldHeight;

	playerFields[playerid][id][field] = CreatePlayerTextDraw(playerid, x, y+16, fieldDefaultValue);
	PlayerTextDrawLetterSize(playerid, playerFields[playerid][id][field], 0.29, 1.6);
	PlayerTextDrawAlignment(playerid, playerFields[playerid][id][field], 1);
	PlayerTextDrawTextSize(playerid, playerFields[playerid][id][field], x+playerFields[playerid][id][fWidth], playerFields[playerid][id][fHeight]);
	PlayerTextDrawColor(playerid, playerFields[playerid][id][field], -1);
	PlayerTextDrawUseBox(playerid, playerFields[playerid][id][field], true);
	PlayerTextDrawBoxColor(playerid, playerFields[playerid][id][field], fieldColor);
	PlayerTextDrawSetShadow(playerid, playerFields[playerid][id][field], 0);
	PlayerTextDrawSetOutline(playerid, playerFields[playerid][id][field], 1);
	PlayerTextDrawBackgroundColor(playerid, playerFields[playerid][id][field], 255);
	PlayerTextDrawFont(playerid, playerFields[playerid][id][field], 1);
	PlayerTextDrawSetProportional(playerid, playerFields[playerid][id][field], 1);
	PlayerTextDrawSetSelectable(playerid, playerFields[playerid][id][field], true);

	return id;
}

stock DestroyPlayerField(playerid, fieldID)
{
	if(IsPlayerFieldCreated(playerid, fieldID))
	{
		PlayerTextDrawDestroy(playerid, playerFields[playerid][fieldID][fieldName]);
		playerFields[playerid][fieldID][fieldName] = INVALID_PLAYER_TEXTDRAW;
		PlayerTextDrawDestroy(playerid, playerFields[playerid][fieldID][field]);
		playerFields[playerid][fieldID][field] = INVALID_PLAYER_TEXTDRAW;
		strdel(playerFields[playerid][fieldID][fieldNameStr], 0, VERY_SHORT_STR);
		playerFields[playerid][fieldID][useDefaultBehavior] = true;
		return true;
	}
	return false;
}

// ----------------------------------------------------------------------------

stock Float:GetFieldGlobalPosX(playerid, fieldID)
{
	return playerFields[playerid][fieldID][globalX];
}

stock Float:GetFieldGlobalPosY(playerid, fieldID)
{
	return playerFields[playerid][fieldID][globalY];
}

// ----------------------------------------------------------------------------

stock Float:GetFieldWidth(playerid, fieldID)
{
	return playerFields[playerid][fieldID][fWidth];
}

stock Float:GetFieldHeight(playerid, fieldID)
{
	return playerFields[playerid][fieldID][fHeight];
}

stock Float:GetGlobalFieldWidth(playerid, fieldID)
{
	return GetFieldWidth(playerid, fieldID);
}

stock Float:GetGlobalFieldHeight(playerid, fieldID)
{
	return playerFields[playerid][fieldID][fHeight]+16;
}

// ----------------------------------------------------------------------------

stock GetAvailablePlayerFieldID(playerid)
{
	for(new i=0; i<MAX_FIELDS; ++i)
	{
		if(!IsPlayerFieldCreated(playerid, i))
			return i;
	}
	return -1;
}

stock IsPlayerFieldCreated(playerid, fieldID)
{
	if(playerFields[playerid][fieldID][field] == INVALID_PLAYER_TEXTDRAW)
		return false;
	else
		return true;
}

stock SetFieldDefaultBehavior(playerid, fieldID, bool:set)
{
	playerFields[playerid][fieldID][useDefaultBehavior] = set;
	return 1;
}

stock IsValidPlayerField(playerid, fieldID)
{
	return IsPlayerFieldCreated(playerid, fieldID);
}