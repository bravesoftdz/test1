{*******************************************************} 
{                                                       } 
{       ������Delphi 7 + IGDIPlus                       } 
{                                                       } 
{       ���ߣ��޻� http://blog.csdn.net/akof1314        } 
{                                                       } 
{*******************************************************} 
unit Unit1; 
 
interface 
 
uses 
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, IGDIPlus, ExtCtrls, Menus; 
 
type 
  TForm1 = class(TForm) 
    tmr1: TTimer; 
    pm1: TPopupMenu; 
    mni_topMost: TMenuItem; 
    mni_transparent: TMenuItem; 
    mni_exit: TMenuItem; 
    procedure FormCreate(Sender: TObject); 
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton; 
      Shift: TShiftState; X, Y: Integer); 
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, 
      Y: Integer); 
    procedure tmr1Timer(Sender: TObject); 
    procedure mni_topMostClick(Sender: TObject); 
    procedure MouseLeave(var Msg: TMessage);message WM_MOUSELEAVE; 
    procedure mni_transparentClick(Sender: TObject); 
    procedure mni_exitClick(Sender: TObject); 
  private 
    m_Kind: Integer;        //��ǰ�ڼ����ַ��� 
    m_bBack: Boolean;       //�Ƿ���ʾ���� 
    m_pszbuf: array[0..5] of WideString;   //Ҫ���Ƶ��ַ������� 
    function UpdateDisplay(pszbuf: WideString;bBack: Boolean = False; 
        Transparent: Integer = 100):Boolean; 
  public 
    { Public declarations } 
  end; 
 
var 
  Form1: TForm1; 
 
implementation 
 
{$R *.dfm} 
{------------------------------------------------------------------------------- 
  ������:    TForm1.UpdateDisplay 
  ����:      ���������� 
  ����:      pszbuf: WideString;     ���Ƶ��ַ��� 
             bBack: Boolean;         �Ƿ���Ʊ��� 
             Transparent: Integer    ͸���̶� 
  ����ֵ:    Boolean 
-------------------------------------------------------------------------------} 
function TForm1.UpdateDisplay(pszbuf: WideString;bBack: Boolean;Transparent: Integer):Boolean; 
var 
  hdcTemp,hdcScreen,m_hdcMemory: HDC; 
  hBitMap: Windows.HBITMAP; 
  blend: BLENDFUNCTION;      //���ֽṹ�Ļ�Ͽ���ͨ��ָ��Դ��Ŀ��λͼ�Ļ�Ϲ��� 
  rct: TRect; 
  ptWinPos,ptSrc: TPoint; 
  graphics: IGPGraphics;     //��װһ�� GDI+ ��ͼͼ�� 
  fontFamily: IGPFontFamily; //�����������ƵĻ�����Ƶ�����ʽ����ĳЩ�����һ������ 
  path: IGPGraphicsPath;     //��ʾһϵ���໥���ӵ�ֱ�ߺ����� 
  strFormat: IGPStringFormat;//��װ�ı�������Ϣ����ʾ���� 
  pen,pen1,pen2: IGPPen;     //�������ڻ���ֱ�ߺ����ߵĶ��� 
  linGrBrush,linGrBrushW: IGPLinearGradientBrush;  //ʹ�����Խ����װ Brush 
  brush: IGPSolidBrush;      //���嵥ɫ���ʣ������������ͼ����״ 
  image: TGPImage;           //ʹ��������������Ͳ���GDI+ͼ�� 
  i: Integer; 
  sizeWindow: SIZE; 
