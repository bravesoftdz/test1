unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Path1: TPath;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.Button1Click(Sender: TObject);
var
  s:string;
  p:PByte;
  //t:RawByteString;
begin
  //ShowMessage(IntToStr(SizeOf(('����'[1]))));  //ȷʵ�������ֽ�һ���ַ�//unicode ��,�����ֻ����� 0 ��ʼ
  s := '1����123����abc';
  p := PByte(PChar(s));
  ShowMessage(IntToStr(p[0])); //ok �ֻ�,pc ��ͨ��
  ShowMessage(IntToStr(p[1])); //ok �ֻ�,pc ��ͨ��
end;

end.
