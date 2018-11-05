;;*****************************************************************************
;;*****************************************************************************
;;  FILENAME: SW.asm
;;   Version: 2.6, Updated on 2015/3/4 at 22:27:48
;;  Generated by PSoC Designer 5.4.3191
;;
;;  DESCRIPTION: Timer32 User Module software implementation file
;;
;;  NOTE: User Module APIs conform to the fastcall16 convention for marshalling
;;        arguments and observe the associated "Registers are volatile" policy.
;;        This means it is the caller's responsibility to preserve any values
;;        in the X and A registers that are still needed after the API functions
;;        returns. For Large Memory Model devices it is also the caller's 
;;        responsibility to perserve any value in the CUR_PP, IDX_PP, MVR_PP and 
;;        MVW_PP registers. Even though some of these registers may not be modified
;;        now, there is no guarantee that will remain the case in future releases.
;;-----------------------------------------------------------------------------
;;  Copyright (c) Cypress Semiconductor 2015. All Rights Reserved.
;;*****************************************************************************
;;*****************************************************************************

include "m8c.inc"
include "memory.inc"
include "SW.inc"

;-----------------------------------------------
;  Global Symbols
;-----------------------------------------------
export  SW_EnableInt
export _SW_EnableInt
export  SW_DisableInt
export _SW_DisableInt
export  SW_Start
export _SW_Start
export  SW_Stop
export _SW_Stop
export  SW_WritePeriod
export _SW_WritePeriod
export  SW_WriteCompareValue
export _SW_WriteCompareValue
export  SW_ReadCompareValue
export _SW_ReadCompareValue
export  SW_ReadTimer
export _SW_ReadTimer
export  SW_ReadTimerSaveCV
export _SW_ReadTimerSaveCV

; The following functions are deprecated and subject to omission in future releases
;
export  SW_ReadCounter       ; obsolete
export _SW_ReadCounter       ; obsolete
export  SW_CaptureCounter    ; obsolete
export _SW_CaptureCounter    ; obsolete


AREA stopwatch_RAM (RAM,REL)

;-----------------------------------------------
;  Constant Definitions
;-----------------------------------------------


;-----------------------------------------------
; Variable Allocation
;-----------------------------------------------


AREA UserModules (ROM, REL)

.SECTION
;-----------------------------------------------------------------------------
;  FUNCTION NAME: SW_EnableInt
;
;  DESCRIPTION:
;     Enables this timer's interrupt by setting the interrupt enable mask bit
;     associated with this User Module. This function has no effect until and
;     unless the global interrupts are enabled (for example by using the
;     macro M8C_EnableGInt).
;-----------------------------------------------------------------------------
;
;  ARGUMENTS:    None.
;  RETURNS:      Nothing.
;  SIDE EFFECTS: 
;    The A and X registers may be modified by this or future implementations
;    of this function.  The same is true for all RAM page pointer registers in
;    the Large Memory Model.  When necessary, it is the calling function's
;    responsibility to perserve their values across calls to fastcall16 
;    functions.
;
 SW_EnableInt:
_SW_EnableInt:
   RAM_PROLOGUE RAM_USE_CLASS_1
   SW_EnableInt_M
   RAM_EPILOGUE RAM_USE_CLASS_1
   ret

.ENDSECTION


.SECTION
;-----------------------------------------------------------------------------
;  FUNCTION NAME: SW_DisableInt
;
;  DESCRIPTION:
;     Disables this timer's interrupt by clearing the interrupt enable
;     mask bit associated with this User Module.
;-----------------------------------------------------------------------------
;
;  ARGUMENTS:    None
;  RETURNS:      Nothing
;  SIDE EFFECTS: 
;    The A and X registers may be modified by this or future implementations
;    of this function.  The same is true for all RAM page pointer registers in
;    the Large Memory Model.  When necessary, it is the calling function's
;    responsibility to perserve their values across calls to fastcall16 
;    functions.
;
 SW_DisableInt:
_SW_DisableInt:
   RAM_PROLOGUE RAM_USE_CLASS_1
   SW_DisableInt_M
   RAM_EPILOGUE RAM_USE_CLASS_1
   ret

.ENDSECTION


