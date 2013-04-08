drawnum		cp	vga.col		col.white
		cp	vga.x1		drawnum.x
		cp	vga.y1		drawnum.y
		mult	vga.x2		eleven		four
		add	vga.x2		drawnum.x	vga.x2
		add	vga.y2		drawnum.y	twenty
		call	vga		vga.r

		div	drawnum.d0	drawnum.num	hundred
		mult	drawnum.temp	drawnum.d0	hundred
		sub	drawnum.num	drawnum.num	drawnum.temp
		div	drawnum.d1	drawnum.num	ten
		mult	drawnum.temp	drawnum.d1	ten
		sub	drawnum.num	drawnum.num	drawnum.temp
		cp	drawnum.d2	drawnum.num

		cpfa	bmp.id		img.n0		drawnum.d0
		cp	bmp.x		drawnum.x
		cp	bmp.y		drawnum.y
		call	bmp		bmp.r

		add	bmp.x		bmp.x		sixteen
		cpfa	bmp.id		img.n0		drawnum.d1
		call	bmp		bmp.r

		add	bmp.x		bmp.x		sixteen
		cpfa	bmp.id		img.n0		drawnum.d2
		call	bmp		bmp.r

		ret	drawnum.r

drawnum.r	.data	0
drawnum.temp	.data	0
drawnum.num	.data	0
drawnum.d0	.data	0
drawnum.d1	.data	0
drawnum.d2	.data	0
drawnum.w	.data	12
drawnum.h	.data	20
drawnum.x	.data	0
drawnum.y	.data	0
