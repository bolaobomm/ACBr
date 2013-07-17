////////////////////////////////////////////////////////////////////////////////
//                                                                            //
//              PCN - Projeto Cooperar NFe                                    //
//                                                                            //
//   Descrição: Classes para geração/leitura dos arquivos xml da NFe          //
//                                                                            //
//        site: www.projetocooperar.org/nfe                                   //
//       email: projetocooperar@zipmail.com.br                                //
//       forum: http://br.groups.yahoo.com/group/projeto_cooperar_nfe/        //
//     projeto: http://code.google.com/p/projetocooperar/                     //
//         svn: http://projetocooperar.googlecode.com/svn/trunk/              //
//                                                                            //
// Coordenação: (c) 2009 - Paulo Casagrande                                   //
//                                                                            //
//      Equipe: Vide o arquivo leiame.txt na pasta raiz do projeto            //
//                                                                            //
//      Versão: Vide o arquivo leiame.txt na pasta raiz do projeto            //
//                                                                            //
// Desenvolvimento                                                            //
//         de CTe: Wiliam Zacarias da Silva Rosa                              //
//                                                                            //
//     Licença: GNU Lesser General Public License (GNU LGPL)                  //
//                                                                            //
//              - Este programa é software livre; você pode redistribuí-lo    //
//              e/ou modificá-lo sob os termos da Licença Pública Geral GNU,  //
//              conforme publicada pela Free Software Foundation; tanto a     //
//              versão 2 da Licença como (a seu critério) qualquer versão     //
//              mais nova.                                                    //
//                                                                            //
//              - Este programa é distribuído na expectativa de ser útil,     //
//              mas SEM QUALQUER GARANTIA; sem mesmo a garantia implícita de  //
//              COMERCIALIZAÇÃO ou de ADEQUAÇÃO A QUALQUER PROPÓSITO EM       //
//              PARTICULAR. Consulte a Licença Pública Geral GNU para obter   //
//              mais detalhes. Você deve ter recebido uma cópia da Licença    //
//              Pública Geral GNU junto com este programa; se não, escreva    //
//              para a Free Software Foundation, Inc., 59 Temple Place,       //
//              Suite 330, Boston, MA - 02111-1307, USA ou consulte a         //
//              licença oficial em http://www.gnu.org/licenses/gpl.txt        //
//                                                                            //
//    Nota (1): - Esta  licença  não  concede  o  direito  de  uso  do nome   //
//              "PCN  -  Projeto  Cooperar  NFe", não  podendo o mesmo ser    //
//              utilizado sem previa autorização.                             //
//                                                                            //
//    Nota (2): - O uso integral (ou parcial) das units do projeto esta       //
//              condicionado a manutenção deste cabeçalho junto ao código     //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

{$I ACBr.inc}

unit pcteCTeW;

interface

uses
  SysUtils, Classes, pcnAuxiliar, pcnConversao, pcnGerador, pcteCTe;

{$IFDEF PL_103}
 {$I pcteCTeW_V103.inc}
{$ENDIF}

{$IFDEF PL_104}
 {$I pcteCTeW_V104.inc}
{$ENDIF}

{$IFDEF PL_200}
// {$I pcteCTeW_V200.inc}
////////////////////////////////////////////////////////////////////////////////
//                                                                            //
//              Gera o XML para a versão 2.00                                 //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

type

  TGeradorOpcoes = class;

  TCTeW = class(TPersistent)
  private
    FGerador: TGerador;
    FCTe: TCTe;
    FOpcoes: TGeradorOpcoes;

    procedure GerarInfCTe;     // Nivel 0

    procedure GerarIde;        // Nivel 1
    procedure GerarToma03;     // Nivel 2
    procedure GerarToma4;      // Nivel 2
    procedure GerarEnderToma;  // Nivel 3

    procedure GerarCompl;      // Nivel 1
    procedure GerarFluxo;      // Nivel 2
    procedure GerarEntrega;    // Nivel 2
    procedure GerarObsCont;    // Nivel 2
    procedure GerarObsFisco;   // Nivel 2

    procedure GerarEmit;       // Nivel 1
    procedure GerarEnderEmit;  // Nivel 2

    procedure GerarRem;        // Nivel 1
    procedure GerarEnderReme;  // Nivel 2
    procedure GerarLocColeta;  // Nivel 2

    procedure GerarExped;      // Nivel 1
    procedure GerarEnderExped; // Nivel 2

    procedure GerarReceb;      // Nivel 1
    procedure GerarEnderReceb; // Nivel 2

    procedure GerarDest;       // Nivel 1
    procedure GerarEnderDest;  // Nivel 2
    procedure GerarLocEnt;     // Nivel 2

    procedure GerarVPrest;     // Nivel 1
    procedure GerarComp;       // Nivel 2

    procedure GerarImp;        // Nivel 1
    procedure GerarICMS;       // Nivel 2
    procedure GerarCST00;      // Nivel 3
    procedure GerarCST20;      // Nivel 3
    procedure GerarCST45;      // Nivel 3
    procedure GerarCST60;      // Nivel 3
    procedure GerarCST90;      // Nivel 3
    procedure GerarICMSOutraUF;// Nivel 3
    procedure GerarICMSSN;     // Nivel 3

    procedure GerarInfCTeNorm; // Nivel 1
    procedure GerarinfCarga;   // Nivel 2
    procedure GerarInfQ;       // Nivel 3
    procedure GerarinfDoc;     // Nivel 2
    procedure GerarInfNF;      // Nivel 3
    procedure GerarInfNFe;     // Nivel 3
    procedure GerarInfOutros;  // Nivel 3

    procedure GerarDocAnt;     // Nivel 2
    procedure GerarInfSeg;     // Nivel 2

    procedure GerarRodo;       // Nivel 2
    procedure GerarOCC;        // Nivel 3
    procedure GerarValePed;    // Nivel 3
    procedure GerarVeic;       // Nivel 3
    procedure GerarLacre;      // Nivel 3
    procedure GerarMoto;       // Nivel 3

    procedure GerarAereo;      // Nivel 2

    procedure GerarAquav;      // Nivel 2

    procedure GerarFerrov;     // Nivel 2
    procedure GerarFerroEnv;   // Nivel 3
    procedure GerardetVag;     // Nivel 3

    procedure GerarDuto;       // Nivel 2

    procedure GerarMultimodal; // Nivel 2

    procedure GerarPeri;       // Nivel 2
    procedure GerarVeicNovos;  // Nivel 2
    procedure GerarCobr;       // Nivel 2
    procedure GerarCobrFat;
    procedure GerarCobrDup;
    procedure GerarInfCTeSub;  // Nivel 2

    procedure GerarInfCTeComp;      // Nivel 1
    procedure GerarImpComp;         // Nivel 2
    procedure GerarICMSComp;        // Nivel 3
    procedure GerarCST00Comp;       // Nivel 4
    procedure GerarCST20Comp;       // Nivel 4
    procedure GerarCST45Comp;       // Nivel 4
    procedure GerarCST60Comp;       // Nivel 4
    procedure GerarCST90Comp;       // Nivel 4
    procedure GerarICMSOutraUFComp; // Nivel 4
    procedure GerarICMSSNComp;      // Nivel 4

    procedure GerarInfCTeAnu; // Nivel 1
    procedure GerarautXML;    // Nivel 1

    procedure AjustarMunicipioUF(var xUF: string; var xMun: string; var cMun: integer; cPais: integer; vxUF, vxMun: string; vcMun: integer);
    function ObterNomeMunicipio(const xMun, xUF: string; const cMun: integer): string;
  public
    constructor Create(AOwner: TCTe);
    destructor Destroy; override;
    function GerarXml: boolean;
    function ObterNomeArquivo: string;
  published
    property Gerador: TGerador read FGerador write FGerador;
    property CTe: TCTe read FCTe write FCTe;
    property Opcoes: TGeradorOpcoes read FOpcoes write FOpcoes;
  end;

  TGeradorOpcoes = class(TPersistent)
  private
    FAjustarTagNro: boolean;
    FNormatizarMunicipios: boolean;
    FGerarTagAssinatura: TpcnTagAssinatura;
    FPathArquivoMunicipios: string;
    FValidarInscricoes: boolean;
    FValidarListaServicos: boolean;
  published
    property AjustarTagNro: boolean read FAjustarTagNro write FAjustarTagNro;
    property NormatizarMunicipios: boolean read FNormatizarMunicipios write FNormatizarMunicipios;
    property GerarTagAssinatura: TpcnTagAssinatura read FGerarTagAssinatura write FGerarTagAssinatura;
    property PathArquivoMunicipios: string read FPathArquivoMunicipios write FPathArquivoMunicipios;
    property ValidarInscricoes: boolean read FValidarInscricoes write FValidarInscricoes;
    property ValidarListaServicos: boolean read FValidarListaServicos write FValidarListaServicos;
  end;

  ////////////////////////////////////////////////////////////////////////////////

implementation

// Regra a ser aplicada em ambiente de homologação a partir de 01/09/2012
const
 xRazao = 'CT-E EMITIDO EM AMBIENTE DE HOMOLOGACAO - SEM VALOR FISCAL';

{ TCTeW }

constructor TCTeW.Create(AOwner: TCTe);
begin
  FCTe := AOwner;
  FGerador := TGerador.Create;
  FGerador.FIgnorarTagNivel := '|?xml version|CTe xmlns|infCTe versao|obsCont|obsFisco|';
  FOpcoes := TGeradorOpcoes.Create;
  FOpcoes.FAjustarTagNro := True;
  FOpcoes.FNormatizarMunicipios := False;
  FOpcoes.FGerarTagAssinatura := taSomenteSeAssinada;
  FOpcoes.FValidarInscricoes := False;
  FOpcoes.FValidarListaServicos := False;
end;

destructor TCTeW.Destroy;
begin
  FGerador.Free;
  FOpcoes.Free;
  inherited Destroy;
end;

////////////////////////////////////////////////////////////////////////////////

function TCTeW.ObterNomeArquivo: string;
begin
  Result := SomenteNumeros(CTe.infCTe.ID) + '-cte.xml';
end;

function TCTeW.GerarXml: boolean;
var
  chave: AnsiString;
  Gerar: boolean;
  xProtCTe : String;
begin
  chave := '';

  if not GerarChave(Chave, CTe.ide.cUF, CTe.ide.cCT, StrToInt(CTe.ide.modelo), CTe.ide.serie,
    CTe.ide.nCT, StrToInt(TpEmisToStr(CTe.ide.tpEmis)), CTe.ide.dhEmi, CTe.emit.CNPJ) then
    Gerador.wAlerta('#001', 'infCte', DSC_CHAVE, ERR_MSG_GERAR_CHAVE);

  chave := StringReplace(chave,'NFe','CTe',[rfReplaceAll]);
  CTe.infCTe.ID := chave;
  CTe.ide.cDV := RetornarDigito(CTe.infCTe.ID);
  CTe.Ide.cCT := RetornarCodigoNumerico(CTe.infCTe.ID, 2);

  // Carrega Layout que sera utilizado para gera o txt
  Gerador.LayoutArquivoTXT.Clear;
  Gerador.ArquivoFormatoXML := '';
  Gerador.ArquivoFormatoTXT := '';

  Gerador.wGrupo(ENCODING_UTF8, '', False);

  if CTe.procCTe.nProt <> ''
   then Gerador.wGrupo('cteProc versao="' + CTeenviCTe + '" ' + NAME_SPACE_CTE, '');
  Gerador.wGrupo('CTe ' + NAME_SPACE_CTE);
  Gerador.wGrupo('infCte versao="' + CTeenviCTe + '" Id="' + CTe.infCTe.ID + '"');

  (**)GerarInfCTe;
  Gerador.wGrupo('/infCte');
  //
  if FOpcoes.GerarTagAssinatura <> taNunca then
  begin
    Gerar := true;
    if FOpcoes.GerarTagAssinatura = taSomenteSeAssinada then
      Gerar := ((CTe.signature.DigestValue <> '') and (CTe.signature.SignatureValue <> '') and (CTe.signature.X509Certificate <> ''));
    if FOpcoes.GerarTagAssinatura = taSomenteParaNaoAssinada then
      Gerar := ((CTe.signature.DigestValue = '') and (CTe.signature.SignatureValue = '') and (CTe.signature.X509Certificate = ''));
    if Gerar then
    begin
      FCTe.signature.URI := somenteNumeros(CTe.infCTe.ID);
      FCTe.signature.Gerador.Opcoes.IdentarXML := Gerador.Opcoes.IdentarXML;
      FCTe.signature.GerarXMLCTe;
      Gerador.ArquivoFormatoXML := Gerador.ArquivoFormatoXML + FCTe.signature.Gerador.ArquivoFormatoXML;
    end;
  end;
  Gerador.wGrupo('/CTe');

  if CTe.procCTe.nProt <> '' then
   begin
     xProtCTe :=
           '<protCTe versao="' + CTeenviCTe + '">' +
             '<infProt>'+
               '<tpAmb>'+TpAmbToStr(CTe.procCTe.tpAmb)+'</tpAmb>'+
               '<verAplic>'+CTe.procCTe.verAplic+'</verAplic>'+
               '<chCTe>'+CTe.procCTe.chCTe+'</chCTe>'+
               '<dhRecbto>'+FormatDateTime('yyyy-mm-dd"T"hh:nn:ss',CTe.procCTe.dhRecbto)+'</dhRecbto>'+
               '<nProt>'+CTe.procCTe.nProt+'</nProt>'+
               '<digVal>'+CTe.procCTe.digVal+'</digVal>'+
               '<cStat>'+IntToStr(CTe.procCTe.cStat)+'</cStat>'+
               '<xMotivo>'+CTe.procCTe.xMotivo+'</xMotivo>'+
             '</infProt>'+
           '</protCTe>';

     Gerador.wTexto(xProtCTe);
     Gerador.wGrupo('/cteProc');
   end;

  Gerador.gtAjustarRegistros(CTe.infCTe.ID);
  Result := (Gerador.ListaDeAlertas.Count = 0);
end;

procedure TCTeW.GerarInfCTe;
begin
  GerarIde;
  GerarCompl;
  GerarEmit;
  GerarRem;
  GerarExped;
  GerarReceb;
  GerarDest;
  GerarvPrest;
  GerarImp;

  GerarInfCTeNorm; // Gerado somente se Tipo de CTe = tcNormal
  GerarinfCTeComp; // Gerado somente se Tipo de CTe = tcComplemento
  GerarInfCTeAnu;  // Gerado somente se Tipo de CTe = tcAnulacao
end;

procedure TCTeW.GerarIde;
begin
  Gerador.wGrupo('ide', '#004');
  Gerador.wCampo(tcInt, '#005', 'cUF     ', 02, 02, 1, CTe.ide.cUF, DSC_CUF);
  if not ValidarCodigoUF(CTe.ide.cUF) then
    Gerador.wAlerta('#005', 'cUF', DSC_CUF, ERR_MSG_INVALIDO);

  Gerador.wCampo(tcStr, '#006', 'cCT     ', 08, 08, 1, IntToStrZero(RetornarCodigoNumerico(CTe.infCTe.ID, 2), 8), DSC_CNF);
  Gerador.wCampo(tcInt, '#007', 'CFOP    ', 04, 04, 1, CTe.ide.CFOP, DSC_CFOP);
  Gerador.wCampo(tcStr, '#008', 'natOp   ', 01, 60, 1, CTe.ide.natOp, DSC_NATOP);
  Gerador.wCampo(tcStr, '#009', 'forPag  ', 01, 01, 1, tpforPagToStr(CTe.ide.forPag), DSC_INDPAG);
  Gerador.wCampo(tcInt, '#010', 'mod     ', 02, 02, 1, CTe.ide.modelo, DSC_MOD);
  Gerador.wCampo(tcInt, '#011', 'serie   ', 01, 03, 1, CTe.ide.serie, DSC_SERIE);
  Gerador.wCampo(tcInt, '#012', 'nCT     ', 01, 09, 1, CTe.ide.nCT, DSC_NNF);
  Gerador.wCampo(tcDatHor, '#013', 'dhEmi', 19, 19, 1, CTe.ide.dhEmi, DSC_DEMI);
  Gerador.wCampo(tcStr, '#014', 'tpImp   ', 01, 01, 1, tpImpToStr(CTe.Ide.tpImp), DSC_TPIMP);
  Gerador.wCampo(tcStr, '#015', 'tpEmis  ', 01, 01, 1, tpEmisToStr(CTe.Ide.tpEmis), DSC_TPEMIS);
  Gerador.wCampo(tcInt, '#016', 'cDV     ', 01, 01, 1, CTe.Ide.cDV, DSC_CDV);
  Gerador.wCampo(tcStr, '#017', 'tpAmb   ', 01, 01, 1, tpAmbToStr(CTe.Ide.tpAmb), DSC_TPAMB);
  Gerador.wCampo(tcStr, '#018', 'tpCTe   ', 01, 01, 1, tpCTePagToStr(CTe.Ide.tpCTe), DSC_TPCTE);
  Gerador.wCampo(tcStr, '#019', 'procEmi', 01, 01, 1, procEmiToStr(CTe.Ide.procEmi), DSC_PROCEMI);
  Gerador.wCampo(tcStr, '#020', 'verProc', 01, 20, 1, CTe.Ide.verProc, DSC_VERPROC);
  Gerador.wCampo(tcStr, '#021', 'refCTE ', 44, 44, 0, SomenteNumeros(CTe.Ide.refCTE), DSC_REFCTE);
  if SomenteNumeros(CTe.Ide.refCTe) <> '' then
    if not ValidarChave('NFe' + SomenteNumeros(CTe.Ide.refCTe)) then
      Gerador.wAlerta('#021', 'refCTE', DSC_REFCTE, ERR_MSG_INVALIDO);
  Gerador.wCampo(tcInt, '#022', 'cMunEnv ', 07, 07, 1, CTe.ide.cMunEnv, DSC_CMUNEMI);
  if not ValidarMunicipio(CTe.ide.cMunEnv) then
    Gerador.wAlerta('#022', 'cMunEnv', DSC_CMUNEMI, ERR_MSG_INVALIDO);
  Gerador.wCampo(tcStr, '#023', 'xMunEnv ', 01, 60, 1, CTe.ide.xMunEnv, DSC_XMUN);
  Gerador.wCampo(tcStr, '#024', 'UFEnv   ', 02, 02, 1, CTe.ide.UFEnv, DSC_UF);
  if not ValidarUF(CTe.ide.UFEnv) then
    Gerador.wAlerta('#024', 'UFEnv', DSC_UF, ERR_MSG_INVALIDO);
  Gerador.wCampo(tcStr, '#025', 'modal   ', 02, 02, 1, TpModalToStr(CTe.Ide.modal), DSC_MODAL);
  Gerador.wCampo(tcStr, '#026', 'tpServ  ', 01, 01, 1, TpServPagToStr(CTe.Ide.tpServ), DSC_TPSERV);
  Gerador.wCampo(tcInt, '#027', 'cMunIni ', 07, 07, 1, CTe.ide.cMunIni, DSC_CMUNEMI);
  if not ValidarMunicipio(CTe.ide.cMunIni) then
    Gerador.wAlerta('#027', 'cMunIni', DSC_CMUNEMI, ERR_MSG_INVALIDO);
  Gerador.wCampo(tcStr, '#028', 'xMunIni ', 01, 60, 1, CTe.ide.xMunIni, DSC_XMUN);
  Gerador.wCampo(tcStr, '#029', 'UFIni   ', 02, 02, 1, CTe.ide.UFIni, DSC_UF);
  if not ValidarUF(CTe.ide.UFIni) then
    Gerador.wAlerta('#029', 'UFIni', DSC_UF, ERR_MSG_INVALIDO);
  Gerador.wCampo(tcInt, '#030', 'cMunFim ', 07, 07, 1, CTe.ide.cMunFim, DSC_CMUNEMI);
  if not ValidarMunicipio(CTe.ide.cMunFim) then
    Gerador.wAlerta('#030', 'cMunFim', DSC_CMUNEMI, ERR_MSG_INVALIDO);
  Gerador.wCampo(tcStr, '#031', 'xMunFim    ', 01, 60, 1, CTe.ide.xMunFim, DSC_XMUN);
  Gerador.wCampo(tcStr, '#032', 'UFFim      ', 02, 02, 1, CTe.ide.UFFim, DSC_UF);
  if not ValidarUF(CTe.ide.UFFim) then
    Gerador.wAlerta('#032', 'UFFim', DSC_UF, ERR_MSG_INVALIDO);
  Gerador.wCampo(tcStr, '#033', 'retira     ', 01, 01, 1, TpRetiraPagToStr(CTe.Ide.retira), DSC_RETIRA);
  Gerador.wCampo(tcStr, '#034', 'xDetRetira ', 01, 160, 0, CTe.Ide.xdetretira, DSC_DRET);

  (**)GerarToma03;
  (**)GerarToma4;

  if CTe.Ide.tpEmis = teFSDA
   then begin
     Gerador.wCampo(tcDatHor, '#057', 'dhCont ', 19, 019, 0, CTe.ide.dhCont, '');
     Gerador.wCampo(tcStr,    '#058', 'xJust  ', 15, 256, 0, CTe.ide.xJust, '');
   end;
  Gerador.wGrupo('/ide');
