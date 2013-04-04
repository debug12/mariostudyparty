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

on		.data	1
off		.data	0
response	.data	0
key.press	.data	0
key.val		.data	0
key.r
