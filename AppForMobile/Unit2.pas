unit Unit2;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Effects, FMX.Layouts, FMX.Colors,
  FMX.Edit;

type
  TForm2 = class(TForm)
    Button1: TButton;
    Rectangle1: TRectangle;
    VertScrollBox1: TVertScrollBox;
    RoundRect1: TRoundRect;
    Image2: TImage;
    ShadowEffect5: TShadowEffect;
    Label2: TLabel;
    RoundRect2: TRoundRect;
    Image5: TImage;
    ShadowEffect6: TShadowEffect;
    Label3: TLabel;
    RoundRect3: TRoundRect;
    Image8: TImage;
    ShadowEffect7: TShadowEffect;
    Label4: TLabel;
    RoundRect4: TRoundRect;
    Image11: TImage;
    ShadowEffect8: TShadowEffect;
    Label5: TLabel;
    RoundRect5: TRoundRect;
    Image14: TImage;
    ShadowEffect9: TShadowEffect;
    Label6: TLabel;
    RoundRect6: TRoundRect;
    Image17: TImage;
    ShadowEffect10: TShadowEffect;
    Label7: TLabel;
    RoundRect7: TRoundRect;
    Image20: TImage;
    ShadowEffect11: TShadowEffect;
    Label8: TLabel;
    Label1: TLabel;
    ColorButton1: TColorButton;
    ColorButton2: TColorButton;
    ColorButton3: TColorButton;
    ColorButton4: TColorButton;
    ColorButton5: TColorButton;
    ColorButton6: TColorButton;
    ColorButton7: TColorButton;
    ColorButton8: TColorButton;
    ColorButton9: TColorButton;
    ColorButton10: TColorButton;
    ColorButton11: TColorButton;
    ColorButton12: TColorButton;
    ColorButton13: TColorButton;
    ColorButton14: TColorButton;
    Button2: TButton;
    Panel1: TPanel;
    ShadowEffect1: TShadowEffect;
    ToolBar1: TToolBar;
    ShadowEffect2: TShadowEffect;
    Label9: TLabel;
    Edit1: TEdit;
    Rectangle2: TRectangle;
    Button3: TButton;
    ShadowEffect3: TShadowEffect;
    Label10: TLabel;
    Button5: TButton;
    Button4: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.fmx}

uses Unit1, Unit3;

procedure TForm2.Button1Click(Sender: TObject);
begin
  Form2.Close();
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
  Panel1.Visible:=not Panel1.Visible;
end;

procedure TForm2.Button3Click(Sender: TObject);
begin
  Panel1.Visible:=false;
end;

procedure TForm2.Button4Click(Sender: TObject);
begin
  //ShowMessage('Ushbu funksiyalar ishlashi uchun mashinaga qo`shilgan simkarta raqamlari kiritilishi kerak. Ushbu funksiyalar umumiylikni taminlash uchun va masofani chegaralamaslik uchun kiritilgan. Rasmlarni bossangiz sms orqali uzatilishi kerak bo`lgan kodlar kiritilgan qaysi bir funksiya sizga kerak bo`lsa yodlab oling va o`sha kodni ixtiyoriy telefon orqali sms ko`rinishida mashinaga yuboring va biroz kuting!');
end;

procedure TForm2.Button5Click(Sender: TObject);
begin
  Panel1.Visible:=false;
end;

end.
