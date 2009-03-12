{******************************************************************************}
{ Projeto: Componente ACBrNFe                                                  }
{  Biblioteca multiplataforma de componentes Delphi para emiss�o de Nota Fiscal}
{ eletr�nica - NFe - http://www.nfe.fazenda.gov.br                          }
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
******************************************************************************}

{************************************************************}
{                                                            }
{                      XML Data Binding                      }
{                                                            }
{         Generated on: 02/10/2008 16:02:34                  }
{       Generated from: PL_005a\inutNFe_v1.07.xsd            }
{                                                            }
{************************************************************}

unit ACBrNFe_inutNFe;

interface

uses xmldom, XMLDoc, XMLIntf;

type

{ Forward Decls }

  IXMLTInutNFe = interface;
  IXMLInfInut = interface;
  IXMLSignatureType = interface;
  IXMLSignedInfoType = interface;
  IXMLCanonicalizationMethod = interface;
  IXMLSignatureMethod = interface;
  IXMLReferenceType = interface;
  IXMLTransformsType = interface;
  IXMLTransformType = interface;
  IXMLDigestMethod = interface;
  IXMLSignatureValueType = interface;
  IXMLKeyInfoType = interface;
  IXMLX509DataType = interface;

{ IXMLTInutNFe }

  IXMLTInutNFe = interface(IXMLNode)
    ['{EB0A5090-13D9-470B-AB9B-E45394F41485}']
    { Property Accessors }
    function Get_Versao: WideString;
    function Get_InfInut: IXMLInfInut;
    function Get_Signature: IXMLSignatureType;
    procedure Set_Versao(Value: WideString);
    { Methods & Properties }
    property Versao: WideString read Get_Versao write Set_Versao;
    property InfInut: IXMLInfInut read Get_InfInut;
    property Signature: IXMLSignatureType read Get_Signature;
  end;

{ IXMLInfInut }

  IXMLInfInut = interface(IXMLNode)
    ['{2977602C-EB10-42E7-9543-F7DC53F1352F}']
    { Property Accessors }
    function Get_Id: WideString;
    function Get_TpAmb: WideString;
    function Get_XServ: WideString;
    function Get_CUF: WideString;
    function Get_Ano: WideString;
    function Get_CNPJ: WideString;
    function Get_Mod_: WideString;
    function Get_Serie: WideString;
    function Get_NNFIni: WideString;
    function Get_NNFFin: WideString;
    function Get_XJust: WideString;
    procedure Set_Id(Value: WideString);
    procedure Set_TpAmb(Value: WideString);
    procedure Set_XServ(Value: WideString);
    procedure Set_CUF(Value: WideString);
    procedure Set_Ano(Value: WideString);
    procedure Set_CNPJ(Value: WideString);
    procedure Set_Mod_(Value: WideString);
    procedure Set_Serie(Value: WideString);
    procedure Set_NNFIni(Value: WideString);
    procedure Set_NNFFin(Value: WideString);
    procedure Set_XJust(Value: WideString);
    { Methods & Properties }
    property Id: WideString read Get_Id write Set_Id;
    property TpAmb: WideString read Get_TpAmb write Set_TpAmb;
    property XServ: WideString read Get_XServ write Set_XServ;
    property CUF: WideString read Get_CUF write Set_CUF;
    property Ano: WideString read Get_Ano write Set_Ano;
    property CNPJ: WideString read Get_CNPJ write Set_CNPJ;
    property Mod_: WideString read Get_Mod_ write Set_Mod_;
    property Serie: WideString read Get_Serie write Set_Serie;
    property NNFIni: WideString read Get_NNFIni write Set_NNFIni;
    property NNFFin: WideString read Get_NNFFin write Set_NNFFin;
    property XJust: WideString read Get_XJust write Set_XJust;
  end;

