#include <LPC23xx.H>                    /* LPC23xx/LPC24xx definitions        */
#include <stdio.h>

extern void init_serial(void);
extern void start (void);

int main (void)
{
	/* Initialise UART */
	init_serial();

	printf("\r\nCalling start() ...\r\n");

	start();

//	printf("start() returned.\r\n");

	while (1);
}
