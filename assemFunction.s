#include <xc.h>
    
.data  
        
/***************************************************************
* Port address declarations.                                   *
***************************************************************/
PORT_REGS =  0x41008000
DIR = 0x00
DIRCLR = 0x04
DIRSET = 0x08
OUT = 0x10
IN = 0x20
OUTCLR = 0x14
OUTSET = 0x18
IN = 0x20
PINCFG = 0x40
        
delayTime = 0x2DC6C00/2

.text
.align
/*********************************************************
* Subroutine to turn the LED on and off. 
* If R0 contains a 0 the LED is turned off.
* If R0 <> 1 the led is turned on. 
 *********************************************************/        
 LED:
   cmp    R0,#0
   beq    LED1
           
   mov  R0, #0x01   // R0 <= #0x4000
   lsl  R0, #14

   mov R2, #OUTSET  // Set individual bit register.
   str R0, [R1,R2]
   bal LEDDone
 
LED1:          
   mov  R0, #0x01   // R0 <= #0x4000
   lsl  R0, #14
   mov R2, #OUTCLR 
   str R0, [R1,R2]  // Clear the individual bit register.

LEDDone:           
   mov PC,LR
 
/*************************************************************
* This subroutine returns the value on the pin connected to
* the push button.
* A 1 in R0 means the push button is up.
* A 0 in R0 means that the push button is down.
*************************************************************/
getPushButton:
   mov R2, #IN      // Input register offest.
   ldr R0, [R1,R2]  // Get bit value.
   
   mov R2, #0       // Create a bit mask: 0x0FFFFFFF.
   sub R2,R2,#1
   lsr R2, R2, #4       
   
   and R0, R2       // AND the mask with R0.
   mov PC, LR       // Return.
   
  
// *****************************************************************************
// *****************************************************************************
// Section: Main Entry Point
// *****************************************************************************
// *****************************************************************************  
   
/********************************************************************
R0 Value to be written / read.
R1 Base pointer value.
R2 Offset pointer.
    R1 + R2 == the effective address.
********************************************************************/    
.global asmFunction
asmFunction:  

/* Initialization section                                */
    mov R8, LR // Save the link register.

   ldr  R1, = #PORT_REGS
  
   ldr	R0, = #0x00     // Set the pin configuration for the LED pin.
   mov R2, #PINCFG
   add R2, R2, #14
   str R0, [R1,R2]
   
   ldr	R0, = #0x06     // Set the pin configuration for the Push button pin.
   mov R2, #PINCFG
   add R2, R2, #15
   str R0, [R1,R2]
           
   mov  R0, #0x01   // R0 <= #0x4000
   lsl  R0, #14                    
   mov R2, #DIRSET
   str R0, [R1,R2]
   
   mov  R0, #0x01   // R0 <= #0x8000
   lsl  R0, #15  
   mov R2, #OUTSET
   str R0, [R1,R2]  // Drive the pullup.
 
/* Start of main working loop. */    
// Your code goes here.

   
   mov pc, R8	  // Return to calling routine.
   
.end asmFunction
   
/**********************************************************************/   
.end
           
