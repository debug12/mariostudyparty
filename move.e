move	call	players.intro	players.r
	
	call	wait		wait.r

	call	players.draw	players.r
	call	gui		gui.r

	cp	dice.x		move.dx
	cp	dice.y		move.dy
	call	dice		dice.r

	call	wait		wait.r

	//call	players.draw	players.r
	//call	gui		gui.r

	cp	move.spaces	move.x
	add	move.spaces	move.spaces	one
	cpfa	move.cur	players.loc	players.id
	cp	waittime.value	move.delay
	
move.m1		sub	move.spaces	move.spaces	one
		be	move.end	move.spaces	negone
		add	move.cur	move.cur	one
		be	move.res	move.cur	bd.size
move.m2		cpta	move.cur	players.loc	players.id
		call	players.draw	players.r
		call	gui		gui.r
		call	waittime	waittime.r
		be	move.m1		0		0
	
move.res	cp	move.cur	one
		be	move.m2		0		0


move.end	ret	move.r

move.r	.data	0
move.x	.data	40
move.dx	.data	280
move.dy	.data	200
move.delay	.data	1000
move.spaces	.data	0
move.cur	.data	0
