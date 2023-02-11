PROJECT	= stm32fc
SOURCES	= main.c

PREFIX	?= arm-none-eabi
CC		= $(PREFIX)-gcc
OBJCOPY	= $(PREFIX)-objcopy

CFLAGS	= -g -O2 -Wall
CFLAGS  += -mlittle-endian -mthumb -mcpu=cortex-m3 -msoft-float
CFLAGS  += -I./include/
CFLAGS 	+= -DSTM32F103xB

LDFLAGS	= -Wl,--gc-sections --specs=nano.specs --specs=nosys.specs

OBJS = $(SOURCES:.c=.o)

all: $(PROJECT).elf

# compile
$(PROJECT).elf: $(SOURCES)
	$(CC) $(CFLAGS) $^ -o $@ $(LDFLAGS)

clean:
	rm -rf *.elf *.hex
