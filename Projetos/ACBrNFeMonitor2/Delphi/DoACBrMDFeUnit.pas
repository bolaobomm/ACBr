{******************************************************************************}
{ Projeto: ACBrNFeMonitor                                                      }
{  Executavel multiplataforma que faz uso do conjunto de componentes ACBr para }
{ criar uma interface de comunicação com equipamentos de automacao comercial.  }
{                                                                              }
{ Direitos Autorais Reservados (c) 2009 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
{                                                                              }
{  Você pode obter a última versão desse arquivo na página do Projeto ACBr     }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr      }
{                                                                              }
{  Este programa é software livre; você pode redistribuí-lo e/ou modificá-lo   }
{ sob os termos da Licença Pública Geral GNU, conforme publicada pela Free     }
{ Software Foundation; tanto a versão 2 da Licença como (a seu critério)       }
{ qualquer versão mais nova.                                                   }
{                                                                              }
{  Este programa é distribuído na expectativa de ser útil, mas SEM NENHUMA     }
{ GARANTIA; nem mesmo a garantia implícita de COMERCIALIZAÇÃO OU DE ADEQUAÇÃO A}
{ QUALQUER PROPÓSITO EM PARTICULAR. Consulte a Licença Pública Geral GNU para  }
{ obter mais detalhes. (Arquivo LICENCA.TXT ou LICENSE.TXT)                    }
{                                                                              }
{  Você deve ter recebido uma cópia da Licença Pública Geral GNU junto com este}
{ programa; se não, escreva para a Free Software Foundation, Inc., 59 Temple   }
{ Place, Suite 330, Boston, MA 02111-1307, USA. Você também pode obter uma     }
{ copia da licença em:  http://www.opensource.org/licenses/gpl-license.php     }
{                                                                              }
{ Daniel Simões de Almeida  -  daniel@djsystem.com.br  -  www.djsystem.com.br  }
{              Praça Anita Costa, 34 - Tatuí - SP - 18270-410                  }
{                                                                              }
{******************************************************************************}
{$I ACBr.inc}

unit DoACBrMDFeUnit;

interface
Uses Classes, SysUtils, CmdUnitNFe, 

     ACBrNFeUtil, ACBrDFeUtil;

Procedure DoACBrMDFe( Cmd : TACBrNFeCTeCmd );
procedure GerarIniMDFe( AStr: WideString );
function GerarMDFeIni( XML : WideString ) : WideString;

implementation

Uses IniFiles, DateUtils,
  Windows, Forms, 
  ACBrUtil, ACBrNFeMonitor1 , ACBrMDFeWebServices,
  ACBrMDFeConfiguracoes,
  pcnConversao, pmdfeConversao,

  pcnAuxiliar,
  
  pmdfeMDFeR, pmdfeRetConsReciMDFe,
  ACBrMDFeManifestos, pmdfeMDFe, DoACBrNFeUnit;

Procedure DoACBrMDFe( Cmd : TACBrNFeCTeCmd );
var
  I,J : Integer;
  ArqMDFe, ArqPDF, Chave : String;
  Salva,  OK : Boolean;
  SL     : TStringList;
  Alertas : AnsiString;

  Memo   : TStringList;
  Files  : String;
  dtFim  : TDateTime;

  RetFind   : Integer;
  SearchRec : TSearchRec;

//  MDFeRTXT            :  TNFeRTXT;
begin
 with frmAcbrNfeMonitor do
  begin
     try
        if Cmd.Metodo = 'statusservico' then
         begin
           if ACBrMDFe1.WebServices.StatusServico.Executar then
            begin

              Cmd.Resposta := ACBrMDFe1.WebServices.StatusServico.Msg+
                              '[STATUS]'+sLineBreak+
                              'Versao='+ACBrMDFe1.WebServices.StatusServico.verAplic+sLineBreak+
                              'TpAmb='+TpAmbToStr(ACBrMDFe1.WebServices.StatusServico.TpAmb)+sLineBreak+
                              'VerAplic='+ACBrMDFe1.WebServices.StatusServico.VerAplic+sLineBreak+
                              'CStat='+IntToStr(ACBrMDFe1.WebServices.StatusServico.CStat)+sLineBreak+
                              'XMotivo='+ACBrMDFe1.WebServices.StatusServico.XMotivo+sLineBreak+
                              'CUF='+IntToStr(ACBrMDFe1.WebServices.StatusServico.CUF)+sLineBreak+
                              'DhRecbto='+DateTimeToStr(ACBrMDFe1.WebServices.StatusServico.DhRecbto)+sLineBreak+
                              'TMed='+IntToStr(ACBrMDFe1.WebServices.StatusServico.TMed)+sLineBreak+
                              'DhRetorno='+DateTimeToStr(ACBrMDFe1.WebServices.StatusServico.DhRetorno)+sLineBreak+
                              'XObs='+ACBrMDFe1.WebServices.StatusServico.XObs+sLineBreak;
            end;
         end
        else if Cmd.Metodo = 'validarmdfe' then
         begin
           ACBrMDFe1.Manifestos.Clear;
           if FileExists(Cmd.Params(0)) then
              ACBrMDFe1.Manifestos.LoadFromFile(Cmd.Params(0))
           else
              raise Exception.Create('Arquivo '+Cmd.Params(0)+' não encontrado.');

           ACBrMDFe1.Manifestos.Valida;
         end
        else if Cmd.Metodo = 'assinarmdfe' then
         begin
           ACBrMDFe1.Manifestos.Clear;
           if FileExists(Cmd.Params(0)) then
              ACBrMDFe1.Manifestos.LoadFromFile(Cmd.Params(0))
           else
              raise Exception.Create('Arquivo '+Cmd.Params(0)+' não encontrado.');

           Salva := ACBrMDFe1.Configuracoes.Geral.Salvar;
           if not Salva then
            begin
             ForceDirectories(PathWithDelim(ExtractFilePath(Application.ExeName))+'Logs');
             ACBrMDFe1.Configuracoes.Geral.PathSalvar := PathWithDelim(ExtractFilePath(Application.ExeName))+'Logs';
            end;
           ACBrMDFe1.Configuracoes.Geral.Salvar := True;
           ACBrMDFe1.Manifestos.Assinar;
           ACBrMDFe1.Configuracoes.Geral.Salvar := Salva;
           if DFeUtil.NaoEstaVazio(ACBrMDFe1.Manifestos.Items[0].NomeArq) then
              Cmd.Resposta := ACBrMDFe1.Manifestos.Items[0].NomeArq
           else
              Cmd.Resposta := PathWithDelim(ACBrMDFe1.Configuracoes.Geral.PathSalvar)+StringReplace(ACBrMDFe1.Manifestos.Items[0].MDFe.infMDFe.ID, 'MDFe', '', [rfIgnoreCase])+'-mdfe.xml';
         end
        else if Cmd.Metodo = 'consultarmdfe' then
         begin
           if FileExists(Cmd.Params(0)) or FileExists(PathWithDelim(ACBrMDFe1.Configuracoes.Geral.PathSalvar)+Cmd.Params(0)) then
            begin
              ACBrMDFe1.Manifestos.Clear;
              if FileExists(PathWithDelim(ACBrMDFe1.Configuracoes.Geral.PathSalvar)+Cmd.Params(0)) then
                 ACBrMDFe1.Manifestos.LoadFromFile(PathWithDelim(ACBrMDFe1.Configuracoes.Geral.PathSalvar)+Cmd.Params(0))
              else
                 ACBrMDFe1.Manifestos.LoadFromFile(Cmd.Params(0));

              ACBrMDFe1.WebServices.Consulta.MDFeChave := OnlyNumber(ACBrMDFe1.Manifestos.Items[0].MDFe.infMDFe.ID);
            end
           else
            begin
              if not ValidarChave('MDFe'+Cmd.Params(0)) then
                 raise Exception.Create('Chave '+Cmd.Params(0)+' inválida.')
              else
                 ACBrMDFe1.WebServices.Consulta.MDFeChave := Cmd.Params(0);
            end;
           try
              ACBrMDFe1.WebServices.Consulta.Executar;

              Cmd.Resposta := ACBrMDFe1.WebServices.Consulta.Msg+sLineBreak+
                              '[CONSULTA]'+sLineBreak+
                              'Versao='+ACBrMDFe1.WebServices.Consulta.verAplic+sLineBreak+
                              'TpAmb='+TpAmbToStr(ACBrMDFe1.WebServices.Consulta.TpAmb)+sLineBreak+
                              'VerAplic='+ACBrMDFe1.WebServices.Consulta.VerAplic+sLineBreak+
                              'CStat='+IntToStr(ACBrMDFe1.WebServices.Consulta.CStat)+sLineBreak+
                              'XMotivo='+ACBrMDFe1.WebServices.Consulta.XMotivo+sLineBreak+
                              'CUF='+IntToStr(ACBrMDFe1.WebServices.Consulta.CUF)+sLineBreak+
                              'ChMDFe='+ACBrMDFe1.WebServices.Consulta.MDFeChave+sLineBreak+
                              'DhRecbto='+DateTimeToStr(ACBrMDFe1.WebServices.Consulta.DhRecbto)+sLineBreak+
                              'NProt='+ACBrMDFe1.WebServices.Consulta.Protocolo+sLineBreak+
                              'DigVal='+ACBrMDFe1.WebServices.Consulta.protMDFe.digVal+sLineBreak;

           except
              raise Exception.Create(ACBrMDFe1.WebServices.Consulta.Msg);
           end;
         end
        else if Cmd.Metodo = 'cancelarmdfe' then
         begin

           if not ValidarChave('MDFe'+Cmd.Params(0)) then
              raise Exception.Create('Chave '+Cmd.Params(0)+' inválida.')
           else
              ACBrMDFe1.WebServices.Consulta.MDFeChave := Cmd.Params(0);

           if not ACBrMDFe1.WebServices.Consulta.Executar then
              raise Exception.Create(ACBrMDFe1.WebServices.Consulta.Msg);

           ACBrMDFe1.EventoMDFe.Evento.Clear;
           with ACBrMDFe1.EventoMDFe.Evento.Add do
           begin
             infEvento.CNPJ := Cmd.Params(2);
             if Trim(infEvento.CNPJ) = '' then
                infEvento.CNPJ := copy(DFeUtil.LimpaNumero(ACBrMDFe1.WebServices.Consulta.MDFeChave),7,14)
             else
             begin
                if not ValidarCNPJ(Cmd.Params(2)) then
                  raise Exception.Create('CNPJ '+Cmd.Params(2)+' inválido.')
             end;

             infEvento.cOrgao   := StrToIntDef(copy(DFeUtil.LimpaNumero(ACBrMDFe1.WebServices.Consulta.MDFeChave),1,2),0);
             infEvento.dhEvento := now;
             infEvento.tpEvento := teCancelamento;
             infEvento.chMDFe   := ACBrMDFe1.WebServices.Consulta.MDFeChave;
             infEvento.detEvento.nProt := ACBrMDFe1.WebServices.Consulta.Protocolo;
             infEvento.detEvento.xJust := Cmd.Params(1);
           end;
           try
              ACBrMDFe1.EnviarEventoMDFe(StrToIntDef(Cmd.Params(3),1));

              Cmd.Resposta := ACBrMDFe1.WebServices.EnvEvento.EventoRetorno.xMotivo+sLineBreak+
                              '[CANCELAMENTO]'+sLineBreak+
                              'Versao='+ACBrMDFe1.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.verAplic+sLineBreak+
                              'TpAmb='+TpAmbToStr(ACBrMDFe1.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.TpAmb)+sLineBreak+
                              'VerAplic='+ACBrMDFe1.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.VerAplic+sLineBreak+
                              'CStat='+IntToStr(ACBrMDFe1.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.cStat)+sLineBreak+
                              'XMotivo='+ACBrMDFe1.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.XMotivo+sLineBreak+
                              'CUF='+IntToStr(ACBrMDFe1.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.cOrgao)+sLineBreak+
                              'ChMDFe='+ACBrMDFe1.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.chMDFe+sLineBreak+
                              'DhRecbto='+DateTimeToStr(ACBrMDFe1.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.dhRegEvento)+sLineBreak+
                              'NProt='+ACBrMDFe1.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.nProt+sLineBreak+
                              'tpEvento='+TpEventoToStr(ACBrMDFe1.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.tpEvento)+sLineBreak+
                              'xEvento='+ACBrMDFe1.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.xEvento+sLineBreak+
                              'nSeqEvento='+IntToStr(ACBrMDFe1.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.nSeqEvento)+sLineBreak+
                              'CNPJDest='+ACBrMDFe1.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.CNPJDest+sLineBreak+
                              'emailDest='+ACBrMDFe1.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.emailDest+sLineBreak+
                              'XML='+ACBrMDFe1.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.XML+sLineBreak;
           except
              raise Exception.Create(ACBrMDFe1.WebServices.EnvEvento.EventoRetorno.xMotivo);
           end;
         end
        else if Cmd.Metodo = 'imprimirdamdfe' then
         begin
           if ACBrMDFe1.DAMDFe.MostrarPreview then
            begin
              Restaurar1.Click;
              Application.BringToFront;
            end;
           ACBrMDFe1.Manifestos.Clear;
           if FileExists(Cmd.Params(0)) or FileExists(PathWithDelim(ACBrMDFe1.Configuracoes.Geral.PathSalvar)+Cmd.Params(0)) then
            begin
              if FileExists(Cmd.Params(0)) then
                 ACBrMDFe1.Manifestos.LoadFromFile(Cmd.Params(0))
              else
                 ACBrMDFe1.Manifestos.LoadFromFile(PathWithDelim(ACBrMDFe1.Configuracoes.Geral.PathSalvar)+Cmd.Params(0));
            end
           else
              raise Exception.Create('Arquivo '+Cmd.Params(0)+' não encontrado.');

           if DFeUtil.NaoEstaVazio(Cmd.Params(1)) then
              ACBrMDFe1.DAMDFe.Impressora := Cmd.Params(1)
           else
              ACBrMDFe1.DAMDFe.Impressora := cbxImpressora.Text;

           if DFeUtil.NaoEstaVazio(Cmd.Params(2)) then
              ACBrMDFe1.DAMDFe.NumCopias := StrToIntDef(Cmd.Params(2),1)
           else
              ACBrMDFe1.DAMDFe.NumCopias := StrToIntDef(edtNumCopia.Text,1);

           if DFeUtil.NaoEstaVazio(Cmd.Params(3)) then
              ACBrMDFe1.DAMDFe.ProtocoloMDFe := Cmd.Params(3);
           ACBrMDFe1.Manifestos.Imprimir;
           Cmd.Resposta := 'DAMDFe Impresso com sucesso';
           if ACBrMDFe1.DAMDFe.MostrarPreview then
              Ocultar1.Click;
         end
        else if Cmd.Metodo = 'imprimirdamdfepdf' then
         begin
           ACBrMDFe1.Manifestos.Clear;
           if FileExists(Cmd.Params(0)) then
              ACBrMDFe1.Manifestos.LoadFromFile(Cmd.Params(0))
           else
              raise Exception.Create('Arquivo '+Cmd.Params(0)+' não encontrado.');

           if DFeUtil.NaoEstaVazio(Cmd.Params(1)) then
              ACBrMDFe1.DAMDFe.ProtocoloMDFe := Cmd.Params(1);

           try
              ACBrMDFe1.Manifestos.ImprimirPDF;
              ArqPDF := OnlyNumber(ACBrMDFe1.Manifestos.Items[0].MDFe.infMDFe.ID)+'.pdf';
              Cmd.Resposta := 'Arquivo criado em: '+ PathWithDelim(ACBrMDFe1.DAMDFe.PathPDF) +
                              ArqPDF;
           except
              raise Exception.Create('Erro ao criar o arquivo PDF');
           end;
         end
        else if Cmd.Metodo = 'inutilizarmdfe' then
         begin                            //CNPJ         //Justificat   //Ano                    //Modelo                 //Série                  //Num.Inicial            //Num.Final
           (*
           ACBrMDFe1.WebServices.Inutiliza(Cmd.Params(0), Cmd.Params(1), StrToInt(Cmd.Params(2)), StrToInt(Cmd.Params(3)), StrToInt(Cmd.Params(4)), StrToInt(Cmd.Params(5)), StrToInt(Cmd.Params(6)));

           Cmd.Resposta := ACBrMDFe1.WebServices.Inutilizacao.Msg+sLineBreak+
                           '[INUTILIZACAO]'+sLineBreak+
                           'Versao='+ACBrMDFe1.WebServices.Inutilizacao.verAplic+sLineBreak+
                           'TpAmb='+TpAmbToStr(ACBrMDFe1.WebServices.Inutilizacao.TpAmb)+sLineBreak+
                           'VerAplic='+ACBrMDFe1.WebServices.Inutilizacao.VerAplic+sLineBreak+
                           'CStat='+IntToStr(ACBrMDFe1.WebServices.Inutilizacao.CStat)+sLineBreak+
                           'XMotivo='+ACBrMDFe1.WebServices.Inutilizacao.XMotivo+sLineBreak+
                           'CUF='+IntToStr(ACBrMDFe1.WebServices.Inutilizacao.CUF)+sLineBreak+
                           'DhRecbto='+DateTimeToStr(ACBrMDFe1.WebServices.Inutilizacao.DhRecbto)+sLineBreak+
                           'NProt='+ACBrMDFe1.WebServices.Inutilizacao.Protocolo+sLineBreak;
           *)                
         end
        else if Cmd.Metodo = 'enviarmdfe' then
         begin
           ACBrMDFe1.Manifestos.Clear;
           if FileExists(Cmd.Params(0)) then
              ACBrMDFe1.Manifestos.LoadFromFile(Cmd.Params(0))
           else
              raise Exception.Create('Arquivo '+Cmd.Params(0)+' não encontrado.');

           ACBrMDFe1.Manifestos.GerarMDFe;
           if Cmd.Params(2) <> '0' then
              ACBrMDFe1.Manifestos.Assinar;

           ACBrMDFe1.Manifestos.Valida;

           if not(ACBrMDFe1.WebServices.StatusServico.Executar) then
            raise Exception.Create(ACBrMDFe1.WebServices.StatusServico.Msg);

           if Trim(OnlyNumber(Cmd.Params(1))) = '' then
              ACBrMDFe1.WebServices.Enviar.Lote := '1'
           else
              ACBrMDFe1.WebServices.Enviar.Lote := OnlyNumber(Cmd.Params(1)); //StrToIntDef( OnlyNumber(Cmd.Params(1)),1);

           ACBrMDFe1.WebServices.Enviar.Executar;

           Cmd.Resposta :=  ACBrMDFe1.WebServices.Enviar.Msg+sLineBreak+
                            '[ENVIO]'+sLineBreak+
                            'Versao='+ACBrMDFe1.WebServices.Enviar.verAplic+sLineBreak+
                            'TpAmb='+TpAmbToStr(ACBrMDFe1.WebServices.Enviar.TpAmb)+sLineBreak+
                            'VerAplic='+ACBrMDFe1.WebServices.Enviar.VerAplic+sLineBreak+
                            'CStat='+IntToStr(ACBrMDFe1.WebServices.Enviar.CStat)+sLineBreak+
                            'XMotivo='+ACBrMDFe1.WebServices.Enviar.XMotivo+sLineBreak+
                            'CUF='+IntToStr(ACBrMDFe1.WebServices.Enviar.CUF)+sLineBreak+
                            'NRec='+ACBrMDFe1.WebServices.Enviar.Recibo+sLineBreak+
                            'DhRecbto='+DateTimeToStr( ACBrMDFe1.WebServices.Enviar.dhRecbto)+sLineBreak+
                            'TMed='+IntToStr( ACBrMDFe1.WebServices.Enviar.tMed)+sLineBreak;

           ACBrMDFe1.WebServices.Retorno.Recibo := ACBrMDFe1.WebServices.Enviar.Recibo;
           ACBrMDFe1.WebServices.Retorno.Executar;

           Cmd.Resposta :=  Cmd.Resposta+
                            ACBrMDFe1.WebServices.Retorno.Msg+sLineBreak+
                            '[RETORNO]'+sLineBreak+
                            'Versao='+ACBrMDFe1.WebServices.Retorno.verAplic+sLineBreak+
                            'TpAmb='+TpAmbToStr(ACBrMDFe1.WebServices.Retorno.TpAmb)+sLineBreak+
                            'VerAplic='+ACBrMDFe1.WebServices.Retorno.VerAplic+sLineBreak+
                            'NRec='+ACBrMDFe1.WebServices.Retorno.MDFeRetorno.nRec+sLineBreak+
                            'CStat='+IntToStr(ACBrMDFe1.WebServices.Retorno.CStat)+sLineBreak+
                            'XMotivo='+ACBrMDFe1.WebServices.Retorno.XMotivo+sLineBreak+
                            'CUF='+IntToStr(ACBrMDFe1.WebServices.Retorno.CUF)+sLineBreak;

           for I:= 0 to ACBrMDFe1.WebServices.Retorno.MDFeRetorno.ProtMDFe.Count-1 do
            begin
              for J:= 0 to ACBrMDFe1.Manifestos.Count-1 do
              begin
                if 'MDFe'+ACBrMDFe1.WebServices.Retorno.MDFeRetorno.ProtMDFe.Items[i].chMDFe = ACBrMDFe1.Manifestos.Items[j].MDFe.infMDFe.Id  then
                begin
                  Cmd.Resposta := Cmd.Resposta+
                             '[MDFe'+Trim(IntToStr(ACBrMDFe1.Manifestos.Items[J].MDFe.Ide.nMDF))+']'+sLineBreak+
                             'Versao='+ACBrMDFe1.WebServices.Retorno.MDFeRetorno.ProtMDFe.Items[i].verAplic+sLineBreak+
                             'TpAmb='+TpAmbToStr(ACBrMDFe1.WebServices.Retorno.MDFeRetorno.ProtMDFe.Items[i].tpAmb)+sLineBreak+
                             'VerAplic='+ACBrMDFe1.WebServices.Retorno.MDFeRetorno.ProtMDFe.Items[i].verAplic+sLineBreak+
                             'CStat='+IntToStr(ACBrMDFe1.WebServices.Retorno.MDFeRetorno.ProtMDFe.Items[i].cStat)+sLineBreak+
                             'XMotivo='+ACBrMDFe1.WebServices.Retorno.MDFeRetorno.ProtMDFe.Items[i].xMotivo+sLineBreak+
                             'CUF='+IntToStr(ACBrMDFe1.WebServices.Retorno.MDFeRetorno.cUF)+sLineBreak+
                             'ChMDFe='+ACBrMDFe1.WebServices.Retorno.MDFeRetorno.ProtMDFe.Items[i].chMDFe+sLineBreak+
                             'DhRecbto='+DateTimeToStr(ACBrMDFe1.WebServices.Retorno.MDFeRetorno.ProtMDFe.Items[i].dhRecbto)+sLineBreak+
                             'NProt='+ACBrMDFe1.WebServices.Retorno.MDFeRetorno.ProtMDFe.Items[i].nProt+sLineBreak+
                             'DigVal='+ACBrMDFe1.WebServices.Retorno.MDFeRetorno.ProtMDFe.Items[i].digVal+sLineBreak;
                  break;
                end;
              end;

              if DFeUtil.NaoEstaVazio(Cmd.Params(4)) then
                 ACBrMDFe1.DAMDFe.Impressora := Cmd.Params(4)
              else
                 ACBrMDFe1.DAMDFe.Impressora := cbxImpressora.Text;

              if ACBrMDFe1.Manifestos.Items[i].Confirmada and (Cmd.Params(3) = '1') then
                 ACBrMDFe1.Manifestos.Items[i].Imprimir;
            end;
         end
        else if (Cmd.Metodo = 'recibomdfe')then
         begin
           ACBrMDFe1.WebServices.Recibo.Recibo := Cmd.Params(0);
           if not(ACBrMDFe1.WebServices.Recibo.Executar) then
             raise Exception.Create(ACBrMDFe1.WebServices.Recibo.xMotivo);

           Cmd.Resposta :=  Cmd.Resposta+
                            ACBrMDFe1.WebServices.Recibo.Msg+sLineBreak+
                           '[RETORNO]'+sLineBreak+
                           'Versao='+ACBrMDFe1.WebServices.Recibo.verAplic+sLineBreak+
                           'TpAmb='+TpAmbToStr(ACBrMDFe1.WebServices.Recibo.TpAmb)+sLineBreak+
                           'VerAplic='+ACBrMDFe1.WebServices.Recibo.VerAplic+sLineBreak+
                           'NRec='+ACBrMDFe1.WebServices.Recibo.Recibo+sLineBreak+
                           'CStat='+IntToStr(ACBrMDFe1.WebServices.Recibo.CStat)+sLineBreak+
                           'XMotivo='+ACBrMDFe1.WebServices.Recibo.XMotivo+sLineBreak+
                           'CUF='+IntToStr(ACBrMDFe1.WebServices.Recibo.CUF)+sLineBreak+
                           'ChMDFe='+ACBrMDFe1.WebServices.Recibo.MDFeRetorno.ProtMDFe.Items[0].chMDFe+sLineBreak+
                           'NProt='+ACBrMDFe1.WebServices.Recibo.MDFeRetorno.ProtMDFe.Items[0].nProt+sLineBreak+
                           'MotivoMDFe='+ACBrMDFe1.WebServices.Recibo.MDFeRetorno.ProtMDFe.Items[0].xMotivo+sLineBreak;

                           for I:= 0 to ACBrMDFe1.WebServices.Recibo.MDFeRetorno.ProtMDFe.Count-1 do
                            begin
                              Cmd.Resposta := Cmd.Resposta+
                                '[MDFe'+Trim(IntToStr(StrToInt(copy(ACBrMDFe1.WebServices.Recibo.MDFeRetorno.ProtMDFe.Items[i].chMDFe,26,9))))+']'+sLineBreak+
                                'Versao='+ACBrMDFe1.WebServices.Recibo.MDFeRetorno.ProtMDFe.Items[i].verAplic+sLineBreak+
                                'TpAmb='+TpAmbToStr(ACBrMDFe1.WebServices.Recibo.MDFeRetorno.ProtMDFe.Items[i].tpAmb)+sLineBreak+
                                'VerAplic='+ACBrMDFe1.WebServices.Recibo.MDFeRetorno.ProtMDFe.Items[i].verAplic+sLineBreak+
                                'CStat='+IntToStr(ACBrMDFe1.WebServices.Recibo.MDFeRetorno.ProtMDFe.Items[i].cStat)+sLineBreak+
                                'XMotivo='+ACBrMDFe1.WebServices.Recibo.MDFeRetorno.ProtMDFe.Items[i].xMotivo+sLineBreak+
                                'CUF='+IntToStr(ACBrMDFe1.WebServices.Recibo.MDFeRetorno.cUF)+sLineBreak+
                                'ChMDFe='+ACBrMDFe1.WebServices.Recibo.MDFeRetorno.ProtMDFe.Items[i].chMDFe+sLineBreak+
                                'DhRecbto='+DateTimeToStr(ACBrMDFe1.WebServices.Recibo.MDFeRetorno.ProtMDFe.Items[i].dhRecbto)+sLineBreak+
                                'NProt='+ACBrMDFe1.WebServices.Recibo.MDFeRetorno.ProtMDFe.Items[i].nProt+sLineBreak+
                                'DigVal='+ACBrMDFe1.WebServices.Recibo.MDFeRetorno.ProtMDFe.Items[i].digVal+sLineBreak;
                            end;

           if ACBrMDFe1.Configuracoes.Geral.Salvar then
            begin
              Cmd.Resposta :=  Cmd.Resposta+
              'Arquivo='+ACBrMDFe1.Configuracoes.Geral.PathSalvar+Cmd.Params(0)+'-pro-rec.xml';
            end;
         end
        else if (Cmd.Metodo = 'consultacadastro')then
         begin
           (*
           ACBrMDFe1.WebServices.ConsultaCadastro.UF   := Cmd.Params(0);
           if Cmd.Params(2) = '1' then
              ACBrMDFe1.WebServices.ConsultaCadastro.IE := Cmd.Params(1)
           else
            begin
              if Length(Cmd.Params(1)) > 11 then
                 ACBrMDFe1.WebServices.ConsultaCadastro.CNPJ := Cmd.Params(1)
              else
                 ACBrMDFe1.WebServices.ConsultaCadastro.CPF := Cmd.Params(1);
            end;
            ACBrMDFe1.WebServices.ConsultaCadastro.Executar;

            Cmd.Resposta :=  Cmd.Resposta+
                             ACBrMDFe1.WebServices.ConsultaCadastro.Msg+sLineBreak+
                             'VerAplic='+ACBrMDFe1.WebServices.ConsultaCadastro.verAplic+sLineBreak+
                             'cStat='+IntToStr(ACBrMDFe1.WebServices.ConsultaCadastro.cStat)+sLineBreak+
                             'xMotivo='+ACBrMDFe1.WebServices.ConsultaCadastro.xMotivo+sLineBreak+
                             'DhCons='+DateTimeToStr(ACBrMDFe1.WebServices.ConsultaCadastro.DhCons)+sLineBreak+
                             'cUF='+IntToStr(ACBrMDFe1.WebServices.ConsultaCadastro.cUF)+sLineBreak+
                             'IE='+ACBrMDFe1.WebServices.ConsultaCadastro.RetConsCad.InfCad.Items[0].IE+sLineBreak+
                             'CNPJ='+ACBrMDFe1.WebServices.ConsultaCadastro.RetConsCad.InfCad.Items[0].CNPJ+sLineBreak+
                             'CPF='+ACBrMDFe1.WebServices.ConsultaCadastro.RetConsCad.InfCad.Items[0].CPF+sLineBreak+
                             'UF='+ACBrMDFe1.WebServices.ConsultaCadastro.RetConsCad.InfCad.Items[0].UF+sLineBreak+
                             'cSit='+IntToStr(ACBrMDFe1.WebServices.ConsultaCadastro.RetConsCad.InfCad.Items[0].cSit)+sLineBreak+
                             'xNome='+ACBrMDFe1.WebServices.ConsultaCadastro.RetConsCad.InfCad.Items[0].xNome+sLineBreak+
                             'xFant='+ACBrMDFe1.WebServices.ConsultaCadastro.RetConsCad.InfCad.Items[0].xFant+sLineBreak+
                             'xRegApur='+ACBrMDFe1.WebServices.ConsultaCadastro.RetConsCad.InfCad.Items[0].xRegApur+sLineBreak+
                             'CNAE='+inttostr(ACBrMDFe1.WebServices.ConsultaCadastro.RetConsCad.InfCad.Items[0].CNAE)+sLineBreak+
                             'dIniAtiv='+DFeUtil.FormatDate(DateToStr(ACBrMDFe1.WebServices.ConsultaCadastro.RetConsCad.InfCad.Items[0].dIniAtiv))+sLineBreak+
                             'dUltSit='+DFeUtil.FormatDate(DateToStr(ACBrMDFe1.WebServices.ConsultaCadastro.RetConsCad.InfCad.Items[0].dUltSit))+sLineBreak+
                             'dBaixa='+DFeUtil.FormatDate(DateToStr(ACBrMDFe1.WebServices.ConsultaCadastro.RetConsCad.InfCad.Items[0].dBaixa))+sLineBreak+
                             'xLgr='+ACBrMDFe1.WebServices.ConsultaCadastro.RetConsCad.InfCad.Items[0].xLgr+sLineBreak+
                             'nro='+ACBrMDFe1.WebServices.ConsultaCadastro.RetConsCad.InfCad.Items[0].nro+sLineBreak+
                             'xCpl='+ACBrMDFe1.WebServices.ConsultaCadastro.RetConsCad.InfCad.Items[0].xCpl+sLineBreak+
                             'xBairro='+ACBrMDFe1.WebServices.ConsultaCadastro.RetConsCad.InfCad.Items[0].xBairro+sLineBreak+
                             'cMun='+inttostr(ACBrMDFe1.WebServices.ConsultaCadastro.RetConsCad.InfCad.Items[0].cMun)+sLineBreak+
                             'xMun='+ACBrMDFe1.WebServices.ConsultaCadastro.RetConsCad.InfCad.Items[0].xMun+sLineBreak+
                             'CEP='+inttostr(ACBrMDFe1.WebServices.ConsultaCadastro.RetConsCad.InfCad.Items[0].CEP)+sLineBreak;
           *)
         end
        else if (Cmd.Metodo = 'criarmdfe')      or (Cmd.Metodo = 'criarenviarmdfe') or
                (Cmd.Metodo = 'criarmdfesefaz') or (Cmd.Metodo = 'criarenviarmdfesefaz') or
                (Cmd.Metodo = 'adicionarmdfe')  or (Cmd.Metodo = 'adicionarmdfesefaz') or
                (Cmd.Metodo = 'enviarlotemdfe') then
         begin
           if (Cmd.Metodo = 'criarmdfe') or (Cmd.Metodo = 'criarenviarmdfe') or
              (Cmd.Metodo = 'adicionarmdfe') then
              GerarIniMDFe( Cmd.Params(0)  );
           {
           else
            begin
              if (Cmd.Metodo = 'criarmdfesefaz') or (Cmd.Metodo = 'criarenviarmdfesefaz') or
                 (Cmd.Metodo = 'adicionarmdfesefaz') then
                  begin
                    if not FileExists(Cmd.Params(0)) then
                       raise Exception.Create('Arquivo '+Cmd.Params(0)+' não encontrado.')
                    else
                     begin
                       ACBrMDFe1.Manifestos.Clear;
                       ACBrMDFe1.Manifestos.Add;
//                       NFeRTXT := TNFeRTXT.Create(ACBrMDFe1.NotasFiscais.Items[0].NFe);
                       try
//                          NFeRTXT.CarregarArquivo(Cmd.Params(0));
//                          if not NFeRTXT.LerTxt then
//                             raise Exception.Create('Arquivo inválido!');
                       finally
//                          NFeRTXT.Free;
                       end;
                     end;
                  end;
            end;
            }
           if (Cmd.Metodo = 'adicionarmdfe')  or (Cmd.Metodo = 'adicionarmdfesefaz') then
            begin
              ForceDirectories(PathWithDelim(ExtractFilePath(Application.ExeName))+'Lotes'+PathDelim+'Lote'+trim(Cmd.Params(1)));
              ACBrMDFe1.Manifestos.GerarMDFe;
              Alertas := ACBrMDFe1.Manifestos.Items[0].Alertas;
              ACBrMDFe1.Manifestos.Valida;
              ArqMDFe := PathWithDelim(PathWithDelim(ExtractFilePath(Application.ExeName))+'Lotes'+PathDelim+'Lote'+trim(Cmd.Params(1)))+OnlyNumber(ACBrMDFe1.Manifestos.Items[0].MDFe.infMDFe.ID)+'-mdfe.xml';
              ACBrMDFe1.Manifestos.SaveToFile(ExtractFilePath(ArqMDFe));
              if not FileExists(ArqMDFe) then
                 raise Exception.Create('Não foi possível criar o arquivo '+ArqMDFe);
            end
           else if (Cmd.Metodo = 'criarmdfe')  or (Cmd.Metodo = 'criaresefaz') or
           (Cmd.Metodo = 'criarenviarmdfe') or (Cmd.Metodo = 'criarenviarmdfesefaz') then
            begin
              Salva := ACBrMDFe1.Configuracoes.Geral.Salvar;
              if not Salva then
               begin
                ForceDirectories(PathWithDelim(ExtractFilePath(Application.ExeName))+'Logs');
                ACBrMDFe1.Configuracoes.Geral.PathSalvar := PathWithDelim(ExtractFilePath(Application.ExeName))+'Logs';
               end;
              ACBrMDFe1.Manifestos.GerarMDFe;
              Alertas := ACBrMDFe1.Manifestos.Items[0].Alertas;
              ACBrMDFe1.Manifestos.Valida;
              ArqMDFe := PathWithDelim(ACBrMDFe1.Configuracoes.Geral.PathSalvar)+OnlyNumber(ACBrMDFe1.Manifestos.Items[0].MDFe.infMDFe.ID)+'-mdfe.xml';
              ACBrMDFe1.Manifestos.SaveToFile(ArqMDFe);
              if not FileExists(ArqMDFe) then
                raise Exception.Create('Não foi possível criar o arquivo '+ArqMDFe);
            end;

           Cmd.Resposta := ArqMDFe;
           if Alertas <> '' then
              Cmd.Resposta :=  Cmd.Resposta+sLineBreak+'Alertas:'+Alertas;
           if ((Cmd.Metodo = 'criarmdfe') or (Cmd.Metodo = 'criarmdfesefaz')) and (Cmd.Params(1) = '1') then
            begin
              SL := TStringList.Create;
              SL.LoadFromFile(ArqMDFe);
              Cmd.Resposta :=  Cmd.Resposta+sLineBreak+SL.Text;
              SL.Free;
            end;

           if (Cmd.Metodo = 'criarenviarmdfe') or (Cmd.Metodo = 'criarenviarmdfesefaz') or (Cmd.Metodo = 'enviarlotemdfe') then
            begin
              //Carregar Notas quando enviar lote
              if (Cmd.Metodo = 'enviarlotemdfe')   then
               begin
                 if not DirectoryExists(PathWithDelim(ExtractFilePath(Application.ExeName))+'Lotes'+PathDelim+'Lote'+trim(Cmd.Params(0))) then
                    raise Exception.Create('Diretório não encontrado:'+PathWithDelim(ExtractFilePath(Application.ExeName))+'Lotes'+PathDelim+'Lote'+trim(Cmd.Params(0)))
                 else
                  begin
                    ACBrMDFe1.Manifestos.Clear;
                    RetFind := SysUtils.FindFirst( PathWithDelim(ExtractFilePath(Application.ExeName))+'Lotes'+PathDelim+'Lote'+Cmd.Params(0)+PathDelim+'*-mdfe.xml', faAnyFile, SearchRec);
                    if (RetFind = 0) then
                     begin
                       while RetFind = 0 do
                        begin
                           ACBrMDFe1.Manifestos.LoadFromFile(PathWithDelim(ExtractFilePath(Application.ExeName))+'Lotes'+PathDelim+'Lote'+Cmd.Params(0)+PathDelim+SearchRec.Name);
                           RetFind := FindNext(SearchRec);
                        end;
                        ACBrMDFe1.Manifestos.GerarMDFe;
                        ACBrMDFe1.Manifestos.Assinar;
                        ACBrMDFe1.Manifestos.Valida;
                     end
                    else
                       raise Exception.Create('Não foi encontrada nenhuma nota para o Lote: '+Cmd.Params(0) );
                  end;
               end;

                 if not(ACBrMDFe1.WebServices.StatusServico.Executar) then
                  raise Exception.Create(ACBrMDFe1.WebServices.StatusServico.Msg);

                 if (Cmd.Metodo = 'criarenviarmdfe') or (Cmd.Metodo = 'criarenviarmdfesefaz') then
                  begin
                    if Trim(OnlyNumber(Cmd.Params(1))) = '' then
                       ACBrMDFe1.WebServices.Enviar.Lote := '1'
                    else
                       ACBrMDFe1.WebServices.Enviar.Lote := OnlyNumber(Cmd.Params(1)); //StrToIntDef( OnlyNumber(Cmd.Params(1)),1);
                  end
                 else
                  begin
                    if Trim(OnlyNumber(Cmd.Params(0))) = '' then
                       ACBrMDFe1.WebServices.Enviar.Lote := '1'
                    else
                       ACBrMDFe1.WebServices.Enviar.Lote := OnlyNumber(Cmd.Params(0)); //StrToIntDef( OnlyNumber(Cmd.Params(0)),1);
                  end;
                 ACBrMDFe1.WebServices.Enviar.Executar;

                 Cmd.Resposta :=  ACBrMDFe1.WebServices.Enviar.Msg+sLineBreak+
                                 '[ENVIO]'+sLineBreak+
                                 'Versao='+ACBrMDFe1.WebServices.Enviar.verAplic+sLineBreak+
                                 'TpAmb='+TpAmbToStr(ACBrMDFe1.WebServices.Enviar.TpAmb)+sLineBreak+
                                 'VerAplic='+ACBrMDFe1.WebServices.Enviar.VerAplic+sLineBreak+
                                 'CStat='+IntToStr(ACBrMDFe1.WebServices.Enviar.CStat)+sLineBreak+
                                 'XMotivo='+ACBrMDFe1.WebServices.Enviar.XMotivo+sLineBreak+
                                 'CUF='+IntToStr(ACBrMDFe1.WebServices.Enviar.CUF)+sLineBreak+
                                 'NRec='+ACBrMDFe1.WebServices.Enviar.Recibo+sLineBreak+
                                 'DhRecbto='+DateTimeToStr(ACBrMDFe1.WebServices.Enviar.dhRecbto)+sLineBreak+
                                 'TMed='+IntToStr(ACBrMDFe1.WebServices.Enviar.TMed)+sLineBreak+
                                 'Msg='+ACBrMDFe1.WebServices.Enviar.Msg+sLineBreak;

                 ACBrMDFe1.WebServices.Retorno.Recibo := ACBrMDFe1.WebServices.Enviar.Recibo;
                 ACBrMDFe1.WebServices.Retorno.Executar;

                 Cmd.Resposta :=  Cmd.Resposta+
                                  ACBrMDFe1.WebServices.Retorno.Msg+sLineBreak+
                                  '[RETORNO]'+sLineBreak+
                                  'Versao='+ACBrMDFe1.WebServices.Retorno.verAplic+sLineBreak+
                                  'TpAmb='+TpAmbToStr(ACBrMDFe1.WebServices.Retorno.TpAmb)+sLineBreak+
                                  'VerAplic='+ACBrMDFe1.WebServices.Retorno.VerAplic+sLineBreak+
                                  'NRec='+ACBrMDFe1.WebServices.Retorno.MDFeRetorno.nRec+sLineBreak+
                                  'CStat='+IntToStr(ACBrMDFe1.WebServices.Retorno.CStat)+sLineBreak+
                                  'XMotivo='+ACBrMDFe1.WebServices.Retorno.XMotivo+sLineBreak+
                                  'CUF='+IntToStr(ACBrMDFe1.WebServices.Retorno.CUF)+sLineBreak;

                 for I:= 0 to ACBrMDFe1.WebServices.Retorno.MDFeRetorno.ProtMDFe.Count-1 do
                  begin
                   for J:= 0 to ACBrMDFe1.Manifestos.Count-1 do
                    begin
                     if 'MDFe'+ACBrMDFe1.WebServices.Retorno.MDFeRetorno.ProtMDFe.Items[i].chMDFe = ACBrMDFe1.Manifestos.Items[j].MDFe.infMDFe.Id  then
                      begin
                        Cmd.Resposta := Cmd.Resposta+
                                   '[MDFe'+Trim(IntToStr(ACBrMDFe1.Manifestos.Items[j].MDFe.Ide.nMDF))+']'+sLineBreak+
                                   'Versao='+ACBrMDFe1.WebServices.Retorno.MDFeRetorno.ProtMDFe.Items[i].verAplic+sLineBreak+
                                   'TpAmb='+TpAmbToStr(ACBrMDFe1.WebServices.Retorno.MDFeRetorno.ProtMDFe.Items[i].tpAmb)+sLineBreak+
                                   'VerAplic='+ACBrMDFe1.WebServices.Retorno.MDFeRetorno.ProtMDFe.Items[i].verAplic+sLineBreak+
                                   'CStat='+IntToStr(ACBrMDFe1.WebServices.Retorno.MDFeRetorno.ProtMDFe.Items[i].cStat)+sLineBreak+
                                   'XMotivo='+ACBrMDFe1.WebServices.Retorno.MDFeRetorno.ProtMDFe.Items[i].xMotivo+sLineBreak+
                                   'CUF='+IntToStr(ACBrMDFe1.WebServices.Retorno.MDFeRetorno.cUF)+sLineBreak+
                                   'ChMDFe='+ACBrMDFe1.WebServices.Retorno.MDFeRetorno.ProtMDFe.Items[i].chMDFe+sLineBreak+
                                   'DhRecbto='+DateTimeToStr(ACBrMDFe1.WebServices.Retorno.MDFeRetorno.ProtMDFe.Items[i].dhRecbto)+sLineBreak+
                                   'NProt='+ACBrMDFe1.WebServices.Retorno.MDFeRetorno.ProtMDFe.Items[i].nProt+sLineBreak+
                                   'DigVal='+ACBrMDFe1.WebServices.Retorno.MDFeRetorno.ProtMDFe.Items[i].digVal+sLineBreak+
                                   'Arquivo='+PathWithDelim(ACBrMDFe1.Configuracoes.Geral.PathSalvar)+OnlyNumber(ACBrMDFe1.Manifestos.Items[j].MDFe.infMDFe.ID)+'-MDFe.xml'+sLineBreak;
                        if (Cmd.Params(2) = '1') and ACBrMDFe1.DAMDFe.MostrarPreview then
                         begin
                           Restaurar1.Click;
                           Application.BringToFront;
                         end;
                        ACBrMDFe1.DAMDFe.Impressora := cbxImpressora.Text;
                        if ACBrMDFe1.Manifestos.Items[i].Confirmada and (Cmd.Params(2) = '1') then
                           ACBrMDFe1.Manifestos.Items[i].Imprimir;
                        if (Cmd.Params(2) = '1') and ACBrMDFe1.DAMDFe.MostrarPreview then
                           Ocultar1.Click;
                        break;
                      end;
                    end;
                  end;

            end;
         end
        else if Cmd.Metodo = 'enviaremail' then
         begin
           ACBrMDFe1.Manifestos.Clear;
           if FileExists(Cmd.Params(1)) or FileExists(PathWithDelim(ACBrMDFe1.Configuracoes.Geral.PathSalvar)+Cmd.Params(1)) then
            begin
              if FileExists(Cmd.Params(1)) then
               begin
                 ACBrMDFe1.Manifestos.LoadFromFile(Cmd.Params(1));
                 ArqMDFe := Cmd.Params(1);
               end
              else
               begin
                 ACBrMDFe1.Manifestos.LoadFromFile(PathWithDelim(ACBrMDFe1.Configuracoes.Geral.PathSalvar)+Cmd.Params(1));
                 ArqMDFe := PathWithDelim(ACBrMDFe1.Configuracoes.Geral.PathSalvar)+Cmd.Params(1);
               end;
            end
           else
              raise Exception.Create('Arquivo '+Cmd.Params(1)+' não encontrado.');

           if (Cmd.Params(2) = '1') then
            begin
              try
                 ACBrMDFe1.Manifestos.ImprimirPDF;
                 ArqPDF := ACBrMDFe1.Manifestos.Items[0].MDFe.infMDFe.ID;

                 ArqPDF := OnlyNumber(ACBrMDFe1.Manifestos.Items[0].MDFe.infMDFe.ID);
                 ArqPDF := PathWithDelim(ACBrMDFe1.DAMDFe.PathPDF)+ArqPDF+'.pdf';
              except
                 raise Exception.Create('Erro ao criar o arquivo PDF');
              end;
            end;
            try
               if rgEmailTipoEnvio.ItemIndex = 0 then
                  EnviarEmail(edtSmtpHost.Text, edtSmtpPort.Text, edtSmtpUser.Text, edtSmtpPass.Text, edtSmtpUser.Text, Cmd.Params(0),DFeUtil.SeSenao(DFeUtil.NaoEstaVazio(Cmd.Params(3)),Cmd.Params(3),edtEmailAssunto.Text), ArqMDFe, ArqPDF, mmEmailMsg.Lines, cbEmailSSL.Checked, cbEmailTLS.Checked, Cmd.Params(4))
               else
                  EnviarEmailIndy(edtSmtpHost.Text, edtSmtpPort.Text, edtSmtpUser.Text, edtSmtpPass.Text, edtSmtpUser.Text, Cmd.Params(0),DFeUtil.SeSenao(DFeUtil.NaoEstaVazio(Cmd.Params(3)),Cmd.Params(3),edtEmailAssunto.Text), ArqMDFe, ArqPDF, mmEmailMsg.Lines, cbEmailSSL.Checked, cbEmailTLS.Checked, Cmd.Params(4));
               Cmd.Resposta := 'Email enviado com sucesso';
            except
               on E: Exception do
                begin
                  raise Exception.Create('Erro ao enviar email'+sLineBreak+E.Message);
                end;
            end;
         end

        else if Cmd.Metodo = 'setcertificado' then
         begin
           if (Cmd.Params(0)<>'') then
            begin
             {$IFDEF ACBrMDFeOpenSSL}
                ACBrMDFe1.Configuracoes.Certificados.Certificado := Cmd.Params(0);
                ACBrMDFe1.Configuracoes.Certificados.Senha       := Cmd.Params(1);
                edtCaminho.Text := ACBrMDFe1.Configuracoes.Certificados.Certificado;
                edtSenha.Text   := ACBrMDFe1.Configuracoes.Certificados.Senha;
             {$ELSE}
                ACBrMDFe1.Configuracoes.Certificados.NumeroSerie := Cmd.Params(0);
                ACBrMDFe1.Configuracoes.Certificados.Senha       := Cmd.Params(1);                
                edtCaminho.Text := ACBrMDFe1.Configuracoes.Certificados.NumeroSerie;
             {$ENDIF}
                frmAcbrNfeMonitor.SalvarIni;
            end
           else
              raise Exception.Create('Certificado '+Cmd.Params(0)+' Inválido.');
         end

        else if Cmd.Metodo = 'setambiente' then //1-Produção 2-Homologação
         begin
           if (StrToInt(Cmd.Params(0))>=1) and (StrToInt(Cmd.Params(0))<=2) then
            begin
              ACBrMDFe1.Configuracoes.WebServices.Ambiente := StrToTpAmb(OK, Cmd.Params(0));
              rgTipoAmb.ItemIndex := ACBrMDFe1.Configuracoes.WebServices.AmbienteCodigo-1;
              frmAcbrNfeMonitor.SalvarIni;
            end
           else
              raise Exception.Create('Ambiente Inválido.');
         end

        else if Cmd.Metodo = 'setformaemissao' then
         begin
           if (StrToInt(Cmd.Params(0))>=1) and (StrToInt(Cmd.Params(0))<=9) then
            begin
              ACBrMDFe1.Configuracoes.Geral.FormaEmissao := StrToTpEmis(OK, Cmd.Params(0));
              rgFormaEmissao.ItemIndex := ACBrMDFe1.Configuracoes.Geral.FormaEmissaoCodigo-1;
              frmAcbrNfeMonitor.SalvarIni;
            end
           else
              raise Exception.Create('Forma de Emissão Inválida.');
         end

        else if Cmd.Metodo = 'lermdfe' then
         begin
           try
              Cmd.Resposta := GerarMDFeIni( Cmd.Params(0)  )
           except
               on E: Exception do
                begin
                  raise Exception.Create('Erro ao gerar INI do MDFe.'+sLineBreak+E.Message);
                end;
           end;
         end

        else if Cmd.Metodo = 'mdfetotxt' then  //1-Arquivo XML, 2-NomeArqTXT
         begin
           ACBrMDFe1.Manifestos.Clear;
           if FileExists(Cmd.Params(0)) then
              ACBrMDFe1.Manifestos.LoadFromFile(Cmd.Params(0))
           else
              raise Exception.Create('Arquivo '+Cmd.Params(0)+' não encontrado.');

           ACBrMDFe1.Manifestos.Items[0].SaveToFile(Cmd.Params(1));
           Cmd.Resposta := ChangeFileExt(ACBrMDFe1.Manifestos.Items[0].NomeArq,'.txt');
         end

        else if Cmd.Metodo = 'savetofile' then
         begin
           Memo := TStringList.Create;
           try
              Memo.Clear;
              Memo.Text := ConvertStrRecived( cmd.Params(1) );
              Memo.SaveToFile( Cmd.Params(0) );
           finally
              Memo.Free;
           end;
         end

        else if Cmd.Metodo = 'loadfromfile' then
         begin
           Files := Cmd.Params(0);
           dtFim := IncSecond(now, StrToIntDef(Cmd.Params(1),1) );
           while now <= dtFim do
           begin
              if FileExists( Files ) then
              begin
                 Memo  := TStringList.Create;
                 try
                    Memo.Clear;
                    Memo.LoadFromFile( Files );
                    Cmd.Resposta := Memo.Text;
                    Break;
                 finally
                    Memo.Free;
                 end;
              end;

              {$IFNDEF NOGUI}
               Application.ProcessMessages;
              {$ENDIF}
              sleep(100);
           end;

           if not FileExists( Cmd.Params(0) ) then
              raise Exception.Create('Arquivo '+Cmd.Params(0)+' não encontrado')
         end

        else if Cmd.Metodo = 'fileexists' then
         begin
           if not FileExists( Cmd.Params(0) ) then
              raise Exception.Create('Arquivo '+Cmd.Params(0)+' não encontrado')
         end


        else if Cmd.Metodo = 'certificadodatavencimento' then
         begin
           {$IFDEF ACBrMDFeOpenSSL}
              Cmd.Resposta := 'Função disponível apenas na versão CAPICOM'
           {$ELSE}
              Cmd.Resposta := DateToStr(ACBrMDFe1.Configuracoes.Certificados.DataVenc);
           {$ENDIF}
         end

        else if Cmd.Metodo = 'lerini' then // Recarrega configurações do arquivo INI
           frmAcbrNfeMonitor.LerIni

        else if Cmd.Metodo = 'gerarchave' then
         begin
           GerarChave(Chave,
                      StrToInt(Cmd.Params(0)), //codigoUF
                      StrToInt(Cmd.Params(1)), //codigoNumerico
                      StrToInt(Cmd.Params(2)), //modelo
                      StrToInt(Cmd.Params(3)), //serie
                      StrToInt(Cmd.Params(4)), //numero
                      StrToInt(Cmd.Params(5)), //tpemi
                      DFeUtil.StringToDate(Cmd.Params(6)), //emissao
                      Cmd.Params(7)); //CNPJ
           Cmd.Resposta := Chave;
         end

        else if Cmd.Metodo = 'restaurar' then
           Restaurar1Click( frmAcbrNfeMonitor )

        else if Cmd.Metodo = 'ocultar' then
           Ocultar1Click( frmAcbrNfeMonitor )

        else if Cmd.Metodo = 'encerrarmonitor' then
           Application.Terminate

        else if Cmd.Metodo = 'ativo' then
           Cmd.Resposta := 'Ativo'

        else if pos('|'+Cmd.Metodo+'|', '|exit|bye|fim|sair|') > 0 then {fecha conexao}
         begin
           Cmd.Resposta := 'Obrigado por usar o ACBrNFeMonitor';
           mCmd.Lines.Clear;

           if Assigned( Conexao ) then
              if Assigned( Conexao.Connection ) then
                 Conexao.Connection.Disconnect;
         end


        else //Else Final - Se chegou ate aqui, o comando é inválido
           raise Exception.Create('Comando inválido ('+Cmd.Comando+')');
     finally
        { Nada a fazer aqui por enquanto... :) }
     end;
  end;