begin 
  //---------------------��ʼ����ʼ������-------------------------------------- 
  hdcTemp := GetDC(Self.Handle); 
  m_hdcMemory := CreateCompatibleDC(hdcTemp); 
  hBitMap := CreateCompatibleBitmap(hdcTemp,755,350); 
  SelectObject(m_hdcMemory,hBitMap); 
  if (Transparent < 0) or (Transparent > 100) then 
    Transparent := 100; 
  with blend do 
  begin 
    BlendOp := AC_SRC_OVER;     //��ԴͼƬ���ǵ�Ŀ��֮�� 
    BlendFlags := 0; 
    AlphaFormat := AC_SRC_ALPHA;//ÿ�������и��Ե�alphaͨ�� 
    SourceConstantAlpha :=Trunc(Transparent * 2.55);  //ԴͼƬ��͸���� 
  end; 
  hdcScreen := GetDC(Self.Handle); 
  GetWindowRect(Self.Handle,rct); 
  ptWinPos := Point(rct.Left,rct.Top); 
  graphics := TGPGraphics.Create(m_hdcMemory); 
  graphics.SetSmoothingMode(SmoothingModeAntiAlias); //ָ��ƽ��������ݣ� 
  graphics.SetInterpolationMode(InterpolationModeHighQualityBicubic);//ָ���ĸ�Ʒ�ʣ�˫���β�ֵ 
  fontFamily := TGPFontFamily.Create('΢���ź�'); //�����壬Ч��ͼΪ'΢���ź�'���� 
  strFormat := TGPStringFormat.Create(); 
  path := TGPGraphicsPath.Create(); 
  //---------------------��������ʼ������-------------------------------------- 
  path.AddString(pszbuf,          //Ҫ��ӵ� String 
                fontFamily,       //��ʾ�����ı�������������� 
                0,                //ָ��Ӧ�õ��ı���������Ϣ,����Ϊ��ͨ�ı� 
                38,               //�޶��ַ��� Em�������С������ĸ߶� 
                MakePoint(10,10), //һ�� Point������ʾ�ı�������ʼ�ĵ� 
                strFormat);       //ָ���ı���ʽ������Ϣ 
  pen := TGPPen.Create(MakeColor(155,215,215,215),3);  //��ɫ����� 
  graphics.DrawPath(pen,path);    //��������GraphicsPath 
  linGrBrush := TGPLinearGradientBrush.Create(MakePoint(0,0),    //���Խ�����ʼ�� 
                                                MakePoint(0,90), //���Խ����ս�� 
                                                MakeColor(255,255,255,255), //���Խ�����ʼɫ 
                                                MakeColor(255,30,120,195)); //���Խ������ɫ 
  linGrBrushW := TGPLinearGradientBrush.Create(MakePoint(0,10), 
                                                MakePoint(0,60), 
                                                MakeColor(255,255,255,255), 
                                                MakeColor(15,1,1,1)); 
  //---------------------��ʼ�����ַ�����Ӱ-------------------------------------- 
  for i := 1 to 8 do 
  begin 
    pen.SetWidth(i); 
    pen.SetColor(MakeColor(62, 0, 2, 2)); 
    pen.SetLineJoin(LineJoinRound); //ָ��Բ�����ӡ��⽫��������֮�����ƽ����Բ���� 
    graphics.DrawPath(pen,path); 
  end; 
  //---------------------��ʼ����������ͱ���ͼ---------------------------------- 
  if bBack then 
  begin 
    brush := TGPSolidBrush.Create(MakeColor(25,228,228,228)); 
    pen1 := TGPPen.Create(MakeColor(155,223,223,223)); 
    pen2 := TGPPen.Create(MakeColor(55,223,223,223)); 
    image := TGPImage.Create('back.png');             //����ͼƬ 
    graphics.FillRectangle(brush,3,5,750,90);         //��䱳����ɫ 
    graphics.DrawRectangle(pen1,2,6,751,91);          //�ڲ㱳���� 
    graphics.DrawRectangle(pen2,1,5,753,93);          //��㱳���� 
    graphics.DrawImage(image,600,25); 
  end; 
  //---------------------��ʼ���Խ���ɫ��ˢ���GraphicsPath�ڲ�----------------- 
  graphics.FillPath(linGrBrush,path); 
  graphics.FillPath(linGrBrushW,path); 
  sizeWindow.cx := 755; 
  sizeWindow.cy := 350; 
  ptSrc := Point(0,0); 
  //---------------------��ʼ������һ���ֲ�Ĵ��ڵ�λ�ã���С����״�����ݺͰ�͸����--- 
  Result := UpdateLayeredWindow(Self.Handle,   //�ֲ㴰�ڵľ�� 
                                hdcScreen,     //��Ļ��DC��� 
                                @ptWinPos,     //�ֲ㴰���µ���Ļ���� 
                                @sizeWindow,   //�ֲ㴰���µĴ�С 
                                m_hdcMemory,   //��������ֲ㴰�ڵı���DC��� 
                                @ptSrc,        //�ֲ㴰�����豸�����ĵ�λ�� 
                                0,             //�ϳɷֲ㴰��ʱʹ��ָ����ɫ��ֵ 
                                @blend,        //�ڷֲ㴰�ڽ������ʱ��͸����ֵ 
                                ULW_ALPHA);    //ʹ��pblendΪ��Ϲ��� 
  //---------------------��ʼ���ͷź�ɾ��-------------------------------------- 
  ReleaseDC(Self.Handle,hdcScreen); 
  ReleaseDC(Self.Handle,hdcTemp); 
  DeleteObject(hBitMap); 
  DeleteDC(m_hdcMemory); 
