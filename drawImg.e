// draws a bitmap image of size bmp.width x bmp.width
// to the position (bmp.x, bmp.y)
// the bitmap should be stored contiguously starting
// at the address stored in bmp.addr

		// initialize curx, cury, which are the locations
		// of the current pixel we're drawing RELATIVE to the
		// beginning of the image
bmp		cp	bmp.curx	zero
		cp	bmp.cury	zero

		// bmp.pix draws a single pixel of the bitmap
		// the address of the pixel we're reading is
		// bmp.addr + bmp.curx + bmp.cury * bmp.width
		// the position is bmp.x + bmp.curx, bmp.y + bmp.cury
bmp.pix		mult	bmp.cur		bmp.cury	bmp.width
		add	bmp.cur		bmp.cur		bmp.curx

		cpfa	vga.col		bmp.addr	bmp.cur	

		// if the color is the color key, we don't draw it
		be	bmp.incx	vga.col		bmp.key

		add	vga.x1		bmp.curx	bmp.x
		add	vga.y1		bmp.cury	bmp.y

		cp	vga.x2		vga.x1
		cp	cga.y2		vga.y1
		
		call	vga		vga.r
		
		// then we increase the x pixel. if we have moved
		// past the end of the image, we reset x and increase y.
bmp.incx	add	bmp.curx	bmp.curx	one
		be	bmp.incy	bmp.width	bmp.curx
		be	bmp.pix		0		0

		// we increase y. if we move past the end of the image we're done.
bmp.incy	cp	bmp.curx	zero
		add	bmp.cury	bmp.cury	one
		be	bmp.end		bmp.height	bmp.cury
		be	bmp.pix		0		0

bmp.end		ret	bmp.r	

// the address of the first pixel of the image
bmp.addr	.data	0

// the return address
bmp.r		.data	0

// size of the image
bmp.width	.data	0
bmp.height	.data	0

// position at which we are drawing the image
bmp.x		.data	0
bmp.y		.data	0

// the current x and y of the pixel we are drawing
bmp.curx	.data	0
bmp.cury	.data	0

// the current address relative
// to the beginning of the image
bmp.cur		.data	0

// color key (transparent color)
bmp.key		.data	0









