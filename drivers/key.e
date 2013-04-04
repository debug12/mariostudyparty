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
key.r
key.left	.data	37
key.up		.data	38
key.right	.data	39
key.down	.data	40
key.space	.data	32
key.enter	.data	13
