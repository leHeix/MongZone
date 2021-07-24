#if defined _COMMANDS_CALLBACKS_
	#endinput
#endif
#define _COMMANDS_CALLBACKS_

#include <YSI_Coding\y_hooks>

hook OnScriptInit()
{
	new hdr[AMX_HDR];
	GetAmxHeaderNow(hdr);

	new pubname[24];
	for(new i = 0, j = GetNumPublics(hdr); i < j; ++i)
	{
		if(!GetPublicNameFromIndex(i, pubname))
			continue;

		if(strfind(pubname, "_cmddesc_") == 0)
		{
			new addr = GetPublicAddressFromIndex(i);
			__emit {
				push.c 0
				load.s.alt addr
				lctrl 6
				add.c 0x20
				lctrl 8
				push.pri
				move.pri
				sctrl 6
			}
		}
	}

	return 1;
}