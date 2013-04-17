over		cp	bd.quad		five
		call	bd		bd.r

over.win	cpfa	over.stars	players.stars	over.i
		cpfa	over.coins	players.coins	over.i

		blt	over.skip	over.stars	over.max
		blt	over.less	over.max	over.stars

		blt	over.coinsmore	over.maxcoins	over.coins
		be	over.skip	0		0		

over.coinsmore	cp	over.maxcoins	over.coins
		cp	over.maxi	over.i

		be	over.skip	0		0

over.less	cp	over.max	over.stars
		cp	over.maxcoins	over.coins
		cp	over.maxi	over.i
		
over.skip	add	over.i		over.i		one
		bne	over.win	over.i		game.players

		cp	bmp.id		img.winner
		cp	bmp.x		over.tx
		cp	bmp.y		over.ty
		call	bmp		bmp.r

		call	wait		wait.r

		cpfa	bmp.id		img.mario	over.maxi
		cp	bmp.x		over.x
		cp	bmp.y		over.y
		cp	bmp.scale	over.scale


		be	over.inst	bmp.id		img.pmchen
		be	over.inst	bmp.id		img.eshild
		be	over.inst	bmp.id		img.leekatt
		be	over.inst	bmp.id		img.kominsky

		be	over.horse	bmp.id		img.horse
		
		be	over.draw	0		0

over.inst	cp	bmp.scale	eight
		be	over.draw	0		0

over.horse	cp	bmp.scale	four
		be	over.draw	0		0

		
over.draw	cp	bmp.override	one
		call	bmp		bmp.r

		call	wait		wait.r

		ret	over.r
		
	

over.tx		.data	100
over.ty		.data	20
over.x		.data	100
over.y		.data	60
over.scale	.data	20
over.stars	.data	0
over.coins	.data	0
over.max	.data	0
over.maxi	.data	0
over.maxcoins	.data	0
over.i		.data	0
over.r		.data	0
	
