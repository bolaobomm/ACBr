unit ACBrNFSeDANFSeFRDM;

interface

uses
  SysUtils, Classes, frxClass, frxExportPDF, DB, DBClient, frxDBSet,
  ACBrNFSeDANFSeClass, pnfsNFSe, pcnConversao, pnfsConversao, frxBarcode, dialogs;

type
  TdmACBrNFSeFR = class(TDataModule)
    frxReport: TfrxReport;
    frxPDFExport: TfrxPDFExport;
    cdsIdentificacao: TClientDataSet;
    cdsPrestador: TClientDataSet;
    cdsServicos: TClientDataSet;
    frxIdentificacao: TfrxDBDataset;
    frxPrestador: TfrxDBDataset;
    frxTomador: TfrxDBDataset;
    frxServicos: TfrxDBDataset;
    cdsParametros: TClientDataSet;
    frxParametros: TfrxDBDataset;
    cdsIdentificacaoid: TStringField;
    cdsIdentificacaoNumero: TStringField;
    cdsIdentificacaoSerie: TStringField;
    cdsIdentificacaoTipo: TStringField;
    cdsIdentificacaoCompetencia: TStringField;
    cdsIdentificacaoNFSeSubstituida: TStringField;
    cdsIdentificacaoDataEmissao: TStringField;
    cdsIdentificacaoCodigoVerificacao: TStringField;
    cdsServicosItemListaServico: TStringField;
    cdsServicosCodigoCnae: TStringField;
    cdsServicosCodigoTributacaoMunicipio: TStringField;
    cdsServicosDiscriminacao: TStringField;
    cdsServicosCodigoPais: TStringField;
    cdsServicosNumeroProcesso: TStringField;
    cdsServicosxItemListaServico: TStringField;
    cdsServicosResponsavelRetencao: TStringField;
    cdsServicosDescricao: TStringField;
    cdsServicosValorServicos: TCurrencyField;
    cdsServicosValorDeducoes: TCurrencyField;
    cdsServicosValorPis: TCurrencyField;
    cdsServicosValorCofins: TCurrencyField;
    cdsServicosValorInss: TCurrencyField;
    cdsServicosValorIr: TCurrencyField;
    cdsServicosValorCsll: TCurrencyField;
    cdsServicosValorIss: TCurrencyField;
    cdsServicosOutrasRetencoes: TCurrencyField;
    cdsServicosBaseCalculo: TCurrencyField;
    cdsServicosAliquota: TCurrencyField;
    cdsServicosIssRetido: TStringField;
    cdsServicosValorLiquidoNfse: TCurrencyField;
    cdsServicosValorIssRetido: TCurrencyField;
    cdsServicosDescontoCondicionado: TCurrencyField;
    cdsServicosDescontoIncondicionado: TCurrencyField;
    cdsPrestadorCnpj: TStringField;
    cdsPrestadorInscricaoMunicipal: TStringField;
    cdsPrestadorRazaoSocial: TStringField;
    cdsPrestadorNomeFantasia: TStringField;
    cdsPrestadorEndereco: TStringField;
    cdsPrestadorNumero: TStringField;
    cdsPrestadorComplemento: TStringField;
    cdsPrestadorBairro: TStringField;
    cdsPrestadorCodigoMunicipio: TStringField;
    cdsPrestadorUF: TStringField;
    cdsPrestadorCEP: TStringField;
    cdsPrestadorxMunicipio: TStringField;
    cdsPrestadorCodigoPais: TStringField;
    cdsPrestadorTelefone: TStringField;
    cdsPrestadorEmail: TStringField;
    cdsTomador: TClientDataSet;
    StringField2: TStringField;
    StringField3: TStringField;
    StringField4: TStringField;
    StringField5: TStringField;
    StringField6: TStringField;
    StringField7: TStringField;
    StringField8: TStringField;
    StringField9: TStringField;
    StringField10: TStringField;
    StringField11: TStringField;
    StringField12: TStringField;
    StringField13: TStringField;
    StringField14: TStringField;
    StringField15: TStringField;
    cdsTomadorCpfCnpj: TStringField;
    cdsIdentificacaoNumeroNFSe: TStringField;
    cdsParametrosExigibilidadeISS: TStringField;
    cdsParametrosCodigoMunicipio: TStringField;
    cdsParametrosMunicipioIncidencia: TStringField;
    cdsParametrosLogoExpandido: TStringField;
    cdsParametrosImagem: TStringField;
    cdsParametrosLogoCarregado: TBlobField;
    cdsServicosTotalNota: TFloatField;
    cdsServicosTotalServicos: TFloatField;
    cdsParametrosimgPrefeitura: TStringField;
    cdsParametrosLogoPrefExpandido: TStringField;
    cdsParametrosLogoPrefCarregado: TBlobField;
    cdsParametrosNome_Prefeitura: TStringField;
    constructor Create(AOwner: TComponent); override;
  private
    FDANFSeClassOwner: TACBrNFSeDANFSeClass;
    FNFSe: TNFSe;
    procedure CarregaIdentificacao;
    procedure CarregaPrestador;
    procedure CarregaTomador;
    procedure CarregaServicos;
    procedure CarregaParametros;    
    { Private declarations }
  public
    { Public declarations }
    property NFSe: TNFSe read FNFSe write FNFSe;
    property DANFSeClassOwner: TACBrNFSeDANFSeClass read FDANFSeClassOwner;
    procedure CarregaDados;
  end;

