/*
	Replaces FillMemory calls with inline "fill" instructions.
	- heix
*/

#if defined _CGEN_fill_
	#endinput
#endif
#define _CGEN_fill_

static stock ReplaceFillInstr(const match[CodeScanner])
{
	new
		cip = CodeScanGetMatchAddressData(match);

	/* parameters */
	new
		size = CodeScanGetMatchHole(match, 0),
		value = CodeScanGetMatchHole(match, 1),
		destination = CodeScanGetMatchHole(match, 2);

	#pragma warning push
	#pragma warning disable 213 
	/* opcodes */
	new
		Opcode:fill_op = RelocateOpcode(OP_FILL),
		Opcode:addr_alt_op =
			(
				((ReadAmxMemory(cip + 24) == _:RelocateOpcode(OP_CONST_PRI)) || 
				(ReadAmxMemory(cip + 16) == _:RelocateOpcode(OP_PUSH_C)))
				? RelocateOpcode(OP_CONST_ALT)
				: RelocateOpcode(OP_ADDR_ALT)
			),
		Opcode:const_pri_op = RelocateOpcode(OP_CONST_PRI);

	#pragma warning pop

	// nop current opcodes so we can generate our own
	CodeScanNOPMatch(match);

	WriteAmxMemory(cip, _:const_pri_op);
	WriteAmxMemory(cip + 4, value);
	WriteAmxMemory(cip + 8, _:addr_alt_op);
	WriteAmxMemory(cip + 12, destination);
	WriteAmxMemory(cip + 16, _:fill_op);
	WriteAmxMemory(cip + 20, (size * (cellbits / charbits)));

	return 1;
}

FillMemory(arr[], val = 0, size = sizeof(arr))
{
	// Calls to this function can only occur after code generation (somehow, it didn't get patched)
	if(!Server_JITComplete())
	{
		new dst;
		__emit {
			// push fill length
			load.s.pri size
			const.alt (cellbits / charbits)
			smul				// size * cellbytes
			push.pri

			// dst = COD + CIP - DAT + bytes to fill param
			lctrl 0				// COD
			move.alt
			lctrl 6				// CIP
			add
			move.alt
			lctrl 1				// DAT
			sub.alt
			add.c 0x44 			// 17 instructions since lctrl 6, multiplied by cell bytes
			stor.s.pri dst

			// WriteAMXMemory(dst, fill_len)
			pop.pri 			// pop fill size
			sref.s.pri dst

			// FILL instruction uses the PRI and ALT registers for fill value and fill destination
			load.s.pri val
			load.s.alt arr

			fill 1				// FILL
		}
	}
	else
	{
		memset(arr, val, size);
	}

	return 0;
}

public OnJITCompile()
{
	new scanner[CodeScanner];
	CodeScanInit(scanner);

	/*
		The compiler has diferents ways of generating code, so we want to match all off them:
		the "_fast" suffix indicates the compiler generates single "push.c"/"push.adr" opcodes for parameter pushing
		the "_cpri" suffix indicates the compiler generates two (three, actually) opcodes:
			"const.pri"/"addr.pri" and "push.pri"
	*/

	new local_fast[CodeScanMatcher];
	CodeScanMatcherInit(local_fast, &ReplaceFillInstr);
	CodeScanMatcherPattern(local_fast,
		OP(PUSH_C, ???)
		OP(PUSH_C, ???)
		OP(PUSH_ADR, ???)
		OP(PUSH_C, 0xc)
		OP(CALL, __addressof(FillMemory))
	);
	CodeScanAddMatcher(scanner, local_fast);

	new local_cpri[CodeScanMatcher];
	CodeScanMatcherInit(local_cpri, &ReplaceFillInstr);
	CodeScanMatcherPattern(local_cpri,
		OP(CONST_PRI, ???)
		OP(PUSH_PRI)
		OP(CONST_PRI, ???)
		OP(PUSH_PRI)
		OP(ADDR_PRI, ???)
		OP(PUSH_PRI)
		OP(PUSH_C, 0xc)
		OP(CALL, __addressof(FillMemory))
	);
	CodeScanAddMatcher(scanner, local_cpri);

	new global_cpri[CodeScanMatcher];
	CodeScanMatcherInit(global_cpri, &ReplaceFillInstr);
	CodeScanMatcherPattern(global_cpri,
		OP(CONST_PRI, ???)
		OP(PUSH_PRI)
		OP(CONST_PRI, ???)
		OP(PUSH_PRI)
		OP(CONST_PRI, ???)
		OP(PUSH_PRI)
		OP(PUSH_C, 0xc)
		OP(CALL, __addressof(FillMemory))
	);
	CodeScanAddMatcher(scanner, global_cpri);

	new global_fast[CodeScanMatcher];
	CodeScanMatcherInit(global_fast, &ReplaceFillInstr);
	CodeScanMatcherPattern(global_fast,
		OP(PUSH_C, ???)
		OP(PUSH_C, ???)
		OP(PUSH_C, ???)
		OP(PUSH_C, 0xc)
		OP(CALL, __addressof(FillMemory))
	);
	CodeScanAddMatcher(scanner, global_fast);

	CodeScanRun(scanner);

	#if defined CGEN_FILL_OnJITCompile
		return CGEN_FILL_OnJITCompile();
	#else
		return 1;
	#endif
}

#if defined _ALS_OnJITCompile
	#undef OnJITCompile
#else
	#define _ALS_OnJITCompile
#endif
#define OnJITCompile CGEN_FILL_OnJITCompile
#if defined CGEN_FILL_OnJITCompile
	forward CGEN_FILL_OnJITCompile();
#endif