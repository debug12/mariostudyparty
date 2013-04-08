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

		ret	rollfirst.r		

rollfirst.r	.data	0

rollfirst.y	.data	280
rollfirst.x	.data	100
rollfirst.dx	.data	125
