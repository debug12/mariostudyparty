// SD card driver. to read from 

sdc	out	82	zero
	out	83	sdc.low
	out	84	sdc.hi
	out	80	one
	
sdc.w1	in	81	sdc.res
	be	sdc.w1	sdc.res	zero

	// read return paremeter while response is 1	
	in	86	sdc.read

	out	80	zero
	
sdc.w2	in	81	sdc.res
	be	sdc.w1	sdc.res	one
	
	ret	sdc.r
	

sdc.low	.data	0
sdc.hi	.data	0
sdc.r	.data	0
sdc.res	.data	0
sdc.read	.data	0
