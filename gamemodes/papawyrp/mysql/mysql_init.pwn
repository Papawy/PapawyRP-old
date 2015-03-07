#if !defined MYSQL_INIT_INCLUDED
	#define MYSQL_INIT_INCLUDED
#endif

// ----------------------------------------------------------------------------

#include "core.pwn"

#include "mysql_infos.pwn"

// ----------------------------------------------------------------------------

forward MySQL_Init(db_address[], db_user[], db_pass[], db_name[]);
public  MySQL_Init(db_address[], db_user[], db_pass[], db_name[])
{
	MySQL_handle = mysql_connect(db_address, db_user, db_name, db_pass, .autoreconnect = true);
	if(mysql_errno() != 0)
	{
		print("[MySQL] Can't connect to MySQL database !");
		return false;
	}
	return true;
}

forward MySQL_Close();
public MySQL_Close()
{
	mysql_close(MySQL_handle);
	printf("+ MySQL connection closed !");
}