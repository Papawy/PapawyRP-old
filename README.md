# PapawyRP
A gamemode for SA:MP.

Originaly made by Papawy.

Gamemode architecture :

		+ core < include all necessary files
		
		- Utils
			+ utils_functions < usefull functions (SendClientMessageEx, GetPlayerNameEx, etc.)
		
		- MySQL : only included if mysql was used
			+ mysql_infos
			+ mysql_init < initialise mysql connection

		- Server infos
			+ server_infos < server infos (players connected, etc)

		- Player Infos
			+ players_vars < standardize players information backups
			+ players_infos < enumeration of infos for each player

		- Commands
			+ commands_config < configuration (color, format, etc.)
			+ commands_generals < help, etc.
			+ commands_tchat < all tchat commands (tchat IC, OOC, /me, /do, etc.)
