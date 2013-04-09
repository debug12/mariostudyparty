//DICE 
//Authored by: Deepak Kumar

dice			cp	bmp.x		dice.x 
			cp	bmp.y		dice.y

dice.time		add	dice2.val	dice2.val	one
				bne	dice2.skip	dice2.val	six
				cp	dice2.val	zero

dice.skip		add	bmp.id		img.die1	dice2.val
			call	bmp		bmp.r
			call	key		key.r
			be	dice2.time	key.press	zero

			ret	dice.r

dice.val		.data	0


dice.r		.data	0
dice.val	.data	0
dice.nmax	.data	0
dice.currt	.data	zero
dice.num	.data	zero
dice.out	.data	0
dice.x		.data	0
dice.y		.data	0