end; 
{------------------------------------------------------------------------------- 
  ����:      ���崴����ʼ�� 
-------------------------------------------------------------------------------} 
procedure TForm1.FormCreate(Sender: TObject); 
begin 
  //���ô������� 
  SetWindowLong(Application.Handle, 
                GWL_EXSTYLE, 
                GetWindowLong(Application.Handle,GWL_EXSTYLE) 
                or WS_EX_TOOLWINDOW);   //�������������� 
  SetWindowLong(Self.Handle, 
                GWL_EXSTYLE, 
                GetWindowLong(Self.Handle,GWL_EXSTYLE) 
                or WS_EX_LAYERED       //��δ��� 
                or WS_EX_TOOLWINDOW);  //����alt+tab�г��� 
  //��ʼ�������ȵ� 
  m_kind := 0; 
  m_bBack := False; 
  PopupMenu := pm1; 
  Self.Cursor := crHandPoint; 
  mni_topMost.Checked := True; 
  mni_topMostClick(mni_topMost); 
 
  m_pszbuf[0] := '��� Everyone!'; 
  m_pszbuf[1] := '����GDI+���Ƶ�������!'; 
  m_pszbuf[2] := '��ӭ�����޻ò���!'; 
  m_pszbuf[3] := 'http://blog.csdn.net/akof1314!'; 
  m_pszbuf[4] := 'Դ�������Ҫ�����޸�!'; 
  UpdateDisplay(m_pszbuf[m_kind],m_bBack); 
end; 
{------------------------------------------------------------------------------- 
  ����:      ��갴���ƶ����� 
-------------------------------------------------------------------------------} 
procedure TForm1.FormMouseDown(Sender: TObject; Button: TMouseButton; 
  Shift: TShiftState; X, Y: Integer); 
begin 
  ReleaseCapture; 
  SendMessage(Self.Handle,WM_SYSCOMMAND,SC_MOVE or HTCAPTION,0); 
end; 
{------------------------------------------------------------------------------- 
  ����:      ����ƹ����� 
-------------------------------------------------------------------------------} 
procedure TForm1.FormMouseMove(Sender: TObject; Shift: TShiftState; X, 
  Y: Integer); 
var 
  xh: TTrackMouseEvent; 
begin 
  m_bBack := True; 
  UpdateDisplay(m_pszbuf[m_kind],m_bBack); 
  with xh do 
  begin 
    cbSize := SizeOf(xh); 
    dwFlags := TME_LEAVE; 
    hwndTrack := Self.Handle; 
    dwHoverTime := 0; 
  end; 
  TrackMouseEvent(xh); 
end; 
{------------------------------------------------------------------------------- 
  ����:      ����Ƴ�����ʱ��ȥ������ 
-------------------------------------------------------------------------------} 
procedure TForm1.MouseLeave(var Msg: TMessage); 
begin 
  m_bBack := False; 
  UpdateDisplay(m_pszbuf[m_kind],m_bBack); 
  Msg.Result := 0; 
end; 
{------------------------------------------------------------------------------- 
  ����:      ��ʱ���л��ַ��� 
-------------------------------------------------------------------------------} 
procedure TForm1.tmr1Timer(Sender: TObject); 
begin 
  Inc(m_Kind); 
  if m_kind > 4 then 
    m_kind := 0; 
  UpdateDisplay(m_pszbuf[m_kind],m_bBack); 
end; 
{------------------------------------------------------------------------------- 
  ����:      �����ö� 
-------------------------------------------------------------------------------} 
procedure TForm1.mni_topMostClick(Sender: TObject); 
begin 
  if mni_topMost.Checked then 
  SetWindowPos(Self.Handle, 
               HWND_TOPMOST, 
               0,0,0,0, 
               SWP_NOSIZE or SWP_NOMOVE)    //�����ö� 
  else 
  SetWindowPos(Self.Handle, 
               HWND_NOTOPMOST, 
               0,0,0,0, 
               SWP_NOSIZE or SWP_NOMOVE);    //�����ö� 
end; 
{------------------------------------------------------------------------------- 
  ����:      ������͸ ���൱���������棩 
-------------------------------------------------------------------------------} 
procedure TForm1.mni_transparentClick(Sender: TObject); 
begin 
  SetWindowLong(Self.Handle, 
                GWL_EXSTYLE, 
                GetWindowLong(Self.Handle,GWL_EXSTYLE) or WS_EX_TRANSPARENT); 
  Application.MessageBox('���ѹرղ��˳����ˣ���������������ر�', 
                        '��ʾ',MB_OK or MB_ICONINFORMATION); 
end; 
{------------------------------------------------------------------------------- 
  ����:      �˳� 
-------------------------------------------------------------------------------} 
procedure TForm1.mni_exitClick(Sender: TObject); 
begin 
  Self.Close; 
end; 
 
end. 