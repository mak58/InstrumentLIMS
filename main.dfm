object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Iris Instrument'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object lbl1: TLabel
    Left = 232
    Top = 24
    Width = 121
    Height = 15
    Caption = 'Iris Glucose Instrument'
  end
  object btn1: TButton
    Left = 24
    Top = 56
    Width = 113
    Height = 25
    Caption = 'Start Instrument'
    TabOrder = 0
    OnClick = btn1Click
  end
  object mmoLog: TMemo
    Left = 16
    Top = 136
    Width = 577
    Height = 281
    Lines.Strings = (
      '')
    TabOrder = 1
  end
  object btn2: TButton
    Left = 152
    Top = 56
    Width = 113
    Height = 25
    Caption = 'Finalize Instrument'
    TabOrder = 2
    OnClick = btn2Click
  end
  object tcpServer: TIdTCPServer
    Bindings = <>
    DefaultPort = 0
    OnConnect = tcpServerConnect
    OnDisconnect = tcpServerDisconnect
    OnExecute = tcpServerExecute
    Left = 584
    Top = 8
  end
end
