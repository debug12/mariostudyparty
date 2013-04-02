// load.e - loads image and sound data from sd card
// to sdram
//
// the file on the sd card must be formatted in a particular way.
// the beginning of an image is indicated with the value 1024.
// the next two values are the width and height of the image, followed
// by the image data itself.
//
// the data is copied DIRECTLY into SDRAM, value-for-value (MIGHT CHANGE).
// however, some addtional data is written to the label specified
// in imgaddr.e. for each image, four values are written, 
// representing the location of the image in memory and the
// images size. ideally, when drawing an image, we will just specify
// an index and call a procedure that will find the address and size of
// the corresponding image.

load		cp	sdc.low		zero
		cp	sdc.hi		zero
		cp	sdr.x		zero
		cp	sdr.y		zero
		cp	sdr.write	one

load.write	// call sd card driver
		call	sdc		sdc.r
		// set value we are writing
		cp	sdr.in		sdc.read
		call	sdr		sdr.r
	
		// if the value is 1024 its the beginning of an image
		be	load.img	sdc.read	load.start
		be	load.w		load.flag	one
		be	load.h		load.flag	two
		be	load.first	load.flag	three

		// increment sdr.low
load.inclo	add	sdc.low		sdc.low		one
		be	load.inchi	sdc.low		load.sdc
		be	load.incx	0		0
		
load.inchi	add	sdc.hi		sdc.hi		one
		cp	sdc.low		zero
		
load.incx	add	sdr.x		sdr.x		one
		be	load.incy	sdr.x		sdr.size
		be	load.write	0		0
		
load.incy	add	sdr.y		sdr.y		one
		cp	sdr.x		zero
		be	load.ret	sdr.y		sdr.size
	
		be	load.write	0		0

load.ret	ret	load.r

load.img	cp	load.flag	one
		be	load.inclo	0		0

load.w		cpta	sdc.read	imgaddr		load.i
		add	load.i		load.i		one
		cp	load.flag	two
		be	load.inclo	0		0

load.h		cpta	sdc.read	imgaddr		load.i
		add	load.i		load.i		one
		cp	load.flag	three
		be	load.inclo	0		0

load.first	cpta	sdr.x		imgaddr		load.i
		add	load.i		load.i		one		
		cpta	sdr.y		imgaddr		load.i
		add	load.i		load.i		one
		cp	load.flag	zero
		be	load.inclo	0		0


load.flag	.data	0
load.sdc	.data	-1
load.start	.data	1024
load.i		.data	0
load.j		.data	0
load.r		.data	0
