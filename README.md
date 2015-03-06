# PapawyRP
A gamemode for SA:MP.

Originaly made by Papawy.

## Gamemode architecture :

		+ core < include all necessary files
		
		- Utils
			+ utils_functions < usefull functions (SendClientMessageEx, GetPlayerNameEx, etc.)
		
		- GUI
			+ gui_fields < user can type text in, and you get the text back like a Dialog

		- MySQL :
			+ mysql_infos < mysql informations & vars
			+ mysql_init < initialise mysql connection

		- Server infos
			+ server_infos < server infos (players connected, etc) AND loading configuration & data files

		- Player Infos
			+ players_vars < standardize players information backups
			+ players_infos < per player enum' and basic checks functions (registered ? connected ?)
			+ players_connection < obvious
			+ players_registration < obvious

		- Commands
			+ commands_config < configuration (color, format, etc.)
			+ commands_functions < functions used in commands
			+ commands_generals < help, etc.
			+ commands_tchat < all tchat commands (tchat IC, OOC, /me, /do, etc.)
			
		- Gui
			+ gui_fields < gui element to request a name from the user or an email, etc.

## Compiling

To compile this gamemode you need this includes :
+ YSI4 (beta) by Y_Less : [Link](https://github.com/Y-Less/YSI-Includes/tree/YSI.tl)
+ easyDialog by Emmet- 	: [Link](http://forum.sa-mp.com/showthread.php?t=475838)
+ BlueG MySQL plugin : [Link](http://forum.sa-mp.com/showthread.php?t=56564)
+ Whirlpool by Y_Less : [Link](http://forum.sa-mp.com/showthread.php?t=65290)
+ Thanks to DracoBlue for his "hash" functions (included in utils_functions). // not used at this time, must remove it !
