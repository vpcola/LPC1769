# put your *.o targets here, make should handle the rest!

SRCS =   \
	 system_LPC17xx.c \
	 newlibstubs.c \
	 startup_LPC17xx.c \
 	 main.c
 
	 
# all the files will be generated with this name (main.elf, main.bin, main.hex, etc)

PROJ_NAME=main

# that's it, no need to change anything below this line!

###################################################

CC=arm-none-eabi-gcc
OBJCOPY=arm-none-eabi-objcopy
OBJDUMP=arm-none-eabi-objdump
OBJSIZE=arm-none-eabi-size

CFLAGS  = -g  -O0 -Wall -Tlpc17xx.ld
# Define the device we are using
CFLAGS += -D__weak="__attribute__((weak))" -D__packed="__attribute__((__packed__))"
CFLAGS += -D PACK_STRUCT_END=__attribute\(\(packed\)\) 
CFLAGS += -D ALIGN_STRUCT_END=__attribute\(\(aligned\(4\)\)\)	
CFLAGS += -D__USE_CMSIS
CFLAGS += -mthumb -mcpu=cortex-m3 
CFLAGS += -fno-builtin -mfloat-abi=soft	-ffunction-sections -fdata-sections -fmessage-length=0 -funsigned-char
 
ODFLAGS	= -x
LDFLAGS += -Wl,-Map,$(PROJ_NAME).map

###################################################

vpath %.c Src
vpath %.c Core/Src 
vpath %.c Drivers/Src

ROOT=$(shell pwd)

CFLAGS += -IInc 
CFLAGS += -ICore/Inc
CFLAGS += -IDrivers/Inc

LIBS = -LDrivers -llpcdriver

OBJS = $(SRCS:.c=.o)

###################################################

.PHONY: Drivers proj

all: Drivers proj

Drivers:
	$(MAKE) -C Drivers
	
proj: 	$(PROJ_NAME).elf

$(PROJ_NAME).elf: $(SRCS)
	$(CC) $(CFLAGS) $^ -o $@ $(LIBS) $(LDFLAGS)
	$(OBJCOPY) -O ihex $(PROJ_NAME).elf $(PROJ_NAME).hex
	$(OBJCOPY) -O binary $(PROJ_NAME).elf $(PROJ_NAME).bin
	$(OBJDUMP) -x $(PROJ_NAME).elf > $(PROJ_NAME).dmp
	@echo " "
	@$(OBJSIZE) -d $(PROJ_NAME).elf

clean:
	$(MAKE) -C Drivers clean
	rm -f $(PROJ_NAME).elf
	rm -f $(PROJ_NAME).hex
	rm -f $(PROJ_NAME).bin
	rm -f $(PROJ_NAME).dmp
	rm -f $(PROJ_NAME).map
