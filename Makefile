PROJECT	= stm32fc
DEVICE	= STM32F103xB

CSRCS	= main.c system_stm32f1xx.c
ASRCS	= startup_stm32f103xb.s
OBJ		= startup_stm32f103xb.o main.o system_stm32f1xx.o
LDS		= stm32f103c8.ld

PREFIX	= arm-none-eabi
CC		= $(PREFIX)-gcc
OBJCOPY	= $(PREFIX)-objcopy

CFLAGS	=  -W -Wall 
CFLAGS 	+= -g3 -Os -ffunction-sections -fdata-sections
CFLAGS  += -mlittle-endian -mthumb -mcpu=cortex-m3 -msoft-float
CFLAGS  += -I./include/
CFLAGS 	+= -D$(DEVICE)

ASFLAGS	=  $(CFLAGS)

LDFLAGS	= -T$(LDS) --specs=nano.specs --specs=nosys.specs -Wl,--gc-sections -Wl,-Map=$@.map

OBJS = $(SOURCES:.c=.o)

all: $(PROJECT).elf

# compile
$(PROJECT).elf: $(OBJ)
	$(CC) $(CFLAGS) $(OBJ) -o $@ $(LDFLAGS)

%.o: %.c $(DEPS)
	$(CC) -c $(CFLAGS) $< -o $@

%.o: %.s $(DEPS)
	$(CC) -c $(ASFLAGS) $< -o $@

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
