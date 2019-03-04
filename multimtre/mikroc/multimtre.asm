
_configPort:

;multimtre.c,23 :: 		void configPort()
;multimtre.c,25 :: 		TRISC=0;TRISC.rc3=1;TRISC.rc4=1;TRISC.rc5=1;
	CLRF       TRISC+0
	BSF        TRISC+0, 3
	BSF        TRISC+0, 4
	BSF        TRISC+0, 5
;multimtre.c,26 :: 		}
L_end_configPort:
	RETURN
; end of _configPort

_InitTimer0:

;multimtre.c,27 :: 		void InitTimer0(){
;multimtre.c,28 :: 		OPTION_REG	 = 0x88;
	MOVLW      136
	MOVWF      OPTION_REG+0
;multimtre.c,29 :: 		TMR0		 = 206;
	MOVLW      206
	MOVWF      TMR0+0
;multimtre.c,30 :: 		INTCON	 = 0xA0;
	MOVLW      160
	MOVWF      INTCON+0
;multimtre.c,31 :: 		}
L_end_InitTimer0:
	RETURN
; end of _InitTimer0

_calcR:

;multimtre.c,32 :: 		int calcR(int R,int Rm)
;multimtre.c,34 :: 		v0=ADC_read(0);
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	CALL       _word2double+0
	MOVF       R0+0, 0
	MOVWF      _v0+0
	MOVF       R0+1, 0
	MOVWF      _v0+1
	MOVF       R0+2, 0
	MOVWF      _v0+2
	MOVF       R0+3, 0
	MOVWF      _v0+3
;multimtre.c,35 :: 		vx=ADC_read(1);
	MOVLW      1
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	CALL       _word2double+0
	MOVF       R0+0, 0
	MOVWF      FLOC__calcR+4
	MOVF       R0+1, 0
	MOVWF      FLOC__calcR+5
	MOVF       R0+2, 0
	MOVWF      FLOC__calcR+6
	MOVF       R0+3, 0
	MOVWF      FLOC__calcR+7
	MOVF       FLOC__calcR+4, 0
	MOVWF      _vx+0
	MOVF       FLOC__calcR+5, 0
	MOVWF      _vx+1
	MOVF       FLOC__calcR+6, 0
	MOVWF      _vx+2
	MOVF       FLOC__calcR+7, 0
	MOVWF      _vx+3
;multimtre.c,36 :: 		Rx=(vx*(Rm+R))/(v0-vx);
	MOVF       FARG_calcR_R+0, 0
	ADDWF      FARG_calcR_Rm+0, 0
	MOVWF      R0+0
	MOVF       FARG_calcR_Rm+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      FARG_calcR_R+1, 0
	MOVWF      R0+1
	CALL       _int2double+0
	MOVF       FLOC__calcR+4, 0
	MOVWF      R4+0
	MOVF       FLOC__calcR+5, 0
	MOVWF      R4+1
	MOVF       FLOC__calcR+6, 0
	MOVWF      R4+2
	MOVF       FLOC__calcR+7, 0
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      FLOC__calcR+0
	MOVF       R0+1, 0
	MOVWF      FLOC__calcR+1
	MOVF       R0+2, 0
	MOVWF      FLOC__calcR+2
	MOVF       R0+3, 0
	MOVWF      FLOC__calcR+3
	MOVF       FLOC__calcR+4, 0
	MOVWF      R4+0
	MOVF       FLOC__calcR+5, 0
	MOVWF      R4+1
	MOVF       FLOC__calcR+6, 0
	MOVWF      R4+2
	MOVF       FLOC__calcR+7, 0
	MOVWF      R4+3
	MOVF       _v0+0, 0
	MOVWF      R0+0
	MOVF       _v0+1, 0
	MOVWF      R0+1
	MOVF       _v0+2, 0
	MOVWF      R0+2
	MOVF       _v0+3, 0
	MOVWF      R0+3
	CALL       _Sub_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      R4+0
	MOVF       R0+1, 0
	MOVWF      R4+1
	MOVF       R0+2, 0
	MOVWF      R4+2
	MOVF       R0+3, 0
	MOVWF      R4+3
	MOVF       FLOC__calcR+0, 0
	MOVWF      R0+0
	MOVF       FLOC__calcR+1, 0
	MOVWF      R0+1
	MOVF       FLOC__calcR+2, 0
	MOVWF      R0+2
	MOVF       FLOC__calcR+3, 0
	MOVWF      R0+3
	CALL       _Div_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      _Rx+0
	MOVF       R0+1, 0
	MOVWF      _Rx+1
	MOVF       R0+2, 0
	MOVWF      _Rx+2
	MOVF       R0+3, 0
	MOVWF      _Rx+3
;multimtre.c,37 :: 		return Rx;
	CALL       _double2int+0
;multimtre.c,38 :: 		}
L_end_calcR:
	RETURN
; end of _calcR

_printR:

;multimtre.c,39 :: 		char printR(float R,int i)
;multimtre.c,41 :: 		FloatToStr_FixLen(R,valeur,i);
	MOVF       FARG_printR_R+0, 0
	MOVWF      FARG_FloatToStr_FixLen_fnum+0
	MOVF       FARG_printR_R+1, 0
	MOVWF      FARG_FloatToStr_FixLen_fnum+1
	MOVF       FARG_printR_R+2, 0
	MOVWF      FARG_FloatToStr_FixLen_fnum+2
	MOVF       FARG_printR_R+3, 0
	MOVWF      FARG_FloatToStr_FixLen_fnum+3
	MOVLW      _valeur+0
	MOVWF      FARG_FloatToStr_FixLen_str+0
	MOVF       FARG_printR_i+0, 0
	MOVWF      FARG_FloatToStr_FixLen_len+0
	CALL       _FloatToStr_FixLen+0
;multimtre.c,42 :: 		return valeur;
	MOVLW      _valeur+0
	MOVWF      R0+0
;multimtre.c,43 :: 		}
L_end_printR:
	RETURN
; end of _printR

_milsecond:

;multimtre.c,44 :: 		int milsecond(float pV)
;multimtre.c,46 :: 		portc.rc6=1;delay_ms(500);portc.rc6=0;
	BSF        PORTC+0, 6
	MOVLW      31
	MOVWF      R11+0
	MOVLW      113
	MOVWF      R12+0
	MOVLW      30
	MOVWF      R13+0
