unit pnfsNFSeR;

interface

uses
  SysUtils, Classes, Forms,
{$IFNDEF VER130}
  Variants,
{$ENDIF}
  pcnAuxiliar, pcnConversao, pcnLeitor, pnfsNFSe, pnfsConversao,
  ACBrUtil, ACBrNFSeUtil, ACBrDFeUtil;

type

 TLeitorOpcoes   = class;

 TNFSeR = class(TPersistent)
  private
    FLeitor: TLeitor;
    FNFSe: TNFSe;
    FSchema: TpcnSchema;
    FOpcoes: TLeitorOpcoes;
    FVersaoXML: String;
    FProvedor: TnfseProvedor;

    procedure Rps_ProvedorfintelISS;
    procedure NFSe_ProvedorfintelISS;

    { Incluido po Jonatan }
    procedure Rps_ProvedorISSDigital;
    procedure NFSe_ProvedorISSDigital;

    procedure Rps_ProvedorSaatri;
    procedure NFSe_ProvedorSaatri;

		// Incluido por Cleiver
    procedure Rps_ProvedorGoiania;
    procedure NFSe_ProvedorGoiania;

    procedure Rps_ProvedorIssDsf;
    procedure NFSe_ProvedorIssDsf;

    procedure NFSe_Provedor4R;
    // incluido por Joel Takei 24/06/2013
    procedure NFSe_ProvedorISSe;
    procedure NFSe_ProvedorTiplan;
    procedure NFSe_ProvedorSimplISS;
    procedure NFSe_ProvedorVirtual;

    procedure Rps_ProvedorEquiplano;

    procedure Rps_Demais;
    procedure NFSe_Demais;

    function LerRPS: Boolean;
    function LerNFSe: Boolean;
  public
    constructor Create(AOwner: TNFSe);
    destructor Destroy; override;
    function LerXml: boolean;
  published
    property Leitor: TLeitor read FLeitor write FLeitor;
    property NFSe: TNFSe read FNFSe write FNFSe;
    property schema: TpcnSchema read Fschema write Fschema;
    property Opcoes: TLeitorOpcoes read FOpcoes write FOpcoes;
    property VersaoXML: String read FVersaoXML write FVersaoXML;
    property Provedor: TnfseProvedor read FProvedor write FProvedor;
  end;

 TLeitorOpcoes = class(TPersistent)
  private
    FPathArquivoMunicipios: string;
    FPathArquivoTabServicos: string;
  published
    property PathArquivoMunicipios: string read FPathArquivoMunicipios write FPathArquivoMunicipios;
    property PathArquivoTabServicos: string read FPathArquivoTabServicos write FPathArquivoTabServicos;
  end;

  ////////////////////////////////////////////////////////////////////////////////

implementation

{ TNFSeR }

constructor TNFSeR.Create(AOwner: TNFSe);
begin
 FLeitor := TLeitor.Create;
 FNFSe   := AOwner;
 FOpcoes := TLeitorOpcoes.Create;
 FOpcoes.FPathArquivoMunicipios  := '';
 FOpcoes.FPathArquivoTabServicos := '';
end;

destructor TNFSeR.Destroy;
begin
 FLeitor.Free;
 FOpcoes.Free;

 inherited Destroy;
end;

////////////////////////////////////////////////////////////////////////////////

procedure TNFSeR.Rps_ProvedorfintelISS;
var
 item, i: Integer;
 ok  : Boolean;
begin
 //By Lutzem Massao Aihara

 if (Leitor.rExtrai(1, 'InfDeclaracaoPrestacaoServico') <> '')
  then begin
   NFSe.Competencia              := Leitor.rCampo(tcStr, 'Competencia');
   NFSe.RegimeEspecialTributacao := StrToRegimeEspecialTributacao(ok, Leitor.rCampo(tcStr, 'RegimeEspecialTributacao'));
   NFSe.OptanteSimplesNacional   := StrToSimNao(ok, Leitor.rCampo(tcStr, 'OptanteSimplesNacional'));
   NFSe.IncentivadorCultural     := StrToSimNao(ok, Leitor.rCampo(tcStr, 'IncentivoFiscal'));
   NFSe.Producao                 := StrToSimNao(ok, Leitor.rCampo(tcStr, 'Producao'));

   if (Leitor.rExtrai(2, 'Prestador') <> '')
    then begin
     NFSe.PrestadorServico.IdentificacaoPrestador.InscricaoMunicipal := Leitor.rCampo(tcStr, 'InscricaoMunicipal');

     if VersaoXML='1'
      then begin
       if Leitor.rExtrai(4, 'CpfCnpj') <> ''
        then begin
          NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj := Leitor.rCampo(tcStr, 'Cpf');
          if NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj = ''
           then NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj := Leitor.rCampo(tcStr, 'Cnpj');
        end;
      end
      else begin
       if Leitor.rExtrai(3, 'CpfCnpj') <> ''
        then begin
          NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj := Leitor.rCampo(tcStr, 'Cpf');
          if NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj = ''
           then NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj := Leitor.rCampo(tcStr, 'Cnpj');
        end
        else
         NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj := Leitor.rCampo(tcStr, 'Cnpj');
      end;

      //...Oo...
      NFSe.Prestador.Cnpj := NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj;
      NFSe.Prestador.InscricaoMunicipal := NFSe.PrestadorServico.IdentificacaoPrestador.InscricaoMunicipal;
    end; // fim Prestador

   if (Leitor.rExtrai(2, 'ValoresServico') <> '')
    then begin
     NFSe.Servico.Valores.ValorServicos    := Leitor.rCampo(tcDe2, 'ValorServicos');
     NFSe.Servico.Valores.ValorLiquidoNfse := Leitor.rCampo(tcDe2, 'ValorLiquidoNfse');
     NFSe.Servico.Valores.ValorIss         := Leitor.rCampo(tcDe2, 'ValorIss');
    end;

   if (Leitor.rExtrai(2, 'Rps') <> '')
    then begin
     NFSe.DataEmissaoRps := Leitor.rCampo(tcDat, 'DataEmissao');
     NFSe.Status         := StrToStatusRPS(ok, Leitor.rCampo(tcStr, 'Status'));

     if (Leitor.rExtrai(2, 'IdentificacaoRps') <> '')
      then begin
       NFSe.IdentificacaoRps.Numero := Leitor.rCampo(tcStr, 'Numero');
       NFSe.IdentificacaoRps.Serie  := Leitor.rCampo(tcStr, 'Serie');
       NFSe.IdentificacaoRps.Tipo   := StrToTipoRPS(ok, Leitor.rCampo(tcStr, 'Tipo'));
       NFSe.InfID.ID                := SomenteNumeros(NFSe.IdentificacaoRps.Numero) + NFSe.IdentificacaoRps.Serie;
      end;
    end; // fim Rps

   if (Leitor.rExtrai(2, 'ListaServicos') <> '')
    then begin
     NFSe.Servico.Valores.IssRetido   := StrToSituacaoTributaria(ok, Leitor.rCampo(tcStr, 'IssRetido'));
     NFSe.Servico.ResponsavelRetencao := StrToResponsavelRetencao(ok, Leitor.rCampo(tcStr, 'ResponsavelRetencao'));
     NFSe.Servico.ItemListaServico    := DFeUtil.LimpaNumero(Leitor.rCampo(tcStr, 'ItemListaServico'));

     Item := StrToInt(SomenteNumeros(Nfse.Servico.ItemListaServico));
     if Item<100 then Item:=Item*100+1;

     NFSe.Servico.ItemListaServico := FormatFloat('0000', Item);
     NFSe.Servico.ItemListaServico := Copy(NFSe.Servico.ItemListaServico, 1, 2) + '.' +
                                      Copy(NFSe.Servico.ItemListaServico, 3, 2);

     NFSe.Servico.xItemListaServico := CodigoToDesc(SomenteNumeros(NFSe.Servico.ItemListaServico));

     //NFSe.Servico.Discriminacao       := Leitor.rCampo(tcStr, 'Discriminacao');
     NFSe.Servico.CodigoMunicipio     := Leitor.rCampo(tcStr, 'CodigoMunicipio');
     NFSe.Servico.CodigoPais          := Leitor.rCampo(tcInt, 'CodigoPais');
     NFSe.Servico.ExigibilidadeISS    := StrToExigibilidadeISS(ok, Leitor.rCampo(tcStr, 'ExigibilidadeISS'));
     NFSe.Servico.MunicipioIncidencia := Leitor.rCampo(tcInt, 'MunicipioIncidencia');

     NFSe.Servico.Valores.Aliquota    := Leitor.rCampo(tcDe3, 'Aliquota');

     //Se não me engano o maximo de servicos é 10...não?
     for I := 1 to 10
      do begin
       if (Leitor.rExtrai(2, 'Servico', 'Servico', i) <> '')
        then begin

         with NFSe.Servico.ItemServico.Add
          do begin
           Descricao       := Leitor.rCampo(tcStr, 'Discriminacao');

           if (Leitor.rExtrai(3, 'Valores') <> '')
            then begin
             ValorServicos := Leitor.rCampo(tcDe2, 'ValorServicos');
             ValorDeducoes := Leitor.rCampo(tcDe2, 'ValorDeducoes');
             ValorIss      := Leitor.rCampo(tcDe2, 'ValorIss');
             Aliquota      := Leitor.rCampo(tcDe3, 'Aliquota');
             BaseCalculo   := Leitor.rCampo(tcDe2, 'BaseCalculo');
            end;
         end;
        end else Break;
      end;

    end; // fim lista serviço
   (*
   if (Leitor.rExtrai(2, 'Prestador') <> '')
    then begin
     NFSe.Prestador.InscricaoMunicipal := Leitor.rCampo(tcStr, 'InscricaoMunicipal');

     if VersaoXML='1'
      then begin
       if Leitor.rExtrai(4, 'CpfCnpj') <> ''
        then begin
          NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj := Leitor.rCampo(tcStr, 'Cpf');
          if NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj = ''
           then NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj := Leitor.rCampo(tcStr, 'Cnpj');
        end;
      end
      else begin
       NFSe.Prestador.Cnpj := Leitor.rCampo(tcStr, 'Cnpj');
      end;

    end; // fim Prestador
   *)
   if (Leitor.rExtrai(2, 'TomadorServico') <> '')
    then begin
     NFSe.Tomador.RazaoSocial := Leitor.rCampo(tcStr, 'RazaoSocial');
     NFSe.Tomador.IdentificacaoTomador.InscricaoMunicipal := Leitor.rCampo(tcStr, 'InscricaoMunicipal');
     NFSe.Tomador.IdentificacaoTomador.InscricaoEstadual  := Leitor.rCampo(tcStr, 'InscricaoEstadual');

     if Leitor.rCampo(tcStr, 'Cpf')<>''
      then NFSe.Tomador.IdentificacaoTomador.CpfCnpj := Leitor.rCampo(tcStr, 'Cpf')
      else NFSe.Tomador.IdentificacaoTomador.CpfCnpj := Leitor.rCampo(tcStr, 'Cnpj');
     NFSe.Tomador.Endereco.Endereco := Leitor.rCampo(tcStr, 'Endereco');
     if Copy(NFSe.Tomador.Endereco.Endereco, 1, 10) = '<' + 'Endereco>'
      then NFSe.Tomador.Endereco.Endereco := Copy(NFSe.Tomador.Endereco.Endereco, 11, 125);

     NFSe.Tomador.Endereco.Numero      := Leitor.rCampo(tcStr, 'Numero');
     NFSe.Tomador.Endereco.Complemento := Leitor.rCampo(tcStr, 'Complemento');
     NFSe.Tomador.Endereco.Bairro      := Leitor.rCampo(tcStr, 'Bairro');

     if VersaoXML='1'
      then begin
       NFSe.Tomador.Endereco.CodigoMunicipio := Leitor.rCampo(tcStr, 'Cidade');
       NFSe.Tomador.Endereco.UF              := Leitor.rCampo(tcStr, 'Estado');
      end
      else begin
       NFSe.Tomador.Endereco.CodigoMunicipio := Leitor.rCampo(tcStr, 'CodigoMunicipio');
       NFSe.Tomador.Endereco.UF              := Leitor.rCampo(tcStr, 'Uf');
      end;

     NFSe.Tomador.Endereco.CEP := Leitor.rCampo(tcStr, 'Cep');

     if length(NFSe.Tomador.Endereco.CodigoMunicipio)<7
      then NFSe.Tomador.Endereco.CodigoMunicipio := Copy(NFSe.Tomador.Endereco.CodigoMunicipio, 1, 2) +
       FormatFloat('00000', StrToIntDef(Copy(NFSe.Tomador.Endereco.CodigoMunicipio, 3, 5), 0));

     if NFSe.Tomador.Endereco.UF = ''
      then NFSe.Tomador.Endereco.UF := NFSe.PrestadorServico.Endereco.UF;

     NFSe.Tomador.Endereco.xMunicipio := CodCidadeToCidade(StrToIntDef(NFSe.Tomador.Endereco.CodigoMunicipio, 0));

     if (Leitor.rExtrai(3, 'Contato') <> '')
      then begin
       NFSe.Tomador.Contato.Telefone := Leitor.rCampo(tcStr, 'Telefone');
       NFSe.Tomador.Contato.Email    := Leitor.rCampo(tcStr, 'Email');
      end;

    end; // fim Tomador

  end; // fim InfDeclaracaoPrestacaoServico
end;

procedure TNFSeR.Rps_ProvedorISSDigital;
var
 item, i: Integer;
 ok  : Boolean;
begin
 //By Lutzem Massao Aihara

 if (Leitor.rExtrai(1, 'InfDeclaracaoPrestacaoServico') <> '')
  then begin
   NFSe.Competencia              := Leitor.rCampo(tcStr, 'Competencia');
   NFSe.RegimeEspecialTributacao := StrToRegimeEspecialTributacao(ok, Leitor.rCampo(tcStr, 'RegimeEspecialTributacao'));
   NFSe.OptanteSimplesNacional   := StrToSimNao(ok, Leitor.rCampo(tcStr, 'OptanteSimplesNacional'));
   NFSe.IncentivadorCultural     := StrToSimNao(ok, Leitor.rCampo(tcStr, 'IncentivoFiscal'));
   NFSe.Producao                 := StrToSimNao(ok, Leitor.rCampo(tcStr, 'Producao'));

   if (Leitor.rExtrai(2, 'Prestador') <> '')
    then begin
     NFSe.PrestadorServico.IdentificacaoPrestador.InscricaoMunicipal := Leitor.rCampo(tcStr, 'InscricaoMunicipal');

     if VersaoXML='1'
      then begin
       if Leitor.rExtrai(4, 'CpfCnpj') <> ''
        then begin
          NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj := Leitor.rCampo(tcStr, 'Cpf');
          if NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj = ''
           then NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj := Leitor.rCampo(tcStr, 'Cnpj');
        end;
      end
      else begin
       if Leitor.rExtrai(3, 'CpfCnpj') <> ''
        then begin
          NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj := Leitor.rCampo(tcStr, 'Cpf');
          if NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj = ''
           then NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj := Leitor.rCampo(tcStr, 'Cnpj');
        end
        else
         NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj := Leitor.rCampo(tcStr, 'Cnpj');
      end;

      //...Oo...
      NFSe.Prestador.Cnpj := NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj;
      NFSe.Prestador.InscricaoMunicipal := NFSe.PrestadorServico.IdentificacaoPrestador.InscricaoMunicipal;
    end; // fim Prestador

   if (Leitor.rExtrai(2, 'ValoresServico') <> '')
    then begin
     NFSe.Servico.Valores.ValorServicos    := Leitor.rCampo(tcDe2, 'ValorServicos');
     NFSe.Servico.Valores.ValorLiquidoNfse := Leitor.rCampo(tcDe2, 'ValorLiquidoNfse');
     NFSe.Servico.Valores.ValorIss         := Leitor.rCampo(tcDe2, 'ValorIss');
    end;

   if (Leitor.rExtrai(2, 'Rps') <> '')
    then begin
     NFSe.DataEmissaoRps := Leitor.rCampo(tcDat, 'DataEmissao');
     NFSe.Status         := StrToStatusRPS(ok, Leitor.rCampo(tcStr, 'Status'));

     if (Leitor.rExtrai(2, 'IdentificacaoRps') <> '')
      then begin
       NFSe.IdentificacaoRps.Numero := Leitor.rCampo(tcStr, 'Numero');
       NFSe.IdentificacaoRps.Serie  := Leitor.rCampo(tcStr, 'Serie');
       NFSe.IdentificacaoRps.Tipo   := StrToTipoRPS(ok, Leitor.rCampo(tcStr, 'Tipo'));
       NFSe.InfID.ID                := SomenteNumeros(NFSe.IdentificacaoRps.Numero) + NFSe.IdentificacaoRps.Serie;
      end;
    end; // fim Rps

   if (Leitor.rExtrai(2, 'ListaServicos') <> '')
    then begin
     NFSe.Servico.Valores.IssRetido   := StrToSituacaoTributaria(ok, Leitor.rCampo(tcStr, 'IssRetido'));
     NFSe.Servico.ResponsavelRetencao := StrToResponsavelRetencao(ok, Leitor.rCampo(tcStr, 'ResponsavelRetencao'));
     NFSe.Servico.ItemListaServico    := DFeUtil.LimpaNumero(Leitor.rCampo(tcStr, 'ItemListaServico'));

     Item := StrToInt(SomenteNumeros(Nfse.Servico.ItemListaServico));
     if Item<100 then Item:=Item*100+1;

     NFSe.Servico.ItemListaServico := FormatFloat('0000', Item);
     NFSe.Servico.ItemListaServico := Copy(NFSe.Servico.ItemListaServico, 1, 2) + '.' +
                                      Copy(NFSe.Servico.ItemListaServico, 3, 2);

     NFSe.Servico.xItemListaServico := CodigoToDesc(SomenteNumeros(NFSe.Servico.ItemListaServico));

     //NFSe.Servico.Discriminacao       := Leitor.rCampo(tcStr, 'Discriminacao');
     NFSe.Servico.CodigoMunicipio     := Leitor.rCampo(tcStr, 'CodigoMunicipio');
     NFSe.Servico.CodigoPais          := Leitor.rCampo(tcInt, 'CodigoPais');
     NFSe.Servico.ExigibilidadeISS    := StrToExigibilidadeISS(ok, Leitor.rCampo(tcStr, 'ExigibilidadeISS'));
     NFSe.Servico.MunicipioIncidencia := Leitor.rCampo(tcInt, 'MunicipioIncidencia');

     NFSe.Servico.Valores.Aliquota    := Leitor.rCampo(tcDe3, 'Aliquota');

     //Se não me engano o maximo de servicos é 10...não?
     for I := 1 to 10
      do begin
       if (Leitor.rExtrai(2, 'Servico', 'Servico', i) <> '')
        then begin

         with NFSe.Servico.ItemServico.Add
          do begin
           Descricao       := Leitor.rCampo(tcStr, 'Discriminacao');

           if (Leitor.rExtrai(3, 'Valores') <> '')
            then begin
             ValorServicos := Leitor.rCampo(tcDe2, 'ValorServicos');
             ValorDeducoes := Leitor.rCampo(tcDe2, 'ValorDeducoes');
             ValorIss      := Leitor.rCampo(tcDe2, 'ValorIss');
             Aliquota      := Leitor.rCampo(tcDe3, 'Aliquota');
             BaseCalculo   := Leitor.rCampo(tcDe2, 'BaseCalculo');
            end;
         end;
        end else Break;
      end;

    end; // fim lista serviço
   (*
   if (Leitor.rExtrai(2, 'Prestador') <> '')
    then begin
     NFSe.Prestador.InscricaoMunicipal := Leitor.rCampo(tcStr, 'InscricaoMunicipal');

     if VersaoXML='1'
      then begin
       if Leitor.rExtrai(4, 'CpfCnpj') <> ''
        then begin
          NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj := Leitor.rCampo(tcStr, 'Cpf');
          if NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj = ''
           then NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj := Leitor.rCampo(tcStr, 'Cnpj');
        end;
      end
      else begin
       NFSe.Prestador.Cnpj := Leitor.rCampo(tcStr, 'Cnpj');
      end;

    end; // fim Prestador
   *)
   if (Leitor.rExtrai(2, 'TomadorServico') <> '')
    then begin
     NFSe.Tomador.RazaoSocial := Leitor.rCampo(tcStr, 'RazaoSocial');
     NFSe.Tomador.IdentificacaoTomador.InscricaoMunicipal := Leitor.rCampo(tcStr, 'InscricaoMunicipal');
     NFSe.Tomador.IdentificacaoTomador.InscricaoEstadual  := Leitor.rCampo(tcStr, 'InscricaoEstadual');

     if Leitor.rCampo(tcStr, 'Cpf')<>''
      then NFSe.Tomador.IdentificacaoTomador.CpfCnpj := Leitor.rCampo(tcStr, 'Cpf')
      else NFSe.Tomador.IdentificacaoTomador.CpfCnpj := Leitor.rCampo(tcStr, 'Cnpj');
     NFSe.Tomador.Endereco.Endereco := Leitor.rCampo(tcStr, 'Endereco');
     if Copy(NFSe.Tomador.Endereco.Endereco, 1, 10) = '<' + 'Endereco>'
      then NFSe.Tomador.Endereco.Endereco := Copy(NFSe.Tomador.Endereco.Endereco, 11, 125);

     NFSe.Tomador.Endereco.Numero      := Leitor.rCampo(tcStr, 'Numero');
     NFSe.Tomador.Endereco.Complemento := Leitor.rCampo(tcStr, 'Complemento');
     NFSe.Tomador.Endereco.Bairro      := Leitor.rCampo(tcStr, 'Bairro');

     if VersaoXML='1'
      then begin
       NFSe.Tomador.Endereco.CodigoMunicipio := Leitor.rCampo(tcStr, 'Cidade');
       NFSe.Tomador.Endereco.UF              := Leitor.rCampo(tcStr, 'Estado');
      end
      else begin
       NFSe.Tomador.Endereco.CodigoMunicipio := Leitor.rCampo(tcStr, 'CodigoMunicipio');
       NFSe.Tomador.Endereco.UF              := Leitor.rCampo(tcStr, 'Uf');
      end;

     NFSe.Tomador.Endereco.CEP := Leitor.rCampo(tcStr, 'Cep');

     if length(NFSe.Tomador.Endereco.CodigoMunicipio)<7
      then NFSe.Tomador.Endereco.CodigoMunicipio := Copy(NFSe.Tomador.Endereco.CodigoMunicipio, 1, 2) +
       FormatFloat('00000', StrToIntDef(Copy(NFSe.Tomador.Endereco.CodigoMunicipio, 3, 5), 0));

     if NFSe.Tomador.Endereco.UF = ''
      then NFSe.Tomador.Endereco.UF := NFSe.PrestadorServico.Endereco.UF;

     NFSe.Tomador.Endereco.xMunicipio := CodCidadeToCidade(StrToIntDef(NFSe.Tomador.Endereco.CodigoMunicipio, 0));

     if (Leitor.rExtrai(3, 'Contato') <> '')
      then begin
       NFSe.Tomador.Contato.Telefone := Leitor.rCampo(tcStr, 'Telefone');
       NFSe.Tomador.Contato.Email    := Leitor.rCampo(tcStr, 'Email');
      end;

    end; // fim Tomador

  end; // fim InfDeclaracaoPrestacaoServico
end;

procedure TNFSeR.Rps_ProvedorSaatri;
var
 item: Integer;
 ok  : Boolean;
