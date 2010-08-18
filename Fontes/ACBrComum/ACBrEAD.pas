{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para intera��o com equipa- }
{ mentos de Automa��o Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2010                                        }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
{                                                                              }
{  Voc� pode obter a �ltima vers�o desse arquivo na pagina do  Projeto ACBr    }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr      }
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
|* 05/07/2010: Elton M. Barbosa
|*  - Baseado em m�todos j� existentes no ACBrRFD.
|*  - Esbo�o da Primeira Versao para avalia��o.
*******************************************************************************}

unit ACBrEAD;

interface

uses
   SysUtils,
   ACBrTXTClass, ACBrUtil;

const
   CACBrEAD_Versao = '0.02' ;

   { Usa utilit�rio de linha de comando, "openssl.exe", para calcular a
       assinatura digital...       http://www.openssl.org/
       Bin�rios para windows:      http://www.openssl.org/related/binaries.html
     NOTA: openssl.exe e suas DLLs (libssl32.dll, ssleay32.dll) precisam
           estar no PATH da m�quina ou no mesmo diret�rio do programa
     Como usar o openssl.exe   ->   http://www.madboa.com/geek/openssl/

     - Para gerar a sua chave Privada usando o "openssl.exe" digite:
          openssl genrsa -out mykey.pem 1024
       ( o arquivo "mykey.pem" conter� a sua chave )

     - Para gerar Publica baseado em uma chave Privada, digite:
          openssl rsa -in mykey.pem -pubout -out pubkey.pem
       ( assume que a sua chave privada est� em "mykey.pem", gera chave p�blica
         no arquivo "pubkey.pem" )                                             }

   { Chave padr�o... por motivos de seguran�a, GERE A SUA PROPRIA CHAVE e
     informe-a em: "OnGetKeyRSA" }
   cRFDRSAKey = '-----BEGIN RSA PRIVATE KEY-----' + sLineBreak +
                'MIICXQIBAAKBgQCtpPqcoOX4rwgdoKi6zJwPX9PA2iX2KxgvyxjE+daI5ZmYxcg0'+ sLineBreak +
                'NScjX59nXRaLmtltVRfsRc1n4+mLSXiWMh3jIbw+TWn+GXKQhS2GitpLVhO3A6Ns'+ sLineBreak +
                'vO1+RuP77s+uGYhqVvbD0Pziq+I2r4oktsjTbpnC7Mof3BjJdIUFsTHKYwIDAQAB'+ sLineBreak +
                'AoGAXXqwU7umsi8ADnsb+pwF85zh8TM/NnvSpIAQkJHzNXVtL7ph4gEvVbK3rLyH'+ sLineBreak +
                'U5aEMICbxV16i9A9PPfLjAfk4CuPpZlTibgfBRIG3MXirum0tjcyzbPyiDrk0qwM'+ sLineBreak +
                'e83MyRkrnGlss6cRT3mZk67txEamqTVmDwz/Sfo1fVlCQAkCQQDW3N/EKyT+8tPW'+ sLineBreak +
                '1EuPXafRONMel4xB1RiBmHYJP1bo/sDebLpocL6oiVlUX/k/zPRo1wMvlXJxPyiz'+ sLineBreak +
                'mnf37cZ9AkEAzuPcDvGxwawr7EPGmPQ0f7aWv87tS/rt9L3nKiz8HfrT6WT0R1Bh'+ sLineBreak +
                'I7lLGq4VFWE29I6hQ2lPNGX9IGFjiflKXwJBALgsO+J62QtwOgU7lEkfjmnYu57N'+ sLineBreak +
                'aHxFnOv5M7RZhrXRKKF/sYk0mzj8AoZAffYiSJ5VL3XqNF6+NLU/AvaR6kECQQCV'+ sLineBreak +
                'nY6sd/kWmA4DhFgAkMnOehq2h0xwH/0pepPLmlCQ1a2eIVXOpMA692rq1m2E0pLN'+ sLineBreak +
                'dMAGYgfXWtIdMpCrXM59AkB5npcELeGBv1K8B41fmrlA6rEq4aqmfwAFRKcQTj8a'+ sLineBreak +
                'n09FVtccLVPJ42AM1/QXK6a8DGCtB9R+j5j3UO/iL0+3'+ sLineBreak +
                '-----END RSA PRIVATE KEY-----' ;

type
  TACBrCalcEAD = procedure(Arquivo: String) of object ;
  TACBrEADGetKeyRSA = procedure(var PrivateKey_RSA: AnsiString) of object ;

  /// DECLARANDO A CLASSE:
  TACBrEAD = class(TObject)
  private
    FOnError: TErrorEvent;

    FOnEADCalcEAD: TACBrCalcEAD;
    FOnEADGetKeyRSA: TACBrEADGetKeyRSA;

    function GetAbout: String;

    function GetOnError: TErrorEvent; /// M�todo do evento OnError
    procedure SetOnError(const Value: TErrorEvent); /// M�todo SetError

    procedure WriteRegistroEAD(Arquivo: String);

  public
    property About: String read GetAbout stored False;

    property OnError: TErrorEvent  read GetOnError write SetOnError;

