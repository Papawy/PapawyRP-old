#if !defined PLAYERS_LOGIN_INCLUDED
	#define PLAYERS_LOGIN_INCLUDED
#endif

// ----------------------------------------------------------------------------

#include <YSI4\YSI_Coding\y_hooks>

// ----------------------------------------------------------------------------

#include "core.pwn"

// ----------------------------------------------------------------------------

enum P_LOGIN {
	fPass,
	tbAvert,
	bConnect,
	bQuit,
	bBckGrd,
	// --
	tmpPass[MAX_PLAYER_PASS+1],
	bool:isNotValid,
	bool:inLogin
}

new pLogin[MAX_PLAYERS][P_LOGIN];

// ----------------------------------------------------------------------------

forward StartLogin(playerid);
public StartLogin(playerid)
{
	pLogin[playerid][fPass] = CreatePlayerField(playerid, 250, 200, "Mot de passe", "...");
	SetFieldDefaultBehavior(playerid, pLogin[playerid][fPass], false);
	ShowPlayerField(playerid, pLogin[playerid][fPass]);

	pLogin[playerid][bQuit] = CreatePlayerButton(playerid, TD_SCREEN_WIDTH/2+BUTTON_DEFAULT_WIDTH/2+10, 250, "Quitter");
	ShowPlayerButton(playerid, pLogin[playerid][bQuit]);

	pLogin[playerid][bConnect] = CreatePlayerButton(playerid, TD_SCREEN_WIDTH/2-BUTTON_DEFAULT_WIDTH/2-10, 250, "Se connecter");
	ShowPlayerButton(playerid, pLogin[playerid][bConnect]);

	pLogin[playerid][tbAvert] = CreatePlayerTextbox(playerid, 320, 80, " ", .textColor=0xBB0000FF);

	pLogin[playerid][bBckGrd] = CreatePlayerBackground(playerid, \
		GetButtonGlobalPosX(playerid, pLogin[playerid][bConnect])-GetButtonWidth(playerid, pLogin[playerid][bConnect])/2-10, 180, \
		GetButtonGlobalPosX(playerid, pLogin[playerid][bQuit])+GetButtonWidth(playerid, pLogin[playerid][bQuit])/2+10, \
		GetButtonGlobalPosY(playerid, pLogin[playerid][bConnect])+GetButtonHeight(playerid, pLogin[playerid][bConnect])+10, 0x10101030);

	ShowPlayerBackground(playerid, pLogin[playerid][bBckGrd]);

	SelectTextDraw(playerid, 0x00FF00FF);

	pLogin[playerid][inLogin] = true;

	return 1;
}

forward DestroyLoginTD(playerid);
public DestroyLoginTD(playerid)
{
	DestroyPlayerField(playerid, pLogin[playerid][fPass]);

	DestroyPlayerButton(playerid, pLogin[playerid][bConnect]);
	DestroyPlayerButton(playerid, pLogin[playerid][bQuit]);

	DestroyPlayerTextbox(playerid, pLogin[playerid][tbAvert]);
	DestroyPlayerBackground(playerid, pLogin[playerid][bBckGrd]);
}

// ----------------------------------------------------------------------------

hook OnPlayerClickButton(playerid, buttonID)
{
	if(pLogin[playerid][inLogin])
	{
		if(pLogin[playerid][bQuit] == buttonID)
		{
			pLogin[playerid][inLogin] = false;
			DestroyLoginTD(playerid);
			KickEx(playerid);
		}
	}
	printf("Button ID : %i", buttonID);
	return 1;
}