L_milsecond0:
	DECFSZ     R13+0, 1
	GOTO       L_milsecond0
	DECFSZ     R12+0, 1
	GOTO       L_milsecond0
	DECFSZ     R11+0, 1
	GOTO       L_milsecond0
	NOP
	BCF        PORTC+0, 6
;multimtre.c,47 :: 		vx=ADC_read(1);
	MOVLW      1
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	CALL       _word2double+0
	MOVF       R0+0, 0
	MOVWF      _vx+0
	MOVF       R0+1, 0
	MOVWF      _vx+1
	MOVF       R0+2, 0
	MOVWF      _vx+2
	MOVF       R0+3, 0
	MOVWF      _vx+3
;multimtre.c,48 :: 		timer=0;
	CLRF       _timer+0
	CLRF       _timer+1
;multimtre.c,49 :: 		while(vx<pV)
L_milsecond1:
	MOVF       FARG_milsecond_pV+0, 0
	MOVWF      R4+0
	MOVF       FARG_milsecond_pV+1, 0
	MOVWF      R4+1
	MOVF       FARG_milsecond_pV+2, 0
	MOVWF      R4+2
	MOVF       FARG_milsecond_pV+3, 0
	MOVWF      R4+3
	MOVF       _vx+0, 0
	MOVWF      R0+0
	MOVF       _vx+1, 0
	MOVWF      R0+1
	MOVF       _vx+2, 0
	MOVWF      R0+2
	MOVF       _vx+3, 0
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_milsecond2
;multimtre.c,51 :: 		if(TMR0IF_bit)
	BTFSS      TMR0IF_bit+0, BitPos(TMR0IF_bit+0)
	GOTO       L_milsecond3
;multimtre.c,53 :: 		TMR0IF_bit=0;
	BCF        TMR0IF_bit+0, BitPos(TMR0IF_bit+0)
;multimtre.c,54 :: 		timer++;
	INCF       _timer+0, 1
	BTFSC      STATUS+0, 2
	INCF       _timer+1, 1
;multimtre.c,55 :: 		TMR0=206;
	MOVLW      206
	MOVWF      TMR0+0
;multimtre.c,56 :: 		vx=ADC_read(1);
	MOVLW      1
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	CALL       _word2double+0
	MOVF       R0+0, 0
	MOVWF      _vx+0
	MOVF       R0+1, 0
	MOVWF      _vx+1
	MOVF       R0+2, 0
	MOVWF      _vx+2
	MOVF       R0+3, 0
	MOVWF      _vx+3
;multimtre.c,57 :: 		}
L_milsecond3:
;multimtre.c,58 :: 		}
	GOTO       L_milsecond1
L_milsecond2:
;multimtre.c,59 :: 		return timer ;
	MOVF       _timer+0, 0
	MOVWF      R0+0
	MOVF       _timer+1, 0
	MOVWF      R0+1
;multimtre.c,60 :: 		}
L_end_milsecond:
	RETURN
; end of _milsecond

_main:

;multimtre.c,63 :: 		void main()
;multimtre.c,65 :: 		InitTimer0();
	CALL       _InitTimer0+0
;multimtre.c,66 :: 		configPort();
	CALL       _configPort+0
;multimtre.c,67 :: 		ADC_init();
	CALL       _ADC_Init+0
;multimtre.c,68 :: 		lcd_init();
	CALL       _Lcd_Init+0
;multimtre.c,69 :: 		lcd_cmd(_lcd_clear);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;multimtre.c,70 :: 		lcd_cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;multimtre.c,71 :: 		start:while(1)
___main_start:
L_main4:
;multimtre.c,73 :: 		lcd_out(1,1,"chose ");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_multimtre+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;multimtre.c,74 :: 		lcd_out(2,1,"1-R 2-C 3-db");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_multimtre+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;multimtre.c,75 :: 		Rx=0;
	CLRF       _Rx+0
	CLRF       _Rx+1
	CLRF       _Rx+2
	CLRF       _Rx+3
;multimtre.c,76 :: 		if (Button(&PORTC, 3, 1, 0))        //buttone calcule de R
	MOVLW      PORTC+0
	MOVWF      FARG_Button_port+0
	MOVLW      3
	MOVWF      FARG_Button_pin+0
	MOVLW      1
	MOVWF      FARG_Button_time_ms+0
	CLRF       FARG_Button_active_state+0
	CALL       _Button+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main6
;multimtre.c,78 :: 		oldstate = 1;
	BSF        _oldstate+0, BitPos(_oldstate+0)
;multimtre.c,79 :: 		}
	GOTO       L_main7
L_main6:
;multimtre.c,80 :: 		else if (Button(&PORTC, 3, 1, 1)&&(oldstate))
	MOVLW      PORTC+0
	MOVWF      FARG_Button_port+0
	MOVLW      3
	MOVWF      FARG_Button_pin+0
	MOVLW      1
	MOVWF      FARG_Button_time_ms+0
	MOVLW      1
	MOVWF      FARG_Button_active_state+0
	CALL       _Button+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main10
	BTFSS      _oldstate+0, BitPos(_oldstate+0)
	GOTO       L_main10
L__main89:
;multimtre.c,82 :: 		lcd_cmd(_lcd_clear);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;multimtre.c,83 :: 		oldstate = 0;
	BCF        _oldstate+0, BitPos(_oldstate+0)
;multimtre.c,84 :: 		while(1)
L_main11:
;multimtre.c,86 :: 		if(Rx>=0&&Rx<=100){portc=0b000;lcd_out (1,3,printR(calcR(Rcalibre[0],354),5));ohm_kohm=0; }
	CLRF       R4+0
	CLRF       R4+1
	CLRF       R4+2
	CLRF       R4+3
	MOVF       _Rx+0, 0
	MOVWF      R0+0
	MOVF       _Rx+1, 0
	MOVWF      R0+1
	MOVF       _Rx+2, 0
	MOVWF      R0+2
	MOVF       _Rx+3, 0
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSS      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main15
	MOVF       _Rx+0, 0
	MOVWF      R4+0
	MOVF       _Rx+1, 0
	MOVWF      R4+1
	MOVF       _Rx+2, 0
	MOVWF      R4+2
	MOVF       _Rx+3, 0
	MOVWF      R4+3
	MOVLW      0
	MOVWF      R0+0
	MOVLW      0
	MOVWF      R0+1
	MOVLW      72
	MOVWF      R0+2
	MOVLW      133
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSS      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main15
L__main88:
	CLRF       PORTC+0
	MOVLW      100
	MOVWF      FARG_calcR_R+0
	MOVLW      0
	MOVWF      FARG_calcR_R+1
	MOVLW      98
	MOVWF      FARG_calcR_Rm+0
	MOVLW      1
	MOVWF      FARG_calcR_Rm+1
	CALL       _calcR+0
	CALL       _int2double+0
	MOVF       R0+0, 0
	MOVWF      FARG_printR_R+0
	MOVF       R0+1, 0
	MOVWF      FARG_printR_R+1
	MOVF       R0+2, 0
	MOVWF      FARG_printR_R+2
	MOVF       R0+3, 0
	MOVWF      FARG_printR_R+3
	MOVLW      5
	MOVWF      FARG_printR_i+0
	MOVLW      0
	MOVWF      FARG_printR_i+1
	CALL       _printR+0
	MOVF       R0+0, 0
	MOVWF      FARG_Lcd_Out_text+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      3
	MOVWF      FARG_Lcd_Out_column+0
	CALL       _Lcd_Out+0
	BCF        _ohm_kohm+0, BitPos(_ohm_kohm+0)
	GOTO       L_main16
