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

		be	move.blue	move.spot	bd.blue
		be	move.red	move.spot	bd.red
		be	move.ret	0		0

move.blue	add	move.coins	move.coins	game.bluecoins
		cpta	move.coins	players.coins	players.id
		be	move.ret	0		0

move.red	blt	move.red2	two		move.coins
		be	move.ret	0		0

move.red2	sub	move.coins	move.coins	game.redcoins
		cpta	move.coins	players.coins	players.id
		be	move.ret	0		0

move.ret	//call	players.draw	players.r
		call	gui		gui.r	
		ret	move.r


move.spot	.data	0
move.coins	.data	0
move.r	.data	0
move.dx	.data	280
move.dy	.data	200
move.delay	.data	1000
move.spaces	.data	0
move.cur	.data	0
