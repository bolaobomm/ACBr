{$I ACBr.inc}

unit ACBrGNREUtil;

interface

uses
  {$IFNDEF ACBrGNREOpenSSL}
    ACBrCAPICOM_TLB, ACBrMSXML2_TLB,
  {$ENDIF}
  Classes, Forms,
  {$IFDEF FPC}
    LResources, Controls, Graphics, Dialogs,
  {$ELSE}
    StrUtils,
  {$ENDIF}
  ACBrGNREConfiguracoes,  pgnreConversao, pgnreGNRE, ACBrDFeUtil;

 {$IFNDEF ACBrGNREOpenSSL}
   var
    CertStore     : IStore3;
    CertStoreMem  : IStore3;
    PrivateKey    : IPrivateKey;
    Certs         : ICertificates2;
    Cert          : ICertificate2;
    NumCertCarregado : String;

   const
    DSIGNS = 'xmlns:ds="http://www.w3.org/2000/09/xmldsig#"';
 {$ENDIF}

type

 GNREUtil = class
  private
  protected

  public
    {$IFDEF ACBrGNREOpenSSL}
      class function sign_file(const Axml: PAnsiChar; const key_file: PChar; const senha: PChar): AnsiString;
      class function sign_memory(const Axml: PChar; const key_file: Pchar; const senha: PChar; Size: Cardinal; Ponteiro: Pointer): AnsiString;
      class Procedure InitXmlSec;
      class Procedure ShutDownXmlSec;
    {$ENDIF}

    class function GetURL(const AAmbiente: Integer; ALayOut: TLayOut): WideString;
    class function RetirarPrefixos(AXML: String): String;
    class function PathWithDelim( const APath : String ) : String;
  end;

implementation

uses
 {$IFDEF ACBrGNREOpenSSL}
   libxml2, libxmlsec, libxslt,
 {$ELSE}
   ComObj,
 {$ENDIF}
 IniFiles, Sysutils, Variants, ACBrUtil;

{ GNREUtil }

{$IFDEF ACBrGNREOpenSSL}
class function GNREUtil.sign_file(const Axml: PAnsiChar; const key_file: PChar; const senha: PChar): AnsiString;
var
  doc: xmlDocPtr;
  node: xmlNodePtr;
  dsigCtx: xmlSecDSigCtxPtr;
  buffer: PChar;
  bufSize: integer;
label done;
begin
    doc     := nil;
    node    := nil;
    dsigCtx := nil;
    result  := '';

    if (Axml = nil) or (key_file = nil) then Exit;

    try
       // load template
       doc := xmlParseDoc(Axml);
       if ((doc = nil) or (xmlDocGetRootElement(doc) = nil)) then
         raise Exception.Create('Error: unable to parse');

       // find start node
       node := xmlSecFindNode(xmlDocGetRootElement(doc), PAnsiChar(xmlSecNodeSignature), PAnsiChar(xmlSecDSigNs));
       if (node = nil) then
         raise Exception.Create('Error: start node not found');

       // create signature context, we don't need keys manager in this example
       dsigCtx := xmlSecDSigCtxCreate(nil);
       if (dsigCtx = nil) then
         raise Exception.Create('Error :failed to create signature context');

       //  load private key
       dsigCtx^.signKey := xmlSecCryptoAppKeyLoad(key_file, xmlSecKeyDataFormatPkcs12, senha, nil, nil);
       if (dsigCtx^.signKey = nil) then
          raise Exception.Create('Error: failed to load private pem key from "' + key_file + '"');

       // set key name to the file name, this is just an example!
       if (xmlSecKeySetName(dsigCtx^.signKey, PAnsiChar(key_file)) < 0) then
         raise Exception.Create('Error: failed to set key name for key from "' + key_file + '"');

       // sign the template
       if (xmlSecDSigCtxSign(dsigCtx, node) < 0) then
         raise Exception.Create('Error: signature failed');

       // print signed document to stdout
       // xmlDocDump(stdout, doc);
       // Can't use "stdout" from Delphi, so we'll use xmlDocDumpMemory instead...
       buffer := nil;
       xmlDocDumpMemory(doc, @buffer, @bufSize);
       if (buffer <> nil) then
          // success
          result := buffer;
   finally
       // cleanup
       if (dsigCtx <> nil) then
         xmlSecDSigCtxDestroy(dsigCtx);

       if (doc <> nil) then
         xmlFreeDoc(doc);
   end;
end;

class function GNREUtil.sign_memory(const Axml: PChar; const key_file: Pchar; const senha: PChar; Size: Cardinal; Ponteiro: Pointer): AnsiString;
var
  doc: xmlDocPtr;
  node: xmlNodePtr;
  dsigCtx: xmlSecDSigCtxPtr;
  buffer: PChar;
  bufSize: integer;
