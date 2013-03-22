vga.start				out		60		one
						out		62		vga.write			
						out		63		vga.x1			
						out		64		vga.y1			
						out		65		vga.x2			
						out		66		vga.y2			
						out		67		vga.col			


vga.command_start		out 	60 		zero


vga.return				ret		vga.r
				

// Make sure initial response is 0
vga.reset				out		60		zero	

//	Check initial response equal to 0
vga.waiting				in		61				vga.response
						be		vga.waiting		vga.response 	zero

vga.waiting2 			in		61				vga.response
						be		vga.waiting2 	vga.response	one

vga.return				ret 	vga.r

vga.x1							.data 	0
vga.x2							.data 	0
vga.y1							.data 	0
vga.y2							.data 	0
vga.col 						.data 	0


vga.response 					.data	0
vga.r 							.data	0
vga.write 						.data	0
