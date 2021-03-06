// board.e
// written by Andrew, Deepak
// draws the quadrant of the board specified
// by bd.quad
// the .data statements below specify the 
// locations and types of spaces in the format:
//	- x
//	- y
//	- quadrant
//	- type
//	- unused

bd	cpfa	bmp.id	img.bg1		bd.quad
	cp	bmp.x	zero
	cp	bmp.y	zero
	call	bmp	bmp.r
	call	star	star.r

bd.end	ret	bd.r

// width and height.
bd.quad	.data	4
bd.r	.data	0
bd.size	.data	32
bd.blue	.data	1
bd.red	.data	2
bd.event	.data	5
bd.bowser	.data	4
bd.store	.data	3
bd.dat	.data	70
	.data	42
	.data	3
	.data	0
	.data	0

	.data	83
	.data	65
	.data	3
	.data	1
	.data	0

	.data	102
	.data	56
	.data	3
	.data	1
	.data	0
	
	.data	123
	.data	54
	.data	3
	.data	1
	.data	0

	.data	143
	.data	58
	.data	3
	.data	2
	.data	0

	.data	1
	.data	69
	.data	2
	.data	1
	.data	0

	.data	23
	.data	63
	.data	2
	.data	1
	.data	0

	.data	42
	.data	58
	.data	2
	.data	3
	.data	0

	.data	64
	.data	63
	.data	2
	.data	4
	.data	0

	.data	82
	.data	56
	.data	2
	.data	5
	.data	0

	.data	92
	.data	61
	.data	1
	.data	1
	.data	0

	.data	111
	.data	51
	.data	1
	.data	1
	.data	0

	.data	117
	.data	38
	.data	1
	.data	2
	.data	0

	.data	114
	.data	20
	.data	1
	.data	1
	.data	0

	.data 	104
	.data	5
	.data	1
	.data	1
	.data	0

	.data	82
	.data	7
	.data	1
	.data	1
	.data	0

	.data	73
	.data	22
	.data	1
	.data	1
	.data	0

	.data	61
	.data	35
	.data	1
	.data	2
	.data	0

	.data	45
	.data	45
	.data	1
	.data	4
	.data	0

	.data	41
	.data	29
	.data	1
	.data	1
	.data	0

	.data	31
	.data	10
	.data	1
	.data	1
	.data	0

	.data	10
	.data	0
	.data	1
	.data	1
	.data	0

	.data	136
	.data	1
	.data	0
	.data	2
	.data	0

	.data	116
	.data	14
	.data	0
	.data	1
	.data	0

	.data	110
	.data	36
	.data	0
	.data	1
	.data	0

	.data	89
	.data	29
	.data	0
	.data	1
	.data	0

	.data	67
	.data	28
	.data	0
	.data	2
	.data	0

	.data	47
	.data	39
	.data	0
	.data	1
	.data	0

	.data	39
	.data	50
	.data	0
	.data	1
	.data	0

	.data	42
	.data	27
	.data	3
	.data	1
	.data	0

	.data	48
	.data	43
	.data	3
	.data	5
	.data	0

	.data	61
	.data	56
	.data	3
	.data	2
	.data	0

