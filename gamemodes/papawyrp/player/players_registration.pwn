#if !defined PLAYERS_REGISTRATION_INCLUDED
	#define PLAYERS_REGISTRATION_INCLUDED
#endif

// ----------------------------------------------------------------------------


// ----------------------------------------------------------------------------

#include "core.pwn"

// ----------------------------------------------------------------------------

#define REGISTRATION_BEGINING 			RegistrationBegining(playerid)
#define REGISTRATION_TERMS 				RegistrationTerms()

// ----------------------------------------------------------------------------

forward RegisterPlayer(playerid);
public RegisterPlayer(playerid)
{
	Dialog_Show(playerid, Registration_Begining, DIALOG_STYLE_MSGBOX, INDIANRED1"Inscription", REGISTRATION_BEGINING, "Commencer", "Quitter");
	return 1;
}

Dialog:Registration_Begining(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		Dialog_Show(playerid, Registration_Terms, DIALOG_STYLE_MSGBOX, INDIANRED1"Conditions", REGISTRATION_TERMS, "Accepter", "Retour");
	}
	else
	{
		KickEx(playerid);
	}
	return 1;
}

Dialog:Registration_Terms(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		Dialog_Show(playerid, Registration_Password_1, DIALOG_STYLE_INPUT , INDIANRED1"Mot de passe", "", "Confirmer", "Retour");
	}
	else
	{
		Dialog_Show(playerid, Registration_Begining, DIALOG_STYLE_MSGBOX, INDIANRED1"Inscription", REGISTRATION_BEGINING, "Commencer", "Quitter");
	}
	return 1;
}

// ----------------------------------------------------------------------------

stock RegistrationBegining(playerid)
{
	new inscription_msg[LONG_STR];
	format(inscription_msg, sizeof(inscription_msg), \
		WHITE"Vous allez maintenant commencer l'"INDIANRED1"inscription"WHITE" %s.\r\nAppuyez sur \""INDIANRED1"Commencer\""WHITE" pour commencer l'inscription.\r\nOu sur \""INDIANRED1"Quitter\""WHITE" pour quitter.", \
		GetPlayerNameEx(playerid));
	return inscription_msg;
}

stock RegistrationTerms()
{
	new reg_terms[LONG_STR]; 
	format(reg_terms, sizeof(reg_terms),\
		WHITE"En cliquant sur le bouton "INDIANRED1"\"Accepter\""WHITE" ci dessous\r\nvous acceptez les conditions d'inscriptions disponibles à l'adresse suivante :\r\n"INDIANRED1"%s", SERVER_WEBSITE);
	return reg_terms;
}