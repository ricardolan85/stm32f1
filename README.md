# stm32fc
Open Source Flight Controller Firmware for STM32

# Startup

1) Após ligar/resetar o microcontrolador, os pinos boot0 e boot1 são verificados para identificar qual o tipo de boot deve ser feito (Flash, Bootloader ou SRAM)

2) Após mapear o boot, o microcontrolador vai consultar a tabela de vetores de interrupção (0x00000000) procurando pelo endereço da stack e do Reset_Handler.

3) A stack é auto configurada e a execução é iniciada no endereço de Reset_Handler. A rotina vai copiar o segmento de .data da memória Flash para a memória RAM.

4) Todo o segmento de .bss é preenchido com zeros

5) A função main é chamada iniciando nossa aplicação
