players.draw	cpfa	bmp.id		img.mario	players.id

		cpfa	bmp.x		players.loc	players.id
		mult	bmp.x		bmp.x		five
		cpfa	bmp.x		bd.dat		bmp.x
		mult	bmp.x		bmp.x		four

		cpfa	bmp.y		players.loc	players.id
		mult	bmp.y		bmp.y		five
		add	bmp.y		bmp.y		one
		cpfa	bmp.y		bd.dat		bmp.y
		mult	bmp.y		bmp.y		four
		
		call	bmp		bmp.r

players.end	ret	players.r

players.r	.data	0
players.id	.data	0


players.coins	.data	0
		.data	0
		.data	0
		.data	0
players.stars	.data	0
		.data	0
		.data	0
		.data	0
players.loc	.data	1
		.data	5
		.data	6
		.data	8
