start	call	clear		clear.r	
	call	load		load.r
	cp	bmp.scale	four

	cp	bmp.x		zero
	cp	bmp.y		zero
	cp	bmp.id		img.bg
	call	bmp		bmp.r

wait	call	key		key.r
	be	wait		key.press	zero

	call	menu		menu.r

	call	bd		bd.r

end	halt


// drivers
#include drivers/vga.e
#include drivers/sdc.e
#include drivers/sdr.e
#include drivers/key.e
#include drivers/snd.e

#include drawImg.e
#include load.e
#include imgaddr.e
#include clear.e
#include num.e
#include board.e
#include imgnames.e
#include menu.e
#include game.e
#include col.e

