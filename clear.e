// clear.e
// written by Andrew
// clears the screen to the color specified
// by clear.col

clear	cp	vga.x1	zero
	cp	vga.y1	zero
	cp	vga.x2	vga.w
	cp	vga.y2	vga.h
	cp	vga.col	clear.col
	call	vga	vga.r
	ret 	clear.r

clear.r	.data	0
clear.col	.data	252
