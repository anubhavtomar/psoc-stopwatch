Project:      output/stopwatch
Build Number: 0
Date:         Thu Nov 08 12:05:37 2018
Compiler:     ICCM8C
Version:      7.05.00


Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                             lit   01A0   00D4 =    212. bytes (rel,con,rom,lit)

       Addr  Global Symbol
      -----  --------------------------------
       01A0  LoadConfigTBL_stopwatch_Bank0
       021F  LoadConfigTBL_stopwatch_Bank1
       0274  __lit_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                        func_lit   0274   0002 =      2. bytes (rel,con,rom,proclab)

       Addr  Global Symbol
      -----  --------------------------------
       0274  __func_lit_start
       0276  __func_lit_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                     psoc_config   0276   0170 =    368. bytes (rel,con,rom,code)

       Addr  Global Symbol
      -----  --------------------------------
       0276  LoadConfigTBL_stopwatch_Ordered
       037B  _LoadConfigInit
       037B  LoadConfigInit
       038B  _LoadConfig_stopwatch
       038B  LoadConfig_stopwatch
       03E6  __psoc_config_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                     UserModules   03E6   04AD =   1197. bytes (rel,con,rom,code)

       Addr  Global Symbol
      -----  --------------------------------
       03E6  _SW_ISR
       0468  SW_EnableInt
       0468  _SW_EnableInt
       046C  SW_DisableInt
       046C  _SW_DisableInt
       0470  SW_Start
       0470  _SW_Start
       0474  _SW_Stop
       0474  SW_Stop
       0478  _SW_WritePeriod
       0478  SW_WritePeriod
       048E  SW_WriteCompareValue
       048E  _SW_WriteCompareValue
       04A4  SW_ReadCompareValue
       04A4  _SW_ReadCompareValue
       04BD  SW_ReadTimerSaveCV
       04BD  _SW_ReadTimerSaveCV
       04BD  SW_ReadCounter
       04BD  _SW_ReadCounter
       0506  _SW_CaptureCounter
       0506  SW_ReadTimer
       0506  _SW_ReadTimer
       0506  SW_CaptureCounter
       0521  _stateTimer_ISR
       054B  _stateTimer_EnableInt
       054B  stateTimer_EnableInt
       054F  _stateTimer_DisableInt
       054F  stateTimer_DisableInt
       0553  _stateTimer_Start
       0553  stateTimer_Start
       0557  stateTimer_Stop
       0557  _stateTimer_Stop
       055B  stateTimer_WritePeriod
       055B  _stateTimer_WritePeriod
       0571  stateTimer_WriteCompareValue
       0571  _stateTimer_WriteCompareValue
       0587  stateTimer_ReadCompareValue
       0587  _stateTimer_ReadCompareValue
       05A0  stateTimer_ReadTimerSaveCV
       05A0  stateTimer_ReadCounter
       05A0  _stateTimer_ReadCounter
       05A0  _stateTimer_ReadTimerSaveCV
       05E9  stateTimer_CaptureCounter
       05E9  _stateTimer_CaptureCounter
       05E9  stateTimer_ReadTimer
       05E9  _stateTimer_ReadTimer
       0604  _LCD_PrCString
       0604  LCD_PrCString
       0616  LCD_HEX_STR
       0626  _LCD_PrHexByte
       0626  LCD_PrHexByte
       0639  _LCD_PrHexInt
       0639  LCD_PrHexInt
       0640  _LCD_PrString
       0640  LCD_PrString
       0652  _LCD_Write_Data
       0652  _LCD_WriteData
       0652  LCD_Write_Data
       0652  LCD_WriteData
       0666  _LCD_Control
       0666  LCD_Control
       0716  _LCD_Init
       0716  LCD_Start
       0716  _LCD_Start
       0716  LCD_Init
       0785  LCD_ROW_OFFSET
       0789  LCD_Position
       0789  _LCD_Position
       0799  LCD_Delay50uTimes
       0799  _LCD_Delay50uTimes
       079F  LCD_Delay50u_Table
       07A7  _LCD_Delay50u
       07A7  LCD_Delay50u
       07BB  _LCD_DrawBG
       07EC  _LCD_DrawVBG
       0820  LCD_InitVBG
       0820  _LCD_InitVBG
       0851  LCD_BG_TYPE1
       0858  LCD_BG_TYPE2
       085F  _LCD_InitBG
       085F  LCD_InitBG
       0893  __UserModules_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            text   0893   0387 =    903. bytes (rel,con,rom,code)

       Addr  Global Symbol
      -----  --------------------------------
       0893  __text_start
       0893  _clearStateTimerVar
       08AF  _clearSWVar
       08CB  _stopStateTimer
       08D3  _printSWInit
       0929  _dwElapsedTime
       0929  dwElapsedTime
       092D  _main
       0C19  PSoC_GPIO_ISR
       0C1A  __text_end
       0C1A  __xidata_start
       0C1C  __xidata_end

Area                               Start  End    Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                             TOP   0000   0143 =    323. bytes (abs,ovr,rom,code)

       Addr  Global Symbol
      -----  --------------------------------
       0068  __Start
       0140  _bGetPowerSetting
       0140  bGetPowerSetting

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                    InterruptRAM   0000   0003 =      3. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0000  _NO_SHADOW
       0000  Port_2_Data_SHADE
       0000  NO_SHADOW
       0000  _Port_2_Data_SHADE
       0001  _Port_2_DriveMode_0_SHADE
       0001  Port_2_DriveMode_0_SHADE
       0002  _Port_2_DriveMode_1_SHADE
       0002  Port_2_DriveMode_1_SHADE

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
               virtual_registers   0003   0002 =      2. bytes (rel,con,ram)

       Addr  Global Symbol
      -----  --------------------------------
       0003  __r1
       0004  __r0

Files Linked      [ module(s) ]

./obj/boot.o	[ boot.asm ]
obj/lib.o	[ lib.asm ]
obj/main.o	[ main.asm ]
<library>	[ swint.asm, sw.asm, statetimerint.asm, statetimer.asm, psocgpioint.asm, psocconfigtbl.asm, psocconfig.asm ]
[ lcd.asm, r1.asm, r0.asm ]

Area Definitions

-blit:0x1a0.0x7fff
-bdata:0.0x6ff
-BInterruptRAM:0	allocated at: 0
-Bvirtual_registers	allocated at: 0x3
-Bstopwatch_RAM	allocated at: 0
-rwh:SSCParmBlk:0xf7.0xff

