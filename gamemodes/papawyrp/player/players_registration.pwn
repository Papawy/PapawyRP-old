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

enum P_REGISTRATION {
	fEmail,
	fPass,
	fPassConfirm,
	tbAvert,
	bAccept,
	bQuit,
	bBckGrd,
	// --
	tmpPass[MAX_PLAYER_PASS+1],
	tmpPassConfirm[MAX_PLAYER_PASS+1],
	tmpEmail[LONG_STR],
	bool:isNotValid,
	bool:inRegistration,
}

new pRegist[MAX_PLAYERS][P_REGISTRATION];

// ----------------------------------------------------------------------------

forward RegisterPlayer(playerid);
public RegisterPlayer(playerid)
{
	WP_Hash(pInfos[playerid][pPass], HASHED_PASS_LENGHT, pRegist[playerid][tmpPass]);
	strins(pInfos[playerid][pEmail], pRegist[playerid][tmpEmail], 0, LONG_STR);

	GetPlayerIp(playerid, pInfos[playerid][pIP], VERY_VERY_SHORT_STR);

	pInfos[playerid][pRegisterDate] = gettime();
	pInfos[playerid][pAdminRank] = 0;
	orm_insert(pInfos[playerid][pOrmID]);
	return 1;
}

// ----------------------------------------------------------------------------

forward StartPlayerRegistration(playerid);
public StartPlayerRegistration(playerid)
{
	
	pRegist[playerid][fEmail] = CreatePlayerField(playerid, 250, 150, "EMail", "Adresse email");
	ShowPlayerField(playerid, pRegist[playerid][fEmail]);

	pRegist[playerid][fPass] = CreatePlayerField(playerid, 250, 200, "Mot de passe", "...");
	SetFieldDefaultBehavior(playerid, pRegist[playerid][fPass], false);
	ShowPlayerField(playerid, pRegist[playerid][fPass]);

	pRegist[playerid][fPassConfirm] = CreatePlayerField(playerid, 250, 250, "Confirmation", "...");
	SetFieldDefaultBehavior(playerid, pRegist[playerid][fPassConfirm], false);
	ShowPlayerField(playerid, pRegist[playerid][fPassConfirm]);

	pRegist[playerid][bQuit] = CreatePlayerButton(playerid,320+BUTTON_DEFAULT_WIDTH/2+10, 300, "Quitter");
	ShowPlayerButton(playerid, pRegist[playerid][bQuit]);

	pRegist[playerid][bAccept] = CreatePlayerButton(playerid,320-BUTTON_DEFAULT_WIDTH/2-10, 300, "S'inscrire");
	ShowPlayerButton(playerid, pRegist[playerid][bAccept]);

	pRegist[playerid][tbAvert] = CreatePlayerTextbox(playerid, 320, 80, " ", .textColor=0xBB0000FF);

	pRegist[playerid][bBckGrd] = CreatePlayerBackground(playerid, \
		GetButtonGlobalPosX(playerid, pRegist[playerid][bAccept])-GetButtonWidth(playerid, pRegist[playerid][bAccept])/2-10, 130, \
		GetButtonGlobalPosX(playerid, pRegist[playerid][bQuit])+GetButtonWidth(playerid, pRegist[playerid][bQuit])/2+10, \
		GetButtonGlobalPosY(playerid, pRegist[playerid][bAccept])+GetButtonHeight(playerid, pRegist[playerid][bAccept])+10, 0x10101030);

	ShowPlayerBackground(playerid, pRegist[playerid][bBckGrd]);

	SelectTextDraw(playerid, 0x00FF00FF);

	pRegist[playerid][inRegistration] = true;

	return 1;
}

// ----------------------------------------------------------------------------

stock DestroyRegistrationTD(playerid)
{
	DestroyPlayerField(playerid, pRegist[playerid][fEmail]);
	DestroyPlayerField(playerid, pRegist[playerid][fPass]);
	DestroyPlayerField(playerid, pRegist[playerid][fPassConfirm]);

	DestroyPlayerButton(playerid, pRegist[playerid][bAccept]);
	DestroyPlayerButton(playerid, pRegist[playerid][bQuit]);

	DestroyPlayerTextbox(playerid, pRegist[playerid][tbAvert]);
	DestroyPlayerBackground(playerid, pRegist[playerid][bBckGrd]);
}

// ----------------------------------------------------------------------------

