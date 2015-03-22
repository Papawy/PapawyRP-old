#if !defined UTILS_FUNCTIONS_INCLUDED
	#define UTILS_FUNCTIONS_INCLUDED
#endif

// ----------------------------------------------------------------------------

#include <YSI4\Coding\y_va>

// ----------------------------------------------------------------------------

#define INVALID_PLAYER_TEXTDRAW			PlayerText:INVALID_TEXT_DRAW

// ----------------------------------------------------------------------------

native WP_Hash(buffer[], len, const str[]);

// ----------------------------------------------------------------------------

stock IsValidEmailEx(const string[])
{
	static
		RegEx:rEmail
	;
	
	if ( !rEmail )
	{		
		rEmail = regex_build("[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?");
	}
	
	return regex_match_exid(string, rEmail);
}

stock IsValidRpNameEx(const string[])
{
	static
		RegEx:rRpName
	;
	
	if ( !rRpName )
	{		
		rRpName = regex_build("([A-Z]{1,1})[a-z]{2,9}+_([A-Z]{1,1})[a-z]{2,9}");
	}
	
	return regex_match_exid(string, rRpName);
}

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


// Thanks to pen_theGun
// Modified by OpakoDev
stock date(timestamp, _form=0)
{
	/*
	~ convert a Timestamp to a Date.
	~ 10.07.2009

	date( 1247182451 )  will print >> 09.07.2009-23:34:11
	date( 1247182451, 1) will print >> 09/07/2009, 23:34:11
	date( 1247182451, 2) will print >> July 09, 2009, 23:34:11
	date( 1247182451, 3) will print >> 9 Jul 2009, 23:34
	*/
	new year = 1970, day = 0, month = 0, hour = 0, mins = 0, sec = 0;
	if(timestamp >= 1262304000) year = 2010, timestamp -= 1262304000;

	new days_of_month[12] = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
	new names_of_month[12][10] = {"Janvier", "Février", "Mars", "Avril", "Mai", "Juin", "Juillet", "Aout", "Septembre", "Octobre", "Novembre", "Décembre"};
	new returnstring[32];

	while(timestamp >= 31622400)
	{
		timestamp -= 31536000;
		if (((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0)) timestamp -= 86400;
		year++;
	}

	if(((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0)) days_of_month[1] = 29;
	else days_of_month[1] = 28;


	while(timestamp >= 86400)
	{
		timestamp -= 86400, day++;
		if(day == days_of_month[month]) day = 0, month++;
	}

	while(timestamp >= 60)
	{
		timestamp -= 60, mins++;
		if(mins == 60) mins = 0, hour++;
	}

	sec = timestamp;

	switch(_form)
	{
		case 1: format(returnstring, 31, "%02d/%02d/%d %02d:%02d:%02d", day+1, month+1, year, hour, mins, sec);
		case 2: format(returnstring, 31, "%02d %s %d, %02d:%02d:%02d", day+1, names_of_month[month], year, hour, mins, sec);
		case 3: format(returnstring, 31, "%d %c%c%c %d, %02d:%02d", day+1, names_of_month[month][0], names_of_month[month][1], names_of_month[month][2], year, hour, mins);

		default: format(returnstring, 31, "%02d.%02d.%d-%02d:%02d:%02d", day+1, month+1, year, hour, mins, sec);
	}
	
	return returnstring;
}

// Thanks to mooman
stock convert_encoding(string[])
{
	new tmpstr[256];
	strins(tmpstr, string, 0);
	new original[50] = {192,193,194,196,198,199,200,201,202,203,204,205,206,207,210,211,212,214,217,218,219,220,223,224,225,226,228,230,231,232,233,234,235,236,237,238,239,242,243,244,246,249,250,251,252,209,241,191,161,176};
	new fixed[50] = {128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,94,124};
	new len = strlen(string);
	for (new i; i < len; i++) {
		for(new j;j < 50;j++) {
			if(tmpstr[i] == original[j]) {
				tmpstr[i] = fixed[j];
				break;
			}
		}
	}
	return tmpstr;
}