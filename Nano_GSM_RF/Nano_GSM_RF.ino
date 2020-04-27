#include <SoftwareSerial.h>
#include <EEPROM.h>
SoftwareSerial gsm(10,11);
byte tozalash_uchun;
boolean bosildi1, bosildi2, bosildi3, bosildi4;
String text;
struct nomerlar{
  char nomer[13]; // +998916719303
};
nomerlar nomer;
String sms;
boolean isMessage; // packet arrived
void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  
  for(byte i=2;i<=9;i++){
    pinMode(i, OUTPUT);
  }
  pinMode(12, OUTPUT);
  for(byte i=14;i<=15;i++){
    pinMode(i, OUTPUT);
  }
  /*for(byte i=18;i<=19;i++){
    pinMode(i, OUTPUT);
    pinMode(i-6, OUTPUT);
  }
  // 14 15 16 17
  for(byte i=14;i<=17;i++){
    pinMode(i, INPUT);
  }*/

  // gsm module communication
  //delay(5000);
  EEPROM.get(0, nomer);
  
  sms = "AT+CMGS=\""+String(nomer.nomer)+"\"\r";
  //Serial.println(sms);
  //delay(5000);
  gsm.begin(9600);
  delay(1000);
  gsm.print("AT+CMGF=1");
  delay(1000);
  tozala();
  //Serial.println("("+gsm.readString()+")");
  //gsm.print("AT+IFC=1, 1\r");
  //delay(500);
  //Serial.println(text);
  //while(gsm.available());
  //text = gsm.readString();
  //gsm.print("AT+CPBS=\"SM\"\r");
  //delay(500);
  //Serial.println("%"+text+"%");
  //text = gsm.readString();
  gsm.print("AT+CNMI=2,2,0,0,0\r");
  delay(700);
  tozala();
  
  //Serial.println(gsm.readString());
  //Serial.println(text);
}

