#if defined PLAYERS_VARS_INCLUDED
	#endinput
#endif

#define PLAYERS_VARS_INCLUDED

// ----------------------------------------------------------------------------

#include "core.pwn"

// ----------------------------------------------------------------------------

#include <YSI4\YSI_Coding\y_hooks>

// ----------------------------------------------------------------------------

#if defined USE_MYSQL
/*
forward BeginLoading(pUID)

forward GetPlayerVar_Int(pUID, key[], &var);



public GetPlayerVar_Int(pUID, key[], &var)
{

}*/

#endif

forward LoadPlayerData(playerid);
public LoadPlayerData(playerid)
{
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
	}
}

forward SavePlayerDate(playerid);
public SavePlayerDate(playerid)
{
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
	}
}