{ IXMLSignatureType }

  IXMLSignatureType = interface(IXMLNode)
    ['{44F713F5-9EEB-4038-A8BB-839B586F953C}']
    { Property Accessors }
    function Get_Id: WideString;
    function Get_SignedInfo: IXMLSignedInfoType;
    function Get_SignatureValue: IXMLSignatureValueType;
    function Get_KeyInfo: IXMLKeyInfoType;
    procedure Set_Id(Value: WideString);
    { Methods & Properties }
    property Id: WideString read Get_Id write Set_Id;
    property SignedInfo: IXMLSignedInfoType read Get_SignedInfo;
    property SignatureValue: IXMLSignatureValueType read Get_SignatureValue;
    property KeyInfo: IXMLKeyInfoType read Get_KeyInfo;
  end;

{ IXMLSignedInfoType }

  IXMLSignedInfoType = interface(IXMLNode)
    ['{E5A0DA1A-79B6-4117-BDEC-C6672A76D748}']
    { Property Accessors }
    function Get_Id: WideString;
    function Get_CanonicalizationMethod: IXMLCanonicalizationMethod;
    function Get_SignatureMethod: IXMLSignatureMethod;
    function Get_Reference: IXMLReferenceType;
    procedure Set_Id(Value: WideString);
    { Methods & Properties }
    property Id: WideString read Get_Id write Set_Id;
    property CanonicalizationMethod: IXMLCanonicalizationMethod read Get_CanonicalizationMethod;
    property SignatureMethod: IXMLSignatureMethod read Get_SignatureMethod;
    property Reference: IXMLReferenceType read Get_Reference;
  end;

{ IXMLCanonicalizationMethod }

  IXMLCanonicalizationMethod = interface(IXMLNode)
    ['{27485FAC-80F4-49FE-A27B-B62F8D91EDB4}']
    { Property Accessors }
    function Get_Algorithm: WideString;
    procedure Set_Algorithm(Value: WideString);
    { Methods & Properties }
    property Algorithm: WideString read Get_Algorithm write Set_Algorithm;
  end;

{ IXMLSignatureMethod }

  IXMLSignatureMethod = interface(IXMLNode)
    ['{D40BE5E2-717C-438A-84A0-5512F617C71F}']
    { Property Accessors }
    function Get_Algorithm: WideString;
    procedure Set_Algorithm(Value: WideString);
    { Methods & Properties }
    property Algorithm: WideString read Get_Algorithm write Set_Algorithm;
  end;

{ IXMLReferenceType }

  IXMLReferenceType = interface(IXMLNode)
    ['{32E858C5-8CBA-49E4-A9E0-D391E595319E}']
    { Property Accessors }
    function Get_Id: WideString;
    function Get_URI: WideString;
    function Get_Type_: WideString;
    function Get_Transforms: IXMLTransformsType;
    function Get_DigestMethod: IXMLDigestMethod;
    function Get_DigestValue: WideString;
    procedure Set_Id(Value: WideString);
    procedure Set_URI(Value: WideString);
    procedure Set_Type_(Value: WideString);
    procedure Set_DigestValue(Value: WideString);
    { Methods & Properties }
    property Id: WideString read Get_Id write Set_Id;
    property URI: WideString read Get_URI write Set_URI;
    property Type_: WideString read Get_Type_ write Set_Type_;
    property Transforms: IXMLTransformsType read Get_Transforms;
    property DigestMethod: IXMLDigestMethod read Get_DigestMethod;
    property DigestValue: WideString read Get_DigestValue write Set_DigestValue;
  end;

{ IXMLTransformsType }

  IXMLTransformsType = interface(IXMLNodeCollection)
    ['{E42077A6-3EFD-4359-8BEF-23BB41AA8D8F}']
    { Property Accessors }
    function Get_Transform(Index: Integer): IXMLTransformType;
    { Methods & Properties }
    function Add: IXMLTransformType;
    function Insert(const Index: Integer): IXMLTransformType;
    property Transform[Index: Integer]: IXMLTransformType read Get_Transform; default;
  end;

{ IXMLTransformType }

  IXMLTransformType = interface(IXMLNodeCollection)
    ['{4B978FE6-7DD6-44CF-99E0-92A611FC8C4B}']
    { Property Accessors }
    function Get_Algorithm: WideString;
    function Get_XPath(Index: Integer): WideString;
    procedure Set_Algorithm(Value: WideString);
    { Methods & Properties }
    function Add(const XPath: WideString): IXMLNode;
    function Insert(const Index: Integer; const XPath: WideString): IXMLNode;
    property Algorithm: WideString read Get_Algorithm write Set_Algorithm;
    property XPath[Index: Integer]: WideString read Get_XPath; default;
  end;

