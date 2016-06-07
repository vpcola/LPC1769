CC=arm-none-eabi-gcc
AR=arm-none-eabi-ar

###########################################

vpath %.c Src 

TARGET = liblpcdriver.a
 
CFLAGS = -g -O2 -Wall
# Define the device we are using
CFLAGS += -D__weak="__attribute__((weak))" -D__packed="__attribute__((__packed__))"
CFLAGS += -D PACK_STRUCT_END=__attribute\(\(packed\)\) 
CFLAGS += -D ALIGN_STRUCT_END=__attribute\(\(aligned\(4\)\)\)	
CFLAGS += -D__USE_CMSIS
CFLAGS += -mlittle-endian -mthumb -mcpu=cortex-m3 -mthumb-interwork
CFLAGS += -fno-builtin -mfloat-abi=soft	-ffunction-sections -fdata-sections -fmessage-length=0 -funsigned-char

CFLAGS += -I./Inc
CFLAGS += -I../Inc 
CFLAGS += -I../Core/Inc

SRCS = lpc17xx_libcfg_default.c \
	 lpc17xx_pinsel.c	\
	 lpc17xx_gpio.c \
	 lpc17xx_uart.c \
	 lpc17xx_i2c.c \
	 lpc17xx_spi.c \
	 lpc17xx_clkpwr.c


OBJS = $(SRCS:.c=.o)

.PHONY: $(TARGET)

all: $(TARGET)

%.o : %.c
	$(CC) $(CFLAGS) -c -o $@ $^

$(TARGET): $(OBJS)
	$(AR) -r $@ $(OBJS)

clean:
	rm -f $(OBJS) $(TARGET)
