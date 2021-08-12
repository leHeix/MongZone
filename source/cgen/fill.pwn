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

	#pragma warning push
	#pragma warning disable 213 

	/* parameters */
	new
		size = CodeScanGetMatchHole(match, 0),
		value = CodeScanGetMatchHole(match, 1),
		destination = CodeScanGetMatchHole(match, 2),
		bool:is_global = (ReadAmxMemory(cip + 24) == _:RelocateOpcode(OP_CONST_PRI)) || (ReadAmxMemory(cip + 16) == _:RelocateOpcode(OP_PUSH_C));

	#pragma warning pop

	// nop current opcodes so we can generate our own
	CodeScanNOPMatch(match);

	new ctx[AsmContext];
	AsmInitPtr(ctx, cip, 24);

	@emit const.pri value

	if(is_global)
	{
		@emit const.alt destination
	}
	else
	{
		@emit addr.alt destination
	}

	@emit fill (size * cellbytes)

	return 1;
}

FillMemory(arr[], val = 0, size = sizeof(arr))
{
	#pragma unused arr, val, size
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