star	mult	star.index	game.star	five
	cpfa	star.x		bd.dat		star.index
	add	star.index	star.index	one
	cpfa	star.y		bd.dat		star.index
	add	star.y		star.y		five
	add	star.index	star.index	one
	cpfa	star.quad	bd.dat		star.index
	bne	star.end	star.quad	bd.quad
	
	cp	bmp.id		img.star
	mult	bmp.x		star.x		four
	mult	bmp.y		star.y		four
	call	bmp		bmp.r

star.end	ret	star.r

star.x		.data	0
star.y		.data	0
star.r		.data	0
star.index	.data	0
star.quad	.data	0
