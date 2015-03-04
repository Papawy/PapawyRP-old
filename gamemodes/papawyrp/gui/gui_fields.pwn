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

hook OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
	for(new i=0; i<MAX_FIELDS; ++i)
	{
		if(playerFields[i][field] == playertextid)
			CallRemoteFunction("OnPlayerClickPlayerField", "dd", playerid, i);
	}
}

hook OnPlayerClickPlayerField(playerid, fieldID)
{
	Dialog_Show(playerid, FieldResponse, DIALOG_STYLE_INPUT, playerFields[id][fieldNameStr], "", "Entrer", "");
}

Dialog:FieldResponse(playerid, response, listitem, inputtext[])
{
	CallRemoteFunction("OnPlayerPlayerFieldResponse", "ds", {Float,_:...})
}

// ----------------------------------------------------------------------------

// Try to implement Iterator with y_iterate, later...
enum FIELD_INFOS {
	PlayerText:fieldName,
	fieldNameStr[VERY_SHORT_STR],
	PlayerText:field,
	pid
}

new playerFields[MAX_FIELDS][FIELD_INFOS];

forward CreatePlayerField(playerid, Float:x, Float:y, fieldName[], fieldDefaultValue[]="");
public CreatePlayerField(playerid, Float:x, Float:y, fieldName[], fieldDefaultValue[]="")
{
	new id = GetAvailablePlayerFieldID();
	if(id == -1)
	{
		return -1;
	}
	playerFields[id][pid] = playerid;
	strins(playerFields[id][fieldNameStr], fieldName, 0, VERY_SHORT_STR);
	playerFields[id][fieldName] = CreatePlayerTextDraw(playerFields[id][pid], x, y, fieldName);
	PlayerTextDrawLetterSize(playerFields[id][pid], playerFields[id][fieldName], 0.412999, 1.512888);
	PlayerTextDrawAlignment(playerFields[id][pid], playerFields[id][fieldName], 1);
	PlayerTextDrawColor(playerFields[id][pid], playerFields[id][fieldName], -1);
	PlayerTextDrawSetShadow(playerFields[id][pid], playerFields[id][fieldName], 0);
	PlayerTextDrawSetOutline(playerFields[id][pid], playerFields[id][fieldName], 1);
	PlayerTextDrawBackgroundColor(playerFields[id][pid], playerFields[id][fieldName], 51);
	PlayerTextDrawFont(playerFields[id][pid], playerFields[id][fieldName], 1);
	PlayerTextDrawSetProportional(playerFields[id][pid], playerFields[id][fieldName], 1);

	playerFields[id][field] = CreatePlayerTextDraw(playerFields[id][pid], x+59.666718, y+16.59256, fieldDefaultValue);
	PlayerTextDrawLetterSize(playerFields[id][pid], playerFields[id][field], 0.273666, 1.467260);
	PlayerTextDrawTextSize(playerFields[id][pid], playerFields[id][field], 408.999725, 137.718383);
	PlayerTextDrawAlignment(playerFields[id][pid], playerFields[id][field], 2);
	PlayerTextDrawColor(playerFields[id][pid], playerFields[id][field], -1);
	PlayerTextDrawUseBox(playerFields[id][pid], playerFields[id][field], true);
	PlayerTextDrawBoxColor(playerFields[id][pid], playerFields[id][field], -2139062017);
	PlayerTextDrawSetShadow(playerFields[id][pid], playerFields[id][field], 0);
	PlayerTextDrawSetOutline(playerFields[id][pid], playerFields[id][field], 1);
	PlayerTextDrawBackgroundColor(playerFields[id][pid], playerFields[id][field], 255);
	PlayerTextDrawFont(playerFields[id][pid], playerFields[id][field], 1);
	PlayerTextDrawSetProportional(playerFields[id][pid], playerFields[id][field], 1);
	PlayerTextDrawSetSelectable(playerFields[id][pid], playerFields[id][field], true);

	return id;
}

forward DestroyPlayerField(fieldID);
public DestroyPlayerField(fieldID)
{
	if(IsPlayerFieldCreated(fieldID))
	{
		PlayerTextDrawDestroy(playerFields[id][pid], playerFields[fieldID][fieldName]);
		layerFields[fieldID][fieldName] = -1;
		PlayerTextDrawDestroy(playerFields[id][pid], playerFields[fieldID][field]);
		layerFields[fieldID][field] = -1;
		strdel(playerFields[id][fieldNameStr], 0, VERY_SHORT_STR);
		playerFields[id][pid] = -1;
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
	if(playerFields[i][field] == -1)
		return false;
	else
		return true;
}