L_main15:
;multimtre.c,87 :: 		else if(Rx>100&&Rx<=900){portc=0b001;lcd_out (1,3,printR(calcR(Rcalibre[1],360),7));ohm_kohm=0; }
	MOVF       _Rx+0, 0
	MOVWF      R4+0
	MOVF       _Rx+1, 0
	MOVWF      R4+1
	MOVF       _Rx+2, 0
	MOVWF      R4+2
	MOVF       _Rx+3, 0
	MOVWF      R4+3
	MOVLW      0
	MOVWF      R0+0
	MOVLW      0
	MOVWF      R0+1
	MOVLW      72
	MOVWF      R0+2
	MOVLW      133
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main19
	MOVF       _Rx+0, 0
	MOVWF      R4+0
	MOVF       _Rx+1, 0
	MOVWF      R4+1
	MOVF       _Rx+2, 0
	MOVWF      R4+2
	MOVF       _Rx+3, 0
	MOVWF      R4+3
	MOVLW      0
	MOVWF      R0+0
	MOVLW      0
	MOVWF      R0+1
	MOVLW      97
	MOVWF      R0+2
	MOVLW      136
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSS      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main19
L__main87:
	MOVLW      1
	MOVWF      PORTC+0
	MOVLW      232
	MOVWF      FARG_calcR_R+0
	MOVLW      3
	MOVWF      FARG_calcR_R+1
	MOVLW      104
	MOVWF      FARG_calcR_Rm+0
	MOVLW      1
	MOVWF      FARG_calcR_Rm+1
	CALL       _calcR+0
	CALL       _int2double+0
	MOVF       R0+0, 0
	MOVWF      FARG_printR_R+0
	MOVF       R0+1, 0
	MOVWF      FARG_printR_R+1
	MOVF       R0+2, 0
	MOVWF      FARG_printR_R+2
	MOVF       R0+3, 0
	MOVWF      FARG_printR_R+3
	MOVLW      7
	MOVWF      FARG_printR_i+0
	MOVLW      0
	MOVWF      FARG_printR_i+1
	CALL       _printR+0
	MOVF       R0+0, 0
	MOVWF      FARG_Lcd_Out_text+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      3
	MOVWF      FARG_Lcd_Out_column+0
	CALL       _Lcd_Out+0
	BCF        _ohm_kohm+0, BitPos(_ohm_kohm+0)
	GOTO       L_main20
L_main19:
;multimtre.c,88 :: 		else if(Rx>900&&Rx<=20000){portc=0b010;lcd_out (1,3,printR(calcR(Rcalibre[2],360),7));ohm_kohm=0; }
	MOVF       _Rx+0, 0
	MOVWF      R4+0
	MOVF       _Rx+1, 0
	MOVWF      R4+1
	MOVF       _Rx+2, 0
	MOVWF      R4+2
	MOVF       _Rx+3, 0
	MOVWF      R4+3
	MOVLW      0
	MOVWF      R0+0
	MOVLW      0
	MOVWF      R0+1
	MOVLW      97
	MOVWF      R0+2
	MOVLW      136
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main23
	MOVF       _Rx+0, 0
	MOVWF      R4+0
	MOVF       _Rx+1, 0
	MOVWF      R4+1
	MOVF       _Rx+2, 0
	MOVWF      R4+2
	MOVF       _Rx+3, 0
	MOVWF      R4+3
	MOVLW      0
	MOVWF      R0+0
	MOVLW      64
	MOVWF      R0+1
	MOVLW      28
	MOVWF      R0+2
	MOVLW      141
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSS      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main23
L__main86:
	MOVLW      2
	MOVWF      PORTC+0
	MOVLW      16
	MOVWF      FARG_calcR_R+0
	MOVLW      39
	MOVWF      FARG_calcR_R+1
	MOVLW      104
	MOVWF      FARG_calcR_Rm+0
	MOVLW      1
	MOVWF      FARG_calcR_Rm+1
	CALL       _calcR+0
	CALL       _int2double+0
	MOVF       R0+0, 0
	MOVWF      FARG_printR_R+0
	MOVF       R0+1, 0
	MOVWF      FARG_printR_R+1
	MOVF       R0+2, 0
	MOVWF      FARG_printR_R+2
	MOVF       R0+3, 0
	MOVWF      FARG_printR_R+3
	MOVLW      7
	MOVWF      FARG_printR_i+0
	MOVLW      0
	MOVWF      FARG_printR_i+1
	CALL       _printR+0
	MOVF       R0+0, 0
	MOVWF      FARG_Lcd_Out_text+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      3
	MOVWF      FARG_Lcd_Out_column+0
	CALL       _Lcd_Out+0
	BCF        _ohm_kohm+0, BitPos(_ohm_kohm+0)
	GOTO       L_main24
