// bo'sh portlar qolmadi D6-12 D7-13 D8-15 portlarni RGB ni boshqarish uchun oldim
/*
 * Katta muammo millis() funksiyasini qiymati unsigned long tipida lekin uning qiymati 50 kundan keyin chegaraga yetib 0 ga qaytariladi
 * millis() ni qiymati chegaralangan qiymatdan kichik bo'lib qoladi
 * 
 * Muammo hal bo'ldi _vaqt_ -= vaqt < 0 bo'lganda vaqt ni qiymatini 50 kun ortga qaytardim
 * vaqt oraliqlarini 30-1000 sekund bersam ham muammo chiqmaydi
 */
#include <ESP8266WiFi.h>
#include <WiFiUDP.h>
#include <Wire.h>
//#include <EEPROM.h>
//#include "Adafruit_MCP23017.h"
#include <OneWire.h>
#include <DallasTemperature.h>

 


//Adafruit_MCP23017 mcp;
#define sensor 5   // d5 ga //nfc da 4 d2
#define ONE_WIRE_BUS_1 4    // d4 ga
//#define dinam 0    // d3 ga ulayman
#define benzin_nasos 13 // d7
#define eshiklar 14     //16 d0 ga ulayman //nfc 14 d5
#define qulflash_vaqti 0.1
#define ochish_vaqti 0.1
#define yurgizish_vaqti 0.1
#define uchirish_vaqti 0.1
#define bagaj_vaqti 0.1
#define uzgarish_vaqti 0.1
byte relay[] = {0,  1,  2,  3,  4,  5,  6,  7,  8,  9,  10};
//----------------d2, d3, d4, d5, d6, d7, d8, d9, da, db, dc,
OneWire temp(ONE_WIRE_BUS_1);
DallasTemperature sensor2(&temp);
char* ssid = "cradev_car";// -=-=-=-=--=-=-=-=-=--=-=-=-=-=-=-=-=--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
char* password = "HafhKmIut2O";   //-=-=--=-=-=-=-=--=-=-=--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// relay[8]
// relay[9]
String ip;
unsigned long n, t1, t2;
boolean berkildi, sirena, _sensor_, _voice_, _active_, _lock_, _door_, _avto_, _aqo_, signalizatsiya_yoniq, benzin, lyuk, fara, _avtooff_,avtoFara;
boolean birinchi_bosilmagan, ikkinchi_bosilmagan, uchinchi_bosilmagan, turtinchi_bosilmagan, rang_uzgardi, yonoyna, almashdi;
float t;
int light;
byte counter;
byte yy;
String parol;
//int red=1020, green=1020, blue=1020;
//-----------------------------------------------
/**
 * Avtomatlashtirilgan qismni uchun foydalanayotgan o'zgaruvchilarim
 * algaritm avto qulflash bilan avto o'chishdaqa bo'lmaydi etiborli bo'lishim kerak
 */
unsigned long VaqtdaUchirish, VaqtdaYurgizish;
//-----------------------------------------------
char data[200] ={};
int packetsize = 0;
WiFiUDP Server;
unsigned int vaqt,vaqt2, _vaqt_;
void tempniol();
void yurgizilsin();
void uchirilsin();
void lock();
void unlock();
void sendip();
//void NFC();

void lighting(float _t_){
  Serial.println("81");
  //mcp.digitalWrite(relay[6], HIGH);
  delay(_t_*100);
  Serial.println("80");
  //mcp.digitalWrite(relay[6], LOW);
  delay(200);
}
void music(float t_){
    Serial.println("41");
    delay(100);
    Serial.println("40");
    delay(200);
}
void _send_(){
      Server.beginPacket("192.168.43.1",12000);
      String text = "("+String(_sensor_)+String(_voice_)+String(_active_)+String(_lock_)+String(t1)+String(t2)+String(_door_)+String(_avto_)+String(_aqo_)+String(benzin)+/******************/String(lyuk)+String(fara)+String(_avtooff_)+String(avtoFara)+String(yonoyna);
      //Serial.println(text);
      char bufer[15]={};
      for(byte i=0;i<16;i++){
        bufer[i]=text[i];
      }
      Server.write(bufer);
      Server.endPacket();
}

