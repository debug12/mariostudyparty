wait	call	key		key.r
		call	music.play	music.r
		be	wait		key.press	zero
	
	ret	wait.r



waittime	add	waittime.iter	waittime.iter		one
			add	waittime.iter2	waittime.iter2		one
			be	waittime	waittime.iter	waittime.value
			be	waittime	waittime.iter2	waittime.value
			cp	waittime.iter	zero
			ret	waittime.r




wait.r			.data	0
waittime.r 		.data	0
waittime.value	.data	0
waittime.iter	.data	0
waittime.iter2	.data	0