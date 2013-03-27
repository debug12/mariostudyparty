sdram.write 	call	sdram.waiting0		sdram.waiting0.r
				call	sdram.apply			sdram.apply.r


sdram.in		out		32		one
				out		35		sdram.data.write
				out		30		one

				call	sdram.waiting1		sdram.waiting1.r
				out		30		zero

				ret		sdram.r


//WAITINGLOOPS//
sdram.waiting1		in		31				sdram.response
					be		sdram.writeWait	sdram.response	zero
					ret		sdram.waiting1.r

sdram.waiting0	 	in		31				sdram.response
					be		sdram.writeWait2	sdram.response	one
					ret		sdram.waiting0.addr

					ret		sdram.r

//READ//
sdram.read      call	sdram.waiting0	sdram.waiting0.r
				call	sdram.apply     sdram.apply.r


sdram.out		out		32		zero
				out		30		one

sdram.get		in		36		sdram.data.read
				out		30		zero

				ret		sdram.r

//APPLY//
sdram.apply 	out		33		sdram.x
				out		34		sdram.y
				ret		sdram.apply.r




sdram.x				.data	0
sdram.y				.data	0
sdram.response		.data	0
sdram.in			.data	0
sdram..out			.data	0
sdram.r				.data	0
sdram.write 		.data	0
sdram.data.write 	.data	0
sdram.data.read  	.data	0
sdram.waiting1.r 	.data	0
sdram.waiting0.r 	.data   0
sdram.apply.addr	.data	0