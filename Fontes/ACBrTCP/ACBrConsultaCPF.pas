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
|* 07/08/2013: Primeira Versao - Adaptador conforme ACBRConsultaCNPJ
|*    Daniel - schrsistemas@gmail.com
******************************************************************************}

{$I ACBr.inc}

unit ACBrConsultaCPF;

interface

uses
  SysUtils, Classes, ACBrSocket;

type
  EACBrConsultaCPFException = class ( Exception );

  { TACBrConsultaCPF }

  TACBrConsultaCPF = class(TACBrHTTP)
  private
    FViewState: String;
    FNome: String;
    FSituacao: String;
    FCPF: String;
    FDigitoVerificador: String;
    FEmissao: String;
    FCodCtrlControle: String;
    Function GetCaptchaURL: String;

    function VerificarErros(Str: String): String;
    function LerCampo(Texto: TStringList; NomeCampo: AnsiString): String;
  public
    procedure Captcha(Stream: TStream);
    function Consulta(const ACPF, ACaptcha: String;
      ARemoverEspacosDuplos: Boolean = False): Boolean;
  published
    property CPF: String Read FCPF Write FCPF;
    property Nome: String Read FNome;
    property Situacao: String Read FSituacao;
    property DigitoVerificador: String Read FDigitoVerificador;
    property Emissao: String Read FEmissao;
    property CodCtrlControle: String Read FCodCtrlControle;
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

function TACBrConsultaCPF.GetCaptchaURL : String ;
var
  URL, Html: String;
begin
  try
    Self.HTTPGet('http://www.receita.fazenda.gov.br/aplicacoes/atcta/cpf/consultapublica.asp');
    Html := Self.RespHTTP.Text;

    URL := 'http://www.receita.fazenda.gov.br' +
           StrEntreStr(Html, 'alt='+
                        QuotedStr(ACBrStr('Imagem com os caracteres anti rob�')) + ' src='+'''', '''');

    FViewState := StrEntreStr(Html, '<input type=hidden id=viewstate name=viewstate value='+'''', '''');

    Result := StringReplace(URL, 'amp;', '', []);
  except
    on E: Exception do
    begin
      raise EACBrConsultaCPFException.Create('Erro na hora de obter a URL do captcha.'+#13#10+E.Message);
    end;
  end;
end;

procedure TACBrConsultaCPF.Captcha(Stream: TStream);
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
    raise EACBrConsultaCPFException.Create('Erro na hora de fazer o download da imagem do captcha.'+#13#10+E.Message);
  end;
  end;
end;

function TACBrConsultaCPF.VerificarErros(Str: String): String;
  var
    Res: String;
begin
  Res:= '';
  if Res = '' then
    if Pos( ACBrStr('Erro na Consulta'), Str) > 0 then
      Res:= 'Catpcha errado.';

  if Res = '' then
    if Pos(ACBrStr('O n�mero do CPF n�o � v�lido. Verifique se o mesmo foi digitado c'+
    'orretamente.'), Str) > 0 then
      Res:= 'O n�mero do CPF n�o � v�lido. Verifique se o mesmo foi digitado'+
      ' corretamente.';

  if Res = '' then
    if Pos(ACBrStr('N�o existe no Cadastro de Pessoas Jur�dicas o n�mero de CPF infor'+
    'mado. Verifique se o mesmo foi digitado corretamente.'), Str) > 0 then
      Res:= 'N�o existe no Cadastro de Pessoas Jur�dicas o n�mero de CPF info'+
      'rmado. Verifique se o mesmo foi digitado corretamente.';

  if Res = '' then
    if Pos(ACBrStr('a. No momento n�o podemos atender a sua solicita��o. Por favor tent'+
    'e mais tarde.'), Str) > 0 then
      Res:= 'Erro no site da receita federal. Tente mais tarde.';

  Result:= ACBrStr(Res);
end;

function TACBrConsultaCPF.LerCampo(Texto : TStringList ; NomeCampo : AnsiString
  ) : String ;
var
  i : integer;
  linha : String;
begin
  NomeCampo := ACBrStr(UpperCase(NomeCampo));
  Result := '';
  for i := 0 to Texto.Count-1 do
  begin
    linha := ACBrStr(UpperCase(Texto[i]));
    if Pos(NomeCampo, linha) > 0 then
    begin
      Result := Trim(StringReplace(linha, NomeCampo, ' ',[rfReplaceAll]));
      break;
    end;
  end
end;

function TACBrConsultaCPF.Consulta(const ACPF, ACaptcha: String;
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
    Post.WriteString('txtCPF='+OnlyNumber(ACPF)+'&');
    Post.WriteString('captcha='+Trim(ACaptcha)+'&');
    Post.WriteString('captchaAudio=&');
    Post.WriteString('Enviar=Consultar&');
    Post.WriteString('search_type=CPF');
    Post.Position:= 0;

    HttpSend.Clear;
    HttpSend.Document.Position:= 0;
    HttpSend.Document.CopyFrom(Post, Post.Size);
    HTTPSend.MimeType := 'application/x-www-form-urlencoded';
    HTTPPost('http://www.receita.fazenda.gov.br/aplicacoes/atcta/cpf/ConsultaPublicaExibir.asp');

    Erro := VerificarErros(RespHTTP.Text);

    if Erro = '' then
    begin
      Result:= True;
      Resposta := TStringList.Create;
      try
        Resposta.Text := StripHTML(RespHTTP.Text);
        RemoveEmptyLines( Resposta );

        //Resposta.Text := AnsiToUtf8(Resposta.Text);
        //DEBUG: Resposta.SaveToFile('C:\cpf.txt');

        FCPF      := LerCampo(Resposta,'No do CPF:');
        FNome     := LerCampo(Resposta,'Nome da Pessoa F�sica:');
        FSituacao := LerCampo(Resposta,'Situa��o Cadastral:');
        FEmissao  := LerCampo(Resposta,'Comprovante emitido �s:');
        FCodCtrlControle   := LerCampo(Resposta,'C�digo de controle do comprovante:');
        FDigitoVerificador := LerCampo(Resposta,'Digito Verificador:');

      finally
        Resposta.Free;
      end ;

      if Trim(FNome) = '' then
        raise EACBrConsultaCPFException.Create('N�o foi poss�vel obter os dados.');

      if ARemoverEspacosDuplos then
      begin
        FNome := RemoverEspacosDuplos(FNome);
      end;
    end
    else
    begin
      Result:= False;
      raise EACBrConsultaCPFException.Create(Erro);
    end;
  finally
    Post.Free;
  end;
end;

end.
