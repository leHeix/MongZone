this is trash bruh 😭😭😭

also the [`FillMemory`](https://github.com/leHeix/MongZone/blob/master/source/cgen/fill.pwn#L50) function at [source/cgen/fill.pwn](https://github.com/leHeix/MongZone/blob/master/source/cgen/fill.pwn) is flawed, idk what the compiler (or the user, with `#emit`) even generates when calling functions and the codescan might replace a great amount of `FillMemory` calls but when it doesn't the function won't do anything, it needs to provide an alternative for when the codescan fails to find and replace one of the function calls

it's actually not needed to do all that bs, you won't even get a great speed benefit from replacing conventional array filling methods with a single `fill` instruction. whatever, just use [`MemSet` from YSI](https://github.com/pawn-lang/YSI-Includes/blob/c0df4b39d820eed0c18d5642bb21cb07bc101a31/YSI_Core/y_utils/y_utils_arrays.inc#L151) or some loop to array size or whatever.
