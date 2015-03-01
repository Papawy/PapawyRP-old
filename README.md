# PapawyRP
A gamemode for SA:MP.

Originaly made by Papawy.

## Gamemode architecture :

		+ core < include all necessary files
		
		- Utils
			+ utils_functions < usefull functions (SendClientMessageEx, GetPlayerNameEx, etc.)
		
		- MySQL : only included if mysql was used
			+ mysql_infos
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

## Compiling

To compile this gamemode you need this includes :
+ YSI4 (beta) by Y_Less : [Link](https://github.com/Y-Less/YSI-Includes/tree/YSI.tl)
+ easyDialog by Emmet- 	: [Link](http://forum.sa-mp.com/showthread.php?t=475838)
+ For MySQL use : BlueG plugin : [Link](http://forum.sa-mp.com/showthread.php?t=56564)

   And put define "USE_MYSQL" on the top of the main file (papawyrp.pwn)
+ Thanks to DracoBlue for his "hash" functions (included in utils_functions).