begin
 if Leitor.rExtrai(2, 'InfDeclaracaoPrestacaoServico') <> ''
  then begin
   NFSe.Competencia              := Leitor.rCampo(tcStr, 'Competencia');
   NFSe.RegimeEspecialTributacao := StrToRegimeEspecialTributacao(ok, Leitor.rCampo(tcStr, 'RegimeEspecialTributacao'));
   NFSe.OptanteSimplesNacional   := StrToSimNao(ok, Leitor.rCampo(tcStr, 'OptanteSimplesNacional'));
   NFSe.IncentivadorCultural     := StrToSimNao(ok, Leitor.rCampo(tcStr, 'IncentivoFiscal'));

   if (Leitor.rExtrai(3, 'Rps') <> '')
    then begin
     NFSe.DataEmissaoRps := Leitor.rCampo(tcDat, 'DataEmissao');
     NFSe.Status         := StrToStatusRPS(ok, Leitor.rCampo(tcStr, 'Status'));

     if (Leitor.rExtrai(3, 'IdentificacaoRps') <> '')
      then begin
       NFSe.IdentificacaoRps.Numero := Leitor.rCampo(tcStr, 'Numero');
       NFSe.IdentificacaoRps.Serie  := Leitor.rCampo(tcStr, 'Serie');
       NFSe.IdentificacaoRps.Tipo   := StrToTipoRPS(ok, Leitor.rCampo(tcStr, 'Tipo'));
       NFSe.InfID.ID                := SomenteNumeros(NFSe.IdentificacaoRps.Numero) + NFSe.IdentificacaoRps.Serie;
      end;
    end;

   if (Leitor.rExtrai(3, 'Servico') <> '')
    then begin
     NFSe.Servico.Valores.IssRetido   := StrToSituacaoTributaria(ok, Leitor.rCampo(tcStr, 'IssRetido'));
     NFSe.Servico.ResponsavelRetencao := StrToResponsavelRetencao(ok, Leitor.rCampo(tcStr, 'ResponsavelRetencao'));
     NFSe.Servico.ItemListaServico    := DFeUtil.LimpaNumero(Leitor.rCampo(tcStr, 'ItemListaServico'));

     Item := StrToInt(SomenteNumeros(Nfse.Servico.ItemListaServico));
     if Item<100 then Item:=Item*100+1;

     NFSe.Servico.ItemListaServico := FormatFloat('0000', Item);
     NFSe.Servico.ItemListaServico := Copy(NFSe.Servico.ItemListaServico, 1, 2) + '.' +
                                      Copy(NFSe.Servico.ItemListaServico, 3, 2);

     NFSe.Servico.xItemListaServico := CodigoToDesc(SomenteNumeros(NFSe.Servico.ItemListaServico));

     NFSe.Servico.Discriminacao       := Leitor.rCampo(tcStr, 'Discriminacao');
     NFSe.Servico.Descricao           := '';
     NFSe.Servico.CodigoMunicipio     := Leitor.rCampo(tcStr, 'CodigoMunicipio');
     NFSe.Servico.CodigoPais          := Leitor.rCampo(tcInt, 'CodigoPais');
     NFSe.Servico.ExigibilidadeISS    := StrToExigibilidadeISS(ok, Leitor.rCampo(tcStr, 'ExigibilidadeISS'));
     NFSe.Servico.MunicipioIncidencia := Leitor.rCampo(tcInt, 'MunicipioIncidencia');

     if (Leitor.rExtrai(4, 'Valores') <> '')
      then begin
       NFSe.Servico.Valores.ValorServicos          := Leitor.rCampo(tcDe2, 'ValorServicos');
       NFSe.Servico.Valores.ValorIss               := Leitor.rCampo(tcDe2, 'ValorIss');
       NFSe.Servico.Valores.Aliquota               := Leitor.rCampo(tcDe3, 'Aliquota');
      end;

    end; // fim serviço

   if (Leitor.rExtrai(3, 'Prestador') <> '')
    then begin
     NFSe.Prestador.InscricaoMunicipal := Leitor.rCampo(tcStr, 'InscricaoMunicipal');

     if VersaoXML='1'
      then begin
       if Leitor.rExtrai(4, 'CpfCnpj') <> ''
        then begin
          NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj := Leitor.rCampo(tcStr, 'Cpf');
          if NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj = ''
           then NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj := Leitor.rCampo(tcStr, 'Cnpj');
        end;
      end
      else begin
       NFSe.Prestador.Cnpj := Leitor.rCampo(tcStr, 'Cnpj');
      end;

    end; // fim Prestador

   if (Leitor.rExtrai(3, 'Tomador') <> '')
    then begin
     NFSe.Tomador.RazaoSocial := Leitor.rCampo(tcStr, 'RazaoSocial');

     if (Leitor.rExtrai(4, 'IdentificacaoTomador') <> '')
      then begin
       NFSe.Tomador.IdentificacaoTomador.InscricaoMunicipal := Leitor.rCampo(tcStr, 'InscricaoMunicipal');

       if Leitor.rExtrai(5, 'CpfCnpj') <> ''
        then begin
         if Leitor.rCampo(tcStr, 'Cpf')<>''
          then NFSe.Tomador.IdentificacaoTomador.CpfCnpj := Leitor.rCampo(tcStr, 'Cpf')
          else NFSe.Tomador.IdentificacaoTomador.CpfCnpj := Leitor.rCampo(tcStr, 'Cnpj');
        end;
      end;

     if (Leitor.rExtrai(4, 'Endereco') <> '')
      then begin
       NFSe.Tomador.Endereco.Endereco := Leitor.rCampo(tcStr, 'Endereco');
       if Copy(NFSe.Tomador.Endereco.Endereco, 1, 10) = '<' + 'Endereco>'
        then NFSe.Tomador.Endereco.Endereco := Copy(NFSe.Tomador.Endereco.Endereco, 11, 125);

       NFSe.Tomador.Endereco.Numero      := Leitor.rCampo(tcStr, 'Numero');
       NFSe.Tomador.Endereco.Complemento := Leitor.rCampo(tcStr, 'Complemento');
       NFSe.Tomador.Endereco.Bairro      := Leitor.rCampo(tcStr, 'Bairro');

       if VersaoXML='1'
        then begin
         NFSe.Tomador.Endereco.CodigoMunicipio := Leitor.rCampo(tcStr, 'Cidade');
         NFSe.Tomador.Endereco.UF              := Leitor.rCampo(tcStr, 'Estado');
        end
        else begin
         NFSe.Tomador.Endereco.CodigoMunicipio := Leitor.rCampo(tcStr, 'CodigoMunicipio');
         NFSe.Tomador.Endereco.UF              := Leitor.rCampo(tcStr, 'Uf');
        end;

       NFSe.Tomador.Endereco.CEP := Leitor.rCampo(tcStr, 'Cep');

       if length(NFSe.Tomador.Endereco.CodigoMunicipio)<7
        then NFSe.Tomador.Endereco.CodigoMunicipio := Copy(NFSe.Tomador.Endereco.CodigoMunicipio, 1, 2) +
          FormatFloat('00000', StrToIntDef(Copy(NFSe.Tomador.Endereco.CodigoMunicipio, 3, 5), 0));

       if NFSe.Tomador.Endereco.UF = ''
        then NFSe.Tomador.Endereco.UF := NFSe.PrestadorServico.Endereco.UF;

       NFSe.Tomador.Endereco.xMunicipio := CodCidadeToCidade(StrToIntDef(NFSe.Tomador.Endereco.CodigoMunicipio, 0));

      end;

     if (Leitor.rExtrai(4, 'Contato') <> '')
      then begin
       NFSe.Tomador.Contato.Telefone := Leitor.rCampo(tcStr, 'Telefone');
       NFSe.Tomador.Contato.Email    := Leitor.rCampo(tcStr, 'Email');
      end;

    end; // fim Tomador
  end; // fim InfDeclaracaoPrestacaoServico

end;

procedure TNFSeR.Rps_ProvedorGoiania;
var
// item: Integer;
 ok  : Boolean;
begin
 	if Leitor.rExtrai(1, 'InfDeclaracaoPrestacaoServico') <> '' then
	begin

   if (Leitor.rExtrai(2, 'Rps') <> '')
    then begin
     NFSe.DataEmissaoRps := Leitor.rCampo(tcDat, 'DataEmissao');
     NFSe.Status         := StrToStatusRPS(ok, Leitor.rCampo(tcStr, 'Status'));

     if (Leitor.rExtrai(2, 'IdentificacaoRps') <> '')
      then begin
       NFSe.IdentificacaoRps.Numero := Leitor.rCampo(tcStr, 'Numero');
       NFSe.IdentificacaoRps.Serie  := Leitor.rCampo(tcStr, 'Serie');
       NFSe.IdentificacaoRps.Tipo   := StrToTipoRPS(ok, Leitor.rCampo(tcStr, 'Tipo'));
       NFSe.InfID.ID                := SomenteNumeros(NFSe.IdentificacaoRps.Numero) + NFSe.IdentificacaoRps.Serie;
      end;
    end;

   if (Leitor.rExtrai(2, 'Servico') <> '')
    then begin
     NFSe.Servico.CodigoTributacaoMunicipio := Leitor.rCampo(tcStr, 'CodigoTributacaoMunicipio');
     NFSe.Servico.Discriminacao       			:= Leitor.rCampo(tcStr, 'Discriminacao');
     NFSe.Servico.Descricao                 := '';
     NFSe.Servico.CodigoMunicipio     			:= Leitor.rCampo(tcStr, 'CodigoMunicipio');

     if (Leitor.rExtrai(2, 'Valores') <> '')
      then begin
       NFSe.Servico.Valores.ValorServicos          := Leitor.rCampo(tcDe2, 'ValorServicos');
       NFSe.Servico.Valores.ValorPis               := Leitor.rCampo(tcDe2, 'ValorPis');
       NFSe.Servico.Valores.ValorCofins            := Leitor.rCampo(tcDe2, 'ValorCofins');
       NFSe.Servico.Valores.ValorInss              := Leitor.rCampo(tcDe2, 'ValorInss');
       NFSe.Servico.Valores.ValorIr                := Leitor.rCampo(tcDe2, 'ValorIr');
       NFSe.Servico.Valores.ValorCsll              := Leitor.rCampo(tcDe2, 'ValorCsll');
       NFSe.Servico.Valores.Aliquota               := Leitor.rCampo(tcDe3, 'Aliquota');
       NFSe.Servico.Valores.DescontoIncondicionado := Leitor.rCampo(tcDe3, 'DescontoIncondicionado');
      end;

    end; // fim serviço

   if (Leitor.rExtrai(2, 'Prestador') <> '')
    then begin
     NFSe.Prestador.InscricaoMunicipal := Leitor.rCampo(tcStr, 'InscricaoMunicipal');

     if VersaoXML='1'
      then begin
       if Leitor.rExtrai(4, 'CpfCnpj') <> ''
        then begin
          NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj := Leitor.rCampo(tcStr, 'Cpf');
          if NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj = ''
           then NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj := Leitor.rCampo(tcStr, 'Cnpj');
        end;
      end
      else begin
       NFSe.Prestador.Cnpj := Leitor.rCampo(tcStr, 'Cnpj');
      end;

    end; // fim Prestador

   	if (Leitor.rExtrai(2, 'Tomador') <> '') then
		begin
     	NFSe.Tomador.RazaoSocial              := Leitor.rCampo(tcStr, 'RazaoSocial');
      NFSe.Tomador.Endereco.Endereco        := Leitor.rCampo(tcStr, 'Endereco');
      if Copy(NFSe.Tomador.Endereco.Endereco, 1, 10) = '<' + 'Endereco>' then
				NFSe.Tomador.Endereco.Endereco      := Copy(NFSe.Tomador.Endereco.Endereco, 11, 125);
      NFSe.Tomador.Endereco.Numero          := Leitor.rCampo(tcStr, 'Numero');
      NFSe.Tomador.Endereco.Complemento     := Leitor.rCampo(tcStr, 'Complemento');
      NFSe.Tomador.Endereco.Bairro          := Leitor.rCampo(tcStr, 'Bairro');
      NFSe.Tomador.Endereco.CEP             := Leitor.rCampo(tcStr, 'Cep');
     	NFSe.Tomador.Endereco.CodigoMunicipio := Leitor.rCampo(tcStr, 'CodigoMunicipio');
     	NFSe.Tomador.Endereco.UF              := Leitor.rCampo(tcStr, 'Uf');
     	NFSe.Tomador.IdentificacaoTomador.InscricaoMunicipal := Leitor.rCampo(tcStr, 'InscricaoMunicipal');
     	if Leitor.rCampo(tcStr, 'Cpf')<>'' then
				NFSe.Tomador.IdentificacaoTomador.CpfCnpj := Leitor.rCampo(tcStr, 'Cpf')
     	else
				NFSe.Tomador.IdentificacaoTomador.CpfCnpj := Leitor.rCampo(tcStr, 'Cnpj');

    end; // fim Tomador
  end; // fim InfDeclaracaoPrestacaoServico
end;

procedure TNFSeR.Rps_ProvedorIssDsf;
var ok  : Boolean;
    sOperacao, sTributacao: string;
begin
   VersaoXML := '1'; // para este provedor usar padrão "1".

   if (Leitor.rExtrai(1, 'Rps') <> '') then begin

      NFSe.DataEmissao := Leitor.rCampo(tcDatHor, 'DataEmissaoRPS');
      NFSe.Status      := StrToEnumerado(ok, Leitor.rCampo(tcStr, 'Status'),['N','C'],[srNormal, srCancelado]);

      NFSe.IdentificacaoRps.Numero := Leitor.rCampo(tcStr, 'NumeroRPS');
      NFSe.IdentificacaoRps.Serie  := Leitor.rCampo(tcStr, 'SerieRPS');
      NFSe.IdentificacaoRps.Tipo   := trRPS;//StrToTipoRPS(ok, Leitor.rCampo(tcStr, 'Tipo'));
      NFSe.InfID.ID                := SomenteNumeros(NFSe.IdentificacaoRps.Numero);// + NFSe.IdentificacaoRps.Serie;
      NFSe.SeriePrestacao          := Leitor.rCampo(tcStr, 'SeriePrestacao');

     	NFSe.Tomador.RazaoSocial              := Leitor.rCampo(tcStr, 'RazaoSocialTomador');

      NFSe.Tomador.Endereco.TipoLogradouro  := Leitor.rCampo(tcStr, 'TipoLogradouroTomador');
      NFSe.Tomador.Endereco.Endereco        := Leitor.rCampo(tcStr, 'LogradouroTomador');

      NFSe.Tomador.Endereco.Numero          := Leitor.rCampo(tcStr, 'NumeroEnderecoTomador');
      NFSe.Tomador.Endereco.Complemento     := Leitor.rCampo(tcStr, 'ComplementoEnderecoTomador');
      NFSe.Tomador.Endereco.TipoBairro      := Leitor.rCampo(tcStr, 'TipoBairroTomador');
      NFSe.Tomador.Endereco.Bairro          := Leitor.rCampo(tcStr, 'BairroTomador');
      NFSe.Tomador.Endereco.CEP             := Leitor.rCampo(tcStr, 'CEPTomador');
     	NFSe.Tomador.Endereco.CodigoMunicipio := CodSiafiToCodCidade( Leitor.rCampo(tcStr, 'CidadeTomador')) ;
     	NFSe.Tomador.Endereco.UF              := Leitor.rCampo(tcStr, 'Uf');
     	NFSe.Tomador.IdentificacaoTomador.InscricaoMunicipal := Leitor.rCampo(tcStr, 'InscricaoMunicipalTomador');
     	NFSe.Tomador.IdentificacaoTomador.CpfCnpj := Leitor.rCampo(tcStr, 'CPFCNPJTomador');
      NFSe.Tomador.IdentificacaoTomador.DocTomadorEstrangeiro := 'DocTomadorEstrangeiro';
      NFSe.Tomador.Contato.Email := Leitor.rCampo(tcStr, 'EmailTomador');

      NFSe.Servico.CodigoCnae := Leitor.rCampo(tcStr, 'CodigoAtividade');
      NFSe.Servico.Valores.Aliquota := Leitor.rCampo(tcDe3, 'AliquotaAtividade');

      NFSe.Servico.Valores.IssRetido := StrToEnumerado( ok, Leitor.rCampo(tcStr, 'TipoRecolhimento'),
                                                        ['A','R'], [ stNormal, stRetencao{, stSubstituicao}]);

      NFSe.Servico.CodigoMunicipio := CodSiafiToCodCidade( Leitor.rCampo(tcStr, 'MunicipioPrestacao'));

      sOperacao   := AnsiUpperCase(Leitor.rCampo(tcStr, 'Operacao'));
      sTributacao := AnsiUpperCase(Leitor.rCampo(tcStr, 'Tributacao'));


      if sOperacao[1] in ['A', 'B'] then begin

         if (sOperacao = 'A') and (sTributacao = 'N') then
            NFSe.NaturezaOperacao := noNaoIncidencia
         else if sTributacao = 'G' then
            NFSe.NaturezaOperacao := noTributacaoForaMunicipio
         else if sTributacao = 'T' then
            NFSe.NaturezaOperacao := noTributacaoNoMunicipio;
      end
      else if (sOperacao = 'C') and (sTributacao = 'C') then begin
         NFSe.NaturezaOperacao := noIsencao;
      end
      else if (sOperacao = 'C') and (sTributacao = 'F') then begin
         NFSe.NaturezaOperacao := noImune;
      end;

      NFSe.NaturezaOperacao := StrToEnumerado( ok,sTributacao, ['T','K'], [ NFSe.NaturezaOperacao, noSuspensaDecisaoJudicial ]);

      NFSe.OptanteSimplesNacional := StrToEnumerado( ok,sTributacao, ['T','H'], [ snNao, snSim ]);

      NFSe.DeducaoMateriais := StrToEnumerado( ok,sOperacao, ['A','B'], [ snNao, snSim ]);

      NFse.RegimeEspecialTributacao := StrToEnumerado( ok,sTributacao, ['T','M'], [ retNenhum, retMicroempresarioIndividual ]);


      //NFSe.Servico.Valores.ValorServicos          :=
      //NFSe.Servico.Valores.ValorDeducoes          :=
      NFSe.Servico.Valores.ValorPis               := Leitor.rCampo(tcDe2, 'ValorPIS');
      NFSe.Servico.Valores.ValorCofins            := Leitor.rCampo(tcDe2, 'ValorCOFINS');
      NFSe.Servico.Valores.ValorInss              := Leitor.rCampo(tcDe2, 'ValorINSS');
      NFSe.Servico.Valores.ValorIr                := Leitor.rCampo(tcDe2, 'ValorIR');
      NFSe.Servico.Valores.ValorCsll              := Leitor.rCampo(tcDe2, 'ValorCSLL');
      //NFSe.Servico.Valores.ValorIss               :=
      NFSe.Servico.Valores.AliquotaPIS            := Leitor.rCampo(tcDe2, 'AliquotaPIS');
      NFSe.Servico.Valores.AliquotaCOFINS         := Leitor.rCampo(tcDe2, 'AliquotaCOFINS');
      NFSe.Servico.Valores.AliquotaINSS           := Leitor.rCampo(tcDe2, 'AliquotaINSS');
      NFSe.Servico.Valores.AliquotaIR             := Leitor.rCampo(tcDe2, 'AliquotaIR');
      NFSe.Servico.Valores.AliquotaCSLL           := Leitor.rCampo(tcDe2, 'AliquotaCSLL');

      NFSe.OutrasInformacoes := Leitor.rCampo(tcStr, 'DescricaoRPS');

      NFSe.PrestadorServico.Contato.Telefone := Leitor.rCampo(tcStr, 'DDDPrestador') + Leitor.rCampo(tcStr, 'TelefonePrestador');
      NFSe.Tomador.Contato.Telefone          := Leitor.rCampo(tcStr, 'DDDTomador') + Leitor.rCampo(tcStr, 'TelefoneTomador');

      NFSE.MotivoCancelamento := Leitor.rCampo(tcStr, 'MotCancelamento');

      NFSe.IntermediarioServico.CpfCnpj := Leitor.rCampo(tcStr, 'CpfCnpjIntermediario');

  end; // fim Rps

end;

procedure TNFSeR.Rps_Demais;
var
 item: Integer;
 ok  : Boolean;
begin
 if (Leitor.rExtrai(2, 'InfRps') <> '') or (Leitor.rExtrai(1, 'Rps') <> '')
  then begin
   NFSe.DataEmissaoRps           := Leitor.rCampo(tcDat, 'DataEmissao');

   if (Leitor.rExtrai(1, 'InfRps') <> '')
    then NFSe.DataEmissao        := Leitor.rCampo(tcDatHor, 'DataEmissao');

   NFSe.NaturezaOperacao         := StrToNaturezaOperacao(ok, Leitor.rCampo(tcStr, 'NaturezaOperacao'));
   NFSe.RegimeEspecialTributacao := StrToRegimeEspecialTributacao(ok, Leitor.rCampo(tcStr, 'RegimeEspecialTributacao'));
   NFSe.OptanteSimplesNacional   := StrToSimNao(ok, Leitor.rCampo(tcStr, 'OptanteSimplesNacional'));
   NFSe.IncentivadorCultural     := StrToSimNao(ok, Leitor.rCampo(tcStr, 'IncentivadorCultural'));
   NFSe.Status                   := StrToStatusRPS(ok, Leitor.rCampo(tcStr, 'Status'));

   if (Leitor.rExtrai(3, 'IdentificacaoRps') <> '') or (Leitor.rExtrai(2, 'IdentificacaoRps') <> '')
    then begin
     NFSe.IdentificacaoRps.Numero := Leitor.rCampo(tcStr, 'Numero');
     NFSe.IdentificacaoRps.Serie  := Leitor.rCampo(tcStr, 'Serie');
     NFSe.IdentificacaoRps.Tipo   := StrToTipoRPS(ok, Leitor.rCampo(tcStr, 'Tipo'));
     NFSe.InfID.ID                := SomenteNumeros(NFSe.IdentificacaoRps.Numero) + NFSe.IdentificacaoRps.Serie;
    end;

   if (Leitor.rExtrai(3, 'RpsSubstituido') <> '') or (Leitor.rExtrai(2, 'RpsSubstituido') <> '')
    then begin
     NFSe.RpsSubstituido.Numero := Leitor.rCampo(tcStr, 'Numero');
     NFSe.RpsSubstituido.Serie  := Leitor.rCampo(tcStr, 'Serie');
     NFSe.RpsSubstituido.Tipo   := StrToTipoRPS(ok, Leitor.rCampo(tcStr, 'Tipo'));
    end;

   if (Leitor.rExtrai(3, 'Servico') <> '') or (Leitor.rExtrai(2, 'Servico') <> '')
    then begin
     NFSe.Servico.ItemListaServico          := DFeUtil.LimpaNumero(Leitor.rCampo(tcStr, 'ItemListaServico'));
     NFSe.Servico.CodigoTributacaoMunicipio := Leitor.rCampo(tcStr, 'CodigoTributacaoMunicipio');
     NFSe.Servico.Discriminacao             := Leitor.rCampo(tcStr, 'Discriminacao');
     NFSe.Servico.Descricao                 := '';

     if VersaoXML='1'
      then NFSe.Servico.CodigoMunicipio := Leitor.rCampo(tcStr, 'MunicipioPrestacaoServico')
      else NFSe.Servico.CodigoMunicipio := Leitor.rCampo(tcStr, 'CodigoMunicipio');

     Item := StrToInt(SomenteNumeros(Nfse.Servico.ItemListaServico));
     if Item<100 then Item:=Item*100+1;

     NFSe.Servico.ItemListaServico := FormatFloat('0000', Item);
     NFSe.Servico.ItemListaServico := Copy(NFSe.Servico.ItemListaServico, 1, 2) + '.' +
                                      Copy(NFSe.Servico.ItemListaServico, 3, 2);

     NFSe.Servico.xItemListaServico := CodigoToDesc(SomenteNumeros(NFSe.Servico.ItemListaServico));

     if length(NFSe.Servico.CodigoMunicipio)<7
      then NFSe.Servico.CodigoMunicipio := Copy(NFSe.Servico.CodigoMunicipio, 1, 2) +
            FormatFloat('00000', StrToIntDef(Copy(NFSe.Servico.CodigoMunicipio, 3, 5), 0));

     if (Leitor.rExtrai(4, 'Valores') <> '') or (Leitor.rExtrai(3, 'Valores') <> '')
      then begin
       NFSe.Servico.Valores.ValorServicos          := Leitor.rCampo(tcDe2, 'ValorServicos');
       NFSe.Servico.Valores.ValorDeducoes          := Leitor.rCampo(tcDe2, 'ValorDeducoes');
       NFSe.Servico.Valores.ValorPis               := Leitor.rCampo(tcDe2, 'ValorPis');
       NFSe.Servico.Valores.ValorCofins            := Leitor.rCampo(tcDe2, 'ValorCofins');
       NFSe.Servico.Valores.ValorInss              := Leitor.rCampo(tcDe2, 'ValorInss');
       NFSe.Servico.Valores.ValorIr                := Leitor.rCampo(tcDe2, 'ValorIr');
       NFSe.Servico.Valores.ValorCsll              := Leitor.rCampo(tcDe2, 'ValorCsll');
       NFSe.Servico.Valores.IssRetido              := StrToSituacaoTributaria(ok, Leitor.rCampo(tcStr, 'IssRetido'));
       NFSe.Servico.Valores.ValorIss               := Leitor.rCampo(tcDe2, 'ValorIss');
       NFSe.Servico.Valores.OutrasRetencoes        := Leitor.rCampo(tcDe2, 'OutrasRetencoes');
       NFSe.Servico.Valores.BaseCalculo            := Leitor.rCampo(tcDe2, 'BaseCalculo');
       NFSe.Servico.Valores.Aliquota               := Leitor.rCampo(tcDe3, 'Aliquota');
       NFSe.Servico.Valores.ValorLiquidoNfse       := Leitor.rCampo(tcDe2, 'ValorLiquidoNfse');
       NFSe.Servico.Valores.ValorIssRetido         := Leitor.rCampo(tcDe2, 'ValorIssRetido');
       NFSe.Servico.Valores.DescontoCondicionado   := Leitor.rCampo(tcDe2, 'DescontoCondicionado');
       NFSe.Servico.Valores.DescontoIncondicionado := Leitor.rCampo(tcDe2, 'DescontoIncondicionado');
      end;

    end; // fim Servico

   if (Leitor.rExtrai(3, 'Prestador') <> '') or (Leitor.rExtrai(2, 'Prestador') <> '')
    then begin
     NFSe.Prestador.Cnpj               := Leitor.rCampo(tcStr, 'Cnpj');
     NFSe.Prestador.InscricaoMunicipal := Leitor.rCampo(tcStr, 'InscricaoMunicipal');
    end; // fim Prestador

   if (Leitor.rExtrai(3, 'Tomador') <> '') or (Leitor.rExtrai(2, 'Tomador') <> '')
    then begin
     NFSe.Tomador.RazaoSocial := Leitor.rCampo(tcStr, 'RazaoSocial');

     NFSe.Tomador.Endereco.Endereco := Leitor.rCampo(tcStr, 'Endereco');
     if Copy(NFSe.Tomador.Endereco.Endereco, 1, 10) = '<' + 'Endereco>'
      then NFSe.Tomador.Endereco.Endereco := Copy(NFSe.Tomador.Endereco.Endereco, 11, 125);

     NFSe.Tomador.Endereco.Numero      := Leitor.rCampo(tcStr, 'Numero');
     NFSe.Tomador.Endereco.Complemento := Leitor.rCampo(tcStr, 'Complemento');
     NFSe.Tomador.Endereco.Bairro      := Leitor.rCampo(tcStr, 'Bairro');

     if VersaoXML='1'
      then begin
       NFSe.Tomador.Endereco.CodigoMunicipio := Leitor.rCampo(tcStr, 'Cidade');
       NFSe.Tomador.Endereco.UF              := Leitor.rCampo(tcStr, 'Estado');
      end
      else begin
       NFSe.Tomador.Endereco.CodigoMunicipio := Leitor.rCampo(tcStr, 'CodigoMunicipio');
       NFSe.Tomador.Endereco.UF              := Leitor.rCampo(tcStr, 'Uf');
      end;

     NFSe.Tomador.Endereco.CEP := Leitor.rCampo(tcStr, 'Cep');

     if length(NFSe.Tomador.Endereco.CodigoMunicipio)<7
      then NFSe.Tomador.Endereco.CodigoMunicipio := Copy(NFSe.Tomador.Endereco.CodigoMunicipio, 1, 2) +
            FormatFloat('00000', StrToIntDef(Copy(NFSe.Tomador.Endereco.CodigoMunicipio, 3, 5), 0));

     if NFSe.Tomador.Endereco.UF = ''
      then NFSe.Tomador.Endereco.UF := NFSe.PrestadorServico.Endereco.UF;

     NFSe.Tomador.Endereco.xMunicipio := CodCidadeToCidade(StrToIntDef(NFSe.Tomador.Endereco.CodigoMunicipio, 0));

     if Leitor.rExtrai(4, 'IdentificacaoTomador') <> ''
      then begin
       NFSe.Tomador.IdentificacaoTomador.InscricaoMunicipal := Leitor.rCampo(tcStr, 'InscricaoMunicipal');

       if Leitor.rExtrai(5, 'CpfCnpj') <> ''
        then begin
         if Leitor.rCampo(tcStr, 'Cpf')<>''
          then NFSe.Tomador.IdentificacaoTomador.CpfCnpj := Leitor.rCampo(tcStr, 'Cpf')
          else NFSe.Tomador.IdentificacaoTomador.CpfCnpj := Leitor.rCampo(tcStr, 'Cnpj');
        end;
      end;

     if Leitor.rExtrai(4, 'Contato') <> ''
      then begin
       NFSe.Tomador.Contato.Telefone := Leitor.rCampo(tcStr, 'Telefone');
       NFSe.Tomador.Contato.Email    := Leitor.rCampo(tcStr, 'Email');
      end;

    end; // fim Tomador

   if Leitor.rExtrai(3, 'IntermediarioServico') <> ''
    then begin
     NFSe.IntermediarioServico.RazaoSocial        := Leitor.rCampo(tcStr, 'RazaoSocial');
     NFSe.IntermediarioServico.InscricaoMunicipal := Leitor.rCampo(tcStr, 'InscricaoMunicipal');
     if Leitor.rExtrai(4, 'CpfCnpj') <> ''
      then begin
       if Leitor.rCampo(tcStr, 'Cpf')<>''
        then NFSe.IntermediarioServico.CpfCnpj := Leitor.rCampo(tcStr, 'Cpf')
        else NFSe.IntermediarioServico.CpfCnpj := Leitor.rCampo(tcStr, 'Cnpj');
      end;
    end;

   if Leitor.rExtrai(3, 'ConstrucaoCivil') <> ''
    then begin
     NFSe.ConstrucaoCivil.CodigoObra := Leitor.rCampo(tcStr, 'CodigoObra');
     NFSe.ConstrucaoCivil.Art        := Leitor.rCampo(tcStr, 'Art');
    end;

  end; // fim InfRps