end;

procedure TCTeW.GerarToma03;
begin
  if (CTe.Ide.Toma4.xNome = '') then
  begin
    Gerador.wGrupo('toma03', '#035');
    Gerador.wCampo(tcStr, '#036', 'toma ', 01, 01, 1, TpTomadorToStr(CTe.ide.Toma03.Toma), DSC_TOMA);
    Gerador.wGrupo('/toma03');
  end;
end;

procedure TCTeW.GerarToma4;
begin
  if (CTe.Ide.Toma4.IE <> '') or
     (CTe.Ide.Toma4.xNome <> '') then
  begin
    Gerador.wGrupo('toma4', '#037');
    Gerador.wCampo(tcStr, '#038', 'toma ', 01, 01, 1, TpTomadorToStr(CTe.ide.Toma4.Toma), DSC_TOMA);
    Gerador.wCampoCNPJCPF('#039', '#040', CTe.ide.Toma4.CNPJCPF, CTe.Ide.Toma4.EnderToma.cPais);

    if CTe.Ide.Toma4.IE <> ''
     then begin
      if Trim(CTe.Ide.Toma4.IE) = 'ISENTO'
       then Gerador.wCampo(tcStr, '#041', 'IE ', 00, 14, 1, CTe.Ide.Toma4.IE, DSC_IE)
       else Gerador.wCampo(tcStr, '#041', 'IE ', 00, 14, 1, SomenteNumeros(CTe.Ide.Toma4.IE), DSC_IE);

      if (FOpcoes.ValidarInscricoes)
       then if not ValidarIE(CTe.Ide.Toma4.IE, CTe.Ide.Toma4.EnderToma.UF) then
        Gerador.wAlerta('#041', 'IE', DSC_IE, ERR_MSG_INVALIDO);
     end;

    Gerador.wCampo(tcStr, '#042', 'xNome  ', 01, 60, 1, CTe.Ide.Toma4.xNome, DSC_XNOME);
    Gerador.wCampo(tcStr, '#043', 'xFant  ', 01, 60, 0, CTe.Ide.Toma4.xFant, DSC_XFANT);
    Gerador.wCampo(tcStr, '#044', 'fone  ', 07, 12, 0, CTe.Ide.Toma4.fone, DSC_FONE);

    (***)GerarEnderToma;

    Gerador.wCampo(tcStr, '#056', 'email  ', 01, 60, 0, CTe.Ide.Toma4.email, DSC_EMAIL);
    Gerador.wGrupo('/toma4');
  end;
end;

procedure TCTeW.GerarEnderToma;
var
  cMun: integer;
  xMun: string;
  xUF: string;
begin
  AjustarMunicipioUF(xUF, xMun, cMun, CTe.Ide.Toma4.EnderToma.cPais,
                                      CTe.Ide.Toma4.EnderToma.UF,
                                      CTe.Ide.Toma4.EnderToma.xMun,
                                      CTe.Ide.Toma4.EnderToma.cMun);
  Gerador.wGrupo('enderToma', '#045');
  Gerador.wCampo(tcStr, '#046', 'xLgr   ', 01, 255, 1, CTe.Ide.Toma4.EnderToma.xLgr, DSC_XLGR);
  Gerador.wCampo(tcStr, '#047', 'nro    ', 01, 60, 1, ExecutarAjusteTagNro(FOpcoes.FAjustarTagNro, CTe.Ide.Toma4.EnderToma.nro), DSC_NRO);
  Gerador.wCampo(tcStr, '#048', 'xCpl   ', 01, 60, 0, CTe.Ide.Toma4.EnderToma.xCpl, DSC_XCPL);
  Gerador.wCampo(tcStr, '#049', 'xBairro', 01, 60, 1, CTe.Ide.Toma4.EnderToma.xBairro, DSC_XBAIRRO);
  Gerador.wCampo(tcInt, '#050', 'cMun   ', 07, 07, 1, cMun, DSC_CMUN);
  if not ValidarMunicipio(CTe.Ide.Toma4.EnderToma.cMun) then
    Gerador.wAlerta('#050', 'cMun', DSC_CMUN, ERR_MSG_INVALIDO);
  Gerador.wCampo(tcStr, '#051', 'xMun   ', 01, 60, 1, xMun, DSC_XMUN);
  Gerador.wCampo(tcInt, '#052', 'CEP    ', 08, 08, 0, CTe.Ide.Toma4.EnderToma.CEP, DSC_CEP);
  Gerador.wCampo(tcStr, '#053', 'UF     ', 02, 02, 1, xUF, DSC_UF);
  if not ValidarUF(xUF) then
    Gerador.wAlerta('#053', 'UF', DSC_UF, ERR_MSG_INVALIDO);
  Gerador.wCampo(tcInt, '#054', 'cPais  ', 04, 04, 0, CTe.Ide.Toma4.EnderToma.cPais, DSC_CPAIS); // Conforme NT-2009/01
  Gerador.wCampo(tcStr, '#055', 'xPais  ', 01, 60, 0, CTe.Ide.Toma4.EnderToma.xPais, DSC_XPAIS);
  Gerador.wGrupo('/enderToma');
end;

procedure TCTeW.GerarCompl;
begin
  Gerador.wGrupo('compl', '#059');//compl
  Gerador.wCampo(tcStr, '#060', 'xCaracAd  ', 01, 15, 0, CTe.Compl.xCaracAd, '');
  Gerador.wCampo(tcStr, '#061', 'xCaracSer ', 01, 30, 0, CTe.Compl.xCaracSer, '');
  Gerador.wCampo(tcStr, '#062', 'xEmi      ', 01, 20, 0, CTe.Compl.xEmi, '');

  (**)GerarFluxo;

  if (TpDataPeriodoToStr(CTe.Compl.Entrega.TipoData)>='0') and
     (TpHorarioIntervaloToStr(CTe.Compl.Entrega.TipoHora)>='0')
   then (**)GerarEntrega;

  Gerador.wCampo(tcStr, '#088', 'origCalc ', 01, 40, 0, CTe.Compl.origCalc, DSC_ORIGCALC);
  Gerador.wCampo(tcStr, '#089', 'destCalc ', 01, 40, 0, CTe.Compl.destCalc, DSC_DESTCALC);
  Gerador.wCampo(tcStr, '#090', 'xObs     ', 01, 2000, 0, CTe.Compl.xObs, DSC_XOBS);

  (**)GerarObsCont;
  (**)GerarObsFisco;

  Gerador.wGrupo('/compl');
end;

procedure TCTeW.GerarFluxo;
var
  i: integer;
begin
 if (CTe.Compl.fluxo.xOrig<>'') or (CTe.Compl.fluxo.pass.Count>0) or
    (CTe.Compl.fluxo.xDest<>'') or (CTe.Compl.fluxo.xRota<>'')
  then begin
   Gerador.wGrupo('fluxo', '#063'); //fluxo
   Gerador.wCampo(tcStr, '#064', 'xOrig ', 01, 15, 0, CTe.Compl.fluxo.xOrig, '');

   for i := 0 to CTe.Compl.fluxo.pass.Count - 1 do
   begin
    Gerador.wGrupo('pass', '#065');
    Gerador.wCampo(tcStr, '#066', 'xPass ', 01, 15, 1, CTe.Compl.fluxo.pass[i].xPass, '');
    Gerador.wGrupo('/pass');
   end;
   if CTe.Compl.fluxo.pass.Count > 990 then
    Gerador.wAlerta('#065', 'pass', '', ERR_MSG_MAIOR_MAXIMO + '990');

   Gerador.wCampo(tcStr, '#067', 'xDest ', 01, 15, 0, CTe.Compl.fluxo.xDest, '');
   Gerador.wCampo(tcStr, '#068', 'xRota ', 01, 10, 0, CTe.Compl.fluxo.xRota, '');
   Gerador.wGrupo('/fluxo');
  end;
end;

procedure TCTeW.GerarEntrega;
begin
  Gerador.wGrupo('Entrega', '#069'); //Entrega

  case CTe.Compl.Entrega.TipoData of
   tdSemData: begin
       Gerador.wGrupo('semData', '#070');
       Gerador.wCampo(tcStr, '#071', 'tpPer ', 01, 01, 1, TpDataPeriodoToStr(CTe.Compl.Entrega.semData.tpPer), '');
       Gerador.wGrupo('/semData');
      end;
  tdNaData,tdAteData,tdApartirData: begin
          Gerador.wGrupo('comData', '#072');
          Gerador.wCampo(tcStr, '#073', 'tpPer ', 01, 01, 1, TpDataPeriodoToStr(CTe.Compl.Entrega.comData.tpPer), '');
          Gerador.wCampo(tcDat, '#074', 'dProg ', 10, 10, 1, CTe.Compl.Entrega.comData.dProg, '');
          Gerador.wGrupo('/comData');
         end;
   tdNoPeriodo: begin
       Gerador.wGrupo('noPeriodo', '#075');
       Gerador.wCampo(tcStr, '#076', 'tpPer ', 01, 01, 1, TpDataPeriodoToStr(CTe.Compl.Entrega.noPeriodo.tpPer), '');
       Gerador.wCampo(tcDat, '#077', 'dIni  ', 10, 10, 1, CTe.Compl.Entrega.noPeriodo.dIni, '');
       Gerador.wCampo(tcDat, '#078', 'dFim  ', 10, 10, 1, CTe.Compl.Entrega.noPeriodo.dFim, '');
       Gerador.wGrupo('/noPeriodo');
      end;
  end;

  case CTe.Compl.Entrega.TipoHora of
   thSemHorario: begin
       Gerador.wGrupo('semHora', '#079');
       Gerador.wCampo(tcStr, '#080', 'tpHor ', 01, 01, 1, TpHorarioIntervaloToStr(CTe.Compl.Entrega.semHora.tpHor), '');
       Gerador.wGrupo('/semHora');
      end;
  thNoHorario,thAteHorario,thApartirHorario: begin
          Gerador.wGrupo('comHora', '#081');
          Gerador.wCampo(tcStr, '#082', 'tpHor ', 01, 01, 1, TpHorarioIntervaloToStr(CTe.Compl.Entrega.comHora.tpHor), '');
          Gerador.wCampo(tcStr, '#083', 'hProg ', 08, 08, 1, TimeToStr(CTe.Compl.Entrega.comHora.hProg), '');
          Gerador.wGrupo('/comHora');
         end;
   thNoIntervalo: begin
       Gerador.wGrupo('noInter', '#084');
       Gerador.wCampo(tcStr, '#085', 'tpHor ', 01, 01, 1, TpHorarioIntervaloToStr(CTe.Compl.Entrega.noInter.tpHor), '');
       Gerador.wCampo(tcStr, '#086', 'hIni  ', 08, 08, 1, TimeToStr(CTe.Compl.Entrega.noInter.hIni), '');
       Gerador.wCampo(tcStr, '#087', 'hFim  ', 08, 08, 1, TimeToStr(CTe.Compl.Entrega.noInter.hFim), '');
       Gerador.wGrupo('/noInter');
      end;
  end;

  Gerador.wGrupo('/Entrega');
end;

procedure TCTeW.GerarObsCont;
var
  i: integer;
begin
  for i := 0 to CTe.Compl.ObsCont.Count - 1 do
  begin
   Gerador.wGrupo('ObsCont xCampo="' + CTe.Compl.ObsCont[i].xCampo + '"', '#092');
   Gerador.wCampo(tcStr, '#093', 'xTexto ', 01, 160, 1, CTe.Compl.ObsCont[i].xTexto, 'xTexto do ObsCont');
   Gerador.wGrupo('/ObsCont');
  end;
  if CTe.Compl.ObsCont.Count > 10 then
    Gerador.wAlerta('#091', 'ObsCont', 'Obs do Contribuinte', ERR_MSG_MAIOR_MAXIMO + '10');
end;

procedure TCTeW.GerarObsFisco;
var
  i: integer;
begin
  for i := 0 to CTe.Compl.ObsFisco.Count - 1 do
  begin
   Gerador.wGrupo('ObsFisco xCampo="' + CTe.Compl.ObsFisco[i].xCampo + '"', '#095');
   Gerador.wCampo(tcStr, '#096', 'xTexto ', 01, 60, 1, CTe.Compl.ObsFisco[i].xTexto, 'xTexto do ObsFisco');
   Gerador.wGrupo('/ObsFisco');
  end;
  if CTe.Compl.ObsFisco.Count > 10 then
    Gerador.wAlerta('#094', 'ObsFisco', 'Obs ao Fisco', ERR_MSG_MAIOR_MAXIMO + '10');
end;

procedure TCTeW.GerarEmit;
begin
  Gerador.wGrupo('emit', '#097');
  Gerador.wCampoCNPJ('#098', CTe.Emit.CNPJ, CODIGO_BRASIL, True);
  Gerador.wCampo(tcStr, '#099', 'IE    ', 02, 14, 1, SomenteNumeros(CTe.Emit.IE), DSC_IE);

  if (FOpcoes.ValidarInscricoes)
   then if not ValidarIE(CTe.Emit.IE, CTe.Emit.enderEmit.UF) then
         Gerador.wAlerta('#099', 'IE', DSC_IE, ERR_MSG_INVALIDO);
  Gerador.wCampo(tcStr, '#100', 'xNome ', 01, 60, 1, CTe.Emit.xNome, DSC_XNOME);
  Gerador.wCampo(tcStr, '#101', 'xFant ', 01, 60, 0, CTe.Emit.xFant, DSC_XFANT);

  (**)GerarEnderEmit;
  Gerador.wGrupo('/emit');
end;

procedure TCTeW.GerarEnderEmit;
var
  cMun: integer;
  xMun: string;
  xUF: string;
begin
  AjustarMunicipioUF(xUF, xMun, cMun, CODIGO_BRASIL,
                                      CTe.Emit.enderEmit.UF,
                                      CTe.Emit.enderEmit.xMun,
                                      CTe.Emit.EnderEmit.cMun);
  Gerador.wGrupo('enderEmit', '#102');
  Gerador.wCampo(tcStr, '#103', 'xLgr   ', 01, 60, 1, CTe.Emit.enderEmit.xLgr, DSC_XLGR);
  Gerador.wCampo(tcStr, '#104', 'nro    ', 01, 60, 1, ExecutarAjusteTagNro(FOpcoes.FAjustarTagNro, CTe.Emit.enderEmit.nro), DSC_NRO);
  Gerador.wCampo(tcStr, '#105', 'xCpl   ', 01, 60, 0, CTe.Emit.enderEmit.xCpl, DSC_XCPL);
  Gerador.wCampo(tcStr, '#106', 'xBairro', 01, 60, 1, CTe.Emit.enderEmit.xBairro, DSC_XBAIRRO);
  Gerador.wCampo(tcInt, '#107', 'cMun   ', 07, 07, 1, cMun, DSC_CMUN);
  if not ValidarMunicipio(CTe.Emit.EnderEmit.cMun) then
    Gerador.wAlerta('#107', 'cMun', DSC_CMUN, ERR_MSG_INVALIDO);
  Gerador.wCampo(tcStr, '#108', 'xMun   ', 01, 60, 1, xMun, DSC_XMUN);
  Gerador.wCampo(tcInt, '#109', 'CEP    ', 08, 08, 0, CTe.Emit.enderEmit.CEP, DSC_CEP);
  Gerador.wCampo(tcStr, '#110', 'UF     ', 02, 02, 1, xUF, DSC_UF);
  if not ValidarUF(xUF) then
    Gerador.wAlerta('#110', 'UF', DSC_UF, ERR_MSG_INVALIDO);
  Gerador.wCampo(tcStr, '#111', 'fone   ', 07, 12, 0, somenteNumeros(CTe.Emit.EnderEmit.fone), DSC_FONE);
  Gerador.wGrupo('/enderEmit');
