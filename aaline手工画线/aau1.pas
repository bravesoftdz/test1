unit aau1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  ca:TCanvas;
  i:Integer;
  x,y,h,w:Integer;
  yf:Double;

  //�ϵ�ľ����
  //�µ�ľ����
  off:Double;//����ľ����
  color:Byte;//TColor;//

begin

  ca := TCanvas.Create;

  ca.Handle := GetDC(Self.Handle);

  ca.LineTo(100, 100);

  h := 100; w := 300;
  for i := 0 to w-1 do
  begin
    x := i;

    yf := x * (h/w);

    y := Trunc(yf);

    //ca.Pixels[x, y] := clBlack;

    //���������������������ֵ
    off := Abs(yf - y);

    color := Trunc(255 * (1 - off));

    color := 255 - color;

    ca.Pixels[x, y] := RGB(color, color, color);

  end;


  ca.Free;

end;

procedure TForm1.Button2Click(Sender: TObject);
var
  ca:TCanvas;
  i:Integer;
  x,y,h,w:Integer;
  yf:Double;

  off1:Double;//�ϵ�ľ����
  off2:Double;//�µ�ľ����
  off:Double;//����ľ����
  color:Byte;//TColor;//

  procedure p1;
  begin
    y := y + 1;  //����ĵ�//��Ϊ windows ����������,��ʵ������ĵ�

    //ca.Pixels[x, y] := clBlack;

    //���������������������ֵ
    off := Abs(yf - y);

    color := Trunc(255 * (1 - off));

    color := 255 - color;

    ca.Pixels[x, y] := RGB(color, color, color);

  end;
  
begin

  ca := TCanvas.Create;

  ca.Handle := GetDC(Self.Handle);

  //ca.LineTo(100, 100);

  h := 100; w := 300;
  //h := 100; w := 100;
  for i := 0 to w-1 do
  begin
    x := i;

    yf := x * (h/w);

    y := Trunc(yf);

    //ca.Pixels[x, y] := clBlack;

    //���������������������ֵ
    off := Abs(yf - y);

    color := Trunc(255 * (1 - off));

    color := 255 - color;

    ca.Pixels[x, y] := RGB(color, color, color);

    p1();//���� y ������ĵ�

  end;


  ca.Free;

end;

end.
