read	cpfa	sdc.low	0	i
	call	sdc	sdc.r
	add	i	i	one
	be	end	i	size
	be	read	0	0
	
	
end	halt

zero	.data	0
one	.data	1
two	.data	2
three	.data	3
four	.data	4
i	.data	0
size	.data	-32768

x	.data	50
y	.data	50
val	.data	105
val2	.data	0

// drivers
#include drivers/vga.e
#include drivers/sdc.e
#include drivers/sdr.e

#include drawImg.e
#include load.e

