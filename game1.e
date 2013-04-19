// game1.e
// written by Andrew, Deepak
// contains the NUMBERPALOOZA
// minigame. 

// initialization
g1		call	g1.clearcup	g1.clearcupr
		call	g1.clearstar	g1.clearstarr
	
		
		// instructions
		cp	bmp.id		img.g1info
		cp	bmp.x		zero
		cp	bmp.y		zero
		call	bmp		bmp.r
		
		call	wait		wait.r
		cp	waittime.value	g1.delay

		// generate target score
		call	rand		rand.r
		add	rand.out	rand.out	eight
		mult	rand.out	rand.out	three
		cp	g1.target	rand.out

		call	g1.clearcup	g1.clearcupr
		call	g1.clearstar	g1.clearstarr

		cp	bmp.x		g1.targetx
		cp	bmp.y		g1.targety
		cp	bmp.id		img.target
		call	bmp		bmp.r	

		// display target
		cp	drawnum.num	g1.target
		cp	drawnum.x	g1.targetx2
		cp	drawnum.y	g1.targety2
		cp	drawnum.scale	sixteen
		call	drawnum		drawnum.r
		cp	drawnum.scale	four

		call	wait		wait.r
		

		cp	g1.player	zero

		//call	g1.clearcup	g1.clearcupr
		//call	g1.clearstar	g1.clearstarr
		//call	g1.drawcup	g1.drawcupr

g1.begin	//beginning of game
		call	g1.clearcup	g1.clearcupr
		call	g1.clearstar	g1.clearstarr
		cp	players.id	g1.player
		cp	g1.score	zero
		cp	g1.stari	zero
		cp	g1.starj	zero
		cp	g1.cupx		zero
		cp	g1.num		one
		cp	g1.numdone	zero
		cpta	zero		players.result	g1.player
		
		call	players.intro	players.r
		call	wait		wait.r

g1.main		call	waittime	waittime.r
		call	key		key.r
		be	g1.key1		key.press	one
g1.draw		add	g1.stari	g1.stari	one
		be	g1.upstar	g1.stari	g1.starmax

		//cp	drawnum.scale	eight
		//call	drawnum		drawnum.r
		//cp	drawnum.scale	four

		be	g1.main		0		0

g1.done		call	g1.clearstar	g1.clearstarr
		call	g1.clearcup	g1.clearcupr
		cp	bmp.x		g1.collx
		cp	bmp.y		g1.colly
		cp	bmp.id		img.collected
		call	bmp		bmp.r

		cp	drawnum.x	g1.coltx
		cp	drawnum.y	g1.colty
		cp	drawnum.scale	eight
		cp	drawnum.num	g1.score
		call	drawnum		drawnum.r
		cp	drawnum.scale	four

		call	wait		wait.r
	

		bne		g1.copyskip	g1.score	g1.target
		cpta	ten	players.result	g1.player

g1.copyskip

		add	g1.player	g1.player	one
		be	g1.end		g1.player	game.players
		be	g1.begin	0		0

g1.end		ret	g1.r

g1.player	.data	0

g1.collx	.data	200
g1.colly	.data	200
g1.coltx	.data	280
g1.colty	.data	236
g1.targetx	.data	200
g1.targety	.data	140
g1.targetx2	.data	220
g1.targety2	.data	180
g1.target	.data	0
///////////////////////////////////////////////////////////////////

// i have no idea why i thought stars were involved with this.
// its actually coins.
//lololol

// updates the numbers falling from the top of the screen
// generates new number
g1.upstar	cp	g1.stari	zero
		cp	g1.starj	zero
		call	g1.clearstar	g1.clearstarr
		call	g1.clearcup	g1.clearcupr
		
		
g1.starbegin	be	g1.donestar	g1.starj	g1.num
		mult	g1.starindex	g1.starj	four
		cpfa	g1.staractive	g1.grid		g1.starindex
		be	g1.incj		g1.staractive	zero
		add	g1.starindex	g1.starindex	one
		cpfa	bmp.x		g1.grid		g1.starindex
		cp	g1.starx	bmp.x
		add	g1.starindex	g1.starindex	one
		cpfa	bmp.y		g1.grid		g1.starindex

		be	g1.drawskip	bmp.y		vga.h
		add	g1.starindex	g1.starindex	one
		cpfa	g1.startype	g1.grid		g1.starindex
		cpfa	bmp.id		img.n1		g1.startype
		add	bmp.x		bmp.x		four
		add	bmp.y		bmp.y		four
		cp	bmp.scale	twelve
		call	bmp		bmp.r
		cp	bmp.scale	four
		sub	bmp.x		bmp.x		four
		sub	bmp.y		bmp.y		four

