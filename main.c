#include <stm32f1xx.h>

void setup(){

  //clock PB
  RCC->APB2ENR |= 0x00000008;

  //PB3
  GPIOB->CRL |= 0x00002000;
  
}

void loop(){

  //on
  GPIOB->BSRR = (1 << 3); //set PB3
  for(int i=0;i<100000;i++);
  
  //off
  GPIOB->BRR = (1 << 3); //reset PB3  
  for(int i=0;i<100000;i++);

}

int main(void) {

    setup();
    
    while(1){
      loop();
    }

    return 0;
    
}
