// keyboard driver
// written by prateek

key		cp	key.press	zero
		add	key.j		key.j		one
		
		be	key.r0		key.j		key.jfreq
		be	key.end		0		0

key.r0		out 	20		one
		cp	key.j		zero
key.r1		in	21		key.res
		add	key.i		key.i		one
		be	key.check	key.i		key.iter
		be	key.r1		0		0
key.check	bne	key.r1.5	key.res		one

		in	22		key.press
		in	23		key.val
		
key.r1.5	out	20		zero

key.r2		in	21		key.res
		bne	key.r2		key.res		zero

key.end		ret	key.r

key.j		.data	0
key.jfreq	.data	1
key.i		.data	0
key.iter	.data	1
key.res		.data	0
key.press	.data	0
key.val		.data	0
key.r		.data	0
key.a		.data	97
key.w		.data	119
key.s		.data	115
key.d		.data	100
key.y		.data	121
key.n		.data	110
key.p		.data	112
key.c		.data	99
key.space	.data	32
key.enter	.data	13
