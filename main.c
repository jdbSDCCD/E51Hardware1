/*******************************************************************************
  Main Source File

  Company:
    Microchip Technology Inc.

  File Name:
    main.c

  Summary:
    This file contains the "main" function for a project.

  Description:
    This file contains the "main" function for a project.  The
    "main" function calls the "SYS_Initialize" function to initialize the state
    machines of all modules in the system
 *******************************************************************************/

// *****************************************************************************
// *****************************************************************************
// Section: Included Files
// *****************************************************************************
// *****************************************************************************

#include <stddef.h>                     // Defines NULL
#include <stdbool.h>                    // Defines true
#include <stdlib.h>                     // Defines EXIT_FAILURE
#include <stdio.h>
#include "definitions.h"                // SYS function prototypes




/* 
 * File:  main.c
 * Author: Jim Broesch
 *
 * Created on May 13, 2022, 9:16 PM
 */

#include <xc.h>

// Multiply the first two arguments and add the third argument to the result.
// Function signature
extern uint32_t asmFunction(uint32_t, uint32_t, uint32_t);

// Place to store the result.
uint32_t t1 = 0;

int main(void) 
{
    
    // Invoke the assembly language function.
    t1 = asmFunction(0, 0, 0);

    while(1);
}

/*******************************************************************************
 End of File
*/

