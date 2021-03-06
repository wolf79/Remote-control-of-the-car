unit Unit1;


interface

uses
  System.ioutils, System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Maps,
  FMX.StdCtrls, FMX.Effects, FMX.Objects, FMX.Controls.Presentation, FMX.Layouts,
  FMX.ScrollBox, FMX.Memo, IdUDPServer, IdBaseComponent, IdComponent, IdUDPBase,
  IdUDPClient, FMX.MultiView, FMX.WebBrowser, IdGlobal, IdSocketHandle,
  System.Permissions, Androidapi.Jni.Os, Androidapi.Helpers,
  FMX.TabControl, FMX.Edit, FMX.Colors, FMX.ListBox,


  FMX.Helpers.Android, Androidapi.JNI.GraphicsContentViewText, Androidapi.JNI.Net, Androidapi.JNI.JavaTypes, Androidapi.JNI.Telephony,

  System.Actions, FMX.ActnList


  {$IFDEF ANDROID}
  //,Androidapi.JNI.Os,
  //,Androidapi.JNI.GraphicsContentViewText,
  //Androidapi.Helpers,
  ,Androidapi.JNIBridge
{$ENDIF}
{$IFDEF IOS}
  ,IOSapi.MediaPlayer,
  IOSapi.CoreGraphics,
  FMX.Platform,
  FMX.Platform.IOS,
  IOSapi.UIKit,
  Macapi.ObjCRuntime,
  Macapi.ObjectiveC,
  iOSapi.Cocoatypes,
  Macapi.CoreFoundation,
  iOSapi.Foundation,
  iOSapi.CoreImage,
  iOSapi.QuartzCore,
  iOSapi.CoreData
{$ENDIF}
  ;

{$IFDEF IOS}
Const
  libAudioToolbox        = '/System/Library/Frameworks/AudioToolbox.framework/AudioToolbox';
  kSystemSoundID_vibrate = $FFF;

Procedure AudioServicesPlaySystemSound( inSystemSoundID: integer ); Cdecl; External libAudioToolbox Name _PU + 'AudioServicesPlaySystemSound';
{$ENDIF}