{ IXMLDigestMethod }

  IXMLDigestMethod = interface(IXMLNode)
    ['{6F7DB5D8-92F0-4BDB-81A8-AA338ED11367}']
    { Property Accessors }
    function Get_Algorithm: WideString;
    procedure Set_Algorithm(Value: WideString);
    { Methods & Properties }
    property Algorithm: WideString read Get_Algorithm write Set_Algorithm;
  end;

{ IXMLSignatureValueType }

  IXMLSignatureValueType = interface(IXMLNode)
    ['{53BD6D36-F294-4157-8606-5F3349FCFDE9}']
    { Property Accessors }
    function Get_Id: WideString;
    procedure Set_Id(Value: WideString);
    { Methods & Properties }
    property Id: WideString read Get_Id write Set_Id;
  end;

{ IXMLKeyInfoType }

  IXMLKeyInfoType = interface(IXMLNode)
    ['{C52494F3-DC4B-4893-A7CA-50CBBE0DB836}']
    { Property Accessors }
    function Get_Id: WideString;
    function Get_X509Data: IXMLX509DataType;
    procedure Set_Id(Value: WideString);
    { Methods & Properties }
    property Id: WideString read Get_Id write Set_Id;
    property X509Data: IXMLX509DataType read Get_X509Data;
  end;

{ IXMLX509DataType }

  IXMLX509DataType = interface(IXMLNode)
    ['{71B4C1B0-61A7-4CAF-A045-4D56B0D1B519}']
    { Property Accessors }
    function Get_X509Certificate: WideString;
    procedure Set_X509Certificate(Value: WideString);
    { Methods & Properties }
    property X509Certificate: WideString read Get_X509Certificate write Set_X509Certificate;
  end;

{ Forward Decls }

  TXMLTInutNFe = class;
  TXMLInfInut = class;
  TXMLSignatureType = class;
  TXMLSignedInfoType = class;
  TXMLCanonicalizationMethod = class;
  TXMLSignatureMethod = class;
  TXMLReferenceType = class;
  TXMLTransformsType = class;
  TXMLTransformType = class;
  TXMLDigestMethod = class;
  TXMLSignatureValueType = class;
  TXMLKeyInfoType = class;
  TXMLX509DataType = class;

{ TXMLTInutNFe }

  TXMLTInutNFe = class(TXMLNode, IXMLTInutNFe)
  protected
    { IXMLTInutNFe }
    function Get_Versao: WideString;
    function Get_InfInut: IXMLInfInut;
    function Get_Signature: IXMLSignatureType;
    procedure Set_Versao(Value: WideString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLInfInut }

  TXMLInfInut = class(TXMLNode, IXMLInfInut)
  protected
    { IXMLInfInut }
    function Get_Id: WideString;
    function Get_TpAmb: WideString;
    function Get_XServ: WideString;
    function Get_CUF: WideString;
    function Get_Ano: WideString;
    function Get_CNPJ: WideString;
    function Get_Mod_: WideString;
    function Get_Serie: WideString;
    function Get_NNFIni: WideString;
    function Get_NNFFin: WideString;
    function Get_XJust: WideString;
    procedure Set_Id(Value: WideString);
    procedure Set_TpAmb(Value: WideString);
    procedure Set_XServ(Value: WideString);
    procedure Set_CUF(Value: WideString);
    procedure Set_Ano(Value: WideString);
    procedure Set_CNPJ(Value: WideString);
    procedure Set_Mod_(Value: WideString);
    procedure Set_Serie(Value: WideString);
    procedure Set_NNFIni(Value: WideString);
    procedure Set_NNFFin(Value: WideString);
    procedure Set_XJust(Value: WideString);
  end;

