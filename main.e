start	call	load	load.r
end	halt

zero	.data	0
one	.data	1
two	.data	2
three	.data	3
four	.data	4

// drivers
#include drivers/vga.e
#include drivers/sdc.e
#include drivers/sdr.e

#include drawImg.e
#include load.e
#include imgaddr.e

