######################################################################
#  Adapted from libopencm3
######################################################################

PREFIX		?= arm-none-eabi

FP_FLAGS	?= -msoft-float
ARCH_FLAGS	= -mthumb -mcpu=cortex-m3 $(FP_FLAGS) -mfix-cortex-m3-ldrd
ASFLAGS		= -mthumb -mcpu=cortex-m3

CC		:= $(PREFIX)-gcc
LD		:= $(PREFIX)-gcc
AR		:= $(PREFIX)-ar
AS		:= $(PREFIX)-as
OBJCOPY		:= $(PREFIX)-objcopy
SIZE		:= $(PREFIX)-size
OBJDUMP		:= $(PREFIX)-objdump
GDB		:= $(PREFIX)-gdb

STFLASH		= $(shell which st-flash)
OPT		:= -Os -g
CSTD		?= -std=c99

TEMP1 		= $(patsubst %.c,%.o,$(SRCFILES))
TEMP2		= $(patsubst %.asm,%.o,$(TEMP1))
OBJS 		= $(patsubst %.cpp,%.o,$(TEMP2))

LDSCRIPT	?= stm32f103c8t6.ld

TGT_CFLAGS	+= $(OPT) $(CSTD)
TGT_CFLAGS	+= $(ARCH_FLAGS)
TGT_CFLAGS	+= -Wextra -Wshadow -Wimplicit-function-declaration
TGT_CFLAGS	+= -Wredundant-decls -Wmissing-prototypes -Wstrict-prototypes
TGT_CFLAGS	+= -fno-common -ffunction-sections -fdata-sections

TGT_LDFLAGS	+= --static -nostartfiles
TGT_LDFLAGS	+= -T$(LDSCRIPT)
TGT_LDFLAGS	+= $(ARCH_FLAGS)
TGT_LDFLAGS	+= -Wl,-Map=$(*).map
TGT_LDFLAGS	+= -Wl,--gc-sections

LDLIBS		+= -specs=nosys.specs
LDLIBS		+= -Wl,--start-group -lc -lgcc -lnosys -Wl,--end-group

.SUFFIXES:	.elf .bin .hex .srec .list .map .images
.SECONDEXPANSION:
.SECONDARY:

elf:	$(DEPS) $(BINARY).elf
bin:	$(DEPS) $(BINARY).bin
hex:	$(DEPS) $(BINARY).hex
srec:	$(DEPS) $(BINARY).srec
list:	$(DEPS) $(BINARY).list

# Define a helper macro for debugging make errors online
print-%:
	@echo $*=$($*)

%.images: %.bin %.hex %.srec %.list %.map
	@#printf "*** $* images generated ***\n"

%.bin: %.elf
	@#printf "  OBJCOPY $(*).bin\n"
	$(OBJCOPY) -Obinary $(*).elf $(*).bin

%.hex: %.elf
	@#printf "  OBJCOPY $(*).hex\n"
	$(OBJCOPY) -Oihex $(*).elf $(*).hex

%.srec: %.elf
	@#printf "  OBJCOPY $(*).srec\n"
	$(OBJCOPY) -Osrec $(*).elf $(*).srec

%.list: %.elf
	@#printf "  OBJDUMP $(*).list\n"
	$(OBJDUMP) -S $(*).elf > $(*).list

%.elf %.map: $(OBJS) $(LDSCRIPT)
	$(LD) $(TGT_LDFLAGS) $(LDFLAGS) $(OBJS) $(LDLIBS) -o $(*).elf
	$(SIZE) $(BINARY).elf

%.o: %.c
	@#printf "  CC      $(*).c\n"
	$(CC) $(TGT_CFLAGS) $(CFLAGS) $(TGT_CPPFLAGS) $(CPPFLAGS) -o $(*).o -c $(*).c

%.o: %.s
	$(AS) $(ASFLAGS) -o $*.o -c $<

clean:
	@#printf "  CLEAN\n"
	$(RM) *.o *.d generated.* $(OBJS) $(patsubst %.o,%.d,$(OBJS))

clobber: clean
	rm -f *.elf *.bin *.hex *.srec *.list *.map $(CLOBBER)

# Flash 64k Device
flash:	$(BINARY).bin
	$(STFLASH) --flash=64k write $(BINARY).bin 0x8000000

.PHONY: images clean elf bin hex srec list all

-include $(OBJS:.o=.d)

# End
