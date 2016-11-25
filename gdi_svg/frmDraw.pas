unit frmDraw;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  IGDIPlus,
  Dialogs;

type
  TformDraw = class(TForm)
    procedure FormPaint(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private
    function DrawString3(pszbuf: WideString): Boolean;
    procedure Draw_bez(Graphics: IGPGraphics);
    { Private declarations }
  public
    { Public declarations }
    isDown:Boolean;
    //�����ƶ����ĸ���λ��
    downPoint:array of TPoint;
  end;

var
  formDraw: TformDraw;

implementation

{$R *.dfm}

//һ�� Bezier ����Ҫ�ĸ���: �����˵㡢�������Ƶ�
procedure TformDraw.Draw_bez(Graphics:IGPGraphics);
var
  //Graphics: IGPGraphics;
  Pen: IGPPen;
  P1,C1,C2,P2: TGPPoint;
begin
  P1 := MakePoint(30, 100);
  C1 := MakePoint(120, 10);
  C2 := MakePoint(170, 150);
  P2 := MakePoint(220, 80);

  //Graphics := TGPGraphics.Create(Handle);
  Pen := TGPPen.Create($FF0000FF, 2);

  Graphics.DrawBezier(Pen, P1, C1, C2, P2);

  Pen.Width := 1;
  Pen.Color := $FFFF0000;
  Graphics.DrawRectangle(Pen, P1.X-3, P1.Y-3, 6, 6);
  Graphics.DrawRectangle(Pen, P2.X-3, P2.Y-3, 6, 6);
  Graphics.DrawEllipse(Pen, C1.X-3, C1.Y-3, 6, 6);
  Graphics.DrawEllipse(Pen, C2.X-3, C2.Y-3, 6, 6);

  Pen.Color := $FFC0C0C0;
  Graphics.DrawLine(Pen, P1, C1);
  Graphics.DrawLine(Pen, P2, C2);

end;

function TformDraw.DrawString3(pszbuf: WideString):Boolean;
var
  hdcScreen: HDC;
  //hBitMap: Windows.HBITMAP;
  rct: TRect;
  graphics: IGPGraphics;     //��װһ�� GDI+ ��ͼͼ��
  fontFamily: IGPFontFamily; //�����������ƵĻ�����Ƶ�����ʽ����ĳЩ�����һ������
  path: IGPGraphicsPath;     //��ʾһϵ���໥���ӵ�ֱ�ߺ�����
  strFormat: IGPStringFormat;//��װ�ı�������Ϣ����ʾ����
  pen,pen1,pen2: IGPPen;     //�������ڻ���ֱ�ߺ����ߵĶ���
  linGrBrush,linGrBrushW: IGPLinearGradientBrush;  //ʹ�����Խ����װ Brush
  brush: IGPSolidBrush;      //���嵥ɫ���ʣ������������ͼ����״
  image: TGPImage;           //ʹ��������������Ͳ���GDI+ͼ��
  i: Integer;

  graphics_form: IGPGraphics;
  tmp:TBitmap;
  tmpg:TGPBitmap;

  st,sl:Integer;

begin
  //---------------------��ʼ����ʼ������--------------------------------------

  hdcScreen := GetDC(Self.Handle);
  //GetWindowRect(Self.Handle,rct);
  rct := GetClientRect;

  tmp := TBitmap.Create;
  tmp.Width := rct.Right - rct.Left;//100;
  tmp.Height := rct.Bottom - rct.Top;

  tmp.Canvas.TextOut(0,0,'aaa');
  tmp.Canvas.TextOut(10,10,'ccc');

  graphics := TGPGraphics.Create(tmp.Canvas.Handle);
  graphics_form := TGPGraphics.Create(hdcScreen);

  graphics.SetSmoothingMode(SmoothingModeAntiAlias); //ָ��ƽ��������ݣ�
  graphics.SetInterpolationMode(InterpolationModeHighQualityBicubic);//ָ���ĸ�Ʒ�ʣ�˫���β�ֵ

  pen := TGPPen.Create(MakeColor(155,215,215,215),3);  //��ɫ�����


  //����Ч��//����ɫˢ��

  linGrBrush := TGPLinearGradientBrush.Create(MakePoint(0, 0),    //���Խ�����ʼ��
                                                MakePoint(0, 100), //���Խ����ս��

                                                MakeColor(255,0,0,0), //���Խ�����ʼɫ

                                                MakeColor(255,30,120,195)); //���Խ������ɫ,ע���1�������� Alpha ͨ��

  //---------------------��ʼ����������ͱ���ͼ---------------------------------- 

  Draw_bez(graphics);


  //---------------------��ʼ������һ���ֲ�Ĵ��ڵ�λ�ã���С����״�����ݺͰ�͸����---
  //ReleaseDC(Self.Handle,hdcScreen); tmp.Free; Exit;
  tmpg := TGPBitmap.Create(tmp);
  graphics_form.DrawImage(tmpg, 0, 0);//˫����

  //---------------------��ʼ���ͷź�ɾ��--------------------------------------
  ReleaseDC(Self.Handle,hdcScreen);
  //tmpg.Free;//�ƺ�����Ҫ
  tmp.Free;

end;

procedure TformDraw.FormPaint(Sender: TObject);
begin

  DrawString3('aaa����');

end;

procedure TformDraw.FormCreate(Sender: TObject);
begin
  Self.isDown := False;
end;

procedure TformDraw.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Self.isDown := False;
end;

procedure TformDraw.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Self.isDown := True;

  SetLength(downPoint, 0);

end;

procedure TformDraw.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  p:TPoint;

begin
  if Self.isDown = False then Exit;

  SetLength(downPoint, Length(downPoint)+1);

  p.X := X; p.Y := Y;
  downPoint[Length(downPoint)-1] := p;

end;

end.
