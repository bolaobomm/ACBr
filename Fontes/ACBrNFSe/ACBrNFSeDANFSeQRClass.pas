{$I ACBr.inc}

unit ACBrNFSeDANFSeQRClass;

interface

uses
 Forms, SysUtils, Classes, pnfsNFSe, ACBrNFSeDANFSeClass, Printers;

type
  TACBrNFSeDANFSeQR = class( TACBrNFSeDANFSeClass )
   private
   public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ImprimirDANFSe(NFSe : TNFSe = nil); override ;
    procedure ImprimirDANFSePDF(NFSe : TNFSe = nil); override ;
    procedure ImprimirDANFSeCampinas(NFSe : TNFSe = nil); override;
  end;

implementation

uses
 StrUtils, Dialogs, ACBrUtil, ACBrNFSe, ACBrNFSeUtil, pcnAuxiliar,
 ACBrNFSeDANFSeQRRetrato, ACBrNFSeDANFSeQRRetratoCampinas;

constructor TACBrNFSeDANFSeQR.Create(AOwner: TComponent);
begin
  inherited create( AOwner );
end;

destructor TACBrNFSeDANFSeQR.Destroy;
begin
  inherited Destroy ;
end;


procedure TACBrNFSeDANFSeQR.ImprimirDANFSe(NFSe : TNFSe = nil);
var
 i : Integer;
 fqrDANFSeQRRetrato : TfqrDANFSeQRRetrato;
begin
 fqrDANFSeQRRetrato := TfqrDANFSeQRRetrato.Create(Self);

 if NFSe = nil
  then begin
   for i:= 0 to TACBrNFSe(ACBrNFSe).NotasFiscais.Count-1 do
    begin
     fqrDANFSeQRRetrato.Imprimir(  TACBrNFSe(ACBrNFSe).NotasFiscais.Items[i].NFSe
                                 , Logo
                                 , Email
                                 , Fax
                                 , NumCopias
                                 , Sistema
                                 , Site
                                 , Usuario
                                 , MostrarPreview
                                 , MargemSuperior
                                 , MargemInferior
                                 , MargemEsquerda
                                 , MargemDireita
                                 , Impressora
                                 , PrestLogo
                                 , Prefeitura
                                 , NFSeCancelada
                                 , ImprimeCanhoto);
    end;
  end
  else fqrDANFSeQRRetrato.Imprimir(  NFSe
                                   , Logo
                                   , Email
                                   , Fax
                                   , NumCopias
                                   , Sistema
                                   , Site
                                   , Usuario
                                   , MostrarPreview
                                   , MargemSuperior
                                   , MargemInferior
                                   , MargemEsquerda
                                   , MargemDireita
                                   , Impressora
                                   , PrestLogo
                                   , Prefeitura
                                   , NFSeCancelada
                                   , ImprimeCanhoto);

 fqrDANFSeQRRetrato.Free;
end;

