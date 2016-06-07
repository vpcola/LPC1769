#ifdef __USE_CMSIS
#include "LPC17xx.h"
#endif

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include "lpc17xx_pinsel.h"
#include "lpc17xx_clkpwr.h"
#include "lpc17xx_gpio.h"

void Init_Pwr(void)
{
	// Turn on peripheral GPIO0
	CLKPWR_ConfigPPWR(CLKPWR_PCONP_PCGPIO, ENABLE);
}

void RedLED(int i)
{
	if (i == 0 )
		GPIO_ClearValue(PINSEL_PORT_0,(1 << PINSEL_PIN_22));
	else
		GPIO_SetValue(PINSEL_PORT_0, (1 << PINSEL_PIN_22));
}

void BlueLED(int i)
{
	if (i == 0 )
		GPIO_ClearValue(PINSEL_PORT_3,(1 << PINSEL_PIN_26));
	else
		GPIO_SetValue(PINSEL_PORT_3, (1 << PINSEL_PIN_26));
}

void Init_GPIO_Pins(void)
{
	// Configure GPIO Pins for LED control (RED Led and Blue Led)
	PINSEL_CFG_Type LedPin;
	LedPin.Portnum = PINSEL_PORT_0;
	LedPin.Pinnum = PINSEL_PIN_22;
	LedPin.Funcnum = PINSEL_FUNC_0; // Default GPIO
	LedPin.Pinmode = PINSEL_PINMODE_PULLUP;
	LedPin.OpenDrain = PINSEL_PINMODE_NORMAL;
	// Configure P0.22 (RED Led) for output
	PINSEL_ConfigPin(&LedPin);
	// Configure P3.26 (BLUE Led) for output
	LedPin.Portnum = PINSEL_PORT_3;
	LedPin.Pinnum = PINSEL_PIN_26;
	PINSEL_ConfigPin(&LedPin);

	// Set IO Direction
	GPIO_SetDir(PINSEL_PORT_0, (1 << PINSEL_PIN_22), GPIO_DIR_OUTPUT); // Red LED
	GPIO_SetDir(PINSEL_PORT_3, (1 << PINSEL_PIN_26), GPIO_DIR_OUTPUT); // Blue LED

	// Set them all off (set to 1)
	RedLED(1);
	BlueLED(1);
}


int main(void)
{
	int i;
	Init_Pwr();
	Init_GPIO_Pins();

	while(1)
	{
		RedLED(0);
		for(i = 0; i < 1000000; i++);
		RedLED(1);
		for(i = 0; i < 1000000; i++);
	}

    return 0 ;
}
