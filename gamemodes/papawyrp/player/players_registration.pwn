#if !defined PLAYERS_REGISTRATION_INCLUDED
	#define PLAYERS_REGISTRATION_INCLUDED
#endif

// ----------------------------------------------------------------------------


// ----------------------------------------------------------------------------

#include "core.pwn"

// ----------------------------------------------------------------------------

#define COLOR_IMPORTANT						INDIANRED1

// ----------------------------------------------------------------------------

#define REGISTRATION_BEGINING 				RegistrationBegining(playerid)
#define REGISTRATION_TERMS 					RegistrationTerms()
#define REGISTRATION_PASSWORD 				RegistrationPassword()
#define REGISTRATION_PASSWORD_FAILED(%0) 	RegistrationPasswordFailed(%0)
#define REGISTRATION_PSWRD_CONFIRM			RegistrationPasswordConfirm()
#define REGISTRATION_PWD_CONF_FAILED(%0)	RegistrationPswrdConfirmFailed(%0)
#define REGISTRATION_END 					RegistrationEnd(playerid)

// ----------------------------------------------------------------------------

forward RegisterPlayer(playerid);
public RegisterPlayer(playerid)
{
	Dialog_Show(playerid, Registration_Begining, DIALOG_STYLE_MSGBOX, COLOR_IMPORTANT"Inscription", REGISTRATION_BEGINING, "Commencer", "Quitter");
	return 1;
}

Dialog:Registration_Begining(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		Dialog_Show(playerid, Registration_Terms, DIALOG_STYLE_MSGBOX, COLOR_IMPORTANT"Conditions", REGISTRATION_TERMS, "Accepter", "Retour");
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
		Dialog_Show(playerid, Registration_Password, DIALOG_STYLE_PASSWORD , COLOR_IMPORTANT"Mot de passe", REGISTRATION_PASSWORD, "Confirmer", "Retour");
	}
	else
	{
		Dialog_Show(playerid, Registration_Begining, DIALOG_STYLE_MSGBOX, COLOR_IMPORTANT"Inscription", REGISTRATION_BEGINING, "Commencer", "Quitter");
	}
	return 1;
}

Dialog:Registration_Password(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		if(strlen(inputtext) < MIN_PLAYER_PASS)
			Dialog_Show(playerid, Registration_Password, DIALOG_STYLE_PASSWORD, COLOR_IMPORTANT"Mot de passe", REGISTRATION_PASSWORD_FAILED(0), "Confirmer", "Retour");
		else if(strlen(inputtext) > MAX_PLAYER_PASS)
			Dialog_Show(playerid, Registration_Password, DIALOG_STYLE_PASSWORD, COLOR_IMPORTANT"Mot de passe", REGISTRATION_PASSWORD_FAILED(1), "Confirmer", "Retour");
		else
		{
			strdel(pInfos[playerid][pPass], 0, MAX_PLAYER_PASS);
			strins(pInfos[playerid][pPass], inputtext, 0, MAX_PLAYER_PASS);
			Dialog_Show(playerid, Registration_Pwd_Confirm, DIALOG_STYLE_PASSWORD, COLOR_IMPORTANT"Confirmation", REGISTRATION_PSWRD_CONFIRM, "Confirmer", "Retour");
		}
	}
	else
	{
		Dialog_Show(playerid, Registration_Terms, DIALOG_STYLE_MSGBOX, COLOR_IMPORTANT"Conditions", REGISTRATION_TERMS, "Accepter", "Retour");
	}
	return 1;
}

Dialog:Registration_Pwd_Confirm(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		if(strcmp(inputtext, pInfos[playerid][pPass], false) != 0)
		{
			Dialog_Show(playerid, Registration_Pwd_Confirm, DIALOG_STYLE_PASSWORD, COLOR_IMPORTANT"Confirmation", REGISTRATION_PWD_CONF_FAILED(0), "Confirmer", "Retour");
		}
		else
		{
			Dialog_Show(playerid, Registration_End, DIALOG_STYLE_MSGBOX, COLOR_IMPORTANT"Fin !", REGISTRATION_END, "Go !", "Quitter");
		}
	}
	else
	{
		Dialog_Show(playerid, Registration_Password, DIALOG_STYLE_PASSWORD , COLOR_IMPORTANT"Mot de passe", REGISTRATION_PASSWORD, "Confirmer", "Retour");
	}
	return 1;
}

Dialog:Registration_End(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		pInfos[playerid][pRegistered] = true;
	}
	else
	{
		KickEx(playerid);
	}
	return 1;
}

// ----------------------------------------------------------------------------