L_main23:
;multimtre.c,89 :: 		else if(Rx>20000&&Rx<=90000){ portc=0b011;lcd_out (1,3,printR(calcR(Rcalibre[3],1),5));Rx=calcR(100000,1);ohm_kohm=1;}
	MOVF       _Rx+0, 0
	MOVWF      R4+0
	MOVF       _Rx+1, 0
	MOVWF      R4+1
	MOVF       _Rx+2, 0
	MOVWF      R4+2
	MOVF       _Rx+3, 0
	MOVWF      R4+3
	MOVLW      0
	MOVWF      R0+0
	MOVLW      64
	MOVWF      R0+1
	MOVLW      28
	MOVWF      R0+2
	MOVLW      141
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main27
	MOVF       _Rx+0, 0
	MOVWF      R4+0
	MOVF       _Rx+1, 0
	MOVWF      R4+1
	MOVF       _Rx+2, 0
	MOVWF      R4+2
	MOVF       _Rx+3, 0
	MOVWF      R4+3
	MOVLW      0
	MOVWF      R0+0
	MOVLW      200
	MOVWF      R0+1
	MOVLW      47
	MOVWF      R0+2
	MOVLW      143
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSS      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main27
L__main85:
	MOVLW      3
	MOVWF      PORTC+0
	MOVLW      100
	MOVWF      FARG_calcR_R+0
	MOVLW      0
	MOVWF      FARG_calcR_R+1
	MOVLW      1
	MOVWF      FARG_calcR_Rm+0
	MOVLW      0
	MOVWF      FARG_calcR_Rm+1
	CALL       _calcR+0
	CALL       _int2double+0
	MOVF       R0+0, 0
	MOVWF      FARG_printR_R+0
	MOVF       R0+1, 0
	MOVWF      FARG_printR_R+1
	MOVF       R0+2, 0
	MOVWF      FARG_printR_R+2
	MOVF       R0+3, 0
	MOVWF      FARG_printR_R+3
	MOVLW      5
	MOVWF      FARG_printR_i+0
	MOVLW      0
	MOVWF      FARG_printR_i+1
	CALL       _printR+0
	MOVF       R0+0, 0
	MOVWF      FARG_Lcd_Out_text+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      3
	MOVWF      FARG_Lcd_Out_column+0
	CALL       _Lcd_Out+0
	MOVLW      160
	MOVWF      FARG_calcR_R+0
	MOVLW      134
	MOVWF      FARG_calcR_R+1
	MOVLW      1
	MOVWF      FARG_calcR_Rm+0
	MOVLW      0
	MOVWF      FARG_calcR_Rm+1
	CALL       _calcR+0
	CALL       _int2double+0
	MOVF       R0+0, 0
	MOVWF      _Rx+0
	MOVF       R0+1, 0
	MOVWF      _Rx+1
	MOVF       R0+2, 0
	MOVWF      _Rx+2
	MOVF       R0+3, 0
	MOVWF      _Rx+3
	BSF        _ohm_kohm+0, BitPos(_ohm_kohm+0)
L_main27:
L_main24:
L_main20:
L_main16:
;multimtre.c,90 :: 		if(Rx>90000&&Rx<=300000){ portc=0b100;lcd_out (1,3,printR(calcR(Rcalibre[4],1),5));Rx=calcR(1000000,360);ohm_kohm=1;}
	MOVF       _Rx+0, 0
	MOVWF      R4+0
	MOVF       _Rx+1, 0
	MOVWF      R4+1
	MOVF       _Rx+2, 0
	MOVWF      R4+2
	MOVF       _Rx+3, 0
	MOVWF      R4+3
	MOVLW      0
	MOVWF      R0+0
	MOVLW      200
	MOVWF      R0+1
	MOVLW      47
	MOVWF      R0+2
	MOVLW      143
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main30
	MOVF       _Rx+0, 0
	MOVWF      R4+0
	MOVF       _Rx+1, 0
	MOVWF      R4+1
	MOVF       _Rx+2, 0
	MOVWF      R4+2
	MOVF       _Rx+3, 0
	MOVWF      R4+3
	MOVLW      0
	MOVWF      R0+0
	MOVLW      124
	MOVWF      R0+1
	MOVLW      18
	MOVWF      R0+2
	MOVLW      145
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSS      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main30
L__main84:
	MOVLW      4
	MOVWF      PORTC+0
	MOVLW      232
	MOVWF      FARG_calcR_R+0
	MOVLW      3
	MOVWF      FARG_calcR_R+1
	MOVLW      1
	MOVWF      FARG_calcR_Rm+0
	MOVLW      0
	MOVWF      FARG_calcR_Rm+1
	CALL       _calcR+0
	CALL       _int2double+0
	MOVF       R0+0, 0
	MOVWF      FARG_printR_R+0
	MOVF       R0+1, 0
	MOVWF      FARG_printR_R+1
	MOVF       R0+2, 0
	MOVWF      FARG_printR_R+2
	MOVF       R0+3, 0
	MOVWF      FARG_printR_R+3
	MOVLW      5
	MOVWF      FARG_printR_i+0
	MOVLW      0
	MOVWF      FARG_printR_i+1
	CALL       _printR+0
	MOVF       R0+0, 0
	MOVWF      FARG_Lcd_Out_text+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      3
	MOVWF      FARG_Lcd_Out_column+0
	CALL       _Lcd_Out+0
	MOVLW      64
	MOVWF      FARG_calcR_R+0
	MOVLW      66
	MOVWF      FARG_calcR_R+1
	MOVLW      104
	MOVWF      FARG_calcR_Rm+0
	MOVLW      1
	MOVWF      FARG_calcR_Rm+1
	CALL       _calcR+0
	CALL       _int2double+0
	MOVF       R0+0, 0
	MOVWF      _Rx+0
	MOVF       R0+1, 0
	MOVWF      _Rx+1
	MOVF       R0+2, 0
	MOVWF      _Rx+2
	MOVF       R0+3, 0
	MOVWF      _Rx+3
	BSF        _ohm_kohm+0, BitPos(_ohm_kohm+0)
