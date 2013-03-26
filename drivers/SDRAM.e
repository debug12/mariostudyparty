sdram	out		32	sdram.write
		out		33	sdram.x
		out		34	sdram.y
		out		35	sdram.data.write
		out		36	sdram.data.read

/*WRITE*/

sdram.writeWait	in		31				sdram.response
				be		sdram.writeWait	sdram.response	zero

				out		30				zero

sdram.writeWait2 	in		31				sdram.response
					be		sdram.writeWait2	sdram.response	one

					ret		sdram.r

/*READ*/




sdram.x			.data	0
sdram.y			.data	0
sdram.response	.data	0
sdram.in	.data	0
sdram..out	.data	0
sdram.r		.data	0
