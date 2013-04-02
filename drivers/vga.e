// VGA driver
// parameters:
//
//	(x1, y1) - upper-left corner
//	(x2, y2) - lower-right corner
//	col - 8-bit color of rectangle

vga	out	62	vga.write			
	out	63	vga.x1			
	out	64	vga.y1			
	out	65	vga.x2			
	out	66	vga.y2			
	out	67	vga.col			
	out	60	one

vga.waiting	in	61		vga.response
		be	vga.waiting	vga.response 	zero

		out	60		zero

vga.waiting2 	in	61		vga.response
		be	vga.waiting2 	vga.response	one

		ret	vga.r

vga.x1		.data 	0
vga.x2		.data	0
vga.y1		.data 	0
vga.y2		.data 	0
vga.col 	.data 	0
vga.response 	.data	0
vga.r 		.data	0
vga.write 	.data	1
vga.w		.data	640
vga.h		.data	480
