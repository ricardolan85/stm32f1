#define CORTEXM_IVT_SIZE 16
#define STM32F1_IVT_SIZE 43

extern void _reset(void);          // Defined in boot.c
extern void _estack(void);          // Defined in stm32fc.ld

__attribute__((section(".vectors"))) void (*tab[CORTEXM_IVT_SIZE + STM32F1_IVT_SIZE])(void) = {_estack, _reset};
