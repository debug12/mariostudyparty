music.init	cp	music.id	snd.mario
		mult	music.id	music.id	four
		cpfa	music.s1	imgaddr		music.id
		add	music.id	music.id	one
		cpfa	music.s2	imgaddr		music.id
		add	music.id	music.id	one
		cpfa	music.loc1	imgaddr		music.id
		add	music.id	music.id	one
		cpfa	music.loc2	imgaddr		music.id
		cp	music.ihi	zero
		cp	music.ilo	zero

		ret 	music.initr

music.play	cp	sdc.low		music.loc1
		cp	sdc.hi		music.loc2
	
		call	sdc		sdc.r

		cp	sp.samp		sdc.read
			
		call	sp		sp.r

music.incilo	add	music.ilo	music.ilo	one
	
		bne	music.skip	music.ilo	music.s1
		bne	music.skip	music.ihi	music.s2

		be	music.end	0		0 

music.skip	be	music.incihi	music.ilo	music.imax
		be	music.inclo	0		0

music.incihi	add	music.ihi	music.ihi	one
		cp	music.ilo	zero
		
		bne	music.inclo	music.ilo	music.s1
		bne	music.inclo	music.ihi	music.s2
		
		be	music.end	0		0

music.inclo	add	music.loc1	music.loc1	one
		be	music.inchi	music.loc1	load.sdc
		be	music.ret	0		0
		
music.inchi	add	music.loc2	music.loc2	one	
		cp	music.loc1	zero
		be	music.ret	0		0

music.end	call	music.init	music.initr

music.ret	ret	music.r
	

music.ilo	.data	0
music.ihi	.data	0
music.id	.data	0
music.s1	.data	0
music.s2	.data	0
music.loc1	.data	0
music.loc2	.data	0
music.imax	.data	10000
music.initr	.data	0

music.r		.data	0
