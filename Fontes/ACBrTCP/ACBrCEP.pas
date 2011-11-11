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
|* 12/08/2010: Primeira Versao
|*    Daniel Simoes de Almeida e Andr� Moraes
******************************************************************************}

unit ACBrCEP ;

{$I ACBr.inc}

interface

uses
  Classes, SysUtils, contnrs,
  ACBrSocket ;

type

  TACBrCEPWebService = ( wsNenhum, wsBuscarCep, wsCepLivre, wsRepublicaVirtual ) ;

  { TACBrCEPEndereco }

  TACBrCEPEndereco = class
    private
      fBairro : String ;
      fCEP : String ;
      fCodigoIBGE : String ;
      fComplemento : String ;
      fLogradouro : String ;
      fMunicipio : String ;
      fTipo_Logradouro : String ;
      fUF : String ;

      function GetIBGE_UF : String ;
    public
      constructor Create ;

      property CEP             : String read fCEP             write fCEP ;
      property Tipo_Logradouro : String read fTipo_Logradouro write fTipo_Logradouro ;
      property Logradouro      : String read fLogradouro      write fLogradouro ;
      property Complemento     : String read fComplemento     write fComplemento ;
      property Bairro          : String read fBairro          write fBairro ;
      property Municipio       : String read fMunicipio       write fMunicipio ;
      property UF              : String read fUF              write fUF ;
      property IBGE_Municipio  : String read fCodigoIBGE      write fCodigoIBGE ;
      property IBGE_UF         : String read GetIBGE_UF ;
  end ;

  { Lista de Objetos do tipo TACBrCEPEndereco }

  { TACBrCEPEnderecos }

  TACBrCEPEnderecos = class(TObjectList)
    protected
      procedure SetObject (Index: Integer; Item: TACBrCEPEndereco);
      function GetObject (Index: Integer): TACBrCEPEndereco;
      procedure Insert (Index: Integer; Obj: TACBrCEPEndereco);
    public
      function Add (Obj: TACBrCEPEndereco): Integer;
      function New: TACBrCEPEndereco ;
      property Objects [Index: Integer]: TACBrCEPEndereco
        read GetObject write SetObject; default;
    end;

  TACBrCEPWSClass = class ;

  { TACBrCEP }

  TACBrCEP = class( TACBrHTTP )
    private
      fWebService : TACBrCEPWebService ;
      fACBrCEPWS  : TACBrCEPWSClass ;

      fEnderecos : TACBrCEPEnderecos ;
      fOnBuscaEfetuada : TNotifyEvent ;
      fChaveAcesso: String;
      function GetURL : String ;
      procedure SetWebService(const AValue : TACBrCEPWebService) ;
    public
      constructor Create(AOwner: TComponent); override;
      Destructor Destroy ; override ;

      property Enderecos : TACBrCEPEnderecos  read fEnderecos ;

      function BuscarPorCEP( ACEP : String ) : Integer ;
      function BuscarPorLogradouro( ACidade, ATipo_Logradouro, ALogradouro, AUF,
         ABairro : String ) : Integer ;

    published
      property WebService : TACBrCEPWebService read fWebService write SetWebService default wsNenhum ;
      property URL : String read GetURL ;
      property ChaveAcesso: String read fChaveAcesso write fChaveAcesso ;

      property OnBuscaEfetuada : TNotifyEvent read fOnBuscaEfetuada
         write fOnBuscaEfetuada ;
  end ;

  { TACBrCEPWSClass }

  TACBrCEPWSClass = class
    private
      fOwner : TACBrCEP ;
      fpURL : String ;

      procedure ErrorAbstract ;
    protected
      procedure TestarChave;
      function LerTagXML(Texto, NomeCampo: string): String;
    public
      constructor Create( AOwner : TACBrCEP ) ; virtual ;

      Procedure BuscarPorCEP( ACEP : String ) ; virtual ;
      Procedure BuscarPorLogradouro( AMunicipio, ATipo_Logradouro, ALogradouro,
         AUF, ABairro : String ) ; virtual ;

      property URL : String read fpURL ;
  end ;

  { TACBrWSBuscarCEP }

  TACBrWSBuscarCEP = class(TACBrCEPWSClass)
    private
      procedure ProcessaResposta ;
    public
      constructor Create( AOwner : TACBrCEP ) ; override ;

      Procedure BuscarPorCEP( ACEP : String ) ; override ;
      Procedure BuscarPorLogradouro( AMunicipio, ATipo_Logradouro, ALogradouro,
         AUF, ABairro : String ) ; override ;
  end ;

  { TACBrWSCEPLivre }

  TACBrWSCEPLivre = class(TACBrCEPWSClass)
    private
      procedure ProcessaResposta ;
    public
      constructor Create( AOwner : TACBrCEP ) ; override ;

      Procedure BuscarPorCEP( ACEP : String ) ; override ;
      Procedure BuscarPorLogradouro( AMunicipio, ATipo_Logradouro, ALogradouro,
         AUF, ABairro : String ) ; override ;
  end ;

  { TACBrWSRepublicaVirtual }

  TACBrWSRepublicaVirtual = class(TACBrCEPWSClass)
    private
      FCepBusca: String;
      procedure ProcessaResposta ;
    public
      constructor Create( AOwner : TACBrCEP ) ; override ;

      Procedure BuscarPorCEP( ACEP : String ) ; override ;
      Procedure BuscarPorLogradouro( AMunicipio, ATipo_Logradouro, ALogradouro,
         AUF, ABairro : String ) ; override ;
  end ;

