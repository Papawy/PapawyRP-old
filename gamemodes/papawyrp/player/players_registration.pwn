#if !defined PLAYERS_REGISTRATION_INCLUDED
	#define PLAYERS_REGISTRATION_INCLUDED
#endif

// ----------------------------------------------------------------------------

#include <YSI4\YSI_Coding\y_hooks>

// ----------------------------------------------------------------------------

#include "core.pwn"

// ----------------------------------------------------------------------------

#define COLOR_IMPORTANT						INDIANRED1

// ----------------------------------------------------------------------------

new Name[MAX_PLAYERS];
new Email[MAX_PLAYERS];
new Pass[MAX_PLAYERS];
new PassConfirm[MAX_PLAYERS];

new AcceptButton[MAX_PLAYERS];
new QuitButton[MAX_PLAYERS];

new BckGrd[MAX_PLAYERS];

// ----------------------------------------------------------------------------

forward RegisterPlayer(playerid);
public RegisterPlayer(playerid)
{
	Name[playerid] = CreatePlayerField(playerid, 250, 100, "Pseudo", "Votre pseudo");
	ShowPlayerField(playerid, Name[playerid]);

	Email[playerid] = CreatePlayerField(playerid, 250, 150, "EMail", "Adresse email");
	ShowPlayerField(playerid, Email[playerid]);

	Pass[playerid] = CreatePlayerField(playerid, 250, 200, "Mot de passe", "...");
	SetFieldDefaultBehavior(playerid, Pass[playerid], false);
	ShowPlayerField(playerid, Pass[playerid]);

	PassConfirm[playerid] = CreatePlayerField(playerid, 250, 250, "Confirmation", "...");
	SetFieldDefaultBehavior(playerid, PassConfirm[playerid], false);
	ShowPlayerField(playerid, PassConfirm[playerid]);

	QuitButton[playerid] = CreatePlayerButton(playerid,320+BUTTON_DEFAULT_WIDTH/2+10, 300, "Quitter");
	ShowPlayerButton(playerid, QuitButton[playerid]);

	AcceptButton[playerid] = CreatePlayerButton(playerid,320-BUTTON_DEFAULT_WIDTH/2-10, 300, "S'inscrire");
	ShowPlayerButton(playerid, AcceptButton[playerid]);

	BckGrd[playerid] = CreatePlayerBackground(playerid, \
		GetButtonGlobalPosX(playerid, AcceptButton[playerid])-GetButtonWidth(playerid, AcceptButton[playerid])/2-10, 80, \
		GetButtonGlobalPosX(playerid, QuitButton[playerid])+GetButtonWidth(playerid, QuitButton[playerid])/2+10, \
		GetButtonGlobalPosY(playerid, AcceptButton[playerid])+GetButtonHeight(playerid, AcceptButton[playerid])+10, 0x10101030);

	ShowPlayerBackground(playerid, BckGrd[playerid]);

	SelectTextDraw(playerid, 0x00FF00FF);

	return 1;
}

hook OnPlayerFieldResponse(playerid, fieldid, inputtext[])
{

	if(fieldid == Pass[playerid])
	{
		new tmpstr[NORMAL_STR];
		for(new i=0; i<strlen(inputtext); ++i)
			tmpstr[i] = 'X';

		UpdateFieldName(playerid, fieldid, tmpstr);
		WP_Hash(pInfos[playerid][pPass], HASHED_PASS_LENGHT, inputtext);

	}
	if(fieldid == PassConfirm[playerid])
	{
		new tmpstr[NORMAL_STR];
		for(new i=0; i<strlen(inputtext); ++i)
			tmpstr[i] = 'X';

		UpdateFieldName(playerid, fieldid, tmpstr);
	}
	return 1;
}

hook OnPlayerClickButton(playerid, buttonID)
{
	if(buttonID == AcceptButton[playerid])
	{
		SendClientMessage(playerid, -1, "Tu as clique !");
	}
	if(buttonID == QuitButton[playerid])
	{
		KickEx(playerid);
	}
	return 1;
}