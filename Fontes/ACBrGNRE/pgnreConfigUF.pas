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

unit pgnreConfigUF;

interface

uses SysUtils, Classes, pcnAuxiliar, pcnConversao, pcnLeitor, pgnreConversao, ACBrUtil;

type
  TInfReceita = class;
  TRetInfReceita = class;
  TInfDetalhamentoReceita = class;
  TRetInfDetalhamentoReceita = class;
  TInfProduto = class;
  TRetInfProduto = class;

  TInfReceita = class
  private
    Fcodigo: Integer;
    Fdescricao: string;
    Fcourier: string;
    FexigeDetalhamentoReceita: string;
    FexigeProduto: string;
    FexigePeriodoReferencia: string;
    FexigePeriodoApuracao: string;
    FexigeParcela: string;
    FvalorExigido: string;
    FexigeDocumentoOrigem: string;
    FexigeContribuinteDestinatario: string;
    FexigeCamposAdicionais: string;
  public
    property codigo: Integer read Fcodigo write Fcodigo;
    property descricao: string read Fdescricao write Fdescricao;
    property courier: string read Fcourier write Fcourier;
    property exigeDetalhamentoReceita: string read FexigeDetalhamentoReceita write FexigeDetalhamentoReceita;
    property exigeProduto: string read FexigeProduto write FexigeProduto;
    property exigePeriodoReferencia: string read FexigePeriodoReferencia write FexigePeriodoReferencia;
    property exigePeriodoApuracao: string read FexigePeriodoApuracao write FexigePeriodoApuracao;
    property exigeParcela: string read FexigeParcela write FexigeParcela;
    property valorExigido: string read FvalorExigido write FvalorExigido;
    property exigeDocumentoOrigem: string read FexigeDocumentoOrigem write FexigeDocumentoOrigem;
    property exigeContribuinteDestinatario: string read FexigeContribuinteDestinatario write FexigeContribuinteDestinatario;
    property exigeCamposAdicionais: string read FexigeCamposAdicionais write FexigeCamposAdicionais;
  end;

  TRetInfReceita = class
  private
    Fcodigo: Integer;
    Fdescricao: string;
    Fcourier: string;
    FexigeDetalhamentoReceita: string;
    FexigeProduto: string;
    FexigePeriodoReferencia: string;
    FexigePeriodoApuracao: string;
    FexigeParcela: string;
    FvalorExigido: string;
    FexigeDocumentoOrigem: string;
    FexigeContribuinteDestinatario: string;    
    FexigeCamposAdicionais: string;
  published
    property codigo: Integer read Fcodigo write Fcodigo;
    property descricao: string read Fdescricao write Fdescricao;
    property courier: string read Fcourier write Fcourier;
    property exigeDetalhamentoReceita: string read FexigeDetalhamentoReceita write FexigeDetalhamentoReceita;
    property exigeProduto: string read FexigeProduto write FexigeProduto;
    property exigePeriodoReferencia: string read FexigePeriodoReferencia write FexigePeriodoReferencia;
    property exigePeriodoApuracao: string read FexigePeriodoApuracao write FexigePeriodoApuracao;
    property exigeParcela: string read FexigeParcela write FexigeParcela;
    property valorExigido: string read FvalorExigido write FvalorExigido;
    property exigeDocumentoOrigem: string read FexigeDocumentoOrigem write FexigeDocumentoOrigem;
    property exigeContribuinteDestinatario: string read FexigeContribuinteDestinatario write FexigeContribuinteDestinatario;
    property exigeCamposAdicionais: string read FexigeCamposAdicionais write FexigeCamposAdicionais;
  end;

  TInfDetalhamentoReceita = class
  private
    Fcodigo: Integer;
    Fdescricao: string;
  public
    property codigo: Integer read Fcodigo write Fcodigo;
    property descricao: string read Fdescricao write Fdescricao;
  end;

  TRetInfDetalhamentoReceita = class
  private
    Fcodigo: Integer;
    Fdescricao: string;
  published
    property codigo: Integer read Fcodigo write Fcodigo;
    property descricao: string read Fdescricao write Fdescricao;
  end;

  TInfProduto = class
  private
    Fcodigo: Integer;
    Fdescricao: string;
  public
    property codigo: Integer read Fcodigo write Fcodigo;
    property descricao: string read Fdescricao write Fdescricao;
  end;

  TRetInfProduto = class
  private
    Fcodigo: Integer;
    Fdescricao: string;
  published
    property codigo: Integer read Fcodigo write Fcodigo;
    property descricao: string read Fdescricao write Fdescricao;
  end;

  TInfPeriodoApuracao = class
  private
    Fcodigo: Integer;
    Fdescricao: string;
  public
    property codigo: Integer read Fcodigo write Fcodigo;
    property descricao: string read Fdescricao write Fdescricao;
  end;

  TRetInfPeriodoApuracao = class
  private
    Fcodigo: Integer;
    Fdescricao: string;
  published
    property codigo: Integer read Fcodigo write Fcodigo;
    property descricao: string read Fdescricao write Fdescricao;
  end;

  TInfTipoDocumentoOrigem = class
  private
    Fcodigo: Integer;
    Fdescricao: string;
  public
    property codigo: Integer read Fcodigo write Fcodigo;
    property descricao: string read Fdescricao write Fdescricao;
  end;

  TRetInfTipoDocumentoOrigem = class
  private
    Fcodigo: Integer;
    Fdescricao: string;
  published
    property codigo: Integer read Fcodigo write Fcodigo;
    property descricao: string read Fdescricao write Fdescricao;
  end;

  TInfCampoAdicional = class
  private
    Fobrigatorio: string;
    Fcodigo: Integer;
    Ftipo: string;
    Ftamanho: Integer;
    FcasasDecimais: Integer;
    Ftitulo: string;
  public
    property obrigatorio: string read Fobrigatorio write Fobrigatorio;
    property codigo: Integer read Fcodigo write Fcodigo;
    property tipo: string read Ftipo write Ftipo;
    property tamanho: Integer read Ftamanho write Ftamanho;
    property casasDecimais: Integer read FcasasDecimais write FcasasDecimais;
    property titulo: string read Ftitulo write Ftitulo;
  end;

  TRetInfCampoAdicional = class
  private
    Fobrigatorio: string;
    Fcodigo: Integer;
    Ftipo: string;
    Ftamanho: Integer;
    FcasasDecimais: Integer;
    Ftitulo: string;
  published
    property obrigatorio: string read Fobrigatorio write Fobrigatorio;
    property codigo: Integer read Fcodigo write Fcodigo;
    property tipo: string read Ftipo write Ftipo;
    property tamanho: Integer read Ftamanho write Ftamanho;
    property casasDecimais: Integer read FcasasDecimais write FcasasDecimais;
    property titulo: string read Ftitulo write Ftitulo;
  end;

implementation

end.
 