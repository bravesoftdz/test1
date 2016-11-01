unit Unit1;
 
interface 
 
uses 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, gdipapi, gdipobj, Menus, StdCtrls; 
 
type 
  TForm1 = class(TForm) 
    PopupMenu1: TPopupMenu; 
    ChangeSkin1: TMenuItem; 
    N1: TMenuItem; 
    Close1: TMenuItem;
    Button1: TButton;
    N2: TMenuItem;
    N3: TMenuItem;
    procedure FormCreate(Sender: TObject); 
    procedure FormDestroy(Sender: TObject); 
    procedure ShowPNGForm1(PNGFile:string; nTran: integer); 
    procedure ShowPNGForm2(PNGFile:string; nTran: integer); 
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton; 
      Shift: TShiftState; X, Y: Integer); 
    procedure Close1Click(Sender: TObject); 
    procedure ChangeSkin1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
  private 
    { Private declarations } 
  public 
    { Public declarations } 
  end; 
 
const 
  WS_EX_LAYERED = $80000; 
  LWA_COLORKEY  = 1; 
  LWA_ALPHA     = 2; 
  ULW_COLORKEY  = 1; 
  ULW_ALPHA     = 2; 
  ULW_OPAQUE    = 4; 
 
 
 
 
var 
  Form1: TForm1; 
  bmp, old_bmp : HBITMAP; 
  DC : HDC; 
  bitmap: tgpbitmap; 
  j:integer; 
 
 
 
 
  Function UpdateLayeredWindow(hWnd : HWND; 
                            hdcDst : HDC; pptDst : PPoint; psize : PSize; 
                            hdcSrc : HDC; pptSrc : PPoint; 
                            crKey  : COLORREF; 
                            pblend : PBlendFunction; 
                            dwFlags : DWORD): BOOL; stdcall; 
 
 
implementation 
 
{$R *.dfm} 
 
Function UpdateLayeredWindow; external 'user32.dll'; 
 
procedure Tform1.ShowPNGForm1(PNGFile:string; nTran: integer); 
var 
  graphics : TGPGraphics; 
  Image: TGPImage; 
 
begin 
   
 
  graphics := TGPGraphics.Create(DC); 
  Image:= TGPImage.Create(PNGFile); 

  graphics.DrawImage(image, 0, 0);
  //UpdateLayeredWindow(Handle, Canvas.Handle, @pt1, @sz, DC, @pt2,0, @bf,ULW_ALPHA);
end;

procedure Tform1.ShowPNGForm2(PNGFile:string; nTran: integer);
var
  pt1, pt2 : TPoint;
  sz : TSize;
  bf : TBlendFunction;
  i,j:Integer;
begin

  bitmap:=tgpbitmap.Create(PNGFile);
  pt1 := Point(left,top); //�������Ͻǵ�����
  pt2 := Point(0, 0); //����Ͳ���˵�ˣ�һ������0��0����Ӧ��������
  sz.cx := bitmap.GetWidth;  //�ߴ粻Ҫ����ͼ���С����Ȼ���ھ�ʲô��û���ˣ�����Ӱ�Ӷ�û��
  sz.cy := bitmap.GetHeight;  //ͬ��
  bf.BlendOp := AC_SRC_OVER; //��Щ���Ǿ�����
  bf.BlendFlags := 0;                  //ͬ��
  if (nTran<0) or (nTran>255) then nTran:=255;
  bf.SourceConstantAlpha := nTran;  //ͬ��
  bf.AlphaFormat := AC_SRC_ALPHA; //ͬ��

  //--------------------------------------------------
  //clq test
  //bitmap.SetPixel(0, 0, aclRed);
  //bitmap.SetPixel(0, 1, $FFFF0000);
  for i := 0 to 100 do
  begin
    for j := 0 to 100 do
    begin
      bitmap.SetPixel(i, j, $8FFF0000);

    end;

  end;

  //--------------------------------------------------

  DeleteObject(bmp); //ǰ����������ﷸ�Ĵ��󣬲�Ȼռ�õ��ڴ����������
  bitmap.GetHBITMAP(0,bmp); // HBITMAP��windows��׼λͼ��ʽ��֧��͸���������Ǵ�tgpbitmap ת���� HBITMAP
  DeleteDC(DC);
  DC := CreateCompatibleDC(Canvas.Handle); //API�ĺ����ҵ������ף�Ϊʲôд��仰�ҾͲ������ˣ�����������Ҫ
  old_bmp := SelectObject(DC, bmp); //ͬ��

  //--------------------------------------------------
  //clq test
  //TextOut(DC, 0, 0, 'aaa', 3);

  //--------------------------------------------------

  UpdateLayeredWindow(Handle, Canvas.Handle, @pt1, @sz, DC, @pt2,0, @bf,ULW_ALPHA); 
end; 
 
procedure TForm1.FormCreate(Sender: TObject); 
begin 
  if SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_LAYERED) = 0 then ShowMessage(SysErrorMessage(GetLastError));

  ShowPNGForm2('test.png',255); 
  J:=1;
end; 
 
procedure TForm1.FormDestroy(Sender: TObject); 
begin
  SelectObject(DC, old_bmp);
  DeleteObject(bmp);
  DeleteDC(DC);
  bitmap.Free; 
end; 
 
procedure TForm1.FormMouseDown(Sender: TObject; Button: TMouseButton; 
  Shift: TShiftState; X, Y: Integer); 
begin 
  if(Button = mbLeft) then 
    begin 
      ReleaseCapture(); 
      Perform(WM_SYSCOMMAND, SC_MOVE or HTCAPTION, 0); 
    end; 
end; 
 
procedure TForm1.Close1Click(Sender: TObject); 
begin 
  Close; 
end; 
 
procedure TForm1.ChangeSkin1Click(Sender: TObject); 
var 
  dlgOpen: TOpenDialog; 
begin 
  dlgOpen := TOpenDialog.Create(Self); 
  dlgOpen.Filter := 'PNG file(*.png)|*.png'; 
  if(dlgOpen.Execute()) then 
    begin 
      ShowPNGForm2(dlgOpen.FileName,255); 
    end; 
  dlgOpen.Free; 
end; 

procedure TForm1.Button1Click(Sender: TObject);
begin
  ShowMessage('aaa');
end;

//������͸ ���൱���������棩
procedure TForm1.N3Click(Sender: TObject);
begin
  //����һ��Ч����ͬ
  SetWindowPos(Self.Handle, 
               HWND_TOPMOST, 
               0,0,0,0, 
               SWP_NOSIZE or SWP_NOMOVE);    //�����ö� 

  //--------------------------------------------------

  SetWindowLong(Self.Handle,
                GWL_EXSTYLE,
                GetWindowLong(Self.Handle,GWL_EXSTYLE) or WS_EX_TRANSPARENT);
  Application.MessageBox('���ѹرղ��˳����ˣ���������������ر�',
                        '��ʾ',MB_OK or MB_ICONINFORMATION);
end;

end.