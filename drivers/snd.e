sp	out	42	sp.samp
	out	40	sp.on
sp.r	in	41	sp.res
	be	sp.r	sp.res	sp.off
	out	40	sp.off
sp.r2	in	41	sp.res
	be	sp.r2	sp.res	sp.on
	ret	sp.addr
	
sp.addr	.data	0
sp.res	.data	0
sp.on	.data	1
sp.off	.data	0
sp.samp	.data	0
