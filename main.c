#include <stm32f1xx.h>

/* delay */
static inline void spin(volatile uint32_t count) {
  while (count--) asm("nop");
}

void setup(){

  //clock GPIOC
  RCC->APB2ENR |= RCC_APB2ENR_IOPCEN;

  //PC13 - output push pull
  GPIOC->CRH |= 0xFF0FFFFF; //clear
  GPIOC->CRH |= 0x00200000; //set
  
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
