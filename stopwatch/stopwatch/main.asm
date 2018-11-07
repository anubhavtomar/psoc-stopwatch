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
averageSample: equ 0x29
longestSample: equ 0x30
shortestSample: equ 0x31

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
	mov [currentState] , 0x04
	
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
	;call _stopStateTimer
	call stateTimer_Stop
	call stateTimer_DisableInt
	mov [stateTimerFlag] , 0x00
	cmp [stateTimerSeconds] , 0x01
	jnc _goToNextState
	jmp _checkShortPressState
	
_checkShortPressState:
	;call _clearStateTimerVar
	mov A , 0x00
   	push A
   	mov A , 0x00
   	push A
   	mov A , 0xC3
   	push A
   	mov A , 0x4F
   	push A
   	lcall stateTimer_WritePeriod
	mov [stateTimerMilisec] , 0x00
	mov [stateTimerSeconds] , 0x00
	mov [stateTimerMinutes] , 0x00
	mov [stateTimerHour] ,0x00
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
	call LCD_Start
	call SW_Start
	mov [SWFlag] , 0x01
	jmp _check
	
_SWstop:
	call SW_Stop
	call SW_DisableInt
	;call _clearSWVar
	and F,[clearFlagMsk]
	cmp [accuracyItr],0x00
	jz _compAccuracy1
	and F,[clearFlagMsk]
	cmp [accuracyItr],0x05
	jz _compAccuracy5
	and F,[clearFlagMsk]
	jmp _compAccuracy01
	
_compAccuracy1:
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
	jmp _delayDisplaySWTime
	
_compAccuracy5:
	mov A , 0x00
   	push A
   	mov A , 0x00
   	push A
   	mov A , 0xC3
   	push A
   	mov A , 0x4F
   	push A
   	lcall SW_WritePeriod
	mov [milisec] , 0x00
	mov [seconds] , 0x00
	mov [minutes] , 0x00
	mov [hour] ,0x00
	mov [SWFlag] , 0x00
	jmp _delayDisplaySWTime

_compAccuracy01:
	mov A , 0x00
   	push A
   	mov A , 0x00
   	push A
   	mov A , 0x27
   	push A
   	mov A , 0x0F
   	push A
   	lcall SW_WritePeriod
	mov [milisec] , 0x00
	mov [seconds] , 0x00
	mov [minutes] , 0x00
	mov [hour] ,0x00
	mov [SWFlag] , 0x00
	jmp _delayDisplaySWTime
	
_delayDisplaySWTime:
	call stateTimer_EnableInt
	call stateTimer_Start
	mov [stateTimerFlag] , 0x01
_inter:
	cmp [stateTimerSeconds] , 0x05
	jc _inter
	call stateTimer_Stop
	call stateTimer_DisableInt
	mov A , 0x00
   	push A
   	mov A , 0x00
   	push A
   	mov A , 0xC3
   	push A
   	mov A , 0x4F
   	push A
   	lcall stateTimer_WritePeriod
	mov [stateTimerMilisec] , 0x00
	mov [stateTimerSeconds] , 0x00
	mov [stateTimerMinutes] , 0x00
	mov [stateTimerHour] ,0x00
	mov [stateTimerFlag] ,0x00
	;call _printSWInit
	call LCD_Start
	mov    A , 00
	mov    X , 00
   	call   LCD_Position
   	mov    A , [hour]
   	call   LCD_PrHexByte   
	
	mov    A , 00
	mov    X , 02
   	call   LCD_Position
	mov    A , >COLON1
   	mov    X , <COLON1
   	call   LCD_PrCString
	
	mov    A , 00
	mov    X , 03
   	call   LCD_Position
   	mov    A , [minutes]
   	call   LCD_PrHexByte   
	
	mov    A , 00
	mov    X , 05
   	call   LCD_Position
	mov    A , >COLON1
   	mov    X , <COLON1
   	call   LCD_PrCString   
	
	mov    A , 00
	mov    X , 06
   	call   LCD_Position
   	mov    A , [seconds]
   	call   LCD_PrHexByte   
	
	mov    A , 00
	mov    X , 10
   	call   LCD_Position
	mov    A , >COLON1
   	mov    X , <COLON1
   	call   LCD_PrCString   
	
	mov    A , 00
	mov    X , 11
   	call   LCD_Position
	mov    A , [milisec]
   	call   LCD_PrHexByte 
	jmp _check

