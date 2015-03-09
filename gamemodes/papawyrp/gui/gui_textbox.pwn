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
	Float:tbHeight
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