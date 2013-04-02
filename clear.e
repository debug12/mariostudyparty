clear	cp	vga.x1	zero
	cp	vga.y1	zero
	cp	vga.x2	vga.w
	cp	vga.y2	vga.h
	cp	vga.col	zero
	call	vga	vga.r
	ret 	clear.r

clear.r	.data	0