end;

function TNFSeR.LerRPS: Boolean;
var
 CM: String;
begin
 FProvedor := proNenhum;

	// Alterado por - Cleiver
 	if Pos('<InfDeclaracaoPrestacaoServico', Leitor.Arquivo) > 0 then
	begin
	 	if Pos('https://nfse.goiania.go.gov.br', Leitor.Arquivo) > 0 then
			FProvedor := proGoiania
    else
			FProvedor := proSaatri;
  end
  else if Pos('<codcidade>'{ ou '<transacao>'}, AnsiLowerCase(Leitor.Arquivo)) > 0 then
    FProvedor := proIssDSF
  else if Pos('<nrRps>', Leitor.Arquivo) > 0 then
    FProvedor := proEquiplano;

 if (Leitor.rExtrai(2, 'Servico') <> '')
  then begin
   CM:= Leitor.rCampo(tcStr, 'CodigoMunicipio');

   if (CM = '4119905') then
    FProvedor := profintelISS;

   if (CM = '3127701') or (CM = '3500105') or (CM = '3510203') or
      (CM = '3523503') or (CM = '3554003') then
    FProvedor := pro4R;

   if (CM = '5213103') or (CM = '5218805') then
    FProvedor := proProdata;

   if (CM = '2919553') then
    FProvedor := proWebISS;

   if (CM = '3205309') then
    FProvedor := proVitoria;
  end;

 if (FProvedor = proEquiplano) and (Leitor.rExtrai(1, 'rps') <> '') then 
   Rps_ProvedorEquiplano
 else if (Leitor.rExtrai(1, 'Rps') <> '')
  then begin
   case FProvedor of
    proSaatri:  Rps_ProvedorSaatri;

    proGoiania,
    proProdata,
    proVitoria: Rps_ProvedorGoiania;

    proIssDsf:  Rps_ProvedorIssDsf;
    else Rps_Demais;
   end;
  end; // fim do Rps

 Result := true;
end;

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

procedure TNFSeR.NFSe_ProvedorfintelISS;
begin
  //By Lutzem Massao Aihara

 if Leitor.rExtrai(3, 'ValoresNfse') <> ''
  then begin
   NFSe.Servico.Valores.ValorPis         := Leitor.rCampo(tcDe2, 'ValorPis');
   NFSe.Servico.Valores.ValorCofins      := Leitor.rCampo(tcDe2, 'ValorCofins');
   NFSe.Servico.Valores.ValorInss        := Leitor.rCampo(tcDe2, 'ValorInss');
   NFSe.Servico.Valores.ValorIr          := Leitor.rCampo(tcDe2, 'ValorIr');
   NFSe.Servico.Valores.ValorCsll        := Leitor.rCampo(tcDe2, 'ValorCsll');
   NFSe.Servico.Valores.ValorIss         := Leitor.rCampo(tcDe2, 'ValorIss');
   NFSe.Servico.Valores.ValorLiquidoNfse := Leitor.rCampo(tcDe2, 'ValorLiquidoNfse');
   NFSe.Servico.Valores.ValorServicos    := Leitor.rCampo(tcDe2, 'ValorServicos');
  end; // fim ValoresNfse

 //
 NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj := NFSe.Prestador.Cnpj;
 NFSe.PrestadorServico.IdentificacaoPrestador.InscricaoMunicipal := NFSe.Prestador.InscricaoMunicipal;
 //

 if Leitor.rExtrai(3, 'EnderecoPrestadorServico') <> ''
  then begin
   NFSe.PrestadorServico.Endereco.Endereco := Leitor.rCampo(tcStr, 'Endereco');
   if Copy(NFSe.PrestadorServico.Endereco.Endereco, 1, 10) = '<' + 'Endereco>'
    then NFSe.PrestadorServico.Endereco.Endereco := Copy(NFSe.PrestadorServico.Endereco.Endereco, 11, 125);

   NFSe.PrestadorServico.Endereco.Numero      := Leitor.rCampo(tcStr, 'Numero');
   NFSe.PrestadorServico.Endereco.Complemento := Leitor.rCampo(tcStr, 'Complemento');
   NFSe.PrestadorServico.Endereco.Bairro      := Leitor.rCampo(tcStr, 'Bairro');

   if VersaoXML='1'
    then begin
     NFSe.PrestadorServico.Endereco.CodigoMunicipio := Leitor.rCampo(tcStr, 'Cidade');
     NFSe.PrestadorServico.Endereco.UF              := Leitor.rCampo(tcStr, 'Estado');
    end
    else begin
     NFSe.PrestadorServico.Endereco.CodigoMunicipio := Leitor.rCampo(tcStr, 'CodigoMunicipio');
     NFSe.PrestadorServico.Endereco.UF              := Leitor.rCampo(tcStr, 'Uf');
    end;

   NFSe.PrestadorServico.Endereco.CodigoPais := Leitor.rCampo(tcInt, 'CodigoPais');
   NFSe.PrestadorServico.Endereco.CEP        := Leitor.rCampo(tcStr, 'Cep');

   if length(NFSe.PrestadorServico.Endereco.CodigoMunicipio)<7
    then NFSe.PrestadorServico.Endereco.CodigoMunicipio := Copy(NFSe.PrestadorServico.Endereco.CodigoMunicipio, 1, 2) +
           FormatFloat('00000', StrToIntDef(Copy(NFSe.PrestadorServico.Endereco.CodigoMunicipio, 3, 5), 0));

   NFSe.PrestadorServico.Endereco.xMunicipio := CodCidadeToCidade(StrToIntDef(NFSe.PrestadorServico.Endereco.CodigoMunicipio, 0));

  end; // fim EnderecoPrestadorServico

 if Leitor.rExtrai(3, 'OrgaoGerador') <> ''
  then begin
   NFSe.OrgaoGerador.CodigoMunicipio := Leitor.rCampo(tcStr, 'CodigoMunicipio');
   NFSe.OrgaoGerador.Uf              := Leitor.rCampo(tcStr, 'Uf');
  end; // fim OrgaoGerador

 //oO...não?
 Rps_ProvedorfintelISS;

end;

procedure TNFSeR.NFSe_ProvedorISSDigital;
begin
  // Por Jonatan

 if Leitor.rExtrai(3, 'ValoresNfse') <> ''
  then begin
   NFSe.Servico.Valores.ValorPis         := Leitor.rCampo(tcDe2, 'ValorPis');
   NFSe.Servico.Valores.ValorCofins      := Leitor.rCampo(tcDe2, 'ValorCofins');
   NFSe.Servico.Valores.ValorInss        := Leitor.rCampo(tcDe2, 'ValorInss');
   NFSe.Servico.Valores.ValorIr          := Leitor.rCampo(tcDe2, 'ValorIr');
   NFSe.Servico.Valores.ValorCsll        := Leitor.rCampo(tcDe2, 'ValorCsll');
   NFSe.Servico.Valores.ValorIss         := Leitor.rCampo(tcDe2, 'ValorIss');
   NFSe.Servico.Valores.ValorLiquidoNfse := Leitor.rCampo(tcDe2, 'ValorLiquidoNfse');
   NFSe.Servico.Valores.ValorServicos    := Leitor.rCampo(tcDe2, 'ValorServicos');
  end; // fim ValoresNfse

 //
 NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj := NFSe.Prestador.Cnpj;
 NFSe.PrestadorServico.IdentificacaoPrestador.InscricaoMunicipal := NFSe.Prestador.InscricaoMunicipal;
 //

 if Leitor.rExtrai(3, 'EnderecoPrestadorServico') <> ''
  then begin
   NFSe.PrestadorServico.Endereco.Endereco := Leitor.rCampo(tcStr, 'Endereco');
   if Copy(NFSe.PrestadorServico.Endereco.Endereco, 1, 10) = '<' + 'Endereco>'
    then NFSe.PrestadorServico.Endereco.Endereco := Copy(NFSe.PrestadorServico.Endereco.Endereco, 11, 125);

   NFSe.PrestadorServico.Endereco.Numero      := Leitor.rCampo(tcStr, 'Numero');
   NFSe.PrestadorServico.Endereco.Complemento := Leitor.rCampo(tcStr, 'Complemento');
   NFSe.PrestadorServico.Endereco.Bairro      := Leitor.rCampo(tcStr, 'Bairro');

   if VersaoXML='1'
    then begin
     NFSe.PrestadorServico.Endereco.CodigoMunicipio := Leitor.rCampo(tcStr, 'Cidade');
     NFSe.PrestadorServico.Endereco.UF              := Leitor.rCampo(tcStr, 'Estado');
    end
    else begin
     NFSe.PrestadorServico.Endereco.CodigoMunicipio := Leitor.rCampo(tcStr, 'CodigoMunicipio');
     NFSe.PrestadorServico.Endereco.UF              := Leitor.rCampo(tcStr, 'Uf');
    end;

   NFSe.PrestadorServico.Endereco.CodigoPais := Leitor.rCampo(tcInt, 'CodigoPais');
   NFSe.PrestadorServico.Endereco.CEP        := Leitor.rCampo(tcStr, 'Cep');

   if length(NFSe.PrestadorServico.Endereco.CodigoMunicipio)<7
    then NFSe.PrestadorServico.Endereco.CodigoMunicipio := Copy(NFSe.PrestadorServico.Endereco.CodigoMunicipio, 1, 2) +
           FormatFloat('00000', StrToIntDef(Copy(NFSe.PrestadorServico.Endereco.CodigoMunicipio, 3, 5), 0));

   NFSe.PrestadorServico.Endereco.xMunicipio := CodCidadeToCidade(StrToIntDef(NFSe.PrestadorServico.Endereco.CodigoMunicipio, 0));

  end;


 if Leitor.rExtrai(3, 'OrgaoGerador') <> ''
  then begin
   NFSe.OrgaoGerador.CodigoMunicipio := Leitor.rCampo(tcStr, 'CodigoMunicipio');
   NFSe.OrgaoGerador.Uf              := Leitor.rCampo(tcStr, 'Uf');
  end;


 Rps_ProvedorISSDigital;

end;

procedure TNFSeR.NFSe_ProvedorSaatri;
var
 item: Integer;
 ok  : Boolean;
begin
 if Leitor.rExtrai(3, 'ValoresNfse') <> ''
  then begin
   NFSe.Servico.Valores.BaseCalculo      := Leitor.rCampo(tcDe2, 'BaseCalculo');
   NFSe.Servico.Valores.Aliquota         := Leitor.rCampo(tcDe3, 'Aliquota');
   NFSe.Servico.Valores.ValorIss         := Leitor.rCampo(tcDe2, 'ValorIss');
   NFSe.Servico.Valores.ValorLiquidoNfse := Leitor.rCampo(tcDe2, 'ValorLiquidoNfse');
  end; // fim ValoresNfse

 if Leitor.rExtrai(3, 'PrestadorServico') <> ''
  then begin
   NFSe.PrestadorServico.RazaoSocial  := Leitor.rCampo(tcStr, 'RazaoSocial');
   NFSe.PrestadorServico.NomeFantasia := Leitor.rCampo(tcStr, 'NomeFantasia');

   NFSe.PrestadorServico.Endereco.Endereco := Leitor.rCampo(tcStr, 'Endereco');
   if Copy(NFSe.PrestadorServico.Endereco.Endereco, 1, 10) = '<' + 'Endereco>'
    then NFSe.PrestadorServico.Endereco.Endereco := Copy(NFSe.PrestadorServico.Endereco.Endereco, 11, 125);

   NFSe.PrestadorServico.Endereco.Numero      := Leitor.rCampo(tcStr, 'Numero');
   NFSe.PrestadorServico.Endereco.Complemento := Leitor.rCampo(tcStr, 'Complemento');
   NFSe.PrestadorServico.Endereco.Bairro      := Leitor.rCampo(tcStr, 'Bairro');

   if VersaoXML='1'
    then begin
     NFSe.PrestadorServico.Endereco.CodigoMunicipio := Leitor.rCampo(tcStr, 'Cidade');
     NFSe.PrestadorServico.Endereco.UF              := Leitor.rCampo(tcStr, 'Estado');
    end
    else begin
     NFSe.PrestadorServico.Endereco.CodigoMunicipio := Leitor.rCampo(tcStr, 'CodigoMunicipio');
     NFSe.PrestadorServico.Endereco.UF              := Leitor.rCampo(tcStr, 'Uf');
    end;

   NFSe.PrestadorServico.Endereco.CodigoPais := Leitor.rCampo(tcInt, 'CodigoPais');
   NFSe.PrestadorServico.Endereco.CEP        := Leitor.rCampo(tcStr, 'Cep');

   if length(NFSe.PrestadorServico.Endereco.CodigoMunicipio)<7
    then NFSe.PrestadorServico.Endereco.CodigoMunicipio := Copy(NFSe.PrestadorServico.Endereco.CodigoMunicipio, 1, 2) +
           FormatFloat('00000', StrToIntDef(Copy(NFSe.PrestadorServico.Endereco.CodigoMunicipio, 3, 5), 0));

   NFSe.PrestadorServico.Endereco.xMunicipio := CodCidadeToCidade(StrToIntDef(NFSe.PrestadorServico.Endereco.CodigoMunicipio, 0));

   if (Leitor.rExtrai(4, 'IdentificacaoPrestador') <> '')
    then begin
     NFSe.PrestadorServico.IdentificacaoPrestador.InscricaoMunicipal := Leitor.rCampo(tcStr, 'InscricaoMunicipal');

     if VersaoXML='1'
      then begin
       if Leitor.rExtrai(5, 'CpfCnpj') <> ''
        then begin
          NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj := Leitor.rCampo(tcStr, 'Cpf');
          if NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj = ''
           then NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj := Leitor.rCampo(tcStr, 'Cnpj');
        end;
      end
      else begin
       NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj := Leitor.rCampo(tcStr, 'Cnpj');
      end;
    end;

   if Leitor.rExtrai(4, 'Contato') <> ''
    then begin
     NFSe.PrestadorServico.Contato.Telefone := Leitor.rCampo(tcStr, 'Telefone');
     NFSe.PrestadorServico.Contato.Email    := Leitor.rCampo(tcStr, 'Email');
    end;

  end; // fim PrestadorServico

 if Leitor.rExtrai(3, 'OrgaoGerador') <> ''
  then begin
   NFSe.OrgaoGerador.CodigoMunicipio := Leitor.rCampo(tcStr, 'CodigoMunicipio');
   NFSe.OrgaoGerador.Uf              := Leitor.rCampo(tcStr, 'Uf');
  end; // fim OrgaoGerador

 if Leitor.rExtrai(3, 'DeclaracaoPrestacaoServico') <> ''
  then begin

   if Leitor.rExtrai(4, 'InfDeclaracaoPrestacaoServico') <> ''
    then begin
     NFSe.Competencia              := Leitor.rCampo(tcStr, 'Competencia');
     NFSe.RegimeEspecialTributacao := StrToRegimeEspecialTributacao(ok, Leitor.rCampo(tcStr, 'RegimeEspecialTributacao'));
     NFSe.OptanteSimplesNacional   := StrToSimNao(ok, Leitor.rCampo(tcStr, 'OptanteSimplesNacional'));
     NFSe.IncentivadorCultural     := StrToSimNao(ok, Leitor.rCampo(tcStr, 'IncentivoFiscal'));

     if (Leitor.rExtrai(5, 'Rps') <> '')
      then begin
//       NFSe.DataEmissao := Leitor.rCampo(tcDatHor, 'DataEmissao');
       NFSe.DataEmissaoRps := Leitor.rCampo(tcDat, 'DataEmissao');
       NFSe.Status         := StrToStatusRPS(ok, Leitor.rCampo(tcStr, 'Status'));

       if (Leitor.rExtrai(6, 'IdentificacaoRps') <> '')
        then begin
         NFSe.IdentificacaoRps.Numero := Leitor.rCampo(tcStr, 'Numero');
         NFSe.IdentificacaoRps.Serie  := Leitor.rCampo(tcStr, 'Serie');
         NFSe.IdentificacaoRps.Tipo   := StrToTipoRPS(ok, Leitor.rCampo(tcStr, 'Tipo'));
         NFSe.InfID.ID                := SomenteNumeros(NFSe.IdentificacaoRps.Numero) + NFSe.IdentificacaoRps.Serie;
        end;
      end;

     if (Leitor.rExtrai(5, 'Servico') <> '')
      then begin
       NFSe.Servico.Valores.IssRetido   := StrToSituacaoTributaria(ok, Leitor.rCampo(tcStr, 'IssRetido'));
       NFSe.Servico.ResponsavelRetencao := StrToResponsavelRetencao(ok, Leitor.rCampo(tcStr, 'ResponsavelRetencao'));
       NFSe.Servico.ItemListaServico    := DFeUtil.LimpaNumero(Leitor.rCampo(tcStr, 'ItemListaServico'));

       Item := StrToInt(SomenteNumeros(Nfse.Servico.ItemListaServico));
       if Item<100 then Item:=Item*100+1;

       NFSe.Servico.ItemListaServico := FormatFloat('0000', Item);
       NFSe.Servico.ItemListaServico := Copy(NFSe.Servico.ItemListaServico, 1, 2) + '.' +
                                        Copy(NFSe.Servico.ItemListaServico, 3, 2);

       NFSe.Servico.xItemListaServico := CodigoToDesc(SomenteNumeros(NFSe.Servico.ItemListaServico));

       NFSe.Servico.CodigoCnae          := Leitor.rCampo(tcStr, 'CodigoCnae');
       NFSe.Servico.Discriminacao       := Leitor.rCampo(tcStr, 'Discriminacao');
       NFSe.Servico.Descricao           := '';
       NFSe.Servico.CodigoMunicipio     := Leitor.rCampo(tcStr, 'CodigoMunicipio');
       NFSe.Servico.CodigoPais          := Leitor.rCampo(tcInt, 'CodigoPais');
       NFSe.Servico.ExigibilidadeISS    := StrToExigibilidadeISS(ok, Leitor.rCampo(tcStr, 'ExigibilidadeISS'));
       NFSe.Servico.MunicipioIncidencia := Leitor.rCampo(tcInt, 'MunicipioIncidencia');

       if StrToIntDef(NFSe.PrestadorServico.Endereco.CodigoMunicipio, 0) = 0
        then begin
         NFSe.PrestadorServico.Endereco.CodigoMunicipio := NFSe.Servico.CodigoMunicipio;
         if length(NFSe.PrestadorServico.Endereco.CodigoMunicipio)<7
          then NFSe.PrestadorServico.Endereco.CodigoMunicipio := Copy(NFSe.PrestadorServico.Endereco.CodigoMunicipio, 1, 2) +
           FormatFloat('00000', StrToIntDef(Copy(NFSe.PrestadorServico.Endereco.CodigoMunicipio, 3, 5), 0));

         NFSe.PrestadorServico.Endereco.xMunicipio := CodCidadeToCidade(StrToIntDef(NFSe.PrestadorServico.Endereco.CodigoMunicipio, 0));
        end;

       if (Leitor.rExtrai(6, 'Valores') <> '')
        then begin
         NFSe.Servico.Valores.ValorServicos          := Leitor.rCampo(tcDe2, 'ValorServicos');
         NFSe.Servico.Valores.ValorDeducoes          := Leitor.rCampo(tcDe2, 'ValorDeducoes');
         NFSe.Servico.Valores.ValorPis               := Leitor.rCampo(tcDe2, 'ValorPis');
         NFSe.Servico.Valores.ValorCofins            := Leitor.rCampo(tcDe2, 'ValorCofins');
         NFSe.Servico.Valores.ValorInss              := Leitor.rCampo(tcDe2, 'ValorInss');
         NFSe.Servico.Valores.ValorIr                := Leitor.rCampo(tcDe2, 'ValorIr');
         NFSe.Servico.Valores.ValorCsll              := Leitor.rCampo(tcDe2, 'ValorCsll');
         NFSe.Servico.Valores.OutrasRetencoes        := Leitor.rCampo(tcDe2, 'OutrasRetencoes');
         NFSe.Servico.Valores.ValorIss               := Leitor.rCampo(tcDe2, 'ValorIss');
         NFSe.Servico.Valores.Aliquota               := Leitor.rCampo(tcDe3, 'Aliquota');
         NFSe.Servico.Valores.DescontoIncondicionado := Leitor.rCampo(tcDe2, 'DescontoIncondicionado');
         NFSe.Servico.Valores.DescontoCondicionado   := Leitor.rCampo(tcDe2, 'DescontoCondicionado');
        end;

       if NFSe.Servico.Valores.IssRetido = stRetencao
        then NFSe.Servico.Valores.ValorIssRetido := NFSe.Servico.Valores.ValorIss
        else NFSe.Servico.Valores.ValorIssRetido := 0.0;

      end; // fim serviço

     if (Leitor.rExtrai(5, 'Prestador') <> '')
      then begin
       NFSe.Prestador.InscricaoMunicipal := Leitor.rCampo(tcStr, 'InscricaoMunicipal');
       NFSe.PrestadorServico.IdentificacaoPrestador.InscricaoMunicipal := NFSe.Prestador.InscricaoMunicipal;

       if Leitor.rExtrai(6, 'CpfCnpj') <> ''
        then begin
          NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj := Leitor.rCampo(tcStr, 'Cpf');
          if NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj = ''
            then NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj := Leitor.rCampo(tcStr, 'Cnpj');
        end
       else begin
        NFSe.Prestador.Cnpj := Leitor.rCampo(tcStr, 'Cnpj');
       end;

      end; // fim Prestador

     if (Leitor.rExtrai(5, 'Tomador') <> '')
      then begin
       NFSe.Tomador.RazaoSocial := Leitor.rCampo(tcStr, 'RazaoSocial');

       NFSe.Tomador.Endereco.Endereco := Leitor.rCampo(tcStr, 'Endereco');
       if Copy(NFSe.Tomador.Endereco.Endereco, 1, 10) = '<' + 'Endereco>'
        then NFSe.Tomador.Endereco.Endereco := Copy(NFSe.Tomador.Endereco.Endereco, 11, 125);

       NFSe.Tomador.Endereco.Numero      := Leitor.rCampo(tcStr, 'Numero');
       NFSe.Tomador.Endereco.Complemento := Leitor.rCampo(tcStr, 'Complemento');
       NFSe.Tomador.Endereco.Bairro      := Leitor.rCampo(tcStr, 'Bairro');

       if VersaoXML='1'
        then begin
         NFSe.Tomador.Endereco.CodigoMunicipio := Leitor.rCampo(tcStr, 'Cidade');
         NFSe.Tomador.Endereco.UF              := Leitor.rCampo(tcStr, 'Estado');
        end
        else begin
         NFSe.Tomador.Endereco.CodigoMunicipio := Leitor.rCampo(tcStr, 'CodigoMunicipio');
         NFSe.Tomador.Endereco.UF              := Leitor.rCampo(tcStr, 'Uf');
        end;

       NFSe.Tomador.Endereco.CEP := Leitor.rCampo(tcStr, 'Cep');

       if length(NFSe.Tomador.Endereco.CodigoMunicipio)<7
        then NFSe.Tomador.Endereco.CodigoMunicipio := Copy(NFSe.Tomador.Endereco.CodigoMunicipio, 1, 2) +
          FormatFloat('00000', StrToIntDef(Copy(NFSe.Tomador.Endereco.CodigoMunicipio, 3, 5), 0));

       if NFSe.Tomador.Endereco.UF = ''
        then NFSe.Tomador.Endereco.UF := NFSe.PrestadorServico.Endereco.UF;

       NFSe.Tomador.Endereco.xMunicipio := CodCidadeToCidade(StrToIntDef(NFSe.Tomador.Endereco.CodigoMunicipio, 0));

       if (Leitor.rExtrai(6, 'IdentificacaoTomador') <> '')
        then begin
         NFSe.Tomador.IdentificacaoTomador.InscricaoMunicipal := Leitor.rCampo(tcStr, 'InscricaoMunicipal');

         if Leitor.rExtrai(7, 'CpfCnpj') <> ''
          then begin
           if Leitor.rCampo(tcStr, 'Cpf')<>''
            then NFSe.Tomador.IdentificacaoTomador.CpfCnpj := Leitor.rCampo(tcStr, 'Cpf')
            else NFSe.Tomador.IdentificacaoTomador.CpfCnpj := Leitor.rCampo(tcStr, 'Cnpj');
          end;
        end;

       if (Leitor.rExtrai(6, 'Contato') <> '')
        then begin
         NFSe.Tomador.Contato.Telefone := Leitor.rCampo(tcStr, 'Telefone');
         NFSe.Tomador.Contato.Email    := Leitor.rCampo(tcStr, 'Email');
        end;

      end; // fim Tomador

    end; // fim InfDeclaracaoPrestacaoServico

  end; // fim DeclaracaoPrestacaoServico