.SECTION
;-----------------------------------------------------------------------------
;  FUNCTION NAME: SW_Start
;
;  DESCRIPTION:
;     Sets the start bit in the Control register of this user module.  The
;     timer will begin counting on the next input clock.
;-----------------------------------------------------------------------------
;
;  ARGUMENTS:    None
;  RETURNS:      Nothing
;  SIDE EFFECTS: 
;    The A and X registers may be modified by this or future implementations
;    of this function.  The same is true for all RAM page pointer registers in
;    the Large Memory Model.  When necessary, it is the calling function's
;    responsibility to perserve their values across calls to fastcall16 
;    functions.
;
 SW_Start:
_SW_Start:
   RAM_PROLOGUE RAM_USE_CLASS_1
   SW_Start_M
   RAM_EPILOGUE RAM_USE_CLASS_1
   ret

.ENDSECTION


.SECTION
;-----------------------------------------------------------------------------
;  FUNCTION NAME: SW_Stop
;
;  DESCRIPTION:
;     Disables timer operation by clearing the start bit in the Control
;     register of the LSB block.
;-----------------------------------------------------------------------------
;
;  ARGUMENTS:    None
;  RETURNS:      Nothing
;  SIDE EFFECTS: 
;    The A and X registers may be modified by this or future implementations
;    of this function.  The same is true for all RAM page pointer registers in
;    the Large Memory Model.  When necessary, it is the calling function's
;    responsibility to perserve their values across calls to fastcall16 
;    functions.
;
 SW_Stop:
_SW_Stop:
   RAM_PROLOGUE RAM_USE_CLASS_1
   SW_Stop_M
   RAM_EPILOGUE RAM_USE_CLASS_1
   ret

.ENDSECTION


.SECTION
;-----------------------------------------------------------------------------
;  FUNCTION NAME: SW_WritePeriod
;
;  DESCRIPTION:
;     Write the 32-bit period value into the Period register (DR1). If the
;     Timer user module is stopped, then this value will also be latched
;     into the Count register (DR0).
;-----------------------------------------------------------------------------
;
;  ARGUMENTS: fastcall16 DWORD dwPeriodValue (on stack)
;  RETURNS:   Nothing
;  SIDE EFFECTS:
;    If the timer user module is stopped, then this value will also be
;    latched into the Count registers (DR0).
;    
;    The A and X registers may be modified by this or future implementations
;    of this function.  The same is true for all RAM page pointer registers in
;    the Large Memory Model.  When necessary, it is the calling function's
;    responsibility to perserve their values across calls to fastcall16 
;    functions.
;
_SW_WritePeriod:
 SW_WritePeriod:
   RAM_PROLOGUE RAM_USE_CLASS_2
   mov   X, SP
   mov   A, [X-6]                                ; load the period registers
   mov   reg[SW_PERIOD_MSB_REG],  A
   mov   A, [X-5]
   mov   reg[SW_PERIOD_ISB2_REG], A
   mov   A, [X-4]
   mov   reg[SW_PERIOD_ISB1_REG], A
   mov   A, [X-3]
   mov   reg[SW_PERIOD_LSB_REG],  A
   RAM_EPILOGUE RAM_USE_CLASS_2
   ret

.ENDSECTION


.SECTION
;-----------------------------------------------------------------------------
;  FUNCTION NAME: SW_WriteCompareValue
;
;  DESCRIPTION:
;     Writes compare value into the Compare register (DR2).
;
;     NOTE! The Timer user module must be STOPPED in order to write the
;           Compare register. (Call SW_Stop to disable).
;-----------------------------------------------------------------------------
;
;  ARGUMENTS:    fastcall16 DWORD dwCompareValue (on stack)
;  RETURNS:      Nothing
;  SIDE EFFECTS: 
;    The A and X registers may be modified by this or future implementations
;    of this function.  The same is true for all RAM page pointer registers in
;    the Large Memory Model.  When necessary, it is the calling function's
;    responsibility to perserve their values across calls to fastcall16 
;    functions.
;
_SW_WriteCompareValue:
 SW_WriteCompareValue:
   RAM_PROLOGUE RAM_USE_CLASS_2
   mov   X, SP
   mov   A, [X-6]                                ; load the compare registers
   mov   reg[SW_COMPARE_MSB_REG],  A
   mov   A, [X-5]
   mov   reg[SW_COMPARE_ISB2_REG], A
   mov   A, [X-4]
   mov   reg[SW_COMPARE_ISB1_REG], A
   mov   A, [X-3]
   mov   reg[SW_COMPARE_LSB_REG],  A
   RAM_EPILOGUE RAM_USE_CLASS_2
   ret

