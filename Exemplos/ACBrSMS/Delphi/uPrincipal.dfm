object frmPrincipal: TfrmPrincipal
  Left = 407
  Top = 214
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Demo ACBrSMS'
  ClientHeight = 400
  ClientWidth = 700
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox5: TGroupBox
    Left = 0
    Top = 0
    Width = 700
    Height = 71
    Align = alTop
    Caption = 'Configura'#231#227'o'
    TabOrder = 0
    object Label3: TLabel
      Left = 14
      Top = 21
      Width = 34
      Height = 13
      Caption = 'Modelo'
    end
    object Label4: TLabel
      Left = 165
      Top = 21
      Width = 26
      Height = 13
      Caption = 'Porta'
    end
    object Label5: TLabel
      Left = 237
      Top = 21
      Width = 51
      Height = 13
      Caption = 'Velocidade'
    end
    object btnAtivar: TButton
      Left = 312
      Top = 35
      Width = 84
      Height = 25
      Caption = 'Ativar'
      TabOrder = 0
      OnClick = btnAtivarClick
    end
    object cbxPorta: TComboBox
      Left = 165
      Top = 37
      Width = 66
      Height = 21
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 2
      Text = 'COM1'
      Items.Strings = (
        'COM1'
        'COM2'
        'COM3'
        'COM4'
        'COM5'
        'COM6'
        'COM7'
        'COM8'
        'COM9'
        'COM10')
    end
    object cbxVelocidade: TComboBox
      Left = 237
      Top = 37
      Width = 69
      Height = 21
      Style = csDropDownList
      ItemIndex = 1
      TabOrder = 3
      Text = '115200'
      Items.Strings = (
        '9600'
        '115200')
    end
    object cbxModelo: TComboBox
      Left = 14
      Top = 37
      Width = 145
      Height = 21
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 1
      Text = 'Daruma'
      Items.Strings = (
        'Daruma'
        'ZTE')
    end
  end
  object pBotoes: TPanel
    Left = 0
    Top = 360
    Width = 700
    Height = 40
    Cursor = crHelp
    Hint = 'Sobre o ACBrMonitor ?'
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    TabStop = True
    object Image1: TImage
      Left = 0
      Top = 0
      Width = 700
      Height = 40
      Align = alClient
      Picture.Data = {
        0A544A504547496D616765C9180000FFD8FFE000104A46494600010101004400
        440000FFFE0018437265617465642077697468205468652047494D5000FFDB00
        430006040506050406060506070706080A100A0A09090A140E0F0C1017141818
        171416161A1D251F1A1B231C1616202C20232627292A29191F2D302D28302528
        2928FFDB0043010707070A080A130A0A13281A161A2828282828282828282828
        2828282828282828282828282828282828282828282828282828282828282828
        28282828282828FFC00011080028040003012200021101031101FFC4001F0000
        010501010101010100000000000000000102030405060708090A0BFFC400B510
        0002010303020403050504040000017D01020300041105122131410613516107
        227114328191A1082342B1C11552D1F02433627282090A161718191A25262728
        292A3435363738393A434445464748494A535455565758595A63646566676869
        6A737475767778797A838485868788898A92939495969798999AA2A3A4A5A6A7
        A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6D7D8D9DAE1E2
        E3E4E5E6E7E8E9EAF1F2F3F4F5F6F7F8F9FAFFC4001F01000301010101010101
        01010000000000000102030405060708090A0BFFC400B5110002010204040304
        0705040400010277000102031104052131061241510761711322328108144291
        A1B1C109233352F0156272D10A162434E125F11718191A262728292A35363738
        393A434445464748494A535455565758595A636465666768696A737475767778
        797A82838485868788898A92939495969798999AA2A3A4A5A6A7A8A9AAB2B3B4
        B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6D7D8D9DAE2E3E4E5E6E7E8E9
        EAF2F3F4F5F6F7F8F9FAFFDA000C03010002110311003F00D9BFFF008FC9FF00
        EBA37F3AAAD56AFF00FE3F27FF00AE8DFCEB2759BD4D374BBABC93EEC11B3E3D
        703815F6B0F851F00D394ECBB961AAE697A45E6AB2EDB488951F7A46E157EA6B
        E7ED3FC51AFDADC586A77B7B732D83DC10D1B39DAE14A965C7D1ABED2B2B8B28
        7438EEEDB6476220F394AF4098CE7F2AF0788B37AB955387B28734A6DA4FA2FF
        0083D8FA2C0E46AACDFB59FBABB185A3F806D5E541A85CCB213C958B0A3F339F
        E95B93F8134548F315A1703AE646CFF3AF97F51F17F8D3E2978CDF4BF0C5CCF6
        F6C59BC982190C6AB18FE376156E1BBF899F0B3C5D656F792DEEA11CD87302BB
        5C473A67040EE0D713CB331AD4B93118AB557AF2A76B7DD6FC8F5234F0949FB9
        495BCF5FCFFCCF7FBAF04E9132911A4D01F54933FCF35CBEB1E04BFB656934F6
        FB646392AAB871F877AECBC5896DAB2786E596DD845752348F1480A9FF0052C7
        0C3D41AC1B8B0B38A4BFFB368227B7B04124F22CAAA4020B700919E057C852CF
        F32CBF13EC253752CAED3B3D2FDDB4FF0013BAAE5383C4D3E75151F35A7FC03C
        E6456462AE0AB038208C106A26AECFC4BE19B779B4E9F450C8F78E50C458957F
        DDB38201E87E5C7E3CF4AE2AE0B410B4D3417290AB98CCAD6F204DD9DB8DD8C6
        73C75EB5F7B95710E1332A0AB29723BD9A9349DFF5F23E5F199557C254E4B732
        EE9086A36A92559219BCAB8827B79768709344D192A7B8C81E951B57B34AAC2B
        454E9C934FAAD51C5284A9BE59AB3F318D519A7B530D58D119A61A79A8CD05A1
        869869E6A3348B430D30D3CD2DBF946E22FB497106F1E614196DB9E71EF8A19A
        223B886581944D13C65943A875232A790467B1F5A85D1D55599582B67692383F
        4AEBB50D7F4DD523985CDBCF6EEF1BC2ACA04BE5A798B22019DBD0875FA37B62
        9F79E24D3E79BE4371140925CF92BE4237941D9991C0DD8C8CE31DBA83C563ED
        25FCA6EA11EE712D51B576371E24B20B225ADB045659B936F1FCCE55423FB7CC
        A5B03A678A77F6FE87F64BD592C5E479DB794688005BE43904300BCAB7F09EBC
        632451ED25FCA528AEE7216D677177E67D961925F2D77BEC5CED5F53551ABBE8
        F56D274FD5A696FDCDF45308D955208CAA4477168C84700100AFA818231D2B03
        5AD52C6EF488ADEDA2612A98480615510858CAB80C0E5B7B10C72074A1546DEC
        5F2A4B731A7B1BB86D63B99AD678EDE4FB92BC642B7D0F43549ABAB7D5B4C7D6
        9B5377BADF306DD098159606319552A4B7CDB1882A081C0ED53CBE27B04F96DE
        DFE5227F319ADA3FDE39B68D237239C7EF519C8ED9CF26973CBB16A2BB9C5353
        0D76AFE24D29B4EBB8FEC4BF6A9A31B9DADC30918C0887A30DB8915DC1C1E5B3
        8C8C553D635FB4BF4D5045BED4CB712BC3B2DA33BE13F7236E46CDBC9E3392C4
        F614D4E4FA16A2BB9CC8B5B86BD166B139BA327942203E62F9C6DC7AE78A5B3D
        3AFAFD656B1B3B9B958B1BCC313384CE719C0E3A1FC8D7731F8AF408AE4CC967
        3822FC5E20F217298BA127CA77E07EEBE5C63AF7C562783F5EB3D1E19C5E6FDC
        6F2DAE5716C93644624C8F988DA7E71861EF53ED26D3762D455F73942688E379
        9CAC4A5982B3103D00249FC0026BB3D27C4FA641796AF776F234105B2C613C85
        70CFBF2E580652D95E324FD41150CDAFE8C6CD235825CC69711C68B02AA2878A
        5552DF31DCC19D3918E01E09C51CF2EC528A3929E39AD2EA48A65786E2172ACA
        7864607047B106BE85F85BAB5C6ADE10B796FA4324F13B42646392C07427DF07
        1F85781F88EFA3D4BC41A9DF401C43737324C81C6182B31233EFCD7B57C1564F
        F842FE6233F6993F90AE2CC95E8A6F7B9AD2F88F40DC3D451B87A8A66E8FD451
        BA3F515E09D23F70F5146E1EA299BA3F5146E8FD45003F70F5146E1EA299BA3F
        5146E8FD45003F70F5146E1EA299BA3F5146E8FD45003F70F5146E1EA299BA3F
        5146E8FD45003F70F5146E1EA299BA3F5146E8FD45003F70F5146E1EA299BA3F
        5146E8FD45003F70F5146E1EA299BA3F5146E8FD45003F70F5146E1EA299BA3F
        5146E8FD45003F70F5146E1EA299BA3F5146E8FD45003F70F5146E1EA299BA3F
        5146E8FD45003F70F5146E1EA299BA3F5146E8FD45003F70F5146E1EA299BA3F
        5146E8FD45003F70F5146E1EA299BA3F5146E8FD45003F70F5146E1EA299BA3F
        5146E8FD45003F70F5146E1EA299BA3F5146E8FD45003F70F5146E1EA299BA3F
        5146E8FD45003F70F5146E1EA299BA3F5146E8FD45003F70F5146E1EA299BA3F
        5146E8FD45003F70F5146E1EA299BA3F5146E8FD45003F70F5146E1EA299BA3F
        5146E8FD45003F70F5146E1EA299BA3F5146E8FD45003F70F5146E1EA299BA3F
        5146E8FD45003F70F5146E1EA299BA3F5146E8FD45003F70F5146E1EA299BA3F
        5146E8FD45003F70F5146E1EA299BA3F5146E8FD45003F70F5146E1EA299BA3F
        5146E8FD45003F70F5146E1EA299BA3F5146E8FD45003F70F5146E1EA299BA3F
        5146E8FD45003F70F5146E1EA299BA3F5146E8FD45003F70F5146E1EA299BA3F
        5146E8FD45003F70F5146E1EA299BA3F5146E8FD45003F70F5146E1EA299BA3F
        5146E8FD45003F70F5146E1EA299BA3F5146E8FD45003F70F5146E1EA299BA3F
        5146E8FD45003F70F5146E1EA299BA3F5146E8FD45003F70F5146E1EA299BA3F
        5146E8FD45003F70F5146E1EA299BA3F5146E8FD45003F70F5146E1EA299BA3F
        5146E8FD45003F70F5146E1EA299BA3F5146E8FD45003F70F5146E1EA299BA3F
        5146E8FD45003F70F5146E1EA299BA3F5146E8FD45003F70F5146E1EA299BA3F
        5146E8FD45003F70F5146E1EA299BA3F5146E8FD45003F70F5146E1EA299BA3F
        5146E8FD45003F70F5146E1EA299BA3F5146E8FD45007097DFF1F93FFD746FE7
        5E6BF19753FB36850582361EEE4CB0FF006179FE78AF4ABF205E4FCE3F78DFCE
        BCD7C59E0FD47C49E2DB6B8966B54D310C719DD21DC1339638C75E4D7D9C2AD3
        8A5CCD687C5E0D43EB1CD37648C1F10EA5E199BE10689A4D95E6ED72CE633CA9
        E530C97CEE1BB18E3E5FCABD93E14EAD2F897E036AD6C926EBDD3AD26B52BD49
        1B094FD38FC28D53E1AFC399B49BA4B08608AF1A2610C86793E57C70704FAD63
        FC08D1F53F026B1A80D5EEB4E6D32F61DAE127DF861D0E31E848AF98AF89C263
        70729252BC25CE94959B77BE9DD6FA1F56AA469CADCEB556D1AEBA7FC139EFD9
        166863F1F6A314ACA2692C888C1EA48604E3F0AFA2FC67F103C37E0FD56C6D7C
        4173F679AE919A37D9B828071CE3903FC2BE71F187C35B9B2F14BEABE00D5E05
        1248648E2598C72C24F50A7B8A6681F0AFC43E26F11437DE3BD50A5BA9065792
        46965751FC238E2BAF1186C266153EB92A9EEDB6DA5F76FF002B0A389504E09A
        BDFB9F47F89AF2DF5097C3377672ACB6D34B23C722F46530BE08AE7AFECD6FF5
        3BDF2B434BEF2563599DA709BF2090369E1B8F5AD5F13DCDB451E84BA440F710
        D8C8CA628B0A553CA651F7CA8EE3BD615DC96D773BCD3E85A89790057C5C46A1
        C0E99025C1FC6BF31CCB035E58CF690A5371E5B2B7ABDF63DCC3E2692A567357
        B93C536351D33C40B2BCF63702385609540FB379A42874C7724A86CE78E84720
        D4BCBA5B2F065FDD18629A48AF27689655DCA24FB5304623D9883F855817B0DC
        DC5A5BDE0B7D2EC2D5D2531492A991CA105142AE42A8201CE7B6315CD6BBAB29
        F0EDDE9896D2BC925EBBACA9246C854DC1901E1F77DDF6AE2C365B88A92A54AA
        5376E7575DA37FEAE5D5C6D1846528CD5ECFAF5398BDBABABEBB7BABFB86B8B8
        6509BCA85C28CE000001D493F8D576A94A37F74FE551BA95EA08FAD7EE387A74
        284151A0928AD923F3BA9567564E73776C89A98D4F6A61ADC1119A8CD486A334
        8B430D466A43519A0B430D466A43519A0B430D46D5D5E9FE1A86FBFB20A5D84F
        B4AC6D3A104B22B5C18B72F18FEEF19CF3554787E09A0B46B7D4632D2C73CAE5
        E36015620C49E99E8BD3D4D65ED626EA0CE69A98D5B8BA32A6AD15A4F728C876
        CAED18391098C49BC647F70F4EB91535AF8625BD4416F3471CA20591D663B417
        60CCA8A7D4A0538F7A6EA456E528B3996A8DABA6834084497515E5F46934369F
        6860A18888E5301BE5E7863D3BF7AA7AB680FA6C5134F776E5A690A46A3772A3
        1F3924600C303CF3ED4BDA45BB16A2CC26A8DABA97F08DC0B8110BCB7FDE3A43
        03E1F6CEEDBB010EDC11F29F9BA73F5C5783C2F7133CA1AE6DE348911D9DB760
        06B779FB0CF0A847D7147B48F72D459CDB546D5D245E19927BC8AD62BDB6333C
        3F6860438D9114DE189C7752381EA3DF16AEBC29041A6A16BE88DD0925696456
        2D12448A872005C9277AF7E338238384EAC56868A2CE39AA36AEA66F094B0EDF
        3EFED1322471C39FDDA2862FF77A1046075E7A0A2E7C1B750DA4F726F6CCC489
        BD18B15F37F72931032060ED91473D4F147B58F72D459C9B546D5D058F8766BE
        D312EA1B983CD93CD31DB9DDBDC47B4B738DA386EE7B1ABD7DE0EFECFB5D4A4B
        ED4ADB7DAC25D562CB65C4888548C640F9C60F7FC0D0EA453B5CA499C69AF7AF
        82AD10F05FCFD7ED327F215E0E457BB7C18300F06E253F37DA64F5F415C599FF
        0007E66D4BE23BFDD07A8FD68DD07A8FD6A3DD6BEBFCE8DD6BEBFCEBE7CE824D
        D07A8FD68DD07A8FD6A3DD6BEBFCE8DD6BEBFCE8024DD07A8FD68DD07A8FD6A3
        DD6BEBFCE8DD6BEBFCE8024DD07A8FD68DD07A8FD6A3DD6BEBFCE8DD6BEBFCE8
        024DD07A8FD68DD07A8FD6A3DD6BEBFCE8DD6BEBFCE8024DD07A8FD68DD07A8F
        D6A3DD6BEBFCE8DD6BEBFCE8024DD07A8FD68DD07A8FD6A3DD6BEBFCE8DD6BEB
        FCE8024DD07A8FD68DD07A8FD6A2DD6BEBFCE8DF6BEA7F5A0097741EA3F5A374
        1EA3F5A8B7DAFA9FD68DF6BEA7F5A0097741EA3F5A3741EA3F5A8B7DAFA9FD68
        DF6BEA7F5A0097741EA3F5A3741EA3F5A8B7DAFA9FD68DF6BEA7F5A0097741EA
        3F5A3741EA3F5A8B7DAFA9FD68DF6BEA7F5A0097741EA3F5A3741EA3F5A8B7DA
        FA9FD68DF6BEA7F5A0097741EA3F5A3741EA3F5A8B7DAFA9FD68DF6BEA7F5A00
        97741EA3F5A3741EA3F5A8B7DAFA9FD68DF6BEA7F5A0097741EA3F5A3741EA3F
        5A8B7DAFA9FD68DF6BEA7F5A0097741EA3F5A3741EA3F5A8F75AFAFF003A375A
        FAFF003A0093741EA3F5A3741EA3F5A8F75AFAFF003A375AFAFF003A0093741E
        A3F5A3741EA3F5A8F75AFAFF003A375AFAFF003A0093741EA3F5A3741EA3F5A8
        F75AFAFF003A375AFAFF003A0093741EA3F5A3741EA3F5A8F75AFAFF003A375A
        FAFF003A0093741EA3F5A3741EA3F5A8F75AFAFF003A375AFAFF003A0093741E
        A3F5A3741EA3F5A8F75AFAFF003A375AFAFF003A0093741EA3F5A3741EA3F5A8
        B75AFAFF003A37DAFA9FD68025DD07A8FD68DD07A8FD6A2DF6BEA7F5A37DAFA9
        FD68025DD07A8FD68DD07A8FD6A2DF6BEA7F5A37DAFA9FD68025DD07A8FD68DD
        07A8FD6A2DF6BEA7F5A37DAFA9FD68025DD07A8FD68DD07A8FD6A2DF6BEA7F5A
        37DAFA9FD68025DD07A8FD68DD07A8FD6A2DF6BEA7F5A37DAFA9FD68025DD07A
        8FD68DD07A8FD6A2DF6BEA7F5A37DAFA9FD68025DD07A8FD68DD07A8FD6A2DD6
        BEA7F5A5DD6BEBFCE8024DD07A8FD68DD07A8FD6A3DD6BEBFCE8DD6BEBFCE802
        4DD07A8FD68DD07A8FD6A3DD6BEBFCE8DD6BEBFCE8024DD07A8FD68DD07A8FD6
        A3DD6BEBFCE8DD6BEBFCE8024DD07A8FD68DD07A8FD6A3DD6BEBFCE8DD6BEBFC
        E8024DD07A8FD68DD07A8FD6A3DD6BEBFCE8DD6BEBFCE8024DD07A8FD68DD07A
        8FD6A3DD6BEBFCE8DD6BEBFCE8024DD07A8FD68DD07A8FD6A3DD6BEBFCE9375A
        FA9FD68025DD07A8FD68DD07A8FD6A2DF6BEA7F5A37DAFA9FD68025DD07A8FD6
        8DD07A8FD6A2DF6BEA7F5A37DAFA9FD68025DD07A8FD68DD07A8FD6A2DF6BEA7
        F5A37DAFA9FD68025DD07A8FD68DD07A8FD6A2DF6BEA7F5A37DAFA9FD68025DD
        07A8FD68DD07A8FD6A2DF6BEA7F5A37DAFA9FD68025DD07A8FD68DD07A8FD6A2
        DF6BEA7F5A37DAFA9FD68025DD07A8FD68DD07A8FD6A2DF6BEA7F5A37DAFA9FD
        68025DD07A8FD68DD07A8FD6A2DF6BEA7F5A37DAFA9FD680385D4A276D42E0A8
        C8F31B1CFBD456F085994CF1968C1C950C013ED4514F1195D275652BBD5DFA7F
        91F13CCEE5BF2EC307F7773924E3E65F97D075E7B5204D3F7731DD05C7F7D726
        8A2B3FECCA3DDFE1FE4573F9166CA4D3ED2EA19956E0BC72AB86DCBD0763CD7A
        32EB7A3ED1BAFA0CF7C483FC68A2BA70F97D249D9BFC3FC8EBC3E2250BD92393
        D5FC52935DB7D8E4B986240426C74F98E7A9CD41178B264CEF9A561D8111FF00
        3A28AC5E0637BF33FEBE443C4546EF728EAFAC5AEACAAF77062742C15E3603E5
        E700F3F4FD6B3DDB4C0AFB1662DB485DD22E338EBC1F5A28A8797526EEDBFC3F
        C88737277667F1FDF4FF00BEC553D418155018120F639A28AECCB32EA54F1319
        A6EEAFF97A116B141AA334515F565A2334C345148B44669868A282D119A61A28
        A0B44B1DFDDC5B3CAB995362845DAC46007DE00FF8173F5AB16BAFEA36B2B48B
        70CC76C80063F74BA152C31D0E0D1454B8A7BA355268A726A97AC662F7323994
        10E58E49C800F5E9C003E9C509AD6A514B2C90DE4D134B8DFE59DA0E060703D0
        71F4E28A28E55D8B4D8C5D6B528FCBD97B38D89E5AFCFD138F97E9C018F6AAF3
        6A77D216325DCCE58924B392492C18FEAA0FE14514B95762D3639B5DD50973F6
        FB91BD42361C8E0678FF00C79BF33EA6A27D67526B7581AFAE0C4ABB150B9C01
        B0A63FEF962BF438A28A3963D8B4D9126AFA846B02C7793A883223C39F94608C
        0F6C1231EE699FDAFA82CCB32DE4C2452CC086E85800DF98001F61451472AEC5
        A6C5B7D6AF62BF8AEE59E59E48D9DBE791864B8C372083CF7E79A5D53C45A95F
        DC5D48F70F1A5C001E2463B7010201C927EEA819EA7BD1454F246F7B169B2849
        A95EBB3335D4C4B19093BBAEFF00BFF9F7A7CDAD6A72B3B4B7D3B9923313966C
        EE524120FAF201E7D051453E55D8B4CCC22BDEFE15D9258F84205BF578E59646
        942E08214E31FCB3F8D14579B9A49AA697766D4773AFCD8FF79FF5A3363FDE7F
        D68A2BC23A43363FDE7FD68CD8FF0079FF005A28A003363FDE7FD68CD8FF0079
        FF005A28A003363FDE7FD68CD8FF0079FF005A28A003363FDE7FD68CD8FF0079
        FF005A28A003363FDE7FD68CD8FF0079FF005A28A003363FDE7FD68CD8FF0079
        FF005A28A003363FDE7FD68CD8FF0079FF005A28A003363FDE7FD68CD8FF0079
        FF005A28A003363FDE7FD68CD8FF0079FF005A28A003363FDE7FD68CD8FF0079
        FF005A28A003363FDE7FD68CD8FF0079FF005A28A003363FDE7FD68CD8FF0079
        FF005A28A003363FDE7FD68CD8FF0079FF005A28A003363FDE7FD68CD8FF0079
        FF005A28A003758FABFEB46EB1F57FD68A2800CD8FABFEB466C7FBCFFAD14500
        19B1FEF3FEB466C7FBCFFAD1450019B1FEF3FEB466C7FBCFFAD1450019B1FEF3
        FEB466C7FBCFFAD1450019B1FEF3FEB466C7FBCFFAD1450019B1FEF3FEB466C7
        FBCFFAD1450019B1FEF3FEB466C7FBCFFAD1450019B1FEF3FEB466C7FBCFFAD1
        450019B1FEF3FEB466C7FBCFFAD1450019B1FEF3FEB466C7FBCFFAD1450019B1
        FEF3FEB466C7FBCFFAD1450019B1FEF3FEB466C7FBCFFAD1450019B1FEF3FEB4
        66C7FBCFFAD1450019B1FEF3FEB466C7FBCFFAD1450019B1FEF3FEB466C7FBCF
        FAD1450019B1FEF3FEB466C7FBCFFAD1450019B1FEF3FEB466C7FBCFFAD14500
        19B1FEF3FEB466C7FBCFFAD1450019B1FEF3FEB466C7FBCFFAD1450019B1FEF3
        FEB466C7FBCFFAD1450019B1FEF3FEB466C7FBCFFAD1450019B1FEF3FEB466C7
        FBCFFAD1450019B1FEF3FEB466C7FBCFFAD1450019B1FEF3FEB466C7FBCFFAD1
        450019B1FEF3FEB466C7FBCFFAD1450019B1FEF3FEB466C7FBCFFAD1450019B1
        FEF3FEB466C7FBCFFAD1450019B1FEF3FEB466C7FBCFFAD1450019B1FEF3FEB4
        66C7FBCFFAD145001BAC7D5FF5A3758FABFEB451401FFFD9}
    end
  end
  object ACBrSMS1: TACBrSMS
    Ativo = False
    Device.Baud = 115200
    Modelo = modDaruma
    SinCard = sin1
    ATTimeOut = 10000
    ATResult = False
    RecebeConfirmacao = False
    QuebraMensagens = False
    Left = 212
    Top = 215
  end
  object MainMenu1: TMainMenu
    Left = 270
    Top = 215
    object Informaes1: TMenuItem
      Caption = 'Informa'#231#245'es'
      object menEmLinha: TMenuItem
        Caption = 'Em linha?'
        OnClick = menEmLinhaClick
      end
      object menIMEI: TMenuItem
        Caption = 'IMEI'
        OnClick = menIMEIClick
      end
      object menOperadora: TMenuItem
        Caption = 'Operadora'
        OnClick = menOperadoraClick
      end
      object menNivelSinal: TMenuItem
        Caption = 'N'#237'vel de Sinal'
        OnClick = menNivelSinalClick
      end
      object menModelo: TMenuItem
        Caption = 'Modelo'
        OnClick = menModeloClick
      end
      object menFabricante: TMenuItem
        Caption = 'Fabricante'
        OnClick = menFabricanteClick
      end
      object menFirmware: TMenuItem
        Caption = 'Firmware'
        OnClick = menFirmwareClick
      end
      object menSincronismo: TMenuItem
        Caption = 'Sincronismo'
        OnClick = menSincronismoClick
      end
    end
    object Mtodos1: TMenuItem
      Caption = 'M'#233'todos'
      object menMensagemEnviar: TMenuItem
        Caption = 'Enviar mensagem'
        OnClick = menMensagemEnviarClick
      end
      object menMensagemListar: TMenuItem
        Caption = 'Listar mensagens'
        OnClick = menMensagemListarClick
      end
      object menTrocarBandeja: TMenuItem
        Caption = 'Trocar bandeja'
        OnClick = menTrocarBandejaClick
      end
    end
    object Sobre1: TMenuItem
      Caption = 'Sobre'
      OnClick = Sobre1Click
    end
  end
end
