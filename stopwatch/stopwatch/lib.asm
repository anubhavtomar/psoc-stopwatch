include "m8c.inc"       ; part specific constants and macros
include "memory.inc"    ; Constants & macros for SMM/LMM and Compiler
include "PSoCAPI.inc"   ; PSoC API definitions for all User Modules

area text (ROM, REL)

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

Export _clearStateTimerVar
Export _clearSWVar
Export _stopStateTimer
Export _printSWInit

.SECTION 
	_clearStateTimerVar:
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
		ret
.ENDSECTION 
	
.SECTION 
	_clearSWVar:
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
		ret
.ENDSECTION 
	
.SECTION	
	_stopStateTimer: 
		call stateTimer_Stop
		call stateTimer_DisableInt
		mov [stateTimerFlag] , 0x00
		ret
.ENDSECTION 
	
.SECTION
	_printSWInit:
		call LCD_Start
		mov    A,00
		mov    X,00
	   	call   LCD_Position
	   	mov    A,[hour]
	   	call   LCD_PrHexByte   
		
		mov    A,00
		mov    X,02
	   	call   LCD_Position
		mov    A,>COLON2
	   	mov    X,<COLON2
	   	call   LCD_PrCString
		
		mov    A,00
		mov    X,03
	   	call   LCD_Position
	   	mov    A,[minutes]
	   	call   LCD_PrHexByte   
		
		mov    A,00
		mov    X,05
	   	call   LCD_Position
		mov    A,>COLON2
	   	mov    X,<COLON2
	   	call   LCD_PrCString   
		
		mov    A,00
		mov    X,06
	   	call   LCD_Position
	   	mov    A,[seconds]
	   	call   LCD_PrHexByte   
		
		mov    A,00
		mov    X,10
	   	call   LCD_Position
		mov    A,>COLON2
	   	mov    X,<COLON2
	   	call   LCD_PrCString   
		
		mov    A,00
		mov    X,11
	   	call   LCD_Position
		mov    A,[milisec]
	   	call   LCD_PrHexByte  
		ret
.ENDSECTION 

.LITERAL
	highStr1:
		ds  "HIGH"
		db  00h                   ; String should always be null terminated		
.ENDLITERAL

.LITERAL
	COLON2:
		ds  ":"
		db  00h
.ENDLITERAL
