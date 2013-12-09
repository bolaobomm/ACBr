////////////////////////////////////////////////////////////////////////////////
//                                                                            //
//              PCN - Projeto Cooperar CTe                                    //
//                                                                            //
//   Descri��o: Classes para gera��o/leitura dos arquivos xml da CTe          //
//                                                                            //
//        site: www.projetocooperar.org/CTe                                   //
//       email: projetocooperar@zipmail.com.br                                //
//       forum: http://br.groups.yahoo.com/group/projeto_cooperar_CTe/        //
//     projeto: http://code.google.com/p/projetocooperar/                     //
//         svn: http://projetocooperar.googlecode.com/svn/trunk/              //
//                                                                            //
// Coordena��o: (c) 2009 - Paulo Casagrande                                   //
//                                                                            //
//      Equipe: Vide o arquivo leiame.txt na pasta raiz do projeto            //
//                                                                            //
//      Vers�o: Vide o arquivo leiame.txt na pasta raiz do projeto            //
//                                                                            //
//     Licen�a: GNU Lesser General Public License (GNU LGPL)                  //
//                                                                            //
//              - Este programa � software livre; voc� pode redistribu�-lo    //
//              e/ou modific�-lo sob os termos da Licen�a P�blica Geral GNU,  //
//              conforme publicada pela Free Software Foundation; tanto a     //
//              vers�o 2 da Licen�a como (a seu crit�rio) qualquer vers�o     //
//              mais nova.                                                    //
//                                                                            //
//              - Este programa � distribu�do na expectativa de ser �til,     //
//              mas SEM QUALQUER GARANTIA; sem mesmo a garantia impl�cita de  //
//              COMERCIALIZA��O ou de ADEQUA��O A QUALQUER PROP�SITO EM       //
//              PARTICULAR. Consulte a Licen�a P�blica Geral GNU para obter   //
//              mais detalhes. Voc� deve ter recebido uma c�pia da Licen�a    //
//              P�blica Geral GNU junto com este programa; se n�o, escreva    //
//              para a Free Software Foundation, Inc., 59 Temple Place,       //
//              Suite 330, Boston, MA - 02111-1307, USA ou consulte a         //
//              licen�a oficial em http://www.gnu.org/licenses/gpl.txt        //
//                                                                            //
//    Nota (1): - Esta  licen�a  n�o  concede  o  direito  de  uso  do nome   //
//              "PCN  -  Projeto  Cooperar  CTe", n�o  podendo o mesmo ser    //
//              utilizado sem previa autoriza��o.                             //
//                                                                            //
//    Nota (2): - O uso integral (ou parcial) das units do projeto esta       //
//              condicionado a manuten��o deste cabe�alho junto ao c�digo     //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

{$I ACBr.inc}

unit pgnreGNRER;

interface

uses
  SysUtils, Classes,
{$IFNDEF VER130}
  Variants,
{$ENDIF}
  pcnAuxiliar, pcnConversao, pcnLeitor, pgnreGNRE;

type

  TGNRER = class(TPersistent)
  private
    FLeitor: TLeitor;
    FGNRE: TGNRE;
  public
    constructor Create(AOwner: TGNRE);
    destructor Destroy; override;
    function LerXml: boolean;
  published
    property Leitor: TLeitor read FLeitor write FLeitor;
    property GNRE: TGNRE read FGNRE write FGNRE;
  end;

  ////////////////////////////////////////////////////////////////////////////////

implementation

{ TGNRER }

constructor TGNRER.Create(AOwner: TGNRE);
begin
  FLeitor := TLeitor.Create;
  FGNRE := AOwner;
end;

destructor TGNRER.Destroy;
begin
  FLeitor.Free;
  inherited Destroy;
end;

////////////////////////////////////////////////////////////////////////////////

function TGNRER.LerXml: boolean;
var
  ok: boolean;
  i, j: integer;
  CampoExtra: TCampoExtraCollectionItem;