end;

procedure TNFSeR.NFSe_ProvedorGoiania;
var
 	item: Integer;
 	ok  : Boolean;
begin
 	if Leitor.rExtrai(3, 'ValoresNfse') <> '' then
	begin
   	NFSe.Servico.Valores.BaseCalculo      := Leitor.rCampo(tcDe2, 'BaseCalculo');
   	NFSe.Servico.Valores.Aliquota         := Leitor.rCampo(tcDe3, 'Aliquota');
   	NFSe.Servico.Valores.ValorIss         := Leitor.rCampo(tcDe2, 'ValorIss');
  end; // fim ValoresNfse

 	if (Leitor.rExtrai(3, 'PrestadorServico') <> '') or
     (Leitor.rExtrai(3, 'Prestador') <> '') then
	begin
    NFSe.PrestadorServico.RazaoSocial  := Leitor.rCampo(tcStr, 'RazaoSocial');
    NFSe.PrestadorServico.NomeFantasia := Leitor.rCampo(tcStr, 'NomeFantasia');

    NFSe.PrestadorServico.Endereco.Endereco := Leitor.rCampo(tcStr, 'Endereco');
    if Copy(NFSe.PrestadorServico.Endereco.Endereco, 1, 10) = '<' + 'Endereco>'
     then NFSe.PrestadorServico.Endereco.Endereco := Copy(NFSe.PrestadorServico.Endereco.Endereco, 11, 125);

    NFSe.PrestadorServico.Endereco.Numero      := Leitor.rCampo(tcStr, 'Numero');
    NFSe.PrestadorServico.Endereco.Complemento := Leitor.rCampo(tcStr, 'Complemento');
    NFSe.PrestadorServico.Endereco.Bairro      := Leitor.rCampo(tcStr, 'Bairro');

    if VersaoXML='1'
     then begin
      NFSe.PrestadorServico.Endereco.CodigoMunicipio := Leitor.rCampo(tcStr, 'Cidade');
      NFSe.PrestadorServico.Endereco.UF              := Leitor.rCampo(tcStr, 'Estado');
     end
     else begin
      NFSe.PrestadorServico.Endereco.CodigoMunicipio := Leitor.rCampo(tcStr, 'CodigoMunicipio');
      NFSe.PrestadorServico.Endereco.UF              := Leitor.rCampo(tcStr, 'Uf');
     end;

    NFSe.PrestadorServico.Endereco.CodigoPais := Leitor.rCampo(tcInt, 'CodigoPais');
    NFSe.PrestadorServico.Endereco.CEP        := Leitor.rCampo(tcStr, 'Cep');

    if length(NFSe.PrestadorServico.Endereco.CodigoMunicipio)<7
     then NFSe.PrestadorServico.Endereco.CodigoMunicipio := Copy(NFSe.PrestadorServico.Endereco.CodigoMunicipio, 1, 2) +
           FormatFloat('00000', StrToIntDef(Copy(NFSe.PrestadorServico.Endereco.CodigoMunicipio, 3, 5), 0));

    NFSe.PrestadorServico.Endereco.xMunicipio := CodCidadeToCidade(StrToIntDef(NFSe.PrestadorServico.Endereco.CodigoMunicipio, 0));

   	if (Leitor.rExtrai(4, 'IdentificacaoPrestador') <> '') then
		begin
     	NFSe.PrestadorServico.IdentificacaoPrestador.InscricaoMunicipal := Leitor.rCampo(tcStr, 'InscricaoMunicipal');

     	if VersaoXML='1' then
			begin
       	if Leitor.rExtrai(5, 'CpfCnpj') <> '' then
				begin
          NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj := Leitor.rCampo(tcStr, 'Cpf');
          if NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj = ''
           then NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj := Leitor.rCampo(tcStr, 'Cnpj');
        end;
      end
      else
			begin
       	NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj := Leitor.rCampo(tcStr, 'Cnpj');
      end;
    end;
  end; // fim PrestadorServico

 	if Leitor.rExtrai(3, 'DeclaracaoPrestacaoServico') <> '' then
	begin
    NFSe.Competencia            := Leitor.rCampo(tcStr, 'Competencia');
    NFSe.OptanteSimplesNacional := StrToSimNao(ok, Leitor.rCampo(tcStr, 'OptanteSimplesNacional'));
    NFSe.DataEmissaoRps         := Leitor.rCampo(tcDat, 'DataEmissao');

    if (Leitor.rExtrai(4, 'IdentificacaoRps') <> '') then
		begin
      NFSe.IdentificacaoRps.Numero := Leitor.rCampo(tcStr, 'Numero');
      NFSe.IdentificacaoRps.Serie  := Leitor.rCampo(tcStr, 'Serie');
      NFSe.IdentificacaoRps.Tipo   := StrToTipoRPS(ok, Leitor.rCampo(tcStr, 'Tipo'));
    end;

    if (Leitor.rExtrai(4, 'Servico') <> '') then
		begin
      NFSe.Servico.Valores.IssRetido := StrToSituacaoTributaria(ok, Leitor.rCampo(tcStr, 'IssRetido'));
      NFSe.Servico.ItemListaServico  := DFeUtil.LimpaNumero(Leitor.rCampo(tcStr, 'ItemListaServico'));

      // Alterado Cleiver em 22/11/2013
      if NFSe.Servico.ItemListaServico <> '' then
      begin
        Item := StrToInt(SomenteNumeros(Nfse.Servico.ItemListaServico));
        if Item<100 then Item:=Item*100+1;

        NFSe.Servico.ItemListaServico := FormatFloat('0000', Item);
        NFSe.Servico.ItemListaServico := Copy(NFSe.Servico.ItemListaServico, 1, 2) + '.' +
                                         Copy(NFSe.Servico.ItemListaServico, 3, 2);

        NFSe.Servico.xItemListaServico := CodigoToDesc(SomenteNumeros(NFSe.Servico.ItemListaServico));
      end;

      NFSe.Servico.CodigoTributacaoMunicipio := Leitor.rCampo(tcStr, 'CodigoTributacaoMunicipio');
      NFSe.Servico.Discriminacao             := Leitor.rCampo(tcStr, 'Discriminacao');

      // Alterado Cleiver em 22/11/2013
      if pos('\s\n', NFSe.Servico.Discriminacao ) > 0 then
        NFSe.Servico.Discriminacao := Copy(NFSe.Servico.Discriminacao,1,pos('\s\n', NFSe.Servico.Discriminacao)-1) + #13#10
                                     + Copy(NFSe.Servico.Discriminacao,pos('\s\n', NFSe.Servico.Discriminacao)+5,Length(NFSe.Servico.Discriminacao));

      NFSe.Servico.Descricao                 := '';
      NFSe.Servico.CodigoMunicipio           := Leitor.rCampo(tcStr, 'CodigoMunicipio');
      NFSe.Servico.ExigibilidadeISS          := StrToExigibilidadeISS(ok, Leitor.rCampo(tcStr, 'ExigibilidadeISS'));
      NFSe.Servico.MunicipioIncidencia       := Leitor.rCampo(tcInt, 'MunicipioIncidencia');

      if StrToIntDef(NFSe.PrestadorServico.Endereco.CodigoMunicipio, 0) = 0
       then begin
        NFSe.PrestadorServico.Endereco.CodigoMunicipio := NFSe.Servico.CodigoMunicipio;
        if length(NFSe.PrestadorServico.Endereco.CodigoMunicipio)<7
         then NFSe.PrestadorServico.Endereco.CodigoMunicipio := Copy(NFSe.PrestadorServico.Endereco.CodigoMunicipio, 1, 2) +
          FormatFloat('00000', StrToIntDef(Copy(NFSe.PrestadorServico.Endereco.CodigoMunicipio, 3, 5), 0));

        NFSe.PrestadorServico.Endereco.xMunicipio := CodCidadeToCidade(StrToIntDef(NFSe.PrestadorServico.Endereco.CodigoMunicipio, 0));
       end;

       if (Leitor.rExtrai(4, 'Valores') <> '')
        then begin
         NFSe.Servico.Valores.ValorServicos          := Leitor.rCampo(tcDe2, 'ValorServicos');
         NFSe.Servico.Valores.ValorDeducoes          := Leitor.rCampo(tcDe2, 'ValorDeducoes');
         NFSe.Servico.Valores.ValorPis               := Leitor.rCampo(tcDe2, 'ValorPis');
         NFSe.Servico.Valores.ValorCofins            := Leitor.rCampo(tcDe2, 'ValorCofins');
         NFSe.Servico.Valores.ValorInss              := Leitor.rCampo(tcDe2, 'ValorInss');
         NFSe.Servico.Valores.ValorIr                := Leitor.rCampo(tcDe2, 'ValorIr');
         NFSe.Servico.Valores.ValorCsll              := Leitor.rCampo(tcDe2, 'ValorCsll');
         NFSe.Servico.Valores.ValorIss               := Leitor.rCampo(tcDe2, 'ValorIss');
         NFSe.Servico.Valores.Aliquota               := Leitor.rCampo(tcDe3, 'Aliquota');
         NFSe.Servico.Valores.DescontoIncondicionado := Leitor.rCampo(tcDe2, 'DescontoIncondicionado');
        end;
        NFSe.Servico.Valores.ValorLiquidoNfse        := NFSe.Servico.Valores.ValorServicos
																												-NFSe.Servico.Valores.ValorDeducoes
                                                        -NFSe.Servico.Valores.DescontoIncondicionado;

       if NFSe.Servico.Valores.IssRetido = stRetencao
        then NFSe.Servico.Valores.ValorIssRetido := NFSe.Servico.Valores.ValorIss
        else NFSe.Servico.Valores.ValorIssRetido := 0.0;

     end; // fim serviço

     if (Leitor.rExtrai(4, 'Prestador') <> '')
      then begin
       NFSe.Prestador.InscricaoMunicipal := Leitor.rCampo(tcStr, 'InscricaoMunicipal');

       if VersaoXML='1'
        then begin
         if Leitor.rExtrai(4, 'CpfCnpj') <> ''
          then begin
            NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj := Leitor.rCampo(tcStr, 'Cpf');
            if NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj = ''
             then NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj := Leitor.rCampo(tcStr, 'Cnpj');
          end;
        end
        else begin
         NFSe.Prestador.Cnpj := Leitor.rCampo(tcStr, 'Cnpj');
        end;

      end; // fim Prestador

     if (Leitor.rExtrai(4, 'Tomador') <> '')
      then begin
       NFSe.Tomador.RazaoSocial := Leitor.rCampo(tcStr, 'RazaoSocial');

       NFSe.Tomador.Endereco.Endereco := Leitor.rCampo(tcStr, 'Endereco');
       if Copy(NFSe.Tomador.Endereco.Endereco, 1, 10) = '<' + 'Endereco>'
        then NFSe.Tomador.Endereco.Endereco := Copy(NFSe.Tomador.Endereco.Endereco, 11, 125);

       NFSe.Tomador.Endereco.Numero      := Leitor.rCampo(tcStr, 'Numero');
       NFSe.Tomador.Endereco.Complemento := Leitor.rCampo(tcStr, 'Complemento');
       NFSe.Tomador.Endereco.Bairro      := Leitor.rCampo(tcStr, 'Bairro');

       if VersaoXML='1'
        then begin
         NFSe.Tomador.Endereco.CodigoMunicipio := Leitor.rCampo(tcStr, 'Cidade');
         NFSe.Tomador.Endereco.UF              := Leitor.rCampo(tcStr, 'Estado');
        end
        else begin
         NFSe.Tomador.Endereco.CodigoMunicipio := Leitor.rCampo(tcStr, 'CodigoMunicipio');
         NFSe.Tomador.Endereco.UF              := Leitor.rCampo(tcStr, 'Uf');
        end;

       	NFSe.Tomador.Endereco.CEP := Leitor.rCampo(tcStr, 'Cep');

       	if length(NFSe.Tomador.Endereco.CodigoMunicipio)<7
        then NFSe.Tomador.Endereco.CodigoMunicipio := Copy(NFSe.Tomador.Endereco.CodigoMunicipio, 1, 2) +
          FormatFloat('00000', StrToIntDef(Copy(NFSe.Tomador.Endereco.CodigoMunicipio, 3, 5), 0));

       	if NFSe.Tomador.Endereco.UF = ''
        then NFSe.Tomador.Endereco.UF := NFSe.PrestadorServico.Endereco.UF;

       	NFSe.Tomador.Endereco.xMunicipio := CodCidadeToCidade(StrToIntDef(NFSe.Tomador.Endereco.CodigoMunicipio, 0));

       	if (Leitor.rExtrai(5, 'IdentificacaoTomador') <> '') then
				begin
         	NFSe.Tomador.IdentificacaoTomador.InscricaoMunicipal := Leitor.rCampo(tcStr, 'InscricaoMunicipal');
         	if Leitor.rCampo(tcStr, 'Cpf')<>'' then
						NFSe.Tomador.IdentificacaoTomador.CpfCnpj := Leitor.rCampo(tcStr, 'Cpf')
         	else
						NFSe.Tomador.IdentificacaoTomador.CpfCnpj := Leitor.rCampo(tcStr, 'Cnpj');
        end;
        if (Leitor.rExtrai(5, 'Contato') <> '')
         then begin
           NFSe.Tomador.Contato.Telefone := Leitor.rCampo(tcStr, 'Telefone');
           NFSe.Tomador.Contato.Email    := Leitor.rCampo(tcStr, 'Email');
         end;
      end; // fim Tomador
  end; // fim DeclaracaoPrestacaoServico

end;

procedure TNFSeR.NFSe_ProvedorIssDsf;
var ok  : Boolean;
    Item, posI, count: integer;
    sOperacao, sTributacao: string;
    strItem: ansiString;
    leitorItem : TLeitor;
begin

   VersaoXML := '1'; // para este provedor usar padrão "1".

   FNFSe.Numero            := Leitor.rCampo(tcStr, 'NumeroNota');
   FNFSe.CodigoVerificacao := Leitor.rCampo(tcStr, 'CodigoVerificacao');

   FNFSe.DataEmissaoRps    := Leitor.rCampo(tcDatHor, 'DataEmissaoRPS');
   FNFSe.DataEmissao       := Leitor.rCampo(tcDatHor, 'DataProcessamento');
   FNFSe.Status            := StrToEnumerado(ok, Leitor.rCampo(tcStr, 'SituacaoRPS'),['N','C'],[srNormal, srCancelado]);

   NFSe.IdentificacaoRps.Numero := Leitor.rCampo(tcStr, 'NumeroRPS');
   NFSe.IdentificacaoRps.Serie  := Leitor.rCampo(tcStr, 'SerieRPS');
   NFSe.IdentificacaoRps.Tipo   := trRPS; //StrToTipoRPS(ok, leitorAux.rCampo(tcStr, 'Tipo'));
   NFSe.InfID.ID                := SomenteNumeros(NFSe.IdentificacaoRps.Numero);// + NFSe.IdentificacaoRps.Serie;
   NFSe.SeriePrestacao          := Leitor.rCampo(tcStr, 'SeriePrestacao');

   NFSe.Tomador.IdentificacaoTomador.InscricaoMunicipal := Leitor.rCampo(tcStr, 'InscricaoMunicipalTomador');
   NFSe.Tomador.IdentificacaoTomador.CpfCnpj := Leitor.rCampo(tcStr, 'CPFCNPJTomador');
   NFSe.Tomador.RazaoSocial              := Leitor.rCampo(tcStr, 'RazaoSocialTomador');
   NFSe.Tomador.Endereco.TipoLogradouro  := Leitor.rCampo(tcStr, 'TipoLogradouroTomador');
   NFSe.Tomador.Endereco.Endereco        := Leitor.rCampo(tcStr, 'LogradouroTomador');
   NFSe.Tomador.Endereco.Numero          := Leitor.rCampo(tcStr, 'NumeroEnderecoTomador');
   NFSe.Tomador.Endereco.Complemento     := Leitor.rCampo(tcStr, 'ComplementoEnderecoTomador');
   NFSe.Tomador.Endereco.TipoBairro      := Leitor.rCampo(tcStr, 'TipoBairroTomador');
   NFSe.Tomador.Endereco.Bairro          := Leitor.rCampo(tcStr, 'BairroTomador');
   NFSe.Tomador.Endereco.CodigoMunicipio := CodSiafiToCodCidade( Leitor.rCampo(tcStr, 'CidadeTomador')) ;
   NFSe.Tomador.Endereco.CEP             := Leitor.rCampo(tcStr, 'CEPTomador');
   NFSe.Tomador.Contato.Email := Leitor.rCampo(tcStr, 'EmailTomador');

   NFSe.Servico.CodigoCnae := Leitor.rCampo(tcStr, 'CodigoAtividade');
   NFSe.Servico.Valores.Aliquota := Leitor.rCampo(tcDe3, 'AliquotaAtividade');

   NFSe.Servico.Valores.IssRetido := StrToEnumerado( ok, Leitor.rCampo(tcStr, 'TipoRecolhimento'),
                              ['A','R'], [ stNormal, stRetencao{, stSubstituicao}]);

   NFSe.Servico.CodigoMunicipio := CodSiafiToCodCidade( Leitor.rCampo(tcStr, 'MunicipioPrestacao'));

   sOperacao   := AnsiUpperCase(Leitor.rCampo(tcStr, 'Operacao'));
   sTributacao := AnsiUpperCase(Leitor.rCampo(tcStr, 'Tributacao'));

   if sOperacao[1] in ['A', 'B'] then begin
      if NFSe.Servico.CodigoMunicipio = NFSe.PrestadorServico.Endereco.CodigoMunicipio then
         NFSe.NaturezaOperacao := noTributacaoNoMunicipio      // ainda estamos
      else                                                    // em análise sobre
         NFSe.NaturezaOperacao := noTributacaoForaMunicipio;   // este ponto
   end
   else if (sOperacao = 'C') and (sTributacao = 'C') then begin
      NFSe.NaturezaOperacao := noIsencao;
   end
   else if (sOperacao = 'C') and (sTributacao = 'F') then begin
      NFSe.NaturezaOperacao := noImune;
   end
   else if (sOperacao = 'A') and (sTributacao = 'N') then begin
      NFSe.NaturezaOperacao := noNaoIncidencia;
   end;

   NFSe.NaturezaOperacao := StrToEnumerado( ok,sTributacao, ['T','K'], [ NFSe.NaturezaOperacao, noSuspensaDecisaoJudicial ]);

   NFSe.OptanteSimplesNacional := StrToEnumerado( ok,sTributacao, ['T','H'], [ snNao, snSim ]);

   NFSe.DeducaoMateriais := StrToEnumerado( ok,sOperacao, ['A','B'], [ snNao, snSim ]);

   NFse.RegimeEspecialTributacao := StrToEnumerado( ok,sTributacao, ['T','M'], [ retNenhum, retMicroempresarioIndividual ]);

   NFSe.Servico.Valores.ValorPis        := Leitor.rCampo(tcDe2, 'ValorPIS');
   NFSe.Servico.Valores.ValorCofins     := Leitor.rCampo(tcDe2, 'ValorCOFINS');
   NFSe.Servico.Valores.ValorInss       := Leitor.rCampo(tcDe2, 'ValorINSS');
   NFSe.Servico.Valores.ValorIr         := Leitor.rCampo(tcDe2, 'ValorIR');
   NFSe.Servico.Valores.ValorCsll       := Leitor.rCampo(tcDe2, 'ValorCSLL');
   NFSe.Servico.Valores.AliquotaPIS     := Leitor.rCampo(tcDe2, 'AliquotaPIS');
   NFSe.Servico.Valores.AliquotaCOFINS  := Leitor.rCampo(tcDe2, 'AliquotaCOFINS');
   NFSe.Servico.Valores.AliquotaINSS    := Leitor.rCampo(tcDe2, 'AliquotaINSS');
   NFSe.Servico.Valores.AliquotaIR      := Leitor.rCampo(tcDe2, 'AliquotaIR');
   NFSe.Servico.Valores.AliquotaCSLL    := Leitor.rCampo(tcDe2, 'AliquotaCSLL');

   NFSe.OutrasInformacoes := Leitor.rCampo(tcStr, 'DescricaoRPS');

   NFSe.PrestadorServico.Contato.Telefone := Leitor.rCampo(tcStr, 'DDDPrestador') + Leitor.rCampo(tcStr, 'TelefonePrestador');
   NFSe.Tomador.Contato.Telefone          := Leitor.rCampo(tcStr, 'DDDTomador') + Leitor.rCampo(tcStr, 'TelefoneTomador');

   NFSE.MotivoCancelamento := Leitor.rCampo(tcStr, 'MotCancelamento');

   NFSe.IntermediarioServico.CpfCnpj := Leitor.rCampo(tcStr, 'CPFCNPJIntermediario');

   if (Leitor.rExtrai(2, 'Deducoes') <> '') then
   begin
      strItem := Leitor.rExtrai(2, 'Deducoes');
      if (strItem <> '') then
      begin
         Item := 0 ;
         posI := pos('<Deducao>', strItem);

         while ( posI > 0 ) do begin
            count := pos('</Deducao>', strItem) + 14;

            FNfse.Servico.Deducao.Add;
            inc(Item);

            leitorItem := TLeitor.Create;
            leitorItem.Arquivo := copy(strItem, PosI, count);
            leitorItem.Grupo := leitorItem.Arquivo;

            FNfse.Servico.Deducao[Item].DeducaoPor  :=
               StrToEnumerado( ok,leitorItem.rCampo(tcStr, 'DeducaoPor'),
                               ['','Percentual','Valor'],
                               [ dpNenhum,dpPercentual, dpValor ]);

            FNfse.Servico.Deducao[Item].TipoDeducao :=
               StrToEnumerado( ok,leitorItem.rCampo(tcStr, 'TipoDeducao'),
                               ['', 'Despesas com Materiais', 'Despesas com Sub-empreitada'],
                               [ tdNenhum, tdMateriais, tdSubEmpreitada ]);

            FNfse.Servico.Deducao[Item].CpfCnpjReferencia := leitorItem.rCampo(tcStr, 'CPFCNPJReferencia');
            FNfse.Servico.Deducao[Item].NumeroNFReferencia := leitorItem.rCampo(tcStr, 'NumeroNFReferencia');
            FNfse.Servico.Deducao[Item].ValorTotalReferencia := leitorItem.rCampo(tcDe2, 'ValorTotalReferencia');
            FNfse.Servico.Deducao[Item].PercentualDeduzir := leitorItem.rCampo(tcDe2, 'PercentualDeduzir');
            FNfse.Servico.Deducao[Item].ValorDeduzir := leitorItem.rCampo(tcDe2, 'ValorDeduzir');

            leitorItem.free;
            Delete(strItem, PosI, count);
            posI := pos('<Deducao>', strItem);
         end;
      end;
   end;

   if (Leitor.rExtrai(2, 'Itens') <> '') then
   begin

      strItem := Leitor.rExtrai(2, 'Itens');
      if (strItem <> '') then
      begin
         Item := 0 ;
         posI := pos('<Item>', strItem);

         while ( posI > 0 ) do begin
            count := pos('</Item>', strItem) + 14;

            FNfse.Servico.ItemServico.Add;
            inc(Item);

            leitorItem := TLeitor.Create;
            leitorItem.Arquivo := copy(strItem, PosI, count);
            leitorItem.Grupo := leitorItem.Arquivo;

            FNfse.Servico.ItemServico[Item].Descricao  := leitorItem.rCampo(tcStr, 'DiscriminacaoServico');
            FNfse.Servico.ItemServico[Item].Quantidade := leitorItem.rCampo(tcStr, 'Quantidade');
            FNfse.Servico.ItemServico[Item].ValorUnitario := leitorItem.rCampo(tcStr, 'ValorUnitario');
            FNfse.Servico.ItemServico[Item].ValorTotal := leitorItem.rCampo(tcStr, 'ValorTotal');
            FNfse.Servico.ItemServico[Item].Tributavel := StrToEnumerado( ok,leitorItem.rCampo(tcStr, 'Tributavel'), ['N','S'], [ snNao, snSim ]);

            leitorItem.free;
            Delete(strItem, PosI, count);
            posI := pos('<Item>', strItem);
         end;
      end;
   end;

