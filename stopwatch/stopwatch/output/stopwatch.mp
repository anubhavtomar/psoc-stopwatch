Project:      output/stopwatch
Build Number: 0
Date:         Sun Nov 04 23:44:33 2018
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
                     UserModules   03E6   04A0 =   1184. bytes (rel,con,rom,code)

       Addr  Global Symbol
      -----  --------------------------------
       03E6  _SW_ISR
       045B  SW_EnableInt
       045B  _SW_EnableInt
       045F  SW_DisableInt
       045F  _SW_DisableInt
       0463  SW_Start
       0463  _SW_Start
       0467  _SW_Stop
       0467  SW_Stop
       046B  _SW_WritePeriod
       046B  SW_WritePeriod
       0481  SW_WriteCompareValue
       0481  _SW_WriteCompareValue
       0497  SW_ReadCompareValue
       0497  _SW_ReadCompareValue
       04B0  SW_ReadTimerSaveCV
       04B0  _SW_ReadTimerSaveCV
       04B0  SW_ReadCounter
       04B0  _SW_ReadCounter
       04F9  _SW_CaptureCounter
       04F9  SW_ReadTimer
       04F9  _SW_ReadTimer
       04F9  SW_CaptureCounter
       0514  _stateTimer_ISR
       053E  _stateTimer_EnableInt
       053E  stateTimer_EnableInt
       0542  _stateTimer_DisableInt
       0542  stateTimer_DisableInt
       0546  _stateTimer_Start
       0546  stateTimer_Start
       054A  stateTimer_Stop
       054A  _stateTimer_Stop
       054E  stateTimer_WritePeriod
       054E  _stateTimer_WritePeriod
       0564  stateTimer_WriteCompareValue
       0564  _stateTimer_WriteCompareValue
       057A  stateTimer_ReadCompareValue
       057A  _stateTimer_ReadCompareValue
       0593  stateTimer_ReadTimerSaveCV
       0593  stateTimer_ReadCounter
       0593  _stateTimer_ReadCounter
       0593  _stateTimer_ReadTimerSaveCV
       05DC  stateTimer_CaptureCounter
       05DC  _stateTimer_CaptureCounter
       05DC  stateTimer_ReadTimer
       05DC  _stateTimer_ReadTimer
       05F7  _LCD_PrCString
       05F7  LCD_PrCString
       0609  LCD_HEX_STR
       0619  _LCD_PrHexByte
       0619  LCD_PrHexByte
       062C  _LCD_PrHexInt
       062C  LCD_PrHexInt
       0633  _LCD_PrString
       0633  LCD_PrString
       0645  _LCD_Write_Data
       0645  _LCD_WriteData
       0645  LCD_Write_Data
       0645  LCD_WriteData
       0659  _LCD_Control
       0659  LCD_Control
       0709  _LCD_Init
       0709  LCD_Start
       0709  _LCD_Start
       0709  LCD_Init
       0778  LCD_ROW_OFFSET
       077C  LCD_Position
       077C  _LCD_Position
       078C  LCD_Delay50uTimes
       078C  _LCD_Delay50uTimes
       0792  LCD_Delay50u_Table
       079A  _LCD_Delay50u
       079A  LCD_Delay50u
       07AE  _LCD_DrawBG
       07DF  _LCD_DrawVBG
       0813  LCD_InitVBG
       0813  _LCD_InitVBG
       0844  LCD_BG_TYPE1
       084B  LCD_BG_TYPE2
       0852  _LCD_InitBG
       0852  LCD_InitBG
       0886  __UserModules_end

Area                               Addr   Size   Decimal Bytes (Attributes)
--------------------------------   ----   ----   ------- ----- ------------
                            text   0886   022A =    554. bytes (rel,con,rom,code)

       Addr  Global Symbol
      -----  --------------------------------
       0886  dwElapsedTime
       0886  __text_start
       0886  _dwElapsedTime
       088A  _main
       0AAF  PSoC_GPIO_ISR
       0AB0  __text_end
       0AB0  __xidata_start
       0AB2  __xidata_end

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

