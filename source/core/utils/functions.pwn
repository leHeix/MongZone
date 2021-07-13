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

Str_FixEncoding(const base[])
{
	new result[256];

	strcat(result, base);

	for (new i = (strlen(base) - 1); i != -1; --i)
	{
		switch (result[i])
		{
			case 'à': result[i] = 151;
			case 'á': result[i] = 152;
			case 'â': result[i] = 153;
			case 'ä': result[i] = 154;
			case 'À': result[i] = 128;
			case 'Á': result[i] = 129;
			case 'Â': result[i] = 130;
			case 'Ä': result[i] = 131;
			case 'è': result[i] = 157;
			case 'é': result[i] = 158;
			case 'ê': result[i] = 159;
			case 'ë': result[i] = 160;
			case 'È': result[i] = 134;
			case 'É': result[i] = 135;
			case 'Ê': result[i] = 136;
			case 'Ë': result[i] = 137;
			case 'ì': result[i] = 161;
			case 'í': result[i] = 162;
			case 'î': result[i] = 163;
			case 'ï': result[i] = 164;
			case 'Ì': result[i] = 138;
			case 'Í': result[i] = 139;
			case 'Î': result[i] = 140;
			case 'Ï': result[i] = 141;
			case 'ò': result[i] = 165;
			case 'ó': result[i] = 166;
			case 'ô': result[i] = 167;
			case 'ö': result[i] = 168;
			case 'Ò': result[i] = 142;
			case 'Ó': result[i] = 143;
			case 'Ô': result[i] = 144;
			case 'Ö': result[i] = 145;
			case 'ù': result[i] = 169;
			case 'ú': result[i] = 170;
			case 'û': result[i] = 171;
			case 'ü': result[i] = 172;
			case 'Ù': result[i] = 146;
			case 'Ú': result[i] = 147;
			case 'Û': result[i] = 148;
			case 'Ü': result[i] = 149;
			case 'ñ': result[i] = 174;
			case 'Ñ': result[i] = 173;
			case '¡': result[i] = 64;
			case '¿': result[i] = 175;
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

/*
 * memset, but 2 microshits faster
 * - heix
 */
FillMemory(arr[], val, length = sizeof(arr))
{
    new dst;

    __emit {
		// push fill length
		load.s.pri length
		const.alt cellbytes
		smul				// length * cellbytes
		push.pri

		// push relocated FILL opcode
		push.c OP_FILL
        push.c 4
		call RelocateOpcode
		push.pri

        // dst = COD + CIP - DAT + bytes to NOP
		lctrl 0				// COD
		move.alt
		lctrl 6				// CIP
		add
		move.alt
		lctrl 1				// DAT
		sub.alt
		add.c 0x64 			// 25 instructions since lctrl 6, multiplied by cell bytes
		stor.s.pri dst

		// WriteAMXMemory(dst, OP_FILL)
		pop.pri
		sref.s.pri dst

		// dst += 4
		load.s.pri dst
		add.c 4
		stor.s.pri dst

		// WriteAMXMemory(dst, fill_len)
		pop.pri                 // pop fill length
		sref.s.pri dst

		// FILL instruction uses the PRI and ALT registers for fill value and fill destination
		load.s.pri val
		load.s.alt arr

		nop 					// FILL
		nop						// fill_len
	}

	return 0;
}