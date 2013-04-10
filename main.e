start	call	clear		clear.r	
	call	load		load.r

	call	music.init	music.initr

	cp	bmp.scale	four
	cp	bmp.x		zero
	cp	bmp.y		zero
	cp	bmp.id		img.bg
	call	bmp		bmp.r

mus	//call	music.play	music.r
	//be	musp		music.finish	one
	//be	mus		0		0
	
musp	call	wait		wait.r

	call	menu		menu.r

	cp	bd.quad		five
	call	bd		bd.r

	call	info		info.r

	//cp	bd.quad		three
	//call	bd		bd.r	

main	cp	players.id	game.curPlayer
	call	move		move.r
	call	gui		gui.r
	call	wait		wait.r
	add	game.curPlayer 	game.curPlayer	one
	be	res		game.curPlayer	four
	be	main		0		0

res	cp	game.curPlayer	zero
	be	main		0		0


	

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
#include music.e
#include move.e
#include star.e
