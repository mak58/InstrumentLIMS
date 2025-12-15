unit main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  Vcl.Controls, Vcl.Forms, Vcl.StdCtrls, IdBaseComponent, IdComponent,
  IdCustomTCPServer, IdTCPServer, IdContext,
  System.Generics.Collections;

type
  TForm1 = class(TForm)
    btn1: TButton;
    tcpServer: TIdTCPServer;
    mmoLog: TMemo;
    lbl1: TLabel;
    btn2: TButton;
    procedure btn1Click(Sender: TObject);
    procedure tcpServerExecute(AContext: TIdContext);
    procedure tcpServerConnect(AContext: TIdContext);
    procedure tcpServerDisconnect(AContext: TIdContext);
    procedure btn2Click(Sender: TObject);
  private
    procedure Log(const S: string);
  public
  end;

  TResponseMachine = record
    Exam: string;
    Instrument: string;
    Value: string;
  end;

const
   TListResponse: array [0..1] of TResponseMachine = (
     (Exam: 'Glucose';
      Instrument: 'AMS_TCP';
      Value:' 0|1|25140008|^1003^|^^^*****|R||20161023105715|20161023103519|||||||SERUM|||CHIM|ARCH|Lab1|251400||||F||||Lab2'),
     (Exam: 'Urea';
      Instrument: 'IRIS';
      Value:' R|1|^^^BENZ^Benz^1:10^^^ABC1234^^NM|7.273|mmol/1|0 - 5|1|H|F||Val.autom.^Admin^FSE|20161023105715|20161023103519^20161023105715|Architecht^^C168976^Z0011^3')
     );

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btn1Click(Sender: TObject);
begin
  tcpServer.DefaultPort := 9000;
  tcpServer.Active := True;
  Log('Servidor iniciado na porta 9000...');
end;

procedure TForm1.btn2Click(Sender: TObject);
begin
  tcpServer.Active := False;
  Log('Server Finalized');
end;

procedure TForm1.Log(const S: string);
begin
  TThread.Synchronize(nil,
    procedure begin
      mmoLog.Lines.Add(TimeToStr(Now) + ' - ' + S);
    end);
end;

procedure TForm1.tcpServerConnect(AContext: TIdContext);
begin
  Log('Cliente conectado: ' + AContext.Binding.PeerIP);
end;

procedure TForm1.tcpServerDisconnect(AContext: TIdContext);
begin
  Log('Cliente desconectado.');
end;

procedure TForm1.tcpServerExecute(AContext: TIdContext);
var
  Cmd: string;
begin
  Cmd := AContext.Connection.IOHandler.ReadLn;
  Log('Recebido do cliente: ' + Cmd);

  // Simula instrumento lento
  Log('Simulando processamento de 10 minutos...');
  Sleep(10 * 1000);

  AContext.Connection.IOHandler.WriteLn('OK - Resposta após 10 minutos');
  Log('Resposta enviada.');
end;

end.


