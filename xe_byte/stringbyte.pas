unit stringbyte;

//System.RawByteString �� AnsiString �����޷��� xe10 ���ֻ�������ʹ�õ�,�����ת�� des �����㷨��Ҫ����ԭʼ�ֽڵĴ���ʱ�͵ò�����ȷ������

interface

uses
  Types;

//��Щ�����ڲ��� xe10 ����Ĭ���ַ���ʱ��Ҫ��ת�� gbk ���� utf8 �ַ���

//���� d7 �µ� pchar �� pbyte (xe10�� pbyte ����ֱ��ʹ��)
function PByte_String(const s:string):PByte;
//���� d7 �µ� Length //����������,�����޸ľɴ���
function Length_String(const s:string):Integer;
//Length_String �ı���,�������
function ByteCount(const s:string):Integer;

implementation

//�Դ˴���Ϊ����
//procedure TForm1.Button1Click(Sender: TObject);
//var
//  s:string;
//  p:PByte;
//  //t:RawByteString;
//begin
//  //ShowMessage(IntToStr(SizeOf(('����'[1]))));  //ȷʵ�������ֽ�һ���ַ�//unicode ��,�����ֻ����� 0 ��ʼ
//  s := '1����123����abc';
//  p := PByte(PChar(s));
//  ShowMessage(IntToStr(p[0])); //ok �ֻ�,pc ��ͨ��
//  ShowMessage(IntToStr(p[1])); //ok �ֻ�,pc ��ͨ��
//end;

//���� d7 �µ� string[i]
function PByte_String(const s:string):PByte;
var
  p:PByte;
begin
  p := PByte(PChar(s));
  //ShowMessage(IntToStr(p[0])); //ok �ֻ�,pc ��ͨ��
  //ShowMessage(IntToStr(p[1])); //ok �ֻ�,pc ��ͨ��

  Result := p;

end;

//���� d7 �µ� Length //����������,�����޸ľɴ���
function Length_String(const s:string):Integer;
begin
  Result := 0;
  if Length(s) = 0 then Exit;

  //ʵ�ʲ���,�ֻ��������� 0 ��ʼ, pc ���� 1 ��ʼ//Result := Length(s) * SizeOf(s[0]);

  Result := Length(s);
{$IFDEF UNICODE}
  Result := Length(s) * 2;
{$ENDIF UNICODE}

end;

//Length_String �ı���,�������
function ByteCount(const s:string):Integer;
begin
  Result := Length_String(s);
end;


end.