stock RegistrationBegining(playerid)
{
	new inscription_msg[LONG_STR];
	format(inscription_msg, sizeof(inscription_msg), \
		WHITE"Vous allez maintenant commencer l'"COLOR_IMPORTANT"inscription"WHITE" %s.\r\nAppuyez sur \""COLOR_IMPORTANT"Commencer"WHITE"\" pour commencer l'inscription." \
		"\r\nOu sur \""COLOR_IMPORTANT"Quitter"WHITE"\" pour quitter.", \
		GetPlayerNameEx(playerid));
	return inscription_msg;
}

stock RegistrationTerms()
{
	new reg_terms[LONG_STR]; 
	format(reg_terms, sizeof(reg_terms),\
		WHITE"En cliquant sur le bouton \""COLOR_IMPORTANT"Accepter"WHITE"\" ci dessous\r\nvous acceptez les conditions d'inscriptions disponibles à l'adresse suivante :" \
		"\r\n"COLOR_IMPORTANT"%s", SERVER_WEBSITE);
	return reg_terms;
}

stock RegistrationPassword()
{
	new password_msg[LONG_STR];
	format(password_msg, sizeof(password_msg), \
		WHITE"Veuillez écrire un "COLOR_IMPORTANT"mot de passe"WHITE" (maximum "COLOR_IMPORTANT"%i"WHITE" caractères)." \
			"\r\nVotre \""COLOR_IMPORTANT"Mot de passe"WHITE"\" doit faire au moins "COLOR_IMPORTANT"%i"WHITE" caracètres." \
			"\r\nOu sur \""COLOR_IMPORTANT"Quitter"WHITE"\" pour quitter.", MAX_PLAYER_PASS, MIN_PLAYER_PASS);
	return password_msg;

}

// reason 0 : password len <  MIN_PLAYER_PASS
// reason 1 : password len >  MAX_PLAYER_PASS
stock RegistrationPasswordFailed(reason)
{
	new password_msg[LONG_STR];
	switch(reason)
	{
		case 0:
		{
			format(password_msg, sizeof(password_msg), \
				RED"Votre mot de passe est trop court !\r\n"WHITE \
				WHITE"Veuillez écrire un "COLOR_IMPORTANT"mot de passe"WHITE" (maximum "COLOR_IMPORTANT"%i"WHITE" caractères)." \
				"\r\nVotre \""COLOR_IMPORTANT"Mot de passe"WHITE"\" doit faire au moins "COLOR_IMPORTANT"%i"WHITE" caracètres." \
				"\r\nOu sur \""COLOR_IMPORTANT"Quitter"WHITE"\" pour quitter.", MAX_PLAYER_PASS, MIN_PLAYER_PASS);
		}
		case 1:
		{
			format(password_msg, sizeof(password_msg), \
				RED"Votre mot de passe est trop long !\r\n"WHITE \
				WHITE"Veuillez écrire un "COLOR_IMPORTANT"mot de passe"WHITE" (maximum "COLOR_IMPORTANT"%i"WHITE" caractères)." \
				"\r\nVotre \""COLOR_IMPORTANT"Mot de passe"WHITE"\" doit faire au moins "COLOR_IMPORTANT"%i"WHITE" caracètres." \
				"\r\nOu sur \""COLOR_IMPORTANT"Quitter"WHITE"\" pour quitter.", MAX_PLAYER_PASS, MIN_PLAYER_PASS);
		}
	}
	return password_msg;

}

stock RegistrationPasswordConfirm()
{
	new confirm_msg[LONG_STR];
	strins(confirm_msg, WHITE"Veuillez réécrire votre "COLOR_IMPORTANT"mot de passe"WHITE"." \
			"\r\nSi vous avez un doute cliquez sur \""COLOR_IMPORTANT"Retour"WHITE"\" pour retaper votre mot de passe.", 0);
	return confirm_msg;
}

// reason 0 : password do not match
stock RegistrationPswrdConfirmFailed(reason)
{
	new confirm_msg[LONG_STR];
	switch(reason)
	{
		case 0:
		{
			strins(confirm_msg, \
				RED"Ce que vous avez entrer ne correspond pas au mot de passe précédent !\r\n"WHITE \
				WHITE"Veuillez réécrire votre "COLOR_IMPORTANT"mot de passe"WHITE".\r\n" \
				"\r\nVeuillez réécrire votre "COLOR_IMPORTANT"mot de passe"WHITE" pour continuer.", 0);
		}
	}
	return confirm_msg;
}

stock RegistrationEnd(playerid)
{
	new end_msg[LONG_STR];
	format(end_msg, sizeof(end_msg), \
		WHITE"Vous allez maintenant commencer votre "COLOR_IMPORTANT"aventure"WHITE" sur "COLOR_IMPORTANT"%s"WHITE" %s.\r\nAppuyez sur \""COLOR_IMPORTANT"Go !"WHITE"\" pour commencer votre personnage." \
		"\r\nOu sur \""COLOR_IMPORTANT"Quitter"WHITE"\" pour quitter.", \
		SERVER_NAME, GetPlayerNameEx(playerid));
	return end_msg;
}