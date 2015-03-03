#if !defined GUI_FIELDS_INCLUDED
	#define GUI_FIELDS_INCLUDED
#endif

// ----------------------------------------------------------------------------

#include "core.pwn"

// ----------------------------------------------------------------------------


// need to be optimized
enum FIELD_INFOS {
	PlayerText:fieldNname,
	PlayerText:field
}

new playerFields[MAX_PLAYERS][FIELD_INFOS];

forward CreatePlayerField(playerid);
public CreatePlayerField(playerid)
{
	
}