label done;
begin
    doc     := nil;
    node    := nil;
    dsigCtx := nil;
    result  := '';

    if (Axml = nil) or (key_file = nil) then Exit;
    try
       // load template
       doc := xmlParseDoc(Axml);
       if ((doc = nil) or (xmlDocGetRootElement(doc) = nil)) then
         raise Exception.Create('Error: unable to parse');

       // find start node
       node := xmlSecFindNode(xmlDocGetRootElement(doc), PChar(xmlSecNodeSignature), PChar(xmlSecDSigNs));
       if (node = nil) then
         raise Exception.Create('Error: start node not found');

       // create signature context, we don't need keys manager in this example
       dsigCtx := xmlSecDSigCtxCreate(nil);
       if (dsigCtx = nil) then
         raise Exception.Create('Error :failed to create signature context');

       //  load private key, assuming that there is not password
       dsigCtx^.signKey := xmlSecCryptoAppKeyLoadMemory(Ponteiro, size, xmlSecKeyDataFormatPkcs12, senha, nil, nil);

       if (dsigCtx^.signKey = nil) then
          raise Exception.Create('Error: failed to load private pem key from "' + key_file + '"');

       // set key name to the file name, this is just an example!
       if (xmlSecKeySetName(dsigCtx^.signKey, key_file) < 0) then
         raise Exception.Create('Error: failed to set key name for key from "' + key_file + '"');

       // sign the template
       if (xmlSecDSigCtxSign(dsigCtx, node) < 0) then
         raise Exception.Create('Error: signature failed');

       // print signed document to stdout
       // xmlDocDump(stdout, doc);
       // Can't use "stdout" from Delphi, so we'll use xmlDocDumpMemory instead...
       buffer := nil;
       xmlDocDumpMemory(doc, @buffer, @bufSize);
       if (buffer <> nil) then
          // success
          result := buffer;
   finally
       // cleanup
       if (dsigCtx <> nil) then
         xmlSecDSigCtxDestroy(dsigCtx);

       if (doc <> nil) then
         xmlFreeDoc(doc);
   end;
end;

class Procedure GNREUtil.InitXmlSec;
begin
    // Init libxml and libxslt libraries
    xmlInitParser();
    __xmlLoadExtDtdDefaultValue^ := XML_DETECT_IDS or XML_COMPLETE_ATTRS;
    xmlSubstituteEntitiesDefault(1);
    __xmlIndentTreeOutput^ := 1;


    // Init xmlsec library
    if (xmlSecInit() < 0) then
       raise Exception.Create('Error: xmlsec initialization failed.');

    // Check loaded library version
    if (xmlSecCheckVersionExt(1, 2, 8, xmlSecCheckVersionABICompatible) <> 1) then
       raise Exception.Create('Error: loaded xmlsec library version is not compatible.');

    (* Load default crypto engine if we are supporting dynamic
     * loading for xmlsec-crypto libraries. Use the crypto library
     * name ("openssl", "nss", etc.) to load corresponding
     * xmlsec-crypto library.
     *)
    if (xmlSecCryptoDLLoadLibrary('openssl') < 0) then
       raise Exception.Create( 'Error: unable to load default xmlsec-crypto library. Make sure'#10 +
                          			'that you have it installed and check shared libraries path'#10 +
                          			'(LD_LIBRARY_PATH) environment variable.');

    // Init crypto library
    if (xmlSecCryptoAppInit(nil) < 0) then
       raise Exception.Create('Error: crypto initialization failed.');

    // Init xmlsec-crypto library
    if (xmlSecCryptoInit() < 0) then
       raise Exception.Create('Error: xmlsec-crypto initialization failed.');
end;

class Procedure GNREUtil.ShutDownXmlSec;
begin
    // Shutdown xmlsec-crypto library
    xmlSecCryptoShutdown();

    // Shutdown crypto library
    xmlSecCryptoAppShutdown();

    // Shutdown xmlsec library
    xmlSecShutdown();

    // Shutdown libxslt/libxml
    xsltCleanupGlobals();
    xmlCleanupParser();
end;
{$ENDIF}

class function GNREUtil.RetirarPrefixos(AXML: String): String;
begin
  AXML := StringReplace( AXML, 'ns1:', '', [rfReplaceAll] );
  AXML := StringReplace( AXML, 'ns2:', '', [rfReplaceAll] );
  AXML := StringReplace( AXML, 'ns3:', '', [rfReplaceAll] );
  AXML := StringReplace( AXML, 'ns4:', '', [rfReplaceAll] );
  AXML := StringReplace( AXML, 'tc:', '', [rfReplaceAll] );
  
  result := AXML;
end;

class function GNREUtil.PathWithDelim( const APath : String ) : String;
begin
  Result := Trim(APath);
  if Result <> '' then
     if RightStr(Result,1) <> PathDelim then   { Tem delimitador no final ? }
        Result := Result + PathDelim;
end;

class function GNREUtil.GetURL(const AAmbiente: Integer;  ALayOut: TLayOut): WideString;
begin
  case ALayOut of
    LayGNRERecepcao:          Result := DFeUtil.SeSenao(AAmbiente = 1, 'https://www.gnre.pe.gov.br/gnreWS/services/GnreLoteRecepcao?wsdl'   , 'https://www.gnre-h.pe.gov.br/gnreWS/services/GnreLoteRecepcao?wsdl');
    LayGNRERetRecepcao:       Result := DFeUtil.SeSenao(AAmbiente = 1, 'https://www.gnre.pe.gov.br/gnreWS/services/GnreResultadoLote?wsdl'  , 'https://www.gnre-h.pe.gov.br/gnreWS/services/GnreResultadoLote?wsdl');
    LayGNREConsultaConfigUF:  Result := DFeUtil.SeSenao(AAmbiente = 1, 'https://www.gnre.pe.gov.br/gnreWS/services/GnreConfigUF?wsdl'       , 'https://www.gnre-h.pe.gov.br/gnreWS/services/GnreConfigUF?wsdl');
  end;
end;

end.
