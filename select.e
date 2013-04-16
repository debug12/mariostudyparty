sel	cp	rect.x		twenty
	cp	rect.y		twenty
	sub	rect.w		vga.w	forty
	sub	rect.h		vga.h	forty
	cp	rect.col	col.yellow
	cp	rect.borcol	col.orange
	call	rect		rect.r
	
	cp	bmp.x		sel.mtx
	cp	bmp.y		sel.mty
	cp	bmp.id		img.minigame
	call	bmp		bmp.r
	cp	sel.mti	zero
	cp	sel.i	zero
	cp	sel.j	zero
	cp	sel.mcur	zero

	call	rand		rand.r
	add	rand.out	rand.out	twenty
	add	rand.out	rand.out	five
	cp	sel.jmax	rand.out

		cp	waittime.value	sel.delay

sel.high	cp	sel.mtcur	sel.mty2

////////////////////////////

sel.draw	cp	bmp.x		sel.mtx2
		cp	bmp.y		sel.mtcur

		be	sel.red		sel.mcur	sel.mti
		be	sel.yel		0	0

sel.red		cp	bmp.id		img.number2
		be	sel.skip	0		0

sel.yel		cp	bmp.id		img.number
	
sel.skip	call	bmp		bmp.r

		add	sel.mti		sel.mti	one

		add	sel.mtcur	sel.mtcur	sel.mtdy
		bne	sel.draw	sel.mti		four

////////////////////////////
		
		cp	sel.mti		zero


		add	sel.j		sel.j		one

		be	sel.done	sel.j		sel.jmax

		call	waittime	waittime.r

		add	sel.mcur	sel.mcur	one

		bne	sel.high	sel.mcur	four
		cp	sel.mcur	zero
		be	sel.high	0		0

sel.done	ret	sel.r


sel.r		.data	0
sel.i		.data	0
sel.j		.data	0
sel.jmax	.data	38
sel.mtx		.data	56
sel.mty		.data	48
sel.mtcur	.data	0
sel.mti		.data	0
sel.delay	.data	600
sel.mtx2	.data	140
sel.mty2	.data	220
sel.mtdy	.data	48
sel.mcur	.data	0
