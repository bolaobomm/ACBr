{$I ACBr.inc}

unit ACBrGNREReg;

interface

uses
 SysUtils, Classes,
{$IFDEF VisualCLX}
 QDialogs,
{$ELSE}
 Dialogs, FileCtrl,
{$ENDIF}
{$IFDEF FPC}
  LResources, LazarusPackageIntf, PropEdits, componenteditors,
{$ELSE}
  {$IFNDEF COMPILER6_UP}
    DsgnIntf,
  {$ELSE}
    DesignIntf, DesignEditors,
  {$ENDIF}
{$ENDIF}
 ACBrGNRE,  pgnreConversao;

type

 { Editor de Proriedades de Componente para mostrar o AboutACBr }
 TACBrAboutDialogProperty = class(TPropertyEditor)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
  end;

 { Editor de Proriedades de Componente para chamar OpenDialog }
 TACBrGNREDirProperty = class( TStringProperty )
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end;

procedure Register;

implementation

uses
 ACBrGNREConfiguracoes;

{$IFNDEF FPC}
   {$R ACBrGNRE.dcr}
{$ENDIF}

procedure Register;
begin
 RegisterComponents('ACBr', [TACBrGNRE]);

 RegisterPropertyEditor(TypeInfo(TACBrGNREAboutInfo), nil, 'AboutACBrGNRE',
     TACBrAboutDialogProperty);

 RegisterPropertyEditor(TypeInfo(TCertificadosConf), TConfiguracoes, 'Certificados',
    TClassProperty);

 RegisterPropertyEditor(TypeInfo(TConfiguracoes), TACBrGNRE, 'Configuracoes',
    TClassProperty);

 RegisterPropertyEditor(TypeInfo(TWebServicesConf), TConfiguracoes, 'WebServices',
    TClassProperty);

 RegisterPropertyEditor(TypeInfo(TGeralConf), TConfiguracoes, 'Geral',
    TClassProperty);

 RegisterPropertyEditor(TypeInfo(String), TGeralConf, 'PathSalvar',
     TACBrGNREDirProperty);

 RegisterPropertyEditor(TypeInfo(TArquivosConf), TConfiguracoes, 'Arquivos',
    TClassProperty);

 RegisterPropertyEditor(TypeInfo(String), TArquivosConf, 'PathGNRE',
     TACBrGNREDirProperty);
end;

{ TACBrAboutDialogProperty }

procedure TACBrAboutDialogProperty.Edit;
begin
 ACBrAboutDialog;
end;

function TACBrAboutDialogProperty.GetAttributes: TPropertyAttributes;
begin
 Result := [paDialog, paReadOnly];
end;

function TACBrAboutDialogProperty.GetValue: string;
begin
 Result := 'Versão: ' + ACBrGNRE_VERSAO;
end;

{ TACBrGNREDirProperty }

procedure TACBrGNREDirProperty.Edit;
var
{$IFNDEF VisualCLX} Dir: String; {$ELSE} Dir: WideString; {$ENDIF}
begin
{$IFNDEF VisualCLX}
  Dir := GetValue;
  if SelectDirectory(Dir,[],0)
   then SetValue( Dir );
{$ELSE}
  Dir := '';
  if SelectDirectory('Selecione o Diretório','',Dir)
   then SetValue( Dir );
{$ENDIF}
end;

function TACBrGNREDirProperty.GetAttributes: TPropertyAttributes;
begin
 Result := [paDialog];
end;

initialization

{$IFDEF FPC}
//   {$i ACBrGNRE_lcl.lrs}
{$ENDIF}

end.