end;

//***** incluido adilson pazzini
procedure TNFSeR.NFSe_Provedor4R;
var
 item: Integer;
 ok  : Boolean;
begin
 if (Leitor.rExtrai(3, 'IdentificacaoRps') <> '')
  then begin
   NFSe.IdentificacaoRps.Numero := Leitor.rCampo(tcStr, 'Numero');
   NFSe.IdentificacaoRps.Serie  := Leitor.rCampo(tcStr, 'Serie');
   NFSe.IdentificacaoRps.Tipo   := StrToTipoRPS(ok, Leitor.rCampo(tcStr, 'Tipo'));
   NFSe.InfID.ID                := SomenteNumeros(NFSe.IdentificacaoRps.Numero) + NFSe.IdentificacaoRps.Serie;
  end;

 if (Leitor.rExtrai(3, 'Servico') <> '')
  then begin
   NFSe.Servico.ResponsavelRetencao := StrToResponsavelRetencao(ok, Leitor.rCampo(tcStr, 'ResponsavelRetencao'));
   NFSe.Servico.ItemListaServico    := DFeUtil.LimpaNumero(Leitor.rCampo(tcStr, 'ItemListaServico'));

   Item := StrToInt(SomenteNumeros(Nfse.Servico.ItemListaServico));
   if Item<100 then Item:=Item*100+1;

   NFSe.Servico.ItemListaServico := FormatFloat('0000', Item);
   NFSe.Servico.ItemListaServico := Copy(NFSe.Servico.ItemListaServico, 1, 2) + '.' +
                                    Copy(NFSe.Servico.ItemListaServico, 3, 2);

   NFSe.Servico.xItemListaServico := CodigoToDesc(SomenteNumeros(NFSe.Servico.ItemListaServico));

   NFSe.Servico.CodigoCnae          := Leitor.rCampo(tcStr, 'CodigoCnae');
   NFSe.Servico.Discriminacao       := Leitor.rCampo(tcStr, 'Discriminacao');
   NFSe.Servico.Descricao           := '';
   NFSe.Servico.CodigoMunicipio     := Leitor.rCampo(tcStr, 'CodigoMunicipio');
   NFSe.Servico.CodigoPais          := Leitor.rCampo(tcInt, 'CodigoPais');
   NFSe.Servico.ExigibilidadeISS    := StrToExigibilidadeISS(ok, Leitor.rCampo(tcStr, 'ExigibilidadeISS'));
   NFSe.Servico.MunicipioIncidencia := Leitor.rCampo(tcInt, 'MunicipioIncidencia');

   if (Leitor.rExtrai(4, 'Valores') <> '')
    then begin
     NFSe.Servico.Valores.ValorServicos          := Leitor.rCampo(tcDe2, 'ValorServicos');
     NFSe.Servico.Valores.ValorDeducoes          := Leitor.rCampo(tcDe2, 'ValorDeducoes');
     NFSe.Servico.Valores.ValorPis               := Leitor.rCampo(tcDe2, 'ValorPis');
     NFSe.Servico.Valores.ValorCofins            := Leitor.rCampo(tcDe2, 'ValorCofins');
     NFSe.Servico.Valores.ValorInss              := Leitor.rCampo(tcDe2, 'ValorInss');
     NFSe.Servico.Valores.ValorIr                := Leitor.rCampo(tcDe2, 'ValorIr');
     NFSe.Servico.Valores.ValorCsll              := Leitor.rCampo(tcDe2, 'ValorCsll');
     NFSe.Servico.Valores.OutrasRetencoes        := Leitor.rCampo(tcDe2, 'OutrasRetencoes');
     NFSe.Servico.Valores.IssRetido              := StrToSituacaoTributaria(ok, Leitor.rCampo(tcStr, 'IssRetido'));
     NFSe.Servico.Valores.ValorIss               := Leitor.rCampo(tcDe2, 'ValorIss');
     NFSe.Servico.Valores.BaseCalculo            := Leitor.rCampo(tcDe2, 'BaseCalculo');
     NFSe.Servico.Valores.Aliquota               := Leitor.rCampo(tcDe3, 'Aliquota');
     NFSe.Servico.Valores.ValorLiquidoNfse       := Leitor.rCampo(tcDe2, 'ValorLiquidoNfse');
     NFSe.Servico.Valores.ValorIssRetido         := Leitor.rCampo(tcDe2, 'ValorIssRetido');
     NFSe.Servico.Valores.DescontoCondicionado   := Leitor.rCampo(tcDe2, 'DescontoCondicionado');
     NFSe.Servico.Valores.DescontoIncondicionado := Leitor.rCampo(tcDe2, 'DescontoIncondicionado');
    end;

  end; // fim serviço

   if (Leitor.rExtrai(3, 'EnderecoPrestadorServico') <> '')then
    begin
      NFSe.PrestadorServico.Endereco.Endereco := Leitor.rCampo(tcStr, 'Endereco');
      if Copy(NFSe.PrestadorServico.Endereco.Endereco, 1, 10) = '<' + 'Endereco>' then
        NFSe.PrestadorServico.Endereco.Endereco := Copy(NFSe.PrestadorServico.Endereco.Endereco, 11, 125);

      NFSe.PrestadorServico.Endereco.Numero      := Leitor.rCampo(tcStr, 'Numero');
      NFSe.PrestadorServico.Endereco.Complemento := Leitor.rCampo(tcStr, 'Complemento');
      NFSe.PrestadorServico.Endereco.Bairro      := Leitor.rCampo(tcStr, 'Bairro');


      if VersaoXML='1' then
       begin
        NFSe.PrestadorServico.Endereco.CodigoMunicipio := Leitor.rCampo(tcStr, 'Cidade');
        NFSe.PrestadorServico.Endereco.UF              := Leitor.rCampo(tcStr, 'Estado');
       end
       else begin
        NFSe.PrestadorServico.Endereco.CodigoMunicipio := Leitor.rCampo(tcStr, 'CodigoMunicipio');
        NFSe.PrestadorServico.Endereco.UF              := Leitor.rCampo(tcStr, 'Uf');
       end;

       NFSe.PrestadorServico.Endereco.CodigoPais := Leitor.rCampo(tcInt, 'CodigoPais');
       NFSe.PrestadorServico.Endereco.CEP        := Leitor.rCampo(tcStr, 'Cep');
       if length(NFSe.PrestadorServico.Endereco.CodigoMunicipio)<7 then
       NFSe.PrestadorServico.Endereco.CodigoMunicipio := Copy(NFSe.PrestadorServico.Endereco.CodigoMunicipio, 1, 2) +
       FormatFloat('00000', StrToIntDef(Copy(NFSe.PrestadorServico.Endereco.CodigoMunicipio, 3, 5), 0));
            NFSe.PrestadorServico.Endereco.xMunicipio := CodCidadeToCidade(StrToIntDef(NFSe.PrestadorServico.Endereco.CodigoMunicipio, 0));
    end;

    if (Leitor.rExtrai(3, 'Prestador') <> '')then
     begin
      NFSe.PrestadorServico.IdentificacaoPrestador.InscricaoMunicipal := Leitor.rCampo(tcStr, 'InscricaoMunicipal');
      NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj := Leitor.rCampo(tcStr, 'Cnpj');
     end;

     if Leitor.rExtrai(3, 'Tomador') <> ''
      then begin
       NFSe.Tomador.RazaoSocial := Leitor.rCampo(tcStr, 'RazaoSocial');

       NFSe.Tomador.Endereco.Endereco := Leitor.rCampo(tcStr, 'Endereco');
       if Copy(NFSe.Tomador.Endereco.Endereco, 1, 10) = '<' + 'Endereco>'
        then NFSe.Tomador.Endereco.Endereco := Copy(NFSe.Tomador.Endereco.Endereco, 11, 125);

       NFSe.Tomador.Endereco.Numero      := Leitor.rCampo(tcStr, 'Numero');
       NFSe.Tomador.Endereco.Complemento := Leitor.rCampo(tcStr, 'Complemento');
       NFSe.Tomador.Endereco.Bairro      := Leitor.rCampo(tcStr, 'Bairro');

       if VersaoXML='1'
        then begin
         NFSe.Tomador.Endereco.CodigoMunicipio := Leitor.rCampo(tcStr, 'Cidade');
         NFSe.Tomador.Endereco.UF              := Leitor.rCampo(tcStr, 'Estado');
        end
        else begin
         NFSe.Tomador.Endereco.CodigoMunicipio := Leitor.rCampo(tcStr, 'CodigoMunicipio');
         NFSe.Tomador.Endereco.UF              := Leitor.rCampo(tcStr, 'Uf');
        end;

       NFSe.Tomador.Endereco.CEP := Leitor.rCampo(tcStr, 'Cep');

       if length(NFSe.Tomador.Endereco.CodigoMunicipio)<7
        then NFSe.Tomador.Endereco.CodigoMunicipio := Copy(NFSe.Tomador.Endereco.CodigoMunicipio, 1, 2) +
              FormatFloat('00000', StrToIntDef(Copy(NFSe.Tomador.Endereco.CodigoMunicipio, 3, 5), 0));

       if NFSe.Tomador.Endereco.UF = ''
        then NFSe.Tomador.Endereco.UF := NFSe.PrestadorServico.Endereco.UF;

       NFSe.Tomador.Endereco.xMunicipio := CodCidadeToCidade(StrToIntDef(NFSe.Tomador.Endereco.CodigoMunicipio, 0));

       if Leitor.rExtrai(4, 'Contato') <> ''
        then begin
         NFSe.Tomador.Contato.Telefone := Leitor.rCampo(tcStr, 'Telefone');
         NFSe.Tomador.Contato.Email    := Leitor.rCampo(tcStr, 'Email');
        end;

       if Leitor.rExtrai(4, 'IdentificacaoTomador') <> ''
        then begin
         NFSe.Tomador.IdentificacaoTomador.InscricaoMunicipal := Leitor.rCampo(tcStr, 'InscricaoMunicipal');
         if Leitor.rExtrai(5, 'CpfCnpj') <> ''
          then begin
           if Leitor.rCampo(tcStr, 'Cpf')<>''
            then NFSe.Tomador.IdentificacaoTomador.CpfCnpj := Leitor.rCampo(tcStr, 'Cpf')
            else NFSe.Tomador.IdentificacaoTomador.CpfCnpj := Leitor.rCampo(tcStr, 'Cnpj');
          end;
        end;
      end;


 if Leitor.rExtrai(3, 'Intermediario') <> ''
  then begin
   NFSe.IntermediarioServico.RazaoSocial        := Leitor.rCampo(tcStr, 'RazaoSocial');
   NFSe.IntermediarioServico.InscricaoMunicipal := Leitor.rCampo(tcStr, 'InscricaoMunicipal');
   if Leitor.rExtrai(4, 'CpfCnpj') <> ''
    then begin
     if Leitor.rCampo(tcStr, 'Cpf')<>''
      then NFSe.IntermediarioServico.CpfCnpj := Leitor.rCampo(tcStr, 'Cpf')
      else NFSe.IntermediarioServico.CpfCnpj := Leitor.rCampo(tcStr, 'Cnpj');
    end;
  end;

 if Leitor.rExtrai(3, 'OrgaoGerador') <> ''
  then begin
   NFSe.OrgaoGerador.CodigoMunicipio := Leitor.rCampo(tcStr, 'CodigoMunicipio');
   NFSe.OrgaoGerador.Uf              := Leitor.rCampo(tcStr, 'Uf');
  end; // fim OrgaoGerador

 if Leitor.rExtrai(3, 'ConstrucaoCivil') <> ''
  then begin
   NFSe.ConstrucaoCivil.CodigoObra := Leitor.rCampo(tcStr, 'CodigoObra');
   NFSe.ConstrucaoCivil.Art        := Leitor.rCampo(tcStr, 'Art');
  end;
end;

// incluido por Joel Takei 24/06/2013
procedure TNFSeR.NFSe_ProvedorISSe;
var
 	ok  : Boolean;
  dt, d, m , a : string;
  Item: Integer;
begin
 	if Leitor.rExtrai(2, 'ValoresNfse') <> '' then
	begin
   	NFSe.Servico.Valores.BaseCalculo      := Leitor.rCampo(tcDe2, 'BaseCalculo');
   	NFSe.Servico.Valores.Aliquota         := Leitor.rCampo(tcDe3, 'Aliquota');
   	NFSe.Servico.Valores.ValorIss         := Leitor.rCampo(tcDe2, 'ValorIss');
    NFSe.Servico.Valores.ValorLiquidoNfse := Leitor.rCampo(tcDe2, 'ValorLiquidoNfse');

  end; // fim ValoresNfse

 	if Leitor.rExtrai(2, 'PrestadorServico') <> '' then
	begin
    NFSe.PrestadorServico.RazaoSocial := Leitor.rCampo(tcStr, 'RazaoSocial');
    NFSe.PrestadorServico.NomeFantasia := Leitor.rCampo(tcStr, 'NomeFantasia');

    NFSe.PrestadorServico.Endereco.Endereco := Leitor.rCampo(tcStr, 'Endereco');

    if Copy(NFSe.PrestadorServico.Endereco.Endereco, 1, 10) = '<Endereco>' then
      NFSe.PrestadorServico.Endereco.Endereco := Copy(NFSe.PrestadorServico.Endereco.Endereco, 11, 125);

    NFSe.PrestadorServico.Endereco.Numero := Leitor.rCampo(tcStr, 'Numero');
    NFSe.PrestadorServico.Endereco.Complemento := Leitor.rCampo(tcStr, 'Complemento');
    NFSe.PrestadorServico.Endereco.Bairro := Leitor.rCampo(tcStr, 'Bairro');
    NFSe.PrestadorServico.Endereco.CodigoMunicipio := Leitor.rCampo(tcStr, 'CodigoMunicipio');
    NFSe.PrestadorServico.Endereco.xMunicipio := CodCidadeToCidade(StrToIntDef(NFSe.PrestadorServico.Endereco.CodigoMunicipio, 0));

    NFSe.PrestadorServico.Endereco.UF := Leitor.rCampo(tcStr, 'Uf');
    NFSe.PrestadorServico.Endereco.CEP := Leitor.rCampo(tcStr, 'Cep');
    (*
   	if (Leitor.rExtrai(3, 'Endereco') <> '') then
    begin
      NFSe.PrestadorServico.Endereco.Endereco := Leitor.rCampo(tcStr, 'Endereco');
      NFSe.PrestadorServico.Endereco.Numero := Leitor.rCampo(tcStr, 'Numero');
      NFSe.PrestadorServico.Endereco.Complemento := Leitor.rCampo(tcStr, 'Complemento');
      NFSe.PrestadorServico.Endereco.Bairro := Leitor.rCampo(tcStr, 'Bairro');
      NFSe.PrestadorServico.Endereco.CodigoMunicipio := Leitor.rCampo(tcStr, 'CodigoMunicipio');
      NFSe.PrestadorServico.Endereco.UF := Leitor.rCampo(tcStr, 'Uf');
      NFSe.PrestadorServico.Endereco.CEP := Leitor.rCampo(tcStr, 'Cep');
    end;
    *)
   	if (Leitor.rExtrai(3, 'Contato') <> '') then
    begin
      NFSe.PrestadorServico.Contato.Telefone := Leitor.rCampo(tcStr, 'Telefone');
      NFSe.PrestadorServico.Contato.Email := Leitor.rCampo(tcStr, 'Email');
    end;

   	if (Leitor.rExtrai(3, 'IdentificacaoPrestador') <> '') then
		begin
     	NFSe.PrestadorServico.IdentificacaoPrestador.InscricaoMunicipal := Leitor.rCampo(tcStr, 'InscricaoMunicipal');

      if Leitor.rExtrai(4, 'CpfCnpj') <> '' then
      begin
        NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj := Leitor.rCampo(tcStr, 'Cpf');

        if NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj = ''
         then NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj := Leitor.rCampo(tcStr, 'Cnpj');
      end;
    end;
  end; // fim PrestadorServico

	if Leitor.rExtrai(2, 'OrgaoGerador') <> '' then
	begin
    NFSe.OrgaoGerador.CodigoMunicipio := Leitor.rCampo(tcStr, 'CodigoMunicipio');
    NFSe.OrgaoGerador.Uf := Leitor.rCampo(tcStr, 'Uf');
  end;

 	if Leitor.rExtrai(2, 'DeclaracaoPrestacaoServico') <> '' then
	begin
    if Leitor.rExtrai(3, 'InfDeclaracaoPrestacaoServico') <> '' then
    begin
      dt := Leitor.rCampo(tcStr, 'Competencia');

      NFSe.Competencia  := dt;

      if Leitor.rExtrai(4, 'Rps') <> '' then
      begin
        dt := Leitor.rCampo(tcStr, 'DataEmissao');

        d := copy(dt, 9, 2);
        m := copy(dt, 6, 2);
        a := copy(dt, 1, 4);

        NFSe.DataEmissaoRps := strtodate(d + '/' + m + '/' + a);
        // Alterado por Joel Takei em 24/07/2013
        NFSe.Status         :=  StrToStatusRps(Ok, Leitor.rCampo(tcStr, 'Status'));

        if (Leitor.rExtrai(5, 'IdentificacaoRps') <> '') then
        begin
          NFSe.IdentificacaoRps.Numero := Leitor.rCampo(tcStr, 'Numero');
          NFSe.IdentificacaoRps.Serie  := Leitor.rCampo(tcStr, 'Serie');
          NFSe.IdentificacaoRps.Tipo   := StrToTipoRPS(ok, Leitor.rCampo(tcStr, 'Tipo'));
        end;
      end;


      if (Leitor.rExtrai(4, 'Servico') <> '') then
      begin
        NFSe.Servico.Valores.IssRetido := StrToSituacaoTributaria(ok, Leitor.rCampo(tcStr, 'IssRetido'));
        NFSe.Servico.ItemListaServico  := Leitor.rCampo(tcStr, 'ItemListaServico');
        NFSe.Servico.Discriminacao     := Leitor.rCampo(tcStr, 'Discriminacao');
        NFSe.Servico.Descricao         := '';

        Item := StrToInt(SomenteNumeros(Nfse.Servico.ItemListaServico));
        if Item<100 then Item:=Item*100+1;

        NFSe.Servico.ItemListaServico := FormatFloat('0000', Item);
        NFSe.Servico.ItemListaServico := Copy(NFSe.Servico.ItemListaServico, 1, 2) + '.' +
                                         Copy(NFSe.Servico.ItemListaServico, 3, 2);

        NFSe.Servico.xItemListaServico := CodigoToDesc(SomenteNumeros(NFSe.Servico.ItemListaServico));

        NFSe.Servico.CodigoMunicipio     := Leitor.rCampo(tcStr, 'CodigoMunicipio');
        NFSe.Servico.CodigoPais          := Leitor.rCampo(tcInt, 'CodigoPais');
        NFSe.Servico.ExigibilidadeISS    := StrToExigibilidadeISS(ok, Leitor.rCampo(tcStr, 'ExigibilidadeISS'));
        NFSe.Servico.MunicipioIncidencia := Leitor.rCampo(tcInt, 'MunicipioIncidencia');

        if (Leitor.rExtrai(5, 'Valores') <> '') then
        begin
          NFSe.Servico.Valores.ValorServicos          := Leitor.rCampo(tcDe2, 'ValorServicos');
          NFSe.Servico.Valores.ValorDeducoes          := Leitor.rCampo(tcDe2, 'ValorDeducoes');
          NFSe.Servico.Valores.ValorPis               := Leitor.rCampo(tcDe2, 'ValorPis');
          NFSe.Servico.Valores.ValorCofins            := Leitor.rCampo(tcDe2, 'ValorCofins');
          NFSe.Servico.Valores.ValorInss              := Leitor.rCampo(tcDe2, 'ValorInss');
          NFSe.Servico.Valores.ValorIr                := Leitor.rCampo(tcDe2, 'ValorIr');
          NFSe.Servico.Valores.ValorCsll              := Leitor.rCampo(tcDe2, 'ValorCsll');
          NFSe.Servico.Valores.OutrasRetencoes        := Leitor.rCampo(tcDe2, 'OutrasRetencoes');
          NFSe.Servico.Valores.ValorIss               := Leitor.rCampo(tcDe2, 'ValorIss');
          NFSe.Servico.Valores.Aliquota               := Leitor.rCampo(tcDe3, 'Aliquota');
          NFSe.Servico.Valores.DescontoIncondicionado := Leitor.rCampo(tcDe2, 'DescontoIncondicionado');
          NFSe.Servico.Valores.DescontoCondicionado   := Leitor.rCampo(tcDe2, 'DescontoCondicionado');
        end;


      end; // fim servico

      if (Leitor.rExtrai(4, 'Prestador') <> '') then
      begin
        NFSe.Prestador.InscricaoMunicipal := Leitor.rCampo(tcStr, 'InscricaoMunicipal');

        if Leitor.rExtrai(5, 'CpfCnpj') <> '' then
        begin
          NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj := Leitor.rCampo(tcStr, 'Cpf');

          if NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj = '' then
            NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj := Leitor.rCampo(tcStr, 'Cnpj');
        end;
      end; // fim Prestador

      if (Leitor.rExtrai(4, 'Tomador') <> '') then
      begin
        NFSe.Tomador.RazaoSocial := Leitor.rCampo(tcStr, 'RazaoSocial');

        NFSe.Tomador.Endereco.Endereco := Leitor.rCampo(tcStr, 'Endereco');

        if Copy(NFSe.Tomador.Endereco.Endereco, 1, 10) = '<Endereco>' then
          NFSe.Tomador.Endereco.Endereco := Copy(NFSe.Tomador.Endereco.Endereco, 11, 125);

        NFSe.Tomador.Endereco.Numero          := Leitor.rCampo(tcStr, 'Numero');
        NFSe.Tomador.Endereco.Complemento     := Leitor.rCampo(tcStr, 'Complemento');
        NFSe.Tomador.Endereco.Bairro          := Leitor.rCampo(tcStr, 'Bairro');
        NFSe.Tomador.Endereco.CodigoMunicipio := Leitor.rCampo(tcStr, 'CodigoMunicipio');
        NFSe.Tomador.Endereco.xMunicipio      := CodCidadeToCidade(StrToIntDef(NFSe.Tomador.Endereco.CodigoMunicipio, 0));
        NFSe.Tomador.Endereco.UF              := Leitor.rCampo(tcStr, 'Uf');
        NFSe.Tomador.Endereco.CEP             := Leitor.rCampo(tcStr, 'CEP');

        if (Leitor.rExtrai(5, 'IdentificacaoTomador') <> '') then
        begin
          if (Leitor.rExtrai(6, 'CpfCnpj') <> '') then
          begin
            NFSe.Tomador.IdentificacaoTomador.CpfCnpj := Leitor.rCampo(tcStr, 'Cpf');

            if NFSe.Tomador.IdentificacaoTomador.CpfCnpj = '' then
              NFSe.Tomador.IdentificacaoTomador.CpfCnpj := Leitor.rCampo(tcStr, 'Cnpj');
          end;
        end;
        (*
        if (Leitor.rExtrai(5, 'Endereco') <> '') then
        begin
          NFSe.Tomador.Endereco.Endereco         := Leitor.rCampo(tcStr, 'Endereco');
          NFSe.Tomador.Endereco.Numero           := Leitor.rCampo(tcStr, 'Numero');
          NFSe.Tomador.Endereco.Complemento      := Leitor.rCampo(tcStr, 'Complemento');
          NFSe.Tomador.Endereco.Bairro           := Leitor.rCampo(tcStr, 'Bairro');
          NFSe.Tomador.Endereco.CodigoMunicipio  := Leitor.rCampo(tcStr, 'CodigoMunicipio');
          NFSe.Tomador.Endereco.UF               := Leitor.rCampo(tcStr, 'Uf');
          NFSe.Tomador.Endereco.CEP              := Leitor.rCampo(tcStr, 'CEP');
        end;
        *)
        if (Leitor.rExtrai(5, 'Contato') <> '') then
        begin
          NFSe.Tomador.Contato.Telefone := Leitor.rCampo(tcStr, 'Telefone');
          NFSe.Tomador.Contato.Email := Leitor.rCampo(tcStr, 'Email');
        end;
      end; // fim tomador

      NFSe.OptanteSimplesNacional  := StrToSimNao(ok, Leitor.rCampo(tcStr, 'OptanteSimplesNacional'));
      NFSe.IncentivadorCultural  := TNfseSimNao(Leitor.rCampo(tcInt, 'IncentivoFiscal'));
    end;
  end; // fim DeclaracaoPrestacaoServico
