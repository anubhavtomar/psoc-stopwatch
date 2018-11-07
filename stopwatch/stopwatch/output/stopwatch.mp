Project:      output/stopwatch
Build Number: 0
Date:         Wed Nov 07 00:48:23 2018
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
                     UserModules   03E6   04A9 =   1193. bytes (rel,con,rom,code)

       Addr  Global Symbol
      -----  --------------------------------
       03E6  _SW_ISR
       0464  SW_EnableInt
       0464  _SW_EnableInt
       0468  SW_DisableInt
       0468  _SW_DisableInt
       046C  SW_Start
       046C  _SW_Start
       0470  _SW_Stop
       0470  SW_Stop
       0474  _SW_WritePeriod
       0474  SW_WritePeriod
       048A  SW_WriteCompareValue
       048A  _SW_WriteCompareValue
       04A0  SW_ReadCompareValue
       04A0  _SW_ReadCompareValue
       04B9  SW_ReadTimerSaveCV
       04B9  _SW_ReadTimerSaveCV
       04B9  SW_ReadCounter
       04B9  _SW_ReadCounter
       0502  _SW_CaptureCounter
       0502  SW_ReadTimer
       0502  _SW_ReadTimer
       0502  SW_CaptureCounter
       051D  _stateTimer_ISR
       0547  _stateTimer_EnableInt
       0547  stateTimer_EnableInt
       054B  _stateTimer_DisableInt
       054B  stateTimer_DisableInt
       054F  _stateTimer_Start
       054F  stateTimer_Start
       0553  stateTimer_Stop
       0553  _stateTimer_Stop
       0557  stateTimer_WritePeriod
       0557  _stateTimer_WritePeriod
       056D  stateTimer_WriteCompareValue
       056D  _stateTimer_WriteCompareValue
       0583  stateTimer_ReadCompareValue
       0583  _stateTimer_ReadCompareValue
       059C  stateTimer_ReadTimerSaveCV
       059C  stateTimer_ReadCounter
       059C  _stateTimer_ReadCounter
       059C  _stateTimer_ReadTimerSaveCV
       05E5  stateTimer_CaptureCounter
       05E5  _stateTimer_CaptureCounter
       05E5  stateTimer_ReadTimer
       05E5  _stateTimer_ReadTimer
       0600  _LCD_PrCString
       0600  LCD_PrCString
       0612  LCD_HEX_STR
       0622  _LCD_PrHexByte
       0622  LCD_PrHexByte
       0635  _LCD_PrHexInt
       0635  LCD_PrHexInt
       063C  _LCD_PrString
       063C  LCD_PrString
       064E  _LCD_Write_Data
       064E  _LCD_WriteData
       064E  LCD_Write_Data
       064E  LCD_WriteData
       0662  _LCD_Control
       0662  LCD_Control
       0712  _LCD_Init
       0712  LCD_Start
       0712  _LCD_Start
       0712  LCD_Init
       0781  LCD_ROW_OFFSET
       0785  LCD_Position
       0785  _LCD_Position
       0795  LCD_Delay50uTimes
       0795  _LCD_Delay50uTimes
       079B  LCD_Delay50u_Table
       07A3  _LCD_Delay50u
       07A3  LCD_Delay50u
       07B7  _LCD_DrawBG
       07E8  _LCD_DrawVBG
       081C  LCD_InitVBG
       081C  _LCD_InitVBG
       084D  LCD_BG_TYPE1
       0854  LCD_BG_TYPE2
       085B  _LCD_InitBG
       085B  LCD_InitBG
       088F  __UserModules_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            text   088F   03B4 =    948. bytes (rel,con,rom,code)

       Addr  Global Symbol
      -----  --------------------------------
       088F  __text_start
       088F  _clearStateTimerVar
       08AB  _clearSWVar
       08C7  _stopStateTimer
       08CF  _printSWInit
       0925  _dwElapsedTime
       0925  dwElapsedTime
       0929  _main
       0C42  PSoC_GPIO_ISR
       0C43  __text_end
       0C43  __xidata_start
       0C45  __xidata_end

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

