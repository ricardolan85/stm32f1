#include <stm32f1xx.h>

void setup(){

  RCC->APB2ENR |= (1 << 4); //habilitado clock para IOPC
  GPIOC->CRH |= (2 << 20); //MODE13 = 10 -  0x2 (output mode, max 2 mhz)
  GPIOC->CRH &= ~(3 << 22); //CNF13 = 00 - ~0x3 (output push-pull)
 
}

void loop(){

  GPIOC->BSRR |= (1 << 13); //set PC13
  for (uint32_t i = 0; i < 1000000; i++); //delay
  GPIOC->BSRR |= (1 << 29); //reset PC13
  for (uint32_t i = 0; i < 1000000; i++); //delay
  
}

int main(void) {

    setup();
    
    while(1){
      loop();
    }

    return 0;
    
}