{ TXMLSignatureType }

  TXMLSignatureType = class(TXMLNode, IXMLSignatureType)
  protected
    { IXMLSignatureType }
    function Get_Id: WideString;
    function Get_SignedInfo: IXMLSignedInfoType;
    function Get_SignatureValue: IXMLSignatureValueType;
    function Get_KeyInfo: IXMLKeyInfoType;
    procedure Set_Id(Value: WideString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLSignedInfoType }

  TXMLSignedInfoType = class(TXMLNode, IXMLSignedInfoType)
  protected
    { IXMLSignedInfoType }
    function Get_Id: WideString;
    function Get_CanonicalizationMethod: IXMLCanonicalizationMethod;
    function Get_SignatureMethod: IXMLSignatureMethod;
    function Get_Reference: IXMLReferenceType;
    procedure Set_Id(Value: WideString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLCanonicalizationMethod }

  TXMLCanonicalizationMethod = class(TXMLNode, IXMLCanonicalizationMethod)
  protected
    { IXMLCanonicalizationMethod }
    function Get_Algorithm: WideString;
    procedure Set_Algorithm(Value: WideString);
  end;

{ TXMLSignatureMethod }

  TXMLSignatureMethod = class(TXMLNode, IXMLSignatureMethod)
  protected
    { IXMLSignatureMethod }
    function Get_Algorithm: WideString;
    procedure Set_Algorithm(Value: WideString);
  end;

{ TXMLReferenceType }

  TXMLReferenceType = class(TXMLNode, IXMLReferenceType)
  protected
    { IXMLReferenceType }
    function Get_Id: WideString;
    function Get_URI: WideString;
    function Get_Type_: WideString;
    function Get_Transforms: IXMLTransformsType;
    function Get_DigestMethod: IXMLDigestMethod;
    function Get_DigestValue: WideString;
    procedure Set_Id(Value: WideString);
    procedure Set_URI(Value: WideString);
    procedure Set_Type_(Value: WideString);
    procedure Set_DigestValue(Value: WideString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLTransformsType }

  TXMLTransformsType = class(TXMLNodeCollection, IXMLTransformsType)
  protected
    { IXMLTransformsType }
    function Get_Transform(Index: Integer): IXMLTransformType;
    function Add: IXMLTransformType;
    function Insert(const Index: Integer): IXMLTransformType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLTransformType }

  TXMLTransformType = class(TXMLNodeCollection, IXMLTransformType)
  protected
    { IXMLTransformType }
    function Get_Algorithm: WideString;
    function Get_XPath(Index: Integer): WideString;
    procedure Set_Algorithm(Value: WideString);
    function Add(const XPath: WideString): IXMLNode;
    function Insert(const Index: Integer; const XPath: WideString): IXMLNode;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLDigestMethod }

  TXMLDigestMethod = class(TXMLNode, IXMLDigestMethod)
  protected
    { IXMLDigestMethod }
    function Get_Algorithm: WideString;
    procedure Set_Algorithm(Value: WideString);
  end;

{ TXMLSignatureValueType }

  TXMLSignatureValueType = class(TXMLNode, IXMLSignatureValueType)
  protected
    { IXMLSignatureValueType }
    function Get_Id: WideString;
    procedure Set_Id(Value: WideString);
  end;

{ TXMLKeyInfoType }

  TXMLKeyInfoType = class(TXMLNode, IXMLKeyInfoType)
  protected
    { IXMLKeyInfoType }
    function Get_Id: WideString;
    function Get_X509Data: IXMLX509DataType;
    procedure Set_Id(Value: WideString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLX509DataType }

  TXMLX509DataType = class(TXMLNode, IXMLX509DataType)
  protected
    { IXMLX509DataType }
    function Get_X509Certificate: WideString;
    procedure Set_X509Certificate(Value: WideString);
  end;

{ Global Functions }

function GetinutNFe(Doc: IXMLDocument): IXMLTInutNFe;
function LoadinutNFe(const FileName: WideString): IXMLTInutNFe;
function NewinutNFe: IXMLTInutNFe;

const
  TargetNamespace = 'http://www.portalfiscal.inf.br/nfe';

implementation

{ Global Functions }

