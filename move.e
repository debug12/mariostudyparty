move	call	players.draw	players.r

	call	players.intro	players.r
	
	call	wait		wait.r

	call	players.draw	players.r
	call	gui		gui.r

	cp	dice.x		move.dx
	cp	dice.y		move.dy
	call	dice		dice.r

	call	wait		wait.r

	//call	players.draw	players.r
	//call	gui		gui.r

	cp	move.spaces	dice.val
	add	move.spaces	move.spaces	one
	cpfa	move.cur	players.loc	players.id
	cp	waittime.value	move.delay
	
move.m1		sub	move.spaces	move.spaces	one
		be	move.end	move.spaces	negone
		add	move.cur	move.cur	one
		be	move.res	move.cur	bd.size
move.m2		cpta	move.cur	players.loc	players.id
		call	players.draw	players.r
		call	waittime	waittime.r
		be	move.m1		0		0
	
move.res	cp	move.cur	one
		be	move.m2		0		0


move.end	cpfa	move.coins	players.coins	players.id

		mult	move.spot	move.cur	five
		add	move.spot	move.spot	three
		cpfa	move.spot	bd.dat		move.spot

		be	move.star	move.cur	game.star
		be	move.blue	move.spot	bd.blue
		be	move.red	move.spot	bd.red
		be	move.bowser	move.spot	bd.bowser
		be	move.store	move.spot	bd.store
		be	move.event	move.spot	bd.event
		be	move.ret	0		0

move.star	cp	bd.quad		five
		call	bd		bd.r
		cp	bmp.x		zero
		cp	bmp.y		zero
move.enough	cpfa	move.coins	players.coins	players.id
		blt	move.notenough	move.coins	twenty


		cp	bmp.id		img.chenstar
		call	bmp		bmp.r
move.starwait	call	key		key.r
		be	move.enough	key.val		key.y
		be	move.starend	key.val		key.n
		be	move.starwait	0		0

move.enough	cpfa	move.coins	players.coins	players.id
		blt	move.starend	move.coins	twenty

move.staryes	cpfa	move.stars	players.stars	players.id
		add	move.stars	move.stars	one
		sub	move.coins	move.coins	twenty
		cpta	move.stars	players.stars	players.id
		cpta	move.coins	players.coins	players.id


move.starend	be	move.ret	0		0

move.notenough	cp	bmp.id		img.chenstar2
		call	bmp		bmp.r

move.blue	add	move.coins	move.coins	game.bluecoins
		cpta	move.coins	players.coins	players.id
		be	move.ret	0		0

move.red	blt	move.red2	two		move.coins
		be	move.ret	0		0

move.bowser	cp	bd.quad		five
		call	bd		bd.r	
		cp	bmp.x		zero
		cp	bmp.y		zero
		cp	bmp.id		img.bowser1
		call	bmp		bmp.r
		call	wait		wait.r
		cp	bmp.id		img.bowser2
		call	bmp		bmp.r
		call	wait		wait.r

		cp	waittime.value	move.delay
		cp	bmp.x		move.wheelx
		cp	bmp.y		move.wheely
move.wheel	be	move.endwheel	move.wheeli	four
		cpfa	bmp.id		img.wheel1	move.wheeli
		call	bmp		bmp.r
		add	move.wheeli	move.wheeli	one
		call	waittime	waittime.r
		be	move.wheel	0		0
		
		
move.endwheel	cp	move.wheeli	zero
		call	wait		wait.r
		cp	bmp.x		zero
		cp	bmp.y		zero
		cp	bmp.id		img.bowser1
		call	bmp		bmp.r
		call	wait		wait.r
		cp	bmp.id		img.bowser3
		call	bmp		bmp.r
		call	wait		wait.r
		cpta	zero		players.coins	one
		be	move.ret	0		0

move.store	
		be	move.ret	0		0

move.event	be	move.ret	0		0

move.red2	sub	move.coins	move.coins	game.redcoins
		cpta	move.coins	players.coins	players.id
		be	move.ret	0		0

move.ret	call	players.draw	players.r
		call	gui		gui.r	
		ret	move.r


move.wheeli	.data	0
move.wheelx	.data	200
move.wheely	.data	120
move.spot	.data	0
move.coins	.data	0
move.stars	.data	0
move.r	.data	0
move.dx	.data	280
move.dy	.data	200
move.delay	.data	1000
move.spaces	.data	0
move.cur	.data	0