end;

procedure TNFSeR.NFSe_ProvedorTiplan;
var
 item: Integer;
 ok  : Boolean;
begin
  if (Leitor.rExtrai(3, 'IdentificacaoRps') <> '')
  then begin
   NFSe.IdentificacaoRps.Numero := Leitor.rCampo(tcStr, 'Numero');
   NFSe.IdentificacaoRps.Serie  := Leitor.rCampo(tcStr, 'Serie');
   NFSe.IdentificacaoRps.Tipo   := StrToTipoRPS(ok, Leitor.rCampo(tcStr, 'Tipo'));
   NFSe.InfID.ID                := SomenteNumeros(NFSe.IdentificacaoRps.Numero) + NFSe.IdentificacaoRps.Serie;
  end;

  if (Leitor.rExtrai(3, 'Servico') <> '')
   then begin
    NFSe.Servico.ResponsavelRetencao := StrToResponsavelRetencao(ok, Leitor.rCampo(tcStr, 'ResponsavelRetencao'));
    NFSe.Servico.ItemListaServico    := DFeUtil.LimpaNumero(Leitor.rCampo(tcStr, 'ItemListaServico'));

   Item := StrToInt(SomenteNumeros(Nfse.Servico.ItemListaServico));
   if Item<100 then Item:=Item*100+1;

   NFSe.Servico.ItemListaServico := FormatFloat('0000', Item);
   NFSe.Servico.ItemListaServico := Copy(NFSe.Servico.ItemListaServico, 1, 2) + '.' +
                                    Copy(NFSe.Servico.ItemListaServico, 3, 2);

   NFSe.Servico.xItemListaServico := CodigoToDesc(SomenteNumeros(NFSe.Servico.ItemListaServico));
   
   NFSe.Servico.CodigoCnae          := Leitor.rCampo(tcStr, 'CodigoCnae');
   NFSe.Servico.Discriminacao       := Leitor.rCampo(tcStr, 'Discriminacao');
   NFSe.Servico.Descricao           := '';
   NFSe.Servico.CodigoMunicipio     := Leitor.rCampo(tcStr, 'CodigoMunicipio');
   NFSe.Servico.CodigoPais          := Leitor.rCampo(tcInt, 'CodigoPais');
   NFSe.Servico.ExigibilidadeISS    := StrToExigibilidadeISS(ok, Leitor.rCampo(tcStr, 'ExigibilidadeISS'));
   //NFSe.Servico.MunicipioIncidencia := Leitor.rCampo(tcInt, 'MunicipioIncidencia');
   NFSe.Servico.MunicipioIncidencia := Leitor.rCampo(tcStr, 'CodigoMunicipio');

  if (Leitor.rExtrai(4, 'Valores') <> '')
    then begin
     NFSe.Servico.Valores.ValorServicos          := Leitor.rCampo(tcDe2, 'ValorServicos');
     NFSe.Servico.Valores.ValorDeducoes          := Leitor.rCampo(tcDe2, 'ValorDeducoes');
     NFSe.Servico.Valores.ValorPis               := Leitor.rCampo(tcDe2, 'ValorPis');
     NFSe.Servico.Valores.ValorCofins            := Leitor.rCampo(tcDe2, 'ValorCofins');
     NFSe.Servico.Valores.ValorInss              := Leitor.rCampo(tcDe2, 'ValorInss');
     NFSe.Servico.Valores.ValorIr                := Leitor.rCampo(tcDe2, 'ValorIr');
     NFSe.Servico.Valores.ValorCsll              := Leitor.rCampo(tcDe2, 'ValorCsll');
     NFSe.Servico.Valores.OutrasRetencoes        := Leitor.rCampo(tcDe2, 'OutrasRetencoes');
     NFSe.Servico.Valores.IssRetido              := StrToSituacaoTributaria(ok, Leitor.rCampo(tcStr, 'IssRetido'));
     NFSe.Servico.Valores.ValorIss               := Leitor.rCampo(tcDe2, 'ValorIss');
     NFSe.Servico.Valores.BaseCalculo            := Leitor.rCampo(tcDe2, 'BaseCalculo');
     NFSe.Servico.Valores.Aliquota               := Leitor.rCampo(tcDe3, 'Aliquota');
     NFSe.Servico.Valores.ValorLiquidoNfse       := Leitor.rCampo(tcDe2, 'ValorLiquidoNfse');
     NFSe.Servico.Valores.ValorIssRetido         := Leitor.rCampo(tcDe2, 'ValorIssRetido');
     NFSe.Servico.Valores.DescontoCondicionado   := Leitor.rCampo(tcDe2, 'DescontoCondicionado');
     NFSe.Servico.Valores.DescontoIncondicionado := Leitor.rCampo(tcDe2, 'DescontoIncondicionado');
    end;

  end; // fim serviço

  if Leitor.rExtrai(3, 'PrestadorServico') <> ''
   then begin
   NFSe.PrestadorServico.RazaoSocial  := Leitor.rCampo(tcStr, 'RazaoSocial');
   NFSe.PrestadorServico.NomeFantasia := Leitor.rCampo(tcStr, 'NomeFantasia');

   NFSe.PrestadorServico.Endereco.Endereco := Leitor.rCampo(tcStr, 'Endereco');
   if Copy(NFSe.PrestadorServico.Endereco.Endereco, 1, 10) = '<' + 'Endereco>'
    then NFSe.PrestadorServico.Endereco.Endereco := Copy(NFSe.PrestadorServico.Endereco.Endereco, 11, 125);

   NFSe.PrestadorServico.Endereco.Numero      := Leitor.rCampo(tcStr, 'Numero');
   NFSe.PrestadorServico.Endereco.Complemento := Leitor.rCampo(tcStr, 'Complemento');
   NFSe.PrestadorServico.Endereco.Bairro      := Leitor.rCampo(tcStr, 'Bairro');

  if VersaoXML='1'
   then begin
    NFSe.PrestadorServico.Endereco.CodigoMunicipio := Leitor.rCampo(tcStr, 'Cidade');
    NFSe.PrestadorServico.Endereco.UF              := Leitor.rCampo(tcStr, 'Estado');
   end
   else begin
    NFSe.PrestadorServico.Endereco.CodigoMunicipio := Leitor.rCampo(tcStr, 'CodigoMunicipio');
    NFSe.PrestadorServico.Endereco.UF              := Leitor.rCampo(tcStr, 'Uf');
   end;

   NFSe.PrestadorServico.Endereco.CodigoPais := Leitor.rCampo(tcInt, 'CodigoPais');
   NFSe.PrestadorServico.Endereco.CEP        := Leitor.rCampo(tcStr, 'Cep');

  if length(NFSe.PrestadorServico.Endereco.CodigoMunicipio)<7
   then NFSe.PrestadorServico.Endereco.CodigoMunicipio := Copy(NFSe.PrestadorServico.Endereco.CodigoMunicipio, 1, 2) +
          FormatFloat('00000', StrToIntDef(Copy(NFSe.PrestadorServico.Endereco.CodigoMunicipio, 3, 5), 0));

  NFSe.PrestadorServico.Endereco.xMunicipio := CodCidadeToCidade(StrToIntDef(NFSe.PrestadorServico.Endereco.CodigoMunicipio, 0));

  if (Leitor.rExtrai(4, 'IdentificacaoPrestador') <> '')
   then begin
    NFSe.PrestadorServico.IdentificacaoPrestador.InscricaoMunicipal := Leitor.rCampo(tcStr, 'InscricaoMunicipal');

    if VersaoXML='1'
      then begin
       if Leitor.rExtrai(5, 'CpfCnpj') <> ''
        then begin
          NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj := Leitor.rCampo(tcStr, 'Cpf');
          if NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj = ''
           then NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj := Leitor.rCampo(tcStr, 'Cnpj');
        end;
      end
      else begin
       NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj := Leitor.rCampo(tcStr, 'Cnpj');
      end;
    end;

  if Leitor.rExtrai(4, 'Contato') <> ''
    then begin
     NFSe.PrestadorServico.Contato.Telefone := Leitor.rCampo(tcStr, 'Telefone');
     NFSe.PrestadorServico.Contato.Email    := Leitor.rCampo(tcStr, 'Email');
    end;

  end; // fim PrestadorServico

  if Leitor.rExtrai(3, 'TomadorServico') <> ''
  then begin
   NFSe.Tomador.RazaoSocial := Leitor.rCampo(tcStr, 'RazaoSocial');

   NFSe.Tomador.Endereco.Endereco := Leitor.rCampo(tcStr, 'Endereco');
   if Copy(NFSe.Tomador.Endereco.Endereco, 1, 10) = '<' + 'Endereco>'
    then NFSe.Tomador.Endereco.Endereco := Copy(NFSe.Tomador.Endereco.Endereco, 11, 125);

   NFSe.Tomador.Endereco.Numero      := Leitor.rCampo(tcStr, 'Numero');
   NFSe.Tomador.Endereco.Complemento := Leitor.rCampo(tcStr, 'Complemento');
   NFSe.Tomador.Endereco.Bairro      := Leitor.rCampo(tcStr, 'Bairro');

   if VersaoXML='1'
    then begin
     NFSe.Tomador.Endereco.CodigoMunicipio := Leitor.rCampo(tcStr, 'Cidade');
     NFSe.Tomador.Endereco.UF              := Leitor.rCampo(tcStr, 'Estado');
    end
    else begin
     NFSe.Tomador.Endereco.CodigoMunicipio := Leitor.rCampo(tcStr, 'CodigoMunicipio');
     NFSe.Tomador.Endereco.UF              := Leitor.rCampo(tcStr, 'Uf');
    end;

  NFSe.Tomador.Endereco.CEP := Leitor.rCampo(tcStr, 'Cep');

  if length(NFSe.Tomador.Endereco.CodigoMunicipio)<7
    then NFSe.Tomador.Endereco.CodigoMunicipio := Copy(NFSe.Tomador.Endereco.CodigoMunicipio, 1, 2) +
         FormatFloat('00000', StrToIntDef(Copy(NFSe.Tomador.Endereco.CodigoMunicipio, 3, 5), 0));

  if NFSe.Tomador.Endereco.UF = ''
   then NFSe.Tomador.Endereco.UF := NFSe.PrestadorServico.Endereco.UF;

   NFSe.Tomador.Endereco.xMunicipio := CodCidadeToCidade(StrToIntDef(NFSe.Tomador.Endereco.CodigoMunicipio, 0));

  if Leitor.rExtrai(4, 'Contato') <> ''
    then begin
     NFSe.Tomador.Contato.Telefone := Leitor.rCampo(tcStr, 'Telefone');
     NFSe.Tomador.Contato.Email    := Leitor.rCampo(tcStr, 'Email');
    end;

  if Leitor.rExtrai(4, 'IdentificacaoTomador') <> ''
    then begin
    NFSe.Tomador.IdentificacaoTomador.InscricaoMunicipal := Leitor.rCampo(tcStr, 'InscricaoMunicipal');
    if Leitor.rExtrai(5, 'CpfCnpj') <> ''
     then begin
      if Leitor.rCampo(tcStr, 'Cpf')<>''
       then NFSe.Tomador.IdentificacaoTomador.CpfCnpj := Leitor.rCampo(tcStr, 'Cpf')
       else NFSe.Tomador.IdentificacaoTomador.CpfCnpj := Leitor.rCampo(tcStr, 'Cnpj');
     end;
    end;
  end;

  if Leitor.rExtrai(3, 'IntermediarioServico') <> ''
   then begin
    NFSe.IntermediarioServico.RazaoSocial        := Leitor.rCampo(tcStr, 'RazaoSocial');
    NFSe.IntermediarioServico.InscricaoMunicipal := Leitor.rCampo(tcStr, 'InscricaoMunicipal');
    if Leitor.rExtrai(4, 'CpfCnpj') <> ''
     then begin
     if Leitor.rCampo(tcStr, 'Cpf')<>''
      then NFSe.IntermediarioServico.CpfCnpj := Leitor.rCampo(tcStr, 'Cpf')
      else NFSe.IntermediarioServico.CpfCnpj := Leitor.rCampo(tcStr, 'Cnpj');
    end;
  end;

  if Leitor.rExtrai(3, 'OrgaoGerador') <> ''
   then begin
    NFSe.OrgaoGerador.CodigoMunicipio := Leitor.rCampo(tcStr, 'CodigoMunicipio');
    NFSe.OrgaoGerador.Uf              := Leitor.rCampo(tcStr, 'Uf');
  end; // fim OrgaoGerador

  if Leitor.rExtrai(3, 'ConstrucaoCivil') <> ''
   then begin
    NFSe.ConstrucaoCivil.CodigoObra := Leitor.rCampo(tcStr, 'CodigoObra');
    NFSe.ConstrucaoCivil.Art        := Leitor.rCampo(tcStr, 'Art');
  end;
end;

procedure TNFSeR.NFSe_ProvedorSimplISS;
var
 item: Integer;
 ok  : Boolean;
begin
  if (Leitor.rExtrai(3, 'IdentificacaoRps') <> '')
  then begin
   NFSe.IdentificacaoRps.Numero := Leitor.rCampo(tcStr, 'Numero');
   NFSe.IdentificacaoRps.Serie  := Leitor.rCampo(tcStr, 'Serie');
   NFSe.IdentificacaoRps.Tipo   := StrToTipoRPS(ok, Leitor.rCampo(tcStr, 'Tipo'));
   NFSe.InfID.ID                := SomenteNumeros(NFSe.IdentificacaoRps.Numero) + NFSe.IdentificacaoRps.Serie;
  end;

  if (Leitor.rExtrai(3, 'Servico') <> '')
   then begin
    NFSe.Servico.ResponsavelRetencao := StrToResponsavelRetencao(ok, Leitor.rCampo(tcStr, 'ResponsavelRetencao'));
    NFSe.Servico.ItemListaServico    := DFeUtil.LimpaNumero(Leitor.rCampo(tcStr, 'ItemListaServico'));

   Item := StrToInt(SomenteNumeros(Nfse.Servico.ItemListaServico));
   if Item<100 then Item:=Item*100+1;

   NFSe.Servico.ItemListaServico := FormatFloat('0000', Item);
   NFSe.Servico.ItemListaServico := Copy(NFSe.Servico.ItemListaServico, 1, 2) + '.' +
                                    Copy(NFSe.Servico.ItemListaServico, 3, 2);

   NFSe.Servico.xItemListaServico := CodigoToDesc(SomenteNumeros(NFSe.Servico.ItemListaServico));

   NFSe.Servico.CodigoCnae          := Leitor.rCampo(tcStr, 'CodigoCnae');
   NFSe.Servico.Discriminacao       := Leitor.rCampo(tcStr, 'Discriminacao');
   NFSe.Servico.Descricao           := '';
   NFSe.Servico.CodigoMunicipio     := Leitor.rCampo(tcStr, 'CodigoMunicipio');
   NFSe.Servico.CodigoPais          := Leitor.rCampo(tcInt, 'CodigoPais');
   NFSe.Servico.ExigibilidadeISS    := StrToExigibilidadeISS(ok, Leitor.rCampo(tcStr, 'ExigibilidadeISS'));
   //NFSe.Servico.MunicipioIncidencia := Leitor.rCampo(tcInt, 'MunicipioIncidencia');
   NFSe.Servico.MunicipioIncidencia := Leitor.rCampo(tcStr, 'CodigoMunicipio');

  if (Leitor.rExtrai(4, 'Valores') <> '')
    then begin
     NFSe.Servico.Valores.ValorServicos          := Leitor.rCampo(tcDe2, 'ValorServicos');
     NFSe.Servico.Valores.ValorDeducoes          := Leitor.rCampo(tcDe2, 'ValorDeducoes');
     NFSe.Servico.Valores.ValorPis               := Leitor.rCampo(tcDe2, 'ValorPis');
     NFSe.Servico.Valores.ValorCofins            := Leitor.rCampo(tcDe2, 'ValorCofins');
     NFSe.Servico.Valores.ValorInss              := Leitor.rCampo(tcDe2, 'ValorInss');
     NFSe.Servico.Valores.ValorIr                := Leitor.rCampo(tcDe2, 'ValorIr');
     NFSe.Servico.Valores.ValorCsll              := Leitor.rCampo(tcDe2, 'ValorCsll');
     NFSe.Servico.Valores.OutrasRetencoes        := Leitor.rCampo(tcDe2, 'OutrasRetencoes');
     NFSe.Servico.Valores.IssRetido              := StrToSituacaoTributaria(ok, Leitor.rCampo(tcStr, 'IssRetido'));
     NFSe.Servico.Valores.ValorIss               := Leitor.rCampo(tcDe2, 'ValorIss');
     NFSe.Servico.Valores.BaseCalculo            := Leitor.rCampo(tcDe2, 'BaseCalculo');
     NFSe.Servico.Valores.Aliquota               := Leitor.rCampo(tcDe3, 'Aliquota');
     NFSe.Servico.Valores.ValorLiquidoNfse       := Leitor.rCampo(tcDe2, 'ValorLiquidoNfse');
     NFSe.Servico.Valores.ValorIssRetido         := Leitor.rCampo(tcDe2, 'ValorIssRetido');
     NFSe.Servico.Valores.DescontoCondicionado   := Leitor.rCampo(tcDe2, 'DescontoCondicionado');
     NFSe.Servico.Valores.DescontoIncondicionado := Leitor.rCampo(tcDe2, 'DescontoIncondicionado');
    end;

  end; // fim serviço

  if Leitor.rExtrai(3, 'PrestadorServico') <> ''
   then begin
   NFSe.PrestadorServico.RazaoSocial  := Leitor.rCampo(tcStr, 'RazaoSocial');
   NFSe.PrestadorServico.NomeFantasia := Leitor.rCampo(tcStr, 'NomeFantasia');

   NFSe.PrestadorServico.Endereco.Endereco := Leitor.rCampo(tcStr, 'Endereco');
   if Copy(NFSe.PrestadorServico.Endereco.Endereco, 1, 10) = '<' + 'Endereco>'
    then NFSe.PrestadorServico.Endereco.Endereco := Copy(NFSe.PrestadorServico.Endereco.Endereco, 11, 125);

   NFSe.PrestadorServico.Endereco.Numero      := Leitor.rCampo(tcStr, 'Numero');
   NFSe.PrestadorServico.Endereco.Complemento := Leitor.rCampo(tcStr, 'Complemento');
   NFSe.PrestadorServico.Endereco.Bairro      := Leitor.rCampo(tcStr, 'Bairro');

  if VersaoXML='1'
   then begin
    NFSe.PrestadorServico.Endereco.CodigoMunicipio := Leitor.rCampo(tcStr, 'Cidade');
    NFSe.PrestadorServico.Endereco.UF              := Leitor.rCampo(tcStr, 'Estado');
   end
   else begin
    NFSe.PrestadorServico.Endereco.CodigoMunicipio := Leitor.rCampo(tcStr, 'CodigoMunicipio');
    NFSe.PrestadorServico.Endereco.UF              := Leitor.rCampo(tcStr, 'Uf');
   end;

   NFSe.PrestadorServico.Endereco.CodigoPais := Leitor.rCampo(tcInt, 'CodigoPais');
   NFSe.PrestadorServico.Endereco.CEP        := Leitor.rCampo(tcStr, 'Cep');

  if length(NFSe.PrestadorServico.Endereco.CodigoMunicipio)<7
   then NFSe.PrestadorServico.Endereco.CodigoMunicipio := Copy(NFSe.PrestadorServico.Endereco.CodigoMunicipio, 1, 2) +
          FormatFloat('00000', StrToIntDef(Copy(NFSe.PrestadorServico.Endereco.CodigoMunicipio, 3, 5), 0));

  NFSe.PrestadorServico.Endereco.xMunicipio := CodCidadeToCidade(StrToIntDef(NFSe.PrestadorServico.Endereco.CodigoMunicipio, 0));

  if (Leitor.rExtrai(4, 'IdentificacaoPrestador') <> '')
   then begin
    NFSe.PrestadorServico.IdentificacaoPrestador.InscricaoMunicipal := Leitor.rCampo(tcStr, 'InscricaoMunicipal');

    if VersaoXML='1'
      then begin
       if Leitor.rExtrai(5, 'CpfCnpj') <> ''
        then begin
          NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj := Leitor.rCampo(tcStr, 'Cpf');
          if NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj = ''
           then NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj := Leitor.rCampo(tcStr, 'Cnpj');
        end;
      end
      else begin
       NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj := Leitor.rCampo(tcStr, 'Cnpj');
      end;
    end;

  if Leitor.rExtrai(4, 'Contato') <> ''
    then begin
     NFSe.PrestadorServico.Contato.Telefone := Leitor.rCampo(tcStr, 'Telefone');
     NFSe.PrestadorServico.Contato.Email    := Leitor.rCampo(tcStr, 'Email');
    end;

  end; // fim PrestadorServico

  if Leitor.rExtrai(3, 'TomadorServico') <> ''
  then begin
   NFSe.Tomador.RazaoSocial := Leitor.rCampo(tcStr, 'RazaoSocial');

   NFSe.Tomador.Endereco.Endereco := Leitor.rCampo(tcStr, 'Endereco');
   if Copy(NFSe.Tomador.Endereco.Endereco, 1, 10) = '<' + 'Endereco>'
    then NFSe.Tomador.Endereco.Endereco := Copy(NFSe.Tomador.Endereco.Endereco, 11, 125);

   NFSe.Tomador.Endereco.Numero      := Leitor.rCampo(tcStr, 'Numero');
   NFSe.Tomador.Endereco.Complemento := Leitor.rCampo(tcStr, 'Complemento');
   NFSe.Tomador.Endereco.Bairro      := Leitor.rCampo(tcStr, 'Bairro');

   if VersaoXML='1'
    then begin
     NFSe.Tomador.Endereco.CodigoMunicipio := Leitor.rCampo(tcStr, 'Cidade');
     NFSe.Tomador.Endereco.UF              := Leitor.rCampo(tcStr, 'Estado');
    end
    else begin
     NFSe.Tomador.Endereco.CodigoMunicipio := Leitor.rCampo(tcStr, 'CodigoMunicipio');
     NFSe.Tomador.Endereco.UF              := Leitor.rCampo(tcStr, 'Uf');
    end;

  NFSe.Tomador.Endereco.CEP := Leitor.rCampo(tcStr, 'Cep');

  if length(NFSe.Tomador.Endereco.CodigoMunicipio)<7
    then NFSe.Tomador.Endereco.CodigoMunicipio := Copy(NFSe.Tomador.Endereco.CodigoMunicipio, 1, 2) +
         FormatFloat('00000', StrToIntDef(Copy(NFSe.Tomador.Endereco.CodigoMunicipio, 3, 5), 0));

  if NFSe.Tomador.Endereco.UF = ''
   then NFSe.Tomador.Endereco.UF := NFSe.PrestadorServico.Endereco.UF;

   NFSe.Tomador.Endereco.xMunicipio := CodCidadeToCidade(StrToIntDef(NFSe.Tomador.Endereco.CodigoMunicipio, 0));

  if Leitor.rExtrai(4, 'Contato') <> ''
    then begin
     NFSe.Tomador.Contato.Telefone := Leitor.rCampo(tcStr, 'Telefone');
     NFSe.Tomador.Contato.Email    := Leitor.rCampo(tcStr, 'Email');
    end;

  if Leitor.rExtrai(4, 'IdentificacaoTomador') <> ''
    then begin
    NFSe.Tomador.IdentificacaoTomador.InscricaoMunicipal := Leitor.rCampo(tcStr, 'InscricaoMunicipal');
    if Leitor.rExtrai(5, 'CpfCnpj') <> ''
     then begin
      if Leitor.rCampo(tcStr, 'Cpf')<>''
       then NFSe.Tomador.IdentificacaoTomador.CpfCnpj := Leitor.rCampo(tcStr, 'Cpf')
       else NFSe.Tomador.IdentificacaoTomador.CpfCnpj := Leitor.rCampo(tcStr, 'Cnpj');
     end;
    end;
  end;

  if Leitor.rExtrai(3, 'IntermediarioServico') <> ''
   then begin
    NFSe.IntermediarioServico.RazaoSocial        := Leitor.rCampo(tcStr, 'RazaoSocial');
    NFSe.IntermediarioServico.InscricaoMunicipal := Leitor.rCampo(tcStr, 'InscricaoMunicipal');
    if Leitor.rExtrai(4, 'CpfCnpj') <> ''
     then begin
     if Leitor.rCampo(tcStr, 'Cpf')<>''
      then NFSe.IntermediarioServico.CpfCnpj := Leitor.rCampo(tcStr, 'Cpf')
      else NFSe.IntermediarioServico.CpfCnpj := Leitor.rCampo(tcStr, 'Cnpj');
    end;
  end;

  if Leitor.rExtrai(3, 'OrgaoGerador') <> ''
   then begin
    NFSe.OrgaoGerador.CodigoMunicipio := Leitor.rCampo(tcStr, 'CodigoMunicipio');
    NFSe.OrgaoGerador.Uf              := Leitor.rCampo(tcStr, 'Uf');
  end; // fim OrgaoGerador

  if Leitor.rExtrai(3, 'ConstrucaoCivil') <> ''
   then begin
    NFSe.ConstrucaoCivil.CodigoObra := Leitor.rCampo(tcStr, 'CodigoObra');
    NFSe.ConstrucaoCivil.Art        := Leitor.rCampo(tcStr, 'Art');
  end;
