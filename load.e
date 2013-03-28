// load.e - loads image and sound data from sd card
// to sdram

load		cp	sdc.low		zero
		cp	sdc.hi		zero
		cp	sdr.write	one

load.write	// call sd card driver
		call	sdc		sdc.r
		// set x, y of sdram
		cp	sdr.x		sdc.low
		cp	sdr.y		sdc.hi
		// set value we are writing
		cp	sdr.in		sdc.read
		call	sdr		sdr.r

		be	load.img	sdc.read	load.start
		be	load.w		load.flag	one
		be	load.h		load.flag	two

		// increment sdr.low
load.incx	add	sdc.low		sdc.low		one
		be	load.incy	sdc.low		load.size
		
load.incy	add	sdc.hi		sdc.hi		one
		cp	sdc.low		zero
		be	load.ret	sdc.hi		load.size
		be	load.write	0		0

load.ret	ret	load.r

load.img	cpta	sdc.low		load.imgaddr	zero 		
		cpta	sdc.hi		load.imgaddr	one
		cp	load.flag	one
		be	load.incx	0		0

load.w		cpta	load.imgaddr	two		sdc.read
		cp	load.flag	two
		be	load.incx	0		0

load.h		cpta	load.imgaddr	three		sdc.read
		cp	load.flag	zero
		add	load.imgaddr	load.imgaddr	four
		be	load.incx	0		0


load.flag	.data	0
load.size	.data	2048
load.start	.data	1024
load.imgaddr	.data	0
load.r		.data	0
