//DICE 
dice 		cp		bmp.x	seventy
			cp		bmp.y	fifty
			cp		bmp.id	dice.val
			call	bmp		bmp.r
			be 		dice.key	0	0


dice.time	call	time	time.r
			cp		dice.currt	time.out
			call	time	time.r
			be 		dice.time	dice.currt	time.out
			bne 	dice.inc	dice.currt  time.out

dice.inc	add		dice.val	one
			bne		dice.inc 	dice.val	fourteen
			be      dice        zero		zero
			be 		dice.reset	dice.val	fourteen


dice.reset	cp		dice.val	eight
			be      dice.inc	zero	zero

dice.key	call	key			key.r
			bne		dice.key	key.val		key.space
			be 		dice.finish	key.val		key.space

dance.finish cp		dice.out	dice.val

		     ret 	dice.r


dice.r		.data	0
dice.val	.data	eight
dice.currt	.data	zero
dice.out	.data	0