PROJECT	= stm32fc
DEVICE	= STM32F103xB

CSRCS	= main.c system_stm32f1xx.c
ASRCS	= startup_stm32f103xb.s
OBJ		= startup_stm32f103xb.o main.o system_stm32f1xx.o
LDS		= stm32f103c8.ld

PREFIX	= arm-none-eabi
CC		= $(PREFIX)-gcc
OBJCOPY	= $(PREFIX)-objcopy

CFLAGS	= -g -O2 -Wall
CFLAGS  += -mlittle-endian -mthumb -mcpu=cortex-m3 -msoft-float
CFLAGS  += -I./include/
CFLAGS 	+= -D$(DEVICE)

ASFLAGS	=  $(CFLAGS)

LDFLAGS	= -T $(LDS) -Wl,--gc-sections --specs=nano.specs --specs=nosys.specs

OBJS = $(SOURCES:.c=.o)

all: $(PROJECT).elf

# compile
$(PROJECT).elf: $(OBJ)
	$(CC) $(CFLAGS) $(OBJ) -o $@ $(LDFLAGS)

%.o: %.c $(DEPS)
	$(CC) -c $(CFLAGS) $< -o $@

%.o: %.s $(DEPS)
	$(CC) -c $(ASFLAGS) $< -o $@

hex: $(PROJECT).elf
	$(OBJCOPY) -O ihex $(PROJECT).elf $(PROJECT).hex

clean:
	rm -rf *.elf *.hex
