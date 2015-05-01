#if !defined CHARACTERS_VARS_INCLUDED
	#define CHARACTERS_VARS_INCLUDED
#endif

// ----------------------------------------------------------------------------

#include <YSI4\YSI_Coding\y_hooks>

// ----------------------------------------------------------------------------

#include "core.pwn"

// ----------------------------------------------------------------------------

forward LoadCharacterData(characterID);
public LoadCharacterData(characterID)
{
	new ORM:cOrm = cInfos[characterID][cOrmID] = orm_create("charactersData");

	orm_addvar_int(cOrm, 	cInfos[characterID][cSqlID], 						"ID");
	orm_addvar_string(cOrm, cInfos[characterID][cName], 	MAX_PLAYER_NAME+1, 	"Name");
	orm_addvar_int(cOrm, 	cInfos[characterID][cAge], 							"Age");
	orm_addvar_int(cOrm, 	cInfos[characterID][cSex],	 						"Sex");
	orm_addvar_float(cOrm, 	cInfos[characterID][cSpawn][0], 					"SpawnX");
	orm_addvar_float(cOrm, 	cInfos[characterID][cSpawn][1],						"SpawnY");
	orm_addvar_float(cOrm,	cInfos[characterID][cSpawn][2],						"SpawnZ");

	cInfos[characterID][cCreated] = true;

	orm_setkey(cOrm, "ID");
	orm_select(cOrm, "OnCharacterDataLoad", "d", characterID);

	return true;
}

forward OnCharacterDataLoad(characterID);
public OnCharacterDataLoad(characterID)
{
	switch(orm_errno(cInfos[characterID][cOrmID]))
	{
		case ERROR_OK: {
			cInfos[characterID][cCreated] = true;
		}
		case ERROR_NO_DATA: {
			cInfos[characterID][cCreated] = false;
		}
	}
	orm_setkey(cInfos[characterID][cOrmID], "ID");
	return 1;
}

forward SaveCharacterData(characterID);
public SaveCharacterData(characterID)
{
	if(IsCharacterCreated(characterID))
	{
		orm_update(cInfos[characterID][cOrmID]);
	}
}

forward ResetCharacterVars(characterID);
public ResetCharacterVars(characterID)
{
	new reset[C_INFOS];
	cInfos[characterID] = reset;
}

forward CreateNewCharacterInDataBase(playerid);
public CreateNewCharacterInDataBase(playerid)
{
	new cID = GetAvaibleCharacterID();

	orm_insert(cInfos[cID][cOrmID], "OnCharacterSQLCreated", "dd", cID, playerid);

	new ORM:cOrm = cInfos[cID][cOrmID] = orm_create("charactersData");

	orm_addvar_int(cOrm, 	cInfos[cID][cSqlID], 						"ID");
	orm_addvar_string(cOrm, cInfos[cID][cName], 	MAX_PLAYER_NAME+1, 	"Name");
	orm_addvar_int(cOrm, 	cInfos[cID][cAge], 							"Age");
	orm_addvar_int(cOrm, 	cInfos[cID][cSex],	 						"Sex");
	orm_addvar_float(cOrm, 	cInfos[cID][cSpawn][0], 					"SpawnX");
	orm_addvar_float(cOrm, 	cInfos[cID][cSpawn][1],						"SpawnY");
	orm_addvar_float(cOrm,	cInfos[cID][cSpawn][2],						"SpawnZ");

	cInfos[cID][cCreated] = true;

	orm_setkey(cOrm, "ID");

	return cID;
}

forward OnCharacterSQLCreated(characterID, playerid);
public OnCharacterSQLCreated(characterID, playerid)
{
	switch(orm_errno(cInfos[characterID][cOrmID]))
	{
		case ERROR_OK: {
			if(playerid != -1)
			{
				pInfos[playerid][pCharacterID] = cInfos[characterID][cSqlID];
			}
		}
		case ERROR_NO_DATA: {
			cInfos[characterID][cCreated] = false;
		}
	}
}