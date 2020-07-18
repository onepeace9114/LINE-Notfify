object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 337
  ClientWidth = 416
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object lbl1: TLabel
    Left = 12
    Top = 129
    Width = 99
    Height = 13
    Caption = 'Message Response :'
  end
  object Label1: TLabel
    Left = 12
    Top = 39
    Width = 38
    Height = 13
    Caption = #3586#3657#3629#3588#3623#3634#3617
  end
  object Label2: TLabel
    Left = 12
    Top = 66
    Width = 32
    Height = 13
    Caption = #3652#3615#3621#3660#3619#3641#3611
  end
  object Label3: TLabel
    Left = 12
    Top = 12
    Width = 29
    Height = 13
    Caption = 'Token'
  end
  object btn1: TButton
    Left = 331
    Top = 101
    Width = 75
    Height = 25
    Caption = 'Send Text'
    Enabled = False
    TabOrder = 0
    OnClick = btn1Click
  end
  object mmo1: TMemo
    Left = 8
    Top = 148
    Width = 398
    Height = 181
    TabOrder = 1
  end
  object edt1: TEdit
    Left = 56
    Top = 35
    Width = 350
    Height = 21
    Font.Charset = THAI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnChange = edtTokenChange
  end
  object edt2: TEdit
    Left = 56
    Top = 62
    Width = 350
    Height = 21
    Font.Charset = THAI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    OnChange = edtTokenChange
  end
  object btn2: TButton
    Left = 250
    Top = 101
    Width = 75
    Height = 25
    Caption = 'Send Image'
    Enabled = False
    TabOrder = 4
    OnClick = btn2Click
  end
  object edtToken: TEdit
    Left = 56
    Top = 8
    Width = 350
    Height = 21
    TabOrder = 5
    OnChange = edtTokenChange
  end
  object RESTClient1: TRESTClient
    Accept = 
      'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8;' +
      'application/json'
    AcceptCharset = 'UTF-8, *;q=0.8'
    BaseURL = 'https://notify-api.line.me/api/notify'
    Params = <
      item
        Kind = pkHTTPHEADER
        name = 'Authorization'
        Options = [poDoNotEncode]
        Value = 'Bearer CFplrSW1511xFumNwW0Ajft3BvuxPixj26ZlW3rKe86'
      end
      item
        name = 'message'
        Value = #3607#3604#3626#3629#3618
      end>
    HandleRedirects = True
    Left = 284
    Top = 240
  end
  object RESTRequest1: TRESTRequest
    Client = RESTClient1
    Method = rmPOST
    Params = <>
    Response = RESTResponse1
    OnAfterExecute = RESTRequest1AfterExecute
    SynchronizedEvents = False
    OnHTTPProtocolError = RESTRequest1HTTPProtocolError
    Left = 196
    Top = 244
  end
  object RESTResponse1: TRESTResponse
    Left = 92
    Top = 248
  end
end