L_main30:
;multimtre.c,91 :: 		if(Rx>300000&&Rx<=500000){ portc=0b100;lcd_out (1,3,printR(calcR(Rcalibre[4],8),5));Rx=calcR(1000000,360);ohm_kohm=1;}
	MOVF       _Rx+0, 0
	MOVWF      R4+0
	MOVF       _Rx+1, 0
	MOVWF      R4+1
	MOVF       _Rx+2, 0
	MOVWF      R4+2
	MOVF       _Rx+3, 0
	MOVWF      R4+3
	MOVLW      0
	MOVWF      R0+0
	MOVLW      124
	MOVWF      R0+1
	MOVLW      18
	MOVWF      R0+2
	MOVLW      145
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main33
	MOVF       _Rx+0, 0
	MOVWF      R4+0
	MOVF       _Rx+1, 0
	MOVWF      R4+1
	MOVF       _Rx+2, 0
	MOVWF      R4+2
	MOVF       _Rx+3, 0
	MOVWF      R4+3
	MOVLW      0
	MOVWF      R0+0
	MOVLW      36
	MOVWF      R0+1
	MOVLW      116
	MOVWF      R0+2
	MOVLW      145
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSS      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main33
L__main83:
	MOVLW      4
	MOVWF      PORTC+0
	MOVLW      232
	MOVWF      FARG_calcR_R+0
	MOVLW      3
	MOVWF      FARG_calcR_R+1
	MOVLW      8
	MOVWF      FARG_calcR_Rm+0
	MOVLW      0
	MOVWF      FARG_calcR_Rm+1
	CALL       _calcR+0
	CALL       _int2double+0
	MOVF       R0+0, 0
	MOVWF      FARG_printR_R+0
	MOVF       R0+1, 0
	MOVWF      FARG_printR_R+1
	MOVF       R0+2, 0
	MOVWF      FARG_printR_R+2
	MOVF       R0+3, 0
	MOVWF      FARG_printR_R+3
	MOVLW      5
	MOVWF      FARG_printR_i+0
	MOVLW      0
	MOVWF      FARG_printR_i+1
	CALL       _printR+0
	MOVF       R0+0, 0
	MOVWF      FARG_Lcd_Out_text+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      3
	MOVWF      FARG_Lcd_Out_column+0
	CALL       _Lcd_Out+0
	MOVLW      64
	MOVWF      FARG_calcR_R+0
	MOVLW      66
	MOVWF      FARG_calcR_R+1
	MOVLW      104
	MOVWF      FARG_calcR_Rm+0
	MOVLW      1
	MOVWF      FARG_calcR_Rm+1
	CALL       _calcR+0
	CALL       _int2double+0
	MOVF       R0+0, 0
	MOVWF      _Rx+0
	MOVF       R0+1, 0
	MOVWF      _Rx+1
	MOVF       R0+2, 0
	MOVWF      _Rx+2
	MOVF       R0+3, 0
	MOVWF      _Rx+3
	BSF        _ohm_kohm+0, BitPos(_ohm_kohm+0)
L_main33:
;multimtre.c,92 :: 		if(Rx>500000&&Rx<=800000){ portc=0b100;lcd_out (1,3,printR(calcR(Rcalibre[4],10),5));Rx=calcR(1000000,360);ohm_kohm=1;}
	MOVF       _Rx+0, 0
	MOVWF      R4+0
	MOVF       _Rx+1, 0
	MOVWF      R4+1
	MOVF       _Rx+2, 0
	MOVWF      R4+2
	MOVF       _Rx+3, 0
	MOVWF      R4+3
	MOVLW      0
	MOVWF      R0+0
	MOVLW      36
	MOVWF      R0+1
	MOVLW      116
	MOVWF      R0+2
	MOVLW      145
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main36
	MOVF       _Rx+0, 0
	MOVWF      R4+0
	MOVF       _Rx+1, 0
	MOVWF      R4+1
	MOVF       _Rx+2, 0
	MOVWF      R4+2
	MOVF       _Rx+3, 0
	MOVWF      R4+3
	MOVLW      0
	MOVWF      R0+0
	MOVLW      80
	MOVWF      R0+1
	MOVLW      67
	MOVWF      R0+2
	MOVLW      146
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSS      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main36
L__main82:
	MOVLW      4
	MOVWF      PORTC+0
	MOVLW      232
	MOVWF      FARG_calcR_R+0
	MOVLW      3
	MOVWF      FARG_calcR_R+1
	MOVLW      10
	MOVWF      FARG_calcR_Rm+0
	MOVLW      0
	MOVWF      FARG_calcR_Rm+1
	CALL       _calcR+0
	CALL       _int2double+0
	MOVF       R0+0, 0
	MOVWF      FARG_printR_R+0
	MOVF       R0+1, 0
	MOVWF      FARG_printR_R+1
	MOVF       R0+2, 0
	MOVWF      FARG_printR_R+2
	MOVF       R0+3, 0
	MOVWF      FARG_printR_R+3
	MOVLW      5
	MOVWF      FARG_printR_i+0
	MOVLW      0
	MOVWF      FARG_printR_i+1
	CALL       _printR+0
	MOVF       R0+0, 0
	MOVWF      FARG_Lcd_Out_text+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      3
	MOVWF      FARG_Lcd_Out_column+0
	CALL       _Lcd_Out+0
	MOVLW      64
	MOVWF      FARG_calcR_R+0
	MOVLW      66
	MOVWF      FARG_calcR_R+1
	MOVLW      104
	MOVWF      FARG_calcR_Rm+0
	MOVLW      1
	MOVWF      FARG_calcR_Rm+1
	CALL       _calcR+0
	CALL       _int2double+0
	MOVF       R0+0, 0
	MOVWF      _Rx+0
	MOVF       R0+1, 0
	MOVWF      _Rx+1
	MOVF       R0+2, 0
	MOVWF      _Rx+2
	MOVF       R0+3, 0
	MOVWF      _Rx+3
	BSF        _ohm_kohm+0, BitPos(_ohm_kohm+0)
L_main36:
;multimtre.c,93 :: 		if(Rx>800000&&Rx<=1200000){ portc=0b100;lcd_out (1,3,printR(calcR(Rcalibre[4],18),7));Rx=calcR(1000000,360);ohm_kohm=1;}
	MOVF       _Rx+0, 0
	MOVWF      R4+0
	MOVF       _Rx+1, 0
	MOVWF      R4+1
	MOVF       _Rx+2, 0
	MOVWF      R4+2
	MOVF       _Rx+3, 0
	MOVWF      R4+3
	MOVLW      0
	MOVWF      R0+0
	MOVLW      80
	MOVWF      R0+1
	MOVLW      67
	MOVWF      R0+2
	MOVLW      146
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main39
	MOVF       _Rx+0, 0
	MOVWF      R4+0
	MOVF       _Rx+1, 0
	MOVWF      R4+1
	MOVF       _Rx+2, 0
	MOVWF      R4+2
	MOVF       _Rx+3, 0
	MOVWF      R4+3
	MOVLW      0
	MOVWF      R0+0
	MOVLW      124
	MOVWF      R0+1
	MOVLW      18
	MOVWF      R0+2
	MOVLW      147
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSS      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main39
L__main81:
	MOVLW      4
	MOVWF      PORTC+0
	MOVLW      232
	MOVWF      FARG_calcR_R+0
	MOVLW      3
	MOVWF      FARG_calcR_R+1
	MOVLW      18
	MOVWF      FARG_calcR_Rm+0
	MOVLW      0
	MOVWF      FARG_calcR_Rm+1
	CALL       _calcR+0
	CALL       _int2double+0
	MOVF       R0+0, 0
	MOVWF      FARG_printR_R+0
	MOVF       R0+1, 0
	MOVWF      FARG_printR_R+1
	MOVF       R0+2, 0
	MOVWF      FARG_printR_R+2
	MOVF       R0+3, 0
	MOVWF      FARG_printR_R+3
	MOVLW      7
	MOVWF      FARG_printR_i+0
	MOVLW      0
	MOVWF      FARG_printR_i+1
	CALL       _printR+0
	MOVF       R0+0, 0
	MOVWF      FARG_Lcd_Out_text+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      3
	MOVWF      FARG_Lcd_Out_column+0
	CALL       _Lcd_Out+0
	MOVLW      64
	MOVWF      FARG_calcR_R+0
	MOVLW      66
	MOVWF      FARG_calcR_R+1
	MOVLW      104
	MOVWF      FARG_calcR_Rm+0
	MOVLW      1
	MOVWF      FARG_calcR_Rm+1
	CALL       _calcR+0
	CALL       _int2double+0
	MOVF       R0+0, 0
	MOVWF      _Rx+0
	MOVF       R0+1, 0
	MOVWF      _Rx+1
	MOVF       R0+2, 0
	MOVWF      _Rx+2
	MOVF       R0+3, 0
	MOVWF      _Rx+3
	BSF        _ohm_kohm+0, BitPos(_ohm_kohm+0)
