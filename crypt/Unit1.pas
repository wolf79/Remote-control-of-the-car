unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Maps,
  FMX.StdCtrls, FMX.Effects, FMX.Objects, FMX.Controls.Presentation, FMX.Layouts,
  FMX.ScrollBox, FMX.Memo, IdUDPServer, IdBaseComponent, IdComponent, IdUDPBase,
  IdUDPClient;

type
  TForm1 = class(TForm)
    Image1: TImage;
    VertScrollBox1: TVertScrollBox;
    Button1: TButton;
    Rectangle1: TRectangle;
    Button2: TButton;
    Rectangle2: TRectangle;
    Button3: TButton;
    ShadowEffect1: TShadowEffect;
    ShadowEffect2: TShadowEffect;
    ShadowEffect3: TShadowEffect;
    Label1: TLabel;
    Memo1: TMemo;
    ShadowEffect4: TShadowEffect;
    Button4: TButton;
    ShadowEffect5: TShadowEffect;
    Memo2: TMemo;
    ShadowEffect6: TShadowEffect;
    Timer1: TTimer;
    Button5: TButton;
    ShadowEffect7: TShadowEffect;
    Memo3: TMemo;
    ShadowEffect8: TShadowEffect;
    IdUDPClient1: TIdUDPClient;
    IdUDPServer1: TIdUDPServer;
    Saqlash: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure SendCommand(command: String);
    procedure Button4Click(Sender: TObject);
    procedure SaqlashClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;


implementation

{$R *.fmx}

procedure TForm1.SaqlashClick(Sender: TObject);
begin
  Memo2.Lines.SaveToFile('/sdcard/Android/data/com.embarcadero.CradevCar/files/data.txt');
end;

procedure TForm1.SendCommand(command : String);
var
  I: Integer;
  dates:String;
  day:Integer;
  month:Integer;
  year:Integer;
  times:String;
  hour:Integer;
  minute:Integer;
  secound:Integer;
  index:Integer;
  shift:Integer;
  unshift:Integer;
  _random_:Integer;
  text:String;
  _byte_:Byte;
