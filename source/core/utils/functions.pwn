#if defined _UTILS_FUNCTIONS_
	#endinput
#endif

#define _UTILS_FUNCTIONS_

Str_Random(len = 10)
{
	new str_generated[32];
	assert len < sizeof(str_generated);

	while (--len != -1)
	{
		str_generated[len] = random(2) ? (random(26) + (random(2) ? 'a' : 'A')) : (random(10) + '0');
	}

	return str_generated;
}

TextDraw_DelayedSelect(playerid, hovercolor)
{
	wait_ms(200);
	SelectTextDraw(playerid, hovercolor);
	return 1;
}

stock String:Str_FixEncoding_s(String:base)
{
	for (new i = (str_len(base) - 1); i != -1; --i)
	{
		switch (str_getc(base, i))
		{
			case '�': str_setc(base, i, 151);
			case '�': str_setc(base, i, 152);
			case '�': str_setc(base, i, 153);
			case '�': str_setc(base, i, 154);
			case '�': str_setc(base, i, 128);
			case '�': str_setc(base, i, 129);
			case '�': str_setc(base, i, 130);
			case '�': str_setc(base, i, 131);
			case '�': str_setc(base, i, 157);
			case '�': str_setc(base, i, 158);
			case '�': str_setc(base, i, 159);
			case '�': str_setc(base, i, 160);
			case '�': str_setc(base, i, 134);
			case '�': str_setc(base, i, 135);
			case '�': str_setc(base, i, 136);
			case '�': str_setc(base, i, 137);
			case '�': str_setc(base, i, 161);
			case '�': str_setc(base, i, 162);
			case '�': str_setc(base, i, 163);
			case '�': str_setc(base, i, 164);
			case '�': str_setc(base, i, 138);
			case '�': str_setc(base, i, 139);
			case '�': str_setc(base, i, 140);
			case '�': str_setc(base, i, 141);
			case '�': str_setc(base, i, 165);
			case '�': str_setc(base, i, 166);
			case '�': str_setc(base, i, 167);
			case '�': str_setc(base, i, 168);
			case '�': str_setc(base, i, 142);
			case '�': str_setc(base, i, 143);
			case '�': str_setc(base, i, 144);
			case '�': str_setc(base, i, 145);
			case '�': str_setc(base, i, 169);
			case '�': str_setc(base, i, 170);
			case '�': str_setc(base, i, 171);
			case '�': str_setc(base, i, 172);
			case '�': str_setc(base, i, 146);
			case '�': str_setc(base, i, 147);
			case '�': str_setc(base, i, 148);
			case '�': str_setc(base, i, 149);
			case '�': str_setc(base, i, 174);
			case '�': str_setc(base, i, 173);
			case '�': str_setc(base, i, 64);
			case '�': str_setc(base, i, 175);
			case '`': str_setc(base, i, 177);
			case '&': str_setc(base, i, 38);
			case ']': str_setc(base, i, ')');
			case '[': str_setc(base, i, '(');
		}
	}
	return base;
}

Str_FixEncoding(const base[])
{
	new result[256];

	strcat(result, base);

	for (new i = (strlen(base) - 1); i != -1; --i)
	{
		switch (result[i])
		{
			case '�': result[i] = 151;
			case '�': result[i] = 152;
			case '�': result[i] = 153;
			case '�': result[i] = 154;
			case '�': result[i] = 128;
			case '�': result[i] = 129;
			case '�': result[i] = 130;
			case '�': result[i] = 131;
			case '�': result[i] = 157;
			case '�': result[i] = 158;
			case '�': result[i] = 159;
			case '�': result[i] = 160;
			case '�': result[i] = 134;
			case '�': result[i] = 135;
			case '�': result[i] = 136;
			case '�': result[i] = 137;
			case '�': result[i] = 161;
			case '�': result[i] = 162;
			case '�': result[i] = 163;
			case '�': result[i] = 164;
			case '�': result[i] = 138;
			case '�': result[i] = 139;
			case '�': result[i] = 140;
			case '�': result[i] = 141;
			case '�': result[i] = 165;
			case '�': result[i] = 166;
			case '�': result[i] = 167;
			case '�': result[i] = 168;
			case '�': result[i] = 142;
			case '�': result[i] = 143;
			case '�': result[i] = 144;
			case '�': result[i] = 145;
			case '�': result[i] = 169;
			case '�': result[i] = 170;
			case '�': result[i] = 171;
			case '�': result[i] = 172;
			case '�': result[i] = 146;
			case '�': result[i] = 147;
			case '�': result[i] = 148;
			case '�': result[i] = 149;
			case '�': result[i] = 174;
			case '�': result[i] = 173;
			case '�': result[i] = 64;
			case '�': result[i] = 175;
			case '`': result[i] = 177;
			case '&': result[i] = 38;
		}
	}
	return result;
}

KillFeed_Clear(playerid = INVALID_PLAYER_ID)
{
	if (!IsPlayerConnected(playerid) && playerid != INVALID_PLAYER_ID)
	{
		return 0;
	}

	const invisible_id = INVALID_PLAYER_ID - 1;
	new i = 5;
   
	#emit push.c invisible_id
	#emit push.c invisible_id

	if (playerid == INVALID_PLAYER_ID)
	{
		#emit push.c 12

		while (--i != -1)
		{
			#emit sysreq.c SendDeathMessage
		}

		#emit stack 12
	}
	else
	{
		#emit push.s playerid
		#emit push.c 16

		while (--i != -1)
		{
			#emit sysreq.c SendDeathMessageToPlayer
		}

		#emit stack 16
	}
	return 1;
}

Chat_Clear(playerid = INVALID_PLAYER_ID, lines = 20)
{
	if (playerid != INVALID_PLAYER_ID && !IsPlayerConnected(playerid))
	{
		return 0;
	}

	static const space[] = !" ";

	#emit push.c space
	#emit push.c 0x01

	if (playerid == INVALID_PLAYER_ID)
	{
		#emit push.c 12

		while (lines-- != -1)
		{
			#emit sysreq.c SendClientMessageToAll
		}

		#emit stack 12
	}
	else
	{
		#emit push.s playerid
		#emit push.c 16

		while (lines-- != -1)
		{
			#emit sysreq.c SendClientMessage
		}

		#emit stack 16
	}
	return 1;
}

stock Date_GetAsText()
{
	new date[11], year, month, day;

	getdate(year, month, day);
	format(date, sizeof(date), "%02d/%02d/%d", day, month, year);
	return date;
}

stock any_acquire(AnyTag:value, tag = tagof(value))
{
	if(tag == tagof(_:))
		return 0;
	
	if(tag == tagof(String:))
	{
		str_acquire(value);
	}
	/* too lazy - add more as the script grows */

	return 1;
}