/*
	PapawyRP - installation

		writen by Papawy

	This GameMode create MySQL table and config files directly In Game !
*/

#define PAPAWYRP_INSTALLER_VERSION "1.0"

#include <a_samp>

#include <YSI4\YSI_Storage\y_ini>

#include <a_mysql>

#include <easyDialog>

#define COLOR_IMPORTANT "{FF0000}"
#define COLOR_WHITE		"{FFFFFF}"

enum SQL_INFOS {
	handle,
	address[16],
	user[32],
	pass[32],
	name[32]
}

new sqlInfos[SQL_INFOS];

public OnGameModeInit()
{

	print("============================================\r\n\r\n");
	print("	PapawyRP Installer by Papawy | V."PAPAWYRP_INSTALLER_VERSION"\r\n\r\n");
	print("============================================");

	SendRconCommand("hostname PapawyRP Installation");

	SendRconCommand("mapname There is no map here");

	SendRconCommand("weburl http://www.404.fr");

	SendRconCommand("gamemodetext Installer V."PAPAWYRP_INSTALLER_VERSION);
	return 1;
}

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
	Dialog_Show(playerid, Inst_DB_Name, DIALOG_STYLE_INPUT, COLOR_IMPORTANT"Nom de la base", convert_encoding("Ecrivez ici le nom de la base de donnée."), "Confirmer", "");
	return 1;
}

Dialog:Inst_DB_Name(playerid, response, listitem, inputtext[])
{
	strins(sqlInfos[name], inputtext, 0);

	sqlInfos[handle] = mysql_connect(sqlInfos[address], sqlInfos[user], sqlInfos[name], sqlInfos[pass], .port = 3306, .autoreconnect = true);

	if(mysql_errno(sqlInfos[handle]) != 0)
	{
		Dialog_Show(playerid, Inst_DB_Address, DIALOG_STYLE_INPUT, COLOR_IMPORTANT"Adresse de la base", convert_encoding(COLOR_IMPORTANT"Impossible de se connecter à la base de donnée !\r\n" \
			"Ecrivez ici l'adresse de votre base SQL."), "Confirmer", "");
	}
	else
	{
		if(!fexist("papawyrp_cfg.ini"))
		{
			fcreate("papawyrp_cfg.ini");
		}
		new INI:cfg = INI_Open("papawyrp_cfg.ini");
		INI_WriteString(cfg, "DB_ADDESS", sqlInfos[address]);
		INI_WriteString(cfg, "DB_USER", sqlInfos[user]);
		INI_WriteString(cfg, "DB_PASS", sqlInfos[pass]);
		INI_WriteString(cfg, "DB_NAME", sqlInfos[name]);
		INI_WriteString(cfg, "TBL_PLAYER", "playersData");
		INI_WriteString(cfg, "TBL_SERVER", "serverData");
		INI_Close(cfg);

		SendClientMessageToAll(-1, convert_encoding("Veuillez patienter pendant que l'assistant crée les tables appropriées."));
		SendClientMessageToAll(-1, convert_encoding("Création de la table serveur..."));
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
	new errCode = mysql_errno(sqlInfos[handle]);
	if(errCode != 0)
	{
		SendClientMessageToAll(-1, convert_encoding(COLOR_IMPORTANT"Création de la base SQL stoppée !"));
		new str[128];
		format(str, sizeof(str), "Une "COLOR_IMPORTANT"erreur (code : %i)"COLOR_WHITE" est survenue lors de la création de la table Serveur.", errCode);
		SendClientMessageToAll(-1, convert_encoding(str));
		SendClientMessageToAll(-1, convert_encoding("Le compte SQL que vous utilisez a-t-il les privilèges suffisant ?"));
	}
	else
	{
		SendClientMessageToAll(-1, convert_encoding("Création de la table serveur réussie !"));
		new query[256] = "INSERT INTO serverData " \
		 	"( GM_Id, GM_Name, GM_Website, GM_Map, GM_Mode, MaxPlayersConnected, MaxPlayersRegistered) VALUES "\
		 	"( '1', 'PapawyRP', 'http://www.404.fr', 'Mapping-pong', 'PapawyRP V.', '0', '0' )";

		mysql_tquery(sqlInfos[handle], query, "FillServerData");
	}
	return 1;
}

forward FillServerData();
public FillServerData()
{
	new errCode = mysql_errno(sqlInfos[handle]);
	if(errCode != 0)
	{
		SendClientMessageToAll(-1, convert_encoding(COLOR_IMPORTANT"Création de la base SQL stoppée !"));
		new str[128];
		format(str, sizeof(str), "Une "COLOR_IMPORTANT"erreur (code : %i)"COLOR_WHITE" est survenue lors de la création de la table Joueurs.", errCode);
		SendClientMessageToAll(-1, convert_encoding(str));
		SendClientMessageToAll(-1, convert_encoding("Le compte SQL que vous utilisez a-t-il les privilèges suffisant ?"));
	}
	else
	{
		SendClientMessageToAll(-1, convert_encoding("Valeurs par défaut de la table serveur attribuées !"));
		new query[256] = "CREATE TABLE playersData ("\
		 	"ID INT PRIMARY KEY NOT NULL," \
		 	"Name VARCHAR(100)," \
			"Pass VARCHAR(100)," \
			"Email VARCHAR(255)," \
			"RegisterDate TIMESTAMP," \
			"AdminRank INT )";
		mysql_tquery(sqlInfos[handle], query, "OnPlayersTableCreated");
	}
}	

forward OnPlayersTableCreated();
public OnPlayersTableCreated()
{
	new errCode = mysql_errno(sqlInfos[handle]);
	if(errCode != 0)
	{
		SendClientMessageToAll(-1, convert_encoding(COLOR_IMPORTANT"Création de la base SQL stoppée !"));
		new str[128];
		format(str, sizeof(str), "Une "COLOR_IMPORTANT"erreur (code : %i)"COLOR_WHITE" est survenue lors de la création de la table Joueurs.", errCode);
		SendClientMessageToAll(-1, convert_encoding(str));
		SendClientMessageToAll(-1, convert_encoding("Le compte SQL que vous utilisez a-t-il les privilèges suffisant ?"));
	}
	else
	{
		/*
		new query[256] = "CREATE TABLE playersData ("\
		 	"ID INT PRIMARY KEY NOT NULL," \
		 	"Name VARCHAR(100)," \
			"Pass VARCHAR(100)," \
			"Email VARCHAR(255)," \
			"RegisterData TIMESTAMP," \
			"AdminRank INT )";
		mysql_tquery(sqlInfos[handle], query, "OnPlayersTableCreated");*/

		SendClientMessageToAll(-1, convert_encoding("L'installation s'est terminée avec succès !"));
	}
}

stock fcreate(filename[])
{
    if (fexist(filename)){return false;}
    new File:fhandle = fopen(filename,io_write);
    fclose(fhandle);
    return true;
}


// Thanks to mooman
stock convert_encoding(string[])
{
	new tmpstr[256];
	strins(tmpstr, string, 0);
	new original[50] = {192,193,194,196,198,199,200,201,202,203,204,205,206,207,210,211,212,214,217,218,219,220,223,224,225,226,228,230,231,232,233,234,235,236,237,238,239,242,243,244,246,249,250,251,252,209,241,191,161,176};
	new fixed[50] = {128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,94,124};
	new len = strlen(string);
	for (new i; i < len; i++) {
		for(new j;j < 50;j++) {
			if(tmpstr[i] == original[j]) {
				tmpstr[i] = fixed[j];
				break;
			}
		}
	}
	return tmpstr;
}