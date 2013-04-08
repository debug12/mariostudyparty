rollfirst	cp	bd.quad		five
		call	bd		bd.r

		cpfa	bmp.id		img.mario	zero
		cp	bmp.x		rollfirst.x
		cp	bmp.y		rollfirst.y
		call	bmp		bmp.r

		add	bmp.x		bmp.x		rollfirst.dx
		cpfa	bmp.id		img.mario	one
		call	bmp		bmp.r

		add	bmp.x		bmp.x		rollfirst.dx
		cpfa	bmp.id		img.mario	two
		call	bmp		bmp.r
		
		add	bmp.x		bmp.x		rollfirst.dx
		cpfa	bmp.id		img.mario	three
		call	bmp		bmp.r

		call	wait		wait.r

		cp	dice.x		rollfirst.x
		cp	dice.y		rollfirst.dy
		call	dice2		dice.r

		blt	rollfirst.r2	dice2.val	rollfirst.max
		cp	rollfirst.max	dice2.val
		cp	rollfirst.first	zero

rollfirst.r2	add	dice.x		dice.x		rollfirst.dx
		call	dice2		dice.r

		blt	rollfirst.r3	dice2.val	rollfirst.max
		cp	rollfirst.max	dice2.val
		cp	rollfirst.first	one

rollfirst.r3	add	dice.x		dice.x		rollfirst.dx
		call	dice2		dice.r

		blt	rollfirst.r4	dice2.val	rollfirst.max
		cp	rollfirst.max	dice2.val
		cp	rollfirst.first	two

rollfirst.r4	add	dice.x		dice.x		rollfirst.dx
		call	dice2		dice.r

		blt	rollfirst.r5	dice2.val	rollfirst.max
		cp	rollfirst.max	dice2.val
		cp	rollfirst.first	three

rollfirst.r5	call	wait		wait.r

		ret	rollfirst.r	

rollfirst.r	.data	0
rollfirst.first	.data	0
rollfirst.max	.data	0

rollfirst.y	.data	280
rollfirst.dy	.data	140
rollfirst.x	.data	100
rollfirst.dx	.data	125
