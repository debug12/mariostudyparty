// keyboard driver

key		out 	20		one
key.r1		in	21		key.res
		bne	key.r1		key.res		one

		in	22		key.press
		in	23		key.val
		out	20		zero

key.r2		in	21		key.res
		bne	key.r2		key.res		zero

		ret	key.r

key.res		.data	0
key.press	.data	0
key.val		.data	0
key.r		.data	0
key.a		.data	97
key.w		.data	119
key.s		.data	115
key.d		.data	100
key.space	.data	32
key.enter	.data	13