begin
  // takrorlanmas turli xil kombinatsiyalarni tashkil qilishni maqsad qildim

  Memo2.Lines.Clear();
  Memo3.Lines.Clear();
  //times:=DateTimeToStr(Time());
  dates:=DateTimeToStr(Date());
  //ShowMessage(dates.Substring(0,2));
  //ShowMessage(IntToStr(dates.IndexOf('/')));
  index:=dates.IndexOf('/');
  month:=StrToInt(dates.Substring(0,index));
  dates:=dates.Substring(index+1);
  //ShowMessage(dates);
  index:=dates.IndexOf('/');
  day:=StrToInt(dates.Substring(0,index));
  dates:=dates.Substring(index+1);
  year:=StrToInt(dates);
  //ShowMessage(IntToStr(year));

  times:=DateTimeToStr(Time());
  //ShowMessage(times);
  index:=times.IndexOf(' ');
  times:=times.Substring(index);
  index:=times.IndexOf(':');
  hour:=StrToInt(times.Substring(0,index));
  times:=times.Substring(index+1);
  index:=times.IndexOf(':');
  minute:=StrToInt(times.Substring(0,index));
  times:=times.Substring(index+1);

  //ShowMessage(times.Substring(0,2));
  secound:=StrToInt(times.Substring(0,2));
  //ShowMessage(IntToStr(secound));
  shift:=hour+secound;


  //ShowMessage(IntToStr(command.Length-1));
  //crypt
  command:=Chr(day+70)+command+Chr(month+60)+Chr(year+80);
  for I := 0 to command.Length-1 do
    begin
      //ShowMessage(IntToStr(Ord(command[I])));
      _byte_:=Ord(command[I])+shift;
      if (_byte_>=127) and (_byte_ <= 173)  then
        begin
          _byte_:=_byte_-127;
          _byte_:=_byte_+174;
        end;
      text := text+Chr(_byte_);
    end;

  hour:=secound+hour+90;
  if (hour>=127) and (hour <= 174)  then
    begin
      hour:=hour-127;
      hour:=hour+174;
    end
  else if hour>=174 then
    begin
      hour:=hour+47;
    end;

  minute:=secound+minute+75;  //

  if (minute>=127) and (minute <= 173)  then
    begin
      minute:=minute-127;
      minute:=minute+174;
    end
  else if minute>=174 then
    begin
      minute:=minute+47;
    end;

  //ShowMessage('|'+Chr(173)+'|');

  // 31   -3
  secound:=secound+130;//   173
  if (secound>=127) and (secound <= 173)  then
    begin
      secound:=secound-127; // 2
      secound:=secound+174;    // 163
    end
  else if secound>=174 then
    begin
      secound:=secound+47;
    end;


  text:=Chr(hour)+text+Chr(minute)+Chr(secound);
  Memo2.Lines.Add(text);
  IdUDPClient1.Send(text);
  //ShowMessage('*'+text.Substring(24,1)+'*'+IntToStr(text.Length));



  //decrypt
  command:='';
  // 163
  //ShowMessage(IntToStr(text.Length));
  secound:=Ord(text[text.Length-1]);
  if (secound>=127) and (secound <= 173)  then
    begin
      secound:=173-secound;
      secound:=126-secound;
    end
  else if secound>=174 then
    begin
      secound:=secound-174; // 188-161=27
      secound:=127+secound; // 32+127 = 154
    end;
  secound:=secound-130;
  // -----------------------------------------------------------------------------------------

  minute:=Ord(text[text.Length-2]);
  if (minute>=127) and (minute <= 173)  then
    begin
      minute:=173-minute;
      minute:=126-minute;
    end
  else if minute>=174 then
    begin
      minute:=minute-174; // 188-161=27
      minute:=127+minute; // 32+127 = 154
    end;
  minute:=minute-75-secound;

  //-----------------------------------------------------------------------------------------

  hour:=Ord(text[0]);
  if (hour>=127) and (hour <= 173)  then
    begin
      hour:=173-hour;
      hour:=126-hour;
    end
  else if hour>=174 then
    begin
      hour:=hour-174; // 188-161=27
      hour:=127+hour; // 32+127 = 154
    end;
  hour:=hour-90-secound;

  //------------------------------------------------------------------------------------------
  //Memo2.Lines.Add(IntToStr(hour)+':'+IntToStr(minute)+':'+IntToStr(secound)+'->'+DateTimeToStr(Time()));
  unshift:=secound+hour;
  //------------------------------------------------------------------------------------------

  day:=Ord(text[1]);
  if (day>=127) and (day <= 173)  then
    begin
      day:=173-day;
      day:=126-day;
    end
  else if day>=174 then
    begin
      day:=day-174; // 188-161=27
      day:=127+day; // 32+127 = 154
    end;
  day:=day-70-unshift;

  //------------------------------------------------------------------------------------------

  month:=Ord(text[text.Length-4]);
  if (month>=127) and (month <= 173)  then
    begin
      month:=173-month;
      month:=126-month;
    end
  else if month>=174 then
    begin
      month:=month-174; // 188-161=27
      month:=127+month; // 32+127 = 154
    end;
  month:=month-60-unshift;

  //------------------------------------------------------------------------------------------

  year:=Ord(text[text.Length-3]);
  if (year>=127) and (year <= 173)  then
    begin
      year:=173-year;
      year:=126-year;
    end
  else if year>=174 then
    begin
      year:=year-174; // 188-161=27
      year:=127+year; // 32+127 = 154
    end;
  year:=year-80-unshift;

  //------------------------------------------------------------------------------------------
  //Ma'lumot chegarasi Q
  //------------------------------------------------------------------------------------------
  //Memo2.Lines.Add(IntToStr(day)+'/'+IntToStr(month)+'/'+IntToStr(year)+'->'+DateToStr(Date()));
  //------------------------------------------------------------------------------------------

  text:=text.Substring(2,text.Length-6);
  //------------------------------------------------------------------------------------------

  command:='';

  for I:=0 to text.Length-1 do
    //command:=command+Chr((Ord(text[I])-shift));
    begin
      _byte_:=Ord(text[I]);
      if (_byte_>=127) and (_byte_ <= 173)  then
        begin
          _byte_:=173-_byte_;
          _byte_:=126-_byte_;
        end
      else if _byte_>=174 then
        begin
          _byte_:=_byte_-174; // 188-161=27  207-174 33
          _byte_:=127+_byte_;
        end;
      _byte_:=_byte_-unshift;
      command:=command+Chr(_byte_);
      //118+89
    end;
  //------------------------------------------------------------------------------------------
  Memo3.Lines.Add(command);
end;
procedure TForm1.Button4Click(Sender: TObject);
begin
  SendCommand(Memo1.Lines.GetText());
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  Memo2.Lines.Clear();
  Memo3.Lines.Clear();
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Image1.Height:=Form1.Height/3;
end;

end.
