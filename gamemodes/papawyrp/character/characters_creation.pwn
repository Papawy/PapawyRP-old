#if !defined CHARACTERS_CREATION_INCLUDED
	#define CHARACTERS_CREATION_INCLUDED
#endif

// ----------------------------------------------------------------------------

#include <YSI4\YSI_Coding\y_hooks>

// ----------------------------------------------------------------------------

#include "core.pwn"

// ----------------------------------------------------------------------------

enum C_CREATION {
	fName,
	fAge,
	cbMen,
	cbWomen,
	fSkin,
	tbAdvert,
	bAccept,
	bQuit,
	bBckGrd,
	// --
	cName[MAX_PLAYER_NAME+1],
	cAge,
	cSex,
	cSkin,
	// --
	bool:inCharCreation
};

new cCreation[MAX_PLAYERS][C_CREATION];

// ----------------------------------------------------------------------------

stock CreateCharacterForPlayer(playerid)
{
	new cID = pInfos[playerid][pCharacterTmpID] = CreateNewCharacterInDataBase(playerid);
	strdel(cInfos[cID][cName], 0, MAX_PLAYER_NAME+1);
	strins(cInfos[cID][cName], cCreation[playerid][cName], 0, MAX_PLAYER_NAME);
	cInfos[cID][cAge] 	= cCreation[playerid][cAge];
	cInfos[cID][cSex] 	= cCreation[playerid][cSex];
	cInfos[cID][cSkin] 	= cCreation[playerid][cSkin];

	SaveCharacterData(cID);
	return 1;
}

// ----------------------------------------------------------------------------

forward StartCharacterCreation(playerid);
public StartCharacterCreation(playerid)
{
	/*
		IN CONSTRUCTION
	*/
/*
	new tmpStr[SHORT_STR];

	cCreation[playerid][fName] = CreatePlayerField(playerid, 250, 100, "Nom", "RP : Jean_Dupont");
	ShowPlayerField(playerid, cCreation[playerid][fName]);

	format(tmpStr, SHORT_STR, "Entre %i et %i", MIN_AGE, MAX_AGE);
	cCreation[playerid][fAge] = CreatePlayerField(playerid, 250, 150, "Age", tmpStr);
	ShowPlayerField(playerid, cCreation[playerid][fAge]);

	cCreation[playerid][fPassConfirm] = CreatePlayerField(playerid, 250, 250, "Confirmation", "...");
	ShowPlayerField(playerid, cCreation[playerid][fPassConfirm]);

	cCreation[playerid][bQuit] = CreatePlayerButton(playerid,320+BUTTON_DEFAULT_WIDTH/2+10, 300, "Quitter");
	ShowPlayerButton(playerid, cCreation[playerid][bQuit]);

	cCreation[playerid][bAccept] = CreatePlayerButton(playerid,320-BUTTON_DEFAULT_WIDTH/2-10, 300, "Créer le personnage");
	ShowPlayerButton(playerid, cCreation[playerid][bAccept]);

	cCreation[playerid][tbAvert] = CreatePlayerTextbox(playerid, 320, 80, " ", .textColor=0xBB0000FF);

	cCreation[playerid][bBckGrd] = CreatePlayerBackground(playerid, \
		GetButtonGlobalPosX(playerid, cCreation[playerid][bAccept])-GetButtonWidth(playerid, cCreation[playerid][bAccept])/2-10, 130, \
		GetButtonGlobalPosX(playerid, cCreation[playerid][bQuit])+GetButtonWidth(playerid, cCreation[playerid][bQuit])/2+10, \
		GetButtonGlobalPosY(playerid, cCreation[playerid][bAccept])+GetButtonHeight(playerid, cCreation[playerid][bAccept])+10, 0x10101030);

	ShowPlayerBackground(playerid, cCreation[playerid][bBckGrd]);

	SelectTextDraw(playerid, 0x00FF00FF);

	cCreation[playerid][inRegistration] = true;*/
	cCreation[playerid][cbMen] = CreatePlayerCheckBox(playerid, 200, 200, "Homme");
	ShowPlayerCheckBox(playerid, cCreation[playerid][cbMen]);

	cCreation[playerid][cbWomen] = CreatePlayerCheckBox(playerid, 200, 250, "Femme");
	ShowPlayerCheckBox(playerid, cCreation[playerid][cbWomen]);

	printf("cbMen (%i) | cbWomen (%i)", cCreation[playerid][cbMen], cCreation[playerid][cbWomen]);

	SelectTextDraw(playerid, 0x00FF00FF);

	cCreation[playerid][inCharCreation] = true;
}

// ----------------------------------------------------------------------------

hook OnPlayerClickCheckBox(playerid, checkBoxID, bool:checkedStatus)
{
	if(cCreation[playerid][inCharCreation])
	{
		if((checkBoxID == cCreation[playerid][cbMen]) && (checkedStatus == true))
		{
			SetCheckBoxStatus(playerid, cCreation[playerid][cbWomen], false);
		}
		else if((checkBoxID == cCreation[playerid][cbWomen]) && (checkedStatus == true))
		{
			SetCheckBoxStatus(playerid, cCreation[playerid][cbMen], false);
		}
	}
}