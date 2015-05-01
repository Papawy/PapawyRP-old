#if !defined CHARACTERS_ID_MANAGER_INCLUDED
	#define CHARACTERS_ID_MANAGER_INCLUDED
#endif

// ----------------------------------------------------------------------------

#include <YSI4\YSI_Coding\y_hooks>

// ----------------------------------------------------------------------------

#include "core.pwn"

// ----------------------------------------------------------------------------

stock GetAvaibleCharacterID()
{
	for(new i=0; i<MAX_CHARACTERS; i++)
	{
		if(cInfos[i][cCreated] == false)
		{
			return i;
		}
	}
	return -1;
}

stock GetLastCharacterIDUsed()
{
	new max = 0;
	for(new i=0; i<MAX_CHARACTERS; i++)
	{
		if(cInfos[i][cCreated] == true)
		{
			max = i;
		}
	}
	return i;	
}