#line 1 "C:/Users/mohamed/Desktop/qq/mikroc/multimtre.c"
 bit oldstate,oldstate1,oldstate2,ohm_kohm;
 float Rx=0;
 float v0=0,vx=0,db=0;
 char valeur[6];
 const int Rcalibre[] = {100,1000,10000,100,1000};
 const float b=83.2073,a=11.003;

 unsigned int timer=0;
sbit LCD_RS at RD0_bit;
sbit LCD_EN at RD1_bit;
sbit LCD_D4 at RD2_bit;
sbit LCD_D5 at RD3_bit;
sbit LCD_D6 at RD4_bit;
sbit LCD_D7 at RD5_bit;

sbit LCD_RS_Direction at TRISD0_bit;
sbit LCD_EN_Direction at TRISD1_bit;
sbit LCD_D4_Direction at TRISD2_bit;
sbit LCD_D5_Direction at TRISD3_bit;
sbit LCD_D6_Direction at TRISD4_bit;
sbit LCD_D7_Direction at TRISD5_bit;

void configPort()
{
TRISC=0;TRISC.rc3=1;TRISC.rc4=1;TRISC.rc5=1;
}
void InitTimer0(){
 OPTION_REG = 0x88;
 TMR0 = 206;
 INTCON = 0xA0;
}
int calcR(int R,int Rm)
{
v0=ADC_read(0);
vx=ADC_read(1);
Rx=(vx*(Rm+R))/(v0-vx);
return Rx;
}
char printR(float R,int i)
{
FloatToStr_FixLen(R,valeur,i);
return valeur;
}
int milsecond(float pV)
{
portc.rc6=1;delay_ms(500);portc.rc6=0;
vx=ADC_read(1);
timer=0;
while(vx<pV)
 {
 if(TMR0IF_bit)
 {
 TMR0IF_bit=0;
 timer++;
 TMR0=206;
 vx=ADC_read(1);
 }
 }
 return timer ;
}


void main()
{
 InitTimer0();
 configPort();
 ADC_init();
 lcd_init();
 lcd_cmd(_lcd_clear);
 lcd_cmd(_LCD_CURSOR_OFF);
start:while(1)
 {
 lcd_out(1,1,"chose ");
 lcd_out(2,1,"1-R 2-C 3-db");
 Rx=0;
 if (Button(&PORTC, 3, 1, 0))
 {
 oldstate = 1;
 }
 else if (Button(&PORTC, 3, 1, 1)&&(oldstate))
 {
 lcd_cmd(_lcd_clear);
 oldstate = 0;
 while(1)
 {
 if(Rx>=0&&Rx<=100){portc=0b000;lcd_out (1,3,printR(calcR(Rcalibre[0],354),5));ohm_kohm=0; }
 else if(Rx>100&&Rx<=900){portc=0b001;lcd_out (1,3,printR(calcR(Rcalibre[1],360),7));ohm_kohm=0; }
 else if(Rx>900&&Rx<=20000){portc=0b010;lcd_out (1,3,printR(calcR(Rcalibre[2],360),7));ohm_kohm=0; }
 else if(Rx>20000&&Rx<=90000){ portc=0b011;lcd_out (1,3,printR(calcR(Rcalibre[3],1),5));Rx=calcR(100000,1);ohm_kohm=1;}
 if(Rx>90000&&Rx<=300000){ portc=0b100;lcd_out (1,3,printR(calcR(Rcalibre[4],1),5));Rx=calcR(1000000,360);ohm_kohm=1;}
 if(Rx>300000&&Rx<=500000){ portc=0b100;lcd_out (1,3,printR(calcR(Rcalibre[4],8),5));Rx=calcR(1000000,360);ohm_kohm=1;}
 if(Rx>500000&&Rx<=800000){ portc=0b100;lcd_out (1,3,printR(calcR(Rcalibre[4],10),5));Rx=calcR(1000000,360);ohm_kohm=1;}
 if(Rx>800000&&Rx<=1200000){ portc=0b100;lcd_out (1,3,printR(calcR(Rcalibre[4],18),7));Rx=calcR(1000000,360);ohm_kohm=1;}
 if(Rx>1200000){lcd_out(1,3,"Inf   ");ohm_kohm=1;}
 lcd_out(1,1,"R=");
 if(ohm_kohm==0){lcd_out(1,11,"OHM");}else {lcd_out(1,11,"KOHM   ");}
 lcd_out(2,11,"3-back");
 if (Button(&PORTC, 5, 1, 0))
 {
 oldstate1 = 1;
 }
 else if (Button(&PORTC, 5, 1, 1)&&(oldstate1))
 {
 oldstate1 = 0;
 lcd_cmd(_lcd_clear);
 goto start;
 }

 }
 }
 if (Button(&PORTc, 4, 1, 0))
 {
 oldstate1=1;
 }
 else if (Button(&PORTc, 4, 1, 1)&&(oldstate1))
 {
 oldstate1=0;
 lcd_cmd(_lcd_clear);
 lcd_out(1,1,"C=");
 lcd_out(2,11,"3-back");

 while(1)
 {

 Portc=0b001;
 milsecond(648);
 if(timer<=10)
 {
 portc=0b010;
 milsecond(648);
 if(timer<=5)
 {
 portc=0b101 ;
 milsecond(648);
 lcd_out(1,3,printR(milsecond(648)*14.286,5));lcd_out(1,1,"C=");lcd_out(1,8,"  pF");lcd_out(2,11,"3-back");
 }
 else {lcd_out(1,3,printR(milsecond(648)*14.3,5));lcd_out(1,1,"C=");lcd_out(1,8,"  nF");lcd_out(2,11,"3-back"); }
 }
 else {lcd_out(1,3,printR(milsecond(648)*0.1295,5));lcd_out(1,1,"C=");lcd_out(1,8,"  uF");lcd_out(2,11,"3-back"); }


 if (Button(&PORTc, 5, 1, 0))
 {
 oldstate2 = 1;
 }
 else if (Button(&PORTc, 5, 1, 1)&&(oldstate2))
 {
 oldstate2 = 0;
 lcd_cmd(_lcd_clear);
 goto start;
 }
 }
 }
 if (Button(&PORTc, 5, 1, 0))
 {
 oldstate2=1;
 }
 else if(Button(&PORTc, 5, 1, 1)&&(oldstate2))
 {
 oldstate2=0;
 lcd_cmd(_lcd_clear);
 lcd_out(1,1,"db=");
 lcd_out(2,11,"3-back");
 while(1)
 {

 db = (adc_read(2)+b) / a ;
 lcd_out(1,7,printR(db,5));
 lcd_out(1,1,"sound=");lcd_out(1,12,"db");



 if (Button(&PORTc, 5, 1, 0))
 {
 oldstate = 1;
 }
 else if (Button(&PORTc, 5, 1, 1)&&(oldstate))
 {
 oldstate = 0;
 lcd_cmd(_lcd_clear);
 goto start;
 }
 }


 }
 }
}
