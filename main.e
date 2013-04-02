start	call	clear	clear.r	
	call	load	load.r

	cp	bmp.x	zero
	cp	bmp.y	zero
	cp	bmp.scale	four
	cp	bmp.id	four
	call 	bmp	bmp.r

end	halt


// drivers
#include drivers/vga.e
#include drivers/sdc.e
#include drivers/sdr.e

#include drawImg.e
#include load.e
#include imgaddr.e
#include clear.e
#include num.e

