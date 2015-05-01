# PapawyRP
A gamemode for SA:MP.

Originaly made by Papawy.

See the roadmap [here](https://trello.com/b/9OyidcpB/papawyrp).

## Gamemode architecture :

		+ core < include all necessary files
		
		- Utils
			+ utils_functions < usefull functions (SendClientMessageEx, GetPlayerNameEx, etc.)
		
		- GUI
			+ gui_utils < usefull things for GUI (screen dimensions, etc.)
			+ gui_fields < user can type text in, and you get the text back like a Dialog
			+ gui_buttons < simple textdraw buttons !
			+ gui_backgrounds < simple backgrounds
			+ gui_textbox < text in a box, that's all !

		- MySQL :
			+ mysql_infos < mysql informations & vars
			+ mysql_init < initialise mysql connection

		- Server infos
			+ server_infos < server infos (players connected, etc) AND loading configuration & data files

		- Player
			+ players_vars < standardize players information backups
			+ players_infos < enumeration of infos for each player
			+ players_connection < obvious
			+ players_registration < obvious
			+ players_login < obvious
			+ players_disconnection < obvious
		
		- Character
			+ characters_infos < enumeration of infos for each character

		- Character
        	+ characters_infos < enumeration of infos for each character
        	+ characters_vars < load & save & create functions for each character
        	+ charaters_id_manager < manage Pawn characters IDs
        	+ characters_creation < creation of character by the player (with GUI)

		- Commands
			+ commands_config < configuration (color, format, etc.)
			+ commands_functions < functions used in commands
			+ commands_generals < help, etc.
			+ commands_tchat < all tchat commands (tchat IC, OOC, /me, /do, etc.)
			
		
## Compiling

To compile this gamemode you need this includes :
+ YSI4 (beta) by Y_Less : [Link](https://github.com/Misiur/YSI-Includes)
+ easyDialog by Emmet- 	: [Link](http://forum.sa-mp.com/showthread.php?t=475838)
+ BlueG MySQL plugin : [Link](http://forum.sa-mp.com/showthread.php?t=56564)
+ Whirlpool by Y_Less : [Link](http://forum.sa-mp.com/showthread.php?t=570945)
+ Regex Plugin by Fro1sha : [Link](http://forum.sa-mp.com/showthread.php?t=247893)
