#if !defined PLAYERS_LOGIN_INCLUDED
	#define PLAYERS_LOGIN_INCLUDED
#endif

// ----------------------------------------------------------------------------

#include <YSI4\YSI_Coding\y_hooks>

// ----------------------------------------------------------------------------

#include "core.pwn"

// ----------------------------------------------------------------------------

enum P_LOGIN {
	fPass,
	tbAvert,
	bConnect,
	bQuit,
	bBckGrd,
	// --
	tmpPass[MAX_PLAYER_PASS+1],
	tmpPassConfirm[MAX_PLAYER_PASS+1],
	tmpEmail[LONG_STR],
	bool:isNotValid
}

new pLogin[MAX_PLAYERS][P_LOGIN];

// ----------------------------------------------------------------------------