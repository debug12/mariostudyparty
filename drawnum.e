drawnum		mult	drawnum.dx	four		drawnum.scale
		mult	drawnum.dy	five		drawnum.scale
		cp	vga.col		col.white
		cp	vga.x1		drawnum.x
		cp	vga.y1		drawnum.y
		mult	vga.x2		eleven		drawnum.scale
		add	vga.x2		drawnum.x	vga.x2
		sub	vga.x2		vga.x2		one

		add	vga.y2		drawnum.y	drawnum.dy
		sub	vga.y2		vga.y2		one
		call	vga		vga.r


		div	drawnum.d0	drawnum.num	hundred
		mult	drawnum.temp	drawnum.d0	hundred
		sub	drawnum.num	drawnum.num	drawnum.temp
		div	drawnum.d1	drawnum.num	ten
		mult	drawnum.temp	drawnum.d1	ten
		sub	drawnum.num	drawnum.num	drawnum.temp
		cp	drawnum.d2	drawnum.num

		cp	bmp.scale	drawnum.scale

		cpfa	bmp.id		img.n0		drawnum.d0
		cp	bmp.x		drawnum.x
		cp	bmp.y		drawnum.y
		call	bmp		bmp.r


		cp	bmp.scale	drawnum.scale

		add	bmp.x		bmp.x		drawnum.dx
		cpfa	bmp.id		img.n0		drawnum.d1
		call	bmp		bmp.r

		cp	bmp.scale	drawnum.scale

		add	bmp.x		bmp.x		drawnum.dx
		cpfa	bmp.id		img.n0		drawnum.d2
		call	bmp		bmp.r

		cp	bmp.scale	four

		ret	drawnum.r

drawnum.r	.data	0
drawnum.temp	.data	0
drawnum.num	.data	0
drawnum.d0	.data	0
drawnum.d1	.data	0
drawnum.d2	.data	0
drawnum.dx	.data	0
drawnum.dy	.data	0
drawnum.w	.data	12
drawnum.h	.data	20
drawnum.x	.data	0
drawnum.y	.data	0
drawnum.scale	.data	4
