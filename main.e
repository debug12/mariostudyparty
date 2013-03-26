	cp	bmp.x	x
	cp	bmp.y	y
	cp	bmp.width	width
	cp	bmp.height	height
	cp	bmp.addr	maraddr
	call	bmp	bmp.r
	halt
	
x	.data	10
y	.data	10
width	.data	50
height	.data	77
col	.data	50

zero	.data	0
one	.data	1
	
#include drivers/vga.e
#include drivers/sdc.e

#include menu.e
#include drawImg.e

#include mar.e

