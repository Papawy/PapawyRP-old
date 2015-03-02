/*
	PapawyRP - installation

		writen by Papawy

	This GameMode create MySQL table and config files directly In Game !
*/

#include <a_samp>

#include <a_mysql>

#include <easyDialog>

#define COLOR_IMPORTANT "{FF0000}"

enum SQL_INFOS {
	handle,
	address[16],
	user[32],
	pass[32],
	name[32]
}

new sqlInfos[SQL_INFOS];

public OnPlayerConnect(playerid)
{
	Dialog_Show(playerid, Inst_DB_Address, DIALOG_STYLE_INPUT, COLOR_IMPORTANT"Adresse de la base", "Ecrivez ici l'adresse de votre base SQL.", "Confirmer", "");
}

Dialog:Inst_DB_Address(playerid, response, listitem, inputtext[])
{
	strins(sqlInfos[address], inputtext, 0);
	Dialog_Show(playerid, Inst_DB_User, DIALOG_STYLE_INPUT, COLOR_IMPORTANT"Compte de la base", "Ecrivez ici le compte utilisateur de votre base SQL.", "Confirmer", "");
	return 1;
}

Dialog:Inst_DB_User(playerid, response, listitem, inputtext[])
{
	strins(sqlInfos[user], inputtext, 0);
	Dialog_Show(playerid, Inst_DB_Pass, DIALOG_STYLE_INPUT, COLOR_IMPORTANT"Mot de passe du compte", "Ecrivez ici le mot de passe du compte utilisateur.", "Confirmer", "");
	return 1;
}

Dialog:Inst_DB_Pass(playerid, response, listitem, inputtext[])
{
	strins(sqlInfos[pass], inputtext, 0);
	Dialog_Show(playerid, Inst_DB_Name, DIALOG_STYLE_INPUT, COLOR_IMPORTANT"Nom de la base", "Ecrivez ici le nom de la base de donnée.", "Confirmer", "");
	return 1;
}

Dialog:Inst_DB_Name(playerid, response, listitem, inputtext[])
{
	strins(sqlInfos[name], inputtext, 0);

	sqlInfos[handle] = mysql_connect(sqlInfos[address], sqlInfos[user], sqlInfos[name], sqlInfos[pass], .port = 3306, .autoreconnect = true);

	if(mysql_errno(sqlInfos[handle]) != 0)
	{
		Dialog_Show(playerid, Inst_DB_Address, DIALOG_STYLE_INPUT, COLOR_IMPORTANT"Adresse de la base", COLOR_IMPORTANT"Impossible de se connecter à la base de donnée !\r\n" \
			"Ecrivez ici l'adresse de votre base SQL.", "Confirmer", "");
	}
	else
	{
		SendClientMessage(playerid, -1, "Veuillez patienter pendant que l'assistant crée les tables appropriées.");
		CreateServerTable();
	}
	return 1;
}

forward CreateServerTable();
public CreateServerTable()
{
	new query[256] = "CREATE TABLE serverData ("\
	 	"GM_Id INT PRIMARY KEY NOT NULL," \
	 	"GM_Name VARCHAR(100)," \
		"GM_Website VARCHAR(100)," \
		"GM_Map VARCHAR(100)," \
		"GM_Mode VARCHAR(100)," \
		"MaxPlayersConnected INT," \
		"MaxPlayersRegistered INT )";
	mysql_tquery(sqlInfos[handle], query, "OnServerTableCreated");
}

forward OnServerTableCreated();
public OnServerTableCreated()
{
	// do things here	
}