object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 535
  ClientWidth = 822
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 0
    Top = 141
    Width = 822
    Height = 253
    Align = alClient
    DataSource = dtsCadastro
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 394
    Width = 822
    Height = 68
    Align = alBottom
    Caption = 'Pesquisar no componente'
    TabOrder = 1
    object Label3: TLabel
      Left = 12
      Top = 19
      Width = 22
      Height = 13
      Caption = 'NCM'
      Color = clBtnFace
      ParentColor = False
    end
    object edNCM: TEdit
      Left = 12
      Top = 35
      Width = 174
      Height = 21
      TabOrder = 0
      Text = 'edNCM'
    end
    object btnPesquisar: TBitBtn
      Left = 307
      Top = 33
      Width = 99
      Height = 26
      Caption = 'Pesquisar...'
      TabOrder = 1
      OnClick = btnPesquisarClick
    end
    object ckbBuscaNCMParcial: TCheckBox
      Left = 192
      Top = 37
      Width = 97
      Height = 17
      Caption = 'Busca parcial'
      TabOrder = 2
    end
  end
  object rgTipoExportacao: TRadioGroup
    Left = 0
    Top = 462
    Width = 822
    Height = 39
    Align = alBottom
    Caption = 'Tipo de exporta'#231#227'o'
    Columns = 6
    ItemIndex = 0
    Items.Strings = (
      'Formato CSV'
      'Formato DSV'
      'Formato XML'
      'Formato HTML'
      'Formato TXT'
      'Demilitado')
    TabOrder = 2
  end
  object Panel1: TPanel
    Left = 0
    Top = 501
    Width = 822
    Height = 34
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
    DesignSize = (
      822
      34)
    object DBNavigator1: TDBNavigator
      Left = 0
      Top = 0
      Width = 160
      Height = 34
      DataSource = dtsCadastro
      VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbRefresh]
      Align = alLeft
      TabOrder = 0
    end
    object btExportar: TBitBtn
      Left = 645
      Top = 3
      Width = 80
      Height = 28
      Anchors = [akTop, akRight]
      Caption = 'Exportar'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00008800FFFF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00008800FF09C724FF008800FFE9DBD3FFFF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000088
        00FF008800FF008800FF008800FF09C724FF09C724FF008800FFFF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00008800FFCCFF
        FFFF09C724FF09C724FF09C724FF09C724FF09C724FF09C724FF008800FFDC69
        30FFDC6930FFDC6930FFDC6930FFDC6930FFDC6930FFD3CFCEFF008800FFCCFF
        FFFF14D651FF15D651FF15D652FF15D651FF14D651FF14D651FF15D651FF0088
        00FFEFD6D0FFEED4CDFFEBD1CAFFE9D0CAFFEFC3B7FFDC6930FF008800FFCCFF
        FFFF25EB8FFF25EB8FFF24EB90FF24EB90FF25EB90FF24EB90FF24EB90FF0088
        00FFFFFFFFFFFFFFFFFFFAFFFFFFF6FCFEFFF9F0EDFFDC6930FF008800FFCCFF
        FFFFCCFFFFFFCCFFFFFFCCFFFFFF30FABDFF30FABDFF30FABDFF008800FFFFE1
        D5FFFFE0D5FFFFDED5FFFDDBD3FFF4CCC4FFF3B6A9FFDC6930FFA38B84FF0088
        00FF008800FF008800FF008800FF30FABDFF30FABDFF008800FFFE9963FFFF99
        64FFFF9565FFFF9065FFFF8F6AFFEB6F47FFE75B36FFDC6930FFA38B84FFFFFF
        FFFFDC6930FFFDDEC9FF008800FF30FABDFF008800FFFD9E69FFFD9B64FFFE9A
        64FFFF9A66FFFF9666FFFF966BFFEB6F47FFE75B36FFDC6930FFA38B84FFFFFF
        FFFFDC6930FFFDE4D0FFFBB98BFF008800FFFCAA78FFFDA36FFFFD9B65FFFD9B
        64FFFE9A65FFFF9966FFFF9B6BFFEA7547FFE76236FFDC6930FFA38B84FFFFFF
        FFFFDC6930FFFDE3D1FFFCDCC7FFFCD9C3FFFCD6C0FFFCD7C1FFFEB992FFFD9E
        69FFFD9A62FFFF9963FFFF9D69FFEA7844FFE86838FFDC6930FFA38B84FFFFFF
        FFFFECEBECFFDC6930FFDC6930FFDC6930FFDC6930FFDC6930FFFADBCAFFFFDE
        CBFFFED2B9FFFED2B9FFFFD3BBFFF7C5ACFFF6BA9FFFDC6930FFA38B84FFFFFF
        FFFFECEBECFFEEEEF1FFF0F1F4FFF2F4F7FFF3F7FAFFF6F7F9FFDC6930FFDC69
        30FFDC6930FFDC6930FFDC6930FFDC6930FFDC6930FFC5B9B4FFA38B84FFFFFF
        FFFFEBE4E2FFEDE6E5FFEFE9E7FFF0EBEAFFF3EEEDFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFAD9187FFE8E8E8FFFF00FF00A38B84FFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFAF8FFA38B84FFA38B84FFA38B
        84FFA38B84FFA38B84FFA38B84FFD7D6D5FFFF00FF00FF00FF00C3BEBCFFA38B
        84FFA38B84FFA38B84FFA38B84FFA38B84FFA38B84FFC5C2C1FFFF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
      TabOrder = 2
      OnClick = btExportarClick
    end
    object btSair: TBitBtn
      Left = 731
      Top = 3
      Width = 80
      Height = 28
      Anchors = [akTop, akRight]
      Caption = 'Sair'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B000000000000000000003F00007F0000
        7F3F007F3F007F3F007F3F007F3F007F3F007F3F000000003F00007F00007F00
        007F00007F00003F00007F0000FF0000FF3F00FF7F00FF7F00FF7F00FF7F00FF
        7F00FF7F007F7F009F9F00BF0000FF0000FF0000FF00007F00007F0000FF0000
        FF0000FF3F00FF7F00FF7F00FF7F00FF7F00FF7F007F7F00BFBF00606000BF00
        00FF0000FF00007F00003F00007F00007F00007F00007F3F007F3F00FFBF00FF
        BF00FFBF007F7F00BFBF008080006060007F00007F00003F0000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFF000000FFFF00FFFF00FFFF007F7F00BFBF008080008080
        00404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF01010100000040404040
        40404040407F7F00BFBF00808000808000404040FFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFF2020000000008080808080808080807F7F00BFBF008080008080
        00404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5F5F0060600060606080
        80808080807F7F009F9F00202020808000404040FFFFFFFFFFFF000000000000
        0000000000007F7F00DFDF006060006060608080807F7F009F9F003F3F3F8080
        00404040FFFFFFFFFFFF5F5F00BFBF00BFBF00BFBF00DFDF00FFFF00DFDF0060
        60006060607F7F00BFBF00808000808000404040FFFFFFFFFFFF7F7F00FFFF3F
        FFFF7FFFFF7FFFFF7FFFFFBFFFFF3F7F7F006060607F7F00BFBF008080008080
        00404040FFFFFFFFFFFF0000000000000000000000007F7F00FFFF3F7F7F0060
        60608080807F7F00BFBF00808000808000404040FFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFF7F7F007F7F006060608080808080807F7F3FBFBF008080008080
        00404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF20200000000080808080
        8080808080606060BFBF7F9F9F00808000404040FFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFF000000808080808080808080808080606060BFBF7F9F9F
        00404040FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000040404040
        40404040404040404040402020207F7F3F2B2B2BFFFFFFFFFFFF}
      TabOrder = 3
      OnClick = btSairClick
    end
    object btProxy: TBitBtn
      Left = 559
      Top = 3
      Width = 80
      Height = 28
      Anchors = [akTop, akRight]
      Caption = 'Proxy'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000064000000640000000000000000000000000000000000
        0000000000000000000000000008000000121207011A180C021F0F0700230401
        001A000000090000000000000000000000000000000000000000000000000000
        00000000000000000033030200644B280C797C49209A8B582EAB7F4D23AA582D
        09970F0100770000005B2828285C5F5F5F5E0000000000000000000000000000
        0000000000000000004F61300BD1AE672EFF82512BFF5C3E25FF826D5CFFACA1
        99FFC4C1BDFEF0F0F0FFF9F9F9FFDEDEDEE50000000000000000000000000000
        000078360716904109E78B3E08FF7A2E00FFB8A496FFFFFFFFFFFCFDF6FFEDEE
        EDFFD8D8D8FFD5D5D5FFD2D2D2FFEBEBEBFF5050500300000000000000000000
        000062561EE75B4E17FF743A07FF772A00FFAC8B6FFF99A3E8FF414FCCFFCECE
        DDFFDBDBD9FFD9D9D9FFD6D6D6FFF0F0F0FF7E7E7E370000000000000000863C
        03892B7234FF635520FF5F5D26FF8B3500FF814C2DFFE1E9FEFFE7E7E6FFB7B9
        ECFFE1E1DEFFDADADAFFD9D9D9FFE9E9E9FFB6B6B66C00000000000000006E59
        22F92D6F31FF546F38FFA3460AFF9C480DFF772C00FFF8FCFDFFE4E5E4FFE9E9
        E6FFE7E7E7FFDBDBDBFFDBDBDBFFE4E4E4FFD7D7D7A1000000006227022C6B65
        2DFF3F7A42FF557740FFB7500CFFAB5314FFA54704FFDBD2CDFFEBECE8FFF7F7
        F1FFF1F1F1FFE4E4E4FFDDDDDDFFDFDFDFFFE9E9E9D700000000783104485773
        39FF377B3DFF3E8043FF6A7639FFCE6518FFBE5D0EFFD5B192FF9BA5EFFF6E78
        D0FFEBEAEAFFEFEFEEFFE2E2E2FFDBDBDBFFF3F4F4FF000000005A3C153E4D86
        4EFF367F3EFF409658FF509962FFD26719FFD76B19FFD99057FFD8DFFCFFE1E2
        F0FFC5C5F3FFFAF6F7FFFFFFFFFFFFFFFFFFFEF9F6FF7E7F7F1A284E2A0D4088
        48FF3A8645FF47A36BFF67A560FF21C986FFC87B29FFA57F37FFE8FAF1FFBBD7
        BEFF95BA95FF6C9C6FFF636B3DFF7D3200FF9A4605AF00000000000000004591
        4FC8398A48FF51A669FF55C585FF6EB36BFF35C680FF3ABB77FF359952FF2E84
        3FFF206E27FF246B27FF3B6C31FF873300FF9A4B0F510000000000000000438E
        50344C9E61FFA08D4AFF61BE80FF58DC9AFF4DDA94FF41B56EFF40A560FF398F
        4CFF227128FF327938FF5B5421FF784C14D70000000000000000000000000000
        00006EA3607887894EFF5AB778FF74C181FF88B275FF5BC285FF4BAA6AFF3D93
        51FF24732CFF33793BFF4B6126F67C3A06180000000000000000000000000000
        000000000000A48D446060B071FE53C486FF59C287FF5BBA80FF61B17BFF61A8
        75FF488F55FF4A773AD257542117000000000000000000000000000000000000
        00000000000000000000814E1C08A77F3E70969259B6BB9569D3B9A47ECBAD88
        5C9E767542450000000000000000000000000000000000000000}
      TabOrder = 1
      OnClick = btProxyClick
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 822
    Height = 141
    Align = alTop
    Caption = 'Arquivo Tabela_CNIEE.bin'
    TabOrder = 4
    DesignSize = (
      822
      141)
    object Label1: TLabel
      Left = 12
      Top = 67
      Width = 484
      Height = 13
      Caption = 
        'Nome do Arquivo em disco (Deixe em branco para baixar ou informe' +
        ' o caminho do arquivo para abrir)'
      Color = clBtnFace
      ParentColor = False
    end
    object sbArquivo: TSpeedButton
      Left = 569
      Top = 78
      Width = 32
      Height = 26
      Anchors = [akTop, akRight]
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00F9F9FAFF566C8EFE415470FE806D6EFEFF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FAFAFBFF75879EFE63AECEFF52AEE7FF21416BFFFF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FEFEFEFF7389A6FE5AA6CEFF73DBFFFF187DD6FF536C92FEFF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00F4F6
        F9FF7792B3FE5AAED6FF73DBFFFF107DD6FF4D73A2FEEBEDF1FFFF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00A9B5
        C9FF3996CEFF73D7FFFF1882DEFF4F7AACFEEBEEF2FFFF00FF00FF00FF00FF00
        FF00D9D1D2FF9C837BFE927A66FE98836BFE917B6FFEAB9A9AFED8CDCCFFA498
        99FE3975A5FF187DD6FF5184BFFEEFF2F6FFFF00FF00FF00FF00FF00FF00BBAD
        ABFFA87E61FEF7DF94FFFFFFB5FFFFFFC6FFFFFFD6FFDED3BDFF846D63FF8C6D
        6BFF9698A3FE84ACD6FFEAF0F6FFFF00FF00FF00FF00FF00FF00D5CCCDFFA778
        57FEFFEB94FFFFEF9CFFFFF7ADFFFFFFC6FFFFFFD6FFFFFFF7FFF7EFE7FF8469
        63FFD9D0CFFFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF009B7E73FEF7C7
        7BFFFFD784FFFFE394FFFFFBADFFFFFFC6FFFFFFD6FFFFFFEFFFFFFFFFFFCEBE
        ADFFC2B5B3FFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00A17555FEFFD7
        84FFFFD78CFFFFE79CFFFFF7B5FFFFFFCEFFFFFFCEFFFFFFDEFFFFFFE7FFFFFB
        DEFFA08E89FEFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00BE8557FEFFD3
        84FFFFDF8CFFFFE39CFFFFEFA5FFFFFBC6FFFFFFCEFFFFFFCEFFFFFFCEFFFFFF
        D6FFA3908BFEFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00B1805BFEFFCF
        7BFFFFEB9CFFFFFFD6FFFFFBDEFFFFEFADFFFFFBBDFFFFFFB5FFFFFFBDFFFFFB
        BDFFAF9C92FEFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00B5988AFEF7B6
        6BFFFFE394FFFFFFBDFFFFFFD6FFFFEBA5FFFFF3A5FFFFEB9CFFFFFBADFFE7D3
        9CFFCCC3C2FFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00CD91
        62FEFFCB73FFFFE794FFFFEFA5FFFFE79CFFF7D78CFFFFDF8CFFFFE394FFBEA6
        93FEF2EFEFFFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00D59A6BFEF7B66BFFFFCF7BFFFFD384FFFFD37BFFF7CB84FFCBAB90FEE1DC
        DDFFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00CBAF9EFED6A578FED6A978FED1AC8DFED0BFB7FEF0ECECFFFF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
      OnClick = sbArquivoClick
    end
    object lVersao: TLabel
      Left = 12
      Top = 110
      Width = 37
      Height = 13
      Caption = 'Vers'#227'o:'
    end
    object Label2: TLabel
      Left = 12
      Top = 24
      Width = 173
      Height = 13
      Caption = 'URL do arquivo .csv no padr'#227'o IBPT'
      Color = clBtnFace
      ParentColor = False
    end
    object edArquivo: TEdit
      Left = 12
      Top = 83
      Width = 551
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      ReadOnly = True
      TabOrder = 1
    end
    object btAbrir: TBitBtn
      Left = 569
      Top = 38
      Width = 99
      Height = 26
      Anchors = [akTop, akRight]
      Caption = 'Abrir'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00000000FFFF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00001808FF086531FF000400FFFF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00001808FF39A66BFF6BEBB5FF39925AFF000800FFFF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00001800FF31A263FF39E39CFF18DB8CFF52E7ADFF398E5AFF000C
        00FFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00001C00FF219E52FF29D78CFF18CF84FF18D384FF18D784FF42DF9CFF318A
        4AFF000C00FFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00001C
        00FF109242FF18C773FF18C36BFF18C773FF18C77BFF18CB7BFF18CF7BFF29D7
        8CFF218642FF001000FFFF00FF00FF00FF00FF00FF00FF00FF00002400FF108E
        39FF18BA63FF18B663FF31C373FF42CB84FF42D38CFF4ACF8CFF39CB84FF29C7
        7BFF21CB7BFF108A39FF001800FFFF00FF00FF00FF00FF00FF00087129FF21B6
        5AFF52BE84FF73CF9CFF7BD7A5FF42BE7BFF107D42FF52CF94FF7BDBADFF73D7
        A5FF6BD39CFF42CB84FF108A31FF002000FFFF00FF00FF00FF00003010FF4AB2
        6BFF9CDBB5FF94DBB5FF42BA73FF003010FFFF00FF00084521FF5ACF8CFF9CDF
        BDFF94DBB5FF94DBB5FF5ACB8CFF108A31FF002800FFFF00FF00FF00FF000020
        08FF52AE73FF42AA6BFF001C08FFFF00FF00FF00FF00FF00FF00003010FF5ABE
        84FFB5E7CEFFB5E3C6FFB5E3C6FF73CF9CFF108629FF002C00FFFF00FF00FF00
        FF00001800FF001400FFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF000020
        08FF52AE73FFD6F3DEFFCEEBDEFFDEEFE7FF94DBADFF085D18FFFF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00001400FF529E63FFEFFFF7FFDEF7E7FF42965AFF001000FFFF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00000000FF428E52FF39864AFF000000FFFF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00000C00FF000C00FFFF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
      TabOrder = 2
      OnClick = btAbrirClick
    end
    object btDownload: TBitBtn
      Left = 674
      Top = 38
      Width = 99
      Height = 26
      Anchors = [akTop, akRight]
      Caption = 'Download'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        20000000000000040000640000006400000000000000000000007C7C7CEF7878
        78FF747474FF707070FF6D6D6DFF6A6A6AFF686868FF676767FF666666FF6666
        66FF666666FF666666FF666666FF666666FF666666FF666666EF8F8F8FFFFDFD
        FDFFF6F5F4FFF6F5F5FFF7F6F6FFF7F7F6FFF7F7F7FFF7F7F7FFF7F7F7FFF7F7
        F7FFF7F7F7FFF7F7F7FFF7F7F7FFF7F7F7FFF7F7F7FF666666FFA2A2A2FFF5F4
        F3FFA69794FFC5BEBCFFC7C1BFFFC9C3C1FFCAC5C3FFCAC5C4FFCBC6C4FFCBC7
        C5FFCBC7C5FFD5D3D2FF55B853FF37C836FFE0F9E0FF6B6B6BFFB5B5B5FFF5F4
        F3FFB8ACAAFFBAAFACFFBCB1AFFFBDB2B0FFBDB3B1FFBEB4B2FFBEB4B2FFBFB4
        B2FFBFB4B2FFDEDCDBFF60C05FFF60D45FFFE3FBE3FF7D7D7DFFC7C7C7FFF5F4
        F3FFF6F5F4FFF6F5F5FFF7F6F6FFF7F7F6FFF7F7F7FFF7F7F7FFF7F7F7FFF7F7
        F7FFF7F7F7FFF7F7F7FFE0F2E0FFDBF5DBFFFAFEFAFF909090FFCCCCCCEFCBC9
        C8FFCCCACAFFCDCBCBFFCDCCCBFFCCCBCBFFCAC9C9FFC8C7C7FFC5C4C4FFC2C2
        C1FFC0BFBFFFBDBCBCFFBAB9B9FFB7B7B6FFB4B4B4FFA3A3A3EFCCCCCC80DDDA
        DBFFFCF5F7FFFCF5F7FFFCF5F7FFFCF5F7FFFCF5F7FFFBF4F6FFFAF3F5FFF8F1
        F3FFF6EFF0FFF2EAEBFFEDE4E5FFE5DCDDFF959292FF67676780CCCCCC10CFCF
        CFFFF9F2F4FFFCF5F7FFE4DCDDFFFAF6F7FFE7ECE3FF30AA30FF49AD46FFC6C2
        B7FFCAB8B6FFCCC0BFFFEDE4E5FFDFD7D7FF7B7B7BFF6C6C6C1000000000CCCC
        CC9FE4E1E2FFFCF5F7FFFDF9FBFFEEF4EDFF3AB13CFF0EA111FF0EA111FF3AB1
        3BFFEBF0E8FFF8F3F4FFEDE4E5FFB6B2B2FF7F7F7F9F0000000000000000CCCC
        CC20CFCFCFFFF9F2F4FFEEF0E9FF41B544FF18A71CFF2EB538FF2EB538FF18A7
        1CFF40B342FFE4E6DEFFE7E0E1FF969595FF8989892000000000000000000000
        0000CCCCCC8FC1CAC2FF40B245FF1FAC26FF36B942FF4AC559FF47C355FF36B9
        42FF1FAC26FF38AA3EFF99A29AFF9B9B9B8F0000000000000000000000000000
        00000000000029B131CF29B131FF29B131FF29B131FF61D375FF53CA64FF29B1
        31FF29B131FF29B131FF29B131CF000000000000000000000000000000000000
        00000000000000000000000000000000000033B73DFF79E191FF67D67CFF33B7
        3DFF000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000028B438FF5FDA84FF51D071FF28B4
        38FF000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000015AC29FF2CC156FF26BC4BFF15AC
        29FF000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000011A421FF11A421FF11A421FF11A4
        21FF000000000000000000000000000000000000000000000000}
      TabOrder = 0
      OnClick = btDownloadClick
    end
    object edURL: TEdit
      Left = 12
      Top = 40
      Width = 551
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 3
      Text = 
        'https://acbr.svn.sourceforge.net/svnroot/acbr/trunk/Exemplos/ACB' +
        'rIBPTax/tabela/AcspDeOlhoNoImpostoIbptV.0.0.1.csv'
    end
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = '.csv'
    Filter = 'Tabela IBPTax|*.csv'
    Options = [ofHideReadOnly, ofNoChangeDir, ofEnableSizing]
    Title = 'Abrir arquivo'
    Left = 138
    Top = 185
  end
  object tmpCadastro: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 45
    Top = 190
    object tmpCadastroNCM: TStringField
      FieldName = 'NCM'
      Size = 8
    end
    object tmpCadastroEx: TIntegerField
      FieldName = 'Ex'
    end
    object tmpCadastroTabela: TIntegerField
      FieldName = 'Tabela'
    end
    object tmpCadastroAliqNacional: TFloatField
      FieldName = 'AliqNacional'
    end
    object tmpCadastroAliqInternacional: TFloatField
      FieldName = 'AliqInternacional'
    end
  end
  object dtsCadastro: TDataSource
    DataSet = tmpCadastro
    Left = 59
    Top = 204
  end
  object SaveDialog1: TSaveDialog
    Options = [ofHideReadOnly, ofNoChangeDir, ofEnableSizing]
    Left = 227
    Top = 185
  end
  object ACBrIBPTax1: TACBrIBPTax
    ProxyPort = '8080'
    Left = 305
    Top = 185
  end
end