L_main39:
;multimtre.c,94 :: 		if(Rx>1200000){lcd_out(1,3,"Inf   ");ohm_kohm=1;}
	MOVF       _Rx+0, 0
	MOVWF      R4+0
	MOVF       _Rx+1, 0
	MOVWF      R4+1
	MOVF       _Rx+2, 0
	MOVWF      R4+2
	MOVF       _Rx+3, 0
	MOVWF      R4+3
	MOVLW      0
	MOVWF      R0+0
	MOVLW      124
	MOVWF      R0+1
	MOVLW      18
	MOVWF      R0+2
	MOVLW      147
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main40
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      3
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr3_multimtre+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
	BSF        _ohm_kohm+0, BitPos(_ohm_kohm+0)
L_main40:
;multimtre.c,95 :: 		lcd_out(1,1,"R=");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr4_multimtre+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;multimtre.c,96 :: 		if(ohm_kohm==0){lcd_out(1,11,"OHM");}else {lcd_out(1,11,"KOHM   ");}
	BTFSC      _ohm_kohm+0, BitPos(_ohm_kohm+0)
	GOTO       L_main41
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      11
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr5_multimtre+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
	GOTO       L_main42
L_main41:
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      11
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr6_multimtre+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
L_main42:
;multimtre.c,97 :: 		lcd_out(2,11,"3-back");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      11
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr7_multimtre+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;multimtre.c,98 :: 		if (Button(&PORTC, 5, 1, 0))
	MOVLW      PORTC+0
	MOVWF      FARG_Button_port+0
	MOVLW      5
	MOVWF      FARG_Button_pin+0
	MOVLW      1
	MOVWF      FARG_Button_time_ms+0
	CLRF       FARG_Button_active_state+0
	CALL       _Button+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main43
;multimtre.c,100 :: 		oldstate1 = 1;
	BSF        _oldstate1+0, BitPos(_oldstate1+0)
;multimtre.c,101 :: 		}
	GOTO       L_main44
L_main43:
;multimtre.c,102 :: 		else if (Button(&PORTC, 5, 1, 1)&&(oldstate1))
	MOVLW      PORTC+0
	MOVWF      FARG_Button_port+0
	MOVLW      5
	MOVWF      FARG_Button_pin+0
	MOVLW      1
	MOVWF      FARG_Button_time_ms+0
	MOVLW      1
	MOVWF      FARG_Button_active_state+0
	CALL       _Button+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main47
	BTFSS      _oldstate1+0, BitPos(_oldstate1+0)
	GOTO       L_main47
L__main80:
;multimtre.c,104 :: 		oldstate1 = 0;
	BCF        _oldstate1+0, BitPos(_oldstate1+0)
;multimtre.c,105 :: 		lcd_cmd(_lcd_clear);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;multimtre.c,106 :: 		goto start;
	GOTO       ___main_start
;multimtre.c,107 :: 		}
L_main47:
L_main44:
;multimtre.c,109 :: 		}
	GOTO       L_main11
;multimtre.c,110 :: 		}
L_main10:
L_main7:
;multimtre.c,111 :: 		if (Button(&PORTc, 4, 1, 0))   //buttone calcule de F
	MOVLW      PORTC+0
	MOVWF      FARG_Button_port+0
	MOVLW      4
	MOVWF      FARG_Button_pin+0
	MOVLW      1
	MOVWF      FARG_Button_time_ms+0
	CLRF       FARG_Button_active_state+0
	CALL       _Button+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main48
;multimtre.c,113 :: 		oldstate1=1;
	BSF        _oldstate1+0, BitPos(_oldstate1+0)
;multimtre.c,114 :: 		}
	GOTO       L_main49
L_main48:
;multimtre.c,115 :: 		else if (Button(&PORTc, 4, 1, 1)&&(oldstate1))
	MOVLW      PORTC+0
	MOVWF      FARG_Button_port+0
	MOVLW      4
	MOVWF      FARG_Button_pin+0
	MOVLW      1
	MOVWF      FARG_Button_time_ms+0
	MOVLW      1
	MOVWF      FARG_Button_active_state+0
	CALL       _Button+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main52
	BTFSS      _oldstate1+0, BitPos(_oldstate1+0)
	GOTO       L_main52
L__main79:
;multimtre.c,117 :: 		oldstate1=0;
	BCF        _oldstate1+0, BitPos(_oldstate1+0)
;multimtre.c,118 :: 		lcd_cmd(_lcd_clear);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;multimtre.c,119 :: 		lcd_out(1,1,"C=");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr8_multimtre+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;multimtre.c,120 :: 		lcd_out(2,11,"3-back");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      11
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr9_multimtre+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;multimtre.c,122 :: 		while(1)
L_main53:
;multimtre.c,125 :: 		Portc=0b001;
	MOVLW      1
	MOVWF      PORTC+0
;multimtre.c,126 :: 		milsecond(648);
	MOVLW      0
	MOVWF      FARG_milsecond_pV+0
	MOVLW      0
	MOVWF      FARG_milsecond_pV+1
	MOVLW      34
	MOVWF      FARG_milsecond_pV+2
	MOVLW      136
	MOVWF      FARG_milsecond_pV+3
	CALL       _milsecond+0
