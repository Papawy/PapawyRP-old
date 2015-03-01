#if !defined PLAYERS_REGISTRATION_INCLUDED
	#define PLAYERS_REGISTRATION_INCLUDED
#endif

// ----------------------------------------------------------------------------

#include <YSI4\YSI_Coding\y_hooks>

// ----------------------------------------------------------------------------

#include "core.pwn"

// ----------------------------------------------------------------------------

#define REGISTRATION_CONDITIONS RegistrationConditions()

// ----------------------------------------------------------------------------

forward RegisterPlayer(playerid);
public RegisterPlayer(playerid)
{
	Dialog_Show(playerid, Registration_Begining, DIALOG_STYLE_MSGBOX, FIREBRICK"Inscription", \
		"Vous allez maintenant commencer l'"FIREBRICK"inscription"WHITE".\r\nAppuyez sur \""FIREBRICK"Commencer\""WHITE" pour commencer l'inscription.\r\nOu sur \""FIREBRICK"Quitter\""WHITE" pour quitter", \
		"Commencer", "Quitter");
	return 1;
}

Dialog:Registration_Begining(playerid, response, listitem, inputtext[])
{
	if(response)
	{

		Dialog_Show(playerid, Registration_Terms, DIALOG_STYLE_MSGBOX, FIREBRICK"Conditions", REGISTRATION_CONDITIONS, "Accepter", "Retour");
	}
	else
	{
		KickEx(playerid);
	}
	return 1;
}

stock RegistrationConditions()
{
	new reg_terms[NORMAL_STR]; 
	format(reg_terms, sizeof(reg_terms),\
		"En cliquant sur le bouton "FIREBRICK"\"Accepter\""WHITE" ci dessous\r\nvous acceptez les conditions d'inscriptions disponibles à l'adresse suivante\r\n"FIREBRICK"%s", SERVER_WEBSITE);
	return reg_terms;
}