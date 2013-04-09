menu	cp	bmp.id		img.menu
	cp	bmp.x		zero
	cp	bmp.y		zero
	call	bmp		bmp.r

menu.drawops	cp	bmp.col		menu.po
		mult	bmp.col		col.red		bmp.col
		cp	bmp.id		img.players
		cp	bmp.x		menu.px
		cp	bmp.y		menu.py
		call	bmp		bmp.r
		cp	bmp.col		negone

	cp	bmp.col		menu.ro
	mult	bmp.col		col.red		bmp.col
	cp	bmp.id		img.rounds
	cp	bmp.y		menu.ry
	call	bmp		bmp.r
	cp	bmp.col		negone

	add	menu.img	img.num1	game.players
	sub	menu.img	menu.img	one
	cp	bmp.id		menu.img
	cp	bmp.y		menu.py
	cp	bmp.x		menu.pnx
	call	bmp		bmp.r

	div	menu.img	game.rounds	five
	add	menu.img	menu.img	img.num5
	sub	menu.img	menu.img	one
	cp	bmp.id		menu.img
	cp	bmp.y		menu.ry
	cp	bmp.x		menu.pnx
	call	bmp		bmp.r

menu.w1	call	key		key.r
	//call	music.play	music.r
	be	menu.keypress	key.press	one
	
	be	menu.drawops	0		0

menu.keypress	be	menu.updown	key.val		key.w
		be	menu.updown	key.val		key.s
		be	menu.left	key.val		key.a
		be	menu.right	key.val		key.d
		be	menu.done	key.val		key.space

		be	menu.drawops	0		0

menu.updown	sub		menu.po		one		menu.po
		sub		menu.ro		one		menu.ro
		be		menu.drawops	0		0

menu.left	be		menu.decp	menu.po		one
		be		menu.decr	0		0

menu.right	be		menu.incp	menu.po		one
		be		menu.incr	0		0


menu.incp	add		game.players	game.players	one
		be		menu.resp4	game.players	five
		be		menu.drawops	0		0

menu.decp	sub		game.players	game.players	one
		be		menu.resp0	game.players	zero
		be		menu.drawops	0		0

menu.resp4	cp		game.players	four
		be		menu.drawops	0		0

menu.resp0	cp		game.players	one
		be		menu.drawops	0		0

menu.incr	add		game.rounds	game.rounds	five
		be		menu.resr25	game.rounds	twentyfive
		be		menu.drawops	0		0

menu.decr	sub		game.rounds	game.rounds	five
		be		menu.resr0	game.rounds	zero
		be		menu.drawops	0		0

menu.resr25	cp		game.rounds	twenty
		be		menu.drawops	0		0

menu.resr0	cp		game.rounds	five
		be		menu.drawops	0		0

	
menu.done	ret	menu.r



menu.px		.data	80
menu.py		.data	100
menu.rx		.data	0
menu.ry		.data	160
menu.pnx	.data	400
menu.r		.data	0
menu.img	.data	0
menu.po		.data	1
menu.ro		.data	0