implementation

uses ACBrUtil ;

{ TACBrCEPEndereco }

constructor TACBrCEPEndereco.Create ;
begin
  inherited ;

  fCEP             := '' ;
  fTipo_Logradouro := '' ;
  fLogradouro      := '' ;
  fBairro          := '' ;
  fCodigoIBGE      := '' ;
  fMunicipio       := '' ;
  fUF              := '' ;
end ;

function TACBrCEPEndereco.GetIBGE_UF : String ;
begin
  Result := copy(IBGE_Municipio,1,2) ;
end;

{ TACBrCEPEnderecos }

procedure TACBrCEPEnderecos.SetObject(Index : Integer ; Item : TACBrCEPEndereco) ;
begin
  inherited SetItem (Index, Item) ;
end ;

function TACBrCEPEnderecos.GetObject(Index : Integer) : TACBrCEPEndereco ;
begin
  Result := inherited GetItem(Index) as TACBrCEPEndereco ;
end ;

procedure TACBrCEPEnderecos.Insert(Index : Integer ; Obj : TACBrCEPEndereco) ;
begin
  inherited Insert(Index, Obj);
end ;

function TACBrCEPEnderecos.New: TACBrCEPEndereco;
begin
  Result := TACBrCEPEndereco.Create;
  Self.Add(Result);
end;

function TACBrCEPEnderecos.Add(Obj : TACBrCEPEndereco) : Integer ;
begin
  Result := inherited Add(Obj) ;
end ;

{ TACBrCEP }

constructor TACBrCEP.Create(AOwner : TComponent) ;
begin
  inherited Create(AOwner) ;

  fOnBuscaEfetuada := nil ;

  fEnderecos  := TACBrCEPEnderecos.create( True );
  fACBrCEPWS  := TACBrCEPWSClass.Create( Self );
  fWebService := wsNenhum ;
end ;

destructor TACBrCEP.Destroy ;
begin
  fEnderecos.Free;
  fACBrCEPWS.Free;

  inherited Destroy ;
end ;

procedure TACBrCEP.SetWebService(const AValue : TACBrCEPWebService) ;
begin
  if fWebService = AValue then exit ;

  fACBrCEPWS.Free;

  case AValue of
    wsBuscarCep : fACBrCEPWS := TACBrWSBuscarCEP.Create( Self );
    wsCepLivre  : fACBrCEPWS := TACBrWSCEPLivre.Create( Self );
    wsRepublicaVirtual : fACBrCEPWS := TACBrWSRepublicaVirtual.Create(Self);
  else
     fACBrCEPWS := TACBrCEPWSClass.Create( Self ) ;
  end ;

  fWebService := AValue;
end;

function TACBrCEP.GetURL : String ;
begin
  Result := fACBrCEPWS.URL ;
end;

function TACBrCEP.BuscarPorCEP(ACEP : String) : Integer ;
begin
  fEnderecos.Clear;

  ACEP := Trim( OnlyNumber( AnsiString( ACEP ) ) ) ;
  if ACEP = '' then
     raise Exception.Create('CEP deve ser informado');

  fACBrCEPWS.BuscarPorCEP(ACEP);

  Result := fEnderecos.Count;
end ;

function TACBrCEP.BuscarPorLogradouro(ACidade, ATipo_Logradouro, ALogradouro,
  AUF, ABairro : String ) : Integer ;
begin
  fEnderecos.Clear;
  fACBrCEPWS.BuscarPorLogradouro( ACidade, ATipo_Logradouro, ALogradouro, AUF,
                                  ABairro );

  Result := fEnderecos.Count;
end ;

{ TACBrCEPWSClass }

procedure TACBrCEPWSClass.ErrorAbstract ;
begin
  raise Exception.Create( 'Nenhum WebService selecionado' )
end ;

procedure TACBrCEPWSClass.TestarChave;
begin
  if fOwner.ChaveAcesso = EmptyStr then
    raise Exception.Create('Chave de acesso n�o informada.');
end;

constructor TACBrCEPWSClass.Create( AOwner : TACBrCEP) ;
begin
  inherited Create ;

  fOwner := AOwner;
  fpURL  := '';
