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
	tmpHashedPass[HASHED_PASS_LENGHT],
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
		if(pLogin[playerid][bConnect] == buttonID)
		{
			WP_Hash(pLogin[playerid][tmpHashedPass], HASHED_PASS_LENGHT, pLogin[playerid][tmpPass]);

			if(strcmp(pLogin[playerid][tmpHashedPass], pInfos[playerid][pPass]) == 0)
			{
				ChangeTextboxColor(playerid, pRegist[playerid][tbAvert], 0x00BB00FF);
				ChangeTextboxString(playerid, pLogin[playerid][tbAvert], convert_encoding("Connexion réussie !"));
				DestroyLoginTD(playerid);
				CallLocalFunction("StartCharacterCreation", "d", playerid);
				// Connection successfull
			}
			else
			{
				ChangeTextboxColor(playerid, pRegist[playerid][tbAvert], 0xBB0000FF);
				ChangeTextboxString(playerid, pLogin[playerid][tbAvert], convert_encoding("Le mot de passe n'est pas bon !"));
			}
		}
	}
	return 1;
}

hook OnPlayerFieldResponse(playerid, fieldid, inputtext[])
{
	if(pLogin[playerid][inLogin])
	{
		if(pLogin[playerid][fPass] == fieldid)
		{
			new tmpstr[NORMAL_STR];
			for(new i=0; i<strlen(inputtext); ++i)
				tmpstr[i] = 'X';

			UpdateFieldName(playerid, fieldid, tmpstr);
			if(strlen(inputtext) == 0)
			{
				tmpstr[0] = ' ';
			}
			strdel(pLogin[playerid][tmpPass], 0, MAX_PLAYER_PASS);
			strins(pLogin[playerid][tmpPass], inputtext, 0, MAX_PLAYER_PASS+1);
		}
	}
	return 1;
}

// ----------------------------------------------------------------------------

// Here, we stop some people trying to do some horrible stuff :o

hook OnPlayerRequestSpawn(playerid)
{
	if(pLogin[playerid][inLogin])
	{
		return 0;
	}
	return 1;
}

hook OnPlayerSpawn(playerid)
{
	if(pLogin[playerid][inLogin])
	{
		ChangeTextboxString(playerid, pLogin[playerid][tbAvert], convert_encoding("Le by-pass c'est mal ! Bouhou !"));
		KickEx(playerid);
	}
	return 1;
}

hook OnPlayerDeath(playerid)
{
	if(pLogin[playerid][inLogin])
	{
		ChangeTextboxString(playerid, pLogin[playerid][tbAvert], convert_encoding("Le by-pass c'est mal ! Bouhou !"));
		KickEx(playerid);
	}
	return 1;
}

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(pLogin[playerid][inLogin])
	{
		ChangeTextboxString(playerid, pLogin[playerid][tbAvert], convert_encoding("Le by-pass c'est mal ! Bouhou !"));
		KickEx(playerid);
	}
	return 1;
}

hook OnPlayerText(playerid, text[])
{
	if(pLogin[playerid][inLogin])
	{
		return 0;
	}
	return 1;
}

hook OnPlayerCommandText(playerid, cmdtext[])
{
	if(pLogin[playerid][inLogin])
	{
		return 1;
	}
	return 0;
}