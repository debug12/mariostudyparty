wait	call	key		key.r
		//call	music.play	music.r
		be	wait		key.press	zero
	
	ret	wait.r



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
