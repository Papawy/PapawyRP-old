#if !defined TXDRAW_CHARACTER_INCLUDED
	#define TXDRAW_CHARACTER_INCLUDED
#endif
 
// ----------------------------------------------------------------------------

#include "core.pwn"

// ----------------------------------------------------------------------------

#include <YSI4\YSI_Coding\y_hooks>

// ----------------------------------------------------------------------------

#define MAX_CHARACTER_TD_USED			10

// ----------------------------------------------------------------------------

enum TD_CHARACTER {
	PlayerText:Background,
	PlayerText:SkinPreview,
	PlayerText:Name_header,
	PlayerText:Name_field,
	PlayerText:Age_header,
	PlayerText:Age_field,
	PlayerText:Size_header,
	PlayerText:Size_field,
	PlayerText:Type_header,
	PlayerText:Type_field,

}

// ----------------------------------------------------------------------------
new TDCharacter[MAX_PLAYERS][10];

stock TD_CharacterCreateInit(playerid)
{

	//Player Textdraws:

	new PlayerText:Textdraw0[MAX_PLAYERS];
	new PlayerText:Textdraw1[MAX_PLAYERS];
	new PlayerText:Textdraw2[MAX_PLAYERS];
	new PlayerText:Textdraw3[MAX_PLAYERS];
	new PlayerText:Textdraw4[MAX_PLAYERS];


	TDCharacter[playerid][10][playerid] = CreatePlayerTextDraw(playerid, 453.333343, 91.514816, "usebox");
	PlayerTextDrawLetterSize(playerid, Textdraw0[playerid], 0.000000, 34.297325);
	PlayerTextDrawTextSize(playerid, Textdraw0[playerid], 185.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, Textdraw0[playerid], 1);
	PlayerTextDrawColor(playerid, Textdraw0[playerid], 0);
	PlayerTextDrawUseBox(playerid, Textdraw0[playerid], true);
	PlayerTextDrawBoxColor(playerid, Textdraw0[playerid], 102);
	PlayerTextDrawSetShadow(playerid, Textdraw0[playerid], 0);
	PlayerTextDrawSetOutline(playerid, Textdraw0[playerid], 0);
	PlayerTextDrawFont(playerid, Textdraw0[playerid], 0);
	PlayerTextDrawSetProportional(playerid, Textdraw0[playerid], 1);

	Textdraw1[playerid] = CreatePlayerTextDraw(playerid, 307.000000, 102.714813, "Skin");
	PlayerTextDrawLetterSize(playerid, Textdraw1[playerid], 0.000000, 17.935184);
	PlayerTextDrawTextSize(playerid, Textdraw1[playerid], 195.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, Textdraw1[playerid], 1);
	PlayerTextDrawColor(playerid, Textdraw1[playerid], -16776961);
	PlayerTextDrawUseBox(playerid, Textdraw1[playerid], true);
	PlayerTextDrawBoxColor(playerid, Textdraw1[playerid], -2139062017);
	PlayerTextDrawSetShadow(playerid, Textdraw1[playerid], 0);
	PlayerTextDrawSetOutline(playerid, Textdraw1[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, Textdraw1[playerid], -2139062017);
	PlayerTextDrawFont(playerid, Textdraw1[playerid], 0);

	Textdraw2[playerid] = CreatePlayerTextDraw(playerid, 192.666748, 81.303672, "Votre personnage");
	PlayerTextDrawLetterSize(playerid, Textdraw2[playerid], 0.449999, 1.600000);
	PlayerTextDrawAlignment(playerid, Textdraw2[playerid], 1);
	PlayerTextDrawColor(playerid, Textdraw2[playerid], -1);
	PlayerTextDrawSetShadow(playerid, Textdraw2[playerid], 0);
	PlayerTextDrawSetOutline(playerid, Textdraw2[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, Textdraw2[playerid], 51);
	PlayerTextDrawFont(playerid, Textdraw2[playerid], 1);
	PlayerTextDrawSetProportional(playerid, Textdraw2[playerid], 1);

	Textdraw3[playerid] = CreatePlayerTextDraw(playerid, 319.333404, 106.192619, "Nom :");
	PlayerTextDrawLetterSize(playerid, Textdraw3[playerid], 0.412999, 1.512888);
	PlayerTextDrawAlignment(playerid, Textdraw3[playerid], 1);
	PlayerTextDrawColor(playerid, Textdraw3[playerid], -1);
	PlayerTextDrawSetShadow(playerid, Textdraw3[playerid], 0);
	PlayerTextDrawSetOutline(playerid, Textdraw3[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, Textdraw3[playerid], 51);
	PlayerTextDrawFont(playerid, Textdraw3[playerid], 1);
	PlayerTextDrawSetProportional(playerid, Textdraw3[playerid], 1);

	Textdraw4[playerid] = CreatePlayerTextDraw(playerid, 379.000122, 122.785179, "JeanCharle_DeLaTourTaMere");
	PlayerTextDrawLetterSize(playerid, Textdraw4[playerid], 0.273666, 1.467260);
	PlayerTextDrawTextSize(playerid, Textdraw4[playerid], 408.999725, 137.718383);
	PlayerTextDrawAlignment(playerid, Textdraw4[playerid], 2);
	PlayerTextDrawColor(playerid, Textdraw4[playerid], -1);
	PlayerTextDrawUseBox(playerid, Textdraw4[playerid], true);
	PlayerTextDrawBoxColor(playerid, Textdraw4[playerid], -2139062017);
	PlayerTextDrawSetShadow(playerid, Textdraw4[playerid], 0);
	PlayerTextDrawSetOutline(playerid, Textdraw4[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, Textdraw4[playerid], 255);
	PlayerTextDrawFont(playerid, Textdraw4[playerid], 1);
	PlayerTextDrawSetProportional(playerid, Textdraw4[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, Textdraw4[playerid], true);
}