function GetinutNFe(Doc: IXMLDocument): IXMLTInutNFe;
begin
  Result := Doc.GetDocBinding('inutNFe', TXMLTInutNFe, TargetNamespace) as IXMLTInutNFe;
end;

function LoadinutNFe(const FileName: WideString): IXMLTInutNFe;
begin
  Result := LoadXMLDocument(FileName).GetDocBinding('inutNFe', TXMLTInutNFe, TargetNamespace) as IXMLTInutNFe;
end;

function NewinutNFe: IXMLTInutNFe;
begin
  Result := NewXMLDocument.GetDocBinding('inutNFe', TXMLTInutNFe, TargetNamespace) as IXMLTInutNFe;
end;

{ TXMLTInutNFe }

procedure TXMLTInutNFe.AfterConstruction;
begin
  RegisterChildNode('infInut', TXMLInfInut);
  RegisterChildNode('Signature', TXMLSignatureType);
  inherited;
end;

function TXMLTInutNFe.Get_Versao: WideString;
begin
  Result := AttributeNodes['versao'].Text;
end;

procedure TXMLTInutNFe.Set_Versao(Value: WideString);
begin
  SetAttribute('versao', Value);
end;

function TXMLTInutNFe.Get_InfInut: IXMLInfInut;
begin
  Result := ChildNodes['infInut'] as IXMLInfInut;
end;

function TXMLTInutNFe.Get_Signature: IXMLSignatureType;
begin
  Result := ChildNodes['Signature'] as IXMLSignatureType;
end;

{ TXMLInfInut }

function TXMLInfInut.Get_Id: WideString;
begin
  Result := AttributeNodes['Id'].Text;
end;

procedure TXMLInfInut.Set_Id(Value: WideString);
begin
  SetAttribute('Id', Value);
end;

function TXMLInfInut.Get_TpAmb: WideString;
begin
  Result := ChildNodes['tpAmb'].Text;
end;

procedure TXMLInfInut.Set_TpAmb(Value: WideString);
begin
  ChildNodes['tpAmb'].NodeValue := Value;
end;

function TXMLInfInut.Get_XServ: WideString;
begin
  Result := ChildNodes['xServ'].Text;
end;

procedure TXMLInfInut.Set_XServ(Value: WideString);
begin
  ChildNodes['xServ'].NodeValue := Value;
end;

function TXMLInfInut.Get_CUF: WideString;
begin
  Result := ChildNodes['cUF'].Text;
end;

procedure TXMLInfInut.Set_CUF(Value: WideString);
begin
  ChildNodes['cUF'].NodeValue := Value;
end;

function TXMLInfInut.Get_Ano: WideString;
begin
  Result := ChildNodes['ano'].Text;
end;

procedure TXMLInfInut.Set_Ano(Value: WideString);
begin
  ChildNodes['ano'].NodeValue := Value;
end;

function TXMLInfInut.Get_CNPJ: WideString;
begin
  Result := ChildNodes['CNPJ'].Text;
end;

procedure TXMLInfInut.Set_CNPJ(Value: WideString);
begin
  ChildNodes['CNPJ'].NodeValue := Value;
end;

function TXMLInfInut.Get_Mod_: WideString;
begin
  Result := ChildNodes['mod'].Text;
end;

procedure TXMLInfInut.Set_Mod_(Value: WideString);
begin
  ChildNodes['mod'].NodeValue := Value;
end;

function TXMLInfInut.Get_Serie: WideString;
begin
  Result := ChildNodes['serie'].Text;
end;

procedure TXMLInfInut.Set_Serie(Value: WideString);
begin
  ChildNodes['serie'].NodeValue := Value;
end;

function TXMLInfInut.Get_NNFIni: WideString;
begin
  Result := ChildNodes['nNFIni'].Text;
end;

procedure TXMLInfInut.Set_NNFIni(Value: WideString);
begin
  ChildNodes['nNFIni'].NodeValue := Value;
end;

function TXMLInfInut.Get_NNFFin: WideString;
begin
  Result := ChildNodes['nNFFin'].Text;
end;

