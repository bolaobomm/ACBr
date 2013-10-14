{$I ACBr.inc}

unit ACBrProvedorBetim;

interface

uses
  Classes, SysUtils,
  pnfsConversao, pcnAuxiliar,
  ACBrNFSeConfiguracoes, ACBrNFSeUtil, ACBrUtil, ACBrDFeUtil,
  {$IFDEF COMPILER6_UP} DateUtils {$ELSE} ACBrD5, FileCtrl {$ENDIF};

type
  { TACBrProvedorBetim }

 TProvedorBetim = class(TProvedorClass)
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

{ TProvedorBetim }

constructor TProvedorBetim.Create;
begin
 {----}
end;

function TProvedorBetim.GetConfigCidade(ACodCidade,
  AAmbiente: Integer): TConfigCidade;
var
 ConfigCidade: TConfigCidade;
begin
 ConfigCidade.VersaoSoap    := '1.2';
 ConfigCidade.Prefixo2      := '';
 ConfigCidade.Prefixo3      := '';
 ConfigCidade.Prefixo4      := '';
 ConfigCidade.Identificador := 'Id';

// if AAmbiente = 1
//  then ConfigCidade.NameSpaceEnvelope := 'http://betim.rps.com.br/sgm/zend/default/xsd/nfse?format=xml'
//  else ConfigCidade.NameSpaceEnvelope := 'http://betim.rps.com.br/sgm/zend/default/xsd/nfse?format=xml';

 if AAmbiente = 1
  then ConfigCidade.NameSpaceEnvelope := 'https://betim.rps.com.br/sgm/zend/nfs/nfs'
  else ConfigCidade.NameSpaceEnvelope := 'https://betim.rps.com.br/sgm/zend/nfs/ambienteteste';

 ConfigCidade.AssinaRPS  := False;
 ConfigCidade.AssinaLote := True;

 Result := ConfigCidade;
end;

function TProvedorBetim.GetConfigSchema(ACodCidade: Integer): TConfigSchema;
var
 ConfigSchema: TConfigSchema;
begin
 ConfigSchema.VersaoCabecalho := '1.00';
 ConfigSchema.VersaoDados     := '1.00';
 ConfigSchema.VersaoXML       := '1';
 ConfigSchema.NameSpaceXML    := 'http://betim.rps.com.br/sgm/zend/default/xsd/nfse?format=xml';
 ConfigSchema.Cabecalho       := 'nfse.xsd';
 ConfigSchema.ServicoEnviar   := 'nfse.xsd';
 ConfigSchema.ServicoConSit   := 'nfse.xsd';
 ConfigSchema.ServicoConLot   := 'nfse.xsd';
 ConfigSchema.ServicoConRps   := 'nfse.xsd';
 ConfigSchema.ServicoConNfse  := 'nfse.xsd';
 ConfigSchema.ServicoCancelar := 'nfse.xsd';
 ConfigSchema.DefTipos        := '';

 Result := ConfigSchema;
end;

function TProvedorBetim.GetConfigURL(ACodCidade: Integer): TConfigURL;
var
 ConfigURL: TConfigURL;
