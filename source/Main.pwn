#pragma option -;+
#pragma option -(+
#pragma semicolon 1
#pragma warning disable 239 // fuck off

// syntactic sugar tweaks
#define PP_SYNTAX_AWAIT
#define PP_SYNTAX_YIELD
#define PP_SYNTAX_STRING_OP
#define PP_SYNAX_GENERIC
#define PP_SYNTAX_@
#define PP_SYNTAX_@f
#define YSI_NO_KEYWORD_yield
#define YSI_NO_KEYWORD_List
// ysi must-haves
#define YSI_NO_HEAP_MALLOC
#define YSI_NO_MODE_CACHE
#define YSI_NO_OPTIMISATION_MESSAGE
#define YSI_NO_VERSION_CHECK
#define YSI_NO_ANDROID_CHECK

#define FCNPC_DISABLE_VERSION_CHECK

#define DEBUG_MODE 1

#if defined DEBUG_MODE
	#pragma option -d3
#else
	#pragma option -d0
	#pragma option -O1
#endif

// Daniel-Cortez's Anti-DeAMX
////////////////////////////////
@___ww___@();
@___ww___@()
{
    #emit    stack    0x7FFFFFFF
    #emit    inc.s    cellmax

    static const ___[][] = {"haha", "no."};

    #emit    retn
    #emit    load.s.pri    ___
    #emit    proc
    #emit    proc
    #emit    fill    cellmax
    #emit    proc
    #emit    stack    1
    #emit    stor.alt    ___
    #emit    strb.i    2
    #emit    switch    0
    #emit    retn
L1:
    #emit    jump    L1
    #emit    zero    cellmin
}

#include <a_samp>

#undef MAX_PLAYERS
#define MAX_PLAYERS 150

// NPC things
#assert (MAX_PLAYERS * 4) < 1000

#include <jit>
#include <streamer>
#include <sscanf2>
#include <YSF>
#include <ColAndreas>
#include <FCNPC>
#include <PawnPlus>
#include <Pawn.RakNet>
#include <Pawn.CMD>
#include <a_mysql>
#include <bcrypt>

// Patches
/////////////
#include "core/patches/first_hooks.pwn"
#include "core/patches/sendclientcheck.pwn"
#include "core/patches/textdraws.pwn"

#include <YSI_Coding\y_hooks>
#include <YSI_Coding\y_inline>
#include <YSI_Core\y_utils>
#include <YSI_Data\y_iterate>
#include <YSI_Data\y_bit>
#include <YSI_Extra\y_inline_mysql>
#include <YSI_Extra\y_inline_bcrypt>
#include <YSI_Visual\y_dialog>

DEFINE_HOOK_REPLACEMENT__(OnVehicle, OV);

// Global definitions
////////////////////////
#include "core/definitions.pwn"

// Headers
/////////////
#include "core/utils/header.pwn"
#include "core/database/header.pwn"
#include "core/transitions/header.pwn"
#include "core/async/header.pwn"
#include "server/textdraws/header.pwn"
#include "server/config/header.pwn"
#include "player/account/header.pwn"
#include "player/introduction/header.pwn"

// Functions
///////////////
#include "core/utils/functions.pwn"
#include "core/transitions/functions.pwn"
#include "core/async/functions.pwn"
#include "server/config/functions.pwn"
#include "player/account/functions.pwn"
#include "player/introduction/functions.pwn"

// Callbacks
///////////////
#include "core/utils/callbacks.pwn"
#include "core/database/callbacks.pwn"
#include "core/transitions/callbacks.pwn"
#include "core/async/callbacks.pwn"
#include "server/config/callbacks.pwn"
#include "server/textdraws/callbacks.pwn"
#include "player/introduction/callbacks.pwn"
#include "player/account/callbacks.pwn"

public OnGameModeInit()
{
	pp_use_funcidx(true);

	print(!"= - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - =");
	print(!"=	    __  ___                 _____                  	=");
	print(!"=	   /  |/  /___  ____  ____ /__  /  ____  ____  ___ 	=");
	print(!"=	  / /|_/ / __ \\/ __ \\/ __ `/ / /  / __ \\/ __ \\/ _ \\	=");
	print(!"=	 / /  / / /_/ / / / / /_/ / / /__/ /_/ / / / /  __/	=");
	print(!"=	/_/  /_/\\____/_/ /_/\\__, / /____/\\____/_/ /_/\\___/ 	=");
	print(!"=	                   /____/                          	=");
	print(!"=                                                               =");
	print(!"= - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - =");

	#if !DEBUG_MODE
		if(!__JIT)
		{
			print(!"[!] MongZone esta diseñado para funcionar con el compilador JIT.");
			SendRconCommand(!"exit");
		}
	#endif

	/*
	__emit {
		zero.pri
		lctrl 0xFF
		jzer L0 // jump out of disable code
		zero.pri
		sctrl 0xFE
		L0:
		nop
	}
	*/

	// the sctrl 0xFE instruction is a nop when crashdetect isn't loaded
	__emit {
		zero.pri
		sctrl 0xFE
	}

	CA_Init();

	return 1;
}