menu	cp	bmp.id		img.players
	cp	bmp.x		menu.px
	cp	bmp.y		menu.py
	call	bmp		bmp.r

	cp	bmp.id		img.rounds
	cp	bmp.y		menu.ry
	call	bmp		bmp.r
	
menu.w	call	key		key.r
	bne	menu.w		key.val		key.space
	
	ret	menu.r



menu.px	.data	80
menu.py	.data	140
menu.rx	.data	0
menu.ry	.data	200
menu.r	.data	0


