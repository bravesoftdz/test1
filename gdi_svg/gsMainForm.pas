unit gsMainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  IGDIPlus,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    procedure FormPaint(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    function DrawString(pszbuf: WideString): Boolean;
    function DrawString2(pszbuf: WideString): Boolean;
    function DrawString3(pszbuf: WideString): Boolean;
    
    //一条 Bezier 线需要四个点: 两个端点、两个控制点
    procedure Draw_bez(Graphics:IGPGraphics);
    procedure Draw_curve(Graphics: IGPGraphics);
  public
    { Public declarations }

    //文字大小
    fontSize:Integer;
    //文字的阴影宽度
    shadowSize:Integer;
    //自动折行后的文字列表
    //stringsForDraw:TStringList;
    //起始边框位置 top,left
    drawOffTop:Integer;
    drawOffLeft:Integer;
  end;

var
  Form1: TForm1;

implementation

uses frmDraw;

{$R *.dfm}

function TForm1.DrawString2(pszbuf: WideString):Boolean;
var
  hdcScreen: HDC;
  //hBitMap: Windows.HBITMAP;
  rct: TRect;
  graphics: IGPGraphics;     //封装一个 GDI+ 绘图图面
  fontFamily: IGPFontFamily; //定义有着相似的基本设计但在形式上有某些差异的一组字样
  path: IGPGraphicsPath;     //表示一系列相互连接的直线和曲线
  strFormat: IGPStringFormat;//封装文本布局信息，显示操作
  pen,pen1,pen2: IGPPen;     //定义用于绘制直线和曲线的对象
  linGrBrush,linGrBrushW: IGPLinearGradientBrush;  //使用线性渐变封装 Brush
  brush: IGPSolidBrush;      //定义单色画笔，画笔用于填充图形形状
  image: TGPImage;           //使用这个类来创建和操作GDI+图像
  i: Integer;

  graphics_form: IGPGraphics;
  tmp:TBitmap;
  tmpg:TGPBitmap;

  st,sl:Integer;

begin
  //---------------------开始：初始化操作--------------------------------------

  hdcScreen := GetDC(Self.Handle);
  //GetWindowRect(Self.Handle,rct);
  rct := GetClientRect;

  tmp := TBitmap.Create;
  tmp.Width := rct.Right - rct.Left;//100;
  tmp.Height := rct.Bottom - rct.Top;

  tmp.Canvas.TextOut(0,0,'aaa');
  tmp.Canvas.TextOut(10,10,'ccc');

  graphics := TGPGraphics.Create(tmp.Canvas.Handle);
  graphics := TGPGraphics.Create(hdcScreen);
  graphics_form := TGPGraphics.Create(hdcScreen);



  graphics.SetSmoothingMode(SmoothingModeAntiAlias); //指定平滑（抗锯齿）
  graphics.SetInterpolationMode(InterpolationModeHighQualityBicubic);//指定的高品质，双三次插值

  pen := TGPPen.Create(MakeColor(155,215,215,215),3);  //颜色、宽度


  //彩白折刷?特殊效果
  //if False then
  linGrBrush := TGPLinearGradientBrush.Create(MakePoint(0, drawOffTop),    //线性渐变起始点
                                                MakePoint(0, Trunc((fontSize*0.5)) + drawOffTop), //线性渐变终结点
                                                MakeColor(255,255,255,255), //线性渐变起始色
                                                //MakeColor(255,30,120,195)); //线性渐变结束色
                                                MakeColor(255,30,120,195)); //线性渐变结束色,注意第1个参数是 Alpha 通道

  //---------------------开始：画背景框和背景图---------------------------------- 
  //if bBack then
  if true then
  begin
    //brush := TGPSolidBrush.Create(MakeColor(25,228,228,228));
    brush := TGPSolidBrush.Create(MakeColor(100, 0,0,0));
//    pen1 := TGPPen.Create(MakeColor(155,223,223,223));
//    pen2 := TGPPen.Create(MakeColor(55,223,223,223));
//    image := TGPImage.Create('back.png');             //背景图片
    graphics.FillRectangle(brush,3,5,750,90);         //填充背景框色//这个会极大的影响性能
//    graphics.FillRectangle(linGrBrush,3,5,750,90);         //填充背景框色//这个会极大的影响性能
//    graphics.DrawRectangle(pen1,2,6,751,91);          //内层背景框
//    graphics.DrawRectangle(pen2,1,5,753,93);          //外层背景框
//    graphics.DrawImage(image,600,25);
  end;
  //---------------------开始：更新一个分层的窗口的位置，大小，形状，内容和半透明度---
  //ReleaseDC(Self.Handle,hdcScreen); tmp.Free; Exit;
  tmpg := TGPBitmap.Create(tmp);
  graphics_form.DrawImage(tmpg, 0, 0);//双缓冲

  //---------------------开始：释放和删除--------------------------------------
  ReleaseDC(Self.Handle,hdcScreen);
  //tmpg.Free;//似乎不需要
  tmp.Free;

end;

function TForm1.DrawString(pszbuf: WideString):Boolean;
var
  hdcScreen: HDC;
  //hBitMap: Windows.HBITMAP;
  rct: TRect;
  graphics: IGPGraphics;     //封装一个 GDI+ 绘图图面
  fontFamily: IGPFontFamily; //定义有着相似的基本设计但在形式上有某些差异的一组字样
  path: IGPGraphicsPath;     //表示一系列相互连接的直线和曲线
  strFormat: IGPStringFormat;//封装文本布局信息，显示操作
  pen,pen1,pen2: IGPPen;     //定义用于绘制直线和曲线的对象
  linGrBrush,linGrBrushW: IGPLinearGradientBrush;  //使用线性渐变封装 Brush
  brush: IGPSolidBrush;      //定义单色画笔，画笔用于填充图形形状
  image: TGPImage;           //使用这个类来创建和操作GDI+图像
  i: Integer;

  graphics_form: IGPGraphics;
  tmp:TBitmap;
  tmpg:TGPBitmap;

  st,sl:Integer;

begin
  //---------------------开始：初始化操作--------------------------------------

  hdcScreen := GetDC(Self.Handle);
  //GetWindowRect(Self.Handle,rct);
  rct := GetClientRect;

  tmp := TBitmap.Create;
  tmp.Width := rct.Right - rct.Left;//100;
  tmp.Height := rct.Bottom - rct.Top;

  tmp.Canvas.TextOut(0,0,'aaa');
  tmp.Canvas.TextOut(10,10,'ccc');

  graphics := TGPGraphics.Create(hdcScreen);




  graphics.SetSmoothingMode(SmoothingModeAntiAlias); //指定平滑（抗锯齿）
  graphics.SetInterpolationMode(InterpolationModeHighQualityBicubic);//指定的高品质，双三次插值

  pen := TGPPen.Create(MakeColor(155,215,215,215),3);  //颜色、宽度


  //彩白折刷?特殊效果
  //if False then
  linGrBrush := TGPLinearGradientBrush.Create(MakePoint(0, drawOffTop),    //线性渐变起始点
                                                MakePoint(0, Trunc((fontSize*0.5)) + drawOffTop), //线性渐变终结点
                                                MakeColor(255,255,255,255), //线性渐变起始色
                                                //MakeColor(255,30,120,195)); //线性渐变结束色
                                                MakeColor(255,30,120,195)); //线性渐变结束色,注意第1个参数是 Alpha 通道

  //---------------------开始：画背景框和背景图---------------------------------- 
  //if bBack then
  if true then
  begin
    //brush := TGPSolidBrush.Create(MakeColor(25,228,228,228));
    brush := TGPSolidBrush.Create(MakeColor(100, 0,0,0));
//    pen1 := TGPPen.Create(MakeColor(155,223,223,223));
//    pen2 := TGPPen.Create(MakeColor(55,223,223,223));
//    image := TGPImage.Create('back.png');             //背景图片
    graphics.FillRectangle(brush,10,10,100,100);         //填充背景框色//这个会极大的影响性能
//    graphics.FillRectangle(linGrBrush,3,5,750,90);         //填充背景框色//这个会极大的影响性能
//    graphics.DrawRectangle(pen1,2,6,751,91);          //内层背景框
//    graphics.DrawRectangle(pen2,1,5,753,93);          //外层背景框
//    graphics.DrawImage(image,600,25);
  end;
  //---------------------开始：更新一个分层的窗口的位置，大小，形状，内容和半透明度---


  //---------------------开始：释放和删除--------------------------------------
  ReleaseDC(Self.Handle,hdcScreen);
  //tmpg.Free;//似乎不需要
  tmp.Free;

end;

function TForm1.DrawString3(pszbuf: WideString):Boolean;
var
  hdcScreen: HDC;
  //hBitMap: Windows.HBITMAP;
  rct: TRect;
  graphics: IGPGraphics;     //封装一个 GDI+ 绘图图面
  fontFamily: IGPFontFamily; //定义有着相似的基本设计但在形式上有某些差异的一组字样
  path: IGPGraphicsPath;     //表示一系列相互连接的直线和曲线
  strFormat: IGPStringFormat;//封装文本布局信息，显示操作
  pen,pen1,pen2: IGPPen;     //定义用于绘制直线和曲线的对象
  linGrBrush,linGrBrushW: IGPLinearGradientBrush;  //使用线性渐变封装 Brush
  brush: IGPSolidBrush;      //定义单色画笔，画笔用于填充图形形状
  image: TGPImage;           //使用这个类来创建和操作GDI+图像
  i: Integer;

  graphics_form: IGPGraphics;
  tmp:TBitmap;
  tmpg:TGPBitmap;

  st,sl:Integer;

begin
  //---------------------开始：初始化操作--------------------------------------

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

  graphics.SetSmoothingMode(SmoothingModeAntiAlias); //指定平滑（抗锯齿）
  graphics.SetInterpolationMode(InterpolationModeHighQualityBicubic);//指定的高品质，双三次插值

  pen := TGPPen.Create(MakeColor(155,215,215,215),3);  //颜色、宽度


  //特殊效果//渐变色刷子
  linGrBrush := TGPLinearGradientBrush.Create(MakePoint(0, drawOffTop),    //线性渐变起始点
                                                MakePoint(0, Trunc((fontSize*0.5)) + drawOffTop), //线性渐变终结点
                                                MakeColor(255,255,255,255), //线性渐变起始色
                                                //MakeColor(255,30,120,195)); //线性渐变结束色
                                                MakeColor(255,30,120,195)); //线性渐变结束色,注意第1个参数是 Alpha 通道

  linGrBrush := TGPLinearGradientBrush.Create(MakePoint(0, 0),    //线性渐变起始点
                                                MakePoint(0, 100), //线性渐变终结点

                                                MakeColor(255,0,0,0), //线性渐变起始色

                                                MakeColor(255,30,120,195)); //线性渐变结束色,注意第1个参数是 Alpha 通道

  //---------------------开始：画背景框和背景图---------------------------------- 
  //if bBack then
  if true then
  begin
    //brush := TGPSolidBrush.Create(MakeColor(25,228,228,228));
    brush := TGPSolidBrush.Create(MakeColor(100, 0,0,0));
//    pen1 := TGPPen.Create(MakeColor(155,223,223,223));
//    pen2 := TGPPen.Create(MakeColor(55,223,223,223));
//    image := TGPImage.Create('back.png');             //背景图片
    graphics.FillRectangle(linGrBrush,15,15,100,100);         //填充背景框色//这个会极大的影响性能
//    graphics.FillRectangle(linGrBrush,3,5,750,90);         //填充背景框色//这个会极大的影响性能
//    graphics.DrawRectangle(pen1,2,6,751,91);          //内层背景框
//    graphics.DrawRectangle(pen2,1,5,753,93);          //外层背景框
//    graphics.DrawImage(image,600,25);
  end;

  Draw_bez(graphics);
  Draw_curve(graphics);

  //---------------------开始：更新一个分层的窗口的位置，大小，形状，内容和半透明度---
  //ReleaseDC(Self.Handle,hdcScreen); tmp.Free; Exit;
  tmpg := TGPBitmap.Create(tmp);
  graphics_form.DrawImage(tmpg, 0, 0);//双缓冲

  //---------------------开始：释放和删除--------------------------------------
  ReleaseDC(Self.Handle,hdcScreen);
  //tmpg.Free;//似乎不需要
  tmp.Free;

end;

//from http://www.cnblogs.com/del/archive/2009/12/16/1625966.html
//GdiPlus[33]: 基本绘图与填充命令

//一条 Bezier 线需要四个点: 两个端点、两个控制点
procedure TForm1.Draw_bez(Graphics:IGPGraphics);
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


const
  Pts: array [0..5] of TGPPoint = (
    (X: 10;  Y:  40),
    (X: 100; Y:  60),
    (X: 150; Y:  20),
    (X: 130; Y: 100),
    (X: 70;  Y:  80),
    (X: 30;  Y: 140));

//一条 Bezier 线需要四个点: 两个端点、两个控制点
procedure TForm1.Draw_curve(Graphics:IGPGraphics);
const
  m = 180;
  n = 160;
var
  //Graphics: IGPGraphics;
  Pen: IGPPen;
  BrushBak, Brush: IGPBrush;
begin
  //Graphics := TGPGraphics.Create(Handle);
  Pen := TGPPen.Create($FFFF0000, 2);
  BrushBak := TGPSolidBrush.Create($FFD8BFD8);
  Brush := TGPSolidBrush.Create($FFFFD700);

  with Graphics do
  begin
    FillPolygon(BrushBak, Pts);
    DrawCurve(Pen, Pts);
    TranslateTransform(m, 0);

    FillPolygon(BrushBak, Pts);
    DrawCurve(Pen, Pts, 1.5);
    TranslateTransform(m, 0);

    FillPolygon(BrushBak, Pts);
    DrawCurve(Pen, Pts, 0.5);
    TranslateTransform(m, 0);

    FillPolygon(BrushBak, Pts);
    DrawCurve(Pen, Pts, 0);

    //
    TranslateTransform(-Transform.OffsetX, 150);

    FillPolygon(BrushBak, Pts);
    DrawClosedCurve(Pen, Pts);
    TranslateTransform(m, 0);

    FillPolygon(BrushBak, Pts);
    DrawClosedCurve(Pen, Pts, 1.5);
    TranslateTransform(m, 0);

    FillPolygon(BrushBak, Pts);
    DrawClosedCurve(Pen, Pts, 0.5);
    TranslateTransform(m, 0);

    FillPolygon(BrushBak, Pts);
    DrawClosedCurve(Pen, Pts, 0);

    //
    TranslateTransform(-Transform.OffsetX, n);

    FillPolygon(BrushBak, Pts);
    FillClosedCurve(Brush, Pts);
    DrawClosedCurve(Pen, Pts);
    TranslateTransform(m, 0);

    FillPolygon(BrushBak, Pts);
    FillClosedCurve(Brush, Pts, FillModeAlternate, 1.5);
    DrawClosedCurve(Pen, Pts, 1.5);
    TranslateTransform(m, 0);

    FillPolygon(BrushBak, Pts);
    FillClosedCurve(Brush, Pts, FillModeAlternate, 0.5);
    DrawClosedCurve(Pen, Pts, 0.5);
    TranslateTransform(m, 0);

    FillPolygon(BrushBak, Pts);
    FillClosedCurve(Brush, Pts, FillModeAlternate, 0);
    DrawClosedCurve(Pen, Pts, 0);
  end;
end;


procedure TForm1.FormPaint(Sender: TObject);
begin

  //DrawString('aaa中文');
  DrawString3('aaa中文');

end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  formDraw.show;
end;

end.