.ENDSECTION


.SECTION
;-----------------------------------------------------------------------------
;  FUNCTION NAME: SW_ReadCompareValue
;
;  DESCRIPTION:
;     Reads the Compare registers.
;-----------------------------------------------------------------------------
;
;  ARGUMENTS: fastcall16 DWORD * pdwCompareValue
;             (pointer: LSB in X, MSB in A, for pass-by-reference update)
;  RETURNS:   Nothing (but see Side Effects).
;  SIDE EFFECTS:
;     1. The DWORD pointed to by X takes on the value read from DR2
;     2. The A and X registers may be modified by this or future implementations
;        of this function.  The same is true for all RAM page pointer registers in
;        the Large Memory Model.  When necessary, it is the calling function's
;        responsibility to perserve their values across calls to fastcall16 
;        functions.
;              
;        Currently only the page pointer registers listed below are modified: 
;              IDX_PP

;
 SW_ReadCompareValue:
_SW_ReadCompareValue:
   RAM_PROLOGUE RAM_USE_CLASS_3
   RAM_SETPAGE_IDX A 
   mov   A, reg[SW_COMPARE_MSB_REG]
   mov   [X+0], A
   mov   A, reg[SW_COMPARE_ISB2_REG]
   mov   [X+1], A
   mov   A, reg[SW_COMPARE_ISB1_REG]
   mov   [X+2], A
   mov   A, reg[SW_COMPARE_LSB_REG]
   mov   [X+3], A
   RAM_EPILOGUE RAM_USE_CLASS_3
   ret

.ENDSECTION


.SECTION
;-----------------------------------------------------------------------------
;  FUNCTION NAME: SW_ReadTimerSaveCV
;
;  DESCRIPTION:
;     Retrieves the value in the Count register (DR0), preserving the
;     value in the compare register (DR2).
;-----------------------------------------------------------------------------
;
;  ARGUMENTS: fastcall16 DWORD * pdwCount
;             (pointer: LSB in X, MSB in A, for pass-by-reference update)
;  RETURNS:   Nothing (but see Side Effects).
;  SIDE EFFECTS:
;     1) The DWORD pointed to by X takes on the value read from DR0
;     2) May cause an interrupt, if interrupt on Compare is enabled.
;     3) If enabled, Global interrupts are momentarily disabled.
;     4) The user module is stopped momentarily while the compare value is
;        restored.  This may cause the Count register to miss one or more
;        counts depending on the input clock speed.
;     5) The A and X registers may be modified by this or future implementations
;        of this function.  The same is true for all RAM page pointer registers in
;        the Large Memory Model.  When necessary, it is the calling function's
;        responsibility to perserve their values across calls to fastcall16 
;        functions.
;              
;        Currently only the page pointer registers listed below are modified: 
;              IDX_PP
;
;  THEORY of OPERATION:
;     1) Read and save the Compare register.
;     2) Read the Count register, causing its data to be latched into
;        the Compare register.
;     3) Read and save the Counter value, now in the Compare register,
;        to the buffer.
;     4) Disable global interrupts
;     5) Halt the timer
;     6) Restore the Compare register values
;     7) Start the Timer again
;     8) Restore global interrupt state
;
 SW_ReadTimerSaveCV:
_SW_ReadTimerSaveCV:
 SW_ReadCounter:                                 ; this name deprecated
