// draws the star
// written by Michael

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
star.loc	.data	11
		.data	28
		.data	10
		.data	2
		.data	15
		.data	29
		.data	1
		.data	19
		.data	5
		.data	24
		.data	10
		.data	11
		.data	10
		.data	0



//1 2 3 5 6 10 11 13 14 15 16 19 20 21 23 24 25 27 28 29
