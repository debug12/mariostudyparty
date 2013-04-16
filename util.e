wait	call	key		key.r
		//call	music.play	music.r
		be	wait		key.press	zero
		be	wait.change	key.val		key.p
		bne	wait		key.val		key.space
	
wait.ret	ret	wait.r

wait.change	cp	img.mario	img.pmchen
		cp	img.luigi	img.eshild
		cp	img.yoshi	img.leekatt
		cp	img.toad	img.kominsky
		cp	img.mario_icon	img.pmchen
		cp	img.luigi_icon	img.eshild
		cp	img.yoshi_icon	img.leekatt
		cp	img.toad_icon	img.kominsky

		be	wait.ret	0		0



waittime	add	waittime.iter	waittime.iter		one
waittime2	add	waittime.iter2	waittime.iter2		one
		bne	waittime2	waittime.iter2	waittime.value
		cp	waittime.iter2	zero
		bne	waittime	waittime.iter	waittime.value
		cp	waittime.iter	zero
		cp	waittime.iter2	zero
		ret	waittime.r




wait.r			.data	0
waittime.r 		.data	0
waittime.value	.data	0
waittime.iter	.data	0
waittime.iter2	.data	0
