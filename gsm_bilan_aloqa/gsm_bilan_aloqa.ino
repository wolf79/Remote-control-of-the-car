#include <SoftwareSerial.h>
SoftwareSerial gsm(10,11);
String text;
boolean isMessage;
void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  gsm.begin(9600);
  gsm.print("AT+CMGF=1\r");
  delay(500);
  gsm.readString();
  gsm.print("AT+IFC=1, 1\r");
  delay(500);
  gsm.readString();
  gsm.print("AT+CPBS=\"SM\"\r");
  delay(500);
  gsm.readString();
  gsm.print("AT+CNMI=1,2,2,1,0\r");
  delay(700);
  gsm.readString();
  pinMode(13, OUTPUT);
}

void loop() {
  // put your main code here, to run repeatedly:
  if(Serial.available()){
    gsm.write(Serial.read());
  }
  if(!gsm.available()) return;
  char simvol = gsm.read();
  if(simvol=='\r'){
    isMessage = true;
    //Serial.print(text);
    //Serial.println("|"+text.substring(1,5)+"|");
    //Serial.println(text.substring(1,5)=="+CMT");
    if(text.substring(1,5)=="+CMT"){ 
      //Serial.println(text.substring(1,12)=="+CMT: \"+998");
      if(text.substring(1,12)=="+CMT: \"+998"){
        while(!gsm.available());
        text=gsm.readStringUntil('\r');
        text=text.substring(1,text.length());
        //Serial.println("#"+String(text[0])+"|"+String(text[1])+"|"+String(text[2])+"|"+String(text[3])+"#");
        if(text[0]=='&'){
          //if(text == "&command=1") digitalWrite(13, LOW);
          //else if(text == "&command=2") digitalWrite(13, HIGH);
          Serial.println(text);
        }  
      }
      gsm.print("AT+CMGD=1\r");
      delay(500);
      gsm.readString();
    }
    if(text.substring(1,5)=="RING"){
      gsm.print("ATH\r");
      delay(500);
      gsm.readString();
      /*for(byte i=1;i<=90;i++){
        delay(1000);
        Serial.println(i);
      }
      Serial.readString();
      gsm.print("AT+CMGF=1\r");
      delay(500);
      Serial.print(gsm.readString());
      gsm.print("AT+IFC=1, 1\r");
      delay(500);
      Serial.print(gsm.readString());
      gsm.print("AT+CPBS=\"SM\"\r");
      delay(500);
      Serial.print(gsm.readString());
      gsm.print("AT+CNMI=1,2,2,1,0\r");
      delay(700);
      Serial.print(gsm.readString());*/
    }
    text="";
  }else{
    //isMessage=false;
    text+=simvol;
  }
  
  /*while(1){
    gsm.print("at+cbc");
    delay(100);
    while(!gsm.available());
    Serial.println(gsm.readString());  
  }*/
}
