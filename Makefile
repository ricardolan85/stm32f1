PROJECT		= stm32fc
SOURCES  = main.c

PREFIX		?= arm-none-eabi
CC			:= $(PREFIX)-gcc
OBJCOPY		:= $(PREFIX)-objcopy

CFLAGS  = -g -O2 -Wall
CFLAGS  += -mthumb -mcpu=cortex-m3 -msoft-float -mfix-cortex-m3-ldrd
CFLAGS  += -I./include/
CFLAGS 	+= -D__GNUC__ -DSTM32F103xB

OBJS = $(SOURCES:.c=.o)

all: $(PROJECT).elf

# compile
$(PROJECT).elf: $(SOURCES)
	$(CC) $(CFLAGS) $^ -o $@
	$(OBJCOPY) -O ihex $(PROJECT).elf $(PROJECT).hex
	$(OBJCOPY) -O binary $(PROJECT).elf $(PROJECT).bin
