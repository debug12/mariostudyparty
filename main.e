start	call	clear		clear.r	
	call	load		load.r
	cp	bmp.scale	four

	cp	bmp.x		zero
	cp	bmp.y		zero
	cp	bmp.id		img.bg
	call	bmp		bmp.r

	call	wait		wait.r

	call	menu		menu.r

	cp	bd.quad		five
	call	bd		bd.r

	call	info		info.r
		
	//call	rollfirst	rollfirst.r

	//cp	bd.quad		three
	//call	bd		bd.r

	call	players.draw	players.r

	call	gui		gui.r

end	halt


// drivers
#include drivers/vga.e
#include drivers/sdc.e
#include drivers/sdr.e
#include drivers/key.e
#include drivers/snd.e
#include drivers/time.e

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
#include gui.e
#include rect.e
#include drawnum.e
#include players.e
#include info.e
#include util.e
#include rollfirst.e
#include dice.e