hook OnPlayerFieldResponse(playerid, fieldid, inputtext[])
{
	if(pRegist[playerid][inRegistration])
	{
		if(fieldid == pRegist[playerid][fEmail])
		{
			if(IsValidEmailEx(inputtext))
			{
				strdel(pRegist[playerid][tmpEmail], 0, LONG_STR);
				strins(pRegist[playerid][tmpEmail], inputtext, 0, LONG_STR);
				HidePlayerTextbox(playerid, pRegist[playerid][tbAvert]);
			}
			else
			{
				ChangeTextboxString(playerid, pRegist[playerid][tbAvert], convert_encoding("Votre email n'est pas valide !"));
			}
		}

		if(fieldid == pRegist[playerid][fPass])
		{
			new tmpstr[NORMAL_STR];
			for(new i=0; i<strlen(inputtext); ++i)
				tmpstr[i] = 'X';

			if(strlen(inputtext) < MIN_PLAYER_PASS)
			{
				new str[64];
				format(str, sizeof(str), "Votre mot de passe est trop petit (minimum %i caractères) !", MIN_PLAYER_PASS);
				ChangeTextboxString(playerid, pRegist[playerid][tbAvert], convert_encoding(str));
			}
			else if(strlen(inputtext) > MAX_PLAYER_PASS)
			{
				new str[64];
				format(str, sizeof(str), "Votre mot de passe est trop grand (minimum %i caractères) !", MAX_PLAYER_PASS);
				ChangeTextboxString(playerid, pRegist[playerid][tbAvert], convert_encoding(str));
			}
			else
			{
				strdel(pRegist[playerid][tmpPass], 0, MAX_PLAYER_PASS);
				strins(pRegist[playerid][tmpPass], inputtext, 0, MAX_PLAYER_PASS+1);
				HidePlayerTextbox(playerid, pRegist[playerid][tbAvert]);
			}
			UpdateFieldName(playerid, fieldid, tmpstr);
			return 1;
		}
		if(fieldid == pRegist[playerid][fPassConfirm])
		{
			new tmpstr[NORMAL_STR];
			for(new i=0; i<strlen(inputtext); ++i)
				tmpstr[i] = 'X';

			UpdateFieldName(playerid, fieldid, tmpstr);
			if(strlen(inputtext) == 0)
			{
				tmpstr[0] = ' ';
			}
			strdel(pRegist[playerid][tmpPassConfirm], 0, MAX_PLAYER_PASS);
			strins(pRegist[playerid][tmpPassConfirm], tmpstr, 0, MAX_PLAYER_PASS+1);
			
			return 1;
		}
	}

	return 1;
}

hook OnPlayerClickButton(playerid, buttonID)
{
	if(pRegist[playerid][inRegistration])
	{
		if(buttonID == pRegist[playerid][bAccept])
		{
			if(!strcmp(pRegist[playerid][tmpPassConfirm], pRegist[playerid][tmpPass], false) || strlen(pRegist[playerid][tmpPass]) == 0)
			{
				ChangeTextboxString(playerid, pRegist[playerid][tbAvert], convert_encoding("Les deux mots de passe ne sont pas les mêmes !"));
				return 1;
			}
			else if(!IsValidEmailEx(pRegist[playerid][tmpEmail]) || strlen(pRegist[playerid][tmpEmail]) == 0)
			{
				ChangeTextboxString(playerid, pRegist[playerid][tbAvert], convert_encoding("Votre email n'est pas valide !"));
				return 1;
			}
			else
			{
				ChangeTextboxColor(playerid, pRegist[playerid][tbAvert], 0x00BB00FF);
				ChangeTextboxString(playerid, pRegist[playerid][tbAvert], convert_encoding("Votre inscription est en cours !"));

				DestroyRegistrationTD(playerid);

				RegisterPlayer(playerid);
				pRegist[playerid][inRegistration] = false;
				return 1;
			}
		}
		if(buttonID == pRegist[playerid][bQuit])
		{
			pRegist[playerid][inRegistration] = false;
			DestroyRegistrationTD(playerid);
			KickEx(playerid);
		}
	}
	return 1;
}

// ----------------------------------------------------------------------------

// Here, we stop some people trying to do some horrible stuff :o

hook OnPlayerRequestSpawn(playerid)
{
	if(pRegist[playerid][inRegistration])
	{
		return 0;
	}
	return 1;
}

hook OnPlayerSpawn(playerid)
{
	if(pRegist[playerid][inRegistration])
	{
		ChangeTextboxString(playerid, pRegist[playerid][tbAvert], convert_encoding("Le by-pass c'est mal ! Bouhou !"));
		KickEx(playerid);
	}
	return 1;
}

hook OnPlayerDeath(playerid)
{
	if(pRegist[playerid][inRegistration])
	{
		ChangeTextboxString(playerid, pRegist[playerid][tbAvert], convert_encoding("Le by-pass c'est mal ! Bouhou !"));
		KickEx(playerid);
	}
	return 1;
}

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(pRegist[playerid][inRegistration])
	{
		ChangeTextboxString(playerid, pRegist[playerid][tbAvert], convert_encoding("Le by-pass c'est mal ! Bouhou !"));
		KickEx(playerid);
	}
	return 1;
}

hook OnPlayerText(playerid, text[])
{
	if(pRegist[playerid][inRegistration])
	{
		return 0;
	}
	return 1;
}

hook OnPlayerCommandText(playerid, cmdtext[])
{
	if(pRegist[playerid][inRegistration])
	{
		return 1;
	}
	return 0;
}