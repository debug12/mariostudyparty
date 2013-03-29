sp	out	42	sp.samp
	out	40	sp.on
sp.re	in	41	sp.res
	be	sp.re	sp.res	sp.off
	out	40	sp.off
sp.re2	in	41	sp.res
	be	sp.re2	sp.res	sp.on
	ret	sp.r
	
sp.r	.data	0
sp.res	.data	0
sp.on	.data	1
sp.off	.data	0
sp.samp	.data	0