end;

procedure TCTeW.GerarRem;
begin
  if (CTe.Rem.CNPJCPF <> '') or
     (CTe.Rem.xNome <> '') then
    begin
      Gerador.wGrupo('rem', '#112');
      Gerador.wCampoCNPJCPF('#113', '#114', CTe.Rem.CNPJCPF, CTe.Rem.EnderReme.cPais);

      if Trim(CTe.Rem.IE) = 'ISENTO'
       then Gerador.wCampo(tcStr, '#115', 'IE ', 00, 14, 1, CTe.Rem.IE, DSC_IE)
       else Gerador.wCampo(tcStr, '#115', 'IE ', 00, 14, 1, SomenteNumeros(CTe.Rem.IE), DSC_IE);

      if (FOpcoes.ValidarInscricoes)
       then if not ValidarIE(CTe.Rem.IE, CTe.Rem.EnderReme.UF) then
        Gerador.wAlerta('#115', 'IE', DSC_IE, ERR_MSG_INVALIDO);

      if CTe.Ide.tpAmb = taHomologacao
       then Gerador.wCampo(tcStr, '#116', 'xNome  ', 01, 60, 1, xRazao, DSC_XNOME)
       else Gerador.wCampo(tcStr, '#116', 'xNome  ', 01, 60, 1, CTe.Rem.xNome, DSC_XNOME);
      Gerador.wCampo(tcStr, '#117', 'xFant  ', 01, 60, 0, CTe.Rem.xFant, DSC_XFANT);
      Gerador.wCampo(tcStr, '#118', 'fone   ', 07, 12, 0, somenteNumeros(CTe.Rem.fone), DSC_FONE);

      (**)GerarEnderReme;
      Gerador.wCampo(tcStr, '#130', 'email  ', 01, 60, 0, CTe.Rem.email, DSC_EMAIL);

      (**)GerarLocColeta;
      Gerador.wGrupo('/rem');
    end;
end;

procedure TCTeW.GerarEnderReme;
var
  cMun: integer;
  xMun: string;
  xUF: string;
begin
  AjustarMunicipioUF(xUF, xMun, cMun, CTe.Rem.EnderReme.cPais,
                                      CTe.Rem.EnderReme.UF,
                                      CTe.Rem.EnderReme.xMun,
                                      CTe.Rem.EnderReme.cMun);
  Gerador.wGrupo('enderReme', '#119');
  Gerador.wCampo(tcStr, '#120', 'xLgr    ', 01, 255, 1, CTe.Rem.EnderReme.xLgr, DSC_XLGR);
  Gerador.wCampo(tcStr, '#121', 'nro     ', 01, 60, 1, ExecutarAjusteTagNro(FOpcoes.FAjustarTagNro, CTe.Rem.EnderReme.nro), DSC_NRO);
  Gerador.wCampo(tcStr, '#122', 'xCpl    ', 01, 60, 0, CTe.Rem.EnderReme.xCpl, DSC_XCPL);
  Gerador.wCampo(tcStr, '#123', 'xBairro ', 01, 60, 1, CTe.Rem.EnderReme.xBairro, DSC_XBAIRRO);
  Gerador.wCampo(tcInt, '#124', 'cMun    ', 07, 07, 1, cMun, DSC_CMUN);
  if not ValidarMunicipio(CTe.Rem.EnderReme.cMun) then
    Gerador.wAlerta('#124', 'cMun', DSC_CMUN, ERR_MSG_INVALIDO);
  Gerador.wCampo(tcStr, '#125', 'xMun    ', 01, 60, 1, xMun, DSC_XMUN);
  Gerador.wCampo(tcInt, '#126', 'CEP     ', 08, 08, 0, CTe.Rem.EnderReme.CEP, DSC_CEP);
  Gerador.wCampo(tcStr, '#127', 'UF      ', 02, 02, 1, xUF, DSC_UF);
  if not ValidarUF(xUF) then
    Gerador.wAlerta('#127', 'UF', DSC_UF, ERR_MSG_INVALIDO);
  Gerador.wCampo(tcInt, '#128', 'cPais   ', 04, 04, 0, CTe.Rem.EnderReme.cPais, DSC_CPAIS); // Conforme NT-2009/01
  Gerador.wCampo(tcStr, '#129', 'xPais   ', 01, 60, 0, CTe.Rem.EnderReme.xPais, DSC_XPAIS);
  Gerador.wGrupo('/enderReme');
end;

procedure TCTeW.GerarLocColeta;
begin
  if (CTe.Rem.locColeta.CNPJCPF <> '') or
     (CTe.Rem.locColeta.xNome <> '') then
  begin
    Gerador.wGrupo('locColeta', '#147');
    Gerador.wCampoCNPJCPF('#148', '#149', CTe.Rem.locColeta.CNPJCPF, CODIGO_BRASIL);
    Gerador.wCampo(tcStr, '#150', 'xNome   ', 01, 60, 1, CTe.Rem.locColeta.xNome, DSC_XNOME);
    Gerador.wCampo(tcStr, '#151', 'xLgr    ', 01, 255, 1, CTe.Rem.locColeta.xLgr, DSC_XLGR);
    Gerador.wCampo(tcStr, '#152', 'nro     ', 01, 60, 1, ExecutarAjusteTagNro(FOpcoes.FAjustarTagNro, CTe.Rem.locColeta.nro), DSC_NRO);
    Gerador.wCampo(tcStr, '#153', 'xCpl    ', 01, 60, 0, CTe.Rem.locColeta.xCpl, DSC_XCPL);
    Gerador.wCampo(tcStr, '#154', 'xBairro ', 01, 60, 1, CTe.Rem.locColeta.xBairro, DSC_XBAIRRO);
    Gerador.wCampo(tcInt, '#155', 'cMun    ', 07, 07, 1, CTe.Rem.locColeta.cMun, DSC_CMUN);
    if not ValidarMunicipio(CTe.Rem.locColeta.cMun) then
      Gerador.wAlerta('#155', 'cMun', DSC_CMUN, ERR_MSG_INVALIDO);
    Gerador.wCampo(tcStr, '#156', 'xMun    ', 01, 60, 1, CTe.Rem.locColeta.xMun, DSC_XMUN);
    Gerador.wCampo(tcStr, '#157', 'UF      ', 02, 02, 1, CTe.Rem.locColeta.UF, DSC_UF);
    if not ValidarUF(CTe.Rem.locColeta.UF) then
      Gerador.wAlerta('#157', 'UF', DSC_UF, ERR_MSG_INVALIDO);
    Gerador.wGrupo('/locColeta');
  end;

end;

procedure TCTeW.GerarExped;
begin
  if (CTe.Exped.CNPJCPF <> '') or
     (CTe.Exped.xNome <> '') then
  begin
    Gerador.wGrupo('exped', '#167');
    Gerador.wCampoCNPJCPF('#168', '#169', CTe.Exped.CNPJCPF, CTe.Exped.EnderExped.cPais);

    if Trim(CTe.Exped.IE) = 'ISENTO'
     then Gerador.wCampo(tcStr, '#170', 'IE ', 00, 14, 1, CTe.Exped.IE, DSC_IE)
     else Gerador.wCampo(tcStr, '#170', 'IE ', 00, 14, 0, SomenteNumeros(CTe.Exped.IE), DSC_IE);

    if (FOpcoes.ValidarInscricoes)
     then if not ValidarIE(CTe.Exped.IE, CTe.Exped.EnderExped.UF) then
      Gerador.wAlerta('#170', 'IE', DSC_IE, ERR_MSG_INVALIDO);

    if CTe.Ide.tpAmb = taHomologacao
     then Gerador.wCampo(tcStr, '#171', 'xNome  ', 01, 60, 1, xRazao, DSC_XNOME)
     else Gerador.wCampo(tcStr, '#171', 'xNome  ', 01, 60, 1, CTe.Exped.xNome, DSC_XNOME);
    Gerador.wCampo(tcStr, '#172', 'fone   ', 07, 12, 0, somenteNumeros(CTe.Exped.fone), DSC_FONE);

    (**)GerarEnderExped;
    Gerador.wCampo(tcStr, '#184', 'email  ', 01, 60, 0, CTe.Exped.email, DSC_EMAIL);
    Gerador.wGrupo('/exped');
  end;
end;

procedure TCTeW.GerarEnderExped;
var
  cMun: integer;
  xMun: string;
  xUF: string;
begin
  AjustarMunicipioUF(xUF, xMun, cMun, CTe.Exped.EnderExped.cPais,
                                      CTe.Exped.EnderExped.UF,
                                      CTe.Exped.EnderExped.xMun,
                                      CTe.Exped.EnderExped.cMun);
  Gerador.wGrupo('enderExped', '#173');
  Gerador.wCampo(tcStr, '#174', 'xLgr    ', 01, 255, 1, CTe.Exped.EnderExped.xLgr, DSC_XLGR);
  Gerador.wCampo(tcStr, '#175', 'nro     ', 01, 60, 1, ExecutarAjusteTagNro(FOpcoes.FAjustarTagNro, CTe.Exped.EnderExped.nro), DSC_NRO);
  Gerador.wCampo(tcStr, '#176', 'xCpl    ', 01, 60, 0, CTe.Exped.EnderExped.xCpl, DSC_XCPL);
  Gerador.wCampo(tcStr, '#177', 'xBairro ', 01, 60, 1, CTe.Exped.EnderExped.xBairro, DSC_XBAIRRO);
  Gerador.wCampo(tcInt, '#178', 'cMun    ', 07, 07, 1, cMun, DSC_CMUN);
  if not ValidarMunicipio(CTe.Exped.EnderExped.cMun) then
    Gerador.wAlerta('#178', 'cMun', DSC_CMUN, ERR_MSG_INVALIDO);
  Gerador.wCampo(tcStr, '#179', 'xMun    ', 01, 60, 1, xMun, DSC_XMUN);
  Gerador.wCampo(tcInt, '#180', 'CEP     ', 08, 08, 0, CTe.Exped.EnderExped.CEP, DSC_CEP);
  Gerador.wCampo(tcStr, '#181', 'UF      ', 02, 02, 1, xUF, DSC_UF);
  if not ValidarUF(xUF) then
    Gerador.wAlerta('#181', 'UF', DSC_UF, ERR_MSG_INVALIDO);
  Gerador.wCampo(tcInt, '#182', 'cPais   ', 04, 04, 0, CTe.Exped.EnderExped.cPais, DSC_CPAIS); // Conforme NT-2009/01
  Gerador.wCampo(tcStr, '#183', 'xPais   ', 01, 60, 0, CTe.Exped.EnderExped.xPais, DSC_XPAIS);
  Gerador.wGrupo('/enderExped');
end;

procedure TCTeW.GerarReceb;
begin
  if (CTe.Receb.CNPJCPF <> '') or
     (CTe.Receb.xNome <> '') then
  Begin
    Gerador.wGrupo('receb', '#185');
    Gerador.wCampoCNPJCPF('#186', '#187', CTe.Receb.CNPJCPF, CTe.Receb.EnderReceb.cPais);

    if Trim(CTe.Receb.IE) = 'ISENTO'
     then Gerador.wCampo(tcStr, '#188', 'IE ', 00, 14, 1, CTe.Receb.IE, DSC_IE)
     else Gerador.wCampo(tcStr, '#188', 'IE ', 00, 14, 0, SomenteNumeros(CTe.Receb.IE), DSC_IE);

    if (FOpcoes.ValidarInscricoes)
     then if not ValidarIE(CTe.Receb.IE, CTe.Receb.EnderReceb.UF) then
      Gerador.wAlerta('#188', 'IE', DSC_IE, ERR_MSG_INVALIDO);

    if CTe.Ide.tpAmb = taHomologacao
     then Gerador.wCampo(tcStr, '#189', 'xNome  ', 01, 60, 1, xRazao, DSC_XNOME)
     else Gerador.wCampo(tcStr, '#189', 'xNome  ', 01, 60, 1, CTe.Receb.xNome, DSC_XNOME);
    Gerador.wCampo(tcStr, '#190', 'fone   ', 07, 12, 0, somenteNumeros(CTe.Receb.fone), DSC_FONE);

    (**)GerarEnderReceb;
    Gerador.wCampo(tcStr, '#202', 'email  ', 01, 60, 0, CTe.Receb.email, DSC_EMAIL);
    Gerador.wGrupo('/receb');
  end;
end;

procedure TCTeW.GerarEnderReceb;
var
  cMun: integer;
  xMun: string;
  xUF: string;
begin
  AjustarMunicipioUF(xUF, xMun, cMun, CTe.Receb.EnderReceb.cPais,
                                      CTe.Receb.EnderReceb.UF,
                                      CTe.Receb.EnderReceb.xMun,
                                      CTe.Receb.EnderReceb.cMun);
  Gerador.wGrupo('enderReceb', '#191');
  Gerador.wCampo(tcStr, '#192', 'xLgr    ', 01, 255, 1, CTe.Receb.EnderReceb.xLgr, DSC_XLGR);
  Gerador.wCampo(tcStr, '#193', 'nro     ', 01, 60, 1, ExecutarAjusteTagNro(FOpcoes.FAjustarTagNro, CTe.Receb.EnderReceb.nro), DSC_NRO);
  Gerador.wCampo(tcStr, '#194', 'xCpl    ', 01, 60, 0, CTe.Receb.EnderReceb.xCpl, DSC_XCPL);
  Gerador.wCampo(tcStr, '#195', 'xBairro ', 01, 60, 1, CTe.Receb.EnderReceb.xBairro, DSC_XBAIRRO);
  Gerador.wCampo(tcInt, '#196', 'cMun    ', 07, 07, 1, cMun, DSC_CMUN);
  if not ValidarMunicipio(CTe.Receb.EnderReceb.cMun) then
    Gerador.wAlerta('#196', 'cMun', DSC_CMUN, ERR_MSG_INVALIDO);
  Gerador.wCampo(tcStr, '#197', 'xMun    ', 01, 60, 1, xMun, DSC_XMUN);
  Gerador.wCampo(tcInt, '#198', 'CEP     ', 08, 08, 0, CTe.Receb.EnderReceb.CEP, DSC_CEP);
  Gerador.wCampo(tcStr, '#199', 'UF      ', 02, 02, 1, xUF, DSC_UF);
  if not ValidarUF(xUF) then
    Gerador.wAlerta('#199', 'UF', DSC_UF, ERR_MSG_INVALIDO);
  Gerador.wCampo(tcInt, '#200', 'cPais   ', 04, 04, 0, CTe.Receb.EnderReceb.cPais, DSC_CPAIS); // Conforme NT-2009/01
  Gerador.wCampo(tcStr, '#201', 'xPais   ', 01, 60, 0, CTe.Receb.EnderReceb.xPais, DSC_XPAIS);
  Gerador.wGrupo('/enderReceb');
end;

procedure TCTeW.GerarDest;
begin
  if (CTe.Dest.CNPJCPF <> '') or
     (CTe.Dest.xNome <> '') then
    begin
      Gerador.wGrupo('dest', '#203');
      Gerador.wCampoCNPJCPF('#204', '#205', CTe.Dest.CNPJCPF, CTe.Dest.EnderDest.cPais);

      if CTe.Dest.IE <> ''
       then begin
        if Trim(CTe.Dest.IE) = 'ISENTO'
         then Gerador.wCampo(tcStr, '#206', 'IE ', 00, 14, 1, CTe.Dest.IE, DSC_IE)
         else Gerador.wCampo(tcStr, '#206', 'IE ', 00, 14, 1, SomenteNumeros(CTe.Dest.IE), DSC_IE);

        if (FOpcoes.ValidarInscricoes)
         then if not ValidarIE(CTe.Dest.IE, CTe.Dest.EnderDest.UF) then
          Gerador.wAlerta('#206', 'IE', DSC_IE, ERR_MSG_INVALIDO);
       end;

      if CTe.Ide.tpAmb = taHomologacao
       then Gerador.wCampo(tcStr, '#207', 'xNome  ', 01, 60, 1, xRazao, DSC_XNOME)
       else Gerador.wCampo(tcStr, '#207', 'xNome  ', 01, 60, 1, CTe.Dest.xNome, DSC_XNOME);
      Gerador.wCampo(tcStr, '#208', 'fone   ', 07, 12, 0, somenteNumeros(CTe.Dest.fone), DSC_FONE);
      Gerador.wCampo(tcStr, '#209', 'ISUF   ', 08, 09, 0, CTe.Dest.ISUF, DSC_ISUF);
      if (FOpcoes.ValidarInscricoes) and (CTe.Dest.ISUF <> '') then
        if not ValidarISUF(CTe.Dest.ISUF) then
          Gerador.wAlerta('#209', 'ISUF', DSC_ISUF, ERR_MSG_INVALIDO);

      (**)GerarEnderDest;
      Gerador.wCampo(tcStr, '#221', 'email  ', 01, 60, 0, CTe.Dest.email, DSC_EMAIL);
      (**)GerarLocEnt;
      Gerador.wGrupo('/dest');
    end;
end;

procedure TCTeW.GerarEnderDest;
var
  cMun: integer;
  xMun: string;
  xUF: string;
begin
  AjustarMunicipioUF(xUF, xMun, cMun, CTe.Dest.EnderDest.cPais,
                                      CTe.Dest.EnderDest.UF,
                                      CTe.Dest.EnderDest.xMun,
                                      CTe.Dest.EnderDest.cMun);
  Gerador.wGrupo('enderDest', '#210');
  Gerador.wCampo(tcStr, '#211', 'xLgr   ', 01, 255, 1, CTe.Dest.EnderDest.xLgr, DSC_XLGR);
  Gerador.wCampo(tcStr, '#212', 'nro    ', 01, 60, 1, ExecutarAjusteTagNro(FOpcoes.FAjustarTagNro, CTe.Dest.EnderDest.nro), DSC_NRO);
  Gerador.wCampo(tcStr, '#213', 'xCpl   ', 01, 60, 0, CTe.Dest.EnderDest.xCpl, DSC_XCPL);
  Gerador.wCampo(tcStr, '#214', 'xBairro', 01, 60, 1, CTe.Dest.EnderDest.xBairro, DSC_XBAIRRO);
  Gerador.wCampo(tcInt, '#215', 'cMun   ', 07, 07, 1, cMun, DSC_CMUN);
  if not ValidarMunicipio(CTe.Dest.EnderDest.cMun) then
    Gerador.wAlerta('#215', 'cMun', DSC_CMUN, ERR_MSG_INVALIDO);
  Gerador.wCampo(tcStr, '#216', 'xMun   ', 01, 60, 1, xMun, DSC_XMUN);
  Gerador.wCampo(tcInt, '#217', 'CEP    ', 08, 08, 0, CTe.Dest.EnderDest.CEP, DSC_CEP);
  Gerador.wCampo(tcStr, '#218', 'UF     ', 02, 02, 1, xUF, DSC_UF);
  if not ValidarUF(xUF) then
    Gerador.wAlerta('#218', 'UF', DSC_UF, ERR_MSG_INVALIDO);
  Gerador.wCampo(tcInt, '#219', 'cPais  ', 04, 04, 0, CTe.Dest.EnderDest.cPais, DSC_CPAIS); // Conforme NT-2009/01
  Gerador.wCampo(tcStr, '#220', 'xPais  ', 01, 60, 0, CTe.Dest.EnderDest.xPais, DSC_XPAIS);
  Gerador.wGrupo('/enderDest');