var
  dmACBrNFSeFR: TdmACBrNFSeFR;

implementation

uses ACBrNFSe, ACBrNFeUtil, ACBrDFeUtil, StrUtils, Math;

{$R *.dfm}

{ TdmACBrNFSeFR }

procedure TdmACBrNFSeFR.CarregaDados;
begin
  CarregaIdentificacao;
  CarregaPrestador;
  CarregaTomador;
  CarregaServicos;
  CarregaParametros;
end;

procedure TdmACBrNFSeFR.CarregaIdentificacao;
begin
  with cdsIdentificacao do
  begin
    Close;
    CreateDataSet;
    Append;

    with FNFSe do
    begin    
      with infID do
      begin
        FieldByName('Id').AsString        := IdentificacaoRps.Numero+IdentificacaoRps.Serie;
      end;

      with IdentificacaoRps do
      begin
        FieldByName('Numero').AsString    := DFeUtil.FormatarNumeroDocumentoFiscal(Numero);
//        FieldByName('Serie').AsString     := Serie;
//        FieldByName('Tipo').AsString      := DFeUtil.SeSenao(Tipo = trRPS, '0','1');
      end;

      FieldByName('Competencia').AsString       := Competencia;
      FieldByName('NFSeSubstituida').AsString   := DFeUtil.FormatarNumeroDocumentoFiscal(NfseSubstituida);
      FieldByName('NumeroNFSe').AsString        := DFeUtil.FormatarNumeroDocumentoFiscal(Numero);
      FieldByName('DataEmissao').AsString       := DFeUtil.FormatDateTime(DateToStr(DataEmissao));
      FieldByName('CodigoVerificacao').AsString := CodigoVerificacao;
    end;

    Post;
  end;
end;

procedure TdmACBrNFSeFR.CarregaParametros;
var
  vStream: TMemoryStream;
  vStringStream: TStringStream;
