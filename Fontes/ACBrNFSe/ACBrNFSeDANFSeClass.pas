unit ACBrNFSeDANFSeClass;

interface

uses
 Forms, SysUtils, Classes,
 pnfsNFSe, pnfsConversao;

type

 TACBrNFSeDANFSeClass = class( TComponent )
  private
    procedure SetNFSe(const Value: TComponent);
    procedure ErroAbstract( NomeProcedure: String );
    function GetPathArquivos: String;
    procedure SetPathArquivos(const Value: String);
  protected
    FACBrNFSe: TComponent;
    FLogo: String;
    FSistema: String;
    FUsuario: String;
    FPathArquivos: String;
    FImpressora: String;
    FMostrarPreview: Boolean;
    FMostrarStatus: Boolean;
    FNumCopias: Integer;
    FExpandirLogoMarca: Boolean;
    FFax : String;
    FSite: String;
    FEmail: String;
    FMargemInferior: Double;
    FMargemSuperior: Double;
    FMargemEsquerda: Double;
    FMargemDireita: Double;
    FPrestLogo: String;
    FPrefeitura: String;
    FRazaoSocial: String;
    FEndereco : String;
    FComplemento : String;
    FFone : String;
    FMunicipio : String;
    FInscMunicipal : String;
    FEMail_Prestador : String;
    FUF : String;         
    FNFSeCancelada: boolean;
    FImprimeCanhoto: Boolean;

    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ImprimirDANFSe(NFSe: TNFSe = nil); virtual;
    procedure ImprimirDANFSePDF(NFSe: TNFSe = nil); virtual;
    procedure ImprimirDANFSeCampinas(NFSe : TNFSe = nil); virtual;
  published
    property ACBrNFSe: TComponent  read FACBrNFSe write SetNFSe;
    property Logo: String read FLogo write FLogo;
    property Sistema: String read FSistema write FSistema;
    property Usuario: String read FUsuario write FUsuario;
    property PathPDF: String read GetPathArquivos write FPathArquivos;
    property Impressora: String read FImpressora write FImpressora;
    property MostrarPreview: Boolean read FMostrarPreview write FMostrarPreview;
    property MostrarStatus: Boolean read FMostrarStatus write FMostrarStatus;
    property NumCopias: Integer read FNumCopias write FNumCopias;
    property ExpandirLogoMarca: Boolean read FExpandirLogoMarca write FExpandirLogoMarca default false;
    property Fax : String read FFax   write FFax;
    property Site: String read FSite  write FSite;
    property Email: String read FEmail write FEmail;
    property MargemInferior: Double read FMargemInferior write FMargemInferior;
    property MargemSuperior: Double read FMargemSuperior write FMargemSuperior;
    property MargemEsquerda: Double read FMargemEsquerda write FMargemEsquerda;
    property MargemDireita: Double read FMargemDireita write FMargemDireita;
    property PrestLogo: String read FPrestLogo write FPrestLogo;
    property Prefeitura: String read FPrefeitura write FPrefeitura;

    property RazaoSocial: String read FRazaoSocial write FRazaoSocial;
    property UF: String read FUF write FUF;
    property Endereco: String read FEndereco write FEndereco;
    property Complemento: String read FComplemento write FComplemento;
    property Fone: String read FFone write FFone;
    property Municipio: String read FMunicipio write FMunicipio;
    property InscMunicipal: String read FInscMunicipal write FInscMunicipal;
    property EMail_Prestador: String read FEMail_Prestador write FEMail_Prestador;

    property NFSeCancelada: Boolean read FNFSeCancelada write FNFSeCancelada;
    property ImprimeCanhoto: Boolean read FImprimeCanhoto write FImprimeCanhoto default False;
  end;

implementation

uses
 ACBrNFSe, ACBrNFSeUtil, ACBrUtil, ACBrDFeUtil;

{ TACBrNFSeDANFSeClass }

constructor TACBrNFSeDANFSeClass.Create(AOwner: TComponent);
begin
 inherited create( AOwner );

 FACBrNFSe       := nil;
 FLogo           := '';
 FSistema        := '';
 FUsuario        := '';
 FPathArquivos   := '';
 FImpressora     := '';
 FMostrarPreview := True;
 FMostrarStatus  := True;
 FNumCopias      := 1;
 FFax            := '';
 FSite           := '';
 FEmail          := '';
 FMargemInferior := 0.8;
 FMargemSuperior := 0.8;
 FMargemEsquerda := 0.6;
 FMargemDireita  := 0.51;
 FPrestLogo      := '';
 FPrefeitura     := '';
 FRazaoSocial    := '';
 FEndereco       := '';
 FComplemento    := '';
 FFone           := '';
 FMunicipio      := '';
 FInscMunicipal  := '';
 FEMail_Prestador := '';
 FUF              := '';               

 FNFSeCancelada  := False;
end;

destructor TACBrNFSeDANFSeClass.Destroy;
begin

 inherited Destroy;
end;

procedure TACBrNFSeDANFSeClass.ErroAbstract(NomeProcedure: String);
begin
 raise Exception.Create( NomeProcedure );
end;

function TACBrNFSeDANFSeClass.GetPathArquivos: String;
begin
 if DFeUtil.EstaVazio(FPathArquivos)
  then if Assigned(FACBrNFSe)
        then FPathArquivos := TACBrNFSe(FACBrNFSe).Configuracoes.Geral.PathSalvar;

 if DFeUtil.NaoEstaVazio(FPathArquivos)
  then if not DirectoryExists(FPathArquivos)
        then ForceDirectories(FPathArquivos);

 Result := PathWithDelim(FPathArquivos);
end;

procedure TACBrNFSeDANFSeClass.ImprimirDANFSe(NFSe: TNFSe);
begin
 ErroAbstract('Imprimir');
end;

// Fernando Oliveira - 05/08/2013 - ALTERAÇÃO ESPECÍFICA PARA O ASIX
procedure TACBrNFSeDANFSeClass.ImprimirDANFSeCampinas(NFSe: TNFSe);
begin
  ErroAbstract('ImprimirCampinas');
end;

procedure TACBrNFSeDANFSeClass.ImprimirDANFSePDF(NFSe: TNFSe);
begin
 ErroAbstract('ImprimirPDF');
end;

procedure TACBrNFSeDANFSeClass.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
 inherited Notification(AComponent, Operation);

 if (Operation = opRemove) and (FACBrNFSe <> nil) and (AComponent is TACBrNFSe)
  then FACBrNFSe := nil;
end;

procedure TACBrNFSeDANFSeClass.SetNFSe(const Value: TComponent);
var
 OldValue: TACBrNFSe;
begin
 if Value <> FACBrNFSe then
  begin
   if Value <> nil
    then if not (Value is TACBrNFSe)
          then raise Exception.Create('ACBrDANFSe.NFSe deve ser do tipo TACBrNFSe');

   if Assigned(FACBrNFSe)
    then FACBrNFSe.RemoveFreeNotification(Self);

   OldValue  := TACBrNFSe(FACBrNFSe);  // Usa outra variavel para evitar Loop Infinito
   FACBrNFSe := Value;                 // na remoção da associação dos componentes

   if Assigned(OldValue)
    then if Assigned(OldValue.DANFSe)
          then OldValue.DANFSe := nil;

   if Value <> nil
    then begin
     Value.FreeNotification(self);
     TACBrNFSe(Value).DANFSe := self;
    end;
  end;
end;

procedure TACBrNFSeDANFSeClass.SetPathArquivos(const Value: String);
begin
  FPathArquivos := Value;
end;

end.
