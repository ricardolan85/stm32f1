#include <stm32f1xx.h>

static inline void spin(volatile uint32_t count) {
  while (count--) asm("nop");
}

void setup(){

  //clock PB
  RCC->APB2ENR |= RCC_APB2ENR_IOPCEN;

  //PB3
  GPIOC->CRH |= 0x00200000;
  
}

void loop(){

  //on
  GPIOC->BSRR = (1 << 13); //set PB3
  spin(999999);
  
  //off
  GPIOC->BSRR = (1 << 29); //reset PB3  
  spin(999999);

}

int main(void) {

    setup();
    
    while(1){
      loop();
    }

    return 0;
    
}