end;

procedure TCTeW.GerarLocEnt;
begin
  if (CTe.Dest.locEnt.CNPJCPF <> '') or
     (CTe.Dest.locEnt.xNome <> '') then
  begin
    Gerador.wGrupo('locEnt', '#222');
    Gerador.wCampoCNPJCPF('#223', '#224', CTe.Dest.locEnt.CNPJCPF, CODIGO_BRASIL);
    Gerador.wCampo(tcStr, '#225', 'xNome  ', 01, 60, 1, CTe.Dest.locEnt.xNome, DSC_XNOME);
    Gerador.wCampo(tcStr, '#226', 'xLgr   ', 01, 255, 1, CTe.Dest.locEnt.xLgr, DSC_XLGR);
    Gerador.wCampo(tcStr, '#227', 'nro    ', 01, 60, 1, ExecutarAjusteTagNro(FOpcoes.FAjustarTagNro, CTe.Dest.locEnt.nro), DSC_NRO);
    Gerador.wCampo(tcStr, '#228', 'xCpl   ', 01, 60, 0, CTe.Dest.locEnt.xCpl, DSC_XCPL);
    Gerador.wCampo(tcStr, '#229', 'xBairro', 01, 60, 1, CTe.Dest.locEnt.xBairro, DSC_XBAIRRO);
    Gerador.wCampo(tcInt, '#230', 'cMun   ', 07, 07, 1, CTe.Dest.locEnt.cMun, DSC_CMUN);
    if not ValidarMunicipio(CTe.Dest.locEnt.cMun) then
      Gerador.wAlerta('#230', 'cMun', DSC_CMUN, ERR_MSG_INVALIDO);
    Gerador.wCampo(tcStr, '#231', 'xMun   ', 01, 60, 1, CTe.Dest.locEnt.xMun, DSC_XMUN);
    Gerador.wCampo(tcStr, '#232', 'UF     ', 02, 02, 1, CTe.Dest.locEnt.UF, DSC_UF);
    if not ValidarUF(CTe.Dest.locEnt.UF) then
      Gerador.wAlerta('#232', 'UF', DSC_UF, ERR_MSG_INVALIDO);
    Gerador.wGrupo('/locEnt');
  end;
end;

procedure TCTeW.GerarVPrest;
begin
  Gerador.wGrupo('vPrest', '#233');
  Gerador.wCampo(tcDe2, '#234', 'vTPrest ', 01, 15, 1, CTe.vPrest.vTPrest, DSC_VTPREST);
  Gerador.wCampo(tcDe2, '#235', 'vRec    ', 01, 15, 1, CTe.vPrest.vRec, DSC_VREC);

  (**)GerarComp;
  Gerador.wGrupo('/vPrest');
end;

procedure TCTeW.GerarComp;
var
  i: integer;
begin
  for i := 0 to CTe.vPrest.comp.Count - 1 do
  begin
    if (CTe.vPrest.comp[i].xNome <> '') and
      (CTe.vPrest.comp[i].vComp <> 0) then
      begin
        Gerador.wGrupo('Comp', '#236');
        Gerador.wCampo(tcStr, '#237', 'xNome ', 01, 15, 1, CTe.vPrest.comp[i].xNome, DSC_XNOMEC);
        Gerador.wCampo(tcDe2, '#238', 'vComp ', 01, 15, 1, CTe.vPrest.comp[i].vComp, DSC_VCOMP);
        Gerador.wGrupo('/Comp');
      end;
  end;
end;

procedure TCTeW.GerarImp;
begin
  Gerador.wGrupo('imp', '#239');
  (**)GerarICMS;
  Gerador.wCampo(tcDe2, '#275', 'vTotTrib   ', 01, 15, 0, CTe.Imp.vTotTrib, DSC_VCOMP);
  Gerador.wCampo(tcStr, '#275', 'infAdFisco ', 01, 2000, 0, CTe.Imp.InfAdFisco, DSC_INFADFISCO);
  Gerador.wGrupo('/imp');
end;

procedure TCTeW.GerarICMS;
begin
  Gerador.wGrupo('ICMS', '#240');

  if CTe.Imp.ICMS.SituTrib = cst00 then
    (**)GerarCST00
  else if CTe.Imp.ICMS.SituTrib = cst20 then
    (**)GerarCST20
  else if ((CTe.Imp.ICMS.SituTrib = cst40) or
           (CTe.Imp.ICMS.SituTrib = cst41) or
           (CTe.Imp.ICMS.SituTrib = cst51)) then
    (**)GerarCST45
  else if CTe.Imp.ICMS.SituTrib = cst60 then
    (**)GerarCST60
  else if CTe.Imp.ICMS.SituTrib = cst90 then
    (**)GerarCST90
  else if CTe.Imp.ICMS.SituTrib = cstICMSOutraUF then
    (**)GerarICMSOutraUF
  else if CTe.Imp.ICMS.SituTrib = cstICMSSN then
    (**)GerarICMSSN;

  Gerador.wGrupo('/ICMS');
end;

procedure TCTeW.GerarCST00;
begin
  Gerador.wGrupo('ICMS00', '#241');
  Gerador.wCampo(tcStr, '#242', 'CST   ', 02, 02, 1, CSTICMSTOStr(CTe.Imp.ICMS.ICMS00.CST), DSC_CST);
  Gerador.wCampo(tcDe2, '#243', 'vBC   ', 01, 15, 1, CTe.Imp.ICMS.ICMS00.vBC, DSC_VBC);
  Gerador.wCampo(tcDe2, '#244', 'pICMS ', 01, 05, 1, CTe.Imp.ICMS.ICMS00.pICMS, DSC_PICMS);
  Gerador.wCampo(tcDe2, '#245', 'vICMS ', 01, 15, 1, CTe.Imp.ICMS.ICMS00.vICMS, DSC_VICMS);
  Gerador.wGrupo('/ICMS00');
end;

procedure TCTeW.GerarCST20;
begin
  Gerador.wGrupo('ICMS20', '#246');
  Gerador.wCampo(tcStr, '#247', 'CST    ', 02, 02, 1, CSTICMSTOStr(CTe.Imp.ICMS.ICMS20.CST), DSC_CST);
  Gerador.wCampo(tcDe2, '#248', 'pRedBC ', 01, 05, 1, CTe.Imp.ICMS.ICMS20.pRedBC, DSC_PREDBC);
  Gerador.wCampo(tcDe2, '#249', 'vBC    ', 01, 15, 1, CTe.Imp.ICMS.ICMS20.vBC, DSC_VBC);
  Gerador.wCampo(tcDe2, '#250', 'pICMS  ', 01, 05, 1, CTe.Imp.ICMS.ICMS20.pICMS, DSC_PICMS);
  Gerador.wCampo(tcDe2, '#251', 'vICMS  ', 01, 15, 1, CTe.Imp.ICMS.ICMS20.vICMS, DSC_VICMS);
  Gerador.wGrupo('/ICMS20');
end;

procedure TCTeW.GerarCST45;
begin
  Gerador.wGrupo('ICMS45', '#252');
  Gerador.wCampo(tcStr, '#253', 'CST ', 02, 02, 1, CSTICMSTOStr(CTe.Imp.ICMS.ICMS45.CST), DSC_CST);
  Gerador.wGrupo('/ICMS45');
end;

procedure TCTeW.GerarCST60;
begin
  Gerador.wGrupo('ICMS60', '#254');
  Gerador.wCampo(tcStr, '#255', 'CST        ', 02, 02, 1, CSTICMSTOStr(CTe.Imp.ICMS.ICMS60.CST), DSC_CST);
  Gerador.wCampo(tcDe2, '#256', 'vBCSTRet   ', 01, 15, 1, CTe.Imp.ICMS.ICMS60.vBCSTRet, DSC_VBC);
  Gerador.wCampo(tcDe2, '#257', 'vICMSSTRet ', 01, 15, 1, CTe.Imp.ICMS.ICMS60.vICMSSTRet, DSC_VICMS);
  Gerador.wCampo(tcDe2, '#258', 'pICMSSTRet ', 01, 05, 1, CTe.Imp.ICMS.ICMS60.pICMSSTRet, DSC_PICMS);
  if CTe.Imp.ICMS.ICMS60.vCred > 0 then
   Gerador.wCampo(tcDe2, '#259', 'vCred     ', 01, 15, 1, CTe.Imp.ICMS.ICMS60.vCred, DSC_VCRED);
  Gerador.wGrupo('/ICMS60');
end;

procedure TCTeW.GerarCST90;
begin
  Gerador.wGrupo('ICMS90', '#260');
  Gerador.wCampo(tcStr, '#261', 'CST      ', 02, 02, 1, CSTICMSTOStr(CTe.Imp.ICMS.ICMS90.CST), DSC_CST);
  if CTe.Imp.ICMS.ICMS90.pRedBC > 0 then
    Gerador.wCampo(tcDe2, '#262', 'pRedBC ', 01, 05, 1, CTe.Imp.ICMS.ICMS90.pRedBC, DSC_PREDBC);
  Gerador.wCampo(tcDe2, '#263', 'vBC      ', 01, 15, 1, CTe.Imp.ICMS.ICMS90.vBC, DSC_VBC);
  Gerador.wCampo(tcDe2, '#264', 'pICMS    ', 01, 05, 1, CTe.Imp.ICMS.ICMS90.pICMS, DSC_PICMS);
  Gerador.wCampo(tcDe2, '#265', 'vICMS    ', 01, 15, 1, CTe.Imp.ICMS.ICMS90.vICMS, DSC_VICMS);
  if CTe.Imp.ICMS.ICMS90.vCred > 0 then
    Gerador.wCampo(tcDe2, '#266', 'vCred  ', 01, 15, 1, CTe.Imp.ICMS.ICMS90.vCred, DSC_VCRED);
  Gerador.wGrupo('/ICMS90');
end;

procedure TCTeW.GerarICMSOutraUF;
begin
  Gerador.wGrupo('ICMSOutraUF', '#267');
  Gerador.wCampo(tcStr, '#268', 'CST             ', 02, 02, 1, CSTICMSTOStr(CTe.Imp.ICMS.ICMSOutraUF.CST), DSC_CST);
  if CTe.Imp.ICMS.ICMSOutraUF.pRedBCOutraUF > 0 then
    Gerador.wCampo(tcDe2, '#269', 'pRedBCOutraUF ', 01, 05, 1, CTe.Imp.ICMS.ICMSOutraUF.pRedBCOutraUF, DSC_PREDBC);
  Gerador.wCampo(tcDe2, '#270', 'vBCOutraUF      ', 01, 15, 1, CTe.Imp.ICMS.ICMSOutraUF.vBCOutraUF, DSC_VBC);
  Gerador.wCampo(tcDe2, '#271', 'pICMSOutraUF    ', 01, 05, 1, CTe.Imp.ICMS.ICMSOutraUF.pICMSOutraUF, DSC_PICMS);
  Gerador.wCampo(tcDe2, '#272', 'vICMSOutraUF    ', 01, 15, 1, CTe.Imp.ICMS.ICMSOutraUF.vICMSOutraUF, DSC_VICMS);
  Gerador.wGrupo('/ICMSOutraUF');
end;

procedure TCTeW.GerarICMSSN;
begin
  Gerador.wGrupo('ICMSSN', '#273');
  Gerador.wCampo(tcInt, '#274', 'indSN ', 01, 01, 1, CTe.Imp.ICMS.ICMSSN.indSN, '');
  Gerador.wGrupo('/ICMSSN');
end;

procedure TCTeW.GerarInfCTeNorm;
begin
  if (CTe.Ide.tpCTe = tcNormal) or (CTe.Ide.tpCTe = tcSubstituto) then
  begin
    Gerador.wGrupo('infCTeNorm', 'K01');
    (**)GerarinfCarga;
    (**)GerarInfDoc;
    if CTe.infCTeNorm.docAnt.emiDocAnt.Count>0
     then (**)GerarDocAnt;
    (**)GerarInfSeg;

    case StrToInt(TpModalToStr(CTe.Ide.modal)) of
     01: Gerador.wGrupo('infModal versaoModal="' + CTeModalRodo + '"', '#312');
     02: Gerador.wGrupo('infModal versaoModal="' + CTeModalAereo + '"', '#312');
     03: Gerador.wGrupo('infModal versaoModal="' + CTeModalAqua + '"', '#312');
     04: Gerador.wGrupo('infModal versaoModal="' + CTeModalFerro + '"', '#312');
     05: Gerador.wGrupo('infModal versaoModal="' + CTeModalDuto + '"', '#312');
    end;
    case StrToInt(TpModalToStr(CTe.Ide.modal)) of
     01: (**)GerarRodo;       // Informações do Modal Rodoviário
     02: (**)GerarAereo;      // Informações do Modal Aéreo
     03: (**)GerarAquav;      // Informações do Modal Aquaviário
     04: (**)GerarFerrov;     // Informações do Modal Ferroviário
     05: (**)GerarDuto;       // Informações do Modal Dutoviário
     06: (**)GerarMultimodal; // Informações do Multimodal
    end;
    Gerador.wGrupo('/infModal');

    (**)GerarPeri; // Informações de produtos classificados pela ONU como Perigosos
    (**)GerarVeicNovos;
    (**)GerarCobr;
    (**)GerarInfCTeSub;

    Gerador.wGrupo('/infCTeNorm');
  end;
end;

procedure TCTeW.GerarinfCarga;
begin
  Gerador.wGrupo('infCarga', '#277');
  Gerador.wCampo(tcDe2, '#278', 'vCarga  ', 01, 15, 1, CTe.infCTeNorm.InfCarga.vCarga, DSC_VTMERC);
  Gerador.wCampo(tcStr, '#279', 'proPred ', 01, 60, 1, CTe.infCTeNorm.InfCarga.proPred, DSC_PRED);
  Gerador.wCampo(tcStr, '#280', 'xOutCat ', 01, 30, 0, CTe.infCTeNorm.InfCarga.xOutCat, DSC_OUTCAT);

  (**)GerarInfQ;

  Gerador.wGrupo('/infCarga');
end;

procedure TCTeW.GerarInfQ;
var
  i: integer;
begin
  for i := 0 to CTe.infCTeNorm.InfCarga.InfQ.Count - 1 do
  begin
    Gerador.wGrupo('infQ', '#281');
    Gerador.wCampo(tcStr, '#282', 'cUnid  ', 02, 02, 1, UnidMedToStr(CTe.infCTeNorm.InfCarga.InfQ[i].cUnid), DSC_CUNID);
    Gerador.wCampo(tcStr, '#283', 'tpMed  ', 01, 20, 1, CTe.infCTeNorm.InfCarga.InfQ[i].tpMed, DSC_TPMED);
    Gerador.wCampo(tcDe4, '#284', 'qCarga ', 01, 15, 1, CTe.infCTeNorm.InfCarga.InfQ[i].qCarga, DSC_QTD);

    Gerador.wGrupo('/infQ');
  end;

  if CTe.infCTeNorm.InfCarga.InfQ.Count > 990 then
    Gerador.wAlerta('#281', 'infQ', DSC_INFQ, ERR_MSG_MAIOR_MAXIMO + '990');
end;

procedure TCTeW.GerarinfDoc;
begin
  Gerador.wGrupo('infDoc', '#281');
  (**)GerarInfNF;
  (**)GerarInfNFe;
  (**)GerarInfOutros;
  Gerador.wGrupo('/infDoc');
end;

procedure TCTeW.GerarInfNF;
var
  i, j, k, l: integer;
