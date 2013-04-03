// BOARD

bd	mult	bmp.x	bd.cx	bd.size
	mult	bmp.y	bd.cy	bd.size
	mult	bd.val	bd.cy	bd.w
	add	bd.val	bd.val	bd.cx
	cpfa	bd.val	bd.dat	bd.val
	be	bd.incx	bd.val	zero
	cpfa	bmp.id	img.bd	bd.val
	sub	bmp.id	bmp.id	one
	call	bmp	bmp.r
	
bd.incx	add	bd.cx	bd.cx	one
	be	bd.incy	bd.cx	bd.w
	be	bd	0	0

bd.incy	add	bd.cy	bd.cy	one
	be	bd.end	bd.cy	bd.h
	cp	bd.cx	zero
	be	bd	0	0

bd.end	ret	bd.r

// width and height.
bd.cx	.data	0
bd.cy	.data	0
bd.size	.data	80
bd.val	.data	0
bd.w	.data	8
bd.h	.data	6
bd.r	.data	0
bd.dat	.data	1
	.data	1
	.data	1
	.data	2
	.data	2
	.data	1
	.data	1
	.data	1
	.data	1
	.data	0
	.data	2
	.data	0
	.data	0
	.data	0
	.data	0
	.data	1
	.data	1
	.data	2
	.data	1
	.data	1
	.data	2
	.data	1
	.data	0
	.data	1
	.data	1
	.data	0
	.data	0
	.data	0
	.data	0
	.data	1
	.data	1
	.data	2
	.data	1
	.data	0
	.data	0
	.data	0
	.data	0
	.data	1
	.data	0
	.data	1
	.data	1
	.data	1
	.data	1
	.data	2
	.data	1
	.data	1
	.data	1
	.data	1
