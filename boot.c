extern long _sbss, _ebss, _sdata, _edata, _sidata;
extern void main(void);

//reset handler
__attribute__((naked, noreturn)) void _reset(void) {
 
  //initialise memory
  for (long *src = &_sbss; src < &_ebss; src++) *src = 0;
  for (long *src = &_sdata, *dst = &_sidata; src < &_edata;) *src++ = *dst++;

  //call main()
  main();
  for (;;) (void) 0;  // Infinite loop

}