begin
  for i := 0 to CTe.infCTeNorm.infDoc.infNF.Count - 1 do
  begin
    Gerador.wGrupo('infNF', '#131');
    Gerador.wCampo(tcStr, '#132', 'nRoma ', 01, 20, 0, CTe.infCTeNorm.infDoc.InfNF[i].nRoma, '');
    Gerador.wCampo(tcStr, '#133', 'nPed  ', 01, 20, 0, CTe.infCTeNorm.infDoc.InfNF[i].nPed, '');
    Gerador.wCampo(tcStr, '#134', 'mod   ', 02, 02, 1, ModeloNFToStr(CTe.infCTeNorm.infDoc.InfNF[i].modelo), '');
    Gerador.wCampo(tcStr, '#135', 'serie ', 01, 03, 1, CTe.infCTeNorm.infDoc.InfNF[i].serie, DSC_SERIE);
    Gerador.wCampo(tcEsp, '#136', 'nDoc  ', 01, 20, 1, SomenteNumeros(CTe.infCTeNorm.infDoc.InfNF[i].nDoc), DSC_NDOC);
    Gerador.wCampo(tcDat, '#137', 'dEmi  ', 10, 10, 1, CTe.infCTeNorm.infDoc.InfNF[i].dEmi, DSC_DEMI);
    Gerador.wCampo(tcDe2, '#138', 'vBC   ', 01, 15, 1, CTe.infCTeNorm.infDoc.InfNF[i].vBC, DSC_VBCICMS);
    Gerador.wCampo(tcDe2, '#139', 'vICMS ', 01, 15, 1, CTe.infCTeNorm.infDoc.InfNF[i].vICMS, DSC_VICMS);
    Gerador.wCampo(tcDe2, '#140', 'vBCST ', 01, 15, 1, CTe.infCTeNorm.infDoc.InfNF[i].vBCST, DSC_VBCST);
    Gerador.wCampo(tcDe2, '#141', 'vST   ', 01, 15, 1, CTe.infCTeNorm.infDoc.InfNF[i].vST, DSC_VST);
    Gerador.wCampo(tcDe2, '#142', 'vProd ', 01, 15, 1, CTe.infCTeNorm.infDoc.InfNF[i].vProd, DSC_VPROD);
    Gerador.wCampo(tcDe2, '#143', 'vNF   ', 01, 15, 1, CTe.infCTeNorm.infDoc.InfNF[i].vNF, DSC_VNF);
    Gerador.wCampo(tcInt, '#144', 'nCFOP ', 04, 04, 1, CTe.infCTeNorm.infDoc.InfNF[i].nCFOP, DSC_CFOP);
    Gerador.wCampo(tcDe3, '#145', 'nPeso ', 01, 15, 0, CTe.infCTeNorm.infDoc.InfNF[i].nPeso, DSC_PESO);
    Gerador.wCampo(tcStr, '#146', 'PIN   ', 02, 09, 0, CTe.infCTeNorm.infDoc.InfNF[i].PIN, DSC_ISUF);
    if (FOpcoes.ValidarInscricoes) and (CTe.infCTeNorm.infDoc.InfNF[i].PIN <> '') then
      if not ValidarISUF(CTe.infCTeNorm.infDoc.InfNF[i].PIN) then
        Gerador.wAlerta('#146', 'PIN', DSC_ISUF, ERR_MSG_INVALIDO);
    Gerador.wCampo(tcDat, '#278', 'dPrev ', 10, 10, 1, CTe.infCTeNorm.infDoc.InfNF[i].dPrev, '***');

    for j := 0 to CTe.infCTeNorm.infDoc.infNF[i].infUnidTransp.Count - 1 do
    begin
      Gerador.wGrupo('infUnidTransp', '#051');
      Gerador.wCampo(tcStr, '#052', 'tpUnidTransp', 01, 01, 1, UnidTranspToStr(CTe.infCTeNorm.infDoc.infNF[i].infUnidTransp[j].tpUnidTransp), '***');
      Gerador.wCampo(tcStr, '#053', 'idUnidTransp', 01, 20, 1, CTe.infCTeNorm.infDoc.infNF[i].infUnidTransp[j].idUnidTransp, '***');

      for k := 0 to CTe.infCTeNorm.infDoc.infNF[i].infUnidTransp[j].lacUnidTransp.Count - 1 do
      begin
        Gerador.wGrupo('lacUnidTransp', '#054');
        Gerador.wCampo(tcStr, '#055', 'nLacre', 01, 20, 1, CTe.infCTeNorm.infDoc.infNF[i].infUnidTransp[j].lacUnidTransp[k].nLacre, DSC_NLACRE);
        Gerador.wGrupo('/lacUnidTransp');
      end;

      for k := 0 to CTe.infCTeNorm.infDoc.infNF[i].infUnidTransp[j].infUnidCarga.Count - 1 do
      begin
        Gerador.wGrupo('infUnidCarga', '#056');
        Gerador.wCampo(tcStr, '#057', 'tpUnidCarga', 01, 01, 1, UnidCargaToStr(CTe.infCTeNorm.infDoc.infNF[i].infUnidTransp[j].infUnidCarga[k].tpUnidCarga), '***');
        Gerador.wCampo(tcStr, '#058', 'idUnidCarga', 01, 20, 1, CTe.infCTeNorm.infDoc.infNF[i].infUnidTransp[j].infUnidCarga[k].idUnidCarga, '***');

        for l := 0 to CTe.infCTeNorm.infDoc.infNF[i].infUnidTransp[j].infUnidCarga[k].lacUnidCarga.Count - 1 do
        begin
          Gerador.wGrupo('lacUnidCarga', '#059');
          Gerador.wCampo(tcStr, '#060', 'nLacre', 01, 20, 1, CTe.infCTeNorm.infDoc.infNF[i].infUnidTransp[j].infUnidCarga[k].lacUnidCarga[l].nLacre, DSC_NLACRE);
          Gerador.wGrupo('/lacUnidCarga');
        end;
        Gerador.wCampo(tcDe2, '#061', 'qtdRat', 01, 05, 0, CTe.infCTeNorm.infDoc.infNF[i].infUnidTransp[j].infUnidCarga[k].qtdRat, '***');

        Gerador.wGrupo('/infUnidCarga');
      end;
      Gerador.wCampo(tcDe2, '#062', 'qtdRat', 01, 05, 0, CTe.infCTeNorm.infDoc.infNF[i].infUnidTransp[j].qtdRat, '***');

      Gerador.wGrupo('/infUnidTransp');
    end;

    for j := 0 to CTe.infCTeNorm.infDoc.infNF[i].infUnidCarga.Count - 1 do
    begin
      Gerador.wGrupo('infUnidCarga', '#056');
      Gerador.wCampo(tcStr, '#057', 'tpUnidCarga', 01, 01, 1, UnidCargaToStr(CTe.infCTeNorm.infDoc.infNF[i].infUnidCarga[j].tpUnidCarga), '***');
      Gerador.wCampo(tcStr, '#058', 'idUnidCarga', 01, 20, 1, CTe.infCTeNorm.infDoc.infNF[i].infUnidCarga[j].idUnidCarga, '***');

      for k := 0 to CTe.infCTeNorm.infDoc.infNF[i].infUnidCarga[j].lacUnidCarga.Count - 1 do
      begin
        Gerador.wGrupo('lacUnidCarga', '#059');
        Gerador.wCampo(tcStr, '#060', 'nLacre', 01, 20, 1, CTe.infCTeNorm.infDoc.infNF[i].infUnidCarga[j].lacUnidCarga[k].nLacre, DSC_NLACRE);
        Gerador.wGrupo('/lacUnidCarga');
      end;
      Gerador.wCampo(tcDe2, '#061', 'qtdRat', 01, 05, 0, CTe.infCTeNorm.infDoc.infNF[i].infUnidCarga[j].qtdRat, '***');

      Gerador.wGrupo('/infUnidCarga');
    end;

    Gerador.wGrupo('/infNF');
  end;
  if CTe.infCTeNorm.infDoc.InfNF.Count > 990 then
    Gerador.wAlerta('#131', 'infNF', DSC_INFNF, ERR_MSG_MAIOR_MAXIMO + '990');
end;

procedure TCTeW.GerarInfNFe;
var
  i, j, k, l: integer;
begin
  for i := 0 to CTe.infCTeNorm.infDoc.InfNFe.Count - 1 do
  begin
    Gerador.wGrupo('infNFe', '#158');
    Gerador.wCampo(tcEsp, '#159', 'chave', 44, 44, 1, SomenteNumeros(CTe.infCTeNorm.infDoc.InfNFe[i].chave), DSC_REFNFE);
    if SomenteNumeros(CTe.infCTeNorm.infDoc.InfNFe[i].chave) <> '' then
     if not ValidarChave('NFe' + SomenteNumeros(CTe.infCTeNorm.infDoc.InfNFe[i].chave)) then
      Gerador.wAlerta('#159', 'chave', DSC_REFNFE, ERR_MSG_INVALIDO);
    Gerador.wCampo(tcStr, '#160', 'PIN   ', 02, 09, 0, CTe.infCTeNorm.infDoc.InfNFe[i].PIN, DSC_ISUF);
    if (FOpcoes.ValidarInscricoes) and (CTe.infCTeNorm.infDoc.InfNFe[i].PIN <> '') then
      if not ValidarISUF(CTe.infCTeNorm.infDoc.InfNFe[i].PIN) then
        Gerador.wAlerta('#160', 'PIN', DSC_ISUF, ERR_MSG_INVALIDO);
    Gerador.wCampo(tcDat, '#278', 'dPrev ', 10, 10, 1, CTe.infCTeNorm.infDoc.InfNFe[i].dPrev, '***');

    for j := 0 to CTe.infCTeNorm.infDoc.infNFe[i].infUnidTransp.Count - 1 do
    begin
      Gerador.wGrupo('infUnidTransp', '#051');
      Gerador.wCampo(tcStr, '#052', 'tpUnidTransp', 01, 01, 1, UnidTranspToStr(CTe.infCTeNorm.infDoc.infNFe[i].infUnidTransp[j].tpUnidTransp), '***');
      Gerador.wCampo(tcStr, '#053', 'idUnidTransp', 01, 20, 1, CTe.infCTeNorm.infDoc.infNFe[i].infUnidTransp[j].idUnidTransp, '***');

      for k := 0 to CTe.infCTeNorm.infDoc.infNFe[i].infUnidTransp[j].lacUnidTransp.Count - 1 do
      begin
        Gerador.wGrupo('lacUnidTransp', '#054');
        Gerador.wCampo(tcStr, '#055', 'nLacre', 01, 20, 1, CTe.infCTeNorm.infDoc.infNFe[i].infUnidTransp[j].lacUnidTransp[k].nLacre, DSC_NLACRE);
        Gerador.wGrupo('/lacUnidTransp');
      end;

      for k := 0 to CTe.infCTeNorm.infDoc.infNFe[i].infUnidTransp[j].infUnidCarga.Count - 1 do
      begin
        Gerador.wGrupo('infUnidCarga', '#056');
        Gerador.wCampo(tcStr, '#057', 'tpUnidCarga', 01, 01, 1, UnidCargaToStr(CTe.infCTeNorm.infDoc.infNFe[i].infUnidTransp[j].infUnidCarga[k].tpUnidCarga), '***');
        Gerador.wCampo(tcStr, '#058', 'idUnidCarga', 01, 20, 1, CTe.infCTeNorm.infDoc.infNFe[i].infUnidTransp[j].infUnidCarga[k].idUnidCarga, '***');

        for l := 0 to CTe.infCTeNorm.infDoc.infNFe[i].infUnidTransp[j].infUnidCarga[k].lacUnidCarga.Count - 1 do
        begin
          Gerador.wGrupo('lacUnidCarga', '#059');
          Gerador.wCampo(tcStr, '#060', 'nLacre', 01, 20, 1, CTe.infCTeNorm.infDoc.infNFe[i].infUnidTransp[j].infUnidCarga[k].lacUnidCarga[l].nLacre, DSC_NLACRE);
          Gerador.wGrupo('/lacUnidCarga');
        end;
        Gerador.wCampo(tcDe2, '#061', 'qtdRat', 01, 05, 0, CTe.infCTeNorm.infDoc.infNFe[i].infUnidTransp[j].infUnidCarga[k].qtdRat, '***');

        Gerador.wGrupo('/infUnidCarga');
      end;
      Gerador.wCampo(tcDe2, '#062', 'qtdRat', 01, 05, 0, CTe.infCTeNorm.infDoc.infNFe[i].infUnidTransp[j].qtdRat, '***');

      Gerador.wGrupo('/infUnidTransp');
    end;

    for j := 0 to CTe.infCTeNorm.infDoc.infNFe[i].infUnidCarga.Count - 1 do
    begin
      Gerador.wGrupo('infUnidCarga', '#056');
      Gerador.wCampo(tcStr, '#057', 'tpUnidCarga', 01, 01, 1, UnidCargaToStr(CTe.infCTeNorm.infDoc.infNFe[i].infUnidCarga[j].tpUnidCarga), '***');
      Gerador.wCampo(tcStr, '#058', 'idUnidCarga', 01, 20, 1, CTe.infCTeNorm.infDoc.infNFe[i].infUnidCarga[j].idUnidCarga, '***');

      for k := 0 to CTe.infCTeNorm.infDoc.infNFe[i].infUnidCarga[j].lacUnidCarga.Count - 1 do
      begin
        Gerador.wGrupo('lacUnidCarga', '#059');
        Gerador.wCampo(tcStr, '#060', 'nLacre', 01, 20, 1, CTe.infCTeNorm.infDoc.infNFe[i].infUnidCarga[j].lacUnidCarga[k].nLacre, DSC_NLACRE);
        Gerador.wGrupo('/lacUnidCarga');
      end;
      Gerador.wCampo(tcDe2, '#061', 'qtdRat', 01, 05, 0, CTe.infCTeNorm.infDoc.infNFe[i].infUnidCarga[j].qtdRat, '***');

      Gerador.wGrupo('/infUnidCarga');
    end;

    Gerador.wGrupo('/infNFe');
  end;
  if CTe.infCTeNorm.infDoc.InfNFe.Count > 990 then
    Gerador.wAlerta('#158', 'infNFe', DSC_INFNFE, ERR_MSG_MAIOR_MAXIMO + '990');
end;

procedure TCTeW.GerarInfOutros;
var
  i, j, k, l: integer;
begin
  for i := 0 to CTe.infCTeNorm.infDoc.InfOutros.Count - 1 do
  begin
    Gerador.wGrupo('infOutros', '#161');
    Gerador.wCampo(tcStr, '#162', 'tpDoc       ', 02, 02, 1, TpDocumentoToStr(CTe.infCTeNorm.infDoc.InfOutros[i].tpDoc), DSC_TPDOC);
    Gerador.wCampo(tcStr, '#163', 'descOutros  ', 01, 100, 0, CTe.infCTeNorm.infDoc.InfOutros[i].descOutros, DSC_OUTROS);
    Gerador.wCampo(tcStr, '#164', 'nDoc        ', 01, 20, 0, CTe.infCTeNorm.infDoc.InfOutros[i].nDoc, DSC_NRO);
    Gerador.wCampo(tcDat, '#165', 'dEmi        ', 10, 10, 1, CTe.infCTeNorm.infDoc.InfOutros[i].dEmi, DSC_DEMI);
    Gerador.wCampo(tcDe2, '#166', 'vDocFisc    ', 01, 15, 0, CTe.infCTeNorm.infDoc.InfOutros[i].vDocFisc, DSC_VDOC);
    Gerador.wCampo(tcDat, '#278', 'dPrev       ', 10, 10, 1, CTe.infCTeNorm.infDoc.infOutros[i].dPrev, '***');

    for j := 0 to CTe.infCTeNorm.infDoc.infOutros[i].infUnidTransp.Count - 1 do
    begin
      Gerador.wGrupo('infUnidTransp', '#051');
      Gerador.wCampo(tcStr, '#052', 'tpUnidTransp', 01, 01, 1, UnidTranspToStr(CTe.infCTeNorm.infDoc.infOutros[i].infUnidTransp[j].tpUnidTransp), '***');
      Gerador.wCampo(tcStr, '#053', 'idUnidTransp', 01, 20, 1, CTe.infCTeNorm.infDoc.infOutros[i].infUnidTransp[j].idUnidTransp, '***');

      for k := 0 to CTe.infCTeNorm.infDoc.infOutros[i].infUnidTransp[j].lacUnidTransp.Count - 1 do
      begin
        Gerador.wGrupo('lacUnidTransp', '#054');
        Gerador.wCampo(tcStr, '#055', 'nLacre', 01, 20, 1, CTe.infCTeNorm.infDoc.infOutros[i].infUnidTransp[j].lacUnidTransp[k].nLacre, DSC_NLACRE);
        Gerador.wGrupo('/lacUnidTransp');
      end;

      for k := 0 to CTe.infCTeNorm.infDoc.infOutros[i].infUnidTransp[j].infUnidCarga.Count - 1 do
      begin
        Gerador.wGrupo('infUnidCarga', '#056');
        Gerador.wCampo(tcStr, '#057', 'tpUnidCarga', 01, 01, 1, UnidCargaToStr(CTe.infCTeNorm.infDoc.infOutros[i].infUnidTransp[j].infUnidCarga[k].tpUnidCarga), '***');
        Gerador.wCampo(tcStr, '#058', 'idUnidCarga', 01, 20, 1, CTe.infCTeNorm.infDoc.infOutros[i].infUnidTransp[j].infUnidCarga[k].idUnidCarga, '***');

        for l := 0 to CTe.infCTeNorm.infDoc.infOutros[i].infUnidTransp[j].infUnidCarga[k].lacUnidCarga.Count - 1 do
        begin
          Gerador.wGrupo('lacUnidCarga', '#059');
          Gerador.wCampo(tcStr, '#060', 'nLacre', 01, 20, 1, CTe.infCTeNorm.infDoc.infOutros[i].infUnidTransp[j].infUnidCarga[k].lacUnidCarga[l].nLacre, DSC_NLACRE);
          Gerador.wGrupo('/lacUnidCarga');
        end;
        Gerador.wCampo(tcDe2, '#061', 'qtdRat', 01, 05, 0, CTe.infCTeNorm.infDoc.infOutros[i].infUnidTransp[j].infUnidCarga[k].qtdRat, '***');

        Gerador.wGrupo('/infUnidCarga');
      end;
      Gerador.wCampo(tcDe2, '#062', 'qtdRat', 01, 05, 0, CTe.infCTeNorm.infDoc.infOutros[i].infUnidTransp[j].qtdRat, '***');

      Gerador.wGrupo('/infUnidTransp');
    end;

    for j := 0 to CTe.infCTeNorm.infDoc.InfOutros[i].infUnidCarga.Count - 1 do
    begin
      Gerador.wGrupo('infUnidCarga', '#056');
      Gerador.wCampo(tcStr, '#057', 'tpUnidCarga', 01, 01, 1, UnidCargaToStr(CTe.infCTeNorm.infDoc.InfOutros[i].infUnidCarga[j].tpUnidCarga), '***');
      Gerador.wCampo(tcStr, '#058', 'idUnidCarga', 01, 20, 1, CTe.infCTeNorm.infDoc.InfOutros[i].infUnidCarga[j].idUnidCarga, '***');

      for k := 0 to CTe.infCTeNorm.infDoc.InfOutros[i].infUnidCarga[j].lacUnidCarga.Count - 1 do
      begin
        Gerador.wGrupo('lacUnidCarga', '#059');
        Gerador.wCampo(tcStr, '#060', 'nLacre', 01, 20, 1, CTe.infCTeNorm.infDoc.InfOutros[i].infUnidCarga[j].lacUnidCarga[k].nLacre, DSC_NLACRE);
        Gerador.wGrupo('/lacUnidCarga');
      end;
      Gerador.wCampo(tcDe2, '#061', 'qtdRat', 01, 05, 0, CTe.infCTeNorm.infDoc.InfOutros[i].infUnidCarga[j].qtdRat, '***');

      Gerador.wGrupo('/infUnidCarga');
    end;

    Gerador.wGrupo('/infOutros');
  end;
  if CTe.infCTeNorm.infDoc.InfOutros.Count > 990 then
    Gerador.wAlerta('#161', 'infOutros', DSC_INFOUTRO, ERR_MSG_MAIOR_MAXIMO + '990');
end;

procedure TCTeW.GerarDocAnt;
var
  i, i01, i02: integer;