// Fernando Oliveira - 05/08/2013 - ALTERAÇÃO ESPECÍFICA PARA O ASIX
procedure TACBrNFSeDANFSeQR.ImprimirDANFSeCampinas(NFSe: TNFSe);
var
 i : Integer;
 fqrDANFSeQRRetratoCampinas : TfqrDANFSeQRRetratoCampinas;
 FACBrNFSe       : TACBrNFSe;
 FNFSe           : TNFSe;
 FLogo           : String;
 FEmail          : String;
 FFax            : String;
 FNumCopias      : Integer;
 FSistema        : String;
 FSite           : String;
 FUsuario        : String;
 AfterPreview    : Boolean;
 ChangedPos      : Boolean;
 FSemValorFiscal : Boolean;
 FMargemSuperior : double;
 FMargemInferior : double;
 FMargemEsquerda : double;
 FMargemDireita  : double;
 FImpressora     : String;
 FPrestLogo      : String;
 FPrefeitura     : String;
 FNFSeCancelada  : Boolean;
 Printer         : TPrinter;

 // Removido "class" por Francis Silva
 procedure ImprimirCampinas(ANFSe           : TNFSe;
                                      ALogo           : String  = '';
                                      AEmail          : String  = '';
                                      AFax            : String  = '';
                                      ANumCopias      : Integer = 1;
                                      ASistema        : String  = '';
                                      ASite           : String  = '';
                                      AUsuario        : String  = '' ;
                                      APreview        : Boolean = True;
                                      AMargemSuperior : Double  = 0.8;
                                      AMargemInferior : Double  = 0.8;
                                      AMargemEsquerda : Double  = 0.6;
                                      AMargemDireita  : Double  = 0.51;
                                      AImpressora     : String  = '';
                                      APrestLogo      : String  = '';
                                      APrefeitura     : String  = '';
                                      ANFSeCancelada  : Boolean = False);
  begin
 // Incluido "TACBrNFSeDANFSeQR." por Francis Silva
  with TACBrNFSeDANFSeQR.Create ( nil ) do
  try
   FNFSe           := ANFSe;
   FLogo           := ALogo;
   FEmail          := AEmail;
   FFax            := AFax;
   FNumCopias      := ANumCopias;
   FSistema        := ASistema;
   FSite           := ASite;
   FUsuario        := AUsuario;
   FMargemSuperior := AMargemSuperior;
   FMargemInferior := AMargemInferior;
   FMargemEsquerda := AMargemEsquerda;
   FMargemDireita  := AMargemDireita;
   FImpressora     := AImpressora;
   FPrestLogo      := APrestLogo;
   FPrefeitura     := APrefeitura;
   FNFSeCancelada  := ANFSeCancelada;

   Printer := TPrinter.Create;

   if FImpressora > ''
    then fqrDANFSeQRRetratoCampinas.QRNFSeCamp.PrinterSettings.PrinterIndex := Printer.Printers.IndexOf(FImpressora);

   if APreview
    then begin
     //fqrDANFSeQRRetratoCampinas.QRNFSeCamp.Copies := FNumCopias;

     fqrDANFSeQRRetratoCampinas.FNFSe           := FNFSe;
     fqrDANFSeQRRetratoCampinas.FLogo           := FLogo;
     fqrDANFSeQRRetratoCampinas.FEmail          := FEmail;
     fqrDANFSeQRRetratoCampinas.FFax            := FFax;
     fqrDANFSeQRRetratoCampinas.FNumCopias      := FNumCopias;
     fqrDANFSeQRRetratoCampinas.FSistema        := FSistema;
     fqrDANFSeQRRetratoCampinas.FUsuario        := FUsuario;
     fqrDANFSeQRRetratoCampinas.FMargemSuperior := FMargemSuperior;
     fqrDANFSeQRRetratoCampinas.FMargemInferior := FMargemInferior;
     fqrDANFSeQRRetratoCampinas.FMargemEsquerda := FMargemEsquerda;
     fqrDANFSeQRRetratoCampinas.FMargemDireita  := FMargemDireita;
     fqrDANFSeQRRetratoCampinas.FImpressora     := FImpressora;
     fqrDANFSeQRRetratoCampinas.FPrestLogo      := FPrestLogo;
     fqrDANFSeQRRetratoCampinas.FPrefeitura     := FPrefeitura;
     fqrDANFSeQRRetratoCampinas.FNFSeCancelada  := FNFSeCancelada;

     fqrDANFSeQRRetratoCampinas.QRNFSeCamp.Prepare;
     fqrDANFSeQRRetratoCampinas.QRNFSeCamp.Preview;

     // Incluido por Italo em 11/04/2013
     // Segundo o Rodrigo Chiva resolveu o problema de travamento
     // após o fechamento do Preview
     Application.ProcessMessages;
    end
    else begin
     AfterPreview := True;
     fqrDANFSeQRRetratoCampinas.QRNFSeCamp.PrinterSettings.Copies := FNumCopias;
     fqrDANFSeQRRetratoCampinas.QRNFSeCamp.Prepare;
     fqrDANFSeQRRetratoCampinas.QRNFSeCamp.Print;
    end;

  finally
   Free;
  end;
 end;

begin
 fqrDANFSeQRRetratoCampinas := TfqrDANFSeQRRetratoCampinas.Create(Self);

 if NFSe = nil
  then begin
   for i:= 0 to TACBrNFSe(ACBrNFSe).NotasFiscais.Count-1 do
    begin
     ImprimirCampinas(  TACBrNFSe(ACBrNFSe).NotasFiscais.Items[i].NFSe
                                         , Logo
                                         , Email
                                         , Fax
                                         , NumCopias
                                         , Sistema
                                         , Site
                                         , Usuario
                                         , MostrarPreview
                                         , MargemSuperior
                                         , MargemInferior
                                         , MargemEsquerda
                                         , MargemDireita
                                         , Impressora
                                         , PrestLogo
                                         , Prefeitura
                                         , NFSeCancelada);
    end;
  end
  else ImprimirCampinas(  NFSe
                                           , Logo
                                           , Email
                                           , Fax
                                           , NumCopias
                                           , Sistema
                                           , Site
                                           , Usuario
                                           , MostrarPreview
                                           , MargemSuperior
                                           , MargemInferior
                                           , MargemEsquerda
                                           , MargemDireita
                                           , Impressora
                                           , PrestLogo
                                           , Prefeitura
                                           , NFSeCancelada);

 fqrDANFSeQRRetratoCampinas.Free;
