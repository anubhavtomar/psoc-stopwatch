;-----------------------------------------------------------------------------
; Assembly main line
;-----------------------------------------------------------------------------

include "m8c.inc"       ; part specific constants and macros
include "memory.inc"    ; Constants & macros for SMM/LMM and Compiler
include "PSoCAPI.inc"   ; PSoC API definitions for all User Modules

area text (ROM, REL)

export _main

;Memory Address Refrence
PRT0DR: equ 0x00
PRT1DR: equ 0x04
milisec: equ 0x10
seconds: equ 0x11
minutes: equ 0x12
hour: equ 0x13
stateTimerFlag: equ 0x14
accuracy: equ 0x20
accuracyItr: equ 0x21
stateTimerMilisec: equ 0x22
stateTimerSeconds: equ 0x23
stateTimerMinutes: equ 0x24
stateTimerHour: equ 0x25
stateTimerAccuracy: equ 0x26
SWFlag: equ 0x27

_dwElapsedTime::  
	dwElapsedTime::    BLK    4


;Mask Initilization
btnMSK: equ 0x01
clearFlagMsk: equ 249

_main:

    M8C_EnableGInt ; Uncomment this line to enable Global Interrupts
	; Insert your main assembly code here.
	call LCD_Start
	mov [milisec] , 0x00
	mov [seconds] , 0x00
	mov [minutes] , 0x00
	mov [hour] ,0x00
	mov [stateTimerMilisec] , 0x00
	mov [stateTimerSeconds] , 0x00
	mov [stateTimerMinutes] , 0x00
	mov [stateTimerHour] ,0x00
	mov [stateTimerAccuracy] , 0x05
	mov [stateTimerFlag] , 0x00
	mov [accuracy] , 0x01
	mov [accuracyItr] , 0x00
	mov [SWFlag] , 0x00
	
_check:
	and F , clearFlagMsk
	cmp [stateTimerFlag] , 0x01
	jz _stopTimer
	
_poll:
	mov a , REG[PRT1DR]
	and a , btnMSK
	and F , clearFlagMsk
	cmp a , 0x01
	jnz _check
	and F , clearFlagMsk
	cmp [stateTimerFlag] , 0x01
	jz _poll
	call stateTimer_EnableInt
	call stateTimer_Start
	mov [stateTimerFlag] , 0x01
	jmp _poll

_stopTimer: 
	call stateTimer_Stop
	call stateTimer_DisableInt
	mov A , 0x00
	push A
	mov A , 0x01
	push A
	mov A , 0x86
	push A
	mov A , 0x9F
	push A
	lcall stateTimer_WritePeriod
	mov [stateTimerFlag] , 0x00
	cmp [stateTimerSeconds] , 0x01
	jnc _checkSWState
	jmp _check
	
_checkSWState:
	mov [stateTimerMilisec] , 0x00
	mov [stateTimerSeconds] , 0x00
	mov [stateTimerMinutes] , 0x00
	mov [stateTimerHour] ,0x00
	cmp [SWFlag] , 0x01
	jz _SWstop
	jmp _SWstart

_SWstart:
	call SW_EnableInt
	call SW_Start
	mov [SWFlag] , 0x01
	jmp _check
	
_SWstop:
	call SW_Stop
	call SW_DisableInt
	mov A , 0x00
	push A
	mov A , 0x01
	push A
	mov A , 0x86
	push A
	mov A , 0x9F
	push A
	lcall SW_WritePeriod
	mov [milisec] , 0x00
	mov [seconds] , 0x00
	mov [minutes] , 0x00
	mov [hour] ,0x00
	mov [SWFlag] , 0x00
	jmp _check
	
_printHigh: 
	mov    A,00           ; Set cursor position at row = 0
	mov    X,02           ; col = 5
   	call   LCD_Position
	mov    A,>highStr      ; Load pointer to ROM string
   	mov    X,<highStr; Load pointer to ROM strin
   	call   LCD_PrCString
	mov [stateTimerMilisec] , 0x00
	mov [stateTimerSeconds] , 0x00
	mov [stateTimerMinutes] , 0x00
	mov [stateTimerHour] ,0x00
	mov [stateTimerAccuracy] , 0x05
	jmp _check
	
_printLow:
	mov    A,01           ; Set cursor position at row = 0
	mov    X,02           ; col = 5
   	call   LCD_Position
	mov    A,>lowStr      ; Load pointer to ROM string
   	mov    X,<lowStr; Load pointer to ROM strin
   	call   LCD_PrCString
	mov [stateTimerMilisec] , 0x00
	mov [stateTimerSeconds] , 0x00
	mov [stateTimerMinutes] , 0x00
	mov [stateTimerHour] ,0x00
	mov [stateTimerAccuracy] , 0x05
	jmp _check
	
.LITERAL
	highStr:
		ds  "HIGH"
		db  00h                   ; String should always be null terminated		
.ENDLITERAL

.LITERAL
	lowStr:
		ds  "LOW"
		db  00h                   ; String should always be null terminated		
.ENDLITERAL

.terminate:
    jmp .terminate
+