procedure TXMLInfInut.Set_NNFFin(Value: WideString);
begin
  ChildNodes['nNFFin'].NodeValue := Value;
end;

function TXMLInfInut.Get_XJust: WideString;
begin
  Result := ChildNodes['xJust'].Text;
end;

procedure TXMLInfInut.Set_XJust(Value: WideString);
begin
  ChildNodes['xJust'].NodeValue := Value;
end;

{ TXMLSignatureType }

procedure TXMLSignatureType.AfterConstruction;
begin
  RegisterChildNode('SignedInfo', TXMLSignedInfoType);
  RegisterChildNode('SignatureValue', TXMLSignatureValueType);
  RegisterChildNode('KeyInfo', TXMLKeyInfoType);
  inherited;
end;

function TXMLSignatureType.Get_Id: WideString;
begin
  Result := AttributeNodes['Id'].Text;
end;

procedure TXMLSignatureType.Set_Id(Value: WideString);
begin
  SetAttribute('Id', Value);
end;

function TXMLSignatureType.Get_SignedInfo: IXMLSignedInfoType;
begin
  Result := ChildNodes['SignedInfo'] as IXMLSignedInfoType;
end;

function TXMLSignatureType.Get_SignatureValue: IXMLSignatureValueType;
begin
  Result := ChildNodes['SignatureValue'] as IXMLSignatureValueType;
end;

function TXMLSignatureType.Get_KeyInfo: IXMLKeyInfoType;
begin
  Result := ChildNodes['KeyInfo'] as IXMLKeyInfoType;
end;

{ TXMLSignedInfoType }

procedure TXMLSignedInfoType.AfterConstruction;
begin
  RegisterChildNode('CanonicalizationMethod', TXMLCanonicalizationMethod);
  RegisterChildNode('SignatureMethod', TXMLSignatureMethod);
  RegisterChildNode('Reference', TXMLReferenceType);
  inherited;
end;

function TXMLSignedInfoType.Get_Id: WideString;
begin
  Result := AttributeNodes['Id'].Text;
end;

procedure TXMLSignedInfoType.Set_Id(Value: WideString);
begin
  SetAttribute('Id', Value);
end;

function TXMLSignedInfoType.Get_CanonicalizationMethod: IXMLCanonicalizationMethod;
begin
  Result := ChildNodes['CanonicalizationMethod'] as IXMLCanonicalizationMethod;
end;

function TXMLSignedInfoType.Get_SignatureMethod: IXMLSignatureMethod;
begin
  Result := ChildNodes['SignatureMethod'] as IXMLSignatureMethod;
end;

function TXMLSignedInfoType.Get_Reference: IXMLReferenceType;
begin
  Result := ChildNodes['Reference'] as IXMLReferenceType;
end;

{ TXMLCanonicalizationMethod }

function TXMLCanonicalizationMethod.Get_Algorithm: WideString;
begin
  Result := AttributeNodes['Algorithm'].Text;
end;

procedure TXMLCanonicalizationMethod.Set_Algorithm(Value: WideString);
begin
  SetAttribute('Algorithm', Value);
end;

{ TXMLSignatureMethod }

function TXMLSignatureMethod.Get_Algorithm: WideString;
begin
  Result := AttributeNodes['Algorithm'].Text;
end;

procedure TXMLSignatureMethod.Set_Algorithm(Value: WideString);
begin
  SetAttribute('Algorithm', Value);
end;

{ TXMLReferenceType }

procedure TXMLReferenceType.AfterConstruction;
begin
  RegisterChildNode('Transforms', TXMLTransformsType);
  RegisterChildNode('DigestMethod', TXMLDigestMethod);
  inherited;
end;

function TXMLReferenceType.Get_Id: WideString;
begin
  Result := AttributeNodes['Id'].Text;
end;

procedure TXMLReferenceType.Set_Id(Value: WideString);
begin
  SetAttribute('Id', Value);
end;

function TXMLReferenceType.Get_URI: WideString;
begin
  Result := AttributeNodes['URI'].Text;
end;

procedure TXMLReferenceType.Set_URI(Value: WideString);
begin
  SetAttribute('URI', Value);