end ;

Procedure TACBrCEPWSClass.BuscarPorCEP(ACEP : String) ;
begin
  ErrorAbstract ;
end ;

Procedure TACBrCEPWSClass.BuscarPorLogradouro(AMunicipio, ATipo_Logradouro,
   ALogradouro, AUF, ABairro : String ) ;
begin
  ErrorAbstract ;
end ;

function TACBrCEPWSClass.LerTagXML(Texto, NomeCampo: string): string;
var
  ConteudoTag: string;
  inicio, fim: integer;
begin
  NomeCampo := '<'+UpperCase(Trim(NomeCampo))+'>';

  inicio := pos(NomeCampo, UpperCase(Texto));
  if inicio = 0 then
    ConteudoTag := ''
  else
  begin
    inicio := inicio + Length(NomeCampo);
    Texto  := copy(Texto,inicio,length(Texto));
    inicio := 0;
    fim    := pos('</',Texto)-1;

    ConteudoTag := trim(copy(Texto, inicio, fim));
  end;

  try
     result := ConteudoTag;
  except
     raise Exception.Create('Conte�do inv�lido. '+ConteudoTag);
  end;
end;

{ TACBrWSBuscarCEP - http://www.buscarcep.com.br }

constructor TACBrWSBuscarCEP.Create(AOwner : TACBrCEP) ;
begin
  inherited Create(AOwner) ;

  fpURL := 'http://www.buscarcep.com.br/' ;
end ;

Procedure TACBrWSBuscarCEP.BuscarPorCEP( ACEP : String ) ;
begin
  TestarChave;

  fOwner.HTTPGet( fpURL + '?cep='+ACEP+'&formato=string&chave='+fOwner.ChaveAcesso ) ;
  ProcessaResposta ;
end ;

Procedure  TACBrWSBuscarCEP.BuscarPorLogradouro(AMunicipio,  ATipo_Logradouro,
  ALogradouro, AUF, ABairro : String) ;
Var
   Params : String ;
begin
  TestarChave;

  AMunicipio       := fOwner.AjustaParam( AMunicipio ) ;
  ATipo_Logradouro := fOwner.AjustaParam( ATipo_Logradouro );
  ALogradouro      := fOwner.AjustaParam( ALogradouro ) ;
  AUF              := fOwner.AjustaParam( AUF );

  if (AMunicipio = '') or (ALogradouro = '') or (AUF = '') then
     raise Exception.Create('UF, Cidade e Logradouro devem ser informados');

  Params := '?logradouro=' + ALogradouro+
            '&cidade='     + AMunicipio+
            '&uf='         + AUF ;

  if ATipo_Logradouro <> '' then
    Params := Params + '&tipo_logradouro=' + ATipo_Logradouro ;

  if ABairro <> '' then
    Params := Params + '&bairro=' + ABairro ;

  Params := Params + '&formato=string' ;
  Params := Params + '&chave=' + fOwner.ChaveAcesso;

  fOwner.HTTPGet( fpURL + Params ) ;
  ProcessaResposta ;
end ;

Procedure TACBrWSBuscarCEP.ProcessaResposta ;
Var
   SL1, SL2 : TStringList ;
   Buffer : String ;
   PosIni, I : Integer ;
begin
  fOwner.fEnderecos.Clear;

  SL1 := TStringList.Create;
  SL2 := TStringList.Create;
  try
    SL1.Text := StringReplace( fOwner.RespHTTP.Text, '&cep=', sLineBreak+'&cep=',
                               [rfReplaceAll] );

    For I := 0 to SL1.Count-1 do
    begin
       Buffer := SL1[I] ;
       PosIni := pos('&cep=',Buffer) ;

       if PosIni > 0 then
       begin

         Buffer := copy( Buffer, PosIni, Length(Buffer) ) ;

         SL2.Clear;
         SL2.Text := StringReplace( Buffer, '&', sLineBreak, [rfReplaceAll] );

         if (SL2.Values['resultado'] = '1') then
         begin
            with fOwner.Enderecos.New do
            begin
              CEP             := SL2.Values['cep'] ;
              Tipo_Logradouro := SL2.Values['tipo_logradouro'] ;
              Logradouro      := SL2.Values['logradouro'] ;
              Complemento     := SL2.Values['complemento'] ;
              Bairro          := SL2.Values['bairro'] ;
              Municipio       := SL2.Values['cidade'] ;
              UF              := SL2.Values['uf'] ;
              IBGE_Municipio  := SL2.Values['ibge_municipio_verificador'] ;
            end ;
         end ;
       end ;
    end ;
  finally
    SL1.free ;
    SL2.free ;
  end ;

  if Assigned( fOwner.OnBuscaEfetuada ) then
     fOwner.OnBuscaEfetuada( Self );
end ;


{ TACBrWSCEPLivre - http://ceplivre.com.br/ }

constructor TACBrWSCEPLivre.Create(AOwner : TACBrCEP) ;
begin
  inherited Create(AOwner) ;
  fpURL := 'http://ceplivre.com.br/consultar/' ;
end ;

Procedure TACBrWSCEPLivre.BuscarPorCEP(ACEP : String) ;
begin
  TestarChave;

  // CEPLivre exige CEP formatado //
  ACEP := Copy(ACEP,1,5)+'-'+Copy(ACEP,6,3);

  fOwner.HTTPGet( fpURL + 'cep/' + Trim(fOwner.ChaveAcesso) + '/' + ACEP + '/csv') ;
  ProcessaResposta ;
end ;

Procedure TACBrWSCEPLivre.BuscarPorLogradouro(AMunicipio, ATipo_Logradouro,
  ALogradouro, AUF, ABairro : String) ;
begin
  TestarChave;

  ALogradouro := fOwner.AjustaParam( ALogradouro ) ;
  if (ALogradouro = '') then
     raise Exception.Create('Cidade e Logradouro devem ser informados');

  fOwner.HTTPGet( fpURL + 'logradouro/' + Trim( fOwner.ChaveAcesso ) + '/' + Alogradouro + '/csv' ) ;
  ProcessaResposta ;
end ;

Procedure TACBrWSCEPLivre.ProcessaResposta ;
Var
   SL1, SL2 : TStringList ;
   Buffer : String ;
   I : Integer ;
begin
  fOwner.fEnderecos.Clear;

  SL1 := TStringList.Create;
  SL2 := TStringList.Create;
  try
    SL1.Text := String( ACBrStrToAnsi( fOwner.RespHTTP.Text ) ) ;

    For I := 0 to SL1.Count-1 do
    begin
      Buffer := SL1[I] ;

      SL2.Clear;
      SL2.Text := StringReplace( Buffer, ',', sLineBreak, [rfReplaceAll] );

      if (SL2.Count >= 9) and (Length( OnlyNumber( AnsiString(SL2[8]) ) ) = 8) then
      begin
        with fOwner.Enderecos.New do
        begin
          CEP             := SL2[8] ;
          Tipo_Logradouro := SL2[0] ;
          Logradouro      := SL2[2] ;
          Bairro          := SL2[3] ;
          Municipio       := SL2[4] ;
          UF              := SL2[5] ;
          IBGE_Municipio  := SL2[9] ;
        end ;
      end ;
    end ;
  finally
    SL1.free ;
    SL2.free ;
  end ;

  if Assigned( fOwner.OnBuscaEfetuada ) then
     fOwner.OnBuscaEfetuada( Self );
end ;

{ TACBrWSRepublicaVirtual }

constructor TACBrWSRepublicaVirtual.Create(AOwner: TACBrCEP);
begin
  inherited Create(AOwner);
  fpURL := 'http://cep.republicavirtual.com.br/' ;
end;

procedure TACBrWSRepublicaVirtual.BuscarPorCEP(ACEP: String);
begin
  FCepBusca := ACep; // republica virtual nao devolve o cep na resposta
  ACEP := OnlyNumber( AnsiString( ACEP ) );

  fOwner.HTTPGet( fpURL + 'web_cep.php?cep='+ACEP+'&formato=xml' ) ;
  ProcessaResposta ;
end;

procedure TACBrWSRepublicaVirtual.BuscarPorLogradouro(AMunicipio,
  ATipo_Logradouro, ALogradouro, AUF, ABairro: String);
begin
  raise Exception.Create(ACBrStr('Busca por Logradouro n�o dispon�vel no site Republica Virtual.'));
end;

procedure TACBrWSRepublicaVirtual.ProcessaResposta;
var
  Buffer : String ;
begin
  fOwner.fEnderecos.Clear;

  Buffer := fOwner.RespHTTP.Text;
  if StrToIntDef(LerTagXML(Buffer, 'resultado'), 0) > 0 then
  begin
    with fOwner.Enderecos.New do
    begin
      CEP             := FCepBusca ; // republica virtual nao devolve o cep na resposta
      Tipo_Logradouro := LerTagXML(Buffer,'tipo_logradouro') ;
      Logradouro      := LerTagXML(Buffer,'logradouro') ;
      Complemento     := LerTagXML(Buffer,'complemento') ;
      Bairro          := LerTagXML(Buffer,'bairro') ;
      Municipio       := LerTagXML(Buffer,'cidade') ;
      UF              := LerTagXML(Buffer,'uf') ;
      IBGE_Municipio  := '';
    end ;
  end ;

  if Assigned( fOwner.OnBuscaEfetuada ) then
    fOwner.OnBuscaEfetuada( Self );
end ;


end.