end;


procedure GerarIniMDFe( AStr: WideString );
var
  I, J : Integer;
  sSecao, sFim, sCampoAdic, sCodPro : String;
  INIRec : TMemIniFile;
  SL     : TStringList;
  OK     : boolean;
begin
 INIRec := TMemIniFile.create( 'MDFe.ini' );
 SL := TStringList.Create;
 if FilesExists(Astr) then
    SL.LoadFromFile(AStr)
 else
    Sl.Text := ConvertStrRecived( Astr );
 INIRec.SetStrings( SL );
 SL.Free;
 with frmAcbrNfeMonitor do
  begin
   try
      ACBrMDFe1.Manifestos.Clear;
      with ACBrMDFe1.Manifestos.Add.MDFe do
       begin
         Ide.modelo  := INIRec.ReadString('ide', 'mod', '58');
         Ide.serie   := INIRec.ReadInteger('ide', 'serie', 1);
         Ide.nMDF    := INIRec.ReadInteger('ide', 'nMDF', 0);
         Ide.cMDF    := INIRec.ReadInteger('ide', 'cMDF', 0);
         Ide.tpEmit  := StrToTpEmitente(OK, INIRec.ReadString('ide', 'tpEmit', '1'));
         Ide.modal   := StrToModal(OK, INIRec.ReadString('ide', 'modal', '01'));
         Ide.dhEmi   := NotaUtil.StringToDateTime(INIRec.ReadString('ide', 'dhEmi', '0'));
         Ide.tpEmis  := StrToTpEmis(OK, INIRec.ReadString('ide', 'tpEmis', IntToStr(ACBrMDFe1.Configuracoes.Geral.FormaEmissaoCodigo)));
         Ide.procEmi := StrToProcEmi(OK, INIRec.ReadString('ide', 'procEmi', '0'));
         Ide.verProc := INIRec.ReadString('ide', 'verProc', 'ACBrMDFe');
         Ide.UFIni   := INIRec.ReadString('ide', 'UFIni', '');
         Ide.UFFim   := INIRec.ReadString('ide', 'UFFim', '');

         I := 1;
         while true do
          begin
            sSecao := 'CARR' + IntToStrZero(I, 3);
            sFim   := INIRec.ReadString(sSecao, 'xMunCarrega', 'FIM');
            if (sFim = 'FIM') or (Length(sFim) <= 0) then
               break;
            with Ide.infMunCarrega.Add do
             begin
               cMunCarrega := INIRec.ReadInteger(sSecao, 'cMunCarrega', 0);
               xMunCarrega := INIRec.ReadString(sSecao, 'xMunCarrega', '')
             end;
            Inc(I);
          end;

         I := 1;
         while true do
          begin
            sSecao := 'PERC' + IntToStrZero(I, 3);
            sFim   := INIRec.ReadString(sSecao, 'UFPer', 'FIM');
            if (sFim = 'FIM') or (Length(sFim) <= 0) then
               break;
            with Ide.infPercurso.Add do
             begin
               UFPer := INIRec.ReadString(sSecao, 'UFPer', '')
             end;
            Inc(I);
          end;

          Emit.CNPJ  := INIRec.ReadString('emit', 'CNPJ', '');
          Emit.IE    := INIRec.ReadString('emit', 'IE', '');
          Emit.xNome := INIRec.ReadString('emit', 'xNome', '');
          Emit.xFant := INIRec.ReadString('emit', 'xFant', '');

          Emit.enderEmit.xLgr    := INIRec.ReadString('emit', 'xLgr', '');
          Emit.enderEmit.nro     := INIRec.ReadString('emit', 'nro', '');
          Emit.enderEmit.xCpl    := INIRec.ReadString('emit', 'xCpl', '');
          Emit.enderEmit.xBairro := INIRec.ReadString('emit', 'xBairro', '');
          Emit.enderEmit.cMun    := INIRec.ReadInteger('emit', 'cMun', 0);
          Emit.enderEmit.xMun    := INIRec.ReadString('emit', 'xMun', '');
          Emit.enderEmit.CEP     := INIRec.ReadInteger('emit', 'CEP', 0);
          Emit.enderEmit.UF      := INIRec.ReadString('emit', 'UF', '');
          Emit.enderEmit.fone    := INIRec.ReadString('emit', 'fone', '');
          Emit.enderEmit.email   := INIRec.ReadString('emit', 'email', '');
          if Emit.enderEmit.cMun <= 0 then
            Emit.enderEmit.cMun := ObterCodigoMunicipio(Emit.enderEmit.xMun, Emit.enderEmit.UF);

          ide.cUF := INIRec.ReadInteger('ide', 'cUF', UFparaCodigo(Emit.enderEmit.UF));

          if INIRec.ReadString('Rodo', 'RNTRC', '') <> '' then
          begin
            Rodo.RNTRC := INIRec.ReadString('Rodo', 'RNTRC', '');
            Rodo.CIOT  := INIRec.ReadString('Rodo', 'CIOT', '');

            rodo.veicTracao.cInt  := INIRec.ReadString('veicTracao', 'cInt', '');
            rodo.veicTracao.placa := INIRec.ReadString('veicTracao', 'placa', '');
            rodo.veicTracao.tara  := INIRec.ReadInteger('veicTracao', 'tara', 0);
            rodo.veicTracao.capKG := INIRec.ReadInteger('veicTracao', 'capKG', 0);
            rodo.veicTracao.capM3 := INIRec.ReadInteger('veicTracao', 'capM3', 0);
            rodo.veicTracao.UF    := INIRec.ReadString('veicTracao', 'UF', '');
            rodo.veicTracao.tpRod := StrToTpRodado(OK, INIRec.ReadString('veicTracao', 'tpRod', '00'));

            I := 1;
            while true do
             begin
               sSecao := 'reboque' + IntToStrZero(I, 2);
               sFim   := INIRec.ReadString(sSecao, 'placa', 'FIM');
               if sFim = 'FIM' then
                  break;
               with rodo.veicReboque.Add do
                begin
                  cInt  := INIRec.ReadString(sSecao, 'cInt', '');
                  placa := INIRec.ReadString(sSecao, 'placa', '');
                  tara  := INIRec.ReadInteger(sSecao, 'tara', 0);
                  capKG := INIRec.ReadInteger(sSecao, 'capKG', 0);
                  capM3 := INIRec.ReadInteger(sSecao, 'capM3', 0);
                  UF    := INIRec.ReadString(sSecao, 'UF', '');
                end;
               Inc(I);
             end;

            I := 1;
            while true do
             begin
               sSecao := 'moto' + IntToStrZero(I, 3);
               sFim   := INIRec.ReadString(sSecao, 'xNome', 'FIM');
               if sFim = 'FIM' then
                  break;
               with rodo.veicTracao.condutor.Add do
                begin
                  xNome := sFim;
                  CPF   := INIRec.ReadString(sSecao, 'CPF', '');
                end;
               Inc(I);
             end;

            I := 1;
            while true do
             begin
               sSecao := 'valePed' + IntToStrZero(I, 3);
               sFim   := INIRec.ReadString(sSecao, 'CNPJForn', 'FIM');
               if sFim = 'FIM' then
                  break;
               with rodo.valePed.disp.Add do
                begin
                  CNPJForn := INIRec.ReadString(sSecao, 'CNPJForn', '');
                  nCompra  := INIRec.ReadString(sSecao, 'nCompra', '');
                  CNPJPg   := INIRec.ReadString(sSecao, 'CNPJPg', '');
                end;
               Inc(I);
             end;

          end; // Fim do Rodo

          if INIRec.ReadString('aereo','CL','') <> '' then
          begin
             sSecao := 'aereo';
             (*
               Aereo.nMinu   := INIRec.ReadInteger(sSecao,'nMinu',0);
               Aereo.nOCA    := INIRec.ReadString(sSecao,'nOCA','');

              {$IFDEF PL_200}
               Aereo.dPrevAereo := DFeUtil.StringToDate(INIRec.ReadString( sSecao,'dPrevAereo','0'));
              {$ELSE}
               Aereo.dPrev   := DFeUtil.StringToDate(INIRec.ReadString( sSecao,'dPrev','0'));
              {$ENDIF}

               Aereo.xLAgEmi := INIRec.ReadString(sSecao,'xLAgEmi','');
               Aereo.IdT     := INIRec.ReadString(sSecao,'IdT','');

               Aereo.tarifa.CL   := INIRec.ReadString(sSecao,'nMinu','');
               Aereo.tarifa.cTar := INIRec.ReadString(sSecao,'cTar','');
               Aereo.tarifa.vTar := StringToFloatDef( INIRec.ReadString(sSecao,'vTar','') ,0);

               Aereo.natCarga.xDime    := INIRec.ReadString(sSecao,'xDime','');
               Aereo.natCarga.cInfManu := INIRec.ReadInteger(sSecao,'cInfManu',0);
               Aereo.natCarga.cIMP     := INIRec.ReadString(sSecao,'cIMP','');
             *)
          end; // Fim do Aereo

          if INIRec.ReadString('aquav', 'xNavio', '') <> '' then
          begin
             sSecao := 'aquav';
             (*
               Aquav.vPrest   := StringToFloatDef( INIRec.ReadString(sSecao,'vPrest','') ,0);
               Aquav.vAFRMM   := StringToFloatDef( INIRec.ReadString(sSecao,'vAFRMM','') ,0);
               Aquav.nBooking := INIRec.ReadString( sSecao,'nBooking','0');
               Aquav.nCtrl    := INIRec.ReadString(sSecao,'nCtrl','');
               Aquav.xNavio   := INIRec.ReadString(sSecao,'xNavio','');

               Aquav.nViag    := INIRec.ReadString(sSecao,'nViag','');
               Aquav.direc    := StrToTpDirecao(OK,INIRec.ReadString(sSecao,'direc',''));
               Aquav.prtEmb   := INIRec.ReadString(sSecao,'prtEmb','');
               Aquav.prtTrans := INIRec.ReadString(sSecao,'prtTrans','');
               Aquav.prtDest  := INIRec.ReadString(sSecao,'prtDest','');
               Aquav.tpNav    := StrToTpNavegacao(OK,INIRec.ReadString(sSecao,'tpNav',''));
               Aquav.irin     := INIRec.ReadString(sSecao,'irin','');

               I := 1;
               while true do
                begin
                  sSecao    := 'balsa'+IntToStrZero(I,3);
                  sFim   := INIRec.ReadString(sSecao,'xBalsa','FIM');
                  if sFim = 'FIM' then
                     break;
                  with Aquav.balsa.Add do
                   begin
                     xBalsa := sFim;
                   end;
                  Inc(I);
                end;

               I := 1;
               while true do
                begin
                  sSecao    := 'detCont'+IntToStrZero(I,3);
                  sFim   := INIRec.ReadString(sSecao,'nCont','FIM');
                  if sFim = 'FIM' then
                     break;
                  with Aquav.detCont.Add do
                   begin
                     nCont := sFim;
                     J := 1;
                     while true do
                      begin
                        sSecao := 'Lacre'+IntToStrZero(I,3)+IntToStrZero(J,3);
                        sFim   := INIRec.ReadString(sSecao,'nLacre','FIM');
                        if (sFim = 'FIM') or (Length(sFim) <= 0)  then
                           break;

                        Lacre.Add.nLacre := sFim;
                        Inc(J);
                      end;

                     J := 1;
                     while true do
                      begin
                        sSecao := 'infNF'+IntToStrZero(I,3)+IntToStrZero(J,3);
                        sFim   := INIRec.ReadString(sSecao,'nDoc','FIM');
                        if (sFim = 'FIM') or (Length(sFim) <= 0)  then
                           break;

                        with infNFCont.Add do
                         begin
                           nDoc    := sFim;
                           serie   := INIRec.ReadString(sSecao,'serie','FIM');
                           unidRat := StringToFloatDef( INIRec.ReadString(sSecao,'unidRat','') ,0);
                         end;
                        Inc(J);
                      end;

                     J := 1;
                     while true do
                      begin
                        sSecao := 'infNFe'+IntToStrZero(I,3)+IntToStrZero(J,3);
                        sFim   := INIRec.ReadString(sSecao,'chave','FIM');
                        if (sFim = 'FIM') or (Length(sFim) <= 0)  then
                           break;

                        with infNFeCont.Add do
                         begin
                           chave   := sFim;
                           unidRat := StringToFloatDef( INIRec.ReadString(sSecao,'unidRat','') ,0);
                         end;
                        Inc(J);
                      end;
                   end;
                  Inc(I);

                end;
             *)
          end; // Fim do Aqua

         if INIRec.ReadString('ferrov', 'tpTraf', '') <> '' then
         begin
            sSecao := 'ferrov';
            (*
              Ferrov.tpTraf := StrToTpTrafego(OK,INIRec.ReadString(sSecao,'tpTraf',''));
              Ferrov.trafMut.respFat := StrToTrafegoMutuo(OK,INIRec.ReadString(sSecao,'respFat',''));
              Ferrov.trafMut.ferrEmi := StrToTrafegoMutuo(OK,INIRec.ReadString(sSecao,'ferrEmi',''));
              Ferrov.fluxo  := INIRec.ReadString( sSecao,'fluxo','0');
              Ferrov.idTrem := INIRec.ReadString( sSecao,'idTrem','0');
              Ferrov.vFrete := StringToFloatDef( INIRec.ReadString(sSecao,'vFrete','') ,0);

              I := 1;
              while true do
               begin
                 sSecao    := 'ferroEnv'+IntToStrZero(I,3);
                 sFim   := INIRec.ReadString(sSecao,'CNPJ','FIM');
                 if sFim = 'FIM' then
                    break;

                 with Ferrov.ferroEnv.Add do
                  begin
                    CNPJ  := sFim;
                    IE    := INIRec.ReadString(sSecao,'IE','');
                    xNome := INIRec.ReadString(sSecao,'xNome','');

                    EnderFerro.xLgr    := INIRec.ReadString(sSecao,'xLgr','');
                    EnderFerro.nro     := INIRec.ReadString(sSecao,'nro','');
                    EnderFerro.xCpl    := INIRec.ReadString(sSecao, 'xCpl','');
                    EnderFerro.xBairro := INIRec.ReadString(sSecao,'xBairro','');
                    EnderFerro.cMun    := INIRec.ReadInteger(sSecao,'cMun',0);
                    EnderFerro.xMun    := INIRec.ReadString(sSecao,'xMun','');
                    EnderFerro.CEP     := INIRec.ReadInteger(sSecao,'CEP',0);
                    EnderFerro.UF      := INIRec.ReadString(sSecao,'UF','');
                  end;

                 Inc(I);
               end;

              sSecao := 'ferroEnv';

              Ferrov.ferroEnv.CNPJ   := INIRec.ReadString(sSecao,'CNPJ','');
              Ferrov.ferroEnv.IE     := INIRec.ReadString(sSecao,'IE','');
              Ferrov.ferroEnv.xNome  := INIRec.ReadString(sSecao,'xNome','');

              Ferrov.ferroEnv.EnderFerro.xLgr     := INIRec.ReadString(sSecao,'xLgr','');
              Ferrov.ferroEnv.EnderFerro.nro      := INIRec.ReadString(sSecao,'nro','');
              Ferrov.ferroEnv.EnderFerro.xCpl     := INIRec.ReadString(sSecao, 'xCpl','');
              Ferrov.ferroEnv.EnderFerro.xBairro  := INIRec.ReadString(sSecao,'xBairro','');
              Ferrov.ferroEnv.EnderFerro.cMun     := INIRec.ReadInteger(sSecao,'cMun',0);
              Ferrov.ferroEnv.EnderFerro.xMun     := INIRec.ReadString(sSecao,'xMun','');
              Ferrov.ferroEnv.EnderFerro.CEP      := INIRec.ReadInteger(sSecao,'CEP',0);
              Ferrov.ferroEnv.EnderFerro.UF       := INIRec.ReadString(sSecao,'UF','');

              I := 1;
              while true do
               begin
                 sSecao    := 'detVag'+IntToStrZero(I,3);
                 sFim   := INIRec.ReadString(sSecao,'nVag','FIM');
                 if sFim = 'FIM' then
                    break;

                 with Ferrov.detVag.Add do
                  begin
                    nVag   := StrToInt(sFim);
                    cap    := StringToFloatDef( INIRec.ReadString(sSecao,'cap','') ,0);
                    tpVag  := INIRec.ReadString(sSecao,'tpVag','');
                    pesoR  := StringToFloatDef( INIRec.ReadString(sSecao,'pesoR','') ,0);
                    pesoBC := StringToFloatDef( INIRec.ReadString(sSecao,'pesoBC','') ,0);

                   {$IFNDEF PL_200}
                    J := 1;
                    while true do
                     begin
                       sSecao := 'lacDetVag'+IntToStrZero(I,3)+IntToStrZero(J,3);
                       sFim   := INIRec.ReadString(sSecao,'nLacre','FIM');
                       if (sFim = 'FIM') or (Length(sFim) <= 0)  then
                          break;

                       lacDetVag.Add.nLacre := sFim;
                       Inc(J);
                     end;

                    J := 1;
                    while true do
                     begin
                       sSecao := 'contVag'+IntToStrZero(I,3)+IntToStrZero(J,3);
                       sFim   := INIRec.ReadString(sSecao,'nCont','FIM');
                       if (sFim = 'FIM') or (Length(sFim) <= 0)  then
                          break;

                       with contVag.Add do
                        begin
                          nCont    := sFim;
                          dPrev   := DFeUtil.StringToDate(INIRec.ReadString( sSecao,'dPrev','0'));
                        end;
                       Inc(J);
                     end;

                    J := 1;
                    while true do
                     begin
                       sSecao := 'ratNF'+IntToStrZero(I,3)+IntToStrZero(J,3);
                       sFim   := INIRec.ReadString(sSecao,'nDoc','FIM');
                       if (sFim = 'FIM') or (Length(sFim) <= 0)  then
                          break;

                       with ratNF.Add do
                        begin
                          nDoc    := sFim;
                          serie   := INIRec.ReadString(sSecao,'serie','FIM');
                          pesoRat := StringToFloatDef( INIRec.ReadString(sSecao,'pesoRat','') ,0);
                        end;
                       Inc(J);
                     end;

                    J := 1;
                    while true do
                     begin
                       sSecao := 'ratNFe'+IntToStrZero(I,3)+IntToStrZero(J,3);
                       sFim   := INIRec.ReadString(sSecao,'chave','FIM');
                       if (sFim = 'FIM') or (Length(sFim) <= 0)  then
                          break;

                       with ratNFe.Add do
                        begin
                          chave   := sFim;
                          pesoRat := StringToFloatDef( INIRec.ReadString(sSecao,'pesoRat','') ,0);
                        end;
                       Inc(J);
                     end;
                   {$ENDIF}
                  end;
                 Inc(I);
               end;
              *)
         end; // Fim do Ferrov

         if INIRec.ReadString('duto', 'dIni', '') <> '' then
         begin
            sSecao := 'duto';
            (*
            with infMDFeNorm do
             begin
              duto.vTar := StringToFloatDef( INIRec.ReadString(sSecao,'pesoRat','') ,0);
              duto.dIni := DFeUtil.StringToDate(INIRec.ReadString( sSecao,'dIni','0'));
              duto.dFim := DFeUtil.StringToDate(INIRec.ReadString( sSecao,'dFim','0'));
             end;
            *)
         end; // Fim do Duto

         I := 1;
         while true do
          begin
            sSecao := 'DESC' + IntToStrZero(I, 3);
            sFim   := INIRec.ReadString(sSecao, 'xMunDescarga', 'FIM');
            if (sFim = 'FIM') or (Length(sFim) <= 0) then
               break;
            with infDoc.infMunDescarga.Add do
             begin
               cMunDescarga := INIRec.ReadInteger(sSecao, 'cMunDescarga', 0);
               xMunDescarga := INIRec.ReadString(sSecao, 'xMunDescarga', '');

               J := 1;
               while true do
                begin
                  sSecao := 'infCTe' + IntToStrZero(I, 3) + IntToStrZero(J, 3);
                  sFim   := INIRec.ReadString(sSecao, 'chCTe', 'FIM');
                  if sFim = 'FIM' then
                    break;
                  with infCTe.Add do
                   begin
                     chCTe := INIRec.ReadString(sSecao, 'chCTe', '');
                   end;
                  Inc(J);
                end;

               J := 1;
               while true do
                begin
                  sSecao := 'infNFe' + IntToStrZero(I, 3) + IntToStrZero(J, 3);
                  sFim   := INIRec.ReadString(sSecao, 'chNFe', 'FIM');
                  if sFim = 'FIM' then
                    break;
                  with infNFe.Add do
                   begin
                     chNFe := INIRec.ReadString(sSecao, 'chNFe', '');
                   end;
                  Inc(J);
                end;

             end;
            Inc(I);
          end;

         tot.qCTe   := INIRec.ReadInteger('tot', 'qCTe', 0);
         tot.qNFe   := INIRec.ReadInteger('tot', 'qNFe', 0);
         tot.vCarga := StringToFloatDef(INIRec.ReadString('tot', 'vCarga', ''), 0);
         tot.cUnid  := StrToUnidMed(OK, INIRec.ReadString('tot', 'cUnid', '00'));
         tot.qCarga := StringToFloatDef(INIRec.ReadString('tot', 'qCarga', ''), 0);

         I := 1;
         while true do
          begin
            sSecao := 'lacre' + IntToStrZero(I, 3);
            sFim   := INIRec.ReadString(sSecao, 'nLacre', 'FIM');
            if sFim = 'FIM' then
               break;
            with lacres.Add do
             begin
               nLacre := sFim;
             end;
            Inc(I);
          end;

         infAdic.infCpl     := INIRec.ReadString('infAdic', 'infCpl', '');
         infAdic.infAdFisco := INIRec.ReadString('infAdic', 'infAdFisco', '');

       end;

   finally
      INIRec.Free;
   end;
  end;
