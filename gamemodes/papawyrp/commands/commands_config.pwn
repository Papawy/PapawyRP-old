#if !defined COMMANDS_CONFIG_INCLUDED
	#define COMMANDS_CONFIG_INCLUDED
#endif

// ----------------------------------------------------------------------------

#include "core.pwn"

// ----------------------------------------------------------------------------

#define CMD_ACTION_RADIUS				15.0

#define CMD_ACTION_COLOR				Y_ORCHID | 0xFF

#define CMD_ACTION_COLOR_STR			ORCHID

// ----------------------------------------------------------------------------

#define HELP_HEADER						"["COLOR_HELP_STR"HELP"WHITE"] "

#define COLOR_HELP 						Y_GOLD_1 | 0xFF

#define COLOR_HELP_STR 					GOLD

// ----------------------------------------------------------------------------

#define PROX_TCHAT_COLOR_1				Y_GREY_37 | 0xFF
#define PROX_TCHAT_RADIUS_1				20.0

#define PROX_TCHAT_COLOR_2				Y_GREY_53 | 0xFF
#define PROX_TCHAT_RADIUS_2				(PROX_TCHAT_RADIUS_1/5)*4

#define PROX_TCHAT_COLOR_3				Y_GREY_69 | 0xFF
#define PROX_TCHAT_RADIUS_3				(PROX_TCHAT_RADIUS_1/5)*3

#define PROX_TCHAT_COLOR_4				Y_GREY_85 | 0xFF
#define PROX_TCHAT_RADIUS_4				(PROX_TCHAT_RADIUS_1/5)*2

#define PROX_TCHAT_COLOR_5				Y_GREY_100 | 0xFF
#define PROX_TCHAT_RADIUS_5				(PROX_TCHAT_RADIUS_1/5)

#define PROX_TCHAT_FORMAT				"%s dit : %s"