begin
  Gerador.wGrupo('docAnt', '#290');

  for i := 0 to CTe.infCTeNorm.docAnt.emiDocAnt.Count - 1 do
  begin
    Gerador.wGrupo('emiDocAnt', '#291');
    Gerador.wCampoCNPJCPF('#292', '#293', CTe.infCTeNorm.docAnt.emiDocAnt[i].CNPJCPF, CODIGO_BRASIL);

    if Trim(CTe.infCTeNorm.docAnt.emiDocAnt[i].IE) = 'ISENTO'
     then Gerador.wCampo(tcStr, '#294', 'IE ', 00, 14, 1, CTe.infCTeNorm.docAnt.emiDocAnt[i].IE, DSC_IE)
     else Gerador.wCampo(tcStr, '#294', 'IE ', 02, 14, 1, SomenteNumeros(CTe.infCTeNorm.docAnt.emiDocAnt[i].IE), DSC_IE);

    if (FOpcoes.ValidarInscricoes)
     then if not ValidarIE(CTe.infCTeNorm.docAnt.emiDocAnt[i].IE, CTe.infCTeNorm.docAnt.emiDocAnt[i].UF) then
      Gerador.wAlerta('#294', 'IE', DSC_IE, ERR_MSG_INVALIDO);

    Gerador.wCampo(tcStr, '#295', 'UF    ', 02, 02, 1, CTe.infCTeNorm.docAnt.emiDocAnt[i].UF, '');
    if not ValidarUF(CTe.infCTeNorm.docAnt.emiDocAnt[i].UF) then
      Gerador.wAlerta('#295', 'UF', DSC_UF, ERR_MSG_INVALIDO);
    Gerador.wCampo(tcStr, '#296', 'xNome ', 01, 60, 1, CTe.infCTeNorm.docAnt.emiDocAnt[i].xNome, '');

    for i01 := 0 to CTe.infCTeNorm.docAnt.emiDocAnt[i].idDocAnt.Count - 1 do
    begin
      Gerador.wGrupo('idDocAnt', '#297');

      for i02 := 0 to CTe.infCTeNorm.docAnt.emiDocAnt[i].idDocAnt[i01].idDocAntPap.Count - 1 do
      begin
        Gerador.wGrupo('idDocAntPap', '#298');
        Gerador.wCampo(tcStr, '#299', 'tpDoc  ', 02, 02, 1, TpDocumentoAnteriorToStr(CTe.infCTeNorm.docAnt.emiDocAnt[i].idDocAnt[i01].idDocAntPap[i02].tpDoc), '');
        Gerador.wCampo(tcStr, '#300', 'serie  ', 01, 03, 1, CTe.infCTeNorm.docAnt.emiDocAnt[i].idDocAnt[i01].idDocAntPap[i02].serie, '');
        Gerador.wCampo(tcStr, '#301', 'subser ', 01, 02, 0, CTe.infCTeNorm.docAnt.emiDocAnt[i].idDocAnt[i01].idDocAntPap[i02].subser, '');
        Gerador.wCampo(tcInt, '#302', 'nDoc   ', 01, 20, 1, CTe.infCTeNorm.docAnt.emiDocAnt[i].idDocAnt[i01].idDocAntPap[i02].nDoc, '');
        Gerador.wCampo(tcDat, '#303', 'dEmi   ', 10, 10, 1, CTe.infCTeNorm.docAnt.emiDocAnt[i].idDocAnt[i01].idDocAntPap[i02].dEmi, '');
        Gerador.wGrupo('/idDocAntPap');
      end;
      if CTe.infCTeNorm.docAnt.emiDocAnt[i].idDocAnt[i01].idDocAntPap.Count > 990 then
        Gerador.wAlerta('#298', 'idDocAntPap', '', ERR_MSG_MAIOR_MAXIMO + '990');

      for i02 := 0 to CTe.infCTeNorm.docAnt.emiDocAnt[i].idDocAnt[i01].idDocAntEle.Count - 1 do
      begin
        Gerador.wGrupo('idDocAntEle', '#304');
        Gerador.wCampo(tcStr, '#305', 'chave ', 44, 44, 1, SomenteNumeros(CTe.infCTeNorm.docAnt.emiDocAnt[i].idDocAnt[i01].idDocAntEle[i02].chave), '');
        if SomenteNumeros(CTe.infCTeNorm.docAnt.emiDocAnt[i].idDocAnt[i01].idDocAntEle[i02].chave) <> '' then
         if not ValidarChave('NFe' + SomenteNumeros(CTe.infCTeNorm.docAnt.emiDocAnt[i].idDocAnt[i01].idDocAntEle[i02].chave)) then
          Gerador.wAlerta('#305', 'chave', DSC_REFCTE, ERR_MSG_INVALIDO);
        Gerador.wGrupo('/idDocAntEle');
      end;
      if CTe.infCTeNorm.docAnt.emiDocAnt[i].idDocAnt[i01].idDocAntEle.Count > 990 then
        Gerador.wAlerta('#304', 'idDocAntEle', '', ERR_MSG_MAIOR_MAXIMO + '990');

      Gerador.wGrupo('/idDocAnt');
    end;
    if CTe.infCTeNorm.docAnt.emiDocAnt[i].idDocAnt.Count > 2 then
      Gerador.wAlerta('#297', 'idDocAnt', '', ERR_MSG_MAIOR_MAXIMO + '02');

    Gerador.wGrupo('/emiDocAnt');
  end;
  if CTe.infCTeNorm.docAnt.emiDocAnt.Count > 990 then
    Gerador.wAlerta('#291', 'emiDocAnt', '', ERR_MSG_MAIOR_MAXIMO + '990');

  Gerador.wGrupo('/docAnt');
end;

procedure TCTeW.GerarInfSeg;
var
  i: integer;
begin
  for i := 0 to CTe.infCTeNorm.seg.Count - 1 do
  begin
    Gerador.wGrupo('seg', '#306');
    Gerador.wCampo(tcStr, '#307', 'respSeg ', 01, 01, 1, TpRspSeguroToStr(CTe.infCTeNorm.seg[i].respSeg), DSC_RESPSEG);
    Gerador.wCampo(tcStr, '#308', 'xSeg    ', 01, 30, 0, CTe.infCTeNorm.seg[i].xSeg, DSC_XSEG);
    Gerador.wCampo(tcStr, '#309', 'nApol   ', 01, 20, 0, CTe.infCTeNorm.seg[i].nApol, DSC_NAPOL);
    Gerador.wCampo(tcStr, '#310', 'nAver   ', 01, 20, 0, CTe.infCTeNorm.seg[i].nAver, DSC_NAVER);
    Gerador.wCampo(tcDe2, '#311', 'vCarga  ', 01, 15, 0, CTe.infCTeNorm.seg[i].vCarga, DSC_VMERC);
    Gerador.wGrupo('/seg');
  end;
  if CTe.infCTeNorm.seg.Count > 990 then
    Gerador.wAlerta('#306', 'seg', DSC_INFSEG, ERR_MSG_MAIOR_MAXIMO + '990');
end;

procedure TCTeW.GerarRodo;
begin
  Gerador.wGrupo('rodo', '#01');
  Gerador.wCampo(tcStr, '#02', 'RNTRC ', 08, 08, 1, SomenteNumeros(CTe.infCTeNorm.rodo.RNTRC), DSC_RNTRC);
  Gerador.wCampo(tcDat, '#03', 'dPrev ', 10, 10, 1, CTe.infCTeNorm.rodo.dPrev, DSC_DPREV);
  Gerador.wCampo(tcStr, '#04', 'lota  ', 01, 01, 1, TpLotacaoToStr(CTe.infCTeNorm.rodo.Lota), DSC_LOTA);
  Gerador.wCampo(tcStr, '#05', 'CIOT  ', 12, 12, 0, CTe.infCTeNorm.rodo.CIOT, '');

  (**)GerarOCC;

  if CTe.infCTeNorm.rodo.Lota = ltSim
   then begin
    (**)GerarValePed;
    (**)GerarVeic;
   end;
  (**)GerarLacre;

  if CTe.infCTeNorm.rodo.Lota = ltSim then
   (**)GerarMoto;

  Gerador.wGrupo('/rodo');
end;

procedure TCTeW.GerarOCC;
var
 i: Integer;
begin
  for i := 0 to CTe.infCTeNorm.rodo.occ.Count - 1 do
  begin
    Gerador.wGrupo('occ', '#06');
    Gerador.wCampo(tcStr, '#07', 'serie ', 01, 03, 0, CTe.infCTeNorm.rodo.occ[i].serie, '');
    Gerador.wCampo(tcInt, '#08', 'nOcc  ', 01, 06, 1, CTe.infCTeNorm.rodo.occ[i].nOcc, '');
    Gerador.wCampo(tcDat, '#09', 'dEmi  ', 10, 10, 1, CTe.infCTeNorm.rodo.occ[i].dEmi, '');

    Gerador.wGrupo('emiOcc', '#10');
    Gerador.wCampoCNPJ('#11', CTe.infCTeNorm.rodo.occ[i].emiOcc.CNPJ, CODIGO_BRASIL, True);
    Gerador.wCampo(tcStr, '#12', 'cInt   ', 01, 10, 0, CTe.infCTeNorm.rodo.occ[i].emiOcc.cInt, DSC_CINT);

    Gerador.wCampo(tcStr, '#13', 'IE ', 02, 14, 1, SomenteNumeros(CTe.infCTeNorm.rodo.occ[i].emiOcc.IE), DSC_IE);

    if (FOpcoes.ValidarInscricoes)
     then if not ValidarIE(CTe.infCTeNorm.rodo.occ[i].emiOcc.IE, CTe.infCTeNorm.rodo.occ[i].emiOcc.UF) then
      Gerador.wAlerta('#13', 'IE', DSC_IE, ERR_MSG_INVALIDO);

    Gerador.wCampo(tcStr, '#14', 'UF   ', 02, 02, 1, CTe.infCTeNorm.rodo.occ[i].emiOcc.UF, DSC_CUF);
    if not ValidarUF(CTe.infCTeNorm.rodo.occ[i].emiOcc.UF) then
      Gerador.wAlerta('#14', 'UF', DSC_UF, ERR_MSG_INVALIDO);
    Gerador.wCampo(tcStr, '#15', 'fone ', 07, 12, 0, somenteNumeros(CTe.infCTeNorm.rodo.occ[i].emiOcc.fone), DSC_FONE);
    Gerador.wGrupo('/emiOcc');

    Gerador.wGrupo('/occ');
  end;
  if CTe.infCTeNorm.rodo.occ.Count > 10 then
    Gerador.wAlerta('#06', 'occ', '', ERR_MSG_MAIOR_MAXIMO + '10');
end;

procedure TCTeW.GerarValePed;
var
 i: Integer;
begin
  for i := 0 to CTe.infCTeNorm.rodo.valePed.Count - 1 do
  begin
    Gerador.wGrupo('valePed', '#16');
    Gerador.wCampo(tcStr, '#17', 'CNPJForn ', 14, 14, 1, CTe.infCTeNorm.rodo.valePed[i].CNPJForn, '');
    Gerador.wCampo(tcStr, '#18', 'nCompra  ', 01, 20, 1, CTe.infCTeNorm.rodo.valePed[i].nCompra, '');
    Gerador.wCampo(tcStr, '#19', 'CNPJPg   ', 14, 14, 0, CTe.infCTeNorm.rodo.valePed[i].CNPJPg, '');
    Gerador.wCampo(tcDe2, '#20', 'vValePed ', 01, 15, 1, CTe.infCTeNorm.rodo.valePed[i].vValePed, '');
    Gerador.wGrupo('/valePed');
  end;
  if CTe.infCTeNorm.rodo.valePed.Count > 990 then
    Gerador.wAlerta('#16', 'valePed', '', ERR_MSG_MAIOR_MAXIMO + '990');
end;

procedure TCTeW.GerarVeic;
var
  i: integer;
begin
  for i := 0 to CTe.infCTeNorm.rodo.veic.Count - 1 do
  begin
    Gerador.wGrupo('veic', '#20');
    Gerador.wCampo(tcStr, '#21', 'cInt    ', 01, 10, 0, CTe.infCTeNorm.rodo.veic[i].cInt, '');
    Gerador.wCampo(tcStr, '#22', 'RENAVAM ', 09, 11, 1, CTe.infCTeNorm.rodo.veic[i].RENAVAM, '');
    Gerador.wCampo(tcStr, '#23', 'placa   ', 01, 07, 1, CTe.infCTeNorm.rodo.veic[i].placa, '');
    Gerador.wCampo(tcInt, '#24', 'tara    ', 01, 06, 1, CTe.infCTeNorm.rodo.veic[i].tara, '');
    Gerador.wCampo(tcInt, '#25', 'capKG   ', 01, 06, 1, CTe.infCTeNorm.rodo.veic[i].capKG, '');
    Gerador.wCampo(tcInt, '#26', 'capM3   ', 01, 03, 1, CTe.infCTeNorm.rodo.veic[i].capM3, '');
    Gerador.wCampo(tcStr, '#27', 'tpProp  ', 01, 01, 1, TpPropriedadeToStr(CTe.infCTeNorm.rodo.veic[i].tpProp), '');
    Gerador.wCampo(tcStr, '#28', 'tpVeic  ', 01, 01, 1, TpVeiculoToStr(CTe.infCTeNorm.rodo.veic[i].tpVeic), '');
    Gerador.wCampo(tcStr, '#29', 'tpRod   ', 02, 02, 1, TpRodadoToStr(CTe.infCTeNorm.rodo.veic[i].tpRod), '');
    Gerador.wCampo(tcStr, '#30', 'tpCar   ', 02, 02, 1, TpCarroceriaToStr(CTe.infCTeNorm.rodo.veic[i].tpCar), '');
    Gerador.wCampo(tcStr, '#31', 'UF      ', 02, 02, 1, CTe.infCTeNorm.rodo.veic[i].UF, DSC_CUF);
    if not ValidarUF(CTe.infCTeNorm.rodo.veic[i].UF) then
      Gerador.wAlerta('#31', 'UF', DSC_UF, ERR_MSG_INVALIDO);

    if (CTe.infCTeNorm.rodo.veic[i].prop.CNPJCPF <> '') or
       (CTe.infCTeNorm.rodo.veic[i].prop.RNTRC <> '') or
       (CTe.infCTeNorm.rodo.veic[i].prop.xNome <> '') then
    begin
      Gerador.wGrupo('prop', '#32');
      Gerador.wCampoCNPJCPF('#33', '#34', CTe.infCTeNorm.rodo.veic[i].prop.CNPJCPF, CODIGO_BRASIL);
      Gerador.wCampo(tcStr, '#35', 'RNTRC ', 08, 08, 1, SomenteNumeros(CTe.infCTeNorm.rodo.veic[i].prop.RNTRC), DSC_RNTRC);
      Gerador.wCampo(tcStr, '#36', 'xNome ', 01, 60, 1, CTe.infCTeNorm.rodo.veic[i].prop.xNome, DSC_XNOME);

      if CTe.infCTeNorm.rodo.veic[i].prop.IE <> ''
       then begin
        if CTe.infCTeNorm.rodo.veic[i].prop.IE = 'ISENTO'
         then Gerador.wCampo(tcStr, '#37', 'IE ', 00, 14, 1, CTe.infCTeNorm.rodo.veic[i].prop.IE, DSC_IE)
         else Gerador.wCampo(tcStr, '#37', 'IE ', 02, 14, 1, SomenteNumeros(CTe.infCTeNorm.rodo.veic[i].prop.IE), DSC_IE);
        if (FOpcoes.ValidarInscricoes)
         then if not ValidarIE(CTe.infCTeNorm.rodo.veic[i].prop.IE, CTe.infCTeNorm.rodo.veic[i].prop.UF) then
          Gerador.wAlerta('#37', 'IE', DSC_IE, ERR_MSG_INVALIDO);
       end;

      Gerador.wCampo(tcStr, '#38', 'UF     ', 02, 02, 1, CTe.infCTeNorm.rodo.veic[i].prop.UF, DSC_CUF);
      if not ValidarUF(CTe.infCTeNorm.rodo.veic[i].prop.UF) then
       Gerador.wAlerta('#38', 'UF', DSC_UF, ERR_MSG_INVALIDO);
      Gerador.wCampo(tcStr, '#39', 'tpProp ', 01, 01, 1, TpPropToStr(CTe.infCTeNorm.rodo.veic[i].prop.tpProp), DSC_TPPROP);
      Gerador.wGrupo('/prop');
    end;

    Gerador.wGrupo('/veic');
  end;
  if CTe.infCTeNorm.rodo.veic.Count > 4 then
    Gerador.wAlerta('#20', 'veic', '', ERR_MSG_MAIOR_MAXIMO + '4');
end;

procedure TCTeW.GerarLacre;
var
  i: integer;
begin
  for i := 0 to CTe.infCTeNorm.rodo.lacRodo.Count - 1 do
  begin
    Gerador.wGrupo('lacRodo', '#40');
    Gerador.wCampo(tcStr, '#41', 'nLacre ', 01, 20, 1, CTe.infCTeNorm.rodo.lacRodo[i].nLacre, DSC_NLACRE);
    Gerador.wGrupo('/lacRodo');
  end;
  if CTe.infCTeNorm.rodo.lacRodo.Count > 990 then
    Gerador.wAlerta('#40', 'lacRodo', DSC_LACR, ERR_MSG_MAIOR_MAXIMO + '990');
end;

procedure TCTeW.GerarMoto;
var
  i: integer;
begin
  for i := 0 to CTe.infCTeNorm.rodo.moto.Count - 1 do
  begin
    Gerador.wGrupo('moto', '#42');
    Gerador.wCampo(tcStr, '#43', 'xNome ', 01, 60, 1, CTe.infCTeNorm.rodo.moto[i].xNome, '');
    Gerador.wCampo(tcStr, '#44', 'CPF   ', 11, 11, 1, CTe.infCTeNorm.rodo.moto[i].CPF, '');
    Gerador.wGrupo('/moto');
  end;
  if CTe.infCTeNorm.rodo.moto.Count > 990 then
    Gerador.wAlerta('#42', 'moto', DSC_LACR, ERR_MSG_MAIOR_MAXIMO + '990');
end;

