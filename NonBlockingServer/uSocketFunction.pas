unit uSocketFunction;

//��� delphi �����ص�� socket ������װ

interface

uses
  Windows, WinSock, SysUtils;

function SetNoBlock(so: TSocket):Boolean;
//�����˿�//�򻯽ӿ�,������ʼ�������ʹ��� socket
function ListenPort(var Listensc:TSocket; port:Integer):Boolean;
//����һ������
function AcceptSocket(Listensc:TSocket; var Acceptsc:TSocket):Boolean;

//���Ժ���
function _send(s: TSocket; buf:AnsiString; len, flags: Integer): Integer;
//���Ժ���
function _recv(s: TSocket; var buf:AnsiString; len, flags: Integer): Integer;


implementation

var
  g_InitSocket:Boolean = False;

//��ʼ�� socket ����
procedure InitSock;
var
  wsData: TWSAData;
begin
  if WSAStartUp($202, wsData) <> 0 then
  begin
      WSACleanup();
  end;

end;


//���� socket
function CreateSocket: TSocket;
var
  errno:Integer;
  err: string;

begin
  Result := socket(AF_INET, SOCK_STREAM, IPPROTO_IP);//һ���ͻ��� tcp socket

  if SOCKET_ERROR = Result then
  begin
    errno := WSAGetLastError;
    err := SysErrorMessage(errno);
    //Result := False;//��һ��,�п����Ƿ����� socket δ���������//10035(WSAEWOULDBLOCK) ʱ
    //Exit;

    //δ���� TThreadSafeSocket.InitSocket;
  end;
end;


//�����˿�//�򻯽ӿ�,������ʼ�������ʹ��� socket
function ListenPort(var Listensc:TSocket; port:Integer):Boolean;
var
  sto:sockaddr_in;
begin
  Result := False;

  if g_InitSocket = False then InitSock();

  //����һ���׽��֣������׽��ֺ�һ���˿ڰ󶨲������˶˿ڡ�
  Listensc := CreateSocket();//Socket(AF_INET,SOCK_STREAM,0,Nil,0,WSA_FLAG_OVERLAPPED);
  if Listensc=SOCKET_ERROR then
  begin
    closesocket(Listensc);
    //WSACleanup();
    Exit;
  end;

  sto.sin_family:=AF_INET;
  sto.sin_port := htons(port);//htons(5500);
  sto.sin_addr.s_addr:=htonl(INADDR_ANY);

  if WinSock.bind(Listensc, sto, sizeof(sto))=SOCKET_ERROR then //���������������ĳЩ winsocket2 ���ǲ�ͬ��
  begin
    closesocket(Listensc);
    Exit;
  end;

  //listen(Listensc,20);         SOMAXCONN
  //listen(Listensc, SOMAXCONN);
  //listen(Listensc, $7fffffff);//WinSock2.SOMAXCONN);
  listen(Listensc, 1);//WinSock2.SOMAXCONN);// 2015/4/3 15:03:26 ̫��Ļ���ʵҲ���������,�ᵼ�³���ֹͣ��Ӧʱ�ͻ�����Ȼ����������,���Ҵ�����ռ��

  Result := True;
end;

//����һ������
function AcceptSocket(Listensc:TSocket; var Acceptsc:TSocket):Boolean;
begin
  Result := False;

  Acceptsc := Accept(Listensc, nil, nil);

  //�ж�Acceptsc�׽��ִ����Ƿ�ɹ���������ɹ����˳���
 if (Acceptsc= SOCKET_ERROR) then Exit;


  Result := True;
end;



function SetNoBlock(so: TSocket):Boolean;
var
  errno:Integer;
  err: string;
  arg:Integer;
begin
  Result := True;
  //--------------------------------------------------

  //���ȣ�����ͨѶΪ������ģʽ
  arg := 1;
  ioctlsocket(so, FIONBIO, arg);

  //if SOCKET_ERROR = Connect(so, addr, Sizeof(TSockAddrIn)) then
  begin
    errno := WSAGetLastError;
    err := SysErrorMessage(errno);
    //Result := False;//��һ��,�п����Ƿ����� socket δ���������//10035(WSAEWOULDBLOCK) ʱ
    //Exit;

    if errno <> WSAEWOULDBLOCK then //WSAEISCONN(10056) The socket is already connected
    begin
      //��ε��Զ��Ƿ��� WSAEWOULDBLOCK �Ķ�,���������Ŀ����Ժ�С
      Result := False;
      Exit;
    end;

  end;

end;


//send ������ delphi ���Է�װ,��ΪĳЩ delphi send ��������Ϊ var ���ʹ�� string ʵ�����ǻ�����,����Ҫȡ string ��ʵ�ʵ�ַ
//�����������,ֱ�Ӱ� string �����ݷŵ�һ�� ansichar ����Ҳ��
//d7  WinSock.pas  ��ԭ����Ϊ  function send(s: TSocket; var Buf; len, flags: Integer): Integer; stdcall;
function _send(s: TSocket; buf:AnsiString; len, flags: Integer): Integer;
begin
  //ע��,������ǲ��Ե�,��Ȼ�ܱ���//Result := send(s, buf, len, flags);
  //���� delphi �����Լ� string ������ɵ��ر��﷨,���ù���
  Result := send(s, (@buf[1])^, len, flags);
end;

//�����ַ�Ӧ��ʽ�����ĺ���
function _recv(s: TSocket; var buf:AnsiString; len, flags: Integer): Integer;
//d7  WinSock.pas  ��ԭ����Ϊ  function recv(s: TSocket; var Buf; len, flags: Integer): Integer; stdcall;
begin
  SetLength(buf, len);
  FillChar((@buf[1])^, len, 0);

  //Ӧ��Ҳ�ǲ��������õ�//Result :=recv(s, buf, len, flags);
  //���� delphi �����Լ� string ������ɵ��ر��﷨,���ù���
  Result :=recv(s, (@buf[1])^, len, flags);
end;



end.