_SW_ReadCounter:                                 ; this name deprecated

   RAM_PROLOGUE RAM_USE_CLASS_3
   RAM_SETPAGE_IDX A 

   ; save the Control register on the stack
   mov   A, reg[SW_CONTROL_LSB_REG]
   push  A

   ; save the Compare register value
   mov   A, reg[SW_COMPARE_MSB_REG]
   push  A
   mov   A, reg[SW_COMPARE_ISB2_REG]
   push  A
   mov   A, reg[SW_COMPARE_ISB1_REG]
   push  A
   mov   A, reg[SW_COMPARE_LSB_REG]
   push  A

   ; Read the LSB count. This latches the Count register data into the
   ; Compare register of all bytes of chained PSoC blocks!
   ; This may cause an interrupt.
   mov   A, reg[SW_COUNTER_LSB_REG]

   ; Read the Compare register, which contains the counter value
   ; and store the return result
   mov   A, reg[SW_COMPARE_MSB_REG]
   mov   [X+0], A
   mov   A, reg[SW_COMPARE_ISB2_REG]
   mov   [X+1], A
   mov   A, reg[SW_COMPARE_ISB1_REG]
   mov   [X+2], A
   mov   A, reg[SW_COMPARE_LSB_REG]
   mov   [X+3], A

   ; determine current interrupt state and save in X
   mov   A, 0
   tst   reg[CPU_F], FLAG_GLOBAL_IE
   jz    .SetupStatusFlag
   mov   A, FLAG_GLOBAL_IE
.SetupStatusFlag:
   mov   X, A

   ; disable interrupts for the time being
   M8C_DisableGInt

   ; stop the timer
   SW_Stop_M

   ; Restore the Compare register
   pop   A
   mov   reg[SW_COMPARE_LSB_REG],  A
   pop   A
   mov   reg[SW_COMPARE_ISB1_REG], A
   pop   A
   mov   reg[SW_COMPARE_ISB2_REG], A
   pop   A
   mov   reg[SW_COMPARE_MSB_REG],  A

   ; restore start state of the timer
   pop   A
   mov   reg[SW_CONTROL_LSB_REG], A

   ; push the flag register to restore on the stack
   push  X

   RAM_EPILOGUE RAM_USE_CLASS_3
   ; Use RETI because it pops a the flag register off the stack
   ; and then returns to the caller.
   reti

.ENDSECTION


.SECTION
;-----------------------------------------------------------------------------
;  FUNCTION NAME: SW_ReadTimer
;
;  DESCRIPTION:
;     Performs a software capture of the Count register.  A synchronous
;     read of the Count register is performed.  The timer is NOT stopped.
;
;     WARNING - this will cause loss of data in the Compare register.
;-----------------------------------------------------------------------------
;
;  ARGUMENTS: fastcall16 DWORD * pdwCount
;             (pointer: LSB in X, MSB in A, for pass-by-reference update)
;  RETURNS:   Nothing (but see Side Effects).
;  SIDE EFFECTS:
;     1) The DWORD pointed to by X takes on the value read from DR2.
;     2) May cause an interrupt.
;     3) The A and X registers may be modified by this or future implementations
;        of this function.  The same is true for all RAM page pointer registers in
;        the Large Memory Model.  When necessary, it is the calling function's
;        responsibility to perserve their values across calls to fastcall16 
;        functions.
;              
;        Currently only the page pointer registers listed below are modified: 
;              IDX_PP
;
;  THEORY of OPERATION:
;     1) Read the Count register - this causes the count value to be
;        latched into the Compare registers.
;     2) Read and return the Count register values from the Compare
;        registers into the return buffer.
;
 SW_ReadTimer:
_SW_ReadTimer:
 SW_CaptureCounter:                              ; this name deprecated
_SW_CaptureCounter:                              ; this name deprecated

   RAM_PROLOGUE RAM_USE_CLASS_3
   RAM_SETPAGE_IDX A 

   ; Read the LSB of the Count register, DR0. This latches the count data into
   ; the Compare register of all bytes of chained PSoC blocks and may cause
   ; an interrupt.
   mov   A, reg[SW_COUNTER_LSB_REG]

   ; Read the Compare register, which contains the counter value
   ; and store ther return result
   mov   A, reg[SW_COMPARE_MSB_REG]
   mov   [X+0], A
   mov   A, reg[SW_COMPARE_ISB2_REG]
   mov   [X+1], A
   mov   A, reg[SW_COMPARE_ISB1_REG]
   mov   [X+2], A
   mov   A, reg[SW_COMPARE_LSB_REG]
   mov   [X+3], A
   RAM_EPILOGUE RAM_USE_CLASS_3
   ret

.ENDSECTION

; End of File SW.asm