procedure TCTeW.GerarAereo;  // M
begin
  Gerador.wGrupo('aereo', '#01');
  Gerador.wCampo(tcInt, '#02', 'nMinu     ', 09, 09, 0, CTe.infCTeNorm.aereo.nMinu, '');
  Gerador.wCampo(tcStr, '#03', 'nOCA      ', 14, 14, 0, CTe.infCTeNorm.aereo.nOCA, '');
  Gerador.wCampo(tcDat, '#04', 'dPrevAereo', 10, 10, 0, CTe.infCTeNorm.aereo.dPrevAereo, '');
  Gerador.wCampo(tcStr, '#05', 'xLAgEmi   ', 01, 20, 0, CTe.infCTeNorm.aereo.xLAgEmi, '');
  Gerador.wCampo(tcStr, '#06', 'IdT       ', 01, 14, 0, CTe.infCTeNorm.aereo.IdT, '');

  Gerador.wGrupo('tarifa', '#07');
  Gerador.wCampo(tcStr, '#08', 'CL     ', 01, 02, 0, CTe.infCTeNorm.aereo.tarifa.CL, '');
  Gerador.wCampo(tcStr, '#09', 'cTar   ', 01, 04, 0, CTe.infCTeNorm.aereo.tarifa.cTar, '');
  Gerador.wCampo(tcDe2, '#10', 'vTar   ', 01, 15, 0, CTe.infCTeNorm.aereo.tarifa.vTar, '');
  Gerador.wGrupo('/tarifa');

  if (CTe.infCTeNorm.aereo.natCarga.xDime<>'') or (CTe.infCTeNorm.aereo.natCarga.cinfManu<>0) or
     (CTe.infCTeNorm.aereo.natCarga.cImp<>'')
   then begin
    Gerador.wGrupo('natCarga', '#11');
    Gerador.wCampo(tcStr, '#12', 'xDime   ', 05, 14, 0, CTe.infCTeNorm.aereo.natCarga.xDime, '');
    Gerador.wCampo(tcInt, '#13', 'cInfManu', 02, 02, 0, CTe.infCTeNorm.aereo.natCarga.cinfManu, '');
    Gerador.wCampo(tcStr, '#14', 'cIMP    ', 03, 03, 0, CTe.infCTeNorm.aereo.natCarga.cIMP, '');
    Gerador.wGrupo('/natCarga');
   end;

  Gerador.wGrupo('/aereo');
end;

procedure TCTeW.GerarAquav;  // N
var
 i: Integer;
begin
  Gerador.wGrupo('aquav', '#01');
  Gerador.wCampo(tcDe2, '#02', 'vPrest   ', 01, 15, 1, CTe.infCTeNorm.aquav.vPrest, '');
  Gerador.wCampo(tcDe2, '#03', 'vAFRMM   ', 01, 15, 1, CTe.infCTeNorm.aquav.vAFRMM, '');
  Gerador.wCampo(tcStr, '#04', 'nBooking ', 01, 10, 0, CTe.infCTeNorm.aquav.nBooking, '');
  Gerador.wCampo(tcStr, '#05', 'nCtrl    ', 01, 10, 0, CTe.infCTeNorm.aquav.nCtrl, '');
  Gerador.wCampo(tcStr, '#06', 'xNavio   ', 01, 60, 1, CTe.infCTeNorm.aquav.xNavio, '');

  for i := 0 to CTe.infCTeNorm.aquav.balsa.Count - 1 do
   begin
    Gerador.wGrupo('balsa', '#07');
    Gerador.wCampo(tcStr, '#08', 'xBalsa ', 01, 60, 1, CTe.infCTeNorm.aquav.balsa.Items[i].xBalsa, '');
    Gerador.wGrupo('/balsa');
   end;
  if CTe.infCTeNorm.aquav.balsa.Count > 3 then
   Gerador.wAlerta('#07', 'balsa', '', ERR_MSG_MAIOR_MAXIMO + '3');

  Gerador.wCampo(tcStr, '#09', 'nViag    ', 01, 10, 0, CTe.infCTeNorm.aquav.nViag, '');
  Gerador.wCampo(tcStr, '#10', 'direc    ', 01, 01, 1, TpDirecaoToStr(CTe.infCTeNorm.aquav.direc), '');
  Gerador.wCampo(tcStr, '#11', 'prtEmb   ', 01, 60, 0, CTe.infCTeNorm.aquav.prtEmb, '');
  Gerador.wCampo(tcStr, '#12', 'prtTrans ', 01, 60, 0, CTe.infCTeNorm.aquav.prtTrans, '');
  Gerador.wCampo(tcStr, '#13', 'prtDest  ', 01, 60, 0, CTe.infCTeNorm.aquav.prtDest, '');
  Gerador.wCampo(tcStr, '#14', 'tpNav    ', 01, 01, 1, TpNavegacaoToStr(CTe.infCTeNorm.aquav.tpNav), '');
  Gerador.wCampo(tcStr, '#15', 'irin     ', 01, 10, 1, CTe.infCTeNorm.aquav.irin, '');

  Gerador.wGrupo('/aquav');
end;

procedure TCTeW.GerarFerrov;  // O
begin
  Gerador.wGrupo('ferrov', '#01');
  Gerador.wCampo(tcStr, '#02', 'tpTraf ', 01, 01, 1, TpTrafegoToStr(CTe.infCTeNorm.ferrov.tpTraf), '');
  Gerador.wGrupo('trafMut', '#03');
  Gerador.wCampo(tcStr, '#04', 'respFat ', 01, 01, 1, TrafegoMutuoToStr(CTe.infCTeNorm.ferrov.trafMut.respFat), '');
  Gerador.wCampo(tcStr, '#05', 'ferrEmi ', 01, 01, 1, TrafegoMutuoToStr(CTe.infCTeNorm.ferrov.trafMut.ferrEmi), '');
  Gerador.wGrupo('/trafMut');
  Gerador.wCampo(tcStr, '#06', 'fluxo  ', 01, 10, 1, CTe.infCTeNorm.ferrov.fluxo, '');
  Gerador.wCampo(tcStr, '#07', 'idTrem ', 01, 07, 0, CTe.infCTeNorm.ferrov.idTrem, '');
  Gerador.wCampo(tcDe2, '#08', 'vFrete ', 01, 15, 1, CTe.infCTeNorm.ferrov.vFrete, '');
  (**) GerarFerroEnv;
  (**) GerardetVag;
  Gerador.wGrupo('/ferrov');
end;

procedure TCTeW.GerarFerroEnv;
var
 i, cMun: integer;
 xMun, xUF: string;
begin
  for i := 0 to CTe.infCTeNorm.ferrov.ferroEnv.Count - 1 do
   begin
    if (CTe.infCTeNorm.ferrov.ferroEnv[i].CNPJ <> '') or
       (CTe.infCTeNorm.ferrov.ferroEnv[i].xNome <> '') then
    begin
      Gerador.wGrupo('ferroEnv', '#09');
      Gerador.wCampoCNPJ('#10', CTe.infCTeNorm.ferrov.ferroEnv[i].CNPJ, CODIGO_BRASIL, True);
      Gerador.wCampo(tcStr, '#11', 'cInt ', 01, 10, 0, CTe.infCTeNorm.ferrov.ferroEnv[i].cInt, '');

      if CTe.infCTeNorm.ferrov.ferroEnv[i].IE <> ''
       then begin
        Gerador.wCampo(tcStr, '#12', 'IE ', 02, 14, 1, SomenteNumeros(CTe.infCTeNorm.ferrov.ferroEnv[i].IE), DSC_IE);

        if (FOpcoes.ValidarInscricoes)
         then if not ValidarIE(CTe.infCTeNorm.ferrov.ferroEnv[i].IE, CTe.infCTeNorm.ferrov.ferroEnv[i].enderFerro.UF) then
          Gerador.wAlerta('#12', 'IE', DSC_IE, ERR_MSG_INVALIDO);
       end;

      Gerador.wCampo(tcStr, '#13', 'xNome ', 01, 60, 1, CTe.infCTeNorm.ferrov.ferroEnv[i].xNome, DSC_XNOME);

      AjustarMunicipioUF(xUF, xMun, cMun, CODIGO_BRASIL,
                                          CTe.infCTeNorm.ferrov.ferroEnv[i].EnderFerro.UF,
                                          CTe.infCTeNorm.ferrov.ferroEnv[i].EnderFerro.xMun,
                                          CTe.infCTeNorm.ferrov.ferroEnv[i].EnderFerro.cMun);
      Gerador.wGrupo('enderFerro', '#14');
      Gerador.wCampo(tcStr, '#15', 'xLgr    ', 01, 255, 1, CTe.infCTeNorm.ferrov.ferroEnv[i].EnderFerro.xLgr, DSC_XLGR);
      Gerador.wCampo(tcStr, '#16', 'nro     ', 01, 60, 0, ExecutarAjusteTagNro(FOpcoes.FAjustarTagNro, CTe.infCTeNorm.ferrov.ferroEnv[i].EnderFerro.nro), DSC_NRO);
      Gerador.wCampo(tcStr, '#17', 'xCpl    ', 01, 60, 0, CTe.infCTeNorm.ferrov.ferroEnv[i].EnderFerro.xCpl, DSC_XCPL);
      Gerador.wCampo(tcStr, '#18', 'xBairro ', 01, 60, 0, CTe.infCTeNorm.ferrov.ferroEnv[i].EnderFerro.xBairro, DSC_XBAIRRO);
      Gerador.wCampo(tcInt, '#19', 'cMun    ', 07, 07, 1, cMun, DSC_CMUN);
      if not ValidarMunicipio(CTe.infCTeNorm.ferrov.ferroEnv[i].EnderFerro.cMun) then
        Gerador.wAlerta('#19', 'cMun', DSC_CMUN, ERR_MSG_INVALIDO);
      Gerador.wCampo(tcStr, '#20', 'xMun    ', 01, 60, 1, xMun, DSC_XMUN);
      Gerador.wCampo(tcInt, '#21', 'CEP     ', 08, 08, 0, CTe.infCTeNorm.ferrov.ferroEnv[i].EnderFerro.CEP, DSC_CEP);
      Gerador.wCampo(tcStr, '#22', 'UF      ', 02, 02, 1, xUF, DSC_UF);
      if not ValidarUF(xUF) then
        Gerador.wAlerta('#22', 'UF', DSC_UF, ERR_MSG_INVALIDO);
      Gerador.wGrupo('/enderFerro');

      Gerador.wGrupo('/ferroSub');
    end;

   end;
end;

procedure TCTeW.GerardetVag;
var
 i: Integer;
begin
  for i := 0 to CTe.infCTeNorm.ferrov.detVag.Count - 1 do
   begin
    Gerador.wGrupo('detVag', '#23');
    Gerador.wCampo(tcInt, '#24', 'nVag   ', 08, 08, 1, CTe.infCTeNorm.ferrov.detVag.Items[i].nVag, '');
    Gerador.wCampo(tcDe2, '#25', 'cap    ', 01, 05, 0, CTe.infCTeNorm.ferrov.detVag.Items[i].cap, '');
    Gerador.wCampo(tcStr, '#26', 'tpVag  ', 03, 03, 0, CTe.infCTeNorm.ferrov.detVag.Items[i].tpVag, '');
    Gerador.wCampo(tcDe2, '#27', 'pesoR  ', 01, 05, 1, CTe.infCTeNorm.ferrov.detVag.Items[i].pesoR, '');
    Gerador.wCampo(tcDe2, '#28', 'pesoBC ', 01, 05, 1, CTe.infCTeNorm.ferrov.detVag.Items[i].pesoBC, '');
   end;

  if CTe.infCTeNorm.ferrov.detVag.Count > 990 then
   Gerador.wAlerta('#23', 'detVag', '', ERR_MSG_MAIOR_MAXIMO + '990');
end;

procedure TCTeW.GerarDuto;  // P
begin
  Gerador.wGrupo('duto', '#01');
  Gerador.wCampo(tcDe6, '#02', 'vTar ', 01, 15, 0, CTe.infCTeNorm.duto.vTar, '');
  Gerador.wCampo(tcDat, '#03', 'dIni ', 10, 10, 1, CTe.infCTeNorm.duto.dIni, '');
  Gerador.wCampo(tcDat, '#04', 'dFim ', 10, 10, 1, CTe.infCTeNorm.duto.dFim, '');
  Gerador.wGrupo('/duto');
end;

procedure TCTeW.GerarMultimodal;
begin
  Gerador.wGrupo('multimodal', '#01');
  Gerador.wCampo(tcStr, '#02', 'COTM         ', 01, 255, 0, CTe.infCTeNorm.multimodal.COTM, '');
  Gerador.wCampo(tcStr, '#03', 'indNegociavel', 01, 001, 1, indNegociavelToStr(CTe.infCTeNorm.multimodal.indNegociavel), '');
  Gerador.wGrupo('/multimodal');
end;

procedure TCTeW.GerarPeri;  // Q
var
 i: Integer;
begin
  for i := 0 to CTe.infCTeNorm.peri.Count - 1 do
   begin
    Gerador.wGrupo('peri', '#315');
    Gerador.wCampo(tcStr, '#316', 'nONU       ', 01,  04, 1, CTe.infCTeNorm.peri.Items[i].nONU, '');
    Gerador.wCampo(tcStr, '#317', 'xNomeAE    ', 01, 150, 1, CTe.infCTeNorm.peri.Items[i].xNomeAE, '');
    Gerador.wCampo(tcStr, '#318', 'xClaRisco  ', 01,  40, 1, CTe.infCTeNorm.peri.Items[i].xClaRisco, '');
    Gerador.wCampo(tcStr, '#319', 'grEmb      ', 01,  06, 0, CTe.infCTeNorm.peri.Items[i].grEmb, '');
    Gerador.wCampo(tcStr, '#320', 'qTotProd   ', 01,  20, 1, CTe.infCTeNorm.peri.Items[i].qTotProd, '');
    Gerador.wCampo(tcStr, '#321', 'qVolTipo   ', 01,  60, 0, CTe.infCTeNorm.peri.Items[i].qVolTipo, '');
    Gerador.wCampo(tcStr, '#322', 'pontoFulgor', 01,  06, 0, CTe.infCTeNorm.peri.Items[i].pontoFulgor, '');
    Gerador.wGrupo('/peri');
   end;
  if CTe.infCTeNorm.peri.Count > 990 then
   Gerador.wAlerta('#315', 'peri', '', ERR_MSG_MAIOR_MAXIMO + '990');
end;

procedure TCTeW.GerarVeicNovos;  // R
var
 i: Integer;
begin
  for i := 0 to CTe.infCTeNorm.veicNovos.Count - 1 do
   begin
    Gerador.wGrupo('veicNovos', '#323');
    Gerador.wCampo(tcStr, '#324', 'chassi ', 17, 17, 1, CTe.infCTeNorm.veicNovos.Items[i].chassi, '');
    Gerador.wCampo(tcStr, '#325', 'cCor   ', 01, 04, 1, CTe.infCTeNorm.veicNovos.Items[i].cCor, '');
    Gerador.wCampo(tcStr, '#326', 'xCor   ', 01, 40, 1, CTe.infCTeNorm.veicNovos.Items[i].xCor, '');
    Gerador.wCampo(tcStr, '#327', 'cMod   ', 01, 06, 1, CTe.infCTeNorm.veicNovos.Items[i].cMod, '');
    Gerador.wCampo(tcDe2, '#328', 'vUnit  ', 01, 15, 1, CTe.infCTeNorm.veicNovos.Items[i].vUnit, '');
    Gerador.wCampo(tcDe2, '#329', 'vFrete ', 01, 15, 1, CTe.infCTeNorm.veicNovos.Items[i].vFrete, '');
    Gerador.wGrupo('/veicNovos');
   end;
  if CTe.infCTeNorm.veicNovos.Count > 990 then
   Gerador.wAlerta('#323', 'veicNovos', '', ERR_MSG_MAIOR_MAXIMO + '990');
end;

procedure TCTeW.GerarCobr;
begin
  if (Trim(CTe.infCTeNorm.cobr.fat.nFat) <> '') or (CTe.infCTeNorm.cobr.fat.vOrig > 0) or
     (CTe.infCTeNorm.cobr.fat.vDesc > 0) or (CTe.infCTeNorm.cobr.fat.vLiq > 0) or
     (CTe.infCTeNorm.cobr.dup.Count > 0) then
  begin
    Gerador.wGrupo('cobr', '#330');
    (**)GerarCobrFat;
    (**)GerarCobrDup;
    Gerador.wGrupo('/cobr');
  end;
end;

procedure TCTeW.GerarCobrFat;
begin
  if (Trim(CTe.infCTeNorm.cobr.fat.nFat) <> '') or (CTe.infCTeNorm.cobr.fat.vOrig > 0) or
     (CTe.infCTeNorm.cobr.fat.vDesc > 0) or (CTe.infCTeNorm.cobr.fat.vLiq > 0) then
  begin
    Gerador.wGrupo('fat', '#331');
    Gerador.wCampo(tcStr, '#332', 'nFat  ', 01, 60, 0, CTe.infCTeNorm.cobr.fat.nFat, DSC_NFAT);
    Gerador.wCampo(tcDe2, '#333', 'vOrig ', 01, 15, 0, CTe.infCTeNorm.cobr.fat.vOrig, DSC_VORIG);
    Gerador.wCampo(tcDe2, '#334', 'vDesc ', 01, 15, 0, CTe.infCTeNorm.cobr.fat.vDesc, DSC_VDESC);
    Gerador.wCampo(tcDe2, '#335', 'vLiq  ', 01, 15, 0, CTe.infCTeNorm.cobr.fat.vLiq, DSC_VLIQ);
    Gerador.wGrupo('/fat');
  end;
end;

procedure TCTeW.GerarCobrDup;
var
  i: integer;
begin
  for i := 0 to CTe.infCTeNorm.cobr.dup.Count - 1 do
  begin
    Gerador.wGrupo('dup', '#336');
    Gerador.wCampo(tcStr, '#337', 'nDup  ', 01, 60, 0, CTe.infCTeNorm.cobr.dup[i].nDup, DSC_NDUP);
    Gerador.wCampo(tcDat, '#338', 'dVenc ', 10, 10, 0, CTe.infCTeNorm.cobr.dup[i].dVenc, DSC_DVENC);
    Gerador.wCampo(tcDe2, '#339', 'vDup  ', 01, 15, 0, CTe.infCTeNorm.cobr.dup[i].vDup, DSC_VDUP);
    Gerador.wGrupo('/dup');
  end;
end;

