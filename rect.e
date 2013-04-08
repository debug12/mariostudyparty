rect	cp	vga.x1	rect.x
	cp	vga.y1	rect.y
	cp	vga.x2	rect.x
	add	vga.x2	rect.w	vga.x2
	cp	vga.y2	rect.y
	add	vga.y2	rect.h	vga.y2
	cp	vga.col	rect.borcol
	call	vga	vga.r

	add	vga.x1	vga.x1	rect.borwidth
	add	vga.y1	vga.y1	rect.borwidth
	sub	vga.x2	vga.x2	rect.borwidth
	sub	vga.y2	vga.y2	rect.borwidth
	cp	vga.col	rect.col
	call	vga	vga.r

	ret	rect.r

rect.x		.data	0
rect.y		.data	0
rect.w		.data	0
rect.h		.data	0
rect.r		.data	0
rect.col	.data	0
rect.borcol	.data	0
rect.borwidth	.data	0