begin
  with cdsParametros do
  begin
    Close;
    CreateDataSet;
    Append;

	with FNFse do
	begin
	  FieldByName('OutrasInformacoes').AsString			:= OutrasInformacoes;
	end;

    with FNFSe.Servico do
    begin
      FieldByName('CodigoMunicipio').AsString           := CodCidadeToCidade(StrToInt(CodigoMunicipio));
      FieldByName('ExigibilidadeISS').AsString          := DFeUtil.SeSenao(ExigibilidadeISS = exiExigivel,'Exig�vel', DFeUtil.SeSenao(ExigibilidadeISS = exiNaoIncidencia,'N�o Incid�ncia', DFeUtil.SeSenao(ExigibilidadeISS = exiIsencao,'Insen��o', DFeUtil.SeSenao(ExigibilidadeISS = exiExportacao,'Exporta��o', DFeUtil.SeSenao(ExigibilidadeISS = exiImunidade,'Imunidade', DFeUtil.SeSenao(ExigibilidadeISS = exiSuspensaDecisaoJudicial,'Suspensa Decisao Judicial','Suspensa Processo Administrativo'))))));
      FieldByName('MunicipioIncidencia').AsString       := CodCidadeToCidade(MunicipioIncidencia);
    end;

	with FNFSe.ConstrucaoCivil do
	begin
	  FieldByName('CodigoObra').AsString				:= CodigoObra;
	  FieldByName('Art').AsString					    	:= Art;
	end;

    // Carrega a Logo Prefeitura
    if DFeUtil.NaoEstaVazio(DANFSeClassOwner.Logo) then
    begin
      FieldByName('Nome_Prefeitura').AsString := DANFSeClassOwner.Prefeitura;
      FieldByName('imgPrefeitura').AsString   := DANFSeClassOwner.Logo;
      vStream := TMemoryStream.Create;
      try
        if FileExists(DANFSeClassOwner.Logo) then
          vStream.LoadFromFile(DANFSeClassOwner.Logo)
        else
        begin
          vStringStream := TStringStream.Create(DANFSeClassOwner.Logo);
          try
            vStream.LoadFromStream(vStringStream);
          finally
            vStringStream.Free;
          end;
        end;
        vStream.Position := 0;
        cdsParametrosLogoPrefCarregado.LoadFromStream(vStream);
      finally
        vStream.Free;
      end;
    end;

    // Carrega a Imagem Prestadora
    if DFeUtil.NaoEstaVazio(DANFSeClassOwner.PrestLogo) then
    begin
      FieldByName('Imagem').AsString := DANFSeClassOwner.PrestLogo;
      vStream := TMemoryStream.Create;
      try
        if FileExists(DANFSeClassOwner.PrestLogo) then
          vStream.LoadFromFile(DANFSeClassOwner.PrestLogo)
        else
        begin
          vStringStream := TStringStream.Create(DANFSeClassOwner.PrestLogo);
          try
            vStream.LoadFromStream(vStringStream);
          finally
            vStringStream.Free;
          end;
        end;
        vStream.Position := 0;
        cdsParametrosLogoCarregado.LoadFromStream(vStream);
      finally
        vStream.Free;
      end;
    end;

    // Prefeitura
    if DANFSeClassOwner.ExpandirLogoMarca then
      FieldByName('LogoPrefExpandido').AsString := '1'
    else
      FieldByName('LogoPrefExpandido').AsString := '0';

    // Prestador 
    if DANFSeClassOwner.ExpandirLogoMarca then
      FieldByName('LogoExpandido').AsString := '1'
    else
      FieldByName('LogoExpandido').AsString := '0';
    
    Post;
  end;
end;

procedure TdmACBrNFSeFR.CarregaPrestador;
begin
  with cdsPrestador do
  begin
    Close;
    CreateDataSet;
    Append;

    with FNFSe.PrestadorServico do
    begin
      FieldByName('RazaoSocial').AsString               := RazaoSocial;
      FieldByName('NomeFantasia').AsString              := NomeFantasia;

      with IdentificacaoPrestador do
      begin
        FieldByName('Cnpj').AsString                    := DFeUtil.FormatarCNPJ(Cnpj);
        FieldByName('InscricaoMunicipal').AsString      := InscricaoMunicipal;
      end;
      with Endereco do
      begin
        FieldByName('Endereco').AsString                := Endereco;
        FieldByName('Numero').AsString                  := Numero;
        FieldByName('Complemento').AsString             := Complemento;
        FieldByName('Bairro').AsString                  := Bairro;
        FieldByName('CodigoMunicipio').AsString         := CodigoMunicipio;
        FieldByName('UF').AsString                      := UF;
        FieldByName('CEP').AsString                     := DFeUtil.FormatarCEP(CEP);
        FieldByName('xMunicipio').AsString              := DFeUtil.CollateBr(xMunicipio);
        FieldByName('CodigoPais').AsString              := IntToStr(CodigoPais);
      end;
      with Contato do
      begin
        FieldByName('Telefone').AsString                := DFeUtil.FormatarFone(Telefone);
        FieldByName('Email').AsString                   := Email;
      end;
    end;
    Post;
  end;
end;

procedure TdmACBrNFSeFR.CarregaServicos;
var
  i: Integer;
  dValorNota: Double;
