// BOARD

bd	cpfa	bmp.id	img.bg1		bd.quad
	cp	bmp.x	zero
	cp	bmp.y	zero
	call	bmp	bmp.r

bd.end	ret	bd.r

// width and height.
bd.quad	.data	4
bd.r	.data	0
bd.dat	.data	0
	.data	0
	.data	0
	.data	0
	.data	0