end;

procedure TNFSeR.NFSe_ProvedorVirtual;
var
 ok  : Boolean;
 Item: Integer;
begin
 	if Leitor.rExtrai(3, 'ValoresNfse') <> '' then
	begin
   	NFSe.Servico.Valores.BaseCalculo      := Leitor.rCampo(tcDe2, 'BaseCalculo');
   	NFSe.Servico.Valores.Aliquota         := Leitor.rCampo(tcDe3, 'Aliquota');
   	NFSe.Servico.Valores.ValorIss         := Leitor.rCampo(tcDe2, 'ValorIss');
  end; // fim ValoresNfse

 if Leitor.rExtrai(3, 'EnderecoPrestadorServico') <> '' then 
 begin

   NFSe.PrestadorServico.Endereco.Endereco := Leitor.rCampo(tcStr, 'Endereco');
   if Copy(NFSe.PrestadorServico.Endereco.Endereco, 1, 10) = '<' + 'Endereco>'
    then NFSe.PrestadorServico.Endereco.Endereco := Copy(NFSe.PrestadorServico.Endereco.Endereco, 11, 125);

   NFSe.PrestadorServico.Endereco.Numero      := Leitor.rCampo(tcStr, 'Numero');
   NFSe.PrestadorServico.Endereco.Complemento := Leitor.rCampo(tcStr, 'Complemento');
   NFSe.PrestadorServico.Endereco.Bairro      := Leitor.rCampo(tcStr, 'Bairro');

   if VersaoXML='1'
    then begin
     NFSe.PrestadorServico.Endereco.CodigoMunicipio := Leitor.rCampo(tcStr, 'Cidade');
     NFSe.PrestadorServico.Endereco.UF              := Leitor.rCampo(tcStr, 'Estado');
    end
    else begin
     NFSe.PrestadorServico.Endereco.CodigoMunicipio := Leitor.rCampo(tcStr, 'CodigoMunicipio');
     NFSe.PrestadorServico.Endereco.UF              := Leitor.rCampo(tcStr, 'Uf');
    end;

   NFSe.PrestadorServico.Endereco.CodigoPais := Leitor.rCampo(tcInt, 'CodigoPais');
   NFSe.PrestadorServico.Endereco.CEP        := Leitor.rCampo(tcStr, 'Cep');

   if length(NFSe.PrestadorServico.Endereco.CodigoMunicipio)<7
    then NFSe.PrestadorServico.Endereco.CodigoMunicipio := Copy(NFSe.PrestadorServico.Endereco.CodigoMunicipio, 1, 2) +
           FormatFloat('00000', StrToIntDef(Copy(NFSe.PrestadorServico.Endereco.CodigoMunicipio, 3, 5), 0));

   NFSe.PrestadorServico.Endereco.xMunicipio := CodCidadeToCidade(StrToIntDef(NFSe.PrestadorServico.Endereco.CodigoMunicipio, 0));

  end; // fim EnderecoPrestadorServico

 	if Leitor.rExtrai(3, 'DeclaracaoPrestacaoServico') <> '' then
	begin
    NFSe.Competencia            := Leitor.rCampo(tcStr, 'Competencia');
    NFSe.OptanteSimplesNacional := StrToSimNao(ok, Leitor.rCampo(tcStr, 'OptanteSimplesNacional'));
    NFSe.DataEmissaoRps         := Leitor.rCampo(tcDat, 'DataEmissao');

    if (Leitor.rExtrai(4, 'IdentificacaoRps') <> '') then
		begin
      NFSe.IdentificacaoRps.Numero := Leitor.rCampo(tcStr, 'Numero');
      NFSe.IdentificacaoRps.Serie  := Leitor.rCampo(tcStr, 'Serie');
      NFSe.IdentificacaoRps.Tipo   := StrToTipoRPS(ok, Leitor.rCampo(tcStr, 'Tipo'));
    end;

    if (Leitor.rExtrai(4, 'Servico') <> '') then
		begin
       NFSe.Servico.Valores.IssRetido         := StrToSituacaoTributaria(ok, Leitor.rCampo(tcStr, 'IssRetido'));
       NFSe.Servico.ItemListaServico          := DFeUtil.LimpaNumero(Leitor.rCampo(tcStr, 'ItemListaServico'));

       Item := StrToInt(SomenteNumeros(Nfse.Servico.ItemListaServico));
       if Item<100 then Item:=Item*100+1;

       NFSe.Servico.ItemListaServico := FormatFloat('0000', Item);
       NFSe.Servico.ItemListaServico := Copy(NFSe.Servico.ItemListaServico, 1, 2) + '.' +
                                        Copy(NFSe.Servico.ItemListaServico, 3, 2);

       NFSe.Servico.xItemListaServico := CodigoToDesc(SomenteNumeros(NFSe.Servico.ItemListaServico));

       NFSe.Servico.CodigoTributacaoMunicipio := Leitor.rCampo(tcStr, 'CodigoTributacaoMunicipio');
       NFSe.Servico.Discriminacao             := Leitor.rCampo(tcStr, 'Discriminacao');
       NFSe.Servico.Descricao                 := '';
       NFSe.Servico.CodigoMunicipio           := Leitor.rCampo(tcStr, 'CodigoMunicipio');
       NFSe.Servico.ExigibilidadeISS          := StrToExigibilidadeISS(ok, Leitor.rCampo(tcStr, 'ExigibilidadeISS'));
       NFSe.Servico.MunicipioIncidencia       := Leitor.rCampo(tcInt, 'MunicipioIncidencia');

       if StrToIntDef(NFSe.PrestadorServico.Endereco.CodigoMunicipio, 0) = 0
        then begin
         NFSe.PrestadorServico.Endereco.CodigoMunicipio := NFSe.Servico.CodigoMunicipio;
         if length(NFSe.PrestadorServico.Endereco.CodigoMunicipio)<7
          then NFSe.PrestadorServico.Endereco.CodigoMunicipio := Copy(NFSe.PrestadorServico.Endereco.CodigoMunicipio, 1, 2) +
           FormatFloat('00000', StrToIntDef(Copy(NFSe.PrestadorServico.Endereco.CodigoMunicipio, 3, 5), 0));

         NFSe.PrestadorServico.Endereco.xMunicipio := CodCidadeToCidade(StrToIntDef(NFSe.PrestadorServico.Endereco.CodigoMunicipio, 0));
        end;

       if (Leitor.rExtrai(4, 'Valores') <> '')
        then begin
         NFSe.Servico.Valores.ValorServicos          := Leitor.rCampo(tcDe2, 'ValorServicos');
         NFSe.Servico.Valores.ValorDeducoes          := Leitor.rCampo(tcDe2, 'ValorDeducoes');
         NFSe.Servico.Valores.ValorPis               := Leitor.rCampo(tcDe2, 'ValorPis');
         NFSe.Servico.Valores.ValorCofins            := Leitor.rCampo(tcDe2, 'ValorCofins');
         NFSe.Servico.Valores.ValorInss              := Leitor.rCampo(tcDe2, 'ValorInss');
         NFSe.Servico.Valores.ValorIr                := Leitor.rCampo(tcDe2, 'ValorIr');
         NFSe.Servico.Valores.ValorCsll              := Leitor.rCampo(tcDe2, 'ValorCsll');
         NFSe.Servico.Valores.OutrasRetencoes        := Leitor.rCampo(tcDe2, 'OutrasRetencoes');
         // Comentado as linhas abaixo pois no grupo ValoresNfse já foram carregadas
         // NFSe.Servico.Valores.ValorIss               := Leitor.rCampo(tcDe2, 'ValorIss');
         // NFSe.Servico.Valores.Aliquota               := Leitor.rCampo(tcDe3, 'Aliquota');
         NFSe.Servico.Valores.DescontoIncondicionado := Leitor.rCampo(tcDe2, 'DescontoIncondicionado');
         NFSe.Servico.Valores.DescontoCondicionado   := Leitor.rCampo(tcDe2, 'DescontoCondicionado');
        end;
        NFSe.Servico.Valores.ValorLiquidoNfse        := NFSe.Servico.Valores.ValorServicos
                                                        - NFSe.Servico.Valores.ValorDeducoes
                                                        - NFSe.Servico.Valores.DescontoIncondicionado;

       if NFSe.Servico.Valores.IssRetido = stRetencao
        then NFSe.Servico.Valores.ValorIssRetido := NFSe.Servico.Valores.ValorIss
        else NFSe.Servico.Valores.ValorIssRetido := 0.0;

     end; // fim serviço

     if (Leitor.rExtrai(4, 'Prestador') <> '')
      then begin
       NFSe.PrestadorServico.IdentificacaoPrestador.InscricaoMunicipal := Leitor.rCampo(tcStr, 'InscricaoMunicipal');

       if VersaoXML='1'
        then begin
         if Leitor.rExtrai(4, 'CpfCnpj') <> ''
          then begin
            NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj := Leitor.rCampo(tcStr, 'Cpf');
            if NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj = ''
             then NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj := Leitor.rCampo(tcStr, 'Cnpj');
          end;
        end
        else begin
         NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj := Leitor.rCampo(tcStr, 'Cnpj');
        end;

      end; // fim Prestador

     if (Leitor.rExtrai(4, 'Tomador') <> '')
      then begin
       NFSe.Tomador.RazaoSocial := Leitor.rCampo(tcStr, 'RazaoSocial');

       NFSe.Tomador.Endereco.Endereco := Leitor.rCampo(tcStr, 'Endereco');
       if Copy(NFSe.Tomador.Endereco.Endereco, 1, 10) = '<' + 'Endereco>'
        then NFSe.Tomador.Endereco.Endereco := Copy(NFSe.Tomador.Endereco.Endereco, 11, 125);

       NFSe.Tomador.Endereco.Numero      := Leitor.rCampo(tcStr, 'Numero');
       NFSe.Tomador.Endereco.Complemento := Leitor.rCampo(tcStr, 'Complemento');
       NFSe.Tomador.Endereco.Bairro      := Leitor.rCampo(tcStr, 'Bairro');

       if VersaoXML='1'
        then begin
         NFSe.Tomador.Endereco.CodigoMunicipio := Leitor.rCampo(tcStr, 'Cidade');
         NFSe.Tomador.Endereco.UF              := Leitor.rCampo(tcStr, 'Estado');
        end
        else begin
         NFSe.Tomador.Endereco.CodigoMunicipio := Leitor.rCampo(tcStr, 'CodigoMunicipio');
         NFSe.Tomador.Endereco.UF              := Leitor.rCampo(tcStr, 'Uf');
        end;

       	NFSe.Tomador.Endereco.CEP := Leitor.rCampo(tcStr, 'Cep');

       	if length(NFSe.Tomador.Endereco.CodigoMunicipio)<7
        then NFSe.Tomador.Endereco.CodigoMunicipio := Copy(NFSe.Tomador.Endereco.CodigoMunicipio, 1, 2) +
          FormatFloat('00000', StrToIntDef(Copy(NFSe.Tomador.Endereco.CodigoMunicipio, 3, 5), 0));

       	if NFSe.Tomador.Endereco.UF = ''
        then NFSe.Tomador.Endereco.UF := NFSe.PrestadorServico.Endereco.UF;

       	NFSe.Tomador.Endereco.xMunicipio := CodCidadeToCidade(StrToIntDef(NFSe.Tomador.Endereco.CodigoMunicipio, 0));

       	if (Leitor.rExtrai(4, 'IdentificacaoTomador') <> '') then
				begin
         	NFSe.Tomador.IdentificacaoTomador.InscricaoMunicipal := Leitor.rCampo(tcStr, 'InscricaoMunicipal');
         	if Leitor.rCampo(tcStr, 'Cpf')<>'' then
						NFSe.Tomador.IdentificacaoTomador.CpfCnpj := Leitor.rCampo(tcStr, 'Cpf')
         	else
						NFSe.Tomador.IdentificacaoTomador.CpfCnpj := Leitor.rCampo(tcStr, 'Cnpj');
        end;
      end; // fim Tomador
  end; // fim DeclaracaoPrestacaoServico

(*
 if (Leitor.rExtrai(3, 'IdentificacaoRps') <> '')
  then begin
   NFSe.IdentificacaoRps.Numero := Leitor.rCampo(tcStr, 'Numero');
   NFSe.IdentificacaoRps.Serie  := Leitor.rCampo(tcStr, 'Serie');
   NFSe.IdentificacaoRps.Tipo   := StrToTipoRPS(ok, Leitor.rCampo(tcStr, 'Tipo'));
   NFSe.InfID.ID                := SomenteNumeros(NFSe.IdentificacaoRps.Numero) + NFSe.IdentificacaoRps.Serie;
  end;

 if (Leitor.rExtrai(3, 'Servico') <> '')
  then begin
   NFSe.Servico.ResponsavelRetencao := StrToResponsavelRetencao(ok, Leitor.rCampo(tcStr, 'ResponsavelRetencao'));
   NFSe.Servico.ItemListaServico    := DFeUtil.LimpaNumero(Leitor.rCampo(tcStr, 'ItemListaServico'));

   Item := StrToInt(SomenteNumeros(Nfse.Servico.ItemListaServico));
   if Item<100 then Item:=Item*100+1;

   NFSe.Servico.ItemListaServico := FormatFloat('0000', Item);
   NFSe.Servico.ItemListaServico := Copy(NFSe.Servico.ItemListaServico, 1, 2) + '.' +
                                    Copy(NFSe.Servico.ItemListaServico, 3, 2);

   NFSe.Servico.xItemListaServico := CodigoToDesc(SomenteNumeros(NFSe.Servico.ItemListaServico));

   NFSe.Servico.CodigoCnae          := Leitor.rCampo(tcStr, 'CodigoCnae');
   NFSe.Servico.Discriminacao       := Leitor.rCampo(tcStr, 'Discriminacao');
   NFSe.Servico.Descricao           := '';
   NFSe.Servico.CodigoMunicipio     := Leitor.rCampo(tcStr, 'CodigoMunicipio');
   NFSe.Servico.CodigoPais          := Leitor.rCampo(tcInt, 'CodigoPais');
   NFSe.Servico.ExigibilidadeISS    := StrToExigibilidadeISS(ok, Leitor.rCampo(tcStr, 'ExigibilidadeISS'));
   NFSe.Servico.MunicipioIncidencia := Leitor.rCampo(tcInt, 'MunicipioIncidencia');

   if (Leitor.rExtrai(4, 'Valores') <> '')
    then begin
     NFSe.Servico.Valores.ValorServicos          := Leitor.rCampo(tcDe2, 'ValorServicos');
     NFSe.Servico.Valores.ValorDeducoes          := Leitor.rCampo(tcDe2, 'ValorDeducoes');
     NFSe.Servico.Valores.ValorPis               := Leitor.rCampo(tcDe2, 'ValorPis');
     NFSe.Servico.Valores.ValorCofins            := Leitor.rCampo(tcDe2, 'ValorCofins');
     NFSe.Servico.Valores.ValorInss              := Leitor.rCampo(tcDe2, 'ValorInss');
     NFSe.Servico.Valores.ValorIr                := Leitor.rCampo(tcDe2, 'ValorIr');
     NFSe.Servico.Valores.ValorCsll              := Leitor.rCampo(tcDe2, 'ValorCsll');
     NFSe.Servico.Valores.OutrasRetencoes        := Leitor.rCampo(tcDe2, 'OutrasRetencoes');
     NFSe.Servico.Valores.IssRetido              := StrToSituacaoTributaria(ok, Leitor.rCampo(tcStr, 'IssRetido'));
     NFSe.Servico.Valores.ValorIss               := Leitor.rCampo(tcDe2, 'ValorIss');
     NFSe.Servico.Valores.BaseCalculo            := Leitor.rCampo(tcDe2, 'BaseCalculo');
     NFSe.Servico.Valores.Aliquota               := Leitor.rCampo(tcDe3, 'Aliquota');
     NFSe.Servico.Valores.ValorLiquidoNfse       := Leitor.rCampo(tcDe2, 'ValorLiquidoNfse');
     NFSe.Servico.Valores.ValorIssRetido         := Leitor.rCampo(tcDe2, 'ValorIssRetido');
     NFSe.Servico.Valores.DescontoCondicionado   := Leitor.rCampo(tcDe2, 'DescontoCondicionado');
     NFSe.Servico.Valores.DescontoIncondicionado := Leitor.rCampo(tcDe2, 'DescontoIncondicionado');
    end;

  end; // fim serviço

   if (Leitor.rExtrai(3, 'EnderecoPrestadorServico') <> '')then
    begin
      NFSe.PrestadorServico.Endereco.Endereco := Leitor.rCampo(tcStr, 'Endereco');
      if Copy(NFSe.PrestadorServico.Endereco.Endereco, 1, 10) = '<' + 'Endereco>' then
        NFSe.PrestadorServico.Endereco.Endereco := Copy(NFSe.PrestadorServico.Endereco.Endereco, 11, 125);

      NFSe.PrestadorServico.Endereco.Numero      := Leitor.rCampo(tcStr, 'Numero');
      NFSe.PrestadorServico.Endereco.Complemento := Leitor.rCampo(tcStr, 'Complemento');
      NFSe.PrestadorServico.Endereco.Bairro      := Leitor.rCampo(tcStr, 'Bairro');


      if VersaoXML='1' then
       begin
        NFSe.PrestadorServico.Endereco.CodigoMunicipio := Leitor.rCampo(tcStr, 'Cidade');
        NFSe.PrestadorServico.Endereco.UF              := Leitor.rCampo(tcStr, 'Estado');
       end
       else begin
        NFSe.PrestadorServico.Endereco.CodigoMunicipio := Leitor.rCampo(tcStr, 'CodigoMunicipio');
        NFSe.PrestadorServico.Endereco.UF              := Leitor.rCampo(tcStr, 'Uf');
       end;

       NFSe.PrestadorServico.Endereco.CodigoPais := Leitor.rCampo(tcInt, 'CodigoPais');
       NFSe.PrestadorServico.Endereco.CEP        := Leitor.rCampo(tcStr, 'Cep');
       if length(NFSe.PrestadorServico.Endereco.CodigoMunicipio)<7 then
       NFSe.PrestadorServico.Endereco.CodigoMunicipio := Copy(NFSe.PrestadorServico.Endereco.CodigoMunicipio, 1, 2) +
       FormatFloat('00000', StrToIntDef(Copy(NFSe.PrestadorServico.Endereco.CodigoMunicipio, 3, 5), 0));
            NFSe.PrestadorServico.Endereco.xMunicipio := CodCidadeToCidade(StrToIntDef(NFSe.PrestadorServico.Endereco.CodigoMunicipio, 0));
    end;

    if (Leitor.rExtrai(3, 'Prestador') <> '')then
     begin
      NFSe.PrestadorServico.IdentificacaoPrestador.InscricaoMunicipal := Leitor.rCampo(tcStr, 'InscricaoMunicipal');
      NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj := Leitor.rCampo(tcStr, 'Cnpj');
     end;

     if Leitor.rExtrai(3, 'Tomador') <> ''
      then begin
       NFSe.Tomador.RazaoSocial := Leitor.rCampo(tcStr, 'RazaoSocial');

       NFSe.Tomador.Endereco.Endereco := Leitor.rCampo(tcStr, 'Endereco');
       if Copy(NFSe.Tomador.Endereco.Endereco, 1, 10) = '<' + 'Endereco>'
        then NFSe.Tomador.Endereco.Endereco := Copy(NFSe.Tomador.Endereco.Endereco, 11, 125);

       NFSe.Tomador.Endereco.Numero      := Leitor.rCampo(tcStr, 'Numero');
       NFSe.Tomador.Endereco.Complemento := Leitor.rCampo(tcStr, 'Complemento');
       NFSe.Tomador.Endereco.Bairro      := Leitor.rCampo(tcStr, 'Bairro');

       if VersaoXML='1'
        then begin
         NFSe.Tomador.Endereco.CodigoMunicipio := Leitor.rCampo(tcStr, 'Cidade');
         NFSe.Tomador.Endereco.UF              := Leitor.rCampo(tcStr, 'Estado');
        end
        else begin
         NFSe.Tomador.Endereco.CodigoMunicipio := Leitor.rCampo(tcStr, 'CodigoMunicipio');
         NFSe.Tomador.Endereco.UF              := Leitor.rCampo(tcStr, 'Uf');
        end;

       NFSe.Tomador.Endereco.CEP := Leitor.rCampo(tcStr, 'Cep');

       if length(NFSe.Tomador.Endereco.CodigoMunicipio)<7
        then NFSe.Tomador.Endereco.CodigoMunicipio := Copy(NFSe.Tomador.Endereco.CodigoMunicipio, 1, 2) +
              FormatFloat('00000', StrToIntDef(Copy(NFSe.Tomador.Endereco.CodigoMunicipio, 3, 5), 0));

       if NFSe.Tomador.Endereco.UF = ''
        then NFSe.Tomador.Endereco.UF := NFSe.PrestadorServico.Endereco.UF;

       NFSe.Tomador.Endereco.xMunicipio := CodCidadeToCidade(StrToIntDef(NFSe.Tomador.Endereco.CodigoMunicipio, 0));

       if Leitor.rExtrai(4, 'Contato') <> ''
        then begin
         NFSe.Tomador.Contato.Telefone := Leitor.rCampo(tcStr, 'Telefone');
         NFSe.Tomador.Contato.Email    := Leitor.rCampo(tcStr, 'Email');
        end;

       if Leitor.rExtrai(4, 'IdentificacaoTomador') <> ''
        then begin
         NFSe.Tomador.IdentificacaoTomador.InscricaoMunicipal := Leitor.rCampo(tcStr, 'InscricaoMunicipal');
         if Leitor.rExtrai(5, 'CpfCnpj') <> ''
          then begin
           if Leitor.rCampo(tcStr, 'Cpf')<>''
            then NFSe.Tomador.IdentificacaoTomador.CpfCnpj := Leitor.rCampo(tcStr, 'Cpf')
            else NFSe.Tomador.IdentificacaoTomador.CpfCnpj := Leitor.rCampo(tcStr, 'Cnpj');
          end;
        end;
      end;

  if Leitor.rExtrai(3, 'Intermediario') <> ''
  then begin
   NFSe.IntermediarioServico.RazaoSocial        := Leitor.rCampo(tcStr, 'RazaoSocial');
   NFSe.IntermediarioServico.InscricaoMunicipal := Leitor.rCampo(tcStr, 'InscricaoMunicipal');
   if Leitor.rExtrai(4, 'CpfCnpj') <> ''
    then begin
     if Leitor.rCampo(tcStr, 'Cpf')<>''
      then NFSe.IntermediarioServico.CpfCnpj := Leitor.rCampo(tcStr, 'Cpf')
      else NFSe.IntermediarioServico.CpfCnpj := Leitor.rCampo(tcStr, 'Cnpj');
    end;
  end;

 if Leitor.rExtrai(3, 'OrgaoGerador') <> ''
  then begin
   NFSe.OrgaoGerador.CodigoMunicipio := Leitor.rCampo(tcStr, 'CodigoMunicipio');
   NFSe.OrgaoGerador.Uf              := Leitor.rCampo(tcStr, 'Uf');
  end; // fim OrgaoGerador

 if Leitor.rExtrai(3, 'ConstrucaoCivil') <> ''
  then begin
   NFSe.ConstrucaoCivil.CodigoObra := Leitor.rCampo(tcStr, 'CodigoObra');
   NFSe.ConstrucaoCivil.Art        := Leitor.rCampo(tcStr, 'Art');
  end;
*)
end;

procedure TNFSeR.NFSe_Demais;
var
 item: Integer;
 ok  : Boolean;