type
  TForm1 = class(TForm)
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    TabItem3: TTabItem;
    Image1: TImage;
    Rectangle1: TRectangle;
    Button2: TButton;
    ShadowEffect3: TShadowEffect;
    Rectangle2: TRectangle;
    Button3: TButton;
    ShadowEffect1: TShadowEffect;
    Label1: TLabel;
    ShadowEffect4: TShadowEffect;
    VertScrollBox1: TVertScrollBox;
    RoundRect2: TRoundRect;
    Image5: TImage;
    ShadowEffect6: TShadowEffect;
    Image6: TImage;
    Image7: TImage;
    Label3: TLabel;
    RoundRect3: TRoundRect;
    Image8: TImage;
    ShadowEffect7: TShadowEffect;
    Image9: TImage;
    Image10: TImage;
    Label4: TLabel;
    RoundRect4: TRoundRect;
    Image11: TImage;
    ShadowEffect8: TShadowEffect;
    Image12: TImage;
    Image13: TImage;
    Label5: TLabel;
    RoundRect5: TRoundRect;
    Image14: TImage;
    ShadowEffect9: TShadowEffect;
    Image15: TImage;
    Image16: TImage;
    Label6: TLabel;
    RoundRect6: TRoundRect;
    Image17: TImage;
    ShadowEffect10: TShadowEffect;
    Image18: TImage;
    Image19: TImage;
    Label7: TLabel;
    RoundRect7: TRoundRect;
    Image20: TImage;
    ShadowEffect11: TShadowEffect;
    Image21: TImage;
    Label8: TLabel;
    RoundRect1: TRoundRect;
    Image2: TImage;
    ShadowEffect5: TShadowEffect;
    Image3: TImage;
    Image4: TImage;
    Label2: TLabel;
    RoundRect8: TRoundRect;
    Image23: TImage;
    Image24: TImage;
    Image25: TImage;
    Label9: TLabel;
    RoundRect9: TRoundRect;
    Image26: TImage;
    Image27: TImage;
    Image28: TImage;
    Label10: TLabel;
    RoundRect10: TRoundRect;
    Image29: TImage;
    Image30: TImage;
    Image31: TImage;
    Label11: TLabel;
    Timer1: TTimer;
    Memo1: TMemo;
    IdUDPClient1: TIdUDPClient;
    IdUDPServer1: TIdUDPServer;
    Rectangle13: TRectangle;
    Label16: TLabel;
    Button6: TButton;
    VertScrollBox2: TVertScrollBox;
    RoundRect11: TRoundRect;
    Image44: TImage;
    Label17: TLabel;
    RoundRect12: TRoundRect;
    Image45: TImage;
    Label18: TLabel;
    RoundRect13: TRoundRect;
    Image46: TImage;
    Label19: TLabel;
    RoundRect14: TRoundRect;
    Image47: TImage;
    Label20: TLabel;
    RoundRect15: TRoundRect;
    Image48: TImage;
    Label21: TLabel;
    RoundRect16: TRoundRect;
    Image49: TImage;
    Label22: TLabel;
    RoundRect17: TRoundRect;
    Image50: TImage;
    Label23: TLabel;
    Panel1: TPanel;
    ShadowEffect19: TShadowEffect;
    ToolBar1: TToolBar;
    ShadowEffect20: TShadowEffect;
    Label24: TLabel;
    Button7: TButton;
    Label25: TLabel;
    Edit1: TEdit;
    Rectangle14: TRectangle;
    Button8: TButton;
    ShadowEffect21: TShadowEffect;
    VertScrollBox3: TVertScrollBox;
    Rectangle8: TRectangle;
    Button4: TButton;
    ShadowEffect12: TShadowEffect;
    ShadowEffect13: TShadowEffect;
    ShadowEffect14: TShadowEffect;
    ShadowEffect15: TShadowEffect;
    ShadowEffect16: TShadowEffect;
    ShadowEffect17: TShadowEffect;
    ShadowEffect18: TShadowEffect;
    Rectangle10: TRectangle;
    Rectangle11: TRectangle;
    Label26: TLabel;
    Edit3: TEdit;
    Image41: TImage;
    Rectangle12: TRectangle;
    Label15: TLabel;
    Edit2: TEdit;
    Image42: TImage;
    Button1: TButton;
    Memo2: TMemo;
    SpeedButton1: TSpeedButton;
    Rectangle4: TRectangle;
    Image32: TImage;
    Image33: TImage;
    Image34: TImage;
    Rectangle5: TRectangle;
    Label12: TLabel;
    ComboBox2: TComboBox;
    Rectangle6: TRectangle;
    Image35: TImage;
    Image36: TImage;
    Image37: TImage;
    Rectangle7: TRectangle;
    Label13: TLabel;
    ComboBox1: TComboBox;
    Switch1: TSwitch;
    Label27: TLabel;
    ShadowEffect2: TShadowEffect;
    Button5: TButton;
    Button9: TButton;
    Button10: TButton;
    Button11: TButton;
    Button12: TButton;
    Button13: TButton;
    Button14: TButton;
    Button15: TButton;
    Button16: TButton;
    Button17: TButton;
    Button18: TButton;
    Button19: TButton;
    Button20: TButton;
    Button21: TButton;
    Rectangle15: TRectangle;
    Rectangle16: TRectangle;
    Edit4: TEdit;
    Label28: TLabel;
    Image22: TImage;
    Button22: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure Image6Click(Sender: TObject);
    procedure Image7Click(Sender: TObject);
    procedure Image9Click(Sender: TObject);
    procedure Image10Click(Sender: TObject);
    procedure Image12Click(Sender: TObject);
    procedure Image13Click(Sender: TObject);
    procedure Image15Click(Sender: TObject);
    procedure Image16Click(Sender: TObject);
    procedure Image18Click(Sender: TObject);
    procedure Image19Click(Sender: TObject);
    procedure Image21Click(Sender: TObject);
    procedure IdUDPServer1UDPRead(AThread: TIdUDPListenerThread;
      const AData: TIdBytes; ABinding: TIdSocketHandle);
    procedure Image2Click(Sender: TObject);
    procedure Image5Click(Sender: TObject);
    procedure Image8Click(Sender: TObject);
    procedure Image11Click(Sender: TObject);
    procedure Image14Click(Sender: TObject);
    procedure Image17Click(Sender: TObject);
    procedure Image20Click(Sender: TObject);
    procedure Image23Click(Sender: TObject);
    procedure Image26Click(Sender: TObject);
    procedure Image29Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Image24Click(Sender: TObject);
    procedure Image27Click(Sender: TObject);
    procedure Image30Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Image25Click(Sender: TObject);
    procedure Switch1Click(Sender: TObject);
    procedure vibration(millis:integer);
    procedure Button1Click(Sender: TObject);
    procedure Image21MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure Image21MouseLeave(Sender: TObject);
    procedure Image28Click(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Switch1Switch(Sender: TObject);
    procedure Image31Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Image33Click(Sender: TObject);
    procedure Image34Click(Sender: TObject);
    procedure Image36Click(Sender: TObject);
    procedure Image37Click(Sender: TObject);
    procedure SendSMS(text: String);
    procedure Button5Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure Button16Click(Sender: TObject);
    procedure Button17Click(Sender: TObject);
    procedure Button18Click(Sender: TObject);
    procedure Button19Click(Sender: TObject);
    procedure Button20Click(Sender: TObject);
    procedure Button21Click(Sender: TObject);
    procedure Button22Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;



implementation

{$R *.fmx}

{$R *.iPhone4in.fmx IOS}
{$R *.SmXhdpiPh.fmx ANDROID}
{$R *.LgXhdpiTb.fmx ANDROID}
procedure TForm1.vibration(millis: Integer);
var
  Vibrator:JVibrator;
begin
  Vibrator:=TJVibrator.Wrap((SharedActivityContext.getSystemService(TJContext.JavaClass.VIBRATOR_SERVICE) as ILocalObject).GetObjectID);
  Vibrator.vibrate(millis);

end;

procedure TForm1.SendSMS(text: string);
  var
    smsManager: JSmsManager; smsTo: JString;
begin
  smsManager:= TJSmsManager.JavaClass.getDefault;

  smsTo:= StringToJString(Edit3.Text);
  smsManager.sendTextMessage(smsTo, nil, StringToJString('&'+Edit2.Text+'-'+text), nil, nil);
  vibration(200);
end;
procedure TForm1.Button10Click(Sender: TObject);
begin
  SendSMS('3');
end;

procedure TForm1.Button11Click(Sender: TObject);
begin
  SendSMS('4');
end;

procedure TForm1.Button12Click(Sender: TObject);
begin
  SendSMS('5');
end;

procedure TForm1.Button13Click(Sender: TObject);
begin
  SendSMS('6');
end;

procedure TForm1.Button14Click(Sender: TObject);
begin
  SendSMS('7');
end;

procedure TForm1.Button15Click(Sender: TObject);
begin
  SendSMS('8');
end;

procedure TForm1.Button16Click(Sender: TObject);
begin
  SendSMS('9');
end;

procedure TForm1.Button17Click(Sender: TObject);
begin
  SendSMS('10');
end;

procedure TForm1.Button18Click(Sender: TObject);
begin
  SendSMS('11');
end;

procedure TForm1.Button19Click(Sender: TObject);
begin
  SendSMS('12');
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Memo2.Visible:=not Memo2.Visible;
  VertScrollBox2.Visible:=not VertScrollBox2.Visible;
  vibration(100);
end;

procedure TForm1.Button20Click(Sender: TObject);
begin
  SendSMS('13');
end;

procedure TForm1.Button21Click(Sender: TObject);
begin
  SendSMS('14');
end;

procedure TForm1.Button22Click(Sender: TObject);
begin
  IdUDPClient1.Send('/'+Edit4.Text+'*');
  vibration(1000);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  ShowMessage('Hardware and Software Developer: Axliyor Sotvoldiyev')
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
// bagaj

  IdUDPClient1.Send('/bagaj*');
  vibration(200);
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  Memo1.Lines.Strings[2]:=Edit3.Text;
  Memo1.Lines.SaveToFile('/sdcard/Android/data/com.embarcadero.CradevCar/files/data.txt');
  IdUDPClient1.Send('/t2'+IntToStr(ComboBox1.ItemIndex));
  IdUDPClient1.Send('/t1'+IntToStr(ComboBox2.ItemIndex));
  
  if Image34.Visible then
    begin
      IdUDPClient1.Send('/aqoon*');
    end
  else
    begin
      IdUDPClient1.Send('/aqooff*');
    end;
  if Image37.Visible then
    begin
      IdUDPClient1.Send('/avtooffon*');
    end
  else
    begin
      IdUDPClient1.Send('/avtooffoff*');
    end;



  vibration(500);

end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  SendSMS('1');
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
   ShowMessage('Ma`lumot berish ...');
end;

procedure TForm1.Button9Click(Sender: TObject);
begin
  SendSMS('2');
end;

procedure TForm1.FormCreate(Sender: TObject);
begin



  //ShowMessage((DateToStr(Date()).Substring(3, 2).ToInteger() > 5).ToString());


  Image1.Height:=Form1.Height/3;



  //if FileExists('/sdcard/Android/data/com.embarcadero.CradevCar/files/data.txt') then
    //ShowMessage('File exists: '+'/sdcard/Android/data/com.embarcadero.CradevCar/files/data.txt')
  //else
  //  ShowMessage('File not exists');
  Memo1.Lines.LoadFromFile('/sdcard/Android/data/com.embarcadero.CradevCar/files/data.txt');
  Memo2.Lines.LoadFromFile('/sdcard/Android/data/com.embarcadero.CradevCar/files/text.txt');


  IdUDPClient1.Host := Memo1.Lines.Strings[0];
  IdUDPClient1.Active := true;
  IdUDPServer1.Active := true;
  IdUDPClient1.Connect();
  Edit3.Text := Memo1.Lines.Strings[2];
  //ShowMessage(IdUDPClient1.Host);

end;

procedure TForm1.Image30Click(Sender: TObject);
begin
  // ogohlantirish tel yoq --------------------------------------------------
  Image30.Visible:=false;
  Image31.Visible:=true;
  Memo1.Lines.Strings[1]:='1';
  Memo1.Lines.SaveToFile('/sdcard/Android/data/com.embarcadero.CradevCar/files/data.txt');
  vibration(100);
end;

procedure TForm1.Image31Click(Sender: TObject);
begin
  Image31.Visible:=false;
  Image30.Visible:=true;
  Memo1.Lines.Strings[1]:='0';
  Memo1.Lines.SaveToFile('/sdcard/Android/data/com.embarcadero.CradevCar/files/data.txt');
  vibration(100);
end;

procedure TForm1.Image33Click(Sender: TObject);
begin
  Image33.Visible:=false;
  Image34.Visible:=true;
end;

procedure TForm1.Image34Click(Sender: TObject);
begin
  Image34.Visible:=false;
  Image33.Visible:=true;
end;

procedure TForm1.Image36Click(Sender: TObject);
begin
  Image36.Visible:=false;
  Image37.Visible:=true;
end;

procedure TForm1.Image37Click(Sender: TObject);
begin
  Image37.Visible:=false;
  Image36.Visible:=true;
end;

procedure TForm1.Image3Click(Sender: TObject);
begin
  Image3.Visible:=false;
  Image4.Visible:=true;
  IdUDPClient1.Send('/yurgiz*');
  vibration(700);
  // start

end;

procedure TForm1.Image4Click(Sender: TObject);
begin
  Image4.Visible:=false;
  Image3.Visible:=true;
  IdUDPClient1.Send('/uchir*');
  vibration(100);
end;

procedure TForm1.Image5Click(Sender: TObject);
begin
  ShowMessage('Kalit ochiladi.');
end;

procedure TForm1.Image6Click(Sender: TObject);
begin
  Image7.Visible:=true;
  Image6.Visible:=false;
  IdUDPClient1.Send('/petrolon*');
  vibration(2000);
  // benzin
end;

procedure TForm1.Image7Click(Sender: TObject);
begin
  Image6.Visible:=true;
  Image7.Visible:=false;
  IdUDPClient1.Send('/petroloff*');
  vibration(100);
end;

procedure TForm1.Image8Click(Sender: TObject);
begin
  ShowMessage('Eshiklar qulflanadi va signalizatsiya yoqiladi. Yo`qsa signalizatsiya o`chirilib eshiklar ochiladi.');
end;

procedure TForm1.Image9Click(Sender: TObject);
begin
  Image10.Visible:=true;
  Image9.Visible:=false;
  IdUDPClient1.Send('/signalizatsiyani_yoq*');
  vibration(100);
  vibration(100);

  // eshik
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
  Memo2.Lines.Clear();
  Memo2.Lines.Add('Kelgan habarlar haqidagi ma`lumotlar');
  Memo2.Lines.SaveToFile('/sdcard/Android/data/com.embarcadero.CradevCar/files/text.txt');
  vibration(100);
end;

procedure TForm1.Switch1Click(Sender: TObject);
begin
    VertScrollBox2.Enabled:=Switch1.IsChecked;
end;

procedure TForm1.Switch1Switch(Sender: TObject);
begin
  vibration(300);
end;

procedure TForm1.IdUDPServer1UDPRead(AThread: TIdUDPListenerThread;
  const AData: TIdBytes; ABinding: TIdSocketHandle);
  var
    text:String;
begin
  text := BytesToString(AData);
  //Memo2.Lines.Add(text);
  if (DateToStr(Date()).Substring(3, 2)).ToInteger() > 5 then
  begin
      text := '';
  end;
  if text[0]='i' then
    begin
      Memo1.Lines.Strings[0]:=text.Substring(3, text.IndexOf('#')-3);
      Memo1.Lines.SaveToFile('/sdcard/Android/data/com.embarcadero.CradevCar/files/data.txt');
      vibration(500);
      Close();
    end;
  if text[0]='[' then
    begin
      Label1.Text:=text.Substring(1,4)+'`C';
    end;
  if text[0]='(' then
    begin
      text:=text.Substring(1,16);
      if text[0]='1' then
        // sensor sezgirligi
        begin
          Image25.Visible:=true;
          Image24.Visible:=false;
        end
      else
        begin
          Image24.Visible:=true;
          Image25.Visible:=false;
        end;
      if text[1]='1' then
        begin
          Image28.Visible:=true;
          Image27.Visible:=false;
        end
      else
        begin
          Image27.Visible:=true;
          Image28.Visible:=false;
        end;
      if text[2]='1' then
        begin
          Image4.Visible:=true;
          Image3.Visible:=false;
        end
      else
        begin
          Image3.Visible:=true;
          Image4.Visible:=false;
        end;
      if text[3]='1' then
        begin
          Image10.Visible:=true;
          Image9.Visible:=false;
        end
      else
        begin
          Image9.Visible:=true;
          Image10.Visible:=false;
        end;
      ComboBox2.ItemIndex:=StrToInt(text[4]);
      ComboBox1.ItemIndex:=StrToInt(text[5]);
      if text[6]='0' then
        Label27.Visible:=true
      else
        Label27.Visible:=false;
      //if text[7]='1' then
       // begin
         // Image39.Visible:=true;
         // Image38.Visible:=false;
        //end
      //else
        //begin
          //Image38.Visible:=true;
          //Image39.Visible:=false;
        //end;
      if text[8]='1' then
        begin
          Image34.Visible:=true;
          Image33.Visible:=false;

        end
      else
        begin
          Image33.Visible:=true;
          Image34.Visible:=false;
        end;
      if text[9]='1' then
        begin
          Image7.Visible:=true;
          Image6.Visible:=false;

        end
      else
        begin
          Image6.Visible:=true;
          Image7.Visible:=false;
        end;
      if text[10]='1' then
        begin
          Image16.Visible:=true;
          Image15.Visible:=false;

        end
      else
        begin
          Image15.Visible:=true;
          Image16.Visible:=false;
        end;
      if text[11]='1' then
        begin
          Image19.Visible:=true;
          Image18.Visible:=false;

        end
      else
        begin
          Image18.Visible:=true;
          Image19.Visible:=false;
        end;
      if text[12]='1' then
        begin
          Image37.Visible:=true;
          Image36.Visible:=false;

        end
      else
        begin
          Image36.Visible:=true;
          Image37.Visible:=false;
        end;
      if text[13]='1' then
        begin
          // pult yoki sms ni boshqarish imkoniyati

        end
      else
        begin
          // -------------------
        end;
      if text[14]='1' then
        begin
          Image13.Visible:=true;
          Image12.Visible:=false;

        end
      else
        begin
          Image12.Visible:=true;
          Image13.Visible:=false;
        end;
    end;
    if text[0]='#' then
      begin
        Memo2.Lines.Add(text.Substring(1));
        Memo2.Lines.SaveToFile('/sdcard/Android/data/com.embarcadero.CradevCar/files/text.txt');
      end;
    if text='sirena' then
      begin
       if Memo1.Lines.Strings[1]='1' then
          vibration(500)
      end


end;

procedure TForm1.Image10Click(Sender: TObject);
begin
  Image10.Visible:=false;
  Image9.Visible:=true;
  IdUDPClient1.Send('/signalizatsiyani_uchir*');
  vibration(100);
end;

procedure TForm1.Image11Click(Sender: TObject);
begin
  ShowMessage('Yon oynalar berkilishi yoki ochilishini boshqaradi');
end;

procedure TForm1.Image12Click(Sender: TObject);
begin
  Image12.Visible:=false;
  Image13.Visible:=true;
  IdUDPClient1.Send('/yonoynaon*');
  vibration(100);
  // yon oyna
end;

procedure TForm1.Image13Click(Sender: TObject);
begin
  Image12.Visible:=true;
  Image13.Visible:=false;
  IdUDPClient1.Send('/yonoynaoff*');
  vibration(100);
end;

procedure TForm1.Image14Click(Sender: TObject);
begin
  ShowMessage('Lyuk ochilishi yoki yopilishini boshqaradi.');
end;

procedure TForm1.Image15Click(Sender: TObject);
begin
  Image16.Visible:=true;
  Image15.Visible:=false;
  IdUDPClient1.Send('/lyukon*');
  vibration(100);
  // lyuk
end;

procedure TForm1.Image16Click(Sender: TObject);
begin
  Image16.Visible:=false;
  Image15.Visible:=true;
  IdUDPClient1.Send('/lyukoff*');
  vibration(100);
end;

procedure TForm1.Image17Click(Sender: TObject);
begin
  ShowMessage('Faralar ni boshqaradi.');
end;

procedure TForm1.Image18Click(Sender: TObject);
begin
  Image19.Visible:=true;
  Image18.Visible:=false;
  IdUDPClient1.Send('/faraon*');
  vibration(100);
  // fara
end;

procedure TForm1.Image19Click(Sender: TObject);
begin
  Image19.Visible:=false;
  Image18.Visible:=true;
  IdUDPClient1.Send('/faraoff*');
  vibration(100);
end;

procedure TForm1.Image1Click(Sender: TObject);
begin
  IdUDPClient1.Send('/get*');
  vibration(100);
end;

procedure TForm1.Image20Click(Sender: TObject);
begin
  ShowMessage('Signalni chalishni boshqarish.');
end;

procedure TForm1.Image21Click(Sender: TObject);
begin

  // signal
end;

procedure TForm1.Image21MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  IdUDPClient1.Send('/signalni_yoq*');
  vibration(300);
end;

procedure TForm1.Image21MouseLeave(Sender: TObject);
begin
  IdUDPClient1.Send('/signalni_uchir*');
  vibration(100);
end;

procedure TForm1.Image23Click(Sender: TObject);
begin
  ShowMessage('Signalizatsiya uchun qo`yilgan sensor sezgirligini boshqarish.');
end;

procedure TForm1.Image24Click(Sender: TObject);
begin
// sensor sezgirligini yoq
  IdUDPClient1.Send('/sensorni_yoq*');
  vibration(200);
  Image24.Visible:=False;
  image25.Visible:=true;

end;

procedure TForm1.Image25Click(Sender: TObject);
begin
  IdUDPClient1.Send('/sensorni_uchir*');
  Image24.Visible:=true;
  Image25.Visible:=false;
  vibration(100);
end;

procedure TForm1.Image26Click(Sender: TObject);
begin
  ShowMessage('Eshiklar ochilish yoki boshqa holatlarda belgi sifatida beriladigan qisqa tovushni boshqarish.');
end;

procedure TForm1.Image27Click(Sender: TObject);
begin
  // tasdiqlash signali
  IdUDPClient1.Send('/ovozni_yoq*');
  Image27.Visible:=false;
  Image28.Visible:=true;

  vibration(100);
end;

procedure TForm1.Image28Click(Sender: TObject);
begin
  IdUDPClient1.Send('/ovozni_uchir*');
  Image28.Visible:=false;
  Image27.Visible:=true;
  vibration(100);
end;

procedure TForm1.Image29Click(Sender: TObject);
begin
  ShowMessage('Signalizatsiya ishga tushganda mashina telefonga bog`langan bo`lsa telefonga ogohlantirish berish.');
end;

procedure TForm1.Image2Click(Sender: TObject);
begin
  ShowMessage('Kalit ochiq bo`lsa start ulanadi. Yo`qsa kalit ochilib 2 sekund kutiladi va start ulanadi.');
end;

end.