g1.drawskip

		cp	g1.startemp	bmp.y
		add	g1.startemp	g1.startemp	g1.cupdx
		bne	g1.starskip	g1.startemp	vga.h
	
		sub	g1.starindex	g1.starindex	three
		cpta	zero		g1.grid		g1.starindex
		add	g1.numdone	g1.numdone	one
		bne	g1.countskip	g1.cupx		g1.starx

		add	g1.score	g1.score	g1.startype
		add	g1.score	g1.score	one

g1.countskip	be	g1.done		g1.numdone	g1.max
		be	g1.incj		0		0


g1.starskip	sub	g1.starindex	g1.starindex	one
		add	bmp.y		bmp.y		g1.cupdx
		cpta	bmp.y		g1.grid		g1.starindex

g1.incj		add	g1.starj	g1.starj	one
		be	g1.starbegin	0		0
		

g1.donestar	// create new coin	
		blt	g1.nomoreskip	g1.max		g1.num		

		mult	g1.starindex	g1.num		four
		cpta	one		g1.grid		g1.starindex
		add	g1.starindex	g1.starindex	one
		call	rand		rand.r
		mult	g1.starx	rand.out	g1.cupdx
		cpta	g1.starx	g1.grid		g1.starindex
		add	g1.starindex	g1.starindex	one
		cpta	zero		g1.grid		g1.starindex
		add	g1.starindex	g1.starindex	one
		call	rand		rand.r
		cpta	rand.out	g1.grid		g1.starindex

g1.incnum	add	g1.num		g1.num		one
		

g1.nomoreskip	call	g1.drawcup	g1.drawcupr
		be	g1.main		0		0

g1.staractive	.data	0
g1.starindex	.data	0
g1.starx	.data	0
g1.startemp	.data	0
g1.startype	.data	0

///////////////////////////////////////////////////////////////////

//handles input
g1.key1		be	g1.keya		key.val		key.a
		be	g1.keyd		key.val		key.d
g1.key2		blt	g1.cupleft	g1.cupx		zero
		be	g1.cupright	g1.cupx		vga.w
		call	g1.clearcup	g1.clearcupr
		cp	bmp.x		g1.cupx
		cp	bmp.y		g1.cupy
		cp	bmp.id		img.cup
		call	bmp		bmp.r
		be	g1.draw		0		0


g1.cupleft	cp	g1.cupx		zero
		be	g1.draw		0		0
g1.cupright	sub	g1.cupx		vga.w		g1.cupdx
		be	g1.draw		0		0

g1.keya		sub	g1.cupx		g1.cupx		g1.cupdx
		be	g1.key2		0		0
		
g1.keyd		add	g1.cupx		g1.cupx		g1.cupdx
		be	g1.key2		0		0


g1.clearcup	cp	vga.col		col.skyblue
		cp	vga.x1		zero
		cp	vga.y1		g1.cupy
		cp	vga.x2		vga.w
		cp	vga.y2		vga.h
		call	vga		vga.r
		ret	g1.clearcupr
g1.clearcupr	.data	0

g1.clearstar	cp	vga.col		col.skyblue
		cp	vga.x1		zero
		cp	vga.y1		zero
		cp	vga.x2		vga.w
		cp	vga.y2		g1.cupy
		call	vga		vga.r
		ret	g1.clearstarr
g1.clearstarr	.data	0

g1.drawcup	cp	bmp.id		img.cup
		cp	bmp.x		g1.cupx
		cp	bmp.y		g1.cupy
		call	bmp		bmp.r
		ret	g1.drawcupr
g1.drawcupr	.data	0

g1.score	.data	0
g1.stari	.data	0
g1.starj	.data	0
g1.starmax	.data	10
g1.cupdx	.data	80
g1.cupx		.data	0
g1.cupy		.data	400
g1.delay	.data	10
g1.r		.data	0
g1.num		.data	1
g1.max		.data	20
g1.numdone	.data	0
g1.grid		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
		.data	0
