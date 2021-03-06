// dice.e
// written by Deepak, Andrew
// rolls a die, displayed on screen
// at (dice.x, dice.y), until the space key
// is hit. the value of the die
// is stored in dice.val.
// the data statements contain the sequence
// of rolls used in the demo.
// if dice.demo and line after it
// are commented out the roll becomes random.

dice			cp	bmp.x		dice.x 
			cp	bmp.y		dice.y

dice.time		add	dice.val	dice.val	one
			bne	dice.skip	dice.val	six
			cp	dice.val	zero

dice.skip		cpfa	bmp.id		img.die1	dice.val
			call	bmp		bmp.r
			call	key		key.r
			be	dice.time	key.press	zero

dice.demo		cpfa	dice.val	dice.roll	dice.i
			sub	dice.val	dice.val	one
			cpfa	bmp.id		img.die1	dice.val
			call	bmp		bmp.r

			add	dice.i		dice.i		one

			ret	dice.r



dice.i		.data	0
dice.r		.data	0
dice.val	.data	0
dice.nmax	.data	0
dice.currt	.data	zero
dice.num	.data	zero
dice.out	.data	0
dice.x		.data	0
dice.y		.data	0

dice.roll	.data	4
		.data	3
		.data	5
		.data	6
		.data	1
		.data	4
		.data	5
		.data	2
		.data	4
		.data	2
		.data	4
		.data	1
		.data	3
		.data	2
		.data	3
		.data	2
		.data	6
		.data	1
		.data	6
		.data	5

