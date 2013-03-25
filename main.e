	cp	bmp.x	x
	cp	bmp.y	y
	cp	bmp.width	width
	cp	bmp.height	height
	cp	bmp.addr	picaddr
	call	bmp	bmp.r
	halt
	
x	.data	50
y	.data	50
width	.data	20
height	.data	22
col	.data	50
	
#include drivers/vga.e

#include menu.e

#include drawImg.e

zero	.data	0
one	.data	1
five	.data	5

picaddr	.data	pic
pic	.data	0