begin
  (* Grupo da TAG <TDadosGNRE> *******************************************************)
  if Leitor.rExtrai(1, 'TDadosGNRE') <> '' then
  begin
    GNRE.c01_UfFavorecida                  := Leitor.rCampo(tcStr, 'c01_UfFavorecida');
    GNRE.c02_receita                       := Leitor.rCampo(tcInt, 'c02_receita');
    GNRE.c25_detalhamentoReceita           := Leitor.rCampo(tcInt, 'c25_detalhamentoReceita');
    GNRE.c26_produto                       := Leitor.rCampo(tcInt, 'c26_produto');
    GNRE.c27_tipoIdentificacaoEmitente     := Leitor.rCampo(tcInt, 'c27_tipoIdentificacaoEmitente');
    GNRE.c03_idContribuinteEmitente        := Leitor.rCampo(tcStr, 'c03_idContribuinteEmitente');
    GNRE.c28_tipoDocOrigem                 := Leitor.rCampo(tcInt, 'c28_tipoDocOrigem');
    GNRE.c04_docOrigem                     := Leitor.rCampo(tcStr, 'c04_docOrigem');
    GNRE.c06_valorPrincipal                := Leitor.rCampo(tcDe2, 'c06_valorPrincipal');
    GNRE.c10_valorTotal                    := Leitor.rCampo(tcDe2, 'c10_valorTotal');
    GNRE.c14_dataVencimento                := Leitor.rCampo(tcDat, 'c14_dataVencimento');
    GNRE.c15_convenio                      := Leitor.rCampo(tcStr, 'c15_convenio');
    GNRE.c16_razaoSocialEmitente           := Leitor.rCampo(tcStr, 'c16_razaoSocialEmitente');
    GNRE.c17_inscricaoEstadualEmitente     := Leitor.rCampo(tcStr, 'c17_inscricaoEstadualEmitente');
    GNRE.c18_enderecoEmitente              := Leitor.rCampo(tcStr, 'c18_enderecoEmitente');
    GNRE.c19_municipioEmitente             := Leitor.rCampo(tcInt, 'c19_municipioEmitente');
    GNRE.c20_ufEnderecoEmitente            := Leitor.rCampo(tcStr, 'c20_ufEnderecoEmitente');
    GNRE.c21_cepEmitente                   := Leitor.rCampo(tcStr, 'c21_cepEmitente');
    GNRE.c22_telefoneEmitente              := Leitor.rCampo(tcStr, 'c22_telefoneEmitente');
    GNRE.c34_tipoIdentificacaoDestinatario := Leitor.rCampo(tcInt, 'c34_tipoIdentificacaoDestinatario');
    GNRE.c35_idContribuinteDestinatario    := Leitor.rCampo(tcStr, 'c35_idContribuinteDestinatario');
    GNRE.c36_inscricaoEstadualDestinatario := Leitor.rCampo(tcStr, 'c36_inscricaoEstadualDestinatario');
    GNRE.c37_razaoSocialDestinatario       := Leitor.rCampo(tcStr, 'c37_razaoSocialDestinatario');
    GNRE.c38_municipioDestinatario         := Leitor.rCampo(tcInt, 'c38_municipioDestinatario');
    GNRE.c33_dataPagamento                 := Leitor.rCampo(tcDat, 'c33_dataPagamento');
    GNRE.c42_identificadorGuia             := Leitor.rCampo(tcStr, 'c42_identificadorGuia');
  end;

  if Leitor.rExtrai(1, 'c05_referencia') <> '' then
  begin
    GNRE.referencia.periodo := Leitor.rCampo(tcInt, 'periodo');
    GNRE.referencia.mes     := Leitor.rCampo(tcStr, 'mes');
    GNRE.referencia.ano     := Leitor.rCampo(tcStr, 'ano');
    GNRE.referencia.parcela := Leitor.rCampo(tcInt, 'parcela');
  end;

  i := 0;

  if Leitor.rExtrai(1, 'c39_camposExtras') <> '' then
  begin
    while Leitor.rExtrai(2, 'campoExtra', '', i + 1) <> '' do
    begin
      CampoExtra := GNRE.camposExtras.Add;
      CampoExtra.CampoExtra.codigo := Leitor.rCampo(tcInt, 'codigo');
      CampoExtra.CampoExtra.tipo   := Leitor.rCampo(tcStr, 'tipo');
      CampoExtra.CampoExtra.valor  := Leitor.rCampo(tcStr, 'valor');
    end;
  end;

  Result := true;
end;

end.

