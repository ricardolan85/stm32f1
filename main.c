#include <stm32f1xx.h>

static inline void spin(volatile uint32_t count) {
  while (count--) asm("nop");
}

void setup(){

  //clock PB
  RCC->APB2ENR |= RCC_APB2ENR_IOPBEN;

  //PB3
  GPIOB->CRL |= 0x00002000;
  
}

void loop(){

  //on
  GPIOB->BSRR = (1 << 3); //set PB3
  spin(999999);
  
  //off
  GPIOB->BRR = (1 << 3); //reset PB3  
  spin(999999);

}

int main(void) {

    setup();
    
    while(1){
      loop();
    }

    return 0;
    
}
