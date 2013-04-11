g1		call	g1.clearcup	g1.clearcupr
		call	g1.clearstar	g1.clearstarr
	
		cp	bmp.id		img.g1info
		cp	bmp.x		zero
		cp	bmp.y		zero
		call	bmp		bmp.r
		
		call	wait		wait.r
		cp	waittime.value	g1.delay

		call	g1.clearcup	g1.clearcupr
		call	g1.clearstar	g1.clearstarr
		call	g1.drawcup	g1.drawcupr

g1.main		call	waittime	waittime.r
		call	key		key.r
		be	g1.key1	key.press	one
g1.draw		add	g1.stari	g1.stari	one
		be	g1.upstar	g1.stari	g1.starmax
		be	g1.main		0		0
///////////////////////////////////////////////////////////////////

g1.upstar	cp	g1.stari	zero
		cp	g1.starj	zero
		call	g1.clearstar	g1.clearstarr
		call	g1.clearcup	g1.clearcupr
		call	g1.drawcup	g1.drawcupr
g1.starbegin	be	g1.donestar	g1.starj	g1.num
		mult	g1.starindex	g1.starj	three
		cpfa	bmp.x		g1.grid		g1.starindex
		add	g1.starindex	g1.starindex	one
		cpfa	bmp.y		g1.grid		g1.starindex

		add	bmp.y		bmp.y		g1.cupdx
		cpta	bmp.y		g1.grid		g1.starindex

		add	g1.starindex	g1.starindex	one
		cpfa	g1.starindex	g1.grid		g1.starindex
		cpfa	bmp.id		img.coin	g1.starindex
		call	bmp		bmp.r

		add	g1.starj	g1.starj	one
		be	g1.starbegin	0		0
		

g1.donestar	be	g1.main		0		0

g1.starindex	.data	0

///////////////////////////////////////////////////////////////////

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

g1.end		ret	g1.r

g1.stari	.data	0
g1.starj	.data	0
g1.starmax	.data	10
g1.cupdx	.data	80
g1.cupx		.data	0
g1.cupy		.data	400
g1.delay	.data	10
g1.r		.data	0
g1.num		.data	1
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
