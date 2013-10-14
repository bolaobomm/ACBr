{$I ACBr.inc}

unit ACBrProvedor4R;

interface

uses
  Classes, SysUtils,
  pnfsConversao, pcnAuxiliar,
  ACBrNFSeConfiguracoes, ACBrUtil, ACBrDFeUtil,
  {$IFDEF COMPILER6_UP} DateUtils {$ELSE} ACBrD5, FileCtrl {$ENDIF};

type
  { TACBrProvedor4R }

 TProvedor4R = class(TProvedorClass)
  protected
   { protected }
  private
   { private }
  public
   { public }
   Constructor Create;

   function GetConfigCidade(ACodCidade, AAmbiente: Integer): TConfigCidade; OverRide;
   function GetConfigSchema(ACodCidade: Integer): TConfigSchema; OverRide;
   function GetConfigURL(ACodCidade: Integer): TConfigURL; OverRide;
   function GetURI(URI: String): String; OverRide;
   function GetAssinarXML(Acao: TnfseAcao): Boolean; OverRide;
   function GetValidarLote: Boolean; OverRide;

   function Gera_TagI(Acao: TnfseAcao; Prefixo3, Prefixo4, NameSpaceDad, Identificador, URI: String): AnsiString; OverRide;
   function Gera_CabMsg(Prefixo2, VersaoLayOut, VersaoDados, NameSpaceCab: String; ACodCidade: Integer): AnsiString; OverRide;
   function Gera_DadosSenha(CNPJ, Senha: String): AnsiString; OverRide;
   function Gera_TagF(Acao: TnfseAcao; Prefixo3: String): AnsiString; OverRide;

   function GeraEnvelopeRecepcionarLoteRPS(URLNS: String; CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString; OverRide;
   function GeraEnvelopeConsultarSituacaoLoteRPS(URLNS: String; CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString; OverRide;
   function GeraEnvelopeConsultarLoteRPS(URLNS: String; CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString; OverRide;
   function GeraEnvelopeConsultarNFSeporRPS(URLNS: String; CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString; OverRide;
   function GeraEnvelopeConsultarNFSe(URLNS: String; CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString; OverRide;
   function GeraEnvelopeCancelarNFSe(URLNS: String; CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString; OverRide;
   function GeraEnvelopeGerarNFSe(URLNS: String; CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString; OverRide;
   function GeraEnvelopeRecepcionarSincrono(URLNS: String; CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString; OverRide;

   function GetSoapAction(Acao: TnfseAcao; NomeCidade: String): String; OverRide;
   function GetRetornoWS(Acao: TnfseAcao; RetornoWS: AnsiString): AnsiString; OverRide;

   function GeraRetornoNFSe(Prefixo: String; RetNFSe: AnsiString; NomeCidade: String): AnsiString; OverRide;
   function GetLinkNFSe(ACodMunicipio, ANumeroNFSe: Integer; ACodVerificacao, AInscricaoM: String; AAmbiente: Integer): String; OverRide;
  end;

implementation

{ TProvedor4R }
{ Informa��es de apoio: http://www.4rsistemas.com.br/wpprodutosdetalhes.aspx?24 }

constructor TProvedor4R.Create;
begin
 {----}
end;

function TProvedor4R.GetConfigCidade(ACodCidade, AAmbiente: Integer): TConfigCidade;
var
  ConfigCidade: TConfigCidade;
begin
 	ConfigCidade.VersaoSoap        := '1.1';
 	ConfigCidade.Prefixo2          := '';
 	ConfigCidade.Prefixo3          := '';
 	ConfigCidade.Prefixo4          := '';
 	ConfigCidade.Identificador     := 'Id';
	ConfigCidade.NameSpaceEnvelope := 'http://www.abrasf.org.br';
 	ConfigCidade.AssinaRPS         := True;
 	ConfigCidade.AssinaLote        := True;

 	Result := ConfigCidade;
end;

function TProvedor4R.GetConfigSchema(ACodCidade: Integer): TConfigSchema;
var
 ConfigSchema: TConfigSchema;
begin
 ConfigSchema.VersaoCabecalho       := '2.00';
 ConfigSchema.VersaoDados           := '2.00';
 ConfigSchema.VersaoXML             := '2';
 ConfigSchema.NameSpaceXML          := 'http://www.abrasf.org.br/';
 ConfigSchema.Cabecalho             := 'nfse.xsd';
 ConfigSchema.ServicoEnviar         := 'nfse.xsd';
 ConfigSchema.ServicoConSit         := 'nfse.xsd';
 ConfigSchema.ServicoConLot         := 'nfse.xsd';
 ConfigSchema.ServicoConRps         := 'nfse.xsd';
 ConfigSchema.ServicoConNfse        := 'nfse.xsd';
 ConfigSchema.ServicoCancelar       := 'nfse.xsd';
 ConfigSchema.ServicoGerar          := 'nfse.xsd';
 ConfigSchema.ServicoEnviarSincrono := 'nfse.xsd';
 ConfigSchema.DefTipos              := '';

 Result := ConfigSchema;
end;

function TProvedor4R.GetConfigURL(ACodCidade: Integer): TConfigURL;
var
 	ConfigURL: TConfigURL;
begin
  case ACodCidade of
   3554003:
     begin
    	 ConfigURL.HomNomeCidade         := 'tatui';

    	 ConfigURL.HomRecepcaoLoteRPS    := '';
    	 ConfigURL.HomConsultaLoteRPS    := 'http://abrasf.sistemas4r.com.br/aconsultarloterps.aspx?wsdl';
    	 ConfigURL.HomConsultaNFSeRPS    := 'http://tatui.sistemas4r.com.br/abrasf/ahconsultarnfseporrps.aspx?wsdl';
    	 ConfigURL.HomConsultaSitLoteRPS := '';
       ConfigURL.HomConsultaNFSe       := '';
       ConfigURL.HomCancelaNFSe        := 'http://tatui.sistemas4r.com.br/abrasf/ahcancelarnfse.aspx?wsdl';
    	 ConfigURL.HomGerarNFSe          := 'http://abrasf.sistemas4r.com.br/agerarnfse.aspx?wsdl';
    	 ConfigURL.HomRecepcaoSincrono   := 'http://tatui.sistemas4r.com.br/abrasf/ahrecepcionarloterpssincrono.aspx?wsdl';
    end;
  else
    	ConfigURL.HomNomeCidade         := '';

    	ConfigURL.HomRecepcaoLoteRPS    := '';
    	ConfigURL.HomConsultaLoteRPS    := 'http://abrasf.sistemas4r.com.br/aconsultarloterps.aspx?wsdl';
    	ConfigURL.HomConsultaNFSeRPS    := 'http://abrasf.sistemas4r.com.br/aconsultarnfseporrps.aspx?wsdl';
    	ConfigURL.HomConsultaSitLoteRPS := '';
    	ConfigURL.HomConsultaNFSe       := '';
    	ConfigURL.HomCancelaNFSe        := 'http://abrasf.sistemas4r.com.br/acancelarnfse.aspx';
    	ConfigURL.HomGerarNFSe          := 'http://abrasf.sistemas4r.com.br/agerarnfse.aspx?wsdl';
    	ConfigURL.HomRecepcaoSincrono   := 'http://abrasf.sistemas4r.com.br/arecepcionarloterpssincrono.aspx?wsdl';
  end;

  case ACodCidade of
   3127701: ConfigURL.ProNomeCidade := 'valadares';
   3500105: ConfigURL.ProNomeCidade := 'adamantina';
   3510203: ConfigURL.ProNomeCidade := 'capaobonito';
   3523503: ConfigURL.ProNomeCidade := 'itatinga';
   3554003: ConfigURL.ProNomeCidade := 'tatui';
  end;

 	ConfigURL.ProRecepcaoLoteRPS    := '';
 	ConfigURL.ProConsultaLoteRPS    := 'http://' + ConfigURL.ProNomeCidade + '.sistemas4r.com.br/aconsultarloterps.aspx?wsdl';
 	ConfigURL.ProConsultaNFSeRPS    := 'http://' + ConfigURL.ProNomeCidade + '.sistemas4r.com.br/abrasf/aconsultarnfseporrps.aspx?wsdl';
 	ConfigURL.ProConsultaSitLoteRPS := '';
 	ConfigURL.ProConsultaNFSe       := '';
 	ConfigURL.ProCancelaNFSe        := 'http://' + ConfigURL.ProNomeCidade + '.sistemas4r.com.br/abrasf/acancelarnfse.aspx';
  ConfigURL.ProGerarNFSe          := 'http://' + ConfigURL.ProNomeCidade + '.sistemas4r.com.br/abrasf/agerarnfse.aspx?wsdl';
 	ConfigURL.ProRecepcaoSincrono   := 'http://' + ConfigURL.ProNomeCidade + '.sistemas4r.com.br/abrasf/arecepcionarloterpssincrono.aspx?wsdl';

 	Result := ConfigURL;
end;

function TProvedor4R.GetURI(URI: String): String;
begin
 Result := URI;
end;

function TProvedor4R.GetAssinarXML(Acao: TnfseAcao): Boolean;
begin
 case Acao of
   acRecepcionar: Result := False;
   acConsSit:     Result := False;
   acConsLote:    Result := False;
   acConsNFSeRps: Result := False;
   acConsNFSe:    Result := False;
   acCancelar:    Result := False;
   acGerar:       Result := False;
   acRecSincrono: Result := False;
   else           Result := False;
 end;
end;

function TProvedor4R.GetValidarLote: Boolean;
begin
 Result := True;
end;

function TProvedor4R.Gera_TagI(Acao: TnfseAcao; Prefixo3, Prefixo4,
  NameSpaceDad, Identificador, URI: String): AnsiString;
var
 xmlns: String;
begin
 xmlns := ' xmlns="http://www.abrasf.org.br/nfse.xsd"';

 case Acao of
   acRecepcionar: Result := '<' + Prefixo3 + 'EnviarLoteRpsEnvio' + NameSpaceDad;
   acConsSit:     Result := '<' + Prefixo3 + 'ConsultarSituacaoLoteRpsEnvio' + NameSpaceDad;
   acConsLote:    Result := '<' + Prefixo3 + 'ConsultarLoteRpsEnvio' + NameSpaceDad;
   acConsNFSeRps: Result := '<' + Prefixo3 + 'ConsultarNfseRps' + NameSpaceDad;
   acConsNFSe:    Result := '<' + Prefixo3 + 'ConsultarNfseEnvio' + NameSpaceDad;
   acCancelar:    Result := '<' + Prefixo3 + 'CancelarNfseEnvio' + NameSpaceDad +
                             '<' + Prefixo3 + 'Pedido>' +
                              '<' + Prefixo4 + 'InfPedidoCancelamento' +
                                 DFeUtil.SeSenao(Identificador <> '', ' ' + Identificador + '="' + URI + '"', '') + '>';
   acGerar:       Result := '<' + Prefixo3 + 'GerarNfseEnvio' + NameSpaceDad;
   acRecSincrono: Result := '<' + Prefixo3 + 'EnviarLoteRpsSincronoEnvio' + NameSpaceDad;
 end;
end;

function TProvedor4R.Gera_CabMsg(Prefixo2, VersaoLayOut, VersaoDados,
  NameSpaceCab: String; ACodCidade: Integer): AnsiString;
begin
 Result := '<' + Prefixo2 + 'cabecalho versao="'  + VersaoLayOut + '"' + NameSpaceCab +
            '<versaoDados>' + VersaoDados + '</versaoDados>'+
           '</' + Prefixo2 + 'cabecalho>';
end;

function TProvedor4R.Gera_DadosSenha(CNPJ, Senha: String): AnsiString;
begin
 Result := '';
end;

function TProvedor4R.Gera_TagF(Acao: TnfseAcao; Prefixo3: String): AnsiString;
begin
 case Acao of
   acRecepcionar: Result := '</' + Prefixo3 + 'EnviarLoteRpsEnvio>';
   acConsSit:     Result := '</' + Prefixo3 + 'ConsultarSituacaoLoteRpsEnvio>';
   acConsLote:    Result := '</' + Prefixo3 + 'ConsultarLoteRpsEnvio>';
   acConsNFSeRps: Result := '</' + Prefixo3 + 'ConsultarNfseRps>';
   acConsNFSe:    Result := '</' + Prefixo3 + 'ConsultarNfseEnvio>';
   acCancelar:    Result := '</' + Prefixo3 + 'Pedido>' +
                            '</' + Prefixo3 + 'CancelarNfseEnvio>';
   acGerar:       Result := '</' + Prefixo3 + 'GerarNfseEnvio>';
   acRecSincrono: Result := '</' + Prefixo3 + 'EnviarLoteRpsSincronoEnvio>';
 end;
end;

function TProvedor4R.GeraEnvelopeRecepcionarLoteRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '';
end;

function TProvedor4R.GeraEnvelopeConsultarSituacaoLoteRPS(
  URLNS: String; CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '';
end;

function TProvedor4R.GeraEnvelopeConsultarLoteRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
            '<S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" ' +
                        'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                        'xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
            '<S:Body>' +
             '<ConsultarLoteRps.Execute xmlns="http://tempuri.org/">' +
              '<Entrada>' +
                StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</Entrada>' +
             '</ConsultarLoteRps.Execute>' +
            '</S:Body>' +
           '</S:Envelope>';
end;

function TProvedor4R.GeraEnvelopeConsultarNFSeporRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="UTF-8"?>' +
            '<S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" ' +
                        'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                        'xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
            '<S:Body>' +
             '<ConsultarNfsePorRps.Execute xmlns="Abrasf2">' +
              '<Entrada>' +
                StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</Entrada>' +
             '</ConsultarNfsePorRps.Execute>' +
            '</S:Body>' +
           '</S:Envelope>';
end;

function TProvedor4R.GeraEnvelopeConsultarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '';
end;

function TProvedor4R.GeraEnvelopeCancelarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="utf-8"?>' +
           '<S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" ' +
                       'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                       'xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
            '<S:Body>' +
             '<CancelarNfse.Execute xmlns="Abrasf2">' +
              '<Entrada>' +
                StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</Entrada>' +
             '</CancelarNfse.Execute>' +
            '</S:Body>' +
           '</S:Envelope>';
end;

function TProvedor4R.GeraEnvelopeGerarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="utf-8"?>' +
           '<S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" ' +
                       'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                       'xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
            '<S:Body>' +
             '<GerarNfse.Execute xmlns="http://tempuri.org/">' +
              '<Entrada>' +
                StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</Entrada>' +
             '</GerarNfse.Execute>' +
            '</S:Body>' +
           '</S:Envelope>';
end;

function TProvedor4R.GetSoapAction(Acao: TnfseAcao; NomeCidade: String): String;
begin
 case Acao of
   acRecepcionar: Result := '';
   acConsSit:     Result := '';
   acConsLote:    Result := 'http://tempuri.org/action/ACONSULTARLOTERPS.Execute';
   acConsNFSeRps: Result := 'Abrasf2action/ACONSULTARNFSEPORRPS.Execute';
   acConsNFSe:    Result := '';
   acCancelar:    Result := 'Abrasf2action/ACANCELARNFSE.Execute';
   acGerar:       Result := 'http://tempuri.org/action/AGERARNFSE.Execute';
   acRecSincrono: Result := 'Abrasf2action/ARECEPCIONARLOTERPSSINCRONO.Execute';
 end;
end;

function TProvedor4R.GetRetornoWS(Acao: TnfseAcao; RetornoWS: AnsiString): AnsiString;
var
 RetWS: AnsiString;
begin
 case Acao of
   acRecepcionar: Result := RetornoWS;
   acConsSit:     Result := RetornoWS;
   acConsLote:    begin
                   RetWS := SeparaDados( RetornoWS, 'Resposta' );
                   Result := RetWS;
                  end;
   acConsNFSeRps: begin
                   RetWS := SeparaDados( RetornoWS, 'Resposta' );
                   Result := RetWS;
                  end;
   acConsNFSe:    Result := RetornoWS;
   acCancelar:    begin
                   RetWS := SeparaDados( RetornoWS, 'Resposta' );
                   Result := RetWS;
                  end;
   acGerar:       begin
                   RetWS := SeparaDados( RetornoWS, 'Resposta' );
                   Result := RetWS;
                  end;
   acRecSincrono: begin
                   // Incluido por Jo�o Paulo Delboni em 22/04/2013
                   RetWS := SeparaDados( RetornoWS, 'Resposta' );
                   Result := RetWS;
                  end;
 end;
end;

function TProvedor4R.GeraRetornoNFSe(Prefixo: String;
  RetNFSe: AnsiString; NomeCidade: String): AnsiString;
begin
 Result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<CompNfse xmlns="http://www.abrasf.org.br/nfse.xsd">' +
            RetNFSe +
           '</CompNfse>';
end;

function TProvedor4R.GetLinkNFSe(ACodMunicipio, ANumeroNFSe: Integer;
  ACodVerificacao, AInscricaoM: String; AAmbiente: Integer): String;
begin
 if AAmbiente = 1 then
  begin
   case ACodMunicipio of
     3127701: Result := 'https://valadares.sistemas4r.com.br/CS/Em_Impressao_Nfe.aspx?id=' + ACodVerificacao;
     3500105: Result := 'https://adamantina.sistemas4r.com.br/CS/Em_Impressao_Nfe.aspx?id=' + ACodVerificacao;
     3510203: Result := 'https://capaobonito.sistemas4r.com.br/CS/Em_Impressao_Nfe.aspx?id=' + ACodVerificacao;
     3523503: Result := 'https://itatinga.sistemas4r.com.br/CS/Em_Impressao_Nfe.aspx?id=' + ACodVerificacao;
     3554003: Result := 'https://tatui.sistemas4r.com.br/CS/Em_Impressao_Nfe.aspx?id=' + ACodVerificacao;
   else
     Result := '';
   end;
  end
 else
  begin
   case ACodMunicipio of
     3127701: Result := 'https://valadares.sistemas4r.com.br/CS/Em_Impressao_NfeHomologa.aspx?id=' + ACodVerificacao;
     3500105: Result := 'https://adamantina.sistemas4r.com.br/CS/Em_Impressao_NfeHomologa.aspx?id=' + ACodVerificacao;
     3510203: Result := 'https://capaobonito.sistemas4r.com.br/CS/Em_Impressao_NfeHomologa.aspx?id=' + ACodVerificacao;
     3523503: Result := 'https://itatinga.sistemas4r.com.br/CS/Em_Impressao_NfeHomologa.aspx?id=' + ACodVerificacao;
     3554003: Result := 'https://tatui.sistemas4r.com.br/CS/Em_Impressao_NfeHomologa.aspx?id=' + ACodVerificacao;
   else
     Result := '';
   end;     
  end;

end;

function TProvedor4R.GeraEnvelopeRecepcionarSincrono(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 result := '<?xml version="1.0" encoding="utf-8"?>' +
           '<S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/" ' +
                       'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                       'xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
            '<S:Body>' +
             // Incluido por Jo�o Paulo Delboni em 22/04/2013
             '<RecepcionarLoteRpsSincrono.Execute xmlns="Abrasf2">' +
              '<Entrada>' +
                StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
              '</Entrada>' +
             '</RecepcionarLoteRpsSincrono.Execute>' +
            '</S:Body>' +
           '</S:Envelope>';
end;

end.
