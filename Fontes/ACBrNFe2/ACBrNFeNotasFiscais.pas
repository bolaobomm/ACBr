{******************************************************************************}
{ Projeto: Componente ACBrNFe                                                  }
{  Biblioteca multiplataforma de componentes Delphi para emiss�o de Nota Fiscal}
{ eletr�nica - NFe - http://www.nfe.fazenda.gov.br                             }
{                                                                              }
{ Direitos Autorais Reservados (c) 2008 Wemerson Souto                         }
{                                       Daniel Simoes de Almeida               }
{                                       Andr� Ferreira de Moraes               }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
{                                                                              }
{  Voc� pode obter a �ltima vers�o desse arquivo na pagina do Projeto ACBr     }
{ Componentes localizado em http://www.sourceforge.net/projects/acbr           }
{                                                                              }
{                                                                              }
{  Esta biblioteca � software livre; voc� pode redistribu�-la e/ou modific�-la }
{ sob os termos da Licen�a P�blica Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a vers�o 2.1 da Licen�a, ou (a seu crit�rio) }
{ qualquer vers�o posterior.                                                   }
{                                                                              }
{  Esta biblioteca � distribu�da na expectativa de que seja �til, por�m, SEM   }
{ NENHUMA GARANTIA; nem mesmo a garantia impl�cita de COMERCIABILIDADE OU      }
{ ADEQUA��O A UMA FINALIDADE ESPEC�FICA. Consulte a Licen�a P�blica Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICEN�A.TXT ou LICENSE.TXT)              }
{                                                                              }
{  Voc� deve ter recebido uma c�pia da Licen�a P�blica Geral Menor do GNU junto}
{ com esta biblioteca; se n�o, escreva para a Free Software Foundation, Inc.,  }
{ no endere�o 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ Voc� tamb�m pode obter uma copia da licen�a em:                              }
{ http://www.opensource.org/licenses/lgpl-license.php                          }
{                                                                              }
{ Daniel Sim�es de Almeida  -  daniel@djsystem.com.br  -  www.djsystem.com.br  }
{              Pra�a Anita Costa, 34 - Tatu� - SP - 18270-410                  }
{                                                                              }
{******************************************************************************}

{******************************************************************************
|* Historico
|*
|* 16/12/2008: Wemerson Souto
|*  - Doa��o do componente para o Projeto ACBr
|* 25/07/2009: Gilson Carmo
|*  - Envio do e-mail utilizando Thread
|* 24/09/2012: Italo Jurisato Junior
|*  - Altera��es para funcionamento com NFC-e
******************************************************************************}
{$I ACBr.inc}

unit ACBrNFeNotasFiscais;

interface

uses
  Classes, Sysutils, Dialogs, Forms, StrUtils,
  ACBrNFeUtil, ACBrNFeConfiguracoes, ACBrDFeUtil,
  ACBrNFeDANFEClass,
  smtpsend, ssl_openssl, mimemess, mimepart, // units para enviar email
  pcnNFe, pcnNFeR, pcnNFeW, pcnConversao, pcnAuxiliar, pcnLeitor;

type

  NotaFiscal = class(TCollectionItem)
  private
    FNFe: TNFe;
    FXML: AnsiString;
    FXMLOriginal: AnsiString;
    FConfirmada : Boolean;
    FMsg : AnsiString ;
    FAlertas: AnsiString;
    FErroValidacao: AnsiString;
    FErroValidacaoCompleto: AnsiString;
    FRegrasdeNegocios: AnsiString;
    FNomeArq: String;
    function GetNFeXML: AnsiString;
  public
    constructor Create(Collection2: TCollection); override;
    destructor Destroy; override;
    procedure Imprimir;
    procedure ImprimirPDF;
    function SaveToFile(CaminhoArquivo: string = ''; SalvaTXT : Boolean = False): boolean;
    function SaveToStream(Stream: TStringStream): boolean;
    procedure EnviarEmail(const sSmtpHost,
                                sSmtpPort,
                                sSmtpUser,
                                sSmtpPasswd,
                                sFrom,
                                sTo,
                                sAssunto: String;
                                sMensagem : TStrings;
                                SSL : Boolean;
                                EnviaPDF: Boolean = true;
                                sCC: TStrings = nil;
                                Anexos:TStrings=nil;
                                PedeConfirma: Boolean = False;
                                AguardarEnvio: Boolean = False;
                                NomeRemetente: String = '';
                                TLS : Boolean = True;
                                UsarThread: Boolean = True;
                                HTML:Boolean = False);
    //Fun��es para validar Regras de Neg�cios
    function ValidarConcatChave : Boolean;

    property NFe: TNFe  read FNFe write FNFe;
    property XML: AnsiString  read GetNFeXML write FXML;
    property XMLOriginal: AnsiString  read FXMLOriginal write FXMLOriginal;
    property Confirmada: Boolean  read FConfirmada write FConfirmada;
    property Msg: AnsiString  read FMsg write FMsg;
    property Alertas: AnsiString read FAlertas write FAlertas;
    property ErroValidacao: AnsiString read FErroValidacao write FErroValidacao;
    property ErroValidacaoCompleto: AnsiString read FErroValidacaoCompleto write FErroValidacaoCompleto;
    property RegrasdeNegocios: AnsiString read FRegrasdeNegocios write FRegrasdeNegocios;       
    property NomeArq: String read FNomeArq write FNomeArq;
  end;

  { TNotasFiscais }

  TNotasFiscais = class(TOwnedCollection)
  private
    FConfiguracoes : TConfiguracoes;
    FACBrNFe : TComponent ;

    function GetItem(Index: Integer): NotaFiscal;
    procedure SetItem(Index: Integer; const Value: NotaFiscal);
  public
    constructor Create(AOwner: TPersistent; ItemClass: TCollectionItemClass);

    procedure GerarNFe;
    procedure Assinar;
    procedure Valida;
    function ValidaAssinatura(out Msg : String) : Boolean;
    function ValidaRegrasdeNegocios : Boolean;
    procedure Imprimir;
    procedure ImprimirResumido;
    procedure ImprimirPDF;
    procedure ImprimirResumidoPDF;
    function  Add: NotaFiscal;
    function Insert(Index: Integer): NotaFiscal;
    property Items[Index: Integer]: NotaFiscal read GetItem  write SetItem; default;
    property Configuracoes: TConfiguracoes read FConfiguracoes  write FConfiguracoes;

    function GetNamePath: string; override ;
    // Incluido o Parametro AGerarNFe que determina se ap�s carregar os dados da NFe
    // para o componente, ser� gerado ou n�o novamente o XML da NFe.
    function LoadFromFile(CaminhoArquivo: string; AGerarNFe: Boolean = True): boolean;
    function LoadFromStream(Stream: TStringStream; AGerarNFe: Boolean = True): boolean;
    function LoadFromString(AString: String; AGerarNFe: Boolean = True): boolean;
    function SaveToFile(PathArquivo: string = ''; SalvaTXT : Boolean = False): boolean;
    function SaveToTXT(PathArquivo: string = ''): boolean;

    property ACBrNFe : TComponent read FACBrNFe;
  end;

  TSendMailThread = class(TThread)
  private
    FException : Exception;
    //FOwner: NotaFiscal;
    procedure DoHandleException;
  public
    OcorreramErros: Boolean;
    Terminado: Boolean;
    smtp : TSMTPSend;
    sFrom : String;
    sTo : String;
    sCC : TStrings;
    slmsg_Lines : TStrings;
    constructor Create;
    destructor Destroy; override;
  protected
    procedure Execute; override;
    procedure HandleException;
  end;


implementation

uses ACBrNFe, ACBrUtil, pcnGerador;

{ NotaFiscal }

constructor NotaFiscal.Create(Collection2: TCollection);
begin
  inherited Create(Collection2);
  FNFe := TNFe.Create;

  case TACBrNFe( TNotasFiscais( Collection ).ACBrNFe ).Configuracoes.Geral.ModeloDF of
   moNFe:  FNFe.Ide.modelo := 55;
   moNFCe: FNFe.Ide.modelo := 65;
  end;

  case TACBrNFe( TNotasFiscais( Collection ).ACBrNFe ).Configuracoes.Geral.VersaoDF of
   ve200: FNFe.infNFe.Versao := 2;
   ve300: FNFe.infNFe.Versao := 3;
   ve310: FNFe.infNFe.Versao := 3.1;
  end;

  FNFe.Ide.tpNF    := tnSaida;
  FNFe.Ide.indPag  := ipVista;
  FNFe.Ide.verProc := 'ACBrNFe2';
  FNFe.Ide.tpAmb   := TACBrNFe( TNotasFiscais( Collection ).ACBrNFe ).Configuracoes.WebServices.Ambiente  ;
  FNFe.Ide.tpEmis  := TACBrNFe( TNotasFiscais( Collection ).ACBrNFe ).Configuracoes.Geral.FormaEmissao ;

  if Assigned(TACBrNFe( TNotasFiscais( Collection ).ACBrNFe ).DANFE) then
     FNFe.Ide.tpImp := TACBrNFe( TNotasFiscais( Collection ).ACBrNFe ).DANFE.TipoDANFE ;

  FNFe.Emit.EnderEmit.xPais := 'BRASIL';
  FNFe.Emit.EnderEmit.cPais := 1058;
  FNFe.Emit.EnderEmit.nro   := 'SEM NUMERO';

  if FNFe.Ide.modelo = 55 then
   begin
     FNFe.Dest.EnderDest.xPais := 'BRASIL';
     FNFe.Dest.EnderDest.cPais := 1058;
     FNFe.Dest.EnderDest.nro   := 'SEM NUMERO';
   end;

end;

destructor NotaFiscal.Destroy;
begin
  FNFe.Free;
  inherited Destroy;
end;

procedure NotaFiscal.Imprimir;
begin
  if not Assigned( TACBrNFe( TNotasFiscais( Collection ).ACBrNFe ).DANFE ) then
     raise EACBrNFeException.Create('Componente DANFE n�o associado.')
  else
     TACBrNFe( TNotasFiscais( Collection ).ACBrNFe ).DANFE.ImprimirDANFE(NFe);
end;

procedure NotaFiscal.ImprimirPDF;
begin
  if not Assigned( TACBrNFe( TNotasFiscais( Collection ).ACBrNFe ).DANFE ) then
     raise EACBrNFeException.Create('Componente DANFE n�o associado.')
  else
     TACBrNFe( TNotasFiscais( Collection ).ACBrNFe ).DANFE.ImprimirDANFEPDF(NFe);
end;

function NotaFiscal.SaveToFile(CaminhoArquivo: string = ''; SalvaTXT : Boolean = False): boolean;
var
  LocNFeW : TNFeW;
begin
  try
     Result := True;
     LocNFeW := TNFeW.Create(NFe);
     try
        LocNFeW.schema := TsPL005c;
        LocNFeW.Opcoes.GerarTXTSimultaneamente := SalvaTXT;

        NFe.infNFe.Versao := DFeUtil.StringToFloat(GetVersaoNFe(TACBrNFe( TNotasFiscais( Collection ).ACBrNFe ).Configuracoes.Geral.ModeloDF,
                                              TACBrNFe( TNotasFiscais( Collection ).ACBrNFe ).Configuracoes.Geral.VersaoDF,
                                              LayNfeRecepcao));

//        if (TACBrNFe( TNotasFiscais( Collection ).ACBrNFe ).Configuracoes.Geral.ModeloDF = moNFCe) then
//           NFe.infNFe.Versao := DFeUtil.StringToFloat(NFCeEnvi)
//        else
//           NFe.infNFe.Versao := DFeUtil.StringToFloat(NFenviNFe);

        LocNFeW.Gerador.Opcoes.FormatoAlerta := TACBrNFe( TNotasFiscais( Collection ).ACBrNFe ).Configuracoes.Geral.FormatoAlerta;
        LocNFeW.GerarXml;
        if DFeUtil.EstaVazio(CaminhoArquivo) then
           CaminhoArquivo := PathWithDelim(TACBrNFe( TNotasFiscais( Collection ).ACBrNFe ).Configuracoes.Geral.PathSalvar)+copy(NFe.infNFe.ID, (length(NFe.infNFe.ID)-44)+1, 44)+'-NFe.xml';

        if DFeUtil.EstaVazio(CaminhoArquivo) or not DirectoryExists(ExtractFilePath(CaminhoArquivo)) then
           raise EACBrNFeException.Create('Caminho Inv�lido: ' + CaminhoArquivo);

        LocNFeW.Gerador.SalvarArquivo(CaminhoArquivo);
        if SalvaTXT then
           LocNFeW.Gerador.SalvarArquivo(ChangeFileExt(CaminhoArquivo,'.txt'),fgTXT);
        NomeArq := CaminhoArquivo;
     finally
        LocNFeW.Free;
     end;
  except
     raise;
     Result := False;
  end;
end;

function NotaFiscal.SaveToStream(Stream: TStringStream): boolean;
var
  LocNFeW : TNFeW;
begin
  try
     Result := True;
     LocNFeW := TNFeW.Create(NFe);
     try
        LocNFeW.schema := TsPL005c;

        NFe.infNFe.Versao := DFeUtil.StringToFloat(GetVersaoNFe(TACBrNFe( TNotasFiscais( Collection ).ACBrNFe ).Configuracoes.Geral.ModeloDF,
                                              TACBrNFe( TNotasFiscais( Collection ).ACBrNFe ).Configuracoes.Geral.VersaoDF,
                                              LayNfeRecepcao));

//        if (TACBrNFe( TNotasFiscais( Collection ).ACBrNFe ).Configuracoes.Geral.ModeloDF = moNFCe) then
//           NFe.infNFe.Versao := DFeUtil.StringToFloat(NFCeEnvi)
//        else
//           NFe.infNFe.Versao := DFeUtil.StringToFloat(NFenviNFe);

        LocNFeW.Gerador.Opcoes.FormatoAlerta := TACBrNFe( TNotasFiscais( Collection ).ACBrNFe ).Configuracoes.Geral.FormatoAlerta;
        LocNFeW.GerarXml;
        Stream.WriteString(LocNFeW.Gerador.ArquivoFormatoXML);
     finally
        LocNFeW.Free;
     end;
  except
     Result := False;
  end;
end;

procedure NotaFiscal.EnviarEmail(const sSmtpHost,
                                      sSmtpPort,
                                      sSmtpUser,
                                      sSmtpPasswd,
                                      sFrom,
                                      sTo,
                                      sAssunto: String;
                                      sMensagem : TStrings;
                                      SSL : Boolean;
                                      EnviaPDF: Boolean = true;
                                      sCC: TStrings=nil;
                                      Anexos:TStrings=nil;
                                      PedeConfirma: Boolean = False;
                                      AguardarEnvio: Boolean = False;
                                      NomeRemetente: String = '';
                                      TLS : Boolean = True;
                                      UsarThread: Boolean = True;
                                      HTML:Boolean = False);
var
 NomeArq : String;
 AnexosEmail:TStrings ;
 StreamNFe : TStringStream;
begin
 AnexosEmail := TStringList.Create;
 StreamNFe  := TStringStream.Create('');
 try
    AnexosEmail.Clear;
    if Anexos <> nil then
      AnexosEmail.Text := Anexos.Text;
    if NomeArq <> '' then
     begin
       SaveToFile(NomeArq);
       AnexosEmail.Add(NomeArq);
     end
    else
     begin
       SaveToStream(StreamNFe) ;
     end;
    if (EnviaPDF) then
    begin
       if TACBrNFe( TNotasFiscais( Collection ).ACBrNFe ).DANFE <> nil then
       begin
          TACBrNFe( TNotasFiscais( Collection ).ACBrNFe ).DANFE.ImprimirDANFEPDF(NFe);
          NomeArq :=  StringReplace(NFe.infNFe.ID,'NFe', '', [rfIgnoreCase]);
          NomeArq := PathWithDelim(TACBrNFe( TNotasFiscais( Collection ).ACBrNFe ).DANFE.PathPDF)+NomeArq+'.pdf';
          AnexosEmail.Add(NomeArq);
       end;
    end;
    TACBrNFe( TNotasFiscais( Collection ).ACBrNFe ).EnviaEmail(sSmtpHost,
                sSmtpPort,
                sSmtpUser,
                sSmtpPasswd,
                sFrom,
                sTo,
                sAssunto,
                sMensagem,
                SSL,
                sCC,
                AnexosEmail,
                PedeConfirma,
                AguardarEnvio,
                NomeRemetente,
                TLS,
                StreamNFe,
                copy(NFe.infNFe.ID, (length(NFe.infNFe.ID)-44)+1, 44)+'-NFe.xml',
                UsarThread,
                HTML);
 finally
    AnexosEmail.Free ;
    StreamNFe.Free ;
 end;
end;

function NotaFiscal.GetNFeXML: AnsiString;
var
 LocNFeW : TNFeW;
begin
 LocNFeW := TNFeW.Create(Self.NFe);
 try
    LocNFeW.schema := TsPL005c;

    NFe.infNFe.Versao := DFeUtil.StringToFloat(GetVersaoNFe(TACBrNFe( TNotasFiscais( Collection ).ACBrNFe ).Configuracoes.Geral.ModeloDF,
                                              TACBrNFe( TNotasFiscais( Collection ).ACBrNFe ).Configuracoes.Geral.VersaoDF,
                                              LayNfeRecepcao));

//    if (TACBrNFe( TNotasFiscais( Collection ).ACBrNFe ).Configuracoes.Geral.ModeloDF = moNFCe) then
//       Self.NFe.infNFe.Versao := DFeUtil.StringToFloat(NFCeEnvi)
//    else
//       Self.NFe.infNFe.Versao := DFeUtil.StringToFloat(NFenviNFe);

    LocNFeW.Gerador.Opcoes.FormatoAlerta := TACBrNFe( TNotasFiscais( Collection ).ACBrNFe ).Configuracoes.Geral.FormatoAlerta;       
    LocNFeW.GerarXml;
    Result := LocNFeW.Gerador.ArquivoFormatoXML;
 finally
    LocNFeW.Free;
 end;
// Result := FXML;
end;

function NotaFiscal.ValidarConcatChave: Boolean;
var
  wAno, wMes, wDia: Word;
begin
  DecodeDate(nfe.ide.dEmi, wAno, wMes, wDia);
  if (Copy(NFe.infNFe.ID,4,2) <> IntToStrZero(nfe.ide.cUF, 2)) or
     (Copy(NFe.infNFe.ID,6,2) <> Copy(FormatFloat('0000', wAno), 3, 2)) or
     (Copy(NFe.infNFe.ID,8,2) <> FormatFloat('00', wMes)) or
     (Copy(NFe.infNFe.ID,10,14) <> copy(SomenteNumeros(nfe.Emit.CNPJCPF) + '00000000000000', 1, 14)) or
     (Copy(NFe.infNFe.ID,24,2) <> IntToStrZero(nfe.ide.modelo, 2)) or
     (Copy(NFe.infNFe.ID,26,3) <> IntToStrZero(nfe.ide.serie, 3)) or
     (Copy(NFe.infNFe.ID,29,9) <> IntToStrZero(nfe.ide.nNF, 9)) or
     (Copy(NFe.infNFe.ID,38,1) <> TpEmisToStr(nfe.ide.tpEmis)) or
     (Copy(NFe.infNFe.ID,39,8) <> IntToStrZero(nfe.ide.cNF, 8)) then
    Result := False
  else
    Result := True;
end;

{ TNotasFiscais }
constructor TNotasFiscais.Create(AOwner: TPersistent;
  ItemClass: TCollectionItemClass);
begin
  if not (AOwner is TACBrNFe ) then
     raise EACBrNFeException.Create( 'AOwner deve ser do tipo TACBrNFe') ;

  inherited;

  FACBrNFe := TACBrNFe( AOwner ) ;
end;


function TNotasFiscais.Add: NotaFiscal;
begin
  Result := NotaFiscal(inherited Add);
end;

procedure TNotasFiscais.Assinar;
var
  i: Integer;
  vAssinada : AnsiString;
  LocNFeW : TNFeW;
  Leitor: TLeitor;
  FMsg : AnsiString;
begin
  for i:= 0 to Self.Count-1 do
   begin
     LocNFeW := TNFeW.Create(Self.Items[i].NFe);
     try
        LocNFeW.schema := TsPL005c;

        Self.Items[i].NFe.infNFe.Versao := DFeUtil.StringToFloat(GetVersaoNFe(FConfiguracoes.Geral.ModeloDF,
                                              FConfiguracoes.Geral.VersaoDF,
                                              LayNfeRecepcao));

//        if (FConfiguracoes.Geral.ModeloDF = moNFCe) then
//           Self.Items[i].NFe.infNFe.Versao := DFeUtil.StringToFloat(NFCeEnvi)
//        else
//           Self.Items[i].NFe.infNFe.Versao := DFeUtil.StringToFloat(NFenviNFe);

        LocNFeW.Gerador.Opcoes.FormatoAlerta := FConfiguracoes.Geral.FormatoAlerta;
        LocNFeW.GerarXml;
        Self.Items[i].Alertas := LocNFeW.Gerador.ListaDeAlertas.Text;
{$IFDEF ACBrNFeOpenSSL}
        if not(NotaUtil.Assinar(LocNFeW.Gerador.ArquivoFormatoXML, FConfiguracoes.Certificados.Certificado , FConfiguracoes.Certificados.Senha, vAssinada, FMsg)) then
           raise EACBrNFeException.Create('Falha ao assinar Nota Fiscal Eletr�nica '+
                                   IntToStr(Self.Items[i].NFe.Ide.nNF)+FMsg);
{$ELSE}
        if not(NotaUtil.Assinar(LocNFeW.Gerador.ArquivoFormatoXML, FConfiguracoes.Certificados.GetCertificado , vAssinada, FMsg)) then
           raise EACBrNFeException.Create('Falha ao assinar Nota Fiscal Eletr�nica '+
                                   IntToStr(Self.Items[i].NFe.Ide.nNF)+FMsg);
{$ENDIF}
        vAssinada := StringReplace( vAssinada, '<'+ENCODING_UTF8_STD+'>', '', [rfReplaceAll] ) ;
        vAssinada := StringReplace( vAssinada, '<?xml version="1.0"?>', '', [rfReplaceAll] ) ;
        Self.Items[i].XML := vAssinada;

        Leitor := TLeitor.Create;
        leitor.Grupo := vAssinada;
        Self.Items[i].NFe.signature.URI := Leitor.rAtributo('Reference URI=');
        Self.Items[i].NFe.signature.DigestValue := Leitor.rCampo(tcStr, 'DigestValue');
        Self.Items[i].NFe.signature.SignatureValue := Leitor.rCampo(tcStr, 'SignatureValue');
        Self.Items[i].NFe.signature.X509Certificate := Leitor.rCampo(tcStr, 'X509Certificate');
        Leitor.Free;
        
        if FConfiguracoes.Geral.Salvar then
           FConfiguracoes.Geral.Save(StringReplace(Self.Items[i].NFe.infNFe.ID, 'NFe', '', [rfIgnoreCase])+'-nfe.xml', vAssinada);

        if DFeUtil.NaoEstaVazio(Self.Items[i].NomeArq) then
           FConfiguracoes.Geral.Save(ExtractFileName(Self.Items[i].NomeArq), vAssinada, ExtractFilePath(Self.Items[i].NomeArq));

     finally
        LocNFeW.Free;
     end;
   end;

end;

procedure TNotasFiscais.GerarNFe;
var
 i: Integer;
 LocNFeW : TNFeW;
begin
 for i:= 0 to Self.Count-1 do
  begin
    LocNFeW := TNFeW.Create(Self.Items[i].NFe);
    try
       LocNFeW.schema := TsPL006;

       Self.Items[i].NFe.infNFe.Versao := DFeUtil.StringToFloat(GetVersaoNFe(FConfiguracoes.Geral.ModeloDF,
                                              FConfiguracoes.Geral.VersaoDF,
                                              LayNfeRecepcao));

//       if (FConfiguracoes.Geral.ModeloDF = moNFCe) then
//          Self.Items[i].NFe.infNFe.Versao := DFeUtil.StringToFloat(NFCeEnvi)
//       else
//          Self.Items[i].NFe.infNFe.Versao := DFeUtil.StringToFloat(NFenviNFe);

       LocNFeW.Gerador.Opcoes.FormatoAlerta := FConfiguracoes.Geral.FormatoAlerta;
       LocNFeW.GerarXml;
       Self.Items[i].XML := LocNFeW.Gerador.ArquivoFormatoXML;
       Self.Items[i].Alertas := LocNFeW.Gerador.ListaDeAlertas.Text;
    finally
       LocNFeW.Free;
    end;
  end;
end;

function TNotasFiscais.GetItem(Index: Integer): NotaFiscal;
begin
  Result := NotaFiscal(inherited Items[Index]);
end;

function TNotasFiscais.GetNamePath: string;
begin
  Result := 'NotaFiscal';
end;

procedure TNotasFiscais.Imprimir;
begin
  if not Assigned( TACBrNFe( FACBrNFe ).DANFE ) then
     raise EACBrNFeException.Create('Componente DANFE n�o associado.')
  else
     TACBrNFe( FACBrNFe ).DANFE.ImprimirDANFE(nil);
end;

procedure TNotasFiscais.ImprimirResumido;
begin
  if not Assigned( TACBrNFe( FACBrNFe ).DANFE ) then
     raise EACBrNFeException.Create('Componente DANFE n�o associado.')
  else
     TACBrNFe( FACBrNFe ).DANFE.ImprimirDANFEResumido(nil);
end;

procedure TNotasFiscais.ImprimirPDF;
begin
  if not Assigned( TACBrNFe( FACBrNFe ).DANFE ) then
     raise EACBrNFeException.Create('Componente DANFE n�o associado.')
  else
     TACBrNFe( FACBrNFe ).DANFE.ImprimirDANFEPDF(nil);
end;

procedure TNotasFiscais.ImprimirResumidoPDF;
begin
  if not Assigned( TACBrNFe( FACBrNFe ).DANFE ) then
     raise EACBrNFeException.Create('Componente DANFE n�o associado.')
  else
     TACBrNFe( FACBrNFe ).DANFE.ImprimirDANFEResumidoPDF(nil);
end;

function TNotasFiscais.Insert(Index: Integer): NotaFiscal;
begin
  Result := NotaFiscal(inherited Insert(Index));
end;

procedure TNotasFiscais.SetItem(Index: Integer; const Value: NotaFiscal);
begin
  Items[Index].Assign(Value);
end;

procedure TNotasFiscais.Valida;
var
 i: Integer;
 FMsg : AnsiString;
begin
  for i:= 0 to Self.Count-1 do
   begin
     if pos('<Signature',Self.Items[i].XML) = 0 then
        Assinar;
     if not(NotaUtil.Valida(('<NFe xmlns' + RetornarConteudoEntre(Self.Items[i].XML, '<NFe xmlns', '</NFe>')+ '</NFe>'),
                            FMsg, Self.FConfiguracoes.Geral.PathSchemas,
                            Self.FConfiguracoes.Geral.ModeloDF,
                            Self.FConfiguracoes.Geral.VersaoDF)) then
      begin
        Self.Items[i].ErroValidacaoCompleto := 'Falha na valida��o dos dados da nota '+
                                               IntToStr(Self.Items[i].NFe.Ide.nNF)+sLineBreak+
                                               Self.Items[i].Alertas+
                                               FMsg;
        Self.Items[i].ErroValidacao := 'Falha na valida��o dos dados da nota '+
                                       IntToStr(Self.Items[i].NFe.Ide.nNF)+sLineBreak+
                                       Self.Items[i].Alertas+
                                       IfThen(Self.FConfiguracoes.Geral.ExibirErroSchema,FMsg,'');
        raise EACBrNFeException.Create(Self.Items[i].ErroValidacao);
      end;
  end;
end;

function TNotasFiscais.ValidaAssinatura(out Msg : String) : Boolean;
var
 i: Integer;
 FMsg : AnsiString;
begin
  Result := False;
  for i:= 0 to Self.Count-1 do
  begin
     if not(NotaUtil.ValidaAssinatura(Self.Items[i].XMLOriginal, FMsg)) then
      begin
        Result := False;
        Msg := 'Falha na valida��o da assinatura da nota '+
                               IntToStr(Self.Items[i].NFe.Ide.nNF)+sLineBreak+FMsg
      end
     else
       Result := True;
  end;
end;

function TNotasFiscais.ValidaRegrasdeNegocios: Boolean;
var
 i: Integer;
 Erros : AnsiString;
begin
  Result := True;
  for i:= 0 to Self.Count-1 do
  begin
    Erros := '';
    if not Self.Items[i].ValidarConcatChave then  //GA03
       Erros := '502-Rejei��o: Erro na Chave de Acesso - Campo Id n�o corresponde � concatena��o dos campos correspondentes'+sLineBreak;

    if copy(IntToStr(Self.Items[i].NFe.Emit.EnderEmit.cMun),1,2) <> IntToStr(FConfiguracoes.WebServices.UFCodigo) then //GB02
       Erros := Erros + '226-Rejei��o: C�digo da UF do Emitente diverge da UF autorizadora'+sLineBreak;

    if (Self.Items[i].NFe.Ide.serie > 889) and   //GB07
//       (Self.Items[i].NFe.Ide.serie < 900) and
       (Self.Items[i].NFe.Ide.tpEmis = teSCAN)then
       Erros := Erros + '266-Rejei��o: S�rie utilizada fora da faixa permitida no Web Service (0-889)'+sLineBreak;

    if (Self.Items[i].NFe.Ide.serie > 899) and  //GB07.1
       (Self.Items[i].NFe.Ide.tpEmis <> teSCAN)then
       Erros := Erros + '503-Rejei��o: S�rie utilizada fora da faixa permitida no SCAN (900-999)'+sLineBreak;

    if (Self.Items[i].NFe.Ide.dEmi > now) then  //GB09
       Erros := Erros + '212-Rejei��o: Data de emiss�o NF-e posterior a data de recebimento'+sLineBreak;

    if ((now - Self.Items[i].NFe.Ide.dEmi) > 30) then  //GB09.1
       Erros := Erros + '228-Rejei��o: Data de Emiss�o muito atrasada'+sLineBreak;

    //GB09.02 - Data de Emiss�o posterior � 31/03/2011
    //GB09.03 - Data de Recep��o posterior � 31/03/2011 e tpAmb (B24) = 2

    if ((Self.Items[i].NFe.Ide.dSaiEnt - now) > 30) then  //GB10  - Facultativo
       Erros := Erros + '504-Rejei��o: Data de Entrada/Sa�da posterior ao permitido'+sLineBreak;

    if ((now - Self.Items[i].NFe.Ide.dSaiEnt) > 30) then  //GB10.1  - Facultativo
       Erros := Erros + '505-Rejei��o: Data de Entrada/Sa�da anterior ao permitido'+sLineBreak;

    if (Self.Items[i].NFe.Ide.dSaiEnt < Self.Items[i].NFe.Ide.dEmi) then  //GB10.2  - Facultativo
       Erros := Erros + '506-Rejei��o: Data de Sa�da menor que a Data de Emiss�o'+sLineBreak;

    if not ValidarMunicipio(Self.Items[i].NFe.Ide.cMunFG) then //GB12
       Erros := Erros + '270-Rejei��o: C�digo Munic�pio do Fato Gerador: d�gito inv�lido'+sLineBreak;

    if (UFparaCodigo(Self.Items[i].NFe.Emit.EnderEmit.UF)<>StrToIntDef(copy(IntToStr(Self.Items[i].NFe.Ide.cMunFG),1,2),0)) then//GB12.1
       Erros := Erros + '271-Rejei��o: C�digo Munic�pio do Fato Gerador: difere da UF do emitente'+sLineBreak;


    Self.Items[i].RegrasdeNegocios := Erros;
    if Erros <> '' then
      Result := False;
  end;
end;

function TNotasFiscais.LoadFromFile(CaminhoArquivo: string; AGerarNFe: Boolean = True): boolean;
var
 LocNFeR : TNFeR;
 ArquivoXML: TStringList;
 XML, XMLOriginal : AnsiString;
begin
 try
    ArquivoXML := TStringList.Create;
    try
      ArquivoXML.LoadFromFile(CaminhoArquivo {$IFDEF DELPHI2009_UP}, TEncoding.UTF8{$ENDIF});
      XMLOriginal := ArquivoXML.Text;
      Result := True;
      while pos('</NFe>',ArquivoXML.Text) > 0 do
       begin
         if pos('</nfeProc>',ArquivoXML.Text) > 0  then
          begin
            XML := copy(ArquivoXML.Text,1,pos('</nfeProc>',ArquivoXML.Text)+5);
            ArquivoXML.Text := Trim(copy(ArquivoXML.Text,pos('</nfeProc>',ArquivoXML.Text)+10,length(ArquivoXML.Text)));
          end
         else
          begin
            XML := copy(ArquivoXML.Text,1,pos('</NFe>',ArquivoXML.Text)+5);
            ArquivoXML.Text := Trim(copy(ArquivoXML.Text,pos('</NFe>',ArquivoXML.Text)+6,length(ArquivoXML.Text)));
          end;
         LocNFeR := TNFeR.Create(Self.Add.NFe);
         try
            LocNFeR.Leitor.Arquivo := XML;
            LocNFeR.LerXml;
            Items[Self.Count-1].XML := LocNFeR.Leitor.Arquivo;
            Items[Self.Count-1].XMLOriginal := XMLOriginal;
            Items[Self.Count-1].NomeArq := CaminhoArquivo;
            if AGerarNFe then
               GerarNFe;
         finally
            LocNFeR.Free;
         end;
       end;
    finally
      ArquivoXML.Free;
    end;
 except
    raise;
    Result := False;    
 end;
end;

function TNotasFiscais.LoadFromStream(Stream: TStringStream; AGerarNFe: Boolean = True): boolean;
var
 LocNFeR : TNFeR;
begin
  try
    Result := True;
    LocNFeR := TNFeR.Create(Self.Add.NFe);
    try
       LocNFeR.Leitor.CarregarArquivo(Stream);
       LocNFeR.LerXml;
       Items[Self.Count-1].XMLOriginal := Stream.DataString;
       Items[Self.Count-1].XML := LocNFeR.Leitor.Arquivo;
       if AGerarNFe then
          GerarNFe;
    finally
       LocNFeR.Free
    end;
  except
    Result := False;
  end;
end;

function TNotasFiscais.LoadFromString(AString: String; AGerarNFe: Boolean = True): boolean;
var
  XMLNFe: TStringStream;
begin
  try
    Result := True;

    XMLNFe := TStringStream.Create(AString);
    try
      XMLNFe.WriteString(AString);
      Result := LoadFromStream(XMLNFe, AGerarNFe);
    finally
      XMLNFe.Free;
    end;
  except
    Result := False;
  end;
end;

function TNotasFiscais.SaveToFile(PathArquivo: string = ''; SalvaTXT : Boolean = False): boolean;
var
 i : integer;
 CaminhoArquivo : String;
begin
 Result := True;
 try
    for i:= 0 to TACBrNFe( FACBrNFe ).NotasFiscais.Count-1 do
     begin
        if DFeUtil.EstaVazio(PathArquivo) then
           PathArquivo := TACBrNFe( FACBrNFe ).Configuracoes.Geral.PathSalvar
        else
           PathArquivo := ExtractFilePath(PathArquivo);
        CaminhoArquivo := PathWithDelim(PathArquivo)+StringReplace(TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].NFe.infNFe.ID, 'NFe', '', [rfIgnoreCase])+'-NFe.xml';
        TACBrNFe( FACBrNFe ).NotasFiscais.Items[i].SaveToFile(CaminhoArquivo, SalvaTXT);
     end;
 except
    Result := False;
 end;
end;

function TNotasFiscais.SaveToTXT(PathArquivo: string): boolean;
var
  loSTR: TStringList;
  LocNFeW : TNFeW;
  I,J: integer;
begin
  Result:=False;
  loSTR := TStringList.Create;
  try
    loSTR.Clear;
    for I := 0 to Self.Count - 1 do
    begin
      LocNFeW := TNFeW.Create(Self.Items[I].Nfe);
      try
        LocNFeW.schema := TsPL006;
        LocNFeW.Opcoes.GerarTXTSimultaneamente:=true;

        Self.Items[i].NFe.infNFe.Versao := DFeUtil.StringToFloat(GetVersaoNFe(FConfiguracoes.Geral.ModeloDF,
                                              FConfiguracoes.Geral.VersaoDF,
                                              LayNfeRecepcao));

//        if (FConfiguracoes.Geral.ModeloDF= moNFCe) then
//           Self.Items[i].NFe.infNFe.Versao := DFeUtil.StringToFloat(NFCeEnvi)
//        else
//           Self.Items[i].NFe.infNFe.Versao := DFeUtil.StringToFloat(NFenviNFe);

        LocNFeW.Gerador.Opcoes.FormatoAlerta := FConfiguracoes.Geral.FormatoAlerta;
        LocNFeW.GerarXml;
        loSTR.Text := loSTR.Text +
                      copy(LocNFeW.Gerador.ArquivoFormatoTXT,14,length(LocNFeW.Gerador.ArquivoFormatoTXT));
      finally
        LocNFeW.Free;
      end;
    end;
    
    if loSTR.Count > 0 then
    begin
      loSTR.Strings[0]:='NOTA FISCAL|'+IntToStr(Self.Count);
      J:=loSTR.Count;
      i:=0;
      while (I <= J-1) do
      begin
        if loSTR.Strings[I] = '' then
        begin
          loSTR.Delete(I);
          J:=J-1;
        end
        else
          I:=I+1;
      end;

      if DFeUtil.EstaVazio(PathArquivo) then
        PathArquivo := PathWithDelim(TACBrNFe( FACBrNFe ).Configuracoes.Geral.PathSalvar)+'NFe.TXT';
      loSTR.SaveToFile(PathArquivo);
      Result:=True;
    end;
  finally
    loSTR.free;
  end;
end;

{ TSendMailThread }

procedure TSendMailThread.DoHandleException;
begin
  //TACBrNFe(TNotasFiscais(FOwner.GetOwner).ACBrNFe).SetStatus( stIdle );
  //FOwner.Alertas := FException.Message;

  if FException is Exception then
    Application.ShowException(FException)
  else
    SysUtils.ShowException(FException, nil);
end;

constructor TSendMailThread.Create;
begin
  smtp        := TSMTPSend.Create;
  slmsg_Lines := TStringList.Create;
  sCC         := TStringList.Create;
  sFrom       := '';
  sTo         := '';

  FreeOnTerminate := True;

  inherited Create(True);
end;

destructor TSendMailThread.Destroy;
begin
  slmsg_Lines.Free;
  sCC.Free;
  smtp.Free;

  inherited;
end;

procedure TSendMailThread.Execute;
var
   I: integer;
begin
  inherited;

  try
    Terminado := False;
    try
      if not smtp.Login() then
        raise Exception.Create('SMTP ERROR: Login:' + smtp.EnhCodeString+sLineBreak+smtp.FullResult.Text);

      if not smtp.MailFrom( sFrom, Length(sFrom)) then
        raise Exception.Create('SMTP ERROR: MailFrom:' + smtp.EnhCodeString+sLineBreak+smtp.FullResult.Text);

      if not smtp.MailTo(sTo) then
        raise Exception.Create('SMTP ERROR: MailTo:' + smtp.EnhCodeString+sLineBreak+smtp.FullResult.Text);

      if (sCC <> nil) then
      begin
        for I := 0 to sCC.Count - 1 do
        begin
          if not smtp.MailTo(sCC.Strings[i]) then
            raise Exception.Create('SMTP ERROR: MailTo:' + smtp.EnhCodeString+sLineBreak+smtp.FullResult.Text);
        end;
      end;

      if not smtp.MailData(slmsg_Lines) then
        raise Exception.Create('SMTP ERROR: MailData:' + smtp.EnhCodeString+sLineBreak+smtp.FullResult.Text);

      if not smtp.Logout() then
        raise Exception.Create('SMTP ERROR: Logout:' + smtp.EnhCodeString+sLineBreak+smtp.FullResult.Text);
    finally
      try
        smtp.Sock.CloseSocket;
      except
      end ;
      Terminado := True;
    end;
  except
    Terminado := True; 
    HandleException;
  end;
end;

procedure TSendMailThread.HandleException;
begin
  FException := Exception(ExceptObject);
  try
    // N�o mostra mensagens de EAbort
    if not (FException is EAbort) then
      Synchronize(DoHandleException);
  finally
    FException := nil;
  end;
end;

end.
