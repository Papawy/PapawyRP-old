/*
	Papawy Role Play

				script made by Papawy

	Gamemode architecture :

	papawyrp
		+ core < include all necessary files
		
		- Utils
			//+ utils < all usefull functions
			+ colors < color standardization
		
		- MySQL : only included if mysql was used
			+ mysql_infos
			+ mysql_init < initialise mysql connection

		- Server infos
			+ server_infos < server configuration

		- Player Infos
			+ players_vars < sstandardize players information backups
			+ players_infos < enumeration of infos for each player

		- Commands
			+ commands_generals < help, etc.
			+ commands_tchat < all tchat commands (tchat IC, OOC, /me, /do, etc.)

*/


#include "papawyrp\core.pwn"

main()
{
	print("Papawy RolePlay\r\n");
	print("-------------------------------------------\r\n");
	print(" - originally made by Papawy\r\n");
	print(" - Current Version : "LILSRP_VERSION"\r\n");

}