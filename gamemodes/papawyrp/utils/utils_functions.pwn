#if !defined UTILS_FUNCTIONS_INCLUDED
	#define UTILS_FUNCTIONS_INCLUDED
#endif

// ----------------------------------------------------------------------------

#include <YSI4\Coding\y_va>

// ----------------------------------------------------------------------------

stock GetPlayerNameEx(playerid)
{
    new pName[MAX_PLAYER_NAME+1];
    GetPlayerName(playerid, pName, MAX_PLAYER_NAME+1);
    return pName;
}

stock SendClientMessageEx(playerid, colour, format[], va_args<>)
{
    new
        out[TCHAT_MAX_STR]
    ;
    va_format(out, sizeof(out), format, va_start<3>);
    SendClientMessage(playerid, colour, out);
}

stock SendClientMessageToAllEx(colour, format[], va_args<>)
{
    new
        out[TCHAT_MAX_STR]
    ;
    va_format(out, sizeof(out), format, va_start<2>);
    SendClientMessageToAll(colour, out);
}

forward KickEx(playerid);
public KickEx(playerid)
{
    SetTimerEx("Kick_delay", 1000, false, "i", playerid);
}

forward Kick_delay(playerid);
public Kick_delay(playerid)
{
    Kick(playerid);
    return 1;
}

// FROM DUTILS.inc By DracoBlue (Thx !) 

// Used to generate Unique Player ID (for INI files)

/**
 *  Returns a hashed value in adler32 as int
 *  @param   buf
 */
stock db_num_hash(buf[])
 {
	new length=strlen(buf);
    new s1 = 1;
    new s2 = 0;
    new n;
    for (n=0; n<length; n++) {
       s1 = (s1 + buf[n]) % 65521;
       s2 = (s2 + s1)     % 65521;
    }
    return (s2 << 16) + s1;
 }

/**
 *  Returns a hashed value in adler32 as string
 *  @param   buf
 */
stock db_hash(str2[]) {
   new tmpdasdsa[64];
   tmpdasdsa[0]=0;
   valstr(tmpdasdsa,db_num_hash(str2));
   return tmpdasdsa;
}