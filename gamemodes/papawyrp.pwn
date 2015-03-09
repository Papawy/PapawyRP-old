/*
	Papawy Role Play

				script made by Papawy

	Gamemode architecture :

	papawyrp
		+ core < include all necessary files
		
		- Utils
			+ utils_functions < usefull functions (SendClientMessageEx, GetPlayerNameEx, etc.)
		
		- GUI
			+ gui_fields < user can type text in, and you get the text back like a Dialog
			+ gui_buttons < simple textdraw buttons !
			+ gui_backgrounds < simple backgrounds

		- MySQL
			+ mysql_infos < mysql informations & vars
			+ mysql_init < initialise mysql connection

		- Server infos
			+ server_infos < server infos (players connected, etc) AND loading configuration & data files

		- Player Infos
			+ players_vars < standardize players information backups
			+ players_infos < enumeration of infos for each player
			+ players_connection < obvious
			+ players_registration < obvious

		- Commands
			+ commands_config < configuration (color, format, etc.)
			+ commands_functions < functions used in commands
			+ commands_generals < help, etc.
			+ commands_tchat < all tchat commands (tchat IC, OOC, /me, /do, etc.)

*/

#include "papawyrp\core.pwn"


main()
{
	print("\r\n-------------------------------------------\r\n");
	print("\r\nPapawy RolePlay\r\n");
	print("\r\n-------------------------------------------\r\n");
	print(" - originally made by Papawy\r\n");
	print(" - Current Version : "PAPAWYRP_VERSION"\r\n");
	return 1;
}
