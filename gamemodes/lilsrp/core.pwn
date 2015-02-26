#if defined CORE_INCLUDED
	#endinput
#endif

#define CORE_INCLUDED

#if !defined _samp_included
	#tryinclude <a_samp>
	#if !defined _samp_included
		#error could not locate a_samp.inc file, please check your server includes
	#endif
#endif

#include <YSI\y_hooks>



#if defined USE_TS3_CONNECTOR

#endif

#if defined USE_MYSQL
	#include <a_mysql>
#endif

#define MAX_PLAYER_PASS			32