begin
 ConfigURL.HomNomeCidade         := '';
 ConfigURL.HomRecepcaoLoteRPS    := 'https://betim.rps.com.br/sgm/zend/nfs/ambienteteste';  // /wsdl
 ConfigURL.HomConsultaLoteRPS    := 'https://betim.rps.com.br/sgm/zend/nfs/ambienteteste';
 ConfigURL.HomConsultaNFSeRPS    := 'https://betim.rps.com.br/sgm/zend/nfs/ambienteteste';
 ConfigURL.HomConsultaSitLoteRPS := 'https://betim.rps.com.br/sgm/zend/nfs/ambienteteste';
 ConfigURL.HomConsultaNFSe       := 'https://betim.rps.com.br/sgm/zend/nfs/ambienteteste';
 ConfigURL.HomCancelaNFSe        := 'https://betim.rps.com.br/sgm/zend/nfs/ambienteteste';

 ConfigURL.ProNomeCidade         := '';
 ConfigURL.ProRecepcaoLoteRPS    := 'https://betim.rps.com.br/sgm/zend/nfs/nfs'; // /wsdl
 ConfigURL.ProConsultaLoteRPS    := 'https://betim.rps.com.br/sgm/zend/nfs/nfs';
 ConfigURL.ProConsultaNFSeRPS    := 'https://betim.rps.com.br/sgm/zend/nfs/nfs';
 ConfigURL.ProConsultaSitLoteRPS := 'https://betim.rps.com.br/sgm/zend/nfs/nfs';
 ConfigURL.ProConsultaNFSe       := 'https://betim.rps.com.br/sgm/zend/nfs/nfs';
 ConfigURL.ProCancelaNFSe        := 'https://betim.rps.com.br/sgm/zend/nfs/nfs';

 Result := ConfigURL;
end;

function TProvedorBetim.GetURI(URI: String): String;
begin
 Result := URI;
end;

function TProvedorBetim.GetAssinarXML(Acao: TnfseAcao): Boolean;
begin
 case Acao of
   acRecepcionar: Result := False;
   acConsSit:     Result := False;
   acConsLote:    Result := False;
   acConsNFSeRps: Result := False;
   acConsNFSe:    Result := False;
   acCancelar:    Result := False;
   acGerar:       Result := False;
   else           Result := False;
 end;
end;

function TProvedorBetim.GetValidarLote: Boolean;
begin
 Result := False;
end;

function TProvedorBetim.Gera_TagI(Acao: TnfseAcao; Prefixo3, Prefixo4,
  NameSpaceDad, Identificador, URI: String): AnsiString;
begin
 case Acao of
   acRecepcionar: Result := '<' + Prefixo3 + 'EnviarLoteRpsEnvio' + NameSpaceDad;
   acConsSit:     Result := '<' + Prefixo3 + 'ConsultarSituacaoLoteRpsEnvio' + NameSpaceDad;
   acConsLote:    Result := '<' + Prefixo3 + 'ConsultarLoteRpsEnvio' + NameSpaceDad;
   acConsNFSeRps: Result := '<' + Prefixo3 + 'ConsultarNfseRpsEnvio' + NameSpaceDad;
   acConsNFSe:    Result := '<' + Prefixo3 + 'ConsultarNfseEnvio' + NameSpaceDad;
   acCancelar:    Result := '<' + Prefixo3 + 'CancelarNfseEnvio' + NameSpaceDad +
                             '<' + Prefixo3 + 'Pedido>' +
                              '<' + Prefixo4 + 'InfPedidoCancelamento' +
                                 DFeUtil.SeSenao(Identificador <> '', ' ' + Identificador + '="' + URI + '"', '') + '>';
   acGerar:       Result := '';
 end;
end;

function TProvedorBetim.Gera_CabMsg(Prefixo2, VersaoLayOut, VersaoDados,
  NameSpaceCab: String; ACodCidade: Integer): AnsiString;
begin
 Result := '<' + Prefixo2 + 'cabecalho versao="'  + VersaoLayOut + '"' + NameSpaceCab +
            '<versaoDados>' + VersaoDados + '</versaoDados>'+
           '</' + Prefixo2 + 'cabecalho>';
end;

function TProvedorBetim.Gera_DadosSenha(CNPJ, Senha: String): AnsiString;
begin
 Result := '';
end;

function TProvedorBetim.Gera_TagF(Acao: TnfseAcao; Prefixo3: String): AnsiString;
begin
 case Acao of
   acRecepcionar: Result := '</' + Prefixo3 + 'EnviarLoteRpsEnvio>';
   acConsSit:     Result := '</' + Prefixo3 + 'ConsultarSituacaoLoteRpsEnvio>';
   acConsLote:    Result := '</' + Prefixo3 + 'ConsultarLoteRpsEnvio>';
   acConsNFSeRps: Result := '</' + Prefixo3 + 'ConsultarNfseRpsEnvio>';
   acConsNFSe:    Result := '</' + Prefixo3 + 'ConsultarNfseEnvio>';
   acCancelar:    Result := '</' + Prefixo3 + 'Pedido>' +
                            '</' + Prefixo3 + 'CancelarNfseEnvio>';
   acGerar:       Result := '';
 end;
