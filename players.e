// players.e
// draws current player
// as well as any other players
// in same quadrant to screen
// written by Andrew

players.intro	cpfa	bmp.id		img.player1	players.id
		cp	bmp.x		players.introx
		cp	bmp.y		players.introy
		call	bmp		bmp.r

		ret	players.r

players.draw	cp	players.i	zero	
		cpfa	players.index	players.loc	players.id
		mult	players.index	players.index	five
		add	bmp.id		players.index	two
		cpfa	bmp.id		bd.dat		bmp.id
		cp	bd.quad		bmp.id
		call	bd		bd.r
		
players.draw1	cpfa	players.index	players.loc	players.i
		mult	players.index	players.index	five
		add	bmp.id		players.index	two
		cpfa	bmp.id		bd.dat		bmp.id
		cp	players.temp	bmp.id
		bne	players.inci	players.temp	bd.quad

		cpfa	bmp.id		img.mario	players.i
		cpfa	bmp.x		bd.dat		players.index
		mult	bmp.x		bmp.x		four
	
		bne	players.asd	players.index	zero
		mult	players.temp	players.i	players.spacing
		add	bmp.x		bmp.x		players.temp
		
players.asd	add	bmp.y		players.index	one
		cpfa	bmp.y		bd.dat		bmp.y
		mult	bmp.y		bmp.y		four
		

		bne	players.notscale	img.mario	img.pmchen
		cp	bmp.scale		two
		call	bmp			bmp.r
		cp	bmp.scale		four
		be	players.inci		0		0

players.notscale	call	bmp		bmp.r

players.inci	add	players.i	players.i	one
		bne	players.draw1	players.i	game.players

players.end	ret	players.r

players.index	.data	0
players.i	.data	0
players.introx	.data	80
players.introy	.data	160
players.r	.data	0
players.id	.data	0
players.temp	.data	0
players.spacing	.data	32
players.coins	.data	10
		.data	10
		.data	10
		.data	10
players.stars	.data	0
		.data	0
		.data	0
		.data	0
players.loc	.data	0
		.data	0
		.data	0
		.data	0
players.result	.data	0
		.data	0
		.data	0
		.data	0
