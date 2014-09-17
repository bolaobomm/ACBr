{$I ACBr.inc}

unit ACBrNFSeDANFSeRLClass;

interface

uses
 Forms, SysUtils, Classes, pnfsNFSe, ACBrNFSeDANFSeClass;

type
  TACBrNFSeDANFSeRL = class( TACBrNFSeDANFSeClass )
   private
   // Augusto Fontana
   protected
     FPrintDialog: Boolean;
   public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ImprimirDANFSe(NFSe : TNFSe = nil); override ;
    procedure ImprimirDANFSePDF(NFSe : TNFSe = nil); override ;
   // Augusto Fontana
   published
     property PrintDialog: Boolean read FPrintDialog write FPrintDialog;
  end;

implementation

uses
 StrUtils, Dialogs, ACBrUtil, ACBrNFSe, ACBrNFSeUtil, ACBrNFSeDANFSeRLRetrato;

constructor TACBrNFSeDANFSeRL.Create(AOwner: TComponent);
begin
  inherited create( AOwner );
  // Augusto Fontana
  FPrintDialog := True;
end;

destructor TACBrNFSeDANFSeRL.Destroy;
begin
  inherited Destroy ;
end;


procedure TACBrNFSeDANFSeRL.ImprimirDANFSe(NFSe : TNFSe = nil);
var
 i : Integer;
 frlDANFSeRLRetrato : TfrlDANFSeRLRetrato;
begin
 frlDANFSeRLRetrato := TfrlDANFSeRLRetrato.Create(Self);

 if NFSe = nil
  then begin
   for i:= 0 to TACBrNFSe(ACBrNFSe).NotasFiscais.Count-1 do
    begin
     frlDANFSeRLRetrato.Imprimir(  TACBrNFSe(ACBrNFSe).NotasFiscais.Items[i].NFSe
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
                                 , RazaoSocial
                                 , Endereco
                                 , Complemento
                                 , Fone
                                 , Municipio
                                 , InscMunicipal
                                 , EMail_Prestador
                                 , UF
                                 , OutrasInformacaoesImp
                                 , T_InscEstadual
                                 , T_InscMunicipal
                                 // Augusto Fontana
                                 , PrintDialog);
    end;
  end
  else frlDANFSeRLRetrato.Imprimir(  NFSe
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
                                   , RazaoSocial
                                   , Endereco
                                   , Complemento
                                   , Fone
                                   , Municipio
                                   , InscMunicipal
                                   , EMail_Prestador
                                   , UF
                                   , OutrasInformacaoesImp
                                   , T_InscEstadual
                                   , T_InscMunicipal
                                   // Augusto Fontana
                                   , PrintDialog);

 frlDANFSeRLRetrato.Free;
end;

procedure TACBrNFSeDANFSeRL.ImprimirDANFSePDF(NFSe : TNFSe = nil);
var
 NomeArq : String;
 i : Integer;
 frlDANFSeRLRetrato : TfrlDANFSeRLRetrato;
begin
 frlDANFSeRLRetrato := TfrlDANFSeRLRetrato.Create(Self);

 if NFSe = nil
  then begin
   for i:= 0 to TACBrNFSe(ACBrNFSe).NotasFiscais.Count-1 do
    begin
//     NomeArq :=  trim(TACBrNFSe(ACBrNFSe).NotasFiscais.Items[i].NomeArq);
//     if NomeArq=''
//      then begin
       NomeArq := StringReplace(TACBrNFSe(ACBrNFSe).NotasFiscais.Items[i].NFSe.Numero,'NFSe', '', [rfIgnoreCase]);
       NomeArq := PathWithDelim(Self.PathPDF)+NomeArq+'.pdf';
//      end
//      else NomeArq := StringReplace(NomeArq,'-nfse.xml', '.pdf', [rfIgnoreCase]);

     frlDANFSeRLRetrato.SavePDF( NomeArq
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
                               , Prefeitura);
    end;
  end
  else begin
   NomeArq := StringReplace(NFSe.Numero,'NFSe', '', [rfIgnoreCase]);
   NomeArq := PathWithDelim(Self.PathPDF)+NomeArq+'.pdf';

   frlDANFSeRLRetrato.SavePDF( NomeArq
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
                             , Prefeitura);
  end;

 frlDANFSeRLRetrato.Free;
end;

end.
