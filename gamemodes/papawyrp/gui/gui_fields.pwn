#if !defined GUI_FIELDS_INCLUDED
	#define GUI_FIELDS_INCLUDED
#endif

// ----------------------------------------------------------------------------

#include "core.pwn"

// ----------------------------------------------------------------------------

#include <YSI4\YSI_Coding\y_hooks>

// ----------------------------------------------------------------------------

#define MAX_FIELDS 					100

// ----------------------------------------------------------------------------

// Try to implement Iterator with y_iterate, later...
enum FIELD_INFOS {
	PlayerText:fieldName,
	fieldNameStr[VERY_SHORT_STR],
	PlayerText:field,
	pid,
	bool:useDefaultBehavior
}

new playerFields[MAX_FIELDS][FIELD_INFOS];

new playerActualField[MAX_PLAYERS];

// ----------------------------------------------------------------------------

hook OnGameModeInit()
{
	for(new i=0; i<MAX_FIELDS; ++i)
	{
		playerFields[i][field] = PlayerText:INVALID_TEXT_DRAW;
		playerFields[i][fieldName] = PlayerText:INVALID_TEXT_DRAW;
		playerFields[i][useDefaultBehavior] = true;
	}
	return 1;
}

// ----------------------------------------------------------------------------

hook OnPlayerClickPlayerTD(playerid, PlayerText:playertextid)
{
	if(playertextid != PlayerText:INVALID_TEXT_DRAW)
	{
		for(new i=0; i<MAX_FIELDS; ++i)
		{
			if(playerFields[i][field] == playertextid)
			{
				CallRemoteFunction("OnPlayerClkPlayerField", "dd", playerid, i);
				break;
			}
		}
	}
	return 1;
}

hook OnPlayerClkPlayerField(playerid, fieldID)
{
	playerActualField[playerid] = fieldID;
	Dialog_Show(playerid, FieldResponse, DIALOG_STYLE_INPUT, playerFields[fieldID][fieldNameStr], " ", "Entrer", "");
	return 1;
}

Dialog:FieldResponse(playerid, response, listitem, inputtext[])
{
	if(strlen(inputtext) == 0)
	{
		Dialog_Show(playerid, FieldResponse, DIALOG_STYLE_INPUT, playerFields[playerActualField[playerid]][fieldNameStr], "", "Entrer", "");
		return 1;
	}
	else {
		if(playerFields[playerActualField[playerid]][useDefaultBehavior])
		{
			UpdateFieldName(playerActualField[playerid], inputtext);
		}
		CallRemoteFunction("OnPlayerPlayerFieldResp", "dds", playerid, playerActualField[playerid], inputtext);
	}
	return 1;
}

// ----------------------------------------------------------------------------

stock ShowPlayerField(fieldID)
{
	PlayerTextDrawShow(playerFields[fieldID][pid], playerFields[fieldID][fieldName]);
	PlayerTextDrawShow(playerFields[fieldID][pid], playerFields[fieldID][field]);
	return 1;
}

stock HidePlayerField(fieldID)
{
	PlayerTextDrawHide(playerFields[fieldID][pid], playerFields[fieldID][fieldName]);
	PlayerTextDrawHide(playerFields[fieldID][pid], playerFields[fieldID][field]);
	return 1;
}

stock UpdateFieldName(fieldID, name[])
{
	PlayerTextDrawHide(playerFields[fieldID][pid], playerFields[fieldID][field]);
	PlayerTextDrawSetString(playerFields[fieldID][pid], playerFields[fieldID][field], name);
	PlayerTextDrawShow(playerFields[fieldID][pid], playerFields[fieldID][field]);
	return 1;
}

stock CreatePlayerField(playerid, Float:x, Float:y, name[], fieldDefaultValue[]=" ", color=0xFFFFFFFF, fieldColor=0x88888860)
{
	new id = GetAvailablePlayerFieldID();
	if(id == -1)
	{
		return INVALID_TEXT_DRAW;
	}
	playerFields[id][pid] = playerid;
	strins(playerFields[id][fieldNameStr], name, 0, VERY_SHORT_STR);
	playerFields[id][fieldName] = CreatePlayerTextDraw(playerFields[id][pid], x+7, y, name);
	PlayerTextDrawLetterSize(playerFields[id][pid], playerFields[id][fieldName], 0.412999, 1.512888);
	PlayerTextDrawAlignment(playerFields[id][pid], playerFields[id][fieldName], 1);
	PlayerTextDrawColor(playerFields[id][pid], playerFields[id][fieldName], color);
	PlayerTextDrawSetShadow(playerFields[id][pid], playerFields[id][fieldName], 0);
	PlayerTextDrawSetOutline(playerFields[id][pid], playerFields[id][fieldName], 1);
	PlayerTextDrawBackgroundColor(playerFields[id][pid], playerFields[id][fieldName], 51);
	PlayerTextDrawFont(playerFields[id][pid], playerFields[id][fieldName], 1);
	PlayerTextDrawSetProportional(playerFields[id][pid], playerFields[id][fieldName], 1);

	playerFields[id][field] = CreatePlayerTextDraw(playerFields[id][pid], x, y+16, fieldDefaultValue);
	PlayerTextDrawLetterSize(playerFields[id][pid], playerFields[id][field], 0.29, 1.6);
	PlayerTextDrawTextSize(playerFields[id][pid], playerFields[id][field], x+135, 17);
	PlayerTextDrawColor(playerFields[id][pid], playerFields[id][field], -1);
	PlayerTextDrawUseBox(playerFields[id][pid], playerFields[id][field], true);
	PlayerTextDrawBoxColor(playerFields[id][pid], playerFields[id][field], fieldColor);
	PlayerTextDrawSetShadow(playerFields[id][pid], playerFields[id][field], 0);
	PlayerTextDrawSetOutline(playerFields[id][pid], playerFields[id][field], 1);
	PlayerTextDrawBackgroundColor(playerFields[id][pid], playerFields[id][field], 255);
	PlayerTextDrawFont(playerFields[id][pid], playerFields[id][field], 1);
	PlayerTextDrawSetProportional(playerFields[id][pid], playerFields[id][field], 1);
	PlayerTextDrawSetSelectable(playerFields[id][pid], playerFields[id][field], true);

	return id;
}

stock DestroyPlayerField(fieldID)
{
	if(IsPlayerFieldCreated(fieldID))
	{
		PlayerTextDrawDestroy(playerFields[id][pid], playerFields[fieldID][fieldName]);
		playerFields[fieldID][fieldName] = INVALID_TEXT_DRAW;
		PlayerTextDrawDestroy(playerFields[id][pid], playerFields[fieldID][field]);
		playerFields[fieldID][field] = INVALID_TEXT_DRAW;
		strdel(playerFields[id][fieldNameStr], 0, VERY_SHORT_STR);
		playerFields[fieldID][pid] = INVALID_PLAYER_ID;
		playerFields[fieldID][useDefaultBehavior] = true;
		return true;
	}
	return false;
}

stock GetAvailablePlayerFieldID()
{
	for(new i=0; i<MAX_FIELDS; ++i)
	{
		if(!IsPlayerFieldCreated(i))
			return i;
	}
	return -1;
}

stock IsPlayerFieldCreated(fieldID)
{
	if(playerFields[fieldID][field] == PlayerText:INVALID_TEXT_DRAW)
		return false;
	else
		return true;
}

stock SetFieldDefaultBehavior(fieldID, bool:set)
{
	playerFields[fieldID][useDefaultBehavior] = set;
	return 1;
}

stock IsValidPlayerField(fieldID)
{
	return IsPlayerFieldCreated(fieldID);
}