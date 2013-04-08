//DICE 
//Authored by: Deepak Kumar

dice2			cp	bmp.x		dice.x 
			cp	bmp.y		dice.y

dice2.time		add	dice2.val	dice2.val	one
			bne	dice2.skip	dice2.val	six
			cp	dice2.val	zero
dice2.skip		add	bmp.id		img.die1	dice2.val
			call	bmp		bmp.r
			call	key		key.r
			be	dice2.time	key.press	zero

			

			ret	dice.r

dice2.val		.data	0




dice 			cp			bmp.x		seventy
			cp			bmp.y		fifty
			cpfa	dice.val 	img.die1	zero
			be	dice.getval	0		0
			cp	bmp.id		dice.val
			call	bmp		bmp.r
			be	dice.time	0		0
			be 	dice.key	0		0

dice.getval		cp	dice.num	dice.val
			add	dice.nmax	dice.num	five


dice.time		call		time		time.r
			cp		dice.currt	time.out
			call		time		time.r
			be 		dice.time	dice.currt	time.out
			bne 		dice.inc	dice.currt 	time.out

dice.inc		add		dice.val	dice.val	one
			bne		dice.inc 	dice.val	dice.nmax
			be      	dice	        zero		zero
			be 		dice.reset	dice.val	dice.nmax


dice.reset		cp		dice.val	dice.num
			be      	dice		zero		zero

dice.key		call		key		key.r
			bne		dice		key.val		key.space
			be 		dice.finish	key.val		key.space

dice.finish 		cp		dice.out	dice.val

		     	ret 		dice.r

dice.r		.data	0
dice.val	.data	0
dice.nmax	.data	0
dice.currt	.data	zero
dice.num	.data	zero
dice.out	.data	0
dice.x		.data	0
dice.y		.data	0
