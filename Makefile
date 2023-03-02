PROJECT	= stm32f1
DEVICE	= STM32F103x6

SRCS	= ivt.c boot.c main.c 
OBJS	= ivt.o boot.o main.o
LDS		= linker.lds

PREFIX	= arm-none-eabi
CC		= $(PREFIX)-gcc
OBJCOPY	= $(PREFIX)-objcopy

CFLAGS	=  -W -Wall 
CFLAGS 	+= -g3 -Os -ffunction-sections -fdata-sections
CFLAGS  += -mcpu=cortex-m3 -mlittle-endian -mthumb -msoft-float
CFLAGS  += -I./include/ -I./ 
CFLAGS 	+= -D$(DEVICE)

LDFLAGS	= -T$(LDS) --specs=nano.specs --specs=nosys.specs -Wl,--gc-sections -Wl,-Map=$@.map


all: $(PROJECT).elf

$(PROJECT).elf: $(OBJS)
	$(CC) $(CFLAGS) $(OBJ) -o $@ $(LDFLAGS)

%.o: %.c
	$(CC) -c $(CFLAGS) $< -o $@

bin: $(PROJECT).elf
	$(OBJCOPY) -O binary $(PROJECT).elf $(PROJECT).bin

hex: $(PROJECT).elf
	$(OBJCOPY) -O ihex $(PROJECT).elf $(PROJECT).hex

size: $(PROJECT).elf
	$(PREFIX)-size $(PROJECT).elf

readelf: $(PROJECT).elf
	$(PREFIX)-readelf -s $(PROJECT).elf

dump: $(PROJECT).elf
	$(PREFIX)-objdump -d $(PROJECT).elf > $(PROJECT).dump

clean:
	del *.elf
	del *.o
	del *.hex
	del *.bin
	del *.dump
	del *.map
