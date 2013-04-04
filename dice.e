//DICE 
//Author: Deepak Kumar

dice 		cp		bmp.x	seventy
			cp		bmp.y	fifty
			cp		bmp.id	dice.val
			call	bmp		bmp.r



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




dice.r		.data	0
dice.val	.data	eight
dice.currt	.data	zero
