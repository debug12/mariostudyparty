// keyboard driver

key		cp	key.press	zero	
		out 	20		one
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

		ret	key.r

key.i		.data	0
key.iter	.data	1000
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