procedure TCTeW.GerarInfCTeSub;  // S
begin
 if CTe.infCTeNorm.infCTeSub.chCte<>''
  then begin
   Gerador.wGrupo('infCteSub', '#340');
   Gerador.wCampo(tcEsp, '#341', 'chCte ', 44, 44, 1, SomenteNumeros(CTe.infCTeNorm.infCTeSub.chCte), DSC_CHCTE);
   if SomenteNumeros(CTe.infCTeNorm.infCTeSub.chCte) <> '' then
    if not ValidarChave('NFe' + SomenteNumeros(CTe.infCTeNorm.infCTeSub.chCte)) then
     Gerador.wAlerta('#341', 'chCte', DSC_REFNFE, ERR_MSG_INVALIDO);

   if (CTe.infCTeNorm.infCTeSub.tomaNaoICMS.refCteAnu='')
    then begin
     Gerador.wGrupo('tomaICMS', '#342');
     if (CTe.infCTeNorm.infCTeSub.tomaICMS.refNFe<>'')
      then begin
       Gerador.wCampo(tcEsp, '#343', 'refNFe ', 44, 44, 1, SomenteNumeros(CTe.infCTeNorm.infCTeSub.tomaICMS.refNFe), DSC_CHCTE);
       if SomenteNumeros(CTe.infCTeNorm.infCTeSub.tomaICMS.refNFe) <> '' then
        if not ValidarChave('NFe' + SomenteNumeros(CTe.infCTeNorm.infCTeSub.tomaICMS.refNFe)) then
         Gerador.wAlerta('#343', 'refNFe', DSC_REFNFE, ERR_MSG_INVALIDO);
      end
      else begin
       if (CTe.infCTeNorm.infCTeSub.tomaICMS.refNF.CNPJ<>'')
        then begin
         Gerador.wGrupo('refNF', '#344');
         Gerador.wCampoCNPJ('#345', CTe.infCTeNorm.infCTeSub.tomaICMS.refNF.CNPJ, CODIGO_BRASIL, True);
         Gerador.wCampo(tcStr, '#346', 'mod      ', 02, 02, 1, CTe.infCTeNorm.infCTeSub.tomaICMS.refNF.modelo, '');
         Gerador.wCampo(tcInt, '#347', 'serie    ', 01, 03, 1, CTe.infCTeNorm.infCTeSub.tomaICMS.refNF.serie, '');
         Gerador.wCampo(tcInt, '#348', 'subserie ', 01, 03, 0, CTe.infCTeNorm.infCTeSub.tomaICMS.refNF.subserie, '');
         Gerador.wCampo(tcInt, '#349', 'nro      ', 01, 06, 1, CTe.infCTeNorm.infCTeSub.tomaICMS.refNF.nro, '');
         Gerador.wCampo(tcDe2, '#350', 'valor    ', 01, 15, 1, CTe.infCTeNorm.infCTeSub.tomaICMS.refNF.valor, '');
         Gerador.wCampo(tcDat, '#351', 'dEmi     ', 10, 10, 1, CTe.infCTeNorm.infCTeSub.tomaICMS.refNF.dEmi, '');
         Gerador.wGrupo('/refNF');
        end
        else begin
         Gerador.wCampo(tcEsp, '#352', 'refCte   ', 44, 44, 1, SomenteNumeros(CTe.infCTeNorm.infCTeSub.tomaICMS.refCte), DSC_CHCTE);
         if SomenteNumeros(CTe.infCTeNorm.infCTeSub.tomaICMS.refCte) <> '' then
          if not ValidarChave('NFe' + SomenteNumeros(CTe.infCTeNorm.infCTeSub.tomaICMS.refCte)) then
           Gerador.wAlerta('#352', 'refCte', DSC_REFNFE, ERR_MSG_INVALIDO);
        end;
      end;
     Gerador.wGrupo('/tomaICMS');
    end
    else begin
     Gerador.wGrupo('tomaNaoICMS', '#353');
     Gerador.wCampo(tcEsp, '#354', 'refCteAnu ', 44, 44, 1, SomenteNumeros(CTe.infCTeNorm.infCTeSub.tomaNaoICMS.refCteAnu), DSC_CHCTE);
     if SomenteNumeros(CTe.infCTeNorm.infCTeSub.tomaNaoICMS.refCteAnu) <> '' then
      if not ValidarChave('NFe' + SomenteNumeros(CTe.infCTeNorm.infCTeSub.tomaNaoICMS.refCteAnu)) then
       Gerador.wAlerta('#354', 'refCteAnu', DSC_REFNFE, ERR_MSG_INVALIDO);
     Gerador.wGrupo('/tomaNaoICMS');
    end;
   Gerador.wGrupo('/infCteSub');
  end;
end;

procedure TCTeW.GerarInfCTeComp;
var
  i: integer;
begin
  if (CTe.Ide.tpCTe = tcComplemento) then
  begin
    Gerador.wGrupo('infCteComp', '#355');
    Gerador.wCampo(tcEsp, '#356', 'chave   ', 44, 44, 1, SomenteNumeros(CTe.infCTeComp.Chave), DSC_CHCTE);
    if SomenteNumeros(CTe.infCTeComp.Chave) <> '' then
     if not ValidarChave('NFe' + SomenteNumeros(CTe.infCTeComp.Chave)) then
      Gerador.wAlerta('#356', 'chave', DSC_REFNFE, ERR_MSG_INVALIDO);
    Gerador.wGrupo('vPresComp', '#357');
    Gerador.wCampo(tcDe2, '#358', 'vTPrest ', 01, 15, 1, CTe.infCTeComp.vPresComp.vTPrest, DSC_VTPREST);

    for i := 0 to CTe.InfCTeComp.vPresComp.compComp.Count - 1 do
    begin
      if (CTe.InfCTeComp.vPresComp.compComp[i].xNome <> '') and
        (CTe.InfCTeComp.vPresComp.compComp[i].vComp <> 0) then
        begin
          Gerador.wGrupo('compComp', '#359');
          Gerador.wCampo(tcStr, '#360', 'xNome ', 01, 15, 1, CTe.InfCTeComp.vPresComp.compComp[i].xNome, DSC_XNOMEC);
          Gerador.wCampo(tcDe2, '#361', 'vComp ', 01, 15, 1, CTe.InfCTeComp.vPresComp.compComp[i].vComp, DSC_VCOMP);
          Gerador.wGrupo('/compComp');
        end;
    end;

    Gerador.wGrupo('/vPresComp');

    (**)GerarImpComp;

    Gerador.wGrupo('/infCteComp');
  end;
end;

procedure TCTeW.GerarImpComp;
begin
  Gerador.wGrupo('impComp', '#362');
  (**)GerarICMSComp;
  Gerador.wCampo(tcDe2, '#398', 'vTotTrib   ', 01, 15, 0, CTe.InfCTeComp.impComp.vTotTrib, DSC_VCOMP);
  Gerador.wCampo(tcStr, '#398', 'infAdFisco ', 01, 1000, 0, CTe.InfCTeComp.impComp.InfAdFisco, DSC_INFADFISCO);
  Gerador.wGrupo('/impComp');
end;

procedure TCTeW.GerarICMSComp;
begin
  Gerador.wGrupo('ICMSComp', '363');

  if CTe.InfCTeComp.impComp.ICMSComp.SituTrib = cst00 then
    (**)GerarCST00Comp
  else if CTe.InfCTeComp.impComp.ICMSComp.SituTrib = cst20 then
    (**)GerarCST20Comp
  else if ((CTe.InfCTeComp.impComp.ICMSComp.SituTrib = cst40) or
           (CTe.InfCTeComp.impComp.ICMSComp.SituTrib = cst41) or
           (CTe.InfCTeComp.impComp.ICMSComp.SituTrib = cst51)) then
    (**)GerarCST45Comp
  else if CTe.InfCTeComp.impComp.ICMSComp.SituTrib = cst60 then
    (**)GerarCST60Comp
  else if CTe.InfCTeComp.impComp.ICMSComp.SituTrib = cst90 then
    (**)GerarCST90Comp
  else if CTe.InfCTeComp.impComp.ICMSComp.SituTrib = cstICMSOutraUF then
    (**)GerarICMSOutraUFComp
  else if CTe.InfCTeComp.impComp.ICMSComp.SituTrib = cstICMSSN then
    (**)GerarICMSSNComp;

  Gerador.wGrupo('/ICMSComp');
end;

procedure TCTeW.GerarCST00Comp;
begin
  Gerador.wGrupo('ICMS00', '#364');
  Gerador.wCampo(tcStr, '#365', 'CST   ', 02, 02, 1, CSTICMSTOStr(CTe.InfCTeComp.impComp.ICMSComp.ICMS00.CST), DSC_CST);
  Gerador.wCampo(tcDe2, '#366', 'vBC   ', 01, 15, 1, CTe.InfCTeComp.impComp.ICMSComp.ICMS00.vBC, DSC_VBC);
  Gerador.wCampo(tcDe2, '#367', 'pICMS ', 01, 05, 1, CTe.InfCTeComp.impComp.ICMSComp.ICMS00.pICMS, DSC_PICMS);
  Gerador.wCampo(tcDe2, '#368', 'vICMS ', 01, 15, 1, CTe.InfCTeComp.impComp.ICMSComp.ICMS00.vICMS, DSC_VICMS);
  Gerador.wGrupo('/ICMS00');
end;

procedure TCTeW.GerarCST20Comp;
begin
  Gerador.wGrupo('ICMS20', '#369');
  Gerador.wCampo(tcStr, '#370', 'CST    ', 02, 02, 1, CSTICMSTOStr(CTe.InfCTeComp.impComp.ICMSComp.ICMS20.CST), DSC_CST);
  Gerador.wCampo(tcDe2, '#371', 'pRedBC ', 01, 05, 1, CTe.InfCTeComp.impComp.ICMSComp.ICMS20.pRedBC, DSC_PREDBC);
  Gerador.wCampo(tcDe2, '#372', 'vBC    ', 01, 15, 1, CTe.InfCTeComp.impComp.ICMSComp.ICMS20.vBC, DSC_VBC);
  Gerador.wCampo(tcDe2, '#373', 'pICMS  ', 01, 05, 1, CTe.InfCTeComp.impComp.ICMSComp.ICMS20.pICMS, DSC_PICMS);
  Gerador.wCampo(tcDe2, '#374', 'vICMS  ', 01, 15, 1, CTe.InfCTeComp.impComp.ICMSComp.ICMS20.vICMS, DSC_VICMS);
  Gerador.wGrupo('/ICMS20');
end;

procedure TCTeW.GerarCST45Comp;
begin
  Gerador.wGrupo('ICMS45', '#375');
  Gerador.wCampo(tcStr, '#376', 'CST ', 02, 02, 1, CSTICMSTOStr(CTe.InfCTeComp.impComp.ICMSComp.ICMS45.CST), DSC_CST);
  Gerador.wGrupo('/ICMS45');
end;

procedure TCTeW.GerarCST60Comp;
begin
  Gerador.wGrupo('ICMS60', '#377');
  Gerador.wCampo(tcStr, '#378', 'CST        ', 02, 02, 1, CSTICMSTOStr(CTe.InfCTeComp.impComp.ICMSComp.ICMS60.CST), DSC_CST);
  Gerador.wCampo(tcDe2, '#379', 'vBCSTRet   ', 01, 15, 1, CTe.InfCTeComp.impComp.ICMSComp.ICMS60.vBCSTRet, DSC_VBC);
  Gerador.wCampo(tcDe2, '#380', 'vICMSSTRet ', 01, 15, 1, CTe.InfCTeComp.impComp.ICMSComp.ICMS60.vICMSSTRet, DSC_VICMS);
  Gerador.wCampo(tcDe2, '#381', 'pICMSSTRet ', 01, 05, 1, CTe.InfCTeComp.impComp.ICMSComp.ICMS60.pICMSSTRet, DSC_PICMS);
  if CTe.InfCTeComp.impComp.ICMSComp.ICMS60.vCred > 0 then
   Gerador.wCampo(tcDe2, '#382', 'vCred     ', 01, 15, 1, CTe.InfCTeComp.impComp.ICMSComp.ICMS60.vCred, DSC_VCRED);
  Gerador.wGrupo('/ICMS60');
end;

procedure TCTeW.GerarCST90Comp;
begin
  Gerador.wGrupo('ICMS90', '#383');
  Gerador.wCampo(tcStr, '#384', 'CST      ', 02, 02, 1, CSTICMSTOStr(CTe.InfCTeComp.impComp.ICMSComp.ICMS90.CST), DSC_CST);
  if CTe.InfCTeComp.impComp.ICMSComp.ICMS90.pRedBC > 0 then
    Gerador.wCampo(tcDe2, '#385', 'pRedBC ', 01, 05, 1, CTe.InfCTeComp.impComp.ICMSComp.ICMS90.pRedBC, DSC_PREDBC);
  Gerador.wCampo(tcDe2, '#386', 'vBC      ', 01, 15, 1, CTe.InfCTeComp.impComp.ICMSComp.ICMS90.vBC, DSC_VBC);
  Gerador.wCampo(tcDe2, '#387', 'pICMS    ', 01, 05, 1, CTe.InfCTeComp.impComp.ICMSComp.ICMS90.pICMS, DSC_PICMS);
  Gerador.wCampo(tcDe2, '#388', 'vICMS    ', 01, 15, 1, CTe.InfCTeComp.impComp.ICMSComp.ICMS90.vICMS, DSC_VICMS);
  if CTe.InfCTeComp.impComp.ICMSComp.ICMS90.vCred > 0 then
    Gerador.wCampo(tcDe2, '#389', 'vCred  ', 01, 15, 1, CTe.InfCTeComp.impComp.ICMSComp.ICMS90.vCred, DSC_VCRED);
  Gerador.wGrupo('/ICMS90');
end;

procedure TCTeW.GerarICMSOutraUFComp;
begin
  Gerador.wGrupo('ICMSOutraUF', '#390');
  Gerador.wCampo(tcStr, '#391', 'CST             ', 02, 02, 1, CSTICMSTOStr(CTe.InfCTeComp.impComp.ICMSComp.ICMSOutraUF.CST), DSC_CST);
  if CTe.InfCTeComp.impComp.ICMSComp.ICMSOutraUF.pRedBCOutraUF > 0 then
    Gerador.wCampo(tcDe2, '#392', 'pRedBCOutraUF ', 01, 05, 1, CTe.InfCTeComp.impComp.ICMSComp.ICMSOutraUF.pRedBCOutraUF, DSC_PREDBC);
  Gerador.wCampo(tcDe2, '#393', 'vBCOutraUF      ', 01, 15, 1, CTe.InfCTeComp.impComp.ICMSComp.ICMSOutraUF.vBCOutraUF, DSC_VBC);
  Gerador.wCampo(tcDe2, '#394', 'pICMSOutraUF    ', 01, 05, 1, CTe.InfCTeComp.impComp.ICMSComp.ICMSOutraUF.pICMSOutraUF, DSC_PICMS);
  Gerador.wCampo(tcDe2, '#395', 'vICMSOutraUF    ', 01, 15, 1, CTe.InfCTeComp.impComp.ICMSComp.ICMSOutraUF.vICMSOutraUF, DSC_VICMS);
  Gerador.wGrupo('/ICMSOutraUF');
end;

procedure TCTeW.GerarICMSSNComp;
begin
  Gerador.wGrupo('ICMSSN', '#396');
  Gerador.wCampo(tcInt, '#397', 'indSN ', 01, 01, 1, CTe.InfCTeComp.impComp.ICMSComp.ICMSSN.indSN, '');
  Gerador.wGrupo('/ICMSSN');
end;

procedure TCTeW.GerarInfCTeAnu;
begin
  if (CTe.Ide.tpCTe = tcAnulacao) then
  begin
    Gerador.wGrupo('infCteAnu', '#399');
    Gerador.wCampo(tcEsp, '#400', 'chCte ', 44, 44, 1, SomenteNumeros(CTe.InfCTeAnu.chCTe), DSC_CHCTE);
    if SomenteNumeros(CTe.InfCTeAnu.chCTe) <> '' then
     if not ValidarChave('NFe' + SomenteNumeros(CTe.InfCTeAnu.chCTe)) then
      Gerador.wAlerta('#400', 'chCte', DSC_REFNFE, ERR_MSG_INVALIDO);
    Gerador.wCampo(tcDat, '#401', 'dEmi  ', 10, 10, 1, CTe.InfCTeAnu.dEmi, DSC_DEMI);
    Gerador.wGrupo('/infCteAnu');
  end;
end;

procedure TCTeW.GerarautXML;
var
  i: integer;
begin
  for i := 0 to CTe.autXML.Count - 1 do
  begin
    Gerador.wGrupo('autXML', '#140');
    Gerador.wCampoCNPJCPF('#141', '#142', CTe.autXML[i].CNPJCPF, CODIGO_BRASIL);
    Gerador.wGrupo('/autXML');
  end;
  if CTe.autXML.Count > 10 then
    Gerador.wAlerta('#140', 'autXML', DSC_LACR, ERR_MSG_MAIOR_MAXIMO + '10');
end;

procedure TCTeW.AjustarMunicipioUF(var xUF, xMun: string;
  var cMun: integer; cPais: integer; vxUF, vxMun: string; vcMun: integer);
var
  PaisBrasil: boolean;
begin
  PaisBrasil := cPais = CODIGO_BRASIL;
  cMun := IIf(PaisBrasil, vcMun, CMUN_EXTERIOR);
  xMun := IIf(PaisBrasil, vxMun, XMUN_EXTERIOR);
  xUF := IIf(PaisBrasil, vxUF, UF_EXTERIOR);
  xMun := ObterNomeMunicipio(xMun, xUF, cMun);
end;

function TCTeW.ObterNomeMunicipio(const xMun, xUF: string;
  const cMun: integer): string;
var
  i: integer;
  PathArquivo, Codigo: string;
  List: TstringList;
begin
  result := '';
  if (FOpcoes.NormatizarMunicipios) and (cMun <> CMUN_EXTERIOR) then
  begin
    PathArquivo := FOpcoes.FPathArquivoMunicipios + 'MunIBGE-UF' + InttoStr(UFparaCodigo(xUF)) + '.txt';
    if FileExists(PathArquivo) then
    begin
      List := TstringList.Create;
      List.LoadFromFile(PathArquivo);
      Codigo := IntToStr(cMun);
      i := 0;
      while (i < list.count) and (result = '') do
      begin
        if pos(Codigo, List[i]) > 0 then
          result := Trim(stringReplace(list[i], codigo, '', []));
        inc(i);
      end;
      List.free;
    end;
  end;
  if result = '' then
    result := xMun;
end;
{$ENDIF}

end.