end;

function GerarMDFeIni( XML : WideString ) : WideString;
var
  I : Integer;
  sSecao,
  sCodPro : String;
  INIRec : TMemIniFile;
  OK     : Boolean;
  IniMDFe : TStringList;
  LocMDFeR : TMDFeR;
begin
 INIRec := TMemIniFile.create( 'MDFe.ini' );
 frmAcbrNfeMonitor.ACBrMDFe1.Manifestos.Clear;
 if FilesExists(XML) then
    frmAcbrNfeMonitor.ACBrMDFe1.Manifestos.LoadFromFile(XML)
 else
  begin
    LocMDFeR := TMDFeR.Create(frmAcbrNfeMonitor.ACBrMDFe1.Manifestos.Add.MDFe);
    try
       LocMDFeR.Leitor.Arquivo := ConvertStrRecived( XML );
       LocMDFeR.LerXml;
       frmAcbrNfeMonitor.ACBrMDFe1.Manifestos.Items[0].XML := LocMDFeR.Leitor.Arquivo;
       frmAcbrNfeMonitor.ACBrMDFe1.Manifestos.GerarMDFe;
    finally
       LocMDFeR.Free;
    end;
  end;

 with frmAcbrNfeMonitor do
  begin
   try
      with ACBrMDFe1.Manifestos.Items[0].MDFe do
       begin
       (*
          INIRec.WriteInteger('ide','cCT', Ide.cCT);
          INIRec.WriteInteger('ide','CFOP',Ide.CFOP        );
          INIRec.WriteString('ide','natOp',Ide.natOp       );
          INIRec.WriteString('ide','forPag',tpforPagToStr( Ide.forPag)       );
          INIRec.WriteString( 'ide','mod' ,Ide.modelo       );
          INIRec.WriteInteger( 'ide','serie'  ,Ide.serie        );
          INIRec.WriteInteger( 'ide','nCT' ,Ide.nCT         );
          INIRec.WriteString( 'ide','dhEmi',DateToStr( Ide.dhEmi       ));
          INIRec.WriteString( 'ide','tpImp',TpImpToStr(Ide.tpImp ));
          INIRec.WriteString( 'ide','tpemis',TpEmisToStr(Ide.tpEmis      ));
          INIRec.WriteString( 'ide','procEmi',procEmiToStr( Ide.procEmi  )   );
          INIRec.WriteString(  'ide','verProc' ,Ide.verProc       );
          INIRec.WriteString( 'ide','dhCont'  ,DateToStr(Ide.dhCont      ));
          INIRec.WriteString(  'ide','xJust' ,Ide.xJust        );
          INIRec.WriteString('ide','tpMDFe',tpMDFePagToStr( Ide.tpMDFe       ));
          INIRec.WriteString('ide','refMDFe',Ide.refMDFe       );
          INIRec.WriteInteger('ide','cMunEnv', Ide.cMunEnv     );
          INIRec.WriteString('ide','xMunEnv',Ide.xMunEnv     );
          INIRec.WriteString('ide','UFEnv',Ide.UFEnv       );
          INIRec.WriteString('ide','modal', TpModalToStr( Ide.modal )      );
          INIRec.WriteString('ide','tpServ',TpServPagToStr( Ide.tpServ      ));
          INIRec.WriteInteger('ide','cMunIni',Ide.cMunIni    );
          INIRec.WriteString('ide','xMunIni',Ide.xMunIni     );
          INIRec.WriteString('ide','UFIni',Ide.UFIni       );
          INIRec.WriteInteger('ide','cMunFim',Ide.cMunFim    );
          INIRec.WriteString('ide','xMunFim',Ide.xMunFim     );
          INIRec.WriteString('ide','UFFim',Ide.UFFim       );
          INIRec.WriteString('ide','retira',TpRetiraPagToStr( Ide.retira     ));
          INIRec.WriteString('ide','xDetRetira',Ide.xDetRetira  );

          INIRec.WriteString('toma3','toma', TpTomadorToStr( Ide.toma03.Toma ));
          {
          Ide.toma4.CNPJCPF := INIRec.ReadString('toma4','CNPJCPF','');
          Ide.toma4.IE      := INIRec.ReadString('toma4','IE','');
          Ide.toma4.xNome   := INIRec.ReadString('toma4','xNome','');
          Ide.toma4.xFant   := INIRec.ReadString('toma4','xFant','');
          Ide.toma4.fone    := INIRec.ReadString('toma4','fone','');
            with Ide.toma4.enderToma do
            begin
              xLgr    := INIRec.ReadString('toma4','xLgr','');
              nro     := INIRec.ReadString('toma4','nro','');
              xCpl    := INIRec.ReadString('toma4','xCpl','');
              xBairro := INIRec.ReadString('toma4','xBairro','');
              cMun    := INIRec.ReadInteger('toma4','cMun',0);
              xMun    := INIRec.ReadString('toma4','xMun','');
              CEP     := INIRec.ReadInteger('toma4','CEP',0);
              UF      := INIRec.ReadString('toma4','UF','');
              if cMun <= 0 then
                cMun := ObterCodigoMunicipio(xMun,UF);
              cPais   := INIRec.ReadInteger('toma4','cPais',0);
              xPais   := INIRec.ReadString('toma4','xPais','');
            end;
          Ide.toma4.email   := INIRec.ReadString('toma4','email','');
          }
          INIRec.WriteString( 'ide','dhCont'  ,DateToStr( Ide.dhCont      ));
          INIRec.WriteString(  'ide','xJust' ,Ide.xJust      );

          INIRec.WriteString('compl','xCaracAd',compl.xCaracAd  );
          INIRec.WriteString('compl','xCaracSer',compl.xCaracSer  );
          INIRec.WriteString('compl','xEmi',compl.xEmi  );

          INIRec.WriteString('compl','tpPer', TpDataPeriodoToStr(  compl.Entrega.TipoData ));
          INIRec.WriteString('compl','tpHor', TpHorarioIntervaloToStr (compl.Entrega.TipoHora ));
          {ainda tem mais dados aqui}

          {...}
          INIRec.WriteString('compl','origCalc',compl.origCalc  );
          INIRec.WriteString('compl','destCalc',compl.destCalc  );
          INIRec.WriteString('compl','xObs',compl.xObs  );

          INIRec.WriteString('emit','CNPJ',Emit.CNPJ   );
          INIRec.WriteString('emit','IE',Emit.IE      );
          INIRec.WriteString('emit','xNome',Emit.xNome  );
          INIRec.WriteString('emit','xFant',Emit.xFant );

          INIRec.WriteString('emit','xLgr',Emit.enderEmit.xLgr     );
          INIRec.WriteString('emit','nro',Emit.enderEmit.nro      );
          INIRec.WriteString('emit', 'xCpl',Emit.enderEmit.xCpl     );
          INIRec.WriteString('emit','xBairro',Emit.enderEmit.xBairro  );
          INIRec.WriteInteger('emit','cMun',Emit.enderEmit.cMun     );
          INIRec.WriteString('emit','xMun',Emit.enderEmit.xMun     );
          INIRec.WriteInteger('emit','CEP',Emit.enderEmit.CEP      );
          INIRec.WriteString('emit','UF',Emit.enderEmit.UF       );

          INIRec.WriteString('emit','fone',Emit.enderEmit.fone     );

          INIRec.WriteInteger('ide','cUF', ide.cUF  );

          INIRec.WriteString('rem','CNPJCPF',Rem.CNPJCPF             );
          INIRec.WriteString('rem','IE',Rem.IE                  );
          INIRec.WriteString('rem','xNome',Rem.xNome                );
          INIRec.WriteString('rem','xFant',Rem.xFant               );
          INIRec.WriteString('rem','fone',Rem.fone                );

          INIRec.WriteString('rem','xLgr',Rem.enderReme.xLgr      );
          INIRec.WriteString('rem','nro',Rem.enderReme.nro       );
          INIRec.WriteString('rem','xCpl',Rem.enderReme.xCpl      );
          INIRec.WriteString('rem','xBairro',Rem.enderReme.xBairro   );
          INIRec.WriteInteger('rem','cMun',Rem.enderReme.cMun      );
          INIRec.WriteString('rem','xMun',Rem.enderReme.xMun      );
          INIRec.WriteInteger('rem','CEP',Rem.enderReme.CEP       );
          INIRec.WriteString('rem','UF',Rem.enderReme.UF        );
          INIRec.WriteInteger( 'rem','PaisCod'    ,Rem.enderReme.cPais      );
          INIRec.WriteString(  'rem','Pais'       ,Rem.enderReme.xPais      );
          INIRec.WriteString(  'rem','Email' ,Rem.email                );

        {$IFNDEF PL_200}
          for i := 0 to Rem.infNF.Count -1 do
          begin
            sSecao := 'infNF'+IntToStrZero(I+1,3);

            with Rem.infNF.Items[i] do
            begin
              INIRec.WriteString(sSecao,'nRoma',nRoma);
              INIRec.WriteString(sSecao,'nPed',nPed);
              INIRec.WriteString(sSecao,'mod',ModeloNFToStr(modelo));
              INIRec.WriteString(sSecao,'serie',serie);
              INIRec.WriteString(sSecao,'nDoc',nDoc);
              INIRec.WriteString(sSecao,'dEmi',DateToStr(dEmi));
              INIRec.WriteString(sSecao,'vBC',vBC);
              INIRec.WriteString(sSecao,'vICMS',vICMS);
              INIRec.WriteString(sSecao,'vBCST',vBCST);
              INIRec.WriteString(sSecao,'vST',vST);
              INIRec.WriteString(sSecao,'vProd',vProd);
              INIRec.WriteString(sSecao,'vNF',vNF);
              INIRec.WriteInteger(sSecao,'nCFOP',nCFOP);
              INIRec.WriteString(sSecao,'nPeso',nPeso);
              INIRec.WriteString(sSecao,'PIN',PIN);
            end;
          end;

          for i := 0 to Rem.infNFe.Count -1 do
          begin
            sSecao := 'infNFe'+IntToStrZero(I+1,3);

            with Rem.infNFe.Items[i] do
            begin
              INIRec.WriteString(sSecao,'chave',chave);
              INIRec.WriteString(sSecao,'PIN',PIN);
            end;
          end;
        {$ENDIF}

          INIRec.WriteString('Dest','CNPJCPF',Dest.CNPJCPF   );
          INIRec.WriteString('Dest','IE',Dest.IE       );
          INIRec.WriteString('Dest','xNome',Dest.xNome    );
          INIRec.WriteString('Dest','fone',Dest.fone     );

          INIRec.WriteString('Dest','xLgr',Dest.enderDest.xLgr     );
          INIRec.WriteString('Dest','nro',Dest.enderDest.nro      );
          INIRec.WriteString('Dest','xCpl',Dest.enderDest.xCpl   );
          INIRec.WriteString('Dest','xBairro',Dest.enderDest.xBairro );
          INIRec.WriteInteger('Dest','cMun',Dest.enderDest.cMun     );
          INIRec.WriteString('Dest','xMun',Dest.enderDest.xMun     );
          INIRec.WriteInteger('Dest', 'CEP',Dest.enderDest.CEP      );
          INIRec.WriteString('Dest','UF',Dest.enderDest.UF       );

          INIRec.WriteInteger('Dest','cPais',Dest.enderDest.cPais    );
          INIRec.WriteString('Dest', 'xPais', Dest.enderDest.xPais    );

          INIRec.WriteString('vPrest','vTPrest', CurrToStr( vPrest.vTPrest ));
          INIRec.WriteString('vPrest','vRec',CurrToStr( vPrest.vRec ));

          for i := 0 to vPrest.comp.Count - 1 do
          begin
            sSecao    := 'Comp'+IntToStrZero(I+1,3);
            with vPrest.comp.Items[i] do
            begin
              INIRec.WriteString(sSecao,'xNome',xNome );
              INIRec.WriteString(sSecao,'vComp',CurrToStr( vComp ));
            end;
          end;

          if Imp.ICMS.ICMS00.CST <> cst00 then
          begin
            INIRec.WriteString('ICMS00','CST',CSTICMSToStr(Imp.ICMS.ICMS00.CST));
            INIRec.WriteString('ICMS00','vBC',CurrToStr( Imp.ICMS.ICMS00.vBC ));
            INIRec.WriteString('ICMS00','pICMS',CurrToStr(Imp.ICMS.ICMS00.pICMS  ));
            INIRec.WriteString('ICMS00','vICMS',CurrToStr(Imp.ICMS.ICMS00.vICMS ));
          end;

          if Imp.ICMS.ICMS20.CST <> cst00 then
          begin
            INIRec.WriteString('ICMS20','CST',CSTICMSToStr(Imp.ICMS.ICMS20.CST )    );
            INIRec.WriteString('ICMS20','pRedBC',CurrToStr(Imp.ICMS.ICMS20.pRedBC  ));
            INIRec.WriteString('ICMS20','vBC',CurrToStr(Imp.ICMS.ICMS20.vBC     ));
            INIRec.WriteString('ICMS20','pICMS',CurrToStr(Imp.ICMS.ICMS20.pICMS   ));
            INIRec.WriteString('ICMS20','vICMS',CurrToStr(Imp.ICMS.ICMS20.vICMS   ));
          end;

          if Imp.ICMS.ICMS45.CST <> cst00 then
            INIRec.WriteString('ICMS45','CST',CSTICMSToStr(Imp.ICMS.ICMS45.CST ));

          if Imp.ICMS.ICMS60.CST <> cst00 then
          begin
            INIRec.WriteString('ICMS60','CST',CSTICMSToStr(Imp.ICMS.ICMS60.CST     ));
            INIRec.WriteString('ICMS60','vBCSTRet',CurrToStr(Imp.ICMS.ICMS60.vBCSTRet ));
            INIRec.WriteString('ICMS60','vICMSSTRet',CurrToStr(Imp.ICMS.ICMS60.vICMSSTRet ));
            INIRec.WriteString('ICMS60','pICMSSTRet',CurrToStr(Imp.ICMS.ICMS60.pICMSSTRet ));
            INIRec.WriteString('ICMS60','vCred',CurrToStr(Imp.ICMS.ICMS60.vCred ));
          end;

          if Imp.ICMS.ICMS90.CST <> cst00 then
          begin
            INIRec.WriteString('ICMS90','CST',CSTICMSToStr(Imp.ICMS.ICMS90.CST     ));
            INIRec.WriteString('ICMS90','pRedBC',CurrToStr(Imp.ICMS.ICMS90.pRedBC));
            INIRec.WriteString('ICMS90','vBC',CurrToStr(Imp.ICMS.ICMS90.vBC ));
            INIRec.WriteString('ICMS90','pICMS',CurrToStr(Imp.ICMS.ICMS90.pICMS ));
            INIRec.WriteString('ICMS90','vICMS',CurrToStr(Imp.ICMS.ICMS90.vICMS ));
            INIRec.WriteString('ICMS90','vCred',CurrToStr(Imp.ICMS.ICMS90.vCred ) );
          end;

          if Imp.ICMS.ICMSOutraUF.CST <> cst00 then
          begin
            INIRec.WriteString('ICMSOutraUF','CST',CSTICMSToStr(Imp.ICMS.ICMSOutraUF.CST     ));
            INIRec.WriteString('ICMSOutraUF','pRedBCOutraUF',CurrToStr(Imp.ICMS.ICMSOutraUF.pRedBCOutraUF));
            INIRec.WriteString('ICMSOutraUF','vBCOutraUF',CurrToStr(Imp.ICMS.ICMSOutraUF.vBCOutraUF ));
            INIRec.WriteString('ICMSOutraUF','pICMSOutraUF',CurrToStr(Imp.ICMS.ICMSOutraUF.pICMSOutraUF ));
            INIRec.WriteString('ICMSOutraUF','vICMSOutraUF',CurrToStr(Imp.ICMS.ICMSOutraUF.vICMSOutraUF ));
          end;

          {indica se é simples}
          if (Imp.ICMS.ICMSSN.indSN = 1) and (Imp.ICMS.SituTrib = cstICMSSN) then
            INIRec.WriteInteger('ICMSSN', 'indSN',Imp.ICMS.ICMSSN.indSN );

        {$IFDEF PL_200}
          INIRec.WriteString('infCarga','vCarga',CurrToStr( infMDFeNorm.infCarga.vCarga ));
          INIRec.WriteString('infCarga','proPred',infMDFeNorm.infCarga.proPred);
          INIRec.WriteString('infCarga','xOutCat',infMDFeNorm.infCarga.xOutCat);
        {$ELSE}
          INIRec.WriteString('infCarga','vCarga',CurrToStr( infCarga.vCarga ));
          INIRec.WriteString('infCarga','proPred',infCarga.proPred);
          INIRec.WriteString('infCarga','xOutCat',infCarga.xOutCat);
        {$ENDIF}

        {$IFDEF PL_200}
          for i := 0 to infMDFeNorm.infCarga.infQ.Count -1 do
        {$ELSE}
          for i := 0 to infCarga.infQ.Count -1 do
        {$ENDIF}
          begin
            sSecao := 'infQ'+IntToStrZero(I+1,3);

        {$IFDEF PL_200}
            with infMDFeNorm.infCarga.infQ.Items[i] do
        {$ELSE}
            with infCarga.infQ.Items[i] do
        {$ENDIF}
            begin
              INIRec.WriteString(sSecao,'cUnid',UnidMedToStr( cUnid ));
              INIRec.WriteString(sSecao,'tpMed',tpMed);
              INIRec.WriteString(sSecao,'qCarga',CurrToStr(qCarga ));
            end;
          end;

        {$IFDEF PL_200}
          for i := 0 to infMDFeNorm.infDoc.infNF.Count -1 do
          begin
            sSecao := 'infNF'+IntToStrZero(I+1,3);

            with infMDFeNorm.infDoc.infNF.Items[i] do
            begin
              INIRec.WriteString(sSecao,'nRoma',nRoma);
              INIRec.WriteString(sSecao,'nPed',nPed);
              INIRec.WriteString(sSecao,'mod',ModeloNFToStr(modelo));
              INIRec.WriteString(sSecao,'serie',serie);
              INIRec.WriteString(sSecao,'nDoc',nDoc);
              INIRec.WriteString(sSecao,'dEmi',DateToStr(dEmi));
              INIRec.WriteString(sSecao,'vBC',CurrToStr(vBC));
              INIRec.WriteString(sSecao,'vICMS',CurrToStr(vICMS));
              INIRec.WriteString(sSecao,'vBCST',CurrToStr(vBCST));
              INIRec.WriteString(sSecao,'vST',CurrToStr(vST));
              INIRec.WriteString(sSecao,'vProd',CurrToStr(vProd));
              INIRec.WriteString(sSecao,'vNF',CurrToStr(vNF));
              INIRec.WriteInteger(sSecao,'nCFOP',nCFOP);
              INIRec.WriteString(sSecao,'nPeso',CurrToStr(nPeso));
              INIRec.WriteString(sSecao,'PIN',PIN);
            end;
          end;

          for i := 0 to infMDFeNorm.infDoc.infNFe.Count -1 do
          begin
            sSecao := 'infNFe'+IntToStrZero(I+1,3);

            with infMDFeNorm.infDoc.infNFe.Items[i] do
            begin
              INIRec.WriteString(sSecao,'chave',chave);
              INIRec.WriteString(sSecao,'PIN',PIN);
            end;
          end;
        {$ENDIF}

        {$IFDEF PL_200}
          for i:= 0 to infMDFeNorm.seg.Count - 1 do
        {$ELSE}
          for i:= 0 to infSeg.Count - 1 do
        {$ENDIF}
          begin
            sSecao := 'infSeg'+IntToStrZero(I+1,3);

        {$IFDEF PL_200}
            with infMDFeNorm.seg.Items[i] do
        {$ELSE}
            with infSeg.Items[i] do
        {$ENDIF}
            begin
              INIRec.WriteString(sSecao,'respSeg',TpRspSeguroToStr( respSeg ));
              INIRec.WriteString(sSecao,'xSeg',xSeg);
              INIRec.WriteString(sSecao,'nApol',nApol);
              INIRec.WriteString(sSecao,'nAver',nAver);
              INIRec.WriteString(sSecao,'vCarga',CurrToStr( vCarga ));
            end;
          end;

        {$IFDEF PL_200}
          if infMDFeNorm.Rodo.RNTRC <> '' then
          begin
            INIRec.WriteString('Rodo','RNTRC',infMDFeNorm.Rodo.RNTRC);
            INIRec.WriteString('Rodo','dPrev',DateToStr( infMDFeNorm.Rodo.dPrev ));
            INIRec.WriteString('Rodo','lota',TpLotacaoToStr( infMDFeNorm.Rodo.Lota ));
          end;
        {$ELSE}
          if Rodo.RNTRC <> '' then
          begin
            INIRec.WriteString('Rodo','RNTRC',Rodo.RNTRC);
            INIRec.WriteString('Rodo','dPrev',DateToStr( Rodo.dPrev ));
            INIRec.WriteString('Rodo','lota',TpLotacaoToStr( Rodo.Lota ));
          end;
        {$ENDIF}
        *)
       end;
   finally
      IniMDFe := TStringList.Create;
      INIRec.GetStrings(IniMDFe);
      INIRec.Free;
      Result := StringReplace(IniMDFe.Text,sLineBreak+sLineBreak,sLineBreak,[rfReplaceAll]);
      IniMDFe.Free;
   end;

  end;

end;

end.