void setup(){
  //char ssid[10], password[10];
  delay(3000);
  Serial.begin(9600);
  
  
  parol="&CradevCar-"; //-=-=-=-=--=-=-=-=-=-=--=-=-=-=-=--=-=-=-=-=-=-=-=-=--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
  sensor2.begin();
  pinMode(sensor, INPUT);
  pinMode(benzin_nasos, INPUT);
  pinMode(eshiklar, INPUT);
  
  //pinMode(12, OUTPUT); ----- bo'sh
  //pinMode(13, OUTPUT); ----- bo'sh
  //pinMode(15, OUTPUT); ----- bo'sh
  
  //mcp.begin();
  /*for(byte i = 0; i < 11; i++){
    mcp.pinMode(relay[i], OUTPUT);
    mcp.digitalWrite(relay[i], LOW);
  }*/
  WiFi.begin(ssid, password);
  /*while (WiFi.status() != WL_CONNECTED) {
    delay(500);
  }*/
  //Serial.print("IP address: ");
  //Serial.println(WiFi.localIP());
  Server.begin(12000);
  delay(15000);  
  Serial.println("zz");
  sendip();
  //music(uzgarish_vaqti);
  //lighting(3);
  //lighting(3);
  //lighting(3);
}
void loop(){

    if(!digitalRead(benzin_nasos) && !almashdi){
      benzin = true;
      tempniol();
      almashdi = true;
    }else if(digitalRead(benzin_nasos) && almashdi){
      benzin = false;
      
      if(avtoFara){
        Serial.println("c0");
        fara = false;
      }
      almashdi = false;
      tempniol();
    }
    //00000000000000000000000000
    
    delay(100);
    counter++;
    if(counter%10 == 0){
      light = analogRead(A0);
    }
    //Serial.println(counter);
    if(avtoFara && benzin){
      if(light < 30  && !fara){
        fara = true;
        Serial.println("c1");
        //mcp.digitalWrite(relay[10], HIGH);
        tempniol();
      }else if(light >= 40 && fara){
        fara = false;
        Serial.println("c0");
        //mcp.digitalWrite(relay[10], LOW);
        tempniol();  
      }
    }
    /*
    if(soya && rang_uzgardi){
      analogWrite(12, red);
      analogWrite(13, green);
      analogWrite(15, blue);
      rang_uzgardi=false;
    }*/
    // eshikdan keladigan signal
    if(digitalRead(eshiklar)){
       _door_ = true;
    }else{
       _door_ = false;
    }
    // berkildi eshik ochiqmi yopiqmi oradagi mantiq uchun pastdagi shart bajarilishi bilan vaqt hisoblashni boshlanadi _aqo_ uchun          !!! Gangib qolyapman :(!!!
    if(_door_ && !berkildi){
      berkildi = true;
      vaqt = (unsigned int)millis()/1000;
    }
    if(!_door_ && berkildi){
      berkildi = false;
    }
    _vaqt_ = (unsigned int)millis()/1000;
    //Serial.println(_vaqt_);
    
    if(_door_ && !_lock_ && !_active_ && _aqo_){
      
      /** 
       * _vaqt_ ni 0 ga qaytganda bo'ladigan jarayon 
       * _vaqt_ = 1 bo'lganda vaqt = 4294967295 shu qiymat atrofida bo'ladi
       * demak _vaqt_ - vaqt = -4294967294 shunga teng bo'ladi 
       * keyingi else shartiga o'tilib vaqt = 1 ga tenglashtiriladi
       * 
       * Jarayonda muammo chiqmaydi shart tog'ri berilgan lekin eshiklar avtomatik qulflanishi uchun minutlar emas 50 kun kerak bo'ladi :)
       * 
       */
      if((t1 + 2)*2*60 <= _vaqt_ - vaqt){
         vaqt = _vaqt_;
         lock();
         tempniol();
      }
      // Eng katta muammo shu qism orqali bartaraf etiladi. chegara vaqtni 50 kun ortga qaytaramiz
      if(_vaqt_ - vaqt < 0){
        vaqt = _vaqt_;
      }
    }else{
      vaqt = _vaqt_;
    }
    if(_active_ && _avtooff_){
      if((t2+2)*2*60 <= _vaqt_ - vaqt2){
        vaqt2 = _vaqt_;
        if(_voice_) music(uchirish_vaqti);
        uchirilsin();
        tempniol();
      }
      if(_vaqt_ - vaqt2 < 0){
        vaqt2 = _vaqt_;
      }
    }else{
      vaqt2 = _vaqt_;
    }
    // _avto_ avtomatik wifi o'chgandadi mantiqiy o'zgaruvchi
    if(WiFi.status() == 1 && _avto_ && _door_ && !signalizatsiya_yoniq){
      signalizatsiya_yoniq = true;
      lock();
      tempniol();
    }
    if(_lock_){
      if(_sensor_ && !digitalRead(sensor) || !_door_){
         sirena = true;
         Serial.println("ogohlik");
      }
    }
    if(sirena){
      Server.beginPacket("192.168.43.1",12000);
      Server.write("sirena");
      Server.endPacket();
      Serial.println("41");
      //mcp.digitalWrite(relay[2], HIGH);
      tempniol();
      lighting(10);
      if(_door_){
        yy++;
        if(yy==10){
          Serial.println("40");
          //mcp.digitalWrite(relay[2], LOW);
          yy=0;
          sirena=false;
        }
      }
    }
    char message = Server.parsePacket();
    packetsize = Server.available();
    if(message){
     Server.read(data,packetsize);
     //delay(100);
     
     String command="";
     for(byte i = 0; data[i];i++){
      if(data[i]=='*') break;
      //Serial.println(String(int(data[i]))+"->"+data[i]);
      command+=data[i];
     }
     //Serial.println(command);

     
     //Serial.println(command.length());
     
     if(command == "/signalni_yoq"){
        //----------- signalni yoqish
        Serial.println("91");
        //mcp.digitalWrite(relay[7], HIGH);
     }else if(command == "/signalni_uchir"){
        //----------- signalni uchirish
        Serial.println("90");
        //mcp.digitalWrite(relay[7], LOW);
     }else if(command == "/petrolon"){
      if(!benzin){
        benzin = true;
        Serial.println("71");
        //mcp.digitalWrite(relay[5], HIGH);
        tempniol();
      }
     }else if(command == "/petroloff"){
      if(benzin){
        _active_ = false;
        benzin = false;
        Serial.println("70");
        //mcp.digitalWrite(relay[5], LOW);
        tempniol();
      }
     }else if(command == "/lyukon"){
      if(!lyuk){
        lyuk = true;
        Serial.println("a1");
        //mcp.digitalWrite(relay[8], HIGH);
        delay(100);
        Serial.println("a0");
        //mcp.digitalWrite(relay[8], LOW);
        
        tempniol();
      }
     }else if(command == "/lyukoff"){
      if(lyuk){
        lyuk = false;
        Serial.println("a1");
        //mcp.digitalWrite(relay[8], HIGH);
        delay(100);
        Serial.println("a0");
        //mcp.digitalWrite(relay[8], LOW);
        tempniol();
      }
     }else if(command == "/avtooffon"){
      if(!_avtooff_){
        _avtooff_=true;
        tempniol();
      }
     }else if(command == "/avtooffoff"){
      if(_avtooff_){
        _avtooff_=false;
        tempniol();
      }
     }else if(command == "/yonoynaon"){
      if(!yonoyna){
        yonoyna = true;
        //mcp.digitalWrite(relay[9], HIGH);
        Serial.println("b1");
        delay(100);
        Serial.println("b0");
        //mcp.digitalWrite(relay[9], LOW);
        tempniol();
      }
     }else if(command == "/yonoynaoff"){
      if(yonoyna){
        yonoyna = false;
        //mcp.digitalWrite(relay[9], HIGH);
        Serial.println("b1");
        delay(100);
        Serial.println("b0");
           //mcp.digitalWrite(relay[9], LOW);
        tempniol();
      }
     }
     else if(command == "/avtofaraon"){
      avtoFara = true;
      tempniol();
     }else if(command == "/avtofaraoff"){
      avtoFara = false;
      tempniol();
     }else if(command == "/bagaj"){ 
        if(_voice_) music(bagaj_vaqti);
        Serial.println("51");
        //mcp.digitalWrite(relay[3], HIGH);
        delay(200);
        Serial.println("50");
        //mcp.digitalWrite(relay[3], LOW);
        lighting(3);
       //----------- bagajni ochish
     }else if(command == "/sensorni_yoq"){
          if(_voice_) music(bagaj_vaqti);
            lighting(4);
            _sensor_ = true;
            tempniol();
     }else if(command == "/sensorni_uchir"){
          if(_voice_) music(bagaj_vaqti);
          lighting(4);
          _sensor_ = false;
          tempniol();
     }else if(command == "/ovozni_yoq"){
       if(!_voice_){
        _voice_ = true;
        if(_voice_) music(bagaj_vaqti);
        tempniol();
       }
     }else if(command == "/ovozni_uchir"){
       if(_voice_){
        if(_voice_) music(bagaj_vaqti);
        _voice_ = false;
        tempniol();
       }
     }else if(command == "/faraon"){
       if(!fara){
        fara = true;
        
        Serial.println("c1");
        if(_voice_) music(bagaj_vaqti);
        //mcp.digitalWrite(relay[10], HIGH);
        tempniol();
       }
     }else if(command == "/faraoff"){
       if(fara){
        
        Serial.println("c0");
        if(_voice_) music(bagaj_vaqti);
        //mcp.digitalWrite(relay[10], LOW);
        fara = false;
        tempniol();
       }
     }
     //---------- yurgizish bilan o'chirish vaqtga bog'lash------------------
     else if(command == "/yurgiz"){
       if(!_active_){
        if(_voice_) music(yurgizish_vaqti);
        yurgizilsin();
        tempniol();
       }
     }else if(command == "/uchir"){
       if(_active_){
        if(_voice_) music(uchirish_vaqti);
        uchirilsin();
        tempniol();
       }
     }
     else if(command.substring(0,10) == "yurgizish="){
        String text = command.substring(10,command.length());
        if(text.toInt()>=0){
          VaqtdaYurgizish = text.toInt()+millis()/1000;
          //Serial.println("yurgizish vaqti ->"+String(VaqtdaYurgizish));
        }
     }
     else if(command.substring(0,9) == "uchirish="){
        String text = command.substring(9,command.length());
        if(text.toInt()>=0){
          VaqtdaUchirish = text.toInt();
          //Serial.println("o'chirish vaqti ->"+String(VaqtdaUchirish));
        }
     }
     
     else if(command == "/signalizatsiyani_yoq"){
       if(!_lock_){
        if(_door_){
          lock();
          signalizatsiya_yoniq=true;
          delay(500);
          tempniol();
        }else{
          tempniol();
        }
       }
     }else if(command == "/signalizatsiyani_uchir"){
       if(_lock_){
        signalizatsiya_yoniq = false;
        sirena = false;
        // avarenniyni o'chir
        Serial.println("40");
        //mcp.digitalWrite(relay[2], LOW);
        unlock();
        tempniol();
       }         
     }else if(command == "/avtoon"){
       if(_voice_) music(bagaj_vaqti);
       lighting(4);
       _avto_ = true;
     }else if(command == "/avtooff"){
       lighting(4);
       if(_voice_) music(bagaj_vaqti);
       _avto_ = false;
     }else if(command == "/aqoon"){
       _aqo_ = true;
     }else if(command == "/aqooff"){
      _aqo_ = false;
     }
     
     // rangni o'rnatish qismi komandadan ajratib olishda yaxshiroq e'tibor berishim kerak
     /*else if(command.substring(0,4) == "red="){
        String red1 = command.substring(4,command.length());
        if(red1.toInt()>=0){
          red = red1.toInt();
          //analogWrite(12, red);
          rang_uzgardi=true;
        }
     }
     else if(command.substring(0,6) == "green="){
       String green1 = command.substring(6,command.length());
       if(green1.toInt()>=0){
         green = green1.toInt();
         //analogWrite(13, green);
         rang_uzgardi=true;
       }
     }
     else if(command.substring(0,5) == "blue="){
       String blue1 = command.substring(5,command.length());
       if(blue1.toInt()>=0){
         blue = blue1.toInt();
         //analogWrite(15, blue);
         rang_uzgardi=true;
       }
     }*/
     // avto lock bilan avto o'chish vaqtini kritish uchun
     else if(command.substring(0,3) == "/t1"){
        t1 = command[3] - 48;
        vaqt = (unsigned int)millis()/1000;
        //Serial.println(t1);
     }else if(command.substring(0,3) == "/t2"){
        t2 = command[3] - 48;
        vaqt2 = (unsigned int)millis()/1000;
        //Serial.println(t2);
     }else if(command == "/get"){
      tempniol();// /+998901234567
     }else if(command.substring(0,6) == "/+9989"){
      String nomer = command.substring(1, 14);
      Serial.println(nomer);
     }
    }

    // GSM
    if(Serial.available()){
      String text;
      text = Serial.readStringUntil('\n');
      if(text[0] == '&'){
        if(text == parol+"1"){
          if(!_active_){
            if(_voice_) music(yurgizish_vaqti);
            yurgizilsin();
            tempniol();
          } 
        }else if(text == parol+"2"){
          if(_active_){
            if(_voice_) music(uchirish_vaqti);
            uchirilsin();
            tempniol();
          }  
        }else if(text == parol+"3"){
          if(!benzin){
            benzin = true;
            Serial.println("71");
            //mcp.digitalWrite(relay[5], HIGH);
            tempniol();
          }  
        }else if(text == parol+"4"){
          if(benzin){
            _active_ = false;
            benzin = false;
            Serial.println("70");
            //mcp.digitalWrite(relay[5], LOW);
            tempniol();
          }
        }else if(text == parol+"5"){
          if(!_lock_){
            if(_door_){
              lock();
              signalizatsiya_yoniq=true;
              delay(500);
              tempniol();
            }else{
              tempniol();
            }
          }
        }else if(text == parol+"6"){
          if(_lock_){
            signalizatsiya_yoniq = false;
            sirena = false;
            // avarenniyni o'chir
            Serial.println("40");
            //mcp.digitalWrite(relay[2], LOW);
            unlock();
            tempniol();
          }  
        }else if(text == parol+"7"){
          if(!yonoyna){
            yonoyna = true;
            //mcp.digitalWrite(relay[9], HIGH);
            Serial.println("b1");
            delay(100);
            Serial.println("b0");
            //mcp.digitalWrite(relay[9], LOW);
            tempniol();
          }
        }else if(text == parol+"8"){
          if(yonoyna){
            yonoyna = false;
            //mcp.digitalWrite(relay[9], HIGH);
            Serial.println("b1");
            delay(100);
            Serial.println("b0");
           //mcp.digitalWrite(relay[9], LOW);
           tempniol();
          }
        }else if(text == parol+"9"){
          if(!lyuk){
            lyuk = true;
            Serial.println("a1");
            //mcp.digitalWrite(relay[8], HIGH);
            delay(100);
            Serial.println("a0");
            //mcp.digitalWrite(relay[8], LOW);
            tempniol();
          }  
        }else if(text == parol + "10"){
          if(lyuk){
            lyuk = false;
            Serial.println("a1");
            //mcp.digitalWrite(relay[8], HIGH);
            delay(100);
            Serial.println("a0");
            //mcp.digitalWrite(relay[8], LOW);
            tempniol();
          }
        }else if(text == parol+"11"){
          if(!fara){
            fara = true;
            Serial.println("c1");
            if(_voice_) music(bagaj_vaqti);
              //mcp.digitalWrite(relay[10], HIGH);
              tempniol();
          } 
        }else if(text == parol+"12"){
          if(fara){
            Serial.println("c0");
            if(_voice_) music(bagaj_vaqti);
              //mcp.digitalWrite(relay[10], LOW);
              fara = false;
              tempniol();
            }  
        }else if(text == parol+"13"){
            Serial.println("91");
            delay(1000);
            Serial.println("90");
        }else if(text == parol+"14"){
          if(_voice_) music(bagaj_vaqti);
            Serial.println("51");
            //mcp.digitalWrite(relay[3], HIGH);
            delay(200);
            Serial.println("50");
            //mcp.digitalWrite(relay[3], LOW);
            lighting(3);
          }
      }else if(text[0]=='#'){
        char x[text.length()];
        for(byte i=0;i<text.length();i++){
          x[i]=text[i];
        }
        Server.beginPacket("192.168.43.1",12000);
        Server.write(x);
        Server.endPacket();
      }
      else if(text[0]=='!'){
        if(text == "!EshikYopil"){
          if(!_lock_){
            if(_door_){
              lock();
              signalizatsiya_yoniq=true;
              delay(500);
              tempniol();
            }else{
              tempniol();
            }
          }
        }
        else if(text == "!EshikOchil"){
          if(_lock_){
              signalizatsiya_yoniq = false;
              sirena = false;
              // avarenniyni o'chir
              Serial.println("40");
              //mcp.digitalWrite(relay[2], LOW);
              unlock();
              tempniol();
          }
        }
        else if(text == "!Bagaj"){
          if(_voice_) music(bagaj_vaqti);
            Serial.println("51");
            //mcp.digitalWrite(relay[3], HIGH);
            delay(200);
            Serial.println("50");
            //mcp.digitalWrite(relay[3], LOW);
            lighting(3);
        }else if(text == "!Yurgiz"){
          if(!_active_){
            if(_voice_) music(yurgizish_vaqti);
              yurgizilsin();
              tempniol();
          }else{
            if(_voice_) music(uchirish_vaqti);
            uchirilsin();
            tempniol();
          }
        }
      }
      
    }
}
void tempniol(){
  _send_();
  sensor2.requestTemperatures();
  t=sensor2.getTempCByIndex(0);
  String text = String(t);
  char bufer[4]={};
  for(byte i=0;i<4;i++){
    bufer[i]=text[i];
  }
  Server.beginPacket("192.168.43.1",12000);
  Server.write("[");
  Server.write(bufer);
  Server.write("]");
  Server.endPacket();
}
void yurgizilsin(){
  _active_ = true;
  if(!benzin){
    
    benzin = true;
    Serial.println("71");
    //mcp.digitalWrite(relay[5], HIGH);
    delay(2000);
  }
  Serial.println("61");
  //mcp.digitalWrite(relay[4], HIGH);
  lighting(5);
  delay(200);
  Serial.println("60");
  //mcp.digitalWrite(relay[4], LOW);
}
void uchirilsin(){
  _active_ = false;
  lighting(6);
  Serial.println("70");
  //mcp.digitalWrite(relay[5], LOW);
  benzin = false;
  lighting(6);
}
void lock(){
  _lock_ = true;
  
  Serial.println("21");
  //mcp.digitalWrite(relay[0], HIGH);
  if(_voice_) music(qulflash_vaqti);
  else delay(300);
  delay(300);
  Serial.println("20");
  
  //mcp.digitalWrite(relay[0], LOW);
  lighting(3);
  delay(300);
  lighting(3);
  delay(300);
  lighting(3);
}
void unlock(){
  _lock_ = false;
  
  Serial.println("31");
  //mcp.digitalWrite(relay[1], HIGH);
  if(_voice_){ music(ochish_vaqti); music(ochish_vaqti);}
  else delay(600);
  //delay(500);
  Serial.println("30");
  //mcp.digitalWrite(relay[1], LOW);
  lighting(3);
  delay(300);
  lighting(3);
}
void sendip(){
  Server.beginPacket("192.168.43.1",12000);
  Server.write("ip=");
  Server.print(WiFi.localIP());
  Server.write("#");
  Server.endPacket();
}
/*void NFC(){
        if(_lock_){
          //unlock();
          signalizatsiya_yoniq = false;
          sirena = false;
         
          
          Serial.println("40");
          unlock();
          tempniol();
        }
        else if(digitalRead(eshiklar) && !_active_){
          lock();
          signalizatsiya_yoniq=true;
          delay(500);
          tempniol();
        }
}*/