end;

procedure TACBrNFSeDANFSeQR.ImprimirDANFSePDF(NFSe : TNFSe = nil);
var
 NomeArqPDF : String;
 i : Integer;
 fqrDANFSeQRRetrato : TfqrDANFSeQRRetrato;
begin
 fqrDANFSeQRRetrato := TfqrDANFSeQRRetrato.Create(Self);

 if NFSe = nil
  then begin
   for i:= 0 to TACBrNFSe(ACBrNFSe).NotasFiscais.Count-1 do
    begin
      // Alterado por Italo em 20/06/2014

      if TACBrNFSe(ACBrNFSe).Configuracoes.Arquivos.NomeLongoNFSe then
        NomeArqPDF := NotaUtil.GerarNomeNFSe(UFparaCodigo(TACBrNFSe(ACBrNFSe).NotasFiscais.Items[i].NFSe.PrestadorServico.Endereco.UF),
                                             TACBrNFSe(ACBrNFSe).NotasFiscais.Items[i].Nfse.DataEmissao,
                                             TACBrNFSe(ACBrNFSe).NotasFiscais.Items[i].Nfse.PrestadorServico.IdentificacaoPrestador.Cnpj,
                                             StrToIntDef(TACBrNFSe(ACBrNFSe).NotasFiscais.Items[i].Nfse.Numero, 0))
      else
        NomeArqPDF := TACBrNFSe(ACBrNFSe).NotasFiscais.Items[i].NFSe.Numero;

      NomeArqPDF := StringReplace(NomeArqPDF, 'NFSe', '', [rfIgnoreCase]);
//      NomeArqPDF := StringReplace(TACBrNFSe(ACBrNFSe).NotasFiscais.Items[i].NFSe.Numero, 'NFSe', '', [rfIgnoreCase]);
      NomeArqPDF := PathWithDelim(Self.PathPDF) + NomeArqPDF + '.pdf';

      if NomeArqPDF = ''
      then begin
        NomeArqPDF := trim(TACBrNFSe(ACBrNFSe).NotasFiscais.Items[i].NomeArq);
        NomeArqPDF := StringReplace(NomeArqPDF, '-nfse.xml', '.pdf', [rfIgnoreCase]);
      end;

      fqrDANFSeQRRetrato.SavePDF( NomeArqPDF
                               , TACBrNFSe(ACBrNFSe).NotasFiscais.Items[i].NFSe
                               , Logo
                               , Email
                               , Fax
                               , NumCopias
                               , Sistema
                               , Site
                               , Usuario
                               , MargemSuperior
                               , MargemInferior
                               , MargemEsquerda
                               , MargemDireita
                               , PrestLogo
                               , Prefeitura
                               , NFSeCancelada
                               , ImprimeCanhoto);
    end;
  end
  else begin
   // Alterado por Italo em 05/11/2012
   NomeArqPDF := trim(NFSe.NomeArq);
   if NomeArqPDF = ''
    then begin
     NomeArqPDF := StringReplace(NFSe.Numero, 'NFSe', '', [rfIgnoreCase]);
     NomeArqPDF := PathWithDelim(Self.PathPDF) + NomeArqPDF + '.pdf';
    end
    else NomeArqPDF := StringReplace(NomeArqPDF, '-nfse.xml', '.pdf', [rfIgnoreCase]);

   fqrDANFSeQRRetrato.SavePDF( NomeArqPDF
                             , NFSe
                             , Logo
                             , Email
                             , Fax
                             , NumCopias
                             , Sistema
                             , Site
                             , Usuario
                             , MargemSuperior
                             , MargemInferior
                             , MargemEsquerda
                             , MargemDireita
                             , PrestLogo
                             , Prefeitura
                             , NFSeCancelada
                             , ImprimeCanhoto);
  end;

 fqrDANFSeQRRetrato.Free;
end;

end.
