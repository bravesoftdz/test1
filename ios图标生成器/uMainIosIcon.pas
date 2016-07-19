unit uMainIosIcon;

//Icon-60@2x.png �ƺ��� Icon-120.png  Ч����һ����

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  pngimage, IGDIPlus, jpeg,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls;

type
  TfrmMainIosIcon = class(TForm)
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Panel2: TPanel;
    Label15: TLabel;
    Panel3: TPanel;
    Label16: TLabel;
    ScrollBox1: TScrollBox;
    GroupBox1: TGroupBox;
    icon57: TImage;
    Label3: TLabel;
    Label13: TLabel;
    icon72: TImage;
    GroupBox2: TGroupBox;
    Label6: TLabel;
    icon114: TImage;
    icon144: TImage;
    Label14: TLabel;
    GroupBox3: TGroupBox;
    icon120: TImage;
    Label7: TLabel;
    icon76: TImage;
    Label8: TLabel;
    icon152: TImage;
    Label9: TLabel;
    GroupBox4: TGroupBox;
    icon1024: TImage;
    Label2: TLabel;
    icon_src: TImage;
    Button1: TButton;
    btnConvert: TButton;
    Button2: TButton;
    chk1024: TCheckBox;
    GroupBox5: TGroupBox;
    icon180: TImage;
    Label10: TLabel;
    ScrollBox2: TScrollBox;
    GroupBox6: TGroupBox;
    Default_640x960: TImage;
    Label1: TLabel;
    Label19: TLabel;
    Default_320x480: TImage;
    GroupBox9: TGroupBox;
    Default_640x1136: TImage;
    Label25: TLabel;
    startImage_bk: TImage;
    Button3: TButton;
    btnConvert_bk: TButton;
    Button5: TButton;
    CheckBox1: TCheckBox;
    Label4: TLabel;
    GroupBox7: TGroupBox;
    Image1: TImage;
    Label5: TLabel;
    Label11: TLabel;
    Image2: TImage;
    startImage_icon: TImage;
    Label12: TLabel;
    Label17: TLabel;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    GroupBox8: TGroupBox;
    icon29: TImage;
    Label18: TLabel;
    Label20: TLabel;
    icon58: TImage;
    Label21: TLabel;
    icon80: TImage;
    GroupBox10: TGroupBox;
    load_view_bg_750x1270: TImage;
    Label22: TLabel;
    Label23: TLabel;
    login_bg_750x1270: TImage;
    TabSheet3: TTabSheet;
    png_alpha: TImage;
    png_alpha_dest: TImage;
    Button4: TButton;
    Button9: TButton;
    Button10: TButton;
    txtWidth: TEdit;
    Label24: TLabel;
    Label26: TLabel;
    txtHeight: TEdit;
    TabSheet4: TTabSheet;
    Panel1: TPanel;
    Label27: TLabel;
    ScrollBox3: TScrollBox;
    GroupBox14: TGroupBox;
    xe10_iphone: TImage;
    Label35: TLabel;
    Image11: TImage;
    Button11: TButton;
    Button12: TButton;
    Button13: TButton;
    GroupBox11: TGroupBox;
    xe10_ipad: TImage;
    Label28: TLabel;
    Image4: TImage;
    Button14: TButton;
    Button15: TButton;
    Button16: TButton;
    procedure Button1Click(Sender: TObject);
    procedure icon1024Click(Sender: TObject);
    procedure btnConvertClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure btnConvert_bkClick(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
  private
    procedure SavePng(image: TImage; fn: string);
    procedure CreateXE10LaunchImage;
    procedure CreateXE10LaunchImage_ipad;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMainIosIcon: TfrmMainIosIcon;

//TImage ת��Ϊ TGPImage //��Ϊ��ʱ������� alpha ͨ��ֻ���ȴ�Ϊ�ļ�
//function TImage2TGPImage_v3(Asrc:TImage):TGPImage;
function TImage2TGPImage_Alpha(Asrc:TImage):TGPImage;  

implementation

uses uFormImageNormal;

{$R *.dfm}

//�� alpha ������,��Ϊ gdi+ �� pngimage �ĸ��ƺ�Ŀǰ������͸������ֻ�����ļ�����ת���� pngimage ��
procedure ImageResize_Alpha(src,dest:string; const des_width:Integer; const des_height:Integer);
//const
//  Path1 = 'C:\Temp\Test.png';
//  Path2 = 'C:\Temp\Test2.png';
var
  Img1,Img2: IGPImage;
  Graphics: IGPGraphics;
begin
  //��ԭͼƬ
  Img1 := TGPImage.Create(src);

  //��һ����ͼƬ, ��������Сһ��
  //Img2 := TGPBitmap.Create(Img1.Width div 2, Img1.Height div 2, PixelFormat32bppARGB);
  Img2 := TGPBitmap.Create(des_width, des_height, PixelFormat32bppARGB); //���һ��������͸����˵����Ҫ

  //��ȡ��ͼƬ�Ļ�ͼ����
  Graphics := TGPGraphics.Create(Img2);

  //������������Ϊ�������
  Graphics.InterpolationMode := InterpolationModeHighQualityBicubic;

  //������
  Graphics.DrawImage(Img1, 0, 0, Img2.Width, Img2.Height);

  //����
  Img2.Save(dest, ImageFormatPNG);
end;

//gdi+ ���������ŵ��㷨1
procedure ImageResize_gdiplus1(Asrc:TImage; Ades:TImage; const des_width:Integer; const des_height:Integer);
var
  g: IGPGraphics;     //��װһ�� GDI+ ��ͼͼ��
  gout: IGPGraphics;
  //gout:TGPImage;
  Bitmap: TBitmap;
  bmpout: TBitmap;

  bmpsrc:TGPBitmap;
begin

	Bitmap := TBitmap.Create;
  bmpout := TBitmap.Create;
	try
	  Bitmap.Width := Asrc.Picture.Width;
	  Bitmap.Height := Asrc.Picture.Height;

	  bmpout.Width := des_width;//57;//Asrc.Picture.Width * 0.5;
	  bmpout.Height := des_height;//57;//Asrc.Picture.Height * 0.5;


	  //Bitmap.Assign(Asrc.Picture);
    Bitmap.Canvas.Draw(0,0, Asrc.Picture.Graphic);


  //--------------------------------------------------
  //��� gdi+ ʵ��Ҫ��ת���� bmp

  //graphic := TGPGraphics.Create(Asrc.Canvas);
  g := TGPGraphics.Create(Bitmap.Canvas);
  g.SetInterpolationMode(InterpolationModeDefault);

  //gout := TGPImage

  //g.ScaleTransform()
  bmpsrc := TGPBitmap.Create(Bitmap);


  gout := TGPGraphics.Create(bmpout.Canvas);
  //gout.SetInterpolationMode(InterpolationModeDefault); //windows 2003 ��Ĭ�ϵ�Ч���ܲ�//no
  //gout.SetInterpolationMode(InterpolationModeHighQualityBilinear); //ָ��������˫���Բ�ֵ�� //ok
  gout.SetInterpolationMode(InterpolationModeHighQualityBicubic); //ok//ָ��������˫���β�ֵ�� //InterpolationModeHighQualityBicubic���Ч��

  // Status Graphics::SetInterpolationMode(IN InterpolationMode interpolationMode)
  //
  // enum InterpolationMode
  // {
  // InterpolationModeInvalid = QualityModeInvalid, //��ֵ��Ч
  // InterpolationModeDefault = QualityModeDefault, //ָ��Ĭ��ģʽ
  // InterpolationModeLowQuality = QualityModeLow, //ָ����������ֵ��
  // InterpolationModeHighQuality = QualityModeHigh, //ָ����������ֵ��
  // InterpolationModeBilinear, //ָ��˫���Բ�ֵ��
  // InterpolationModeBicubic, //ָ��˫���β�ֵ��
  // InterpolationModeNearestNeighbor, //ָ�����ٽ���ֵ��
  // InterpolationModeHighQualityBilinear, //ָ��������˫���Բ�ֵ��
  // InterpolationModeHighQualityBicubic //ָ��������˫���β�ֵ�� //InterpolationModeHighQualityBicubic���Ч������Ȼ��ϵͳ��Դ������Ҳ���
  // };


  //g.DrawImage(img, rt, 0, 0, img.GetWidth, img.GetHeight, UnitPixel);
  //gout.DrawImage(g, rt, 0, 0, gout.GetWidth, gout.GetHeight, UnitPixel);
  //gout.DrawImage(g, 0, 0, bmpout.Width, bmpout.Height);
  gout.DrawImage(bmpsrc, 0, 0, bmpout.Width, bmpout.Height);

  Ades.Picture.Assign(bmpout);

  //--------------------------------------------------
	finally
	  Bitmap.Free;
    bmpout.Free;
	end;
end;

//gdi+ ���������ŵ��㷨,�� alpha ͨ��//Ŀǰ delphi7 �� gdiplus ��alpha ��ͨ��,����ֻ��ͨ����ʱ�ļ�����ʽ
procedure ImageResize_gdiplus_alpha1(Asrc:TImage; Ades:TImage; const des_width:Integer; const des_height:Integer);
var
  tmpfn:string;

  Img1,Img2: IGPImage;
  Graphics: IGPGraphics;

const
  GDIImageFormatBMP:  TGUID = '{557CF400-1A04-11D3-9A73-0000F81EF32E}';
  GDIImageFormatJPG:  TGUID = '{557CF401-1A04-11D3-9A73-0000F81EF32E}';
  GDIImageFormatGIF:  TGUID = '{557CF402-1A04-11D3-9A73-0000F81EF32E}';
  GDIImageFormatEMF:  TGUID = '{557CF403-1A04-11D3-9A73-0000F81EF32E}';
  GDIImageFormatWMF:  TGUID = '{557CF404-1A04-11D3-9A73-0000F81EF32E}';
  GDIImageFormatTIFF: TGUID = '{557CF405-1A04-11D3-9A73-0000F81EF32E}';
  GDIImageFormatPNG:  TGUID = '{557CF406-1A04-11D3-9A73-0000F81EF32E}';
  GDIImageFormatICO:  TGUID = '{557CF407-1A04-11D3-9A73-0000F81EF32E}';

begin
  //��ԭͼƬ
  //Img1 := TGPImage.Create(src);
  Img1 := TImage2TGPImage_Alpha(Asrc);

  //��һ����ͼƬ, ��������Сһ��
  //Img2 := TGPBitmap.Create(Img1.Width div 2, Img1.Height div 2, PixelFormat32bppARGB);
  Img2 := TGPBitmap.Create(des_width, des_height, PixelFormat32bppARGB); //���һ��������͸����˵����Ҫ

  //��ȡ��ͼƬ�Ļ�ͼ����
  Graphics := TGPGraphics.Create(Img2);

  //������������Ϊ�������
  Graphics.InterpolationMode := InterpolationModeHighQualityBicubic;

  //������
  Graphics.DrawImage(Img1, 0, 0, Img2.Width, Img2.Height);

  Img1 := nil; //������ tmpfn ���ļ������ٴβ���

  //����
  tmpfn := ExtractFilePath(Application.ExeName) + 'tmp.png';
  //Img2.Save(tmpfn, ImageFormatPNG);
  Img2.Save(tmpfn, GDIImageFormatPNG);

  Ades.Picture.LoadFromFile(tmpfn);

end;

procedure TfrmMainIosIcon.Button1Click(Sender: TObject);
var
  fn:string;
begin
  if not OpenDialog1.Execute then Exit;

  fn := OpenDialog1.FileName;

  icon1024.Picture.LoadFromFile(fn);
end;

procedure TfrmMainIosIcon.icon1024Click(Sender: TObject);
begin
  if frmImageNormal=nil then frmImageNormal := TfrmImageNormal.Create(Application);

  frmImageNormal.Image_src.Picture.Assign((Sender as TImage).Picture);
  frmImageNormal.Caption := 'ԭʼͼƬ ' + IntToStr(frmImageNormal.Image_src.Picture.Width) + 'x' + IntToStr(frmImageNormal.Image_src.Picture.Height);
  frmImageNormal.ShowModal;
end;

procedure TfrmMainIosIcon.btnConvertClick(Sender: TObject);
begin
  ImageResize_gdiplus1(icon1024, icon57, 57, 57);
  ImageResize_gdiplus1(icon1024, icon72, 72, 72);
  ImageResize_gdiplus1(icon1024, icon114, 114, 114);
  ImageResize_gdiplus1(icon1024, icon144, 144, 144);
  ImageResize_gdiplus1(icon1024, icon120, 120, 120);
  ImageResize_gdiplus1(icon1024, icon76, 76, 76);
  ImageResize_gdiplus1(icon1024, icon152, 152, 152);
  ImageResize_gdiplus1(icon1024, icon180, 180, 180);

  ImageResize_gdiplus1(icon1024, icon80, 80, 80);
  ImageResize_gdiplus1(icon1024, icon29, 29, 29);
  ImageResize_gdiplus1(icon1024, icon58, 58, 58);
end;

procedure TfrmMainIosIcon.Button2Click(Sender: TObject);
begin
  if not SaveDialog1.Execute then Exit;

  SavePng(icon57, 'Icon.png');
  SavePng(icon72, 'Icon-72.png');
  SavePng(icon114, 'Icon@2x.png');
  SavePng(icon144, 'Icon-72@2x.png');
  SavePng(icon120, 'Icon-120.png');
  SavePng(icon76, 'Icon-76.png');
  SavePng(icon152, 'Icon-152.png');
  SavePng(icon180, 'Icon-60@3x.png'); SavePng(icon180, 'Icon-180.png'); //�ظ��ߴ����������?//Ӧ�ò��Ǳ�Ҫ��,ԭ��Ŀ��

  SavePng(icon80, 'Icon-80.png');//Spotlight ԭ��Ŀ��//Ӧ�ò��Ǳ�Ҫ��
  SavePng(icon29, 'Icon-small.png');//Spotlight ԭ��Ŀ��//Ӧ�ò��Ǳ�Ҫ��
  SavePng(icon58, 'Icon-small@2x.png');//Spotlight ԭ��Ŀ��//Ӧ�ò��Ǳ�Ҫ��


end;

procedure TfrmMainIosIcon.SavePng(image:TImage; fn:string);
var
  path:string;
  png:TPngObject;
begin

  path := ExtractFilePath(SaveDialog1.FileName);
  fn := path + fn;

  png := TPngObject.Create;
  png.Assign(image.Picture.Graphic);

  //icon57.Picture.SaveToFile(fn); //���������������Ȼ�� bmp ҪΪ png �Ļ���Ҫת

  png.SaveToFile(fn);

  png.Free;

end;

procedure TfrmMainIosIcon.Button3Click(Sender: TObject);
var
  fn:string;
begin
  if not OpenDialog1.Execute then Exit;

  fn := OpenDialog1.FileName;

  startImage_bk.Picture.LoadFromFile(fn);
end;

procedure TfrmMainIosIcon.Button6Click(Sender: TObject);
var
  fn:string;
begin
  if not OpenDialog1.Execute then Exit;

  fn := OpenDialog1.FileName;

  startImage_icon.Picture.LoadFromFile(fn);
end;

//TImage ת��Ϊ TGPImage ,��ΪĬ�ϵ�ֻ֧�� bmp ��ʽ
function TImage2TGPImage(Asrc:TImage):TGPImage;
var
  //g: IGPGraphics;     //��װһ�� GDI+ ��ͼͼ��
  //gout:TGPImage;
  Bitmap: TBitmap;

  bmpsrc:TGPBitmap;
  img:TGPImage;

  Graphic:TGPGraphics;
  b:TGPSolidBrush;
  i:Integer;
  //c:TAlphaColor;
begin

	Bitmap := TBitmap.Create;

	try
	  Bitmap.Width := Asrc.Picture.Width;
	  Bitmap.Height := Asrc.Picture.Height;

    Bitmap.PixelFormat := pf32bit;

    //Bitmap.ScanLine := ;TAlphaColor
    FillChar(Bitmap.ScanLine[0]^, 1024, 1);
    FillChar(Bitmap.ScanLine[1]^, 1024, 1);
    FillChar(Bitmap.ScanLine[2]^, 1024, 1);

    for i := 0 to 100 do
    begin
      FillChar(Bitmap.ScanLine[i]^, 1024, 100);
    end;


//    Bitmap.Canvas.Brush.Color := clRed;
//    Bitmap.Canvas.FillRect(Rect(0, 0, Bitmap.Width, Bitmap.Height));

	  //Bitmap.Assign(Asrc.Picture);
//    Bitmap.Canvas.Draw(0,0, Asrc.Picture.Graphic);

    //--------------------------------------------------

//      Graphic := TGPGraphics.Create(Bitmap2.Canvas.Handle);
//  Graphic.SetInterpolationMode(InterpolationModeHighQualityBicubic);  // bicubic resample
//  Graphic.DrawImage(Bitmap1, 0, 0, Bitmap2.Width, Bitmap2.Height);
//  Bitmap2.SaveToFile('test_resized.bmp');

    img := TGpBitmap.Create(Bitmap);
//    img := TGpBitmap.Create(Asrc.Picture.Bitmap);

    //b := TGPSolidBrush.Create(ColorRefToARGB(FColorOfLable));
    //b := TGPSolidBrush.Create(ColorRefToARGB(FColorOfLable));

//    img := TGpBitmap.Create(Asrc.Picture.Bitmap);

    Result := img;
    //--------------------------------------------------
	finally
	  //Bitmap.Free;
	end;
end;

//TImage ת��Ϊ TGPImage //��Ϊ��ʱ������� alpha ͨ��ֻ���ȴ�Ϊ�ļ�
//function TImage2TGPImage_v3(Asrc:TImage):TGPImage;
function TImage2TGPImage_Alpha(Asrc:TImage):TGPImage;
var
  //g: IGPGraphics;     //��װһ�� GDI+ ��ͼͼ��
  //gout:TGPImage;
  Bitmap: TBitmap;

  bmpsrc:TGPBitmap;
  img:TGPImage;

  Graphic:TGPGraphics;
  b:TGPSolidBrush;
  i:Integer;
  //c:TAlphaColor;
  tmpfn:string;
  tmp:TGPImage;
begin
  tmpfn := ExtractFilePath(Application.ExeName) + 'tmp.png';

  Asrc.Picture.SaveToFile(tmpfn);

  Result := TGPImage.Create(tmpfn);   //�����и�����,���ɵ� IGPImage Ҫ����Ϊ nil ������ٴβ��� tmp.png �ļ�
  //tmp := TGPImage.Create(tmpfn);

  //Result := tmp.Clone;

  //tmp.Free;
end;

{
// GDI+��ͼ����ת��
procedure TForm1.Button1Click(Sender: TObject);
var
  Png: TGpBitmap;
  Jpg: TGpBitmap;
  g: TGpGraphics;
begin
  Png := TGpBitmap.Create('d:\xmas_011.png');
  Jpg := TGpBitmap.Create(Png.Width, Png.Height, pf24bppRGB);
  g := TGpGraphics.Create(Jpg);
  g.Clear($FFFFFFFF);  // ��ɫ����
  g.DrawImage(Png, 0, 0, Png.Width, png.Height);
  g.Free;
  SaveJpg(Jpg, 'd:\1.jpg', 95); // ����ͼƬ������Ϊ95
  Jpg.Free;
  Png.Free;
end;
}

Procedure PrepareBMP(bmp: TBitmap; Width, Height: Integer);
var
  p: Pointer;
begin
  bmp.PixelFormat := pf32Bit;
  bmp.Width := Width;
  bmp.Height := Height;
  bmp.HandleType := bmDIB;
  bmp.ignorepalette := true;
//  bmp.alphaformat := afPremultiplied; //delphi7 û�����
//--------------------------------------------------
//4. ����͸����ͼƬ����
//delphi7��ֻ����24bit��ͼƬ����û��alphaͨ����ͼƬ����Ҫ����͸����ֻ��TImage.Transparent := True;
//delphi2010�Ϳ���֧��32bit��ͼƬ�ˣ�����alphaͨ��Image3.Transparent := False;
// Image3.Picture.Bitmap.AlphaFormat := afPremultiplied;
//--------------------------------------------------

  // clear all Scanlines
  p := bmp.ScanLine[Height - 1];
  ZeroMemory(p, Width * Height * 4);
end;

function TImage2TGPImage_v2(Asrc:TImage):TGPImage;
var
  //Png: TGpBitmap;
  Jpg: TGpBitmap;
  g: TGpGraphics;
  Bitmap:TBitmap;
begin

    Bitmap := TBitmap.Create;
	  Bitmap.Width := Asrc.Picture.Width;
	  Bitmap.Height := Asrc.Picture.Height;

    Bitmap.PixelFormat := pf32bit;
    PrepareBMP(Bitmap, Bitmap.Width, Bitmap.Height);

    g := TGPGraphics.Create(Bitmap.Canvas);
    g.Clear(111);


	  //Bitmap.Assign(Asrc.Picture);
    Bitmap.Canvas.Draw(0,0, Asrc.Picture.Graphic);

//    g := TGPGraphics.Create(Bitmap.Canvas);
    g := TGPGraphics.Create(Asrc.Picture.Bitmap.Canvas);
    //g.Clear(111); Exit;

    Result := TGpBitmap.Create(Bitmap); Exit;

  //--------------------------------------------------

  //Png := TGpBitmap.Create('d:\xmas_011.png');
  //Jpg := TGpBitmap.Create(Png.Width, Png.Height, pf24bppRGB);

  Jpg := TGpBitmap.Create(Asrc.Picture.Width, Asrc.Picture.Height, PixelFormat32bppARGB);
  //Jpg := TGpBitmap.Create(100, 100, PixelFormat32bppARGB);

  g := TGpGraphics.Create(Jpg);
//  g.Clear($FFFFFFFF);  // ��ɫ����//clq ��������ؼ�������
  //g.DrawImage(Png, 0, 0, Png.Width, png.Height);
  
//  g.Free;
  //SaveJpg(Jpg, 'd:\1.jpg', 95); // ����ͼƬ������Ϊ95
  //Jpg.Free;
  //Png.Free;

  Result := Jpg;

//  Result := TGpBitmap.Create(Asrc.Picture.Bitmap);

//  Jpg.GetHBITMAP()


end;


//�ϳ�����ͼ
//gdi+ ���������ŵ��㷨1//Aico ��Ҫ�����������ͼƬ
procedure ImageComposite_gdiplus1(Asrc:TImage; Ades:TImage; Aicon:TImage);
var
  g: IGPGraphics;     //��װһ�� GDI+ ��ͼͼ��
  //gout:TGPImage;
  Bitmap: TBitmap;

  img:TGPImage;

  i:Integer;
begin

	Bitmap := TBitmap.Create;

	try
	  Bitmap.Width := Asrc.Picture.Width;
	  Bitmap.Height := Asrc.Picture.Height;


    Bitmap.Canvas.Brush.Color := clRed;
    Bitmap.Canvas.FillRect(Rect(0, 0, Bitmap.Width, Bitmap.Height));

	  //Bitmap.Assign(Asrc.Picture);
    Bitmap.Canvas.Draw(0,0, Asrc.Picture.Graphic);
    //Bitmap.Canvas.Draw(0,0, Aicon.Picture.Graphic);

    //--------------------------------------------------
    //��� gdi+ ʵ��Ҫ��ת���� bmp

    if Aicon.Picture.Graphic<>nil then
    begin

    g := TGPGraphics.Create(Bitmap.Canvas);
    g.SetInterpolationMode(InterpolationModeHighQualityBicubic); //ok//ָ��������˫���β�ֵ�� //InterpolationModeHighQualityBicubic���Ч��

    //img:=TGPImage.Create(Aicon.Canvas.handle);
    //img := TGpBitmap.Create(Aicon.Canvas.);

    //bmpsrc := TImage2TGPImage(Aicon);
//    img := TImage2TGPImage(Aicon);
//    img := TImage2TGPImage_v2(Aicon);
    img := TImage2TGPImage_Alpha(Aicon);
//    img := TGpBitmap.Create(100, 100, PixelFormat32bppARGB);//ok

//    gout.DrawImage(bmpsrc, 0, 0, bmpout.Width, bmpout.Height);//���,��������������,�ƺ���һ�κ�������
//    g.DrawImage(bmpsrc, 0, 0, 57, 57);
    g.DrawImage(img, 0, 0, 570, 570); //ȷʵ���Ա���

    end;// if

    //Ades.Picture.Assign(bmpout);
    Ades.Picture.Assign(Bitmap);


    //--------------------------------------------------
	finally
	  Bitmap.Free;
    //img.Free;
	end;
end;

procedure TfrmMainIosIcon.Button7Click(Sender: TObject);
begin
  //�ж���ԭʼͼƬ������ 640x1136 ��,���ǵĻ���ʾ�Ƿ񰴵�ǰͼƬ����һ��
  if (startImage_bk.Picture.Width<>640)or(startImage_bk.Picture.Height<>1136) then
  begin
    if MessageBox(Self.Handle, 'ԭʼͼƬ���� 640x1136 �Ƿ��Ƚ�ԭͼ�Զ�����?', '��ʾ', MB_YESNO) = IDYES
    then ImageResize_gdiplus1(startImage_bk, startImage_bk, 640, 1136);

  end;
    
  ImageComposite_gdiplus1(startImage_bk, Default_640x1136, startImage_icon);
  
end;

procedure TfrmMainIosIcon.Button8Click(Sender: TObject);
var
  bmp: TBitmap;
  G: TGPGRaphics;
  B: TGPSolidBrush;
begin
  bmp := TBitmap.Create;
  try
    PrepareBMP(bmp, 300, 300);
    G := TGPGRaphics.Create(bmp.Canvas.Handle);
    B := TGPSolidBrush.Create(MakeColor(100, 255, 0, 0));
    try
      G.SetSmoothingMode(SmoothingModeHighQuality);
      G.FillEllipse(B, MakeRect(0, 0, 300, 300));
//      B.SetColor(MakeColor(100, 0, 255, 128));
//      G.FillEllipse(B, MakeRect(40, 40, 260, 260));
    finally
//      B.Free;
      G.Free;
    end;
    // draw overlapping in Form Canvas to display transparency
    Canvas.Draw(0, 0, bmp);
    Canvas.Draw(100, 100, bmp);
  finally
    bmp.Free;
  end;
end;

procedure TfrmMainIosIcon.Button5Click(Sender: TObject);
begin
  if not SaveDialog1.Execute then Exit;

  SavePng(Default_640x1136, 'Default-568h@2x.png');
  SavePng(Default_640x960, 'Default@2x.png');
  SavePng(Default_320x480, 'Default.png');

  SavePng(load_view_bg_750x1270, 'load_view_bg.png');
  SavePng(login_bg_750x1270, 'login_bg.png');

  
//  SavePng(icon144, 'Icon-72@2x.png');
//  SavePng(icon120, 'Icon-120.png');
//  SavePng(icon76, 'Icon-76.png');
//  SavePng(icon152, 'Icon-152.png');
//  SavePng(icon180, 'Icon-60@3x.png'); SavePng(icon180, 'Icon-180.png'); //�ظ��ߴ����������?//Ӧ�ò��Ǳ�Ҫ��,ԭ��Ŀ��
//
//  SavePng(icon80, 'Icon-80.png');//Spotlight ԭ��Ŀ��//Ӧ�ò��Ǳ�Ҫ��
//  SavePng(icon29, 'Icon-small.png');//Spotlight ԭ��Ŀ��//Ӧ�ò��Ǳ�Ҫ��
//  SavePng(icon58, 'Icon-small@2x.png');//Spotlight ԭ��Ŀ��//Ӧ�ò��Ǳ�Ҫ��

end;

procedure TfrmMainIosIcon.btnConvert_bkClick(Sender: TObject);
begin

  ImageResize_gdiplus1(Default_640x1136, Default_640x960, 640, 960);
  ImageResize_gdiplus1(Default_640x1136, Default_320x480, 320, 480);

  ImageResize_gdiplus1(Default_640x1136, load_view_bg_750x1270, 750, 1270);
  ImageResize_gdiplus1(Default_640x1136, login_bg_750x1270, 750, 1270);
end;

procedure TfrmMainIosIcon.Button4Click(Sender: TObject);
var
  fn:string;
begin
  if not OpenDialog1.Execute then Exit;

  fn := OpenDialog1.FileName;

  png_alpha.Picture.LoadFromFile(fn);

end;

procedure TfrmMainIosIcon.Button9Click(Sender: TObject);
begin

  ImageResize_gdiplus_alpha1(png_alpha, png_alpha_dest, StrToInt(txtWidth.Text), StrToInt(txtHeight.Text));

end;

procedure TfrmMainIosIcon.Button10Click(Sender: TObject);
begin
  if not SaveDialog1.Execute then Exit;

  SavePng(png_alpha_dest, 'login_icon.png');
end;

procedure TfrmMainIosIcon.Button11Click(Sender: TObject);
var
  fn:string;
begin
  if not OpenDialog1.Execute then Exit;

  fn := OpenDialog1.FileName;

  xe10_iphone.Picture.LoadFromFile(fn);

end;

procedure TfrmMainIosIcon.Button12Click(Sender: TObject);
var
  tmp:TImage;
begin

  if not SaveDialog1.Execute then Exit;

  tmp := TImage.Create(nil);

  ImageResize_gdiplus1(xe10_iphone, tmp, 57, 57);
  SavePng(tmp, 'FM_ApplicationIcon_57x57.png');

  ImageResize_gdiplus1(xe10_iphone, tmp, 60, 60);
  SavePng(tmp, 'FM_ApplicationIcon_60x60.png');

  ImageResize_gdiplus1(xe10_iphone, tmp, 87, 87);
  SavePng(tmp, 'FM_ApplicationIcon_87x87.png');

  ImageResize_gdiplus1(xe10_iphone, tmp, 114, 114);
  SavePng(tmp, 'FM_ApplicationIcon_114x114.png');

  ImageResize_gdiplus1(xe10_iphone, tmp, 120, 120);
  SavePng(tmp, 'FM_ApplicationIcon_120x120.png');

  ImageResize_gdiplus1(xe10_iphone, tmp, 180, 180);
  SavePng(tmp, 'FM_ApplicationIcon_180x180.png');

  //����4������ͼ����ʵҲ�ǳ���ͼ��
  ImageResize_gdiplus1(xe10_iphone, tmp, 29, 29);
  SavePng(tmp, 'FM_SpotlightSearchIcon_29x29.png');

  ImageResize_gdiplus1(xe10_iphone, tmp, 40, 40);
  SavePng(tmp, 'FM_SpotlightSearchIcon_40x40.png');

  ImageResize_gdiplus1(xe10_iphone, tmp, 58, 58);
  SavePng(tmp, 'FM_SpotlightSearchIcon_58x58.png');

  ImageResize_gdiplus1(xe10_iphone, tmp, 80, 80);
  SavePng(tmp, 'FM_SpotlightSearchIcon_80x80.png');


  tmp.Free;

  //�׵׵ļ�������ͼ��
  CreateXE10LaunchImage;
  
end;


//�׵׵ļ�������ͼ��
procedure TfrmMainIosIcon.CreateXE10LaunchImage;
var
  tmp:TImage;
  bmp1:TBitmap;

  procedure ToImg(w,h:Integer;fn:string);
  begin

    bmp1.Width := w; bmp1.Height := h;

    bmp1.Canvas.FillRect(Rect(0,0,w,h));

    //bmp1.Canvas.Draw(0, 0, xe10_iphone.Picture.Graphic);
    //bmp1.Canvas.Draw(w div 2, h div 2, xe10_iphone.Picture.Graphic);
    bmp1.Canvas.Draw((w-xe10_iphone.Picture.Width) div 2, (h-xe10_iphone.Picture.Height) div 2, xe10_iphone.Picture.Graphic);

    tmp.Picture.Bitmap := bmp1;
    SavePng(tmp, fn);
    //--------------------------------------------------
  end;  
begin

  //if not SaveDialog1.Execute then Exit;

  tmp := TImage.Create(nil);
  bmp1 := TBitmap.Create;

  //--------------------------------------------------
  bmp1.Width := 320; bmp1.Height := 480;
  bmp1.Canvas.Draw(0, 0, xe10_iphone.Picture.Graphic);

  tmp.Picture.Bitmap := bmp1;
  SavePng(tmp, 'FM_LaunchImage_320x480.png');
  //--------------------------------------------------

  ToImg(320, 480, 'FM_LaunchImage_320x480.png');
  ToImg(640, 960, 'FM_LaunchImage_640x960.png');
  ToImg(640, 1136, 'FM_LaunchImage_640x1136.png');
  ToImg(750, 1334, 'FM_LaunchImage_750x1334.png');
  ToImg(1242, 2208, 'FM_LaunchImage_1242x2208.png');
  ToImg(2208, 1242, 'FM_LaunchImage_2208x1242.png');

  tmp.Free;
  bmp1.Free;
end;


//�׵׵ļ�������ͼ��
procedure TfrmMainIosIcon.CreateXE10LaunchImage_ipad;
var
  tmp:TImage;
  bmp1:TBitmap;

  procedure ToImg(w,h:Integer;fn:string);
  begin

    bmp1.Width := w; bmp1.Height := h;

    bmp1.Canvas.FillRect(Rect(0,0,w,h));

    //bmp1.Canvas.Draw(0, 0, xe10_iphone.Picture.Graphic);
    //bmp1.Canvas.Draw(w div 2, h div 2, xe10_iphone.Picture.Graphic);
    bmp1.Canvas.Draw((w-xe10_ipad.Picture.Width) div 2, (h-xe10_ipad.Picture.Height) div 2, xe10_ipad.Picture.Graphic);

    tmp.Picture.Bitmap := bmp1;
    SavePng(tmp, fn);
    //--------------------------------------------------
  end;
begin

  //if not SaveDialog1.Execute then Exit;

  tmp := TImage.Create(nil);
  bmp1 := TBitmap.Create;

  //--------------------------------------------------
  ToImg(1024, 748, 'FM_LaunchImageLandscape_1024x748.png');
  ToImg(1024, 768, 'FM_LaunchImageLandscape_1024x768.png');
  ToImg(2048, 1496, 'FM_LaunchImageLandscape_2048x1496.png');
  ToImg(2048, 1536, 'FM_LaunchImageLandscape_2048x1536.png');
  ToImg(768, 1004, 'FM_LaunchImagePortrait_768x1004.png');
  ToImg(768, 1024, 'FM_LaunchImagePortrait_768x1024.png');
  ToImg(1536, 2008, 'FM_LaunchImagePortrait_1536x2008.png');
  ToImg(1536, 2048, 'FM_LaunchImagePortrait_1536x2048.png');

  tmp.Free;
  bmp1.Free;
end;

procedure TfrmMainIosIcon.Button14Click(Sender: TObject);
var
  fn:string;
begin
  if not OpenDialog1.Execute then Exit;

  fn := OpenDialog1.FileName;

  xe10_ipad.Picture.LoadFromFile(fn);

end;

procedure TfrmMainIosIcon.Button15Click(Sender: TObject);
var
  tmp:TImage;
begin

  if not SaveDialog1.Execute then Exit;

  tmp := TImage.Create(nil);

  ImageResize_gdiplus1(xe10_ipad, tmp, 72, 72);
  SavePng(tmp, 'FM_ApplicationIcon_72x72.png');

  ImageResize_gdiplus1(xe10_ipad, tmp, 76, 76);
  SavePng(tmp, 'FM_ApplicationIcon_76x76.png');

  ImageResize_gdiplus1(xe10_ipad, tmp, 144, 144);
  SavePng(tmp, 'FM_ApplicationIcon_144x144.png');

  ImageResize_gdiplus1(xe10_ipad, tmp, 152, 152);
  SavePng(tmp, 'FM_ApplicationIcon_152x152.png');

  ImageResize_gdiplus1(xe10_ipad, tmp, 29, 39);
  SavePng(tmp, 'FM_SettingIcon_29x29.png');

  ImageResize_gdiplus1(xe10_ipad, tmp, 58, 58);
  SavePng(tmp, 'FM_SettingIcon_58x58.png');


  //����4������ͼ����ʵҲ�ǳ���ͼ��
  ImageResize_gdiplus1(xe10_ipad, tmp, 40, 40);
  SavePng(tmp, 'FM_SpotlightSearchIcon_40x40.png');

  ImageResize_gdiplus1(xe10_ipad, tmp, 50, 50);
  SavePng(tmp, 'FM_SpotlightSearchIcon_50x50.png');

  ImageResize_gdiplus1(xe10_ipad, tmp, 80, 80);
  SavePng(tmp, 'FM_SpotlightSearchIcon_80x80.png');

  ImageResize_gdiplus1(xe10_ipad, tmp, 100, 100);
  SavePng(tmp, 'FM_SpotlightSearchIcon_100x100.png');




  tmp.Free;

  //�׵׵ļ�������ͼ��
  CreateXE10LaunchImage_ipad;

end;

end.
