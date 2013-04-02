start	call	clear	clear.r	
	call	load	load.r
	cp	bmp.x	zero
	cp	bmp.y	zero
	cp	bmp.id	one
	cp	bmp.scale	four
	call	bmp	bmp.r
end	halt

zero	.data	0
one	.data	1
two	.data	2
three	.data	3
four	.data	4

// drivers
#include drivers/vga.e
#include drivers/sdc.e
#include drivers/sdr.e

#include drawImg.e
#include load.e
#include imgaddr.e
#include clear.e

