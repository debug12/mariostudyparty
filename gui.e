gui	cp	rect.borcol	col.orange
	cp	rect.col	col.yellow
	cp	rect.borwidth	four
	cp	rect.w		gui.width
	cp	rect.h		gui.height

	cp	gui.id		zero
	cp	gui.x		gui.x1
	cp	gui.y		gui.y1
	call	gui.draw	gui.drawr

	cp	gui.id		one
	cp	gui.x		gui.x2
	cp	gui.y		gui.y1
	call	gui.draw	gui.drawr

	cp	gui.id		two
	cp	gui.x		gui.x1
	cp	gui.y		gui.y3
	call	gui.draw	gui.drawr

	cp	gui.id		three
	cp	gui.x		gui.x2
	cp	gui.y		gui.y3
	call	gui.draw	gui.drawr
		
	ret	gui.r

gui.r	.data	0


gui.draw	cp	rect.x		gui.x
		cp	rect.y		gui.y
		call	rect		rect.r

		add	bmp.id		img.mario_icon	gui.id
		add	bmp.x		gui.x		gui.iconx
		add	bmp.y		gui.y		gui.icony
		call	bmp		bmp.r

		cpfa	drawnum.num	players.coins	gui.id
		add	drawnum.x	gui.x		gui.coinsx
		add	drawnum.x	drawnum.x	twentyfour
		add	drawnum.y	gui.y		gui.coinsy
		call	drawnum		drawnum.r

		cpfa	drawnum.num	players.stars	gui.id
		add	drawnum.x	gui.x		gui.coinsx
		add	drawnum.x	drawnum.x	twentyfour
		add	drawnum.y	gui.y		gui.starsy
		call	drawnum		drawnum.r

		cp	bmp.id		img.coins
		add	bmp.x		gui.x		gui.coinsx
		add	bmp.y		gui.y		gui.coinsy
		call	bmp		bmp.r

		cp	bmp.id		img.stars	
		add	bmp.y		gui.y		gui.starsy
		call	bmp		bmp.r
		

		ret gui.drawr

gui.drawr	.data	0

gui.width	.data	160
gui.height	.data	80
gui.id		.data	0
gui.x		.data	0
gui.y		.data	0
gui.x1		.data	20
gui.y1		.data	20
gui.x2		.data	460
gui.y3		.data	380
gui.iconx	.data	12
gui.icony	.data	12
gui.coinsx	.data	80	
gui.coinsy	.data	20
gui.starsy	.data	44
