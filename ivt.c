#define CORTEXM_IVT_SIZE 16
#define STM32F1_IVT_SIZE 43

extern void _reset(void);
extern void _estack(void);

__attribute__((section(".vectors"))) void (*tab[CORTEXM_IVT_SIZE + STM32F1_IVT_SIZE])(void) = {_estack, _reset};