end;

function TProvedorBetim.GeraEnvelopeRecepcionarLoteRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
var
 AXML: String;
begin
 AXML := '<?xml version="1.0" encoding="UTF-8"?>' +
         DadosMsg;
 AXML := StringReplace(StringReplace(AXML, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]);

 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" ' +
                          'xmlns:tns="' + URLNS + '" ' +
                          'xmlns:xsd="http://www.w3.org/2001/XMLSchema" ' +
                          'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                          'xmlns:soapenc="http://schemas.xmlsoap,org/soap/encoding/" ' +
                          'soap:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">' +
//                       'xmlns:types="' + URLNS + '/encodedTypes" ' +
//            '<soap:Body soap:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">' +
            '<soap:Body>' +
             '<tns:RecepcionarLoteRps>' +
              '<EnviarLoteRpsEnvio xsi:type="xsd:string">' +
                AXML +
              '</EnviarLoteRpsEnvio>' +
             '</tns:RecepcionarLoteRps>' +
            '</soap:Body>' +
           '</soap:Envelope>';
end;

function TProvedorBetim.GeraEnvelopeConsultarSituacaoLoteRPS(
  URLNS: String; CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
var
 AXML: String;
begin
 AXML := '<?xml version="1.0" encoding="UTF-8"?>' +
         DadosMsg;
 AXML := StringReplace(StringReplace(AXML, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]);

 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" ' +
                       'xmlns:soapenc="http://schemas.xmlsoap,org/soap/encoding/" ' +
                       'xmlns:tns="' + URLNS + '" ' +
                       'xmlns:types="' + URLNS + '/encodedTypes" ' +
                       'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                       'xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
//            '<soap:Body soap:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">' +
            '<soap:Body>' +
             '<tns:ConsultarSituacaoLoteRps>' +
                AXML +
             '</tns:ConsultarSituacaoLoteRps>' +

//             '<ConsultarSituacaoLoteRpsEnvio xmlns="' + URLNS + '">' +
//              '<MensagemXML>' +
//                StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
//              '</MensagemXML>' +
//             '</ConsultarSituacaoLoteRpsEnvio>' +

            '</soap:Body>' +
           '</soap:Envelope>';
end;

function TProvedorBetim.GeraEnvelopeConsultarLoteRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
var
 AXML: String;
begin
 AXML := '<?xml version="1.0" encoding="UTF-8"?>' +
         DadosMsg;
 AXML := StringReplace(StringReplace(AXML, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]);

 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" ' +
                       'xmlns:soapenc="http://schemas.xmlsoap,org/soap/encoding/" ' +
                       'xmlns:tns="' + URLNS + '" ' +
                       'xmlns:types="' + URLNS + '/encodedTypes" ' +
                       'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                       'xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
//            '<soap:Body soap:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">' +
            '<soap:Body>' +
             '<tns:ConsultarLoteRps>' +
                AXML +
             '</tns:ConsultarLoteRps>' +

//             '<ConsultarLoteRpsEnvio xmlns="' + URLNS + '">' +
//              '<MensagemXML>' +
//                StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
//              '</MensagemXML>' +
//             '</ConsultarLoteRpsEnvio>' +

            '</soap:Body>' +
           '</soap:Envelope>';
end;

function TProvedorBetim.GeraEnvelopeConsultarNFSeporRPS(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
var
 AXML: String;
begin
 AXML := '<?xml version="1.0" encoding="UTF-8"?>' +
         DadosMsg;
 AXML := StringReplace(StringReplace(AXML, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]);

 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" ' +
                       'xmlns:soapenc="http://schemas.xmlsoap,org/soap/encoding/" ' +
                       'xmlns:tns="' + URLNS + '" ' +
                       'xmlns:types="' + URLNS + '/encodedTypes" ' +
                       'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                       'xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
//            '<soap:Body soap:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">' +
            '<soap:Body>' +
             '<tns:ConsultarNfsePorRps>' +
                AXML +
             '</tns:ConsultarNfsePorRps>' +

//             '<ConsultarNfseRpsEnvio xmlns="' + URLNS + '">' +
//              '<MensagemXML>' +
//                StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
//              '</MensagemXML>' +

             '</ConsultarNfseRpsEnvio>' +
            '</soap:Body>' +
           '</soap:Envelope>';
end;

function TProvedorBetim.GeraEnvelopeConsultarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
var
 AXML: String;
begin
 AXML := '<?xml version="1.0" encoding="UTF-8"?>' +
         DadosMsg;
 AXML := StringReplace(StringReplace(AXML, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]);

 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" ' +
                       'xmlns:soapenc="http://schemas.xmlsoap,org/soap/encoding/" ' +
                       'xmlns:tns="' + URLNS + '" ' +
                       'xmlns:types="' + URLNS + '/encodedTypes" ' +
                       'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                       'xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
//            '<soap:Body soap:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">' +
            '<soap:Body>' +
             '<tns:ConsultarNfse>' +
                AXML +
             '</tns:ConsultarNfse>' +

//             '<ConsultarNfseEnvio xmlns="' + URLNS + '">' +
//              '<MensagemXML>' +
//                StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
//              '</MensagemXML>' +

             '</ConsultarNfseEnvio>' +
            '</soap:Body>' +
           '</soap:Envelope>';
end;

function TProvedorBetim.GeraEnvelopeCancelarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
var
 AXML: String;
begin
 AXML := '<?xml version="1.0" encoding="UTF-8"?>' +
         DadosMsg;
 AXML := StringReplace(StringReplace(AXML, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]);

 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" ' +
                       'xmlns:soapenc="http://schemas.xmlsoap,org/soap/encoding/" ' +
                       'xmlns:tns="' + URLNS + '" ' +
                       'xmlns:types="' + URLNS + '/encodedTypes" ' +
                       'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                       'xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
//            '<soap:Body soap:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">' +
            '<soap:Body>' +
             '<tns:CancelarNfse>' +
                AXML +
             '</tns:CancelarNfse>' +

//             '<CancelarNfseEnvio xmlns="' + URLNS + '">' +
//              '<MensagemXML>' +
//                StringReplace(StringReplace(DadosMsg, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]) +
//              '</MensagemXML>' +

             '</CancelarNfseEnvio>' +
            '</soap:Body>' +
           '</soap:Envelope>';
end;

function TProvedorBetim.GeraEnvelopeGerarNFSe(URLNS: String; CabMsg,
  DadosMsg, DadosSenha: AnsiString): AnsiString;
var
 AXML: String;
begin
 AXML := '<?xml version="1.0" encoding="UTF-8"?>' +
         DadosMsg;
 AXML := StringReplace(StringReplace(AXML, '<', '&lt;', [rfReplaceAll]), '>', '&gt;', [rfReplaceAll]);

 result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" ' +
                       'xmlns:soapenc="http://schemas.xmlsoap,org/soap/encoding/" ' +
                       'xmlns:tns="' + URLNS + '" ' +
                       'xmlns:types="' + URLNS + '/encodedTypes" ' +
                       'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' +
                       'xmlns:xsd="http://www.w3.org/2001/XMLSchema">' +
//            '<soap:Body soap:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">' +
            '<soap:Body>' +
             '<tns:GerarNfse>' +
                AXML +
             '</tns:GerarNfse>' +
            '</soap:Body>' +
           '</soap:Envelope>';
end;

function TProvedorBetim.GetSoapAction(Acao: TnfseAcao; NomeCidade: String): String;
begin
 case Acao of
   acRecepcionar: Result := 'https://betim.rps.com.br/sgm/zend/nfs/ambienteteste#RecepcionarLoteRps';
   acConsSit:     Result := 'https://betim.rps.com.br/sgm/zend/nfs/ambienteteste#ConsultarSituacaoLoteRps';
   acConsLote:    Result := 'https://betim.rps.com.br/sgm/zend/nfs/ambienteteste#ConsultarLoteRps';
   acConsNFSeRps: Result := 'https://betim.rps.com.br/sgm/zend/nfs/ambienteteste#ConsultarNfsePorRps';
   acConsNFSe:    Result := 'https://betim.rps.com.br/sgm/zend/nfs/ambienteteste#ConsultarNfse';
   acCancelar:    Result := 'https://betim.rps.com.br/sgm/zend/nfs/ambienteteste#CancelarNfse';
   acGerar:       Result := 'https://betim.rps.com.br/sgm/zend/nfs/ambienteteste#GerarNfse';
 end;
end;

function TProvedorBetim.GetRetornoWS(Acao: TnfseAcao; RetornoWS: AnsiString): AnsiString;
begin
 case Acao of
   acRecepcionar: Result := SeparaDados( RetornoWS, 'return' );
   acConsSit:     Result := SeparaDados( RetornoWS, 'return' );
   acConsLote:    Result := SeparaDados( RetornoWS, 'return' );
   acConsNFSeRps: Result := SeparaDados( RetornoWS, 'return' );
   acConsNFSe:    Result := SeparaDados( RetornoWS, 'return' );
   acCancelar:    Result := SeparaDados( RetornoWS, 'return' );
   acGerar:       Result := SeparaDados( RetornoWS, 'return' );
 end;
(*
 case Acao of
   acRecepcionar: begin
                   RetWS := SeparaDados( RetornoWS, 'EnviarLoteRpsResposta>' );
                   RetWS := RetWS + '</EnviarLoteRpsResposta>';
                   Result := RetWS;
                  end;
   acConsSit:     Result := SeparaDados( RetornoWS, 'ConsultarSituacaoLoteRpsResposta' );
   acConsLote:    Result := SeparaDados( RetornoWS, 'ConsultarLoteRpsRpsResposta' );
   acConsNFSeRps: begin
                   RetWS := SeparaDados( RetornoWS, 'ConsultarNfseRpsResposta>' );
                   RetWS := RetWS + '</ConsultarNfseRpsResposta>';
                   Result := RetWS;
                  end;
   acConsNFSe:    begin
                   RetWS := SeparaDados( RetornoWS, 'ConsultarNfseResposta>' );
                   RetWS := RetWS + '</ConsultarNfseResposta>';
                   Result := RetWS;
                  end;
   acCancelar:    begin
                   RetWS := SeparaDados( RetornoWS, 'CancelarNfseResposta>' );
                   RetWS := RetWS + '</CancelarNfseResposta>';
                   Result := RetWS;
                  end;
   acGerar:       Result := '';
 end;
*)
end;

function TProvedorBetim.GeraRetornoNFSe(Prefixo: String;
  RetNFSe: AnsiString; NomeCidade: String): AnsiString;
begin
 Result := '<?xml version="1.0" encoding="UTF-8"?>' +
           '<' + Prefixo + 'CompNfse xmlns="http://www.abrasf.org.br/ABRASF/arquivos/">' +
             RetNfse +
           '</' + Prefixo + 'CompNfse>';
end;

function TProvedorBetim.GetLinkNFSe(ACodMunicipio, ANumeroNFSe: Integer;
  ACodVerificacao, AInscricaoM: String; AAmbiente: Integer): String;
begin
 Result := '';
end;

function TProvedorBetim.GeraEnvelopeRecepcionarSincrono(URLNS: String;
  CabMsg, DadosMsg, DadosSenha: AnsiString): AnsiString;
begin
 Result := '';
end;

end.
