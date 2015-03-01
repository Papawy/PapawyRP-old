#if defined PLAYERS_VARS_INCLUDED
	#endinput
#endif

#define PLAYERS_VARS_INCLUDED

// ----------------------------------------------------------------------------

#include "core.pwn"

// ----------------------------------------------------------------------------

#include <YSI4\YSI_Coding\y_hooks>

// ----------------------------------------------------------------------------

forward LoadPlayerData(playerid);
public LoadPlayerData(playerid)
{
	#if defined USE_MYSQL

	#else


	
	#endif

	/*
	new tag;
	for(new i = 0; P_INFOS:i < P_INFOS; i++)
	{
		tag = tagof(pInfos[playerid][i]);
		// Now we should do loading
		if(tag== tagof(Float:))
		{
			// Float
		}
		else if(tag == tagof(bool:))
		{
			// Bool
		}
		else
		{
			if(sizeof(pInfos[playerid][i]) > 1)
			{
				// String
			}
			else
			{
				// Int ?
			}
		}
	}*/
}

forward SavePlayerData(playerid);
public SavePlayerData(playerid)
{
	if(IsPlayerRegistered(playerid))
	{
		#if defined USE_MYSQL

		#else

		new INI:pIni = INI_Open(GetPlayerDataPath(playerid));

		INI_Close(pIni);

		#endif
		/*
		for(new i; P_INFOS:i < P_INFOS; i++)
		{
			// Now we should do loading
			if(tagof(pInfos[playerid][P_INFOS:i]) == tagof(Float:))
			{
				// Float
			}
			else if(tagof(pInfos[playerid][P_INFOS:i]) == tagof(bool:))
			{
				// Bool
			}
			else
			{
				if(sizeof(pInfos[playerid][P_INFOS:i]) > 1)
				{
					// String
				}
				else
				{
					// Int ?
				}
			}
		}*/
	}
}