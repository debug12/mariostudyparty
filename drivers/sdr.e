sdr	out	32	sdr.write
	out	33	sdr.x
	out	34	sdr.y
	out	35	sdr.in
	out	30	one

sdr.w0	in	31	sdr.response
	be	sdr.w0	sdr.response	zero

	// read return paremeter while response is 1
	in	36	sdr.out

	out	30	zero

sdr.w1	in	31	sdr.response
	be	sdr.w1	sdr.response	one


	ret	sdr.r

sdr.x		.data	0
sdr.y		.data	0
sdr.response	.data	0
sdr.r		.data	0
sdr.write 	.data	0
sdr.in	 	.data	0
sdr.out		.data	0
