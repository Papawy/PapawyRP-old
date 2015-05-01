#if !defined CHARACTERS_INFOS_INCLUDED
	#define CHARACTERS_INFOS_INCLUDED
#endif

// ----------------------------------------------------------------------------

#include <YSI4\YSI_Coding\y_hooks>

// ----------------------------------------------------------------------------

#include "core.pwn"

// ----------------------------------------------------------------------------

#define MAX_CHARACTERS_PER_PLAYER		1
#define MAX_CHARACTERS 					MAX_PLAYERS*MAX_CHARACTERS_PER_PLAYER

// ----------------------------------------------------------------------------

enum C_INFOS {
	cSqlID,
	ORM:cOrmID,
	cName[MAX_PLAYER_NAME],
	cAge,
	cSex,
	cSkin,
	Float:cSpawn[3],
	bool:cCreated
};

new cInfos[MAX_CHARACTERS][C_INFOS];

stock IsCharacterCreated(characterID)
{
	return cInfos[characterID][cCreated];
}