;multimtre.c,127 :: 		if(timer<=10)
	MOVF       _timer+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main96
	MOVF       _timer+0, 0
	SUBLW      10
L__main96:
	BTFSS      STATUS+0, 0
	GOTO       L_main55
;multimtre.c,129 :: 		portc=0b010;
	MOVLW      2
	MOVWF      PORTC+0
;multimtre.c,130 :: 		milsecond(648);
	MOVLW      0
	MOVWF      FARG_milsecond_pV+0
	MOVLW      0
	MOVWF      FARG_milsecond_pV+1
	MOVLW      34
	MOVWF      FARG_milsecond_pV+2
	MOVLW      136
	MOVWF      FARG_milsecond_pV+3
	CALL       _milsecond+0
;multimtre.c,131 :: 		if(timer<=5)
	MOVF       _timer+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main97
	MOVF       _timer+0, 0
	SUBLW      5
L__main97:
	BTFSS      STATUS+0, 0
	GOTO       L_main56
;multimtre.c,133 :: 		portc=0b101 ;
	MOVLW      5
	MOVWF      PORTC+0
;multimtre.c,134 :: 		milsecond(648);
	MOVLW      0
	MOVWF      FARG_milsecond_pV+0
	MOVLW      0
	MOVWF      FARG_milsecond_pV+1
	MOVLW      34
	MOVWF      FARG_milsecond_pV+2
	MOVLW      136
	MOVWF      FARG_milsecond_pV+3
	CALL       _milsecond+0
;multimtre.c,135 :: 		lcd_out(1,3,printR(milsecond(648)*14.286,5));lcd_out(1,1,"C=");lcd_out(1,8,"  pF");lcd_out(2,11,"3-back");
	MOVLW      0
	MOVWF      FARG_milsecond_pV+0
	MOVLW      0
	MOVWF      FARG_milsecond_pV+1
	MOVLW      34
	MOVWF      FARG_milsecond_pV+2
	MOVLW      136
	MOVWF      FARG_milsecond_pV+3
	CALL       _milsecond+0
	CALL       _int2double+0
	MOVLW      117
	MOVWF      R4+0
	MOVLW      147
	MOVWF      R4+1
	MOVLW      100
	MOVWF      R4+2
	MOVLW      130
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      FARG_printR_R+0
	MOVF       R0+1, 0
	MOVWF      FARG_printR_R+1
	MOVF       R0+2, 0
	MOVWF      FARG_printR_R+2
	MOVF       R0+3, 0
	MOVWF      FARG_printR_R+3
	MOVLW      5
	MOVWF      FARG_printR_i+0
	MOVLW      0
	MOVWF      FARG_printR_i+1
	CALL       _printR+0
	MOVF       R0+0, 0
	MOVWF      FARG_Lcd_Out_text+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      3
	MOVWF      FARG_Lcd_Out_column+0
	CALL       _Lcd_Out+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr10_multimtre+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      8
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr11_multimtre+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      11
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr12_multimtre+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;multimtre.c,136 :: 		}
	GOTO       L_main57
L_main56:
;multimtre.c,137 :: 		else {lcd_out(1,3,printR(milsecond(648)*14.3,5));lcd_out(1,1,"C=");lcd_out(1,8,"  nF");lcd_out(2,11,"3-back"); }
	MOVLW      0
	MOVWF      FARG_milsecond_pV+0
	MOVLW      0
	MOVWF      FARG_milsecond_pV+1
	MOVLW      34
	MOVWF      FARG_milsecond_pV+2
	MOVLW      136
	MOVWF      FARG_milsecond_pV+3
	CALL       _milsecond+0
	CALL       _int2double+0
	MOVLW      205
	MOVWF      R4+0
	MOVLW      204
	MOVWF      R4+1
	MOVLW      100
	MOVWF      R4+2
	MOVLW      130
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      FARG_printR_R+0
	MOVF       R0+1, 0
	MOVWF      FARG_printR_R+1
	MOVF       R0+2, 0
	MOVWF      FARG_printR_R+2
	MOVF       R0+3, 0
	MOVWF      FARG_printR_R+3
	MOVLW      5
	MOVWF      FARG_printR_i+0
	MOVLW      0
	MOVWF      FARG_printR_i+1
	CALL       _printR+0
	MOVF       R0+0, 0
	MOVWF      FARG_Lcd_Out_text+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      3
	MOVWF      FARG_Lcd_Out_column+0
	CALL       _Lcd_Out+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr13_multimtre+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      8
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr14_multimtre+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      11
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr15_multimtre+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
L_main57:
;multimtre.c,138 :: 		}
	GOTO       L_main58
L_main55:
;multimtre.c,139 :: 		else {lcd_out(1,3,printR(milsecond(648)*0.1295,5));lcd_out(1,1,"C=");lcd_out(1,8,"  uF");lcd_out(2,11,"3-back"); }
	MOVLW      0
	MOVWF      FARG_milsecond_pV+0
	MOVLW      0
	MOVWF      FARG_milsecond_pV+1
	MOVLW      34
	MOVWF      FARG_milsecond_pV+2
	MOVLW      136
	MOVWF      FARG_milsecond_pV+3
	CALL       _milsecond+0
	CALL       _int2double+0
	MOVLW      166
	MOVWF      R4+0
	MOVLW      155
	MOVWF      R4+1
	MOVLW      4
	MOVWF      R4+2
	MOVLW      124
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      FARG_printR_R+0
	MOVF       R0+1, 0
	MOVWF      FARG_printR_R+1
	MOVF       R0+2, 0
	MOVWF      FARG_printR_R+2
	MOVF       R0+3, 0
	MOVWF      FARG_printR_R+3
	MOVLW      5
	MOVWF      FARG_printR_i+0
	MOVLW      0
	MOVWF      FARG_printR_i+1
	CALL       _printR+0
	MOVF       R0+0, 0
	MOVWF      FARG_Lcd_Out_text+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      3
	MOVWF      FARG_Lcd_Out_column+0
	CALL       _Lcd_Out+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr16_multimtre+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      8
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr17_multimtre+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      11
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr18_multimtre+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
L_main58:
;multimtre.c,142 :: 		if (Button(&PORTc, 5, 1, 0))
	MOVLW      PORTC+0
	MOVWF      FARG_Button_port+0
	MOVLW      5
	MOVWF      FARG_Button_pin+0
	MOVLW      1
	MOVWF      FARG_Button_time_ms+0
	CLRF       FARG_Button_active_state+0
	CALL       _Button+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main59
