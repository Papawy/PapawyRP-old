#if !defined MYSQL_INIT_INCLUDED
	#define MYSQL_INIT_INCLUDED
#endif

// ----------------------------------------------------------------------------

#include "core.pwn"

#if defined USE_MYSQL

#include "mysql_infos.pwn"

// ----------------------------------------------------------------------------

forward Connect();
public Connect()
{
	MySQL_handle = mysql_connect(SQL_HOST, SQL_USER, SQL_DB, SQL_PASS, 3306, true, 2);
}

#endif