{ Evento para retornar a chave RSA para calculo interno do EAD. Se n�o
  programado usar� a constante cRFDRSAKey (acima) }
    property OnGetKeyRSA: TACBrEADGetKeyRSA read FOnEADGetKeyRSA write FOnEADGetKeyRSA;
{ Evento para calculo Externo do EAD. Se n�o programado, usar� a rotina de
  calculo interno, que usa o "openssl.exe" (veja acima) }
    property OnCalcEAD: TACBrCalcEAD read FOnEADCalcEAD write FOnEADCalcEAD;

    function AssinaArquivoComEAD(Arquivo: String): Boolean; //NOTA: Deve ser passado o caminho completo do arquivo a ser assinado.

  end;


implementation

uses Classes, {$IFDEF CLX}QForms{$ELSE}Forms{$ENDIF};

function TACBrEAD.GetAbout: String;
begin
   Result := 'ACBrEAD Ver: ' + CACBrEAD_Versao;
end;

function TACBrEAD.GetOnError: TErrorEvent;
begin
   Result := FOnError;
end;

procedure TACBrEAD.SetOnError(const Value: TErrorEvent);
begin
  FOnError := Value;
end;

{ Gerando registro EAD }
procedure TACBrEAD.WriteRegistroEAD(Arquivo: String);
var
  EAD, cmd, ChaveRSA: AnsiString ;
  SL: TStringList;
  I: Integer;
  Dir,Linha:String;
begin
  EAD := '' ;
  SL  := TStringList.Create ;
  Dir := GetCurrentDir ;

  { Obtendo Chave RSA }
  ChaveRSA := '' ;
  if Assigned( FOnEADGetKeyRSA ) then
    FOnEADGetKeyRSA( ChaveRSA )    { Se usu�rio tem Chave pr�pria, use-a }
  else
    ChaveRSA := cRFDRSAKey;      { caso contr�rio, use a padr�o...}


  if ChaveRSA = '' then  { Se o m�todo do usu�rio n�o definiu uma Chave }
   raise Exception.Create( ACBrStr('O m�todo onGetKeyRSA n�o retornou nenhuma Chave.')) ;

  try
     { Gravando a chave RSA temporariamente no DirLog }
     SL.Clear ;
     SL.Text := ChaveRSA;
     SL.SaveToFile( 'id.rsa' );

     { Executando o "openssl.exe" }
     cmd := 'dgst -md5 -sign id.rsa -out ead.txt -hex "'+ Arquivo+'"' ;
     {$IFDEF CONSOLE}
       WriteLn('Executando: openssl '+cmd) ;
     {$ENDIF}
     RunCommand('openssl', cmd, True, 0);

     {$IFDEF CONSOLE}
       WriteLn('Aguardando ead.txt') ;
     {$ENDIF}
     I := 0 ;
     while (not FileExists('ead.txt')) and (I < 30) do
     begin
        sleep(100) ;
        {$IFNDEF CONSOLE}
          Application.ProcessMessages ;
        {$ELSE}
          Write('.') ;
        {$ENDIF}
        Inc( I ) ;
     end ;

     { Lendo a resposta }
     try
        SL.Clear ;
        SL.LoadFromFile('ead.txt');
        EAD := SL.Text ;
        EAD := UpperCase( Trim( copy(EAD, pos('=',EAD)+1, Length(EAD) ))) ;
     except
        raise Exception.Create( ACBrStr('Erro ao calcular registro EAD usando o "openssl"' )) ;
     end ;
  finally
     SL.Free ;

     SysUtils.DeleteFile( 'id.rsa' ) ;  // Removendo a chave privada do disco ;
     SysUtils.DeleteFile( 'ead.txt' ) ;

     ChDir( Dir );  { Voltando para o diret�rio anterior }
     {$IFDEF CONSOLE}
       writeln( 'Diretorio atual: ',GetCurrentDir ) ;
     {$ENDIF}
  end;
  Linha := 'EAD' + EAD ;
  WriteToTXT( Arquivo, Linha, True, False ); // modifa��o linux
end;

function TACBrEAD.AssinaArquivoComEAD(Arquivo: String): Boolean;
begin
  Result := False;
  ///
  if (Trim(Arquivo) = '') then
     raise Exception.Create('Caminho ou nome do arquivo n�o informado!');

  try
    /// Assinatura EAD
    if Assigned( FOnEADCalcEAD ) then
       FOnEADCalcEAD(Arquivo) /// Se usu�rio usa outro m�todo para assinar o arquivo
    else
       WriteRegistroEAD(Arquivo);

    Result := True;
  except
    on E: Exception do
    begin
      raise Exception.Create(E.Message);
    end;
  end;
end;

end.
