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
currentState: equ 0x28

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
	mov [currentState] , 0x00
	
_check:
	and F , clearFlagMsk
	cmp [stateTimerFlag] , 0x01
	jz _checkLongPress
	
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
	
_checkLongPress:
	call _stopStateTimer
	cmp [stateTimerSeconds] , 0x01
	jnc _goToNextState
	jmp _checkShortPressState
	
_checkShortPressState:
	call _clearStateTimerVar
	cmp [currentState] , 0x01
	jz _goToNextAccuracy
	cmp [currentState] , 0x02
	jz _checkSWState
	cmp [currentState] , 0x03
	jz _checkSWState
	jmp _check
	
_checkSWState:
	cmp [SWFlag] , 0x01
	jz _SWstop
	cmp [currentState] , 0x03
	jz _SWstart
	jmp _check
	
_SWstart:
	call SW_EnableInt
	call SW_Start
	mov [SWFlag] , 0x01
	jmp _check
	
_SWstop:
	call SW_Stop
	call SW_DisableInt
	call _clearSWVar
	mov [SWFlag] , 0x00
	jmp _check
	
_delayDisplaySWTime:
	call stateTimer_EnableInt
	call stateTimer_Start
	mov [stateTimerFlag] , 0x01
_inter:
	cmp [stateTimerSeconds] , 0x05
	jc _inter
	call _printSWInit
	jmp _check
	

	
_goToNextState:
	call _clearStateTimerVar
	mov    A,00
		mov    X,02
	   	call   LCD_Position
		mov    A,>highStr
	   	mov    X,<highStr
	   	call   LCD_PrCString
	and F , clearFlagMsk
	cmp [currentState] , 0x04
	jz _setSensitivity
	and F , clearFlagMsk
	cmp [currentState] , 0x00
	jz _setAccuracy
	and F , clearFlagMsk
	cmp [currentState] , 0x01
	jz _soundSW
	and F , clearFlagMsk
	cmp [currentState] , 0x02
	jz _pushBtnSW
	jnc _displayMemory
	
_setSensitivity:
	mov [currentState] , 0x00
	mov    A,00
	mov    X,00
   	call   LCD_Position
	mov    A,>Microphone
   	mov    X,<Microphone
   	call   LCD_PrCString  
	jmp _check
	
_setAccuracy:
	mov [currentState] , 0x01
	mov    A,00
	mov    X,00
   	call   LCD_Position
	mov    A,>Accuracy
   	mov    X,<Accuracy
   	call   LCD_PrCString  
	mov [accuracyItr] , 0x00
	jmp _check
	
_soundSW:
	mov [currentState] , 0x02
	mov    A,00
	mov    X,00
   	call   LCD_Position
	mov    A,>Sound
   	mov    X,<Sound
   	call   LCD_PrCString  
	jmp _check
	
_pushBtnSW:
	mov [currentState] , 0x03
	mov    A,00
	mov    X,00
   	call   LCD_Position
	mov    A,>PushBtn
   	mov    X,<PushBtn
   	call   LCD_PrCString  
	jmp _check
	
_displayMemory:
	mov [currentState] , 0x04
	mov    A,00
	mov    X,00
   	call   LCD_Position
	mov    A,>Memory
   	mov    X,<Memory
   	call   LCD_PrCString  
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
	
_goToNextAccuracy:
	cmp [accuracyItr] , 0x00
	jz _accuracyState1
	cmp [accuracyItr] , 0x05
	jz _accuracyState2
	jmp _accuracyState3
	
_accuracyState1:
	mov [accuracyItr] , 0x05
	jmp _check

_accuracyState2:
	mov [accuracyItr] , 0x01
	jmp _check
	
_accuracyState3:
	mov [accuracyItr] , 0x00
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

.LITERAL
	Microphone:
		ds  "Microphone"
		db  00h
.ENDLITERAL

.LITERAL
	Accuracy:
		ds  "Accuracy Mode"
		db  00h
.ENDLITERAL

.LITERAL
	Sound:
		ds  "Sound"
		db  00h
.ENDLITERAL

.LITERAL
	PushBtn:
		ds  "Push Button"
		db  00h
.ENDLITERAL

.LITERAL
	Memory:
		ds  "Memory"
		db  00h
.ENDLITERAL

.LITERAL
	COLON1:
		ds  ":"
		db  00h
.ENDLITERAL

.terminate:
    jmp .terminate
	
	ret