begin
  with cdsServicos do
  begin
    Close;
    CreateDataSet;
    Append;

    with FNFSe.Servico do
    begin
      FieldByName('ItemListaServico').AsString          := ItemListaServico;
      FieldByName('xItemListaServico').AsString         := xItemListaServico;
      FieldByName('CodigoCnae').AsString                := CodigoCnae;
      FieldByName('CodigoTributacaoMunicipio').AsString := CodigoTributacaoMunicipio;
      FieldByName('Discriminacao').AsString             := StringReplace(Discriminacao, ';', #13, [rfReplaceAll]);
      FieldByName('CodigoPais').AsString                := IntToStr(CodigoPais);
      FieldByName('NumeroProcesso').AsString            := NumeroProcesso;
//      FieldByName('ResponsavelRetencao').AsString       := DFeUtil.SeSenao(ResponsavelRetencao = rtPrestador,'0','1');
      FieldByName('Descricao').AsString                 := Descricao;

      with Valores do
      begin
        FieldByName('ValorServicos').AsFloat            := ValorServicos;
        FieldByName('ValorDeducoes').AsFloat            := ValorDeducoes;
        FieldByName('ValorPis').AsFloat                 := ValorPis;
        FieldByName('ValorCofins').AsFloat              := ValorCofins;
        FieldByName('ValorInss').AsFloat                := ValorInss;
        FieldByName('ValorIr').AsFloat                  := ValorIr;
        FieldByName('ValorCsll').AsFloat                := ValorCsll;
//        FieldByName('IssRetido').AsString               := DFeUtil.SeSenao(IssRetido = stRetencao,'0', DFeUtil.SeSenao(IssRetido = stNormal,'2','3'));
        FieldByName('ValorIss').AsFloat                 := ValorIss;
        FieldByName('OutrasRetencoes').AsFloat          := OutrasRetencoes;
        FieldByName('BaseCalculo').AsFloat              := BaseCalculo;
        FieldByName('Aliquota').AsFloat                 := Aliquota;
        FieldByName('ValorLiquidoNfse').AsFloat         := ValorLiquidoNfse;
        FieldByName('ValorIssRetido').AsFloat           := ValorIssRetido;
        FieldByName('DescontoCondicionado').AsFloat     := DescontoCondicionado;
        FieldByName('DescontoIncondicionado').AsFloat   := DescontoIncondicionado;
      end;
    end;
    Post;
  end;
end;

procedure TdmACBrNFSeFR.CarregaTomador;
begin
  with cdsTomador do
  begin
    Close;
    CreateDataSet;
    Append;

    with FNFSe.Tomador do
    begin
      FieldByName('RazaoSocial').AsString               := RazaoSocial;
      
      with IdentificacaoTomador do
      begin
        if DFeUtil.NaoEstaVazio(CpfCnpj) then
        begin
          if Length(CpfCnpj) > 11 then
            FieldByName('CpfCnpj').AsString := DFeUtil.FormatarCNPJ(CpfCnpj)
          else
            FieldByName('CpfCnpj').AsString := DFeUtil.FormatarCPF(CpfCnpj);
        end
        else
          FieldByName('CpfCnpj').AsString := '';
          
        FieldByName('InscricaoMunicipal').AsString      := InscricaoMunicipal;
      end;
      
      with Endereco do
      begin
        FieldByName('Endereco').AsString                := Endereco;
        FieldByName('Numero').AsString                  := Numero;
        FieldByName('Complemento').AsString             := Complemento;
        FieldByName('Bairro').AsString                  := Bairro;
        FieldByName('CodigoMunicipio').AsString         := CodigoMunicipio;
        FieldByName('UF').AsString                      := UF;
        FieldByName('CEP').AsString                     := DFeUtil.FormatarCEP(CEP);
        FieldByName('xMunicipio').AsString              := DFeUtil.CollateBr(xMunicipio);
        FieldByName('CodigoPais').AsString              := IntToStr(CodigoPais);
      end;
      
      with Contato do
      begin
        FieldByName('Telefone').AsString                := DFeUtil.FormatarFone(Telefone);
        FieldByName('Email').AsString                   := Email;
      end;
    end;
        
    Post;
  end;
end;

constructor TdmACBrNFSeFR.Create(AOwner: TComponent);
begin
  inherited;
  FDANFSeClassOwner := TACBrNFSeDANFSeClass(AOwner);
end;

end.