#include <stm32f1xx.h>

void setup(){

  RCC->APB2ENR |= RCC_APB2ENR_IOPBEN; //habilitado clock para PB

  //PB3
  GPIOB->CRL &= ~(3 << 12); //MODE3 = 00 -  0x0 clear mode
  GPIOB->CRL |= (2 << 12); //MODE3 = 10 -  0x2 (output mode, max 2 mhz)
  GPIOB->CRL &= ~(3 << 14); //CNF3 = 00 - ~0x3 (output push-pull)

}

void loop(){

  //on
  GPIOB->BSRR |= (1 << 3); //set PB3
  for (uint32_t i = 0; i < 1000000; i++); //delay
  
  //off
  GPIOB->BSRR |= (1 << 19); //reset PB3
  for (uint32_t i = 0; i < 1000000; i++); //delay
  
}

int main(void) {

    setup();
    
    while(1){
      loop();
    }

    return 0;
    
}
