start	call	clear		clear.r	
	call	load		load.r


	cp	bmp.scale	four
	cp	bmp.x		zero
	cp	bmp.y		zero
	cp	bmp.id		img.bg
	call	bmp		bmp.r

	
	call	wait		wait.r

	call	rand.init	rand.r

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
	be	res		game.curPlayer	game.players
	be	main		0		0

res		cp	game.curPlayer	zero

		be	main.skipgame	main.demo	one
		call	sel		sel.r

		call	wait		wait.r


		cp	main.demo	one

		call	g1		g1.r
		call	mini		mini.r

main.skipgame	add	main.i		main.i		one
			be	end		main.i		game.rounds
	
		be	main		0		0


	

end	call	over	over.r
	halt

main.i	.data	0
main.demo	.data	0



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
#include game1.e
#include rand.e
#include minigameinfo.e
#include select.e
#include over.e
