// draws a bitmap image of size bmp.width x bmp.width
// to the position (bmp.x, bmp.y)
// the bitmap should be stored contiguously starting
// at the address stored in bmp.addr

		// initialize curx, cury, which are the locations
		// of the current pixel were drawing RELATIVE to the
		// beginning of the image
bmp		cp	bmp.curx1	zero
		cp	bmp.cury1	zero
		
		// read the position of the image in memory and its size
		mult	bmp.id		bmp.id		four
		cpfa	bmp.width	imgaddr		bmp.id
		add	bmp.id		bmp.id		one
		cpfa	bmp.height	imgaddr		bmp.id
		add	bmp.id		bmp.id		one
		cpfa	bmp.mx		imgaddr		bmp.id
		add	bmp.id		bmp.id		one
		cpfa	bmp.my		imgaddr		bmp.id
		cp	sdr.write	zero

bmp.pix		cp	sdr.x		bmp.mx
		cp	sdr.y		bmp.my
		call	sdr		sdr.r
		cp	vga.col		sdr.out		

		// if the color is the color key, we dont draw it
		be	bmp.incmx	vga.col		bmp.key

		mult	vga.x1		bmp.curx1	bmp.scale
		mult	vga.y1		bmp.cury1	bmp.scale
		
		add	vga.x1		vga.x1		bmp.x
		add	vga.y1		vga.y1		bmp.y
		
		add	vga.x2		vga.x1		bmp.scale
		add	vga.y2		vga.y1		bmp.scale
		sub	vga.x2		vga.x2		one
		sub	vga.y2		vga.y2		one
		
		call	vga		vga.r

		// increase location in memory
bmp.incmx	add	bmp.mx		bmp.mx		one
		be	bmp.incmy	bmp.mx		sdr.size
		be	bmp.incx	0		0

bmp.incmy	add	bmp.my		bmp.my		one
		cp	bmp.mx		zero
		
		// then we increase the x pixel. if we have moved
		// past the end of the image, we reset x and increase y.
bmp.incx	add	bmp.curx1	bmp.curx1	one
		be	bmp.incy	bmp.width	bmp.curx1
		be	bmp.pix		0		0

		// we increase y. if we move past the end of the image were done.
bmp.incy	cp	bmp.curx1	zero
		add	bmp.cury1	bmp.cury1	one
		be	bmp.end		bmp.height	bmp.cury1
		be	bmp.pix		0		0

bmp.end		ret	bmp.r	

// the id of the image we are drawing
bmp.id		.data	0

// the return address
bmp.r		.data	0

// size of the image
bmp.width	.data	0
bmp.height	.data	0

// position at which we are drawing the image
bmp.x		.data	0
bmp.y		.data	0

// the position of the image in memory
bmp.mx		.data	0
bmp.my		.data	0

// the current x and y of the pixel we are drawing
bmp.curx1	.data	0
bmp.cury1	.data	0

// color key (transparent color)
bmp.key		.data	227

// scale
bmp.scale	.data	1