;multimtre.c,144 :: 		oldstate2 = 1;
	BSF        _oldstate2+0, BitPos(_oldstate2+0)
;multimtre.c,145 :: 		}
	GOTO       L_main60
L_main59:
;multimtre.c,146 :: 		else if (Button(&PORTc, 5, 1, 1)&&(oldstate2))
	MOVLW      PORTC+0
	MOVWF      FARG_Button_port+0
	MOVLW      5
	MOVWF      FARG_Button_pin+0
	MOVLW      1
	MOVWF      FARG_Button_time_ms+0
	MOVLW      1
	MOVWF      FARG_Button_active_state+0
	CALL       _Button+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main63
	BTFSS      _oldstate2+0, BitPos(_oldstate2+0)
	GOTO       L_main63
L__main78:
;multimtre.c,148 :: 		oldstate2 = 0;
	BCF        _oldstate2+0, BitPos(_oldstate2+0)
;multimtre.c,149 :: 		lcd_cmd(_lcd_clear);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;multimtre.c,150 :: 		goto start;
	GOTO       ___main_start
;multimtre.c,151 :: 		}
L_main63:
L_main60:
;multimtre.c,152 :: 		}
	GOTO       L_main53
;multimtre.c,153 :: 		}
L_main52:
L_main49:
;multimtre.c,154 :: 		if (Button(&PORTc, 5, 1, 0))  //  buttone calcule de db
	MOVLW      PORTC+0
	MOVWF      FARG_Button_port+0
	MOVLW      5
	MOVWF      FARG_Button_pin+0
	MOVLW      1
	MOVWF      FARG_Button_time_ms+0
	CLRF       FARG_Button_active_state+0
	CALL       _Button+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main64
;multimtre.c,156 :: 		oldstate2=1;
	BSF        _oldstate2+0, BitPos(_oldstate2+0)
;multimtre.c,157 :: 		}
	GOTO       L_main65
L_main64:
;multimtre.c,158 :: 		else if(Button(&PORTc, 5, 1, 1)&&(oldstate2))
	MOVLW      PORTC+0
	MOVWF      FARG_Button_port+0
	MOVLW      5
	MOVWF      FARG_Button_pin+0
	MOVLW      1
	MOVWF      FARG_Button_time_ms+0
	MOVLW      1
	MOVWF      FARG_Button_active_state+0
	CALL       _Button+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main68
	BTFSS      _oldstate2+0, BitPos(_oldstate2+0)
	GOTO       L_main68
L__main77:
;multimtre.c,160 :: 		oldstate2=0;
	BCF        _oldstate2+0, BitPos(_oldstate2+0)
;multimtre.c,161 :: 		lcd_cmd(_lcd_clear);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;multimtre.c,162 :: 		lcd_out(1,1,"db=");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr19_multimtre+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;multimtre.c,163 :: 		lcd_out(2,11,"3-back");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      11
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr20_multimtre+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;multimtre.c,164 :: 		while(1)
L_main69:
;multimtre.c,167 :: 		db = (adc_read(2)+b) / a ;
	MOVLW      2
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	CALL       _word2double+0
	MOVLW      35
	MOVWF      R4+0
	MOVLW      106
	MOVWF      R4+1
	MOVLW      38
	MOVWF      R4+2
	MOVLW      133
	MOVWF      R4+3
	CALL       _Add_32x32_FP+0
	MOVLW      74
	MOVWF      R4+0
	MOVLW      12
	MOVWF      R4+1
	MOVLW      48
	MOVWF      R4+2
	MOVLW      130
	MOVWF      R4+3
	CALL       _Div_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      _db+0
	MOVF       R0+1, 0
	MOVWF      _db+1
	MOVF       R0+2, 0
	MOVWF      _db+2
	MOVF       R0+3, 0
	MOVWF      _db+3
;multimtre.c,168 :: 		lcd_out(1,7,printR(db,5));
	MOVF       R0+0, 0
	MOVWF      FARG_printR_R+0
	MOVF       R0+1, 0
	MOVWF      FARG_printR_R+1
	MOVF       R0+2, 0
	MOVWF      FARG_printR_R+2
	MOVF       R0+3, 0
	MOVWF      FARG_printR_R+3
	MOVLW      5
	MOVWF      FARG_printR_i+0
	MOVLW      0
	MOVWF      FARG_printR_i+1
	CALL       _printR+0
	MOVF       R0+0, 0
	MOVWF      FARG_Lcd_Out_text+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      7
	MOVWF      FARG_Lcd_Out_column+0
	CALL       _Lcd_Out+0
;multimtre.c,169 :: 		lcd_out(1,1,"sound=");lcd_out(1,12,"db");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr21_multimtre+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      12
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr22_multimtre+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;multimtre.c,173 :: 		if (Button(&PORTc, 5, 1, 0))
	MOVLW      PORTC+0
	MOVWF      FARG_Button_port+0
	MOVLW      5
	MOVWF      FARG_Button_pin+0
	MOVLW      1
	MOVWF      FARG_Button_time_ms+0
	CLRF       FARG_Button_active_state+0
	CALL       _Button+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main71
;multimtre.c,175 :: 		oldstate = 1;
	BSF        _oldstate+0, BitPos(_oldstate+0)
;multimtre.c,176 :: 		}
	GOTO       L_main72
L_main71:
;multimtre.c,177 :: 		else if (Button(&PORTc, 5, 1, 1)&&(oldstate))
	MOVLW      PORTC+0
	MOVWF      FARG_Button_port+0
	MOVLW      5
	MOVWF      FARG_Button_pin+0
	MOVLW      1
	MOVWF      FARG_Button_time_ms+0
	MOVLW      1
	MOVWF      FARG_Button_active_state+0
	CALL       _Button+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main75
	BTFSS      _oldstate+0, BitPos(_oldstate+0)
	GOTO       L_main75
L__main76:
;multimtre.c,179 :: 		oldstate = 0;
	BCF        _oldstate+0, BitPos(_oldstate+0)
;multimtre.c,180 :: 		lcd_cmd(_lcd_clear);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;multimtre.c,181 :: 		goto start;
	GOTO       ___main_start
;multimtre.c,182 :: 		}
L_main75:
L_main72:
;multimtre.c,183 :: 		}
	GOTO       L_main69
;multimtre.c,186 :: 		}
L_main68:
L_main65:
;multimtre.c,187 :: 		}
	GOTO       L_main4
;multimtre.c,188 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
