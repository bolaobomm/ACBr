object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Demo Tabelas Sped'
  ClientHeight = 511
  ClientWidth = 784
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 784
    Height = 200
    Align = alTop
    DataSource = DataSource1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'Id'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Versao'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Pacote'
        Width = 294
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Tipo'
        Width = 375
        Visible = True
      end>
  end
  object DBGrid2: TDBGrid
    Left = 0
    Top = 200
    Width = 784
    Height = 200
    Align = alTop
    DataSource = DataSource1
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'Desc'
        Width = 351
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DtCriacao'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DtVersao'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Hash'
        Width = 263
        Visible = True
      end>
  end
  object Panel1: TPanel
    Left = 0
    Top = 472
    Width = 784
    Height = 39
    Align = alBottom
    BevelInner = bvLowered
    TabOrder = 2
    object BtnListar: TBitBtn
      Left = 241
      Top = 5
      Width = 161
      Height = 25
      Caption = 'Listar Tabelas'
      TabOrder = 0
      OnClick = BtnListarClick
    end
    object BtnDow: TBitBtn
      Left = 417
      Top = 5
      Width = 161
      Height = 25
      Caption = 'Download Item Selecionado'
      TabOrder = 1
      OnClick = BtnDowClick
    end
    object BtnDowT: TBitBtn
      Left = 588
      Top = 5
      Width = 161
      Height = 25
      Caption = 'Download Todos'
      TabOrder = 2
      OnClick = BtnDowTClick
    end
    object ComboBox1: TComboBox
      Left = 63
      Top = 7
      Width = 145
      Height = 21
      TabOrder = 3
      Text = 'ComboBox1'
    end
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 48
    Top = 32
    object ClientDataSet1Id: TStringField
      FieldName = 'Id'
      Size = 5
    end
    object ClientDataSet1Versao: TStringField
      FieldName = 'Versao'
      Size = 5
    end
    object ClientDataSet1Pacote: TStringField
      FieldName = 'Pacote'
      Size = 100
    end
    object ClientDataSet1Tipo: TStringField
      FieldName = 'Tipo'
      Size = 100
    end
    object ClientDataSet1Desc: TStringField
      FieldName = 'Desc'
      Size = 200
    end
    object ClientDataSet1DtCriacao: TDateField
      FieldName = 'DtCriacao'
    end
    object ClientDataSet1DtVersao: TDateField
      FieldName = 'DtVersao'
    end
    object ClientDataSet1Hash: TStringField
      FieldName = 'Hash'
      Size = 50
    end
  end
  object DataSource1: TDataSource
    DataSet = ClientDataSet1
    Left = 104
    Top = 40
  end
  object ACBrTabelasSped1: TACBrTabelasSped
    ProxyPort = '8080'
    Left = 328
    Top = 152
  end
end
