{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para intera��o com equipa- }
{ mentos de Automa��o Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2004 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
{                                                                              }
{  Voc� pode obter a �ltima vers�o desse arquivo na pagina do  Projeto ACBr    }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr      }
{                                                                              }
{ Esse arquivo usa a classe  SynaSer   Copyright (c)2001-2003, Lukas Gebauer   }
{  Project : Ararat Synapse     (Found at URL: http://www.ararat.cz/synapse/)  }
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
|* 25/05/2013: Primeira Versao
|*    Fernando - fernando-mm@hotmail.com
******************************************************************************}

{$I ACBr.inc}

unit ACBrConsultaCNPJ;

interface

uses
  SysUtils, Classes, ACBrSocket;

type
  EACBrConsultaCNPJException = class ( Exception );

  { TACBrConsultaCNPJ }

  TACBrConsultaCNPJ = class(TACBrHTTP)
  private
    FViewState: String;
    FEmpresaTipo: String;
    FAbertura: TDateTime;
    FRazaoSocial: String;
    FFantasia: String;
    FCNAE1: String;
    FCNAE2: String;
    FEndereco: String;
    FNumero: String;
    FComplemento: String;
    FCEP: String;
    FBairro: String;
    FCidade: String;
    FUF: String;
    FSituacao: String;
    FCNPJ: String;
    FDataSituacao: TDateTime;
    Function GetCaptchaURL: String;

    function VerificarErros(Str: String): String;
    function LerCampo(Texto: TStringList; NomeCampo: AnsiString): String;
  public
    procedure Captcha(Stream: TStream);
    function Consulta(const ACNPJ, ACaptcha: String;
      ARemoverEspacosDuplos: Boolean = False): Boolean;
  published
    property CNPJ: String Read FCNPJ Write FCNPJ;
    property EmpresaTipo: String Read FEmpresaTipo;
    property Abertura: TDateTime Read FAbertura;
    property RazaoSocial: String Read FRazaoSocial;
    property Fantasia: String Read FFantasia;
    property CNAE1: String Read FCNAE1;
    property CNAE2: String Read FCNAE2;
    property Endereco: String Read FEndereco;
    property Numero: String Read FNumero;
    property Complemento: String Read FComplemento;
    property CEP: String Read FCEP;
    property Bairro: String Read FBairro;
    property Cidade: String Read FCidade;
    property UF: String Read FUF;
    property Situacao: String Read FSituacao;
    property DataSituacao: TDateTime Read FDataSituacao;
  end;

implementation

uses
  ACBrUtil, synacode, synautil, strutils;

function StrEntreStr(Str, StrInicial, StrFinal: String; ComecarDe: Integer = 1): String;
var
  Ini, Fim: Integer;
begin
  Ini:= PosEx(StrInicial, Str, ComecarDe) + Length(StrInicial);
  if Ini > 0 then
  begin
    Fim:= PosEx(StrFinal, Str, Ini);
    if Fim > 0 then
      Result:= Copy(Str, Ini, Fim - Ini)
    else
      Result:= '';
  end
  else
    Result:= '';
end;

Function TACBrConsultaCNPJ.GetCaptchaURL: String;
var
  URL, Html: String;
begin
  try
    Self.HTTPGet('http://www.receita.fazenda.gov.br/pessoajuridica/cnpj/cnpjreva/cnpjreva_solicitacao2.asp');
    Html := Self.RespHTTP.Text;

    URL := 'http://www.receita.fazenda.gov.br' +
           StrEntreStr(Html, 'alt='+
                        QuotedStr(ACBrStr('Imagem com os caracteres anti rob�')) + ' src='+'''', '''');

    FViewState := StrEntreStr(Html, '<input type=hidden id=viewstate name=viewstate value='+'''', '''');

    Result := StringReplace(URL, 'amp;', '', []);
  except
    on E: Exception do
    begin
      raise EACBrConsultaCNPJException.Create('Erro na hora de obter a URL do captcha.'+#13#10+E.Message);
    end;
  end;
end;

procedure TACBrConsultaCNPJ.Captcha(Stream: TStream);
begin
  try
    HTTPGet(GetCaptchaURL);
    if HttpSend.ResultCode = 200 then
    begin
      HTTPSend.Document.Position := 0;
      Stream.CopyFrom(HttpSend.Document, HttpSend.Document.Size);
      Stream.Position := 0;
    end;
  Except on E: Exception do begin
    raise EACBrConsultaCNPJException.Create('Erro na hora de fazer o download da imagem do captcha.'+#13#10+E.Message);
  end;
  end;
end;

function TACBrConsultaCNPJ.VerificarErros(Str: String): String;
  var
    Res: String;
begin
  Res:= '';
  if Res = '' then
    if Pos( ACBrStr('Erro na Consulta'), Str) > 0 then
      Res:= 'Catpcha errado.';

  if Res = '' then
    if Pos(ACBrStr('O n�mero do CNPJ n�o � v�lido. Verifique se o mesmo foi digitado c'+
    'orretamente.'), Str) > 0 then
      Res:= 'O n�mero do CNPJ n�o � v�lido. Verifique se o mesmo foi digitado'+
      ' corretamente.';

  if Res = '' then
    if Pos(ACBrStr('N�o existe no Cadastro de Pessoas Jur�dicas o n�mero de CNPJ infor'+
    'mado. Verifique se o mesmo foi digitado corretamente.'), Str) > 0 then
      Res:= 'N�o existe no Cadastro de Pessoas Jur�dicas o n�mero de CNPJ info'+
      'rmado. Verifique se o mesmo foi digitado corretamente.';

  if Res = '' then
    if Pos(ACBrStr('a. No momento n�o podemos atender a sua solicita��o. Por favor tent'+
    'e mais tarde.'), Str) > 0 then
      Res:= 'Erro no site da receita federal. Tente mais tarde.';

  Result:= ACBrStr(Res);
end;

function TACBrConsultaCNPJ.LerCampo(Texto: TStringList; NomeCampo: AnsiString): string;
var
  i : integer;
begin
  NomeCampo := ACBrStr(UpperCase(NomeCampo));
  Result := '';
  for i := 0 to Texto.Count-1 do
  begin
    if Trim(UpperCase(Texto[i])) = NomeCampo then
    begin
      Result := StringReplace(Trim(Texto[i+1]),'&nbsp;',' ',[rfReplaceAll]);
      break;
    end;
  end
end;

function TACBrConsultaCNPJ.Consulta(const ACNPJ, ACaptcha: String;
  ARemoverEspacosDuplos: Boolean): Boolean;
var
  Post: TStringStream;
  Erro, Html: String;
  Resposta : TStringList;
  I: Integer;
begin
  Post:= TStringStream.Create('');
  try
    Post.WriteString('origem=comprovante&');
    Post.WriteString('viewstate=' + EncodeURLElement(fviewstate)+'&');
    Post.WriteString('cnpj='+OnlyNumber(ACNPJ)+'&');
    Post.WriteString('captcha='+Trim(ACaptcha)+'&');
    Post.WriteString('captchaAudio=&');
    Post.WriteString('submit1=Consultar&');
    Post.WriteString('search_type=cnpj');
    Post.Position:= 0;

    HttpSend.Clear;
    HttpSend.Document.Position:= 0;
    HttpSend.Document.CopyFrom(Post, Post.Size);
    HTTPSend.MimeType := 'application/x-www-form-urlencoded';
    HTTPPost('http://www.receita.fazenda.gov.br/pessoajuridica/cnpj/cnpjreva/valida.asp');

    Erro := VerificarErros(RespHTTP.Text);

    if Erro = '' then
    begin
      Result:= True;
      Resposta := TStringList.Create;
      try
        Resposta.Text := StripHTML(RespHTTP.Text);

        I := 0;
        while i < Resposta.Count-1 do
        begin
          if trim(Resposta[I]) = '' then
          begin
            Resposta.Delete(I);
            Inc(I,-1);
          end;
          Inc(I);
        end;

        //Resposta.Text := AnsiToUtf8(Resposta.Text);
        //DEBUG: Resposta.SaveToFile('/tmp/bobo.txt');

        FCNPJ         := LerCampo(Resposta,'N�MERO DE INSCRI��O');
        FEmpresaTipo  := LerCampo(Resposta,FCNPJ);
        FAbertura     := StrToDateDef(LerCampo(Resposta,'DATA DE ABERTURA'),0);
        FRazaoSocial  := LerCampo(Resposta,'NOME EMPRESARIAL');
        FFantasia     := LerCampo(Resposta,'T�TULO DO ESTABELECIMENTO (NOME DE FANTASIA)');
        FCNAE1        := LerCampo(Resposta,'C�DIGO E DESCRI��O DA ATIVIDADE ECON�MICA PRINCIPAL');
        FCNAE2        := LerCampo(Resposta,'C�DIGO E DESCRI��O DAS ATIVIDADES ECON�MICAS SECUND�RIAS');
        FEndereco     := LerCampo(Resposta,'LOGRADOURO');
        FNumero       := LerCampo(Resposta,'N�MERO');
        FComplemento  := LerCampo(Resposta,'COMPLEMENTO');
        FCEP          := OnlyNumber( LerCampo(Resposta,'CEP') ) ;
        FCEP          := copy(FCEP,1,5)+'-'+copy(FCEP,6,3) ;
        FBairro        := LerCampo(Resposta,'BAIRRO/DISTRITO');
        FCidade       := LerCampo(Resposta,'MUNIC�PIO');
        FUF           := LerCampo(Resposta,'UF');
        FSituacao     := LerCampo(Resposta,'SITUA��O CADASTRAL');
        FDataSituacao := StrToDateDef(LerCampo(Resposta,'DATA DA SITUA��O CADASTRAL'),0);
      finally
        Resposta.Free;
      end ;

      if Trim(FRazaoSocial) = '' then
        raise EACBrConsultaCNPJException.Create('N�o foi poss�vel obter os dados.');

      if ARemoverEspacosDuplos then
      begin
        FRazaoSocial := RemoverEspacosDuplos(FRazaoSocial);
        FFantasia    := RemoverEspacosDuplos(FFantasia);
        FEndereco    := RemoverEspacosDuplos(FEndereco);
        FNumero      := RemoverEspacosDuplos(FNumero);
        FComplemento := RemoverEspacosDuplos(FComplemento);
        FBairro      := RemoverEspacosDuplos(FBairro);
        FCidade      := RemoverEspacosDuplos(FCidade);
      end;
    end
    else
    begin
      Result:= False;
      raise EACBrConsultaCNPJException.Create(Erro);
    end;
  finally
    Post.Free;
  end;
end;

end.