void loop() {
  // put your main code here, to run repeatedly:
  if(Serial.available()){
    String kod = Serial.readStringUntil('\n');
    if(kod[0] == '2'){
      if(kod[1] == '1'){
        digitalWrite(12, HIGH); 
      }else{
        digitalWrite(12, LOW);
      }
    }else if(kod[0] == '3'){
      if(kod[1] == '1'){
        digitalWrite(14, HIGH); 
      }else{
        digitalWrite(14, LOW);
      }
    }else if(kod[0] == '4'){
      if(kod[1] == '1'){
        digitalWrite(6, HIGH); 
      }else{
        digitalWrite(6, LOW);
      }
    }else if(kod[0] == '5'){
      if(kod[1] == '1'){
        digitalWrite(9, HIGH); 
      }else{
        digitalWrite(9, LOW);
      }
    }else if(kod[0] == '6'){
      if(kod[1] == '1'){
        digitalWrite(8, HIGH); 
      }else{
        digitalWrite(8, LOW);
      }
    }else if(kod[0] == '7'){
      if(kod[1] == '1'){
        digitalWrite(7, HIGH); 
      }else{
        digitalWrite(7, LOW);
      }
    }else if(kod[0] == '8'){
      if(kod[1] == '1'){
        digitalWrite(15, HIGH); 
      }else{
        digitalWrite(15, LOW);
      }
    }else if(kod[0] == '9'){
      if(kod[1] == '1'){
        digitalWrite(5, HIGH); 
      }else{
        digitalWrite(5, LOW);
      }
    }else if(kod[0] == 'a'){
      if(kod[1] == '1'){
        digitalWrite(2, HIGH); 
      }else{
        digitalWrite(2, LOW);
      }
    }else if(kod[0] == 'b'){
      if(kod[1] == '1'){
        digitalWrite(3, HIGH); 
      }else{
        digitalWrite(3, LOW);
      }
    }else if(kod[0] == 'c'){
      if(kod[1] == '1'){
        digitalWrite(4, HIGH); 
      }else{
        digitalWrite(4, LOW);
      }
    }else if(kod[0] == 'z'){
      if(kod[1] == 'z'){
        for(byte i=2;i<=12;i++){
          digitalWrite(i, LOW);
          //pinMode(i, OUTPUT);
        }
        for(byte i=14;i<=15;i++){
          digitalWrite(i, LOW);
          //pinMode(i, OUTPUT);
        }
        
        delay(1000);
        
        gsm.print("AT+CMGF=1\r");
        delay(500);
        tozala();
        //Serial.println(gsm.readString());
        gsm.print("AT+CNMI=2,2,0,0,0\r");
        delay(700);
        tozala();
        //Serial.println(gsm.readString());        
      }
    }else if(kod[0] == '+'){
      for(byte i=0;i<13;i++){
        nomer.nomer[i] = kod[i];  
      }
      EEPROM.put(0, nomer);
    }else if(kod == "ogohlik"){
      ogohlantirish();
    }
  }
  // gsm spaces

  // pult uchun ajratilgan qism
  /*if((digitalRead(A0) || digitalRead(A1) || digitalRead(A2) || digitalRead(A3))){
    delay(50);
    if(digitalRead(A0) && digitalRead(A1) && digitalRead(A2) && digitalRead(A3) && !bosildi1){
      //Serial.print("Bagaj\n");
      //delay(100);
      byte n=0;   
      while(digitalRead(A0) && digitalRead(A1) && digitalRead(A2) && digitalRead(A3)){
        n++;
        delay(100);
      }
      if(n>=20){
        Serial.print("!Bagaj\n");
        bosildi1 = true;
      }
      bosildi1 = true;
    }else if(digitalRead(A0) && digitalRead(A1) && !digitalRead(A2) && !digitalRead(A3) && !bosildi2){
      Serial.print("!EshikOchil\n");
      //delay(1000);
      bosildi2 = true;
    }else if(digitalRead(A2) && digitalRead(A3) && !digitalRead(A0) && !digitalRead(A1) && !bosildi3){
      //Serial.print("!Yurgiz\n");
      //delay(1000);
      byte k=0;
      while(digitalRead(A2) && digitalRead(A3) && !digitalRead(A0) && !digitalRead(A1)){
        k++;
        delay(100);
      }
      if(k>=20){
        bosildi3 = true; 
        Serial.print("!Yurgiz\n"); 
      }
    }else if(digitalRead(A0) && !digitalRead(A1) && !digitalRead(A2) && !digitalRead(A3) && !bosildi4){
      Serial.print("!EshikYopil\n");
      //delay(1000);
      bosildi4 = true;
    }
  }else{
    bosildi1 = false;
    bosildi2 = false;
    bosildi3 = false;
    bosildi4 = false;
  }*/

  /*
  else if(digitalRead(A0) && digitalRead(A1) && !bosildi2){
    bosildi2=true;
    Serial.print("!EshikOchil\n");
    delay(1000);
  }else if(!digitalRead(A0) && !digitalRead(A1) && bosildi2){
    bosildi2=false;
  }else if(digitalRead(A0) && !bosildi1){
    bosildi1=true;
    Serial.print("!EshikYopil\n");
    delay(1000);
  }else if(!digitalRead(A0) && bosildi1){
    bosildi1=false;
  }
  
  

  if(digitalRead(17) && !bosildi3){
    bosildi3=true;
    Serial.print("!Yonoyna\n");
  }else if(!digitalRead(17) && bosildi3){
    bosildi3=false;
  }

  if(digitalRead(15) && !bosildi4){
    bosildi4=true;
    Serial.print("!Yurgizish\n");
  }else if(!digitalRead(15) && bosildi4){
    bosildi4=false;
  } 
  */
  
  if(!gsm.available()) return;
  char simvol = gsm.read();
  if(simvol=='\r'){
    isMessage = true;
    if(text.substring(1,5)=="+CMT"){ 
      //Serial.println(text);
      if(text.substring(1,12)=="+CMT: \"+998"){
        while(!gsm.available());
        text=gsm.readStringUntil('\r');
        text=text.substring(1,text.length());
        //Serial.println("#"+String(text[0])+"|"+String(text[1])+"|"+String(text[2])+"|"+String(text[3])+"#");
        if(text[0]=='&'){
          //if(text == "&command=1") digitalWrite(13, LOW);
          //else if(text == "&command=2") digitalWrite(13, HIGH);
          Serial.print(text+'\n');
        }else{
          text=text.substring(1,text.length());
          Serial.print('#'+text+'\n');
        } 
      }
      gsm.print("AT+CMGD=1\r");
      delay(500);
      tozala();
      //text = gsm.readString();
      //Serial.println(text);
    }
    //--------------------------------------- Shu qismda ATH bajarilmadi ---------------------- bo'lishi mumkin Ring ni ajratislishi Sim800L dagi bilan mos tushmadi --------
    if(text.substring(1,5)=="RING"){
      gsm.print("ATH\r");
      delay(500);
      tozala();
      //text = gsm.readString(); // or gsm.flush();
      //Serial.println(text);
    }
    text="";
  }else{
    text+=simvol;
  }
}

void tozala(){
  while(gsm.available()){
    tozalash_uchun = gsm.read();
  }
}
void ogohlantirish(){
      tozala();
      gsm.write("AT+CMGF=1\r");
      delay(500);
      tozala();
      //Serial.println(gsm.readString());
      gsm.println(sms);
      delay(500);
      //Serial.println(gsm.readString());
      tozala();
      gsm.print("Mashinaga kimdir yaqinlashgan bo'lishi mumkin!\r");
      delay(500);
      gsm.write(26);
      delay(5000);
      tozala();
      //Serial.println(gsm.readString());
}