begin
 if (Leitor.rExtrai(3, 'IdentificacaoRps') <> '')
  then begin
   NFSe.IdentificacaoRps.Numero := Leitor.rCampo(tcStr, 'Numero');
   NFSe.IdentificacaoRps.Serie  := Leitor.rCampo(tcStr, 'Serie');
   NFSe.IdentificacaoRps.Tipo   := StrToTipoRPS(ok, Leitor.rCampo(tcStr, 'Tipo'));
   NFSe.InfID.ID                := SomenteNumeros(NFSe.IdentificacaoRps.Numero) + NFSe.IdentificacaoRps.Serie;
  end;

 if (Leitor.rExtrai(3, 'Servico') <> '')
  then begin
   NFSe.Servico.ResponsavelRetencao       := StrToResponsavelRetencao(ok, Leitor.rCampo(tcStr, 'ResponsavelRetencao'));
   NFSe.Servico.ItemListaServico          := DFeUtil.LimpaNumero(Leitor.rCampo(tcStr, 'ItemListaServico'));
   NFSe.Servico.CodigoTributacaoMunicipio := Leitor.rCampo(tcStr, 'CodigoTributacaoMunicipio');

   Item := StrToInt(SomenteNumeros(Nfse.Servico.ItemListaServico));
   if Item<100 then Item:=Item*100+1;

   NFSe.Servico.ItemListaServico := FormatFloat('0000', Item);
   NFSe.Servico.ItemListaServico := Copy(NFSe.Servico.ItemListaServico, 1, 2) + '.' +
                                    Copy(NFSe.Servico.ItemListaServico, 3, 2);

   NFSe.Servico.xItemListaServico := CodigoToDesc(SomenteNumeros(NFSe.Servico.ItemListaServico));

   NFSe.Servico.CodigoCnae          := Leitor.rCampo(tcStr, 'CodigoCnae');
   NFSe.Servico.Discriminacao       := Leitor.rCampo(tcStr, 'Discriminacao');
   NFSe.Servico.Descricao           := '';
   NFSe.Servico.CodigoMunicipio     := Leitor.rCampo(tcStr, 'CodigoMunicipio');
   NFSe.Servico.CodigoPais          := Leitor.rCampo(tcInt, 'CodigoPais');
   NFSe.Servico.ExigibilidadeISS    := StrToExigibilidadeISS(ok, Leitor.rCampo(tcStr, 'ExigibilidadeISS'));
   NFSe.Servico.MunicipioIncidencia := Leitor.rCampo(tcInt, 'MunicipioIncidencia');

   if (Leitor.rExtrai(4, 'Valores') <> '')
    then begin
     NFSe.Servico.Valores.ValorServicos          := Leitor.rCampo(tcDe2, 'ValorServicos');
     NFSe.Servico.Valores.ValorDeducoes          := Leitor.rCampo(tcDe2, 'ValorDeducoes');
     NFSe.Servico.Valores.ValorPis               := Leitor.rCampo(tcDe2, 'ValorPis');
     NFSe.Servico.Valores.ValorCofins            := Leitor.rCampo(tcDe2, 'ValorCofins');
     NFSe.Servico.Valores.ValorInss              := Leitor.rCampo(tcDe2, 'ValorInss');
     NFSe.Servico.Valores.ValorIr                := Leitor.rCampo(tcDe2, 'ValorIr');
     NFSe.Servico.Valores.ValorCsll              := Leitor.rCampo(tcDe2, 'ValorCsll');
     NFSe.Servico.Valores.OutrasRetencoes        := Leitor.rCampo(tcDe2, 'OutrasRetencoes');
     NFSe.Servico.Valores.IssRetido              := StrToSituacaoTributaria(ok, Leitor.rCampo(tcStr, 'IssRetido'));
     NFSe.Servico.Valores.ValorIss               := Leitor.rCampo(tcDe2, 'ValorIss');
     NFSe.Servico.Valores.BaseCalculo            := Leitor.rCampo(tcDe2, 'BaseCalculo');
     NFSe.Servico.Valores.Aliquota               := Leitor.rCampo(tcDe3, 'Aliquota');
     NFSe.Servico.Valores.ValorLiquidoNfse       := Leitor.rCampo(tcDe2, 'ValorLiquidoNfse');
     NFSe.Servico.Valores.ValorIssRetido         := Leitor.rCampo(tcDe2, 'ValorIssRetido');
     NFSe.Servico.Valores.DescontoCondicionado   := Leitor.rCampo(tcDe2, 'DescontoCondicionado');
     NFSe.Servico.Valores.DescontoIncondicionado := Leitor.rCampo(tcDe2, 'DescontoIncondicionado');
    end;

  end; // fim serviço

 if Leitor.rExtrai(3, 'PrestadorServico') <> ''
  then begin
   NFSe.PrestadorServico.RazaoSocial  := Leitor.rCampo(tcStr, 'RazaoSocial');
   NFSe.PrestadorServico.NomeFantasia := Leitor.rCampo(tcStr, 'NomeFantasia');

   NFSe.PrestadorServico.Endereco.Endereco := Leitor.rCampo(tcStr, 'Endereco');
   if Copy(NFSe.PrestadorServico.Endereco.Endereco, 1, 10) = '<' + 'Endereco>'
    then NFSe.PrestadorServico.Endereco.Endereco := Copy(NFSe.PrestadorServico.Endereco.Endereco, 11, 125);

   NFSe.PrestadorServico.Endereco.Numero      := Leitor.rCampo(tcStr, 'Numero');
   NFSe.PrestadorServico.Endereco.Complemento := Leitor.rCampo(tcStr, 'Complemento');
   NFSe.PrestadorServico.Endereco.Bairro      := Leitor.rCampo(tcStr, 'Bairro');

   if VersaoXML='1'
    then begin
     NFSe.PrestadorServico.Endereco.CodigoMunicipio := Leitor.rCampo(tcStr, 'Cidade');
     NFSe.PrestadorServico.Endereco.UF              := Leitor.rCampo(tcStr, 'Estado');
    end
    else begin
     NFSe.PrestadorServico.Endereco.CodigoMunicipio := Leitor.rCampo(tcStr, 'CodigoMunicipio');
     NFSe.PrestadorServico.Endereco.UF              := Leitor.rCampo(tcStr, 'Uf');
    end;

   NFSe.PrestadorServico.Endereco.CodigoPais := Leitor.rCampo(tcInt, 'CodigoPais');
   NFSe.PrestadorServico.Endereco.CEP        := Leitor.rCampo(tcStr, 'Cep');

   if length(NFSe.PrestadorServico.Endereco.CodigoMunicipio)<7
    then NFSe.PrestadorServico.Endereco.CodigoMunicipio := Copy(NFSe.PrestadorServico.Endereco.CodigoMunicipio, 1, 2) +
           FormatFloat('00000', StrToIntDef(Copy(NFSe.PrestadorServico.Endereco.CodigoMunicipio, 3, 5), 0));

   NFSe.PrestadorServico.Endereco.xMunicipio := CodCidadeToCidade(StrToIntDef(NFSe.PrestadorServico.Endereco.CodigoMunicipio, 0));

   if (Leitor.rExtrai(4, 'IdentificacaoPrestador') <> '')
    then begin
     NFSe.PrestadorServico.IdentificacaoPrestador.InscricaoMunicipal := Leitor.rCampo(tcStr, 'InscricaoMunicipal');

     if VersaoXML='1'
      then begin
       if Leitor.rExtrai(5, 'CpfCnpj') <> ''
        then begin
          NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj := Leitor.rCampo(tcStr, 'Cpf');
          if NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj = ''
           then NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj := Leitor.rCampo(tcStr, 'Cnpj');
        end;
      end
      else begin
       NFSe.PrestadorServico.IdentificacaoPrestador.Cnpj := Leitor.rCampo(tcStr, 'Cnpj');
      end;
    end;

   if Leitor.rExtrai(4, 'Contato') <> ''
    then begin
     NFSe.PrestadorServico.Contato.Telefone := Leitor.rCampo(tcStr, 'Telefone');
     NFSe.PrestadorServico.Contato.Email    := Leitor.rCampo(tcStr, 'Email');
    end;

  end; // fim PrestadorServico

 if Leitor.rExtrai(3, 'TomadorServico') <> ''
  then begin
   NFSe.Tomador.RazaoSocial := Leitor.rCampo(tcStr, 'RazaoSocial');

   NFSe.Tomador.Endereco.Endereco := Leitor.rCampo(tcStr, 'Endereco');
   if Copy(NFSe.Tomador.Endereco.Endereco, 1, 10) = '<' + 'Endereco>'
    then NFSe.Tomador.Endereco.Endereco := Copy(NFSe.Tomador.Endereco.Endereco, 11, 125);

   NFSe.Tomador.Endereco.Numero      := Leitor.rCampo(tcStr, 'Numero');
   NFSe.Tomador.Endereco.Complemento := Leitor.rCampo(tcStr, 'Complemento');
   NFSe.Tomador.Endereco.Bairro      := Leitor.rCampo(tcStr, 'Bairro');

   if VersaoXML='1'
    then begin
     NFSe.Tomador.Endereco.CodigoMunicipio := Leitor.rCampo(tcStr, 'Cidade');
     NFSe.Tomador.Endereco.UF              := Leitor.rCampo(tcStr, 'Estado');
    end
    else begin
     NFSe.Tomador.Endereco.CodigoMunicipio := Leitor.rCampo(tcStr, 'CodigoMunicipio');
     NFSe.Tomador.Endereco.UF              := Leitor.rCampo(tcStr, 'Uf');
    end;

   NFSe.Tomador.Endereco.CEP := Leitor.rCampo(tcStr, 'Cep');

   if length(NFSe.Tomador.Endereco.CodigoMunicipio)<7
    then NFSe.Tomador.Endereco.CodigoMunicipio := Copy(NFSe.Tomador.Endereco.CodigoMunicipio, 1, 2) +
          FormatFloat('00000', StrToIntDef(Copy(NFSe.Tomador.Endereco.CodigoMunicipio, 3, 5), 0));

   if NFSe.Tomador.Endereco.UF = ''
    then NFSe.Tomador.Endereco.UF := NFSe.PrestadorServico.Endereco.UF;

   NFSe.Tomador.Endereco.xMunicipio := CodCidadeToCidade(StrToIntDef(NFSe.Tomador.Endereco.CodigoMunicipio, 0));

   if Leitor.rExtrai(4, 'Contato') <> ''
    then begin
     NFSe.Tomador.Contato.Telefone := Leitor.rCampo(tcStr, 'Telefone');
     NFSe.Tomador.Contato.Email    := Leitor.rCampo(tcStr, 'Email');
    end;

   if Leitor.rExtrai(4, 'IdentificacaoTomador') <> ''
    then begin
     NFSe.Tomador.IdentificacaoTomador.InscricaoMunicipal := Leitor.rCampo(tcStr, 'InscricaoMunicipal');
     if Leitor.rExtrai(5, 'CpfCnpj') <> ''
      then begin
       if Leitor.rCampo(tcStr, 'Cpf')<>''
        then NFSe.Tomador.IdentificacaoTomador.CpfCnpj := Leitor.rCampo(tcStr, 'Cpf')
        else NFSe.Tomador.IdentificacaoTomador.CpfCnpj := Leitor.rCampo(tcStr, 'Cnpj');
      end;
    end;
  end;

 if Leitor.rExtrai(3, 'IntermediarioServico') <> ''
  then begin
   NFSe.IntermediarioServico.RazaoSocial        := Leitor.rCampo(tcStr, 'RazaoSocial');
   NFSe.IntermediarioServico.InscricaoMunicipal := Leitor.rCampo(tcStr, 'InscricaoMunicipal');
   if Leitor.rExtrai(4, 'CpfCnpj') <> ''
    then begin
     if Leitor.rCampo(tcStr, 'Cpf')<>''
      then NFSe.IntermediarioServico.CpfCnpj := Leitor.rCampo(tcStr, 'Cpf')
      else NFSe.IntermediarioServico.CpfCnpj := Leitor.rCampo(tcStr, 'Cnpj');
    end;
  end;

 if Leitor.rExtrai(3, 'OrgaoGerador') <> ''
  then begin
   NFSe.OrgaoGerador.CodigoMunicipio := Leitor.rCampo(tcStr, 'CodigoMunicipio');
   NFSe.OrgaoGerador.Uf              := Leitor.rCampo(tcStr, 'Uf');
  end; // fim OrgaoGerador

 if Leitor.rExtrai(3, 'ConstrucaoCivil') <> ''
  then begin
   NFSe.ConstrucaoCivil.CodigoObra := Leitor.rCampo(tcStr, 'CodigoObra');
   NFSe.ConstrucaoCivil.Art        := Leitor.rCampo(tcStr, 'Art');
  end;

end;

function TNFSeR.LerNFSe: Boolean;
var
 ok  : Boolean;
 CM: String;
begin
 FProvedor := proNenhum;

	// Alterado por - Cleiver
 	if Pos('<DeclaracaoPrestacaoServico', Leitor.Arquivo) > 0 then
	begin
	 	if Pos('https://nfse.goiania.go.gov.br', Leitor.Arquivo) > 0 then
			FProvedor := proGoiania
    else
			FProvedor := proSaatri;
   if (Leitor.rExtrai(1, 'DeclaracaoPrestacaoServico') <> '')
   then begin
    CM:= Leitor.rCampo(tcStr, 'CodigoMunicipio');
    if (CM = '5101803')
     then
      FProvedor := proVirtual;
   end;
  end;

 if (Leitor.rExtrai(1, 'OrgaoGerador') <> '')
  then begin
   CM:= Leitor.rCampo(tcStr, 'CodigoMunicipio');

   if (CM = '4119905') then
    FProvedor := profintelISS;

   if (CM = '3127701') or (CM = '3500105') or (CM = '3510203') or
      (CM = '3523503') or (CM = '3554003') then
     FProvedor := pro4R;

   if (CM = '4115200') then
     Fprovedor := proISSe;

   if (CM = '3301702') or (CM = '3501608') or (CM = '3300100') or
      (CM = '3300407') or (CM = '3302007') or (CM = '3302403') or
      (CM = '3302601') or (CM = '2611606') or (CM = '3304201') or
      (CM = '3304524') then
     FProvedor := proTiplan;

   if(CM = '3503307') or (CM = '3538709') or (CM = '3541406') then
      FProvedor := proSimplISS;

   if (CM = '5213103') or (CM = '5218805') then
    FProvedor := proProdata;

   if (CM = '2919553') then
    FProvedor := proWebISS;

   if (CM = '3205309') then
    FProvedor := proVitoria;
  end;

 if (Leitor.rExtrai(1, 'Nfse') <> '') or (Pos('Nfse versao="2.01"', Leitor.Arquivo) > 0) then // alterado por Joel Takei 24/06/2013
 begin
   if (Leitor.rExtrai(2, 'InfNfse') <> '') or (Leitor.rExtrai(1, 'InfNfse') <> '') // alterado por Joel Takei 24/06/2013
    then begin
     NFSe.Numero                   := Leitor.rCampo(tcStr, 'Numero');
     NFSe.CodigoVerificacao        := Leitor.rCampo(tcStr, 'CodigoVerificacao');
     if FProvedor in [proFreire, proVitoria]
      then NFSe.DataEmissao              := Leitor.rCampo(tcDat, 'DataEmissao')
      else NFSe.DataEmissao              := Leitor.rCampo(tcDatHor, 'DataEmissao');
     // Alterado por Leonardo Gregianin 11/01/2014: Tratar erro de conversão de tipo no Provedor Ábaco
	 if Leitor.rCampo(tcStr, 'DataEmissaoRps') <> '0000-00-00' then
	    NFSe.DataEmissaoRps           := Leitor.rCampo(tcDat, 'DataEmissaoRps');

     if FProvedor = proISSNet
      then FNFSe.NfseSubstituida := ''
      else begin
       NFSe.NfseSubstituida := Leitor.rCampo(tcStr, 'NfseSubstituida');
       if NFSe.NfseSubstituida = ''
        then NFSe.NfseSubstituida := Leitor.rCampo(tcStr, 'NfseSubstituta');
      end;
      
     NFSe.OutrasInformacoes        := Leitor.rCampo(tcStr, 'OutrasInformacoes');
     NFSe.ValorCredito             := Leitor.rCampo(tcDe2, 'ValorCredito');
     NFSe.NaturezaOperacao         := StrToNaturezaOperacao(ok, Leitor.rCampo(tcStr, 'NaturezaOperacao'));
     NFSe.RegimeEspecialTributacao := StrToRegimeEspecialTributacao(ok, Leitor.rCampo(tcStr, 'RegimeEspecialTributacao'));
     NFSe.OptanteSimplesNacional   := StrToSimNao(ok, Leitor.rCampo(tcStr, 'OptanteSimplesNacional'));
     NFSe.IncentivadorCultural     := StrToSimNao(ok, Leitor.rCampo(tcStr, 'IncentivadorCultural'));
     NFSe.Competencia              := Leitor.rCampo(tcStr, 'Competencia');

     case FProvedor of
      proSaatri:    NFSe_ProvedorSaatri;

      profintelISS: NFSe_ProvedorfintelISS;

      proGoiania,
      proProdata,
      proVitoria:   NFSe_ProvedorGoiania;

      pro4R:        NFSe_Provedor4R;

      proISSe:      NFSe_ProvedorISSe; // alterado por Joel Takei 24/06/2013

      proTiplan:    NFSe_ProvedorTiplan;

      proSimplISS:  NFSe_ProvedorSimplISS;
      
      proVirtual:   NFSe_ProvedorVirtual;

      proISSDigital: NFSe_ProvedorISSDigital;

      else          NFSe_Demais;
     end;

    end; // fim do infNfse

  end; // fim da Nfse

 //provedorIssDSF
 if Pos('<Notas>', Leitor.Arquivo) > 0 then begin
    NFSe_ProvedorIssDsf;
 end;

 if Leitor.rExtrai(1, 'NfseCancelamento') <> ''
  then begin
   NFSe.NfseCancelamento.DataHora := Leitor.rCampo(tcDatHor, 'DataHora');
   // Incluido por joel takei 12/08/2013
   NFSe.NfseCancelamento.Pedido.CodigoCancelamento := Leitor.rCampo(tcStr, 'CodigoCancelamento');
   if NFSe.NfseCancelamento.DataHora = 0
    then NFSe.NfseCancelamento.DataHora := Leitor.rCampo(tcDatHor, 'DataHoraCancelamento');
  end;

 Result := True;
end;

function TNFSeR.LerXml: boolean;
begin
 Result := False;

 if Pos('<Nfse', Leitor.Arquivo) > 0
  then Result := LerNFSe;

 if (Pos('<Rps', Leitor.Arquivo) > 0) or (Pos('<rps', Leitor.Arquivo) > 0)
  then Result := LerRPS;

 if Pos('<Notas>', Leitor.Arquivo) > 0
  then Result := LerNFSe;

 // Grupo da TAG <signature> ***************************************************
 Leitor.Grupo := Leitor.Arquivo;

 NFSe.signature.URI             := Leitor.rAtributo('Reference URI=');
 NFSe.signature.DigestValue     := Leitor.rCampo(tcStr, 'DigestValue');
 NFSe.signature.SignatureValue  := Leitor.rCampo(tcStr, 'SignatureValue');
 NFSe.signature.X509Certificate := Leitor.rCampo(tcStr, 'X509Certificate');

end;

procedure TNFSeR.Rps_ProvedorEquiplano;
var
  ok: Boolean;
  Item: Integer;
begin
  NFSe.IdentificacaoRps.Numero:= Leitor.rCampo(tcStr, 'nrRps');
  NFSe.IdentificacaoRps.Serie := Leitor.rCampo(tcStr, 'nrEmissorRps');
  NFSe.DataEmissao            := Leitor.rCampo(tcDatHor, 'dtEmissaoRps');
  NFSe.DataEmissaoRps         := Leitor.rCampo(tcDat, 'DataEmissao');
  NFSe.NaturezaOperacao       := StrToNaturezaOperacao(ok, Leitor.rCampo(tcStr, 'NaturezaOperacao'));

  NFSe.Servico.Valores.IssRetido       := StrToSituacaoTributaria(ok, Leitor.rCampo(tcStr, 'isIssRetido'));
  NFSe.Servico.Valores.ValorLiquidoNfse:= Leitor.rCampo(tcDe2, 'vlLiquidoRps');

  if (Leitor.rExtrai(2, 'tomador') <> '') then
    begin
      NFSe.Tomador.IdentificacaoTomador.CpfCnpj              := Leitor.rCampo(tcStr, 'nrDocumento');
      NFSe.Tomador.IdentificacaoTomador.DocTomadorEstrangeiro:= Leitor.rCampo(tcStr, 'dsDocumentoEstrangeiro');
      NFSe.Tomador.IdentificacaoTomador.InscricaoEstadual    := Leitor.rCampo(tcStr, 'nrInscricaoEstadual');
      NFSe.Tomador.RazaoSocial                               := Leitor.rCampo(tcStr, 'nmTomador');
      NFSe.Tomador.Contato.Email                             := Leitor.rCampo(tcStr, 'dsEmail');
      NFSe.Tomador.Endereco.Endereco                         := Leitor.rCampo(tcStr, 'dsEndereco');
      NFSe.Tomador.Endereco.Numero                           := Leitor.rCampo(tcStr, 'nrEndereco');
      NFSe.Tomador.Endereco.Complemento                      := Leitor.rCampo(tcStr, 'dsComplemento');
      NFSe.Tomador.Endereco.Bairro                           := Leitor.rCampo(tcStr, 'nmBairro');
      NFSe.Tomador.Endereco.CodigoMunicipio                  := Leitor.rCampo(tcStr, 'nrCidadeIbge');
      NFSe.Tomador.Endereco.UF                               := Leitor.rCampo(tcStr, 'nmUf');
      NFSe.Tomador.Endereco.xPais                            := Leitor.rCampo(tcStr, 'nmPais');
      NFSe.Tomador.Endereco.CEP                              := Leitor.rCampo(tcStr, 'nrCep');
      NFSe.Tomador.Contato.Telefone                          := Leitor.rCampo(tcStr, 'nrTelefone');
    end;

  if (Leitor.rExtrai(2, 'listaServicos') <> '') then
    begin
      NFSe.Servico.ItemListaServico            := Poem_Zeros( Leitor.rCampo(tcStr, 'nrServicoItem'), 2) +
                                                  Poem_Zeros( Leitor.rCampo(tcStr, 'nrServicoSubItem'), 2);

      Item := StrToInt(SomenteNumeros(Nfse.Servico.ItemListaServico));
      if Item<100 then Item:=Item*100+1;

      NFSe.Servico.ItemListaServico := FormatFloat('0000', Item);
      NFSe.Servico.ItemListaServico := Copy(NFSe.Servico.ItemListaServico, 1, 2) + '.' +
                                       Copy(NFSe.Servico.ItemListaServico, 3, 2);

      NFSe.Servico.xItemListaServico := CodigoToDesc(SomenteNumeros(NFSe.Servico.ItemListaServico));

      NFSe.Servico.Valores.ValorServicos       := Leitor.rCampo(tcDe2, 'vlServico');
      NFSe.Servico.Valores.Aliquota            := Leitor.rCampo(tcDe2, 'vlAliquota');
      NFSe.Servico.Valores.ValorDeducoes       := Leitor.rCampo(tcDe2, 'vlDeducao');
      NFSe.Servico.Valores.JustificativaDeducao:= Leitor.rCampo(tcStr, 'dsJustificativaDeducao');
      NFSe.Servico.Valores.BaseCalculo         := Leitor.rCampo(tcDe2, 'vlBaseCalculo');
      NFSe.Servico.Valores.ValorIss            := Leitor.rCampo(tcDe2, 'vlIssServico');
      NFSe.Servico.Discriminacao               := Leitor.rCampo(tcStr, 'dsDiscriminacaoServico');
    end;

  if (Leitor.rExtrai(2, 'retencoes') <> '') then
    begin
      NFSe.Servico.Valores.ValorCofins            := Leitor.rCampo(tcDe2, 'vlCofins');
      NFSe.Servico.Valores.ValorCsll              := Leitor.rCampo(tcDe2, 'vlCsll');
      NFSe.Servico.Valores.ValorInss              := Leitor.rCampo(tcDe2, 'vlInss');
      NFSe.Servico.Valores.ValorIr                := Leitor.rCampo(tcDe2, 'vlIrrf');
      NFSe.Servico.Valores.ValorPis               := Leitor.rCampo(tcDe2, 'vlPis');
      NFSe.Servico.Valores.ValorIssRetido         := Leitor.rCampo(tcDe2, 'vlIss'); 
      NFSe.Servico.Valores.AliquotaCofins         := Leitor.rCampo(tcDe2, 'vlAliquotaCofins');
      NFSe.Servico.Valores.AliquotaCsll           := Leitor.rCampo(tcDe2, 'vlAliquotaCsll');
      NFSe.Servico.Valores.AliquotaInss           := Leitor.rCampo(tcDe2, 'vlAliquotaInss');
      NFSe.Servico.Valores.AliquotaIr             := Leitor.rCampo(tcDe2, 'vlAliquotaIrrf');
      NFSe.Servico.Valores.AliquotaPis            := Leitor.rCampo(tcDe2, 'vlAliquotaPis');
    end;
end;

end.