end;

function TXMLReferenceType.Get_Type_: WideString;
begin
  Result := AttributeNodes['Type'].Text;
end;

procedure TXMLReferenceType.Set_Type_(Value: WideString);
begin
  SetAttribute('Type', Value);
end;

function TXMLReferenceType.Get_Transforms: IXMLTransformsType;
begin
  Result := ChildNodes['Transforms'] as IXMLTransformsType;
end;

function TXMLReferenceType.Get_DigestMethod: IXMLDigestMethod;
begin
  Result := ChildNodes['DigestMethod'] as IXMLDigestMethod;
end;

function TXMLReferenceType.Get_DigestValue: WideString;
begin
  Result := ChildNodes['DigestValue'].Text;
end;

procedure TXMLReferenceType.Set_DigestValue(Value: WideString);
begin
  ChildNodes['DigestValue'].NodeValue := Value;
end;

{ TXMLTransformsType }

procedure TXMLTransformsType.AfterConstruction;
begin
  RegisterChildNode('Transform', TXMLTransformType);
  ItemTag := 'Transform';
  ItemInterface := IXMLTransformType;
  inherited;
end;

function TXMLTransformsType.Get_Transform(Index: Integer): IXMLTransformType;
begin
  Result := List[Index] as IXMLTransformType;
end;

function TXMLTransformsType.Add: IXMLTransformType;
begin
  Result := AddItem(-1) as IXMLTransformType;
end;

function TXMLTransformsType.Insert(const Index: Integer): IXMLTransformType;
begin
  Result := AddItem(Index) as IXMLTransformType;
end;

{ TXMLTransformType }

procedure TXMLTransformType.AfterConstruction;
begin
  ItemTag := 'XPath';
  ItemInterface := IXMLNode;
  inherited;
end;

function TXMLTransformType.Get_Algorithm: WideString;
begin
  Result := AttributeNodes['Algorithm'].Text;
end;

procedure TXMLTransformType.Set_Algorithm(Value: WideString);
begin
  SetAttribute('Algorithm', Value);
end;

function TXMLTransformType.Get_XPath(Index: Integer): WideString;
begin
  Result := List[Index].Text;
end;

function TXMLTransformType.Add(const XPath: WideString): IXMLNode;
begin
  Result := AddItem(-1);
  Result.NodeValue := XPath;
end;

function TXMLTransformType.Insert(const Index: Integer; const XPath: WideString): IXMLNode;
begin
  Result := AddItem(Index);
  Result.NodeValue := XPath;
end;

{ TXMLDigestMethod }

function TXMLDigestMethod.Get_Algorithm: WideString;
begin
  Result := AttributeNodes['Algorithm'].Text;
end;

procedure TXMLDigestMethod.Set_Algorithm(Value: WideString);
begin
  SetAttribute('Algorithm', Value);
end;

{ TXMLSignatureValueType }

function TXMLSignatureValueType.Get_Id: WideString;
begin
  Result := AttributeNodes['Id'].Text;
end;

procedure TXMLSignatureValueType.Set_Id(Value: WideString);
begin
  SetAttribute('Id', Value);
end;

{ TXMLKeyInfoType }

procedure TXMLKeyInfoType.AfterConstruction;
begin
  RegisterChildNode('X509Data', TXMLX509DataType);
  inherited;
end;

function TXMLKeyInfoType.Get_Id: WideString;
begin
  Result := AttributeNodes['Id'].Text;
end;

procedure TXMLKeyInfoType.Set_Id(Value: WideString);
begin
  SetAttribute('Id', Value);
end;

function TXMLKeyInfoType.Get_X509Data: IXMLX509DataType;
begin
  Result := ChildNodes['X509Data'] as IXMLX509DataType;
end;

{ TXMLX509DataType }

function TXMLX509DataType.Get_X509Certificate: WideString;
begin
  Result := ChildNodes['X509Certificate'].Text;
end;

procedure TXMLX509DataType.Set_X509Certificate(Value: WideString);
begin
  ChildNodes['X509Certificate'].NodeValue := Value;
end;

end. 