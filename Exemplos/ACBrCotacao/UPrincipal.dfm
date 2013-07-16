object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  Caption = 'ACBrCotacao'
  ClientHeight = 502
  ClientWidth = 696
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 696
    Height = 50
    Align = alTop
    TabOrder = 0
    object btnAtualizarMostrar: TButton
      Left = 13
      Top = 13
      Width = 128
      Height = 25
      Caption = 'Atualizar e mostrar'
      TabOrder = 0
      OnClick = btnAtualizarMostrarClick
    end
    object btnProcurarSimbolo: TButton
      Left = 147
      Top = 13
      Width = 128
      Height = 25
      Caption = 'Procurar por Simbolo'
      TabOrder = 1
      OnClick = btnProcurarSimboloClick
    end
  end
  object ListBox1: TListBox
    Left = 0
    Top = 50
    Width = 696
    Height = 452
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ItemHeight = 14
    ParentFont = False
    TabOrder = 1
    ExplicitLeft = 295
    ExplicitTop = 220
    ExplicitWidth = 121
    ExplicitHeight = 97
  end
  object ACBrCotacao1: TACBrCotacao
    ProxyPort = '8080'
    Left = 215
    Top = 105
  end
end
