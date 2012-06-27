object FormCaptcha: TFormCaptcha
  Left = 501
  Top = 257
  BorderStyle = bsSizeToolWin
  Caption = '..::PROG0040::..'
  ClientHeight = 203
  ClientWidth = 280
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object capcha: TcxTabControl
    Left = 0
    Top = 0
    Width = 280
    Height = 206
    Align = alTop
    TabOrder = 0
    ExplicitLeft = 108
    ExplicitTop = 71
    ExplicitWidth = 289
    ClientRectBottom = 201
    ClientRectLeft = 2
    ClientRectRight = 275
    ClientRectTop = 2
    object cxGroupBox3: TcxGroupBox
      Left = 2
      Top = 2
      Align = alClient
      Caption = 'Informe as Letras Abraixo'
      TabOrder = 0
      ExplicitWidth = 282
      Height = 199
      Width = 273
      object imgCaptcha: TImage
        Left = 42
        Top = 20
        Width = 193
        Height = 81
        Center = True
        Stretch = True
      end
      object edCaptcha: TcxTextEdit
        Left = 63
        Top = 112
        BeepOnEnter = False
        ParentFont = False
        Properties.Alignment.Horz = taCenter
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -17
        Style.Font.Name = 'Tahoma'
        Style.Font.Style = [fsBold]
        Style.IsFontAssigned = True
        TabOrder = 0
        Width = 158
      end
      object cxTabControl3: TcxTabControl
        Left = 3
        Top = 150
        Width = 267
        Height = 39
        Align = alBottom
        TabOrder = 1
        ExplicitWidth = 276
        ClientRectBottom = 34
        ClientRectLeft = 2
        ClientRectRight = 262
        ClientRectTop = 2
        object cxButton1: TcxButton
          Left = 86
          Top = 6
          Width = 75
          Height = 25
          Caption = 'Consultar'
          TabOrder = 0
          OnClick = cxButton1Click
        end
        object cxButton2: TcxButton
          Left = 6
          Top = 6
          Width = 75
          Height = 25
          Caption = 'Imagem'
          TabOrder = 1
          OnClick = cxButton2Click
        end
        object cxButton4: TcxButton
          Left = 182
          Top = 6
          Width = 75
          Height = 25
          Caption = 'Sair'
          TabOrder = 2
          OnClick = cxButton4Click
        end
      end
    end
  end
  object wbChromium: TChromium
    Left = 281
    Top = 29
    Width = 43
    Height = 124
    TabOrder = 1
    Visible = False
    OnLoadEnd = wbChromiumLoadEnd
  end
end
