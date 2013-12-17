{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2013 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo:  André Ferreira Moraes                          }
{                                                                              }
{  Você pode obter a última versão desse arquivo na pagina do  Projeto ACBr    }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr      }
{                                                                              }
{  Esta biblioteca é software livre; você pode redistribuí-la e/ou modificá-la }
{ sob os termos da Licença Pública Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a versão 2.1 da Licença, ou (a seu critério) }
{ qualquer versão posterior.                                                   }
{                                                                              }
{  Esta biblioteca é distribuída na expectativa de que seja útil, porém, SEM   }
{ NENHUMA GARANTIA; nem mesmo a garantia implícita de COMERCIABILIDADE OU      }
{ ADEQUAÇÃO A UMA FINALIDADE ESPECÍFICA. Consulte a Licença Pública Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICENÇA.TXT ou LICENSE.TXT)              }
{                                                                              }
{  Você deve ter recebido uma cópia da Licença Pública Geral Menor do GNU junto}
{ com esta biblioteca; se não, escreva para a Free Software Foundation, Inc.,  }
{ no endereço 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ Você também pode obter uma copia da licença em:                              }
{ http://www.opensource.org/licenses/lgpl-license.php                          }
{                                                                              }
{ Daniel Simões de Almeida  -  daniel@djsystem.com.br  -  www.djsystem.com.br  }
{              Praça Anita Costa, 34 - Tatuí - SP - 18270-410                  }
{                                                                              }
{******************************************************************************}

{$I ACBr.inc}

unit ACBrSATDinamico_cdecl ;

interface

uses
  Classes, SysUtils, ACBrSATClass;

type

   { TACBrSATDinamico_cdecl }

   TACBrSATDinamico_cdecl = class( TACBrSATClass )
   private
     xSAT_AssociarAssinatura : function ( numeroSessao : LongInt;
        codigoDeAtivacao, CNPJvalue, assinaturaCNPJs : PAnsiChar ) : PAnsiChar ;
        cdecl;
     xSAT_AtivarSAT : function ( numeroSessao, subComando : LongInt;
        codigoDeAtivacao, CNPJ: PAnsiChar; cUF : LongInt ) : PAnsiChar ; cdecl;
     xSAT_AtualizarSoftwareSAT : function ( numeroSessao : LongInt;
        codigoDeAtivacao : PAnsiChar ) : PAnsiChar ; cdecl;
     xSAT_BloquearSAT : function ( numeroSessao : LongInt;
        codigoDeAtivacao : PAnsiChar ) : PAnsiChar ; cdecl;
     xSAT_CancelarUltimaVenda : function (numeroSessao : LongInt;
        codigoAtivacao, chave, dadosCancelamento : PAnsiChar ) : PAnsiChar ; cdecl;
     xSAT_ComunicarCertificadoICPBRASIL : function ( numeroSessao : LongInt;
        codigoDeAtivacao, certificado : PAnsiChar ) : PAnsiChar ; cdecl;
     xSAT_ConfigurarInterfaceDeRede : function ( numeroSessao : LongInt;
        codigoDeAtivacao, dadosConfiguracao : PAnsiChar ) : PAnsiChar ; cdecl;
     xSAT_ConsultarNumeroSessao : function (numeroSessao : LongInt;
        codigoDeAtivacao : PAnsiChar; cNumeroDeSessao : LongInt) : PAnsiChar ; cdecl;
     xSAT_ConsultarSAT : function ( numeroSessao : LongInt ) : PAnsiChar ; cdecl;
     xSAT_ConsultarStatusOperacional : function ( numeroSessao : LongInt;
        codigoDeAtivacao : PAnsiChar ) : PAnsiChar ; cdecl;
     xSAT_DesbloquearSAT : function ( numeroSessao : LongInt;
        codigoDeAtivacao : PAnsiChar ) : PAnsiChar ; cdecl;
     xSAT_DesligarSAT : function : PAnsiChar ; cdecl;
     xSAT_EnviarDadosVenda : function ( numeroSessao : LongInt;
        codigoDeAtivacao, dadosVenda : PAnsiChar) : PAnsiChar ; cdecl;
     xSAT_ExtrairLogs : function ( numeroSessao : LongInt;
        codigoDeAtivacao : PAnsiChar ) : PAnsiChar ; cdecl;
     xSAT_TesteFimAFim : function ( numeroSessao : LongInt;
        codigoDeAtivacao, dadosVenda : PAnsiChar) : PAnsiChar ; cdecl;
     xSAT_TrocarCodigoDeAtivacao : function ( numeroSessao : LongInt;
        codigoDeAtivacao : PAnsiChar; opcao : LongInt; novoCodigo,
        confNovoCodigo : PAnsiChar ) : PAnsiChar ; cdecl;

   protected
     procedure LoadDLLFunctions ; override;

   public
     constructor Create( AOwner : TComponent ) ; override;

     function AssociarAssinatura( CNPJvalue, assinaturaCNPJs : String ):
       String ; override;
     function AtivarSAT( subComando : Integer; CNPJ: String; cUF : Integer )
       : String ; override;
     function AtualizarSoftwareSAT : String ; override;
     function BloquearSAT : String ; override;
     function CancelarUltimaVenda( chave, dadosCancelamento : String ) :
       String ; override;
     function ComunicarCertificadoICPBRASIL( certificado : AnsiString ) :
       String ; override;
     function ConfigurarInterfaceDeRede( dadosConfiguracao : AnsiString ) :
       String ; override;
     function ConsultarNumeroSessao( cNumeroDeSessao : Integer) : String ;
       override;
     function ConsultarSAT : String ; override ;
     function ConsultarStatusOperacional : String ; override;
     function DesbloquearSAT : String ; override;
     function DesligarSAT : String ; override;
     function EnviarDadosVenda( dadosVenda : AnsiString ) : String ; override;
     function ExtrairLogs : String ; override;
     function TesteFimAFim( dadosVenda : AnsiString) : String ; override;
     function TrocarCodigoDeAtivacao( opcao : Integer; novoCodigo,
        confNovoCodigo : String ) : String ; override;
   end;

implementation

Uses ACBrUtil;

constructor TACBrSATDinamico_cdecl.Create(AOwner : TComponent) ;
begin
  inherited Create(AOwner) ;

  fpModeloStr := 'Emulador_SAT_Dinamico' ;
end ;

function TACBrSATDinamico_cdecl.AssociarAssinatura(CNPJvalue,
  assinaturaCNPJs : String) : String ;
Var
  Resp : PAnsiChar;
begin
  Resp := xSAT_AssociarAssinatura(  numeroSessao,
                                    PAnsiChar(codigoDeAtivacao),
                                    PAnsiChar(CNPJvalue),
                                    PAnsiChar(assinaturaCNPJs) ) ;
  Result := String( Resp );
end ;

function TACBrSATDinamico_cdecl.AtivarSAT(subComando : Integer ;
  CNPJ : String ; cUF : Integer) : String ;
Var
  Resp : PAnsiChar;
begin
  Resp := xSAT_AtivarSAT( numeroSessao, subComando,
                          PAnsiChar(codigoDeAtivacao), PAnsiChar(CNPJ), cUF);
  Result := String( Resp );
end ;

function TACBrSATDinamico_cdecl.AtualizarSoftwareSAT : String ;
Var
  Resp : PAnsiChar;
begin
  Resp := xSAT_AtualizarSoftwareSAT( numeroSessao, PAnsiChar(codigoDeAtivacao) ) ;
  Result := String( Resp );
end ;

function TACBrSATDinamico_cdecl.BloquearSAT : String ;
Var
  Resp : PAnsiChar;
begin
  Resp := xSAT_BloquearSAT( numeroSessao, PAnsiChar(codigoDeAtivacao) ) ;
  Result := String( Resp );
end ;

function TACBrSATDinamico_cdecl.CancelarUltimaVenda(chave,
  dadosCancelamento : String) : String ;
Var
  Resp : PAnsiChar;
begin
  Resp := xSAT_CancelarUltimaVenda( numeroSessao, PAnsiChar(codigoDeAtivacao),
                                      PAnsiChar(chave), PAnsiChar(dadosCancelamento) ) ;
  Result := String( Resp );
end ;

function TACBrSATDinamico_cdecl.ComunicarCertificadoICPBRASIL(
  certificado : AnsiString) : String ;
Var
  Resp : PAnsiChar;
begin
  Resp := xSAT_ComunicarCertificadoICPBRASIL( numeroSessao,
                  PAnsiChar(codigoDeAtivacao), PAnsiChar(certificado) ) ;
  Result := String( Resp );
end ;

function TACBrSATDinamico_cdecl.ConfigurarInterfaceDeRede(
  dadosConfiguracao : AnsiString) : String ;
Var
  Resp : PAnsiChar;
begin
  Resp := xSAT_ConfigurarInterfaceDeRede( numeroSessao,
                 PAnsiChar(codigoDeAtivacao), PAnsiChar(dadosConfiguracao) ) ;
  Result := String( Resp );
end ;

function TACBrSATDinamico_cdecl.ConsultarNumeroSessao(cNumeroDeSessao : Integer
  ) : String ;
Var
  Resp : PAnsiChar;
begin
  Resp := xSAT_ConsultarNumeroSessao( numeroSessao, PAnsiChar(codigoDeAtivacao),
                                        cNumeroDeSessao) ;
  Result := String( Resp );
end ;

function TACBrSATDinamico_cdecl.ConsultarSAT : String ;
Var
  Resp : PAnsiChar;
begin
  Resp := xSAT_ConsultarSAT( numeroSessao ) ;
  Result := String( Resp );
end ;

function TACBrSATDinamico_cdecl.ConsultarStatusOperacional : String ;
Var
  Resp : PAnsiChar;
begin
  Resp := xSAT_ConsultarStatusOperacional( numeroSessao, PAnsiChar(codigoDeAtivacao) ) ;
  Result := String( Resp );
end ;

function TACBrSATDinamico_cdecl.DesbloquearSAT : String ;
Var
  Resp : PAnsiChar;
begin
  Resp := xSAT_DesbloquearSAT( numeroSessao, PAnsiChar(codigoDeAtivacao) );
  Result := String( Resp );
end ;

function TACBrSATDinamico_cdecl.DesligarSAT : String ;
Var
  Resp : PAnsiChar;
begin
  Resp := xSAT_DesligarSAT ;
  Result := String( Resp );
end ;

function TACBrSATDinamico_cdecl.EnviarDadosVenda(dadosVenda : AnsiString) : String ;
Var
  Resp : PAnsiChar;
begin
  Resp := xSAT_EnviarDadosVenda( numeroSessao, PAnsiChar(codigoDeAtivacao),
                                   PAnsiChar(dadosVenda) ) ;
  Result := String( Resp );
end ;

function TACBrSATDinamico_cdecl.ExtrairLogs : String ;
Var
  Resp : PAnsiChar;
begin
  Resp := xSAT_ExtrairLogs( numeroSessao, PAnsiChar(codigoDeAtivacao) ) ;
  Result := String( Resp );
end ;

function TACBrSATDinamico_cdecl.TesteFimAFim(dadosVenda : AnsiString) : String ;
Var
  Resp : PAnsiChar;
begin
  Resp := xSAT_TesteFimAFim( numeroSessao, PAnsiChar(codigoDeAtivacao),
                               PAnsiChar(dadosVenda) );
  Result := String( Resp );
end ;

function TACBrSATDinamico_cdecl.TrocarCodigoDeAtivacao(opcao : Integer ;
  novoCodigo, confNovoCodigo : String) : String ;
Var
  Resp : PAnsiChar;
begin
  Resp := xSAT_TrocarCodigoDeAtivacao( numeroSessao, PAnsiChar(codigoDeAtivacao),
                 opcao, PAnsiChar(novoCodigo), PAnsiChar(confNovoCodigo) ) ;
  Result := String( Resp );
end ;

procedure TACBrSATDinamico_cdecl.LoadDLLFunctions;
begin
  FunctionDetectLibSAT( 'AssociarAssinatura', @xSAT_AssociarAssinatura );
  FunctionDetectLibSAT( 'AtivarSAT', @xSAT_AtivarSAT );
  FunctionDetectLibSAT( 'AtualizarSoftwareSAT', @xSAT_AtualizarSoftwareSAT) ;
  FunctionDetectLibSAT( 'BloquearSAT', @xSAT_BloquearSAT);
  FunctionDetectLibSAT( 'CancelarUltimaVenda', @xSAT_CancelarUltimaVenda);
  FunctionDetectLibSAT( 'ComunicarCertificadoICPBRASIL', @xSAT_ComunicarCertificadoICPBRASIL);
  FunctionDetectLibSAT( 'ConfigurarInterfaceDeRede', @xSAT_ConfigurarInterfaceDeRede);
  FunctionDetectLibSAT( 'ConsultarNumeroSessao', @xSAT_ConsultarNumeroSessao);
  FunctionDetectLibSAT( 'ConsultarSAT', @xSAT_ConsultarSAT);
  FunctionDetectLibSAT( 'ConsultarStatusOperacional', @xSAT_ConsultarStatusOperacional);
  FunctionDetectLibSAT( 'DesbloquearSAT', @xSAT_DesbloquearSAT);
  FunctionDetectLibSAT( 'DesligarSAT', @xSAT_DesligarSAT);
  FunctionDetectLibSAT( 'EnviarDadosVenda', @xSAT_EnviarDadosVenda);
  FunctionDetectLibSAT( 'ExtrairLogs', @xSAT_ExtrairLogs);
  FunctionDetectLibSAT( 'TesteFimAFim', @xSAT_TesteFimAFim) ;
  FunctionDetectLibSAT( 'TrocarCodigoDeAtivacao', @xSAT_TrocarCodigoDeAtivacao);
end;

end.

(* Resposta válida do Kryptus
Result := IntToStr(numeroSessao)+#10+
'|06000'+#10+
'|0000'+#10+
'|Emitido com sucesso + conte?do das notas'+#10+
'|999'+#10+
'|Aviso nao catalogado'+#10+
'|PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz48Q0ZlIHhtbG5zPSJodHRwOi8vd3d3LmZhemVuZGEuc3AuZ292LmJyL3NhdCI+PGluZkNGZSB4bWxucz0iaHR0cDovL3d3dy5mYXplbmRhLnNwLmdvdi5ici9zYXQiIHhtbG5zOnhzZD0iaHR0cDovL3d3dy53My5vcmcvMjAwMS9YTUxTY2hlbWEiIHhtbG5zOnhzaT0iaHR0cDovL3d3dy53My5vcmcvMjAwMS9YTUxTY2hlbWEtaW5zdGFuY2UiIElkPSJDRmUzNTAxMDEwNTc2MTA5ODAwMDExMzU5OTAwMDAwMTg2MDAwMDAxMTkzMzEzMCIgdmVyc2FvPSIwLjAzIiB2ZXJzYW9EYWRvc0VudD0iMC4wMyIgdmVyc2FvU0I9IjAxMDAwMCI+PGlkZT48Y1VGPjM1PC9jVUY+PGNORj4xOTMzMTM8L2NORj48bW9kPjU5PC9tb2Q+PG5zZXJpZVNBVD45MDAwMDAxODY8L25zZXJpZVNBVD48bkNGZT4wMDAwMDE8L25DRmU+PGRFbWk+MjAwMTAxMDE8L2RFbWk+PGhFbWk+MDAwMDAwPC9oRW1pPjxjRFY+MDwvY0RWPjx0cEFtYj4yPC90cEFtYj48Q05QSj4xNjcxNjExNDAwMDE3MjwvQ05QSj48c2lnbkFDPjRGVXljNUg1eFF4N0pGR0dZOGNLbFB4RVNnSFM0RlV5YzVINXhReDdKRkdHWThjS2xQeEVTZ0hTNEZVeWM1SDV4UXg3SkZHR1k4Y0tsUHhFU2dIUzRGVXljNUg1eFF4N0pGR0dZOGNLbFB4RVNnSFM0RlV5YzVINXhReDdKRkdHWThjS2xQeEVTZ0hTNEZVeWM1SDV4UXg3SkZHR1k4Y0tsUHhFU2dIUzRGVXljNUg1eFF4N0pGR0dZOGNLbFB4RVNnSFM0RlV5YzVINXhReDdKRkdHWThjS2xQeEVTZ0hTNEZVeWM1SDV4UXg3SkZHR1k4Y0tsUHhFU2dIUzRGVXljNUg1eFF4N0pGR0dZOGNLbFB4RVNnSFM0RlV5YzVINXhReDdKRkdHWThjS2xQeEVTZ0hTNEZVeWM1SDV4UXg3SkZHR1k4Y0tsUHhFU2dIU2xQeEVTZ0hTPC9zaWduQUM+PGFzc2luYXR1cmFRUkNPREU+ZmZLeGRqQWNBNTBGdVdYVU5STGoyYnRqWS8rMWRXTmFpZEJHWFc3cHRxcXh2OHdjQVFBQUFIZ3ZCcDB3SEFPZGZDOEduVEFjQTUwQUFBQUFBQUFCQUFBQUFBQUpBQUFBbUM4R25RRUFBQURwQndBQU1Cd0RuVzg5QUFCQW9BQ2dBQUNJdjJvQUFBQVVvUUNnQUFDSXZ3QUFnTDhCQUFBQUFnQUFBQW9BQUFDRU1RR2cwTnNBb0tqYkFLQTVNUUdnZ0lDQWdBRUJBUUVCQUFBQUFESUJvQUFBQUFBQUFBQUFBUUFBQUlDQWdJQ0VNUUdncU5zQW9BQUFBYUFBbUFLZCtKY0NuZGlPQXAzZ2pnS2RDRElCb0M4QUFBQkFzQUNnQUFBQUFNaVlBcDF3TVFHZ0JESUZuVDU4QXAwREFCQUFBQUFBQk1pWUFwMXdNUUdnREh3RW5RPT14eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4PC9hc3NpbmF0dXJhUVJDT0RFPjxudW1lcm9DYWl4YT4wMDE8L251bWVyb0NhaXhhPjwvaWRlPjxlbWl0PjxDTlBKPjA1NzYxMDk4MDAwMTEzPC9DTlBKPjx4Tm9tZT5LUllQVFVTIFNFR1VSQU5DQSBEQSBJTkZPUk1BQ0FPIExUREE8L3hOb21lPjx4RmFudD5LUllQVFVTIFNPTFVDT0VTIEVNIFNFR1VSQU5DQSBEQSBJTkZPUk1BQ0FPPC94RmFudD48ZW5kZXJFbWl0Pjx4TGdyPlJVQSBGUkFOQ0lTQ0EgUkVTRU5ERSBNRVJDSUFJPC94TGdyPjxucm8+MTAyPC9ucm8+PHhDcGw+U0FMQSAgMDIgRSAwMzwveENwbD48eEJhaXJybz5CQVJBTyBHRVJBTERPPC94QmFpcnJvPjx4TXVuPkNBTVBJTkFTPC94TXVuPjxDRVA+MTMwODQxOTU8L0NFUD48L2VuZGVyRW1pdD48SUU+MTExMTExMTExMTExPC9JRT48Y1JlZ1RyaWI+MzwvY1JlZ1RyaWI+PGluZFJhdElTU1FOPlM8L2luZFJhdElTU1FOPjwvZW1pdD48ZGVzdD48Q1BGPjQxMjc4OTAzMjA4PC9DUEY+PC9kZXN0PjxkZXQgbkl0ZW09IjEiPjxwcm9kPjxjUHJvZD5hPC9jUHJvZD48eFByb2Q+YTwveFByb2Q+PENGT1A+NTUwMDwvQ0ZPUD48dUNvbT5oPC91Q29tPjxxQ29tPjAwMDAwMDAwMDEuMTIwNTwvcUNvbT48dlVuQ29tPjAwMDAwMDAwMDExLjIxMDwvdlVuQ29tPjx2UHJvZD4wMDAwMDAwMDAwMDEyLjU2PC92UHJvZD48aW5kUmVncmE+VDwvaW5kUmVncmE+PHZJdGVtPjAwMDAwMDAwMDAwMTIuNTY8L3ZJdGVtPjwvcHJvZD48aW1wb3N0bz48SUNNUz48SUNNU1NOOTAwPjxPcmlnPjA8L09yaWc+PENTT1NOPjkwMDwvQ1NPU04+PHBJQ01TPjAzMy42PC9wSUNNUz48dklDTVM+MDAwMDAwMDAwMDAwNC4yMjwvdklDTVM+PC9JQ01TU045MDA+PC9JQ01TPjxQSVM+PFBJU0FsaXE+PENTVD4wMjwvQ1NUPjx2QkM+MDAwMDAwMDAwODE3LjY0PC92QkM+PHBQSVM+Mi4zMDY8L3BQSVM+PHZQSVM+MDAwMDAwMDAwMTg4NS40ODwvdlBJUz48L1BJU0FsaXE+PC9QSVM+PFBJU1NUPjxxQkNQcm9kPjAwMDAwMDA3NzM1LjMyMDc8L3FCQ1Byb2Q+PHZBbGlxUHJvZD4wMDAwMDAwOTg3Ljk1NDI8L3ZBbGlxUHJvZD48dlBJUz4wMDAwMDA3NjQyMTQyLjU3PC92UElTPjwvUElTU1Q+PENPRklOUz48Q09GSU5TTlQ+PENTVD4wNDwvQ1NUPjwvQ09GSU5TTlQ+PC9DT0ZJTlM+PENPRklOU1NUPjx2QkM+MDAwMDAwMDg3MjA2LjQ2PC92QkM+PHBDT0ZJTlM+MS44NDU8L3BDT0ZJTlM+PHZDT0ZJTlM+MDAwMDAwMDE2MDg5NS45MjwvdkNPRklOUz48L0NPRklOU1NUPjwvaW1wb3N0bz48L2RldD48dG90YWw+PElDTVNUb3Q+PHZJQ01TPjAwMDAwMDAwMDAwMDQuMjI8L3ZJQ01TPjx2UHJvZD4wMDAwMDAwMDAwMDEyLjU2PC92UHJvZD48dkRlc2M+MDAwMDAwMDAwMDAwMC4wMDwvdkRlc2M+PHZQSVM+MDAwMDAwMDAwMTg4NS40ODwvdlBJUz48dkNPRklOUz4wMDAwMDAwMDAwMDAwLjAwPC92Q09GSU5TPjx2UElTU1Q+MDAwMDAwNzY0MjE0Mi41NzwvdlBJU1NUPjx2Q09GSU5TU1Q+MDAwMDAwMDE2MDg5NS45MjwvdkNPRklOU1NUPjx2T3V0cm8+MDAwMDAwMDAwMDAwMC4wMDwvdk91dHJvPjwvSUNNU1RvdD48dkNGZT4wMDAwMDAwMDAwMDEyLjU2PC92Q0ZlPjwvdG90YWw+PHBndG8+PE1QPjxjTVA+MDI8L2NNUD48dk1QPjAwMDAwOTk5OTk5OS45OTwvdk1QPjwvTVA+PHZUcm9jbz4wMDAwMDA5OTk5OTg3LjQzPC92VHJvY28+PC9wZ3RvPjwvaW5mQ0ZlPjxTaWduYXR1cmUgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvMDkveG1sZHNpZyMiPjxTaWduZWRJbmZvIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwLzA5L3htbGRzaWcjIiB4bWxuczp4c2Q9Imh0dHA6Ly93d3cudzMub3JnLzIwMDEvWE1MU2NoZW1hIiB4bWxuczp4c2k9Imh0dHA6Ly93d3cudzMub3JnLzIwMDEvWE1MU2NoZW1hLWluc3RhbmNlIj48Q2Fub25pY2FsaXphdGlvbk1ldGhvZCBBbGdvcml0aG09Imh0dHA6Ly93d3cudzMub3JnL1RSLzIwMDEvUkVDLXhtbC1jMTRuLTIwMDEwMzE1Ii8+PFNpZ25hdHVyZU1ldGhvZCBBbGdvcml0aG09Imh0dHA6Ly93d3cudzMub3JnLzIwMDEvMDQveG1sZHNpZy1tb3JlI3JzYS1zaGEyNTYiLz48UmVmZXJlbmNlIFVSST0iI0NGZTM1MDEwMTA1NzYxMDk4MDAwMTEzNTk5MDAwMDAxODYwMDAwMDExOTMzMTMwIj48VHJhbnNmb3Jtcz48VHJhbnNmb3JtIEFsZ29yaXRobT0iaHR0cDovL3d3dy53My5vcmcvMjAwMC8wOS94bWxkc2lnI2VudmVsb3BlZC1zaWduYXR1cmUiLz48VHJhbnNmb3JtIEFsZ29yaXRobT0iaHR0cDovL3d3dy53My5vcmcvVFIvMjAwMS9SRUMteG1sLWMxNG4tMjAwMTAzMTUiLz48L1RyYW5zZm9ybXM+PERpZ2VzdE1ldGhvZCBBbGdvcml0aG09Imh0dHA6Ly93d3cudzMub3JnLzIwMDEvMDQveG1sZW5jI3NoYTI1NiIvPjxEaWdlc3RWYWx1ZT5LTzVBVU9Zbng3c2dOVmozSEtvVFVkR2pJbkFCZEoweWVGamxvYXlScHBzPTwvRGlnZXN0VmFsdWU+PC9SZWZlcmVuY2U+PC9TaWduZWRJbmZvPjxTaWduYXR1cmVWYWx1ZT5oUXEzSnpnaEd5NU93bWNvUzRDUWNrQXZBYUFZTUFHZ0FBQUFBRWd2QWFBQkFBQUFnQzhCb09DT0FwMElNZ0dnQUFBQUFNOWhhMk5JTHdHZ3AvUlJlWVo2d2orNHZqQUlRSlFBb0ZjQUFBQVlNQUdnS0lzQW9DajhBYUFzK2dHZ2pDOEFuYlJGSCtkV1V2SG5MNXQ1VTRBeThNNUFBQUFBRndBQUFEQXdNREF3TURBd01USTFmRFF4TWpjNE9UQXpNakE0Z0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFyaTNQSVJ4R1VnTjR3OTZJdU45WlNBZXJDOEJvR0FvSXNydGlLNjZMcGM3OXdBQUFBQWM2QVdkS0dCMnBmSnJPNnRteE9JWFpUUVl3MUdjTmxZNXFLUllHNFlwZ3c9PTwvU2lnbmF0dXJlVmFsdWU+PEtleUluZm8+PFg1MDlEYXRhPjxYNTA5Q2VydGlmaWNhdGU+PC9YNTA5Q2VydGlmaWNhdGU+PC9YNTA5RGF0YT48L0tleUluZm8+PC9TaWduYXR1cmU+PC9DRmU+'+#10+
'|20010101000000'+#10+
'|35010105761098000113599000001860000011933130'+#10+
'|000000000000125'+#10+
'|';
*)
