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
    Height = 325
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ItemHeight = 14
    ParentFont = False
    TabOrder = 1
    ExplicitHeight = 452
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 375
    Width = 696
    Height = 127
    Align = alBottom
    Caption = 'Como utilizar'
    TabOrder = 2
    object Label1: TLabel
      Left = 2
      Top = 36
      Width = 692
      Height = 89
      Align = alClient
      Caption = 
        '   Moedas do Tipo "A":'#13#10'        - Para calcular o valor equivale' +
        'nte em US$ (d'#243'lar americano), divida o montante na moeda consult' +
        'ada pela respectiva paridade.'#13#10'        - Para obter o valor em R' +
        '$ (reais), multiplique o montante na moeda consultada pela respe' +
        'ctiva taxa.'#13#10'   Moedas do tipo "B":'#13#10'        - Para calcular o v' +
        'alor equivalente em US$ (d'#243'lar americano), multiplique o montant' +
        'e na moeda consultada pela respectiva paridade.'#13#10'        - Para ' +
        'obter o valor em R$ (reais), multiplique o montante na moeda con' +
        'sultada pela respectiva taxa.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ExplicitTop = 15
      ExplicitWidth = 658
      ExplicitHeight = 78
    end
    object Label2: TLabel
      Left = 2
      Top = 15
      Width = 692
      Height = 21
      Cursor = crHandPoint
      Align = alTop
      AutoSize = False
      Caption = 'http://www4.bcb.gov.br/pec/taxas/batch/cotacaomoedas.asp'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsUnderline]
      ParentFont = False
      OnClick = Label2Click
      ExplicitLeft = 3
    end
  end
  object ACBrCotacao1: TACBrCotacao
    ProxyPort = '8080'
    Left = 215
    Top = 105
  end
end
