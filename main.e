start	call	clear		clear.r	
	call	load		load.r

	cp	bmp.scale	four

	call	bd		bd.r

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
#include board.e
#include imgnames.e