_goToNextState:
	;call _clearStateTimerVar
	mov A , 0x00
   	push A
   	mov A , 0x00
   	push A
   	mov A , 0xC3
   	push A
   	mov A , 0x4F
   	push A
   	lcall stateTimer_WritePeriod
	mov [stateTimerMilisec] , 0x00
	mov [stateTimerSeconds] , 0x00
	mov [stateTimerMinutes] , 0x00
	mov [stateTimerHour] ,0x00
	and F , clearFlagMsk
	cmp [SWFlag] , 0x01
	jz _check
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
	call LCD_Start
	mov    A,00
	mov    X,00
   	call   LCD_Position
	mov    A,>Microphone
   	mov    X,<Microphone
   	call   LCD_PrCString  
	jmp _check
	
_setAccuracy:
	mov [currentState] , 0x01
	call LCD_Start
	mov    A , 00
	mov    X , 00
   	call   LCD_Position
	mov    A , >Accuracy
   	mov    X , <Accuracy
   	call   LCD_PrCString  
	mov [accuracyItr] , 0x00
	mov    A , 01
	mov    X , 00
   	call   LCD_Position
	mov    A , 0x10
   	call   LCD_PrHexByte
	jmp _check
	
_soundSW:
	mov [currentState] , 0x02
	call LCD_Start
	mov    A , 00
	mov    X , 00
   	call   LCD_Position
	mov    A , >Sound
   	mov    X , <Sound
   	call   LCD_PrCString  
	jmp _check
	
_pushBtnSW:
	mov [currentState] , 0x03
	call LCD_Start
	mov    A , 00
	mov    X , 00
   	call   LCD_Position
	mov    A , >PushBtn
   	mov    X , <PushBtn
   	call   LCD_PrCString  
	jmp _check
	
_displayMemory:
	mov [currentState] , 0x04
	call LCD_Start
	mov    A , 00
	mov    X , 00
   	call   LCD_Position
	mov    A , >Memory
   	mov    X , <Memory
   	call   LCD_PrCString  
	jmp _check
	
_goToNextAccuracy:
	cmp [accuracyItr] , 0x00
	jz _accuracyState1
	cmp [accuracyItr] , 0x05
	jz _accuracyState2
	jmp _accuracyState3
	
_accuracyState1:
	mov [accuracyItr] , 0x05
	mov A , 0x00
   	push A
   	mov A , 0x00
   	push A
   	mov A , 0xC3
   	push A
   	mov A , 0x4F
   	push A
   	lcall SW_WritePeriod
	mov    A , 01
	mov    X , 00
   	call   LCD_Position
	mov    A , [accuracyItr]
   	call   LCD_PrHexByte
	jmp _check

_accuracyState2:
	mov [accuracyItr] , 0x01
	mov A , 0x00
   	push A
   	mov A , 0x00
   	push A
   	mov A , 0x27
   	push A
   	mov A , 0x0F
   	push A
   	lcall SW_WritePeriod
	mov    A , 01
	mov    X , 00
   	call   LCD_Position
	mov    A , [accuracyItr]
   	call   LCD_PrHexByte
	jmp _check
	
_accuracyState3:
	mov [accuracyItr] , 0x00
	mov A , 0x00
   	push A
   	mov A , 0x01
   	push A
   	mov A , 0x86
   	push A
   	mov A , 0x9F
   	push A
   	lcall SW_WritePeriod
	mov    A , 01  
	mov    X , 00  
   	call   LCD_Position
	mov    A , 0x10
   	call   LCD_PrHexByte
	jmp _check

.LITERAL
	highStr:
		ds  "HIGH"
		db  00h
.ENDLITERAL

.LITERAL
	lowStr:
		ds  "LOW"
		db  00h
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