#if !defined PLAYERS_CONNECTION_INCLUDED
	#define PLAYERS_CONNECTION_INCLUDED
#endif

// ----------------------------------------------------------------------------

#include <YSI4\YSI_Coding\y_hooks>

// ----------------------------------------------------------------------------

#include "core.pwn"

// ----------------------------------------------------------------------------

new Name[MAX_PLAYERS];
new Email[MAX_PLAYERS];
new Pass[MAX_PLAYERS];
new PassConfirm[MAX_PLAYERS];

new AcceptButton[MAX_PLAYERS];

new BckGrd[MAX_PLAYERS];

// ----------------------------------------------------------------------------

hook OnPlayerConnect(playerid)
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

	AcceptButton[playerid] = CreatePlayerButton(playerid, 320, 300, "S'inscrire");
	ShowPlayerButton(playerid, AcceptButton[playerid]);

	BckGrd[playerid] = CreatePlayerBackground(playerid, 220, 80, 420, 320, 0x20202030);
	ShowPlayerBackground(playerid, BckGrd[playerid]);

	SelectTextDraw(playerid, 0x00FF00FF);

	LoadPlayerData(playerid, 1);
	if(!IsPlayerRegistered(playerid))
	{
		//RegisterPlayer(playerid);
		return 1;
	}
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
	return 1;
}