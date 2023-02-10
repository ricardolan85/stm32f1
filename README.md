# stm32fc
Open Source Flight Controller Firmware for STM32

# Startup

1) Após ligar/resetar o microcontrolador o mesmo vai consultar a tabela dos vetores de interrupção (.isr_vector) procurando pelo endereço de Reset_Handler.

2) A execução é iniciado no endereço de Reset_Handler onde o mesmo vai copiar o segmento de .data da memória Flash para a memória RAM.

3) Todo o segmento de .bss é preenchido com zeros

4) A função SystemInit é chamada para iniciar o sistema de clock do microcontrolador

5) A função __libc_init_array é chamada (static constructors)

6) A função main é chamada iniciando nossa aplicação

OBS) até que sejam implementados, os demais vetores de interrupção são configurados para Default_Handler (loop infinito)
