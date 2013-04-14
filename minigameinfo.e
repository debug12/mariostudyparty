mini		cp	vga.x1		zero
		cp	vga.x2		vga.w
		cp	vga.y1		zero
		cp	vga.y2		vga.h
		cp	vga.col		col.skyblue
		call	vga		vga.r

		cp	rect.w		mini.bw
		cp	rect.h		mini.bh
		cp	rect.x		mini.bx
		cp	rect.y		mini.by
		cp	rect.col	col.yellow
		cp	rect.borcol	col.orange
		cp	rect.borwidth	four
		call	rect		rect.r

		cp	bmp.x		mini.rx
		cp	bmp.y		mini.ry
		cp	bmp.id		img.results
		call	bmp		bmp.r

		cp	mini.i		zero


mini.begin	mult	mini.cy		mini.dy		mini.i
		add	mini.cy		mini.y		mini.cy
		//add	bmp.x		mini.x		mini.tx
		cp	bmp.x		mini.x
		add	bmp.y		mini.cy		zero
		cpfa	bmp.id		img.mario_icon	mini.i	
		call	bmp		bmp.r
		add	bmp.x		bmp.x		mini.tx
		cp	bmp.id		img.wontotal	
		call	bmp		bmp.r
		

		cp	drawnum.x	mini.wx
		cp	drawnum.y	mini.cy
		cp	drawnum.scale	eight
		cpfa	drawnum.num	players.result	mini.i
		call	drawnum		drawnum.r

		cpfa	mini.temp	players.coins	mini.i
		cpfa	mini.temp2	players.result	mini.i
		add	mini.temp	mini.temp2	mini.temp
		cpta	mini.temp	players.coins	mini.i
		cp	drawnum.num	mini.temp

		cp	drawnum.x	mini.tox
		call	drawnum		drawnum.r
		cp	drawnum.scale	four

		add	mini.i		mini.i		one
		be	mini.end	mini.i		game.players
		be	mini.begin	0		0

mini.end	call	wait		wait.r
		ret	mini.r

mini.temp	.data	0
mini.temp2	.data	0
mini.bx	.data	20
mini.by	.data	20
mini.wx	.data	252
mini.tox	.data	500
mini.bw	.data	600
mini.bh	.data	440
mini.rx	.data	184
mini.ry	.data	32
mini.x	.data	40
mini.cy	.data	0
mini.dy	.data	92
mini.y	.data	80
mini.tx	.data	120
mini.w	.data	560
mini.h	.data	80
mini.i	.data	0
mini.r	.data	0
