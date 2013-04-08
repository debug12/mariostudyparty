info	cp	rect.x	info.x
	cp	rect.y	info.y
	cp	rect.w	info.w
	cp	rect.h	info.h
	cp	rect.col	col.yellow
	cp	rect.borcol	col.orange
	cp	rect.borwidth	four
	call	rect	rect.r

	cp	bmp.x	info.x
	cp	bmp.y	info.y
	cp	bmp.id	img.info1
	call	bmp	bmp.r
	
	call	wait	wait.r

	call	rect	rect.r
	cp	bmp.id	img.info2
	call	bmp	bmp.r

	call	wait	wait.r

	call	rect	rect.r
	cp	bmp.id	img.info3
	call	bmp	bmp.r

	call	wait	wait.r

	ret	info.r

info.r	.data	0

info.x	.data	80
info.y	.data	60
info.w	.data	480
info.h	.data	360
