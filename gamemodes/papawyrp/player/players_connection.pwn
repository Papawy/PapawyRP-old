#if !defined PLAYERS_CONNECTION_INCLUDED
	#define PLAYERS_CONNECTION_INCLUDED
#endif

// ----------------------------------------------------------------------------

#include <YSI4\YSI_Coding\y_hooks>

// ----------------------------------------------------------------------------

#include "core.pwn"

// ----------------------------------------------------------------------------

new Name;
new Email;
new Pass;
new PassConfirm;

// ----------------------------------------------------------------------------

hook OnPlayerConnect(playerid)
{
	Name = CreatePlayerField(playerid, 300, 200, "Pseudo", "Jacquouille");
	ShowPlayerField(Name);

	Email = CreatePlayerField(playerid, 300, 250, "EMail", "Jacquouille.lafripouille@gmail.com");
	ShowPlayerField(Email);

	Pass = CreatePlayerField(playerid, 300, 300, "Mot de passe", "...");
	SetFieldDefaultBehavior(Pass, false);
	ShowPlayerField(Pass);

	PassConfirm = CreatePlayerField(playerid, 300, 350, "Confirmation mot de passe", "...");
	SetFieldDefaultBehavior(PassConfirm, false);
	ShowPlayerField(PassConfirm);

	SelectTextDraw(playerid, 0x00FF00FF);

	LoadPlayerData(playerid, 1);
	if(!IsPlayerRegistered(playerid))
	{
		//RegisterPlayer(playerid);
		return 1;
	}
	return 1;
}

hook OnPlayerPlayerFieldResp(playerid, fieldid, inputtext[])
{

	if(fieldid == Pass)
	{
		new tmpstr[NORMAL_STR];
		for(new i=0; i<strlen(inputtext); ++i)
			tmpstr[i] = 'X';

		UpdateFieldName(fieldid, tmpstr);
	}
	if(fieldid == PassConfirm)
	{
		new tmpstr[NORMAL_STR];
		for(new i=0; i<strlen(inputtext); ++i)
			tmpstr[i] = 'X';

		UpdateFieldName(fieldid, tmpstr);
	}
	return 1;
}