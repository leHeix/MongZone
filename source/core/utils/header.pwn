#if defined _H_UTILS_
	#endinput
#endif
#define _H_UTILS_

forward OnPlayerPressEsc(playerid);

#define @f str_format

native mysql_tquery_s(MySQL:handle, ConstAmxString:query, const callback[] = "", const format[] = "", {Float, _}:...) = mysql_tquery;