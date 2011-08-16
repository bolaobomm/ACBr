unit ACBrECFDll;

interface

uses
  SysUtils,
  Classes,
  ACBrECF,
  ACBrECFClass,
  ACBrUtil;

{Classe que armazena os EventHandlers para o componente ACBr}
type TEventHandlers = class
    procedure OnMsgPoucoPapel(Sender: TObject);
end;

{Handle para o componente TACBrECF }
type TECFHandle = record
  UltimoErro : String;
  ECF : TACBrECF;
  EventHandlers : TEventHandlers;
end;

{Ponteiro para o Handle }
type PECFHandle = ^TECFHandle;

{Records estilo C utilizados nos retornos das fun��es}

type TAliquotaRec = record
      Indice : array[0..3] of char;
      Aliquota : double;
      Tipo : char;
      Total : double;
      Sequencia : byte;
end;

type TFormaPagamentoRec = record
      Indice : array[0..3] of char;
      Descricao : array[0..29] of char;
      PermiteVinculado : boolean;
      Total : double;
end;

type TComprovanteNaoFiscalRec = record
    Indice: array[0..3] of char;
    Descricao: array[0..29] of char;
    PermiteVinculado: Boolean;
    FormaPagamento: array[0..3] of char;
    Total: Double ;
    Contador: Integer;
end;

implementation

{
PADRONIZA��O DAS FUN��ES:

        PAR�METROS:
        Todas as fun��es recebem o par�metro "handle" que � o ponteiro
        para o componente instanciado; Este ponteiro deve ser armazenado
        pela aplica��o que utiliza a DLL;

        RETORNO:
        Todas as fun��es da biblioteca retornam um Integer com as poss�veis Respostas:

                MAIOR OU IGUAL A ZERO: SUCESSO
                Outos retornos maior que zero indicam sucesso, com valor espec�fico de cada fun��o.

                MENOR QUE ZERO: ERROS

                  -1 : Erro ao executar;
                       Vide UltimoErro

                  -2 : ACBr n�o inicializado.

                  Outros retornos negativos indicam erro espec�fico de cada fun��o;

                  A fun��o "UltimoErro" retornar� a mensagem da �ltima exception disparada pelo componente.
}


 procedure TEventHandlers.OnMsgPoucoPapel(Sender: TObject);
 begin
 end;

{
CRIA um novo componente TACBrECF retornando o ponteiro para o objeto criado.
Este ponteiro deve ser armazenado pela aplica��o que utiliza a DLL e informado
em todas as chamadas de fun��o relativas ao TACBrECF
}
Function ECF_Create(var ecfHandle: PECFHandle): Integer; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF}  export;
begin

  try

     New(ecfHandle);

     ecfHandle^.ECF := TACBrECF.Create(nil);
     ecfHandle^.EventHandlers := TEventHandlers.Create();
     ecfHandle^.ECF.ReTentar := False;
     ecfHandle^.ECF.ExibeMensagem := False;
     ecfHandle^.ECF.BloqueiaMouseTeclado := False;
     ecfHandle^.UltimoErro := '';
     ecfHandle^.ECF.OnMsgPoucoPapel := ecfHandle^.EventHandlers.OnMsgPoucoPapel;

     Result := 0;

  except
     on exception : Exception do
     begin
        Result := -1;
        ecfHandle^.UltimoErro := exception.Message;
     end
  end;

end;

{
DESTR�I o objeto TACBrECF e libera a mem�ria utilizada.
Esta fun��o deve SEMPRE ser chamada pela aplica��o que utiliza a DLL
quando o componente n�o mais for utilizado.
}
Function ECF_Destroy(var ecfHandle: PECFHandle): Integer; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF}  export;
begin

  try

     if (ecfHandle <> nil) then
     begin
         ecfHandle^.ECF.Destroy();
         Dispose(ecfHandle);
     end;

     Result := 0;
  except
     on exception : Exception do
     begin
        Result := -1;
        ecfHandle^.UltimoErro := exception.Message;
     end
  end;

end;

Function ECF_GetUltimoErro(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
begin

  try
     StrPLCopy(Buffer, ecfHandle^.UltimoErro, BufferLen);
     Result := length(ecfHandle^.UltimoErro);
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;


Function ECF_Ativar(const ecfHandle: PECFHandle) : Integer; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF}  export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     ecfHandle^.ECF.Ativar;
     Result := 0;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result  := -1;
     end
  end;

end;

Function ECF_Desativar(const ecfHandle: PECFHandle) : Integer; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF}  export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     ecfHandle^.ECF.Desativar;
     Result := 0;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;

end;

{ Fun��es mapeando as propriedades do componente }

Function ECF_GetModelo(const ecfHandle: PECFHandle) : Integer; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF}  export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     Result := Integer(ecfHandle^.ECF.Modelo);
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;

end;

Function ECF_SetModelo(const ecfHandle: PECFHandle; const Modelo : Integer) : Integer; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF}  export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     ecfHandle^.ECF.Modelo := TACBrECFModelo(Modelo);
     Result := 0;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;

end;

Function ECF_GetPorta(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
var
  StrTmp : String;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

 try
     StrTmp := ecfHandle^.ECF.Porta;
     StrPLCopy(Buffer, StrTmp, BufferLen);
     Result := length(StrTmp);
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;

end;

Function ECF_SetPorta(const ecfHandle: PECFHandle; const Porta : pChar) : Integer; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF}  export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     ecfHandle^.ECF.Porta := Porta;
     Result := 0;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;

end;

Function ECF_GetVelocidade(const ecfHandle: PECFHandle) : Integer; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF}  export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     Result := ecfHandle^.ECF.Device.Baud;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;

end;

Function ECF_SetVelocidade(const ecfHandle: PECFHandle; const Velocidade : Integer) : Integer; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF}  export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     ecfHandle^.ECF.Device.Baud := Velocidade;
     Result := 0;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;

end;

Function ECF_GetTimeOut(const ecfHandle: PECFHandle) : Integer; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF}  export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     Result := ecfHandle^.ECF.TimeOut;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;

end;

Function ECF_SetTimeOut(const ecfHandle: PECFHandle; const TimeOut : Integer) : Integer; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF}  export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     ecfHandle^.ECF.TimeOut := TimeOut;
     Result := 0;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;

end;


Function ECF_GetAtivo(const ecfHandle: PECFHandle) : Integer; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF}  export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     if (ecfHandle^.ECF.Ativo) then
        Result := 1
     else
        Result := 0;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;

end;

Function ECF_GetColunas(const ecfHandle: PECFHandle) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     Result := ecfHandle^.ECF.Colunas;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;

Function ECF_GetAguardandoResposta(const ecfHandle: PECFHandle) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
        if (ecfHandle^.ECF.AguardandoResposta) then
           Result := 1
        else
           Result :=0;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;

Function ECF_GetComandoEnviado(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
var
  StrTmp : String;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

 try
     StrTmp := ecfHandle^.ECF.ComandoEnviado;
     StrPLCopy(Buffer, StrTmp, BufferLen);
     Result := length(StrTmp);
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;

end;

Function ECF_GetRespostaComando(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
var
  StrTmp : String;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

 try
     StrTmp := ecfHandle^.ECF.RespostaComando;
     StrPLCopy(Buffer, StrTmp, BufferLen);
     Result := length(StrTmp);
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;

end;

Function ECF_GetComandoLOG(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
var
  StrTmp : String;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

 try
     StrTmp := ecfHandle^.ECF.ComandoLOG;
     StrPLCopy(Buffer, StrTmp, BufferLen);
     Result := length(StrTmp);
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;

end;

Function ECF_SetComandoLOG(const ecfHandle: PECFHandle; const ComandoLog : pChar) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

 try
     ecfHandle^.ECF.ComandoLOG := ComandoLog;
     Result := 0;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;

end;

Function ECF_GetAguardaImpressao(const ecfHandle: PECFHandle) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
        if ecfHandle^.ECF.AguardaImpressao then
            Result := 1
        else
            Result :=0;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;

Function ECF_SetAguardaImpressao(const ecfHandle: PECFHandle; const AguardaImpressao : Boolean) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     ecfHandle^.ECF.AguardaImpressao := AguardaImpressao;
     Result := 0;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;


Function ECF_GetModeloStr(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
Var
  StrTmp : String;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     StrTmp := ecfHandle^.ECF.ModeloStr;
     StrPLCopy(Buffer, StrTmp, BufferLen);
     Result := length(StrTmp);
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;

Function ECF_GetRFDID(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
Var
  StrTmp : String;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     StrTmp := ecfHandle^.ECF.RFDID;
     StrPLCopy(Buffer, StrTmp, BufferLen);
     Result := length(StrTmp);
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;

Function ECF_GetDataHora(const ecfHandle: PECFHandle; var ticks : Double) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     ticks := double(ecfHandle^.ECF.DataHora);
     Result := 0;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;

Function ECF_GetDataHoraStr(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
var
   strTmp : String;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     strTmp := FormatDateTime('dd/mm/yyyy hh:nn:ss', ecfHandle^.ECF.DataHora);
     StrPLCopy(Buffer, strTmp, BufferLen);
     Result := length(strTmp);
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;

Function ECF_GetNumCupom(const ecfHandle: PECFHandle;  Buffer : pChar; const BufferLen : Integer) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
var
   strTmp : String;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     strTmp := ecfHandle^.ECF.NumCupom;
     StrPLCopy(Buffer, strTmp, BufferLen);
     Result := length(strTmp);
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;

Function ECF_GetNumCOO(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
var
   strTmp : String;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     strTmp := ecfHandle^.ECF.NumCOO;
     StrPLCopy(Buffer, strTmp, BufferLen);
     Result := length(strTmp);
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;

Function ECF_GetNumLoja(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
var
   strTmp : String;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     strTmp := ecfHandle^.ECF.NumLoja;
     StrPLCopy(Buffer, strTmp, BufferLen);
     Result := length(strTmp);
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;

Function ECF_GetNumECF(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
var
   strTmp : String;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     strTmp := ecfHandle^.ECF.NumECF;
     StrPLCopy(Buffer, strTmp, BufferLen);
     Result := length(strTmp);
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;

Function ECF_GetNumSerie(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
var
   strTmp : String;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     strTmp := ecfHandle^.ECF.NumSerie;
     StrPLCopy(Buffer, strTmp, BufferLen);
     Result := length(strTmp);
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;

Function ECF_GetNumVersao(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
var
   strTmp : String;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     strTmp := ecfHandle^.ECF.NumVersao;
     StrPLCopy(Buffer, strTmp, BufferLen);
     Result := length(strTmp);
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end;
  end;
end;

Function ECF_GetDataMovimento(const ecfHandle: PECFHandle; var ticks : Double) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     ticks := double(ecfHandle^.ECF.DataMovimento);
     Result := 0;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;

Function ECF_GetDataMovimentoStr(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
var
   strTmp : String;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     strTmp := pchar(FormatDateTime('dd/mm/yyyy', ecfHandle^.ECF.DataMovimento));
     StrPLCopy(Buffer, strTmp, BufferLen);
     Result := length(strTmp);
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;

Function ECF_GetDataHoraSB(const ecfHandle: PECFHandle; var ticks : Double) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     ticks := double(ecfHandle^.ECF.DataHoraSB);
     Result := 0;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;

Function ECF_GetDataHoraSBStr(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
var
   strTmp : String;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     strTmp := pchar(FormatDateTime('dd/mm/yyyy hh:nn:ss', ecfHandle^.ECF.DataHoraSB));
     StrPLCopy(Buffer, strTmp, BufferLen);
     Result := length(strTmp);
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;


Function ECF_GetCNPJ(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
var
   strTmp : String;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     strTmp := ecfHandle^.ECF.CNPJ;
     StrPLCopy(Buffer, strTmp, BufferLen);
     Result := length(strTmp);
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;

Function ECF_GetIE(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
var
   strTmp : String;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     strTmp := ecfHandle^.ECF.IE;
     StrPLCopy(Buffer, strTmp, BufferLen);
     Result := length(strTmp);
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;

Function ECF_GetIM(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
var
   strTmp : String;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     strTmp := ecfHandle^.ECF.IM;
     StrPLCopy(Buffer, strTmp, BufferLen);
     Result := length(strTmp);
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;

Function ECF_GetCliche(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
var
  StrTmp : String;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

 try
     StrTmp := ecfHandle^.ECF.Cliche;
     StrPLCopy(Buffer, StrTmp, BufferLen);
     Result := length(StrTmp);
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;

end;

Function ECF_GetUsuarioAtual(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
var
  StrTmp : String;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

 try
     StrTmp := ecfHandle^.ECF.UsuarioAtual;
     StrPLCopy(Buffer, StrTmp, BufferLen);
     Result := length(StrTmp);
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;

end;

Function ECF_GetSubModeloECF(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
var
  StrTmp : String;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

 try
     StrTmp := ecfHandle^.ECF.SubModeloECF;
     StrPLCopy(Buffer, StrTmp, BufferLen);
     Result := length(StrTmp);
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;

end;


Function ECF_GetPAF(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
var
  StrTmp : String;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     StrTmp := ecfHandle^.ECF.PAF;
     StrPLCopy(Buffer, StrTmp, BufferLen);
     Result := length(StrTmp);
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;

end;



Function ECF_GetNumCRZ(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
var
   strTmp : String;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     strTmp := ecfHandle^.ECF.NumCRZ;
     StrPLCopy(Buffer, strTmp, BufferLen);
     Result := length(strTmp);
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;

Function ECF_GetNumCRO(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
var
   strTmp : String;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     strTmp := ecfHandle^.ECF.NumCRO;
     StrPLCopy(Buffer, strTmp, BufferLen);
     Result := length(strTmp);
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;

Function ECF_GetNumCCF(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
var
   strTmp : String;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     strTmp := ecfHandle^.ECF.NumCCF;
     StrPLCopy(Buffer, strTmp, BufferLen);
     Result := length(strTmp);
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;

Function ECF_GetNumGNF(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
var
   strTmp : String;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     strTmp := ecfHandle^.ECF.NumGNF;
     StrPLCopy(Buffer, strTmp, BufferLen);
     Result := length(strTmp);
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;

Function ECF_GetNumGRG(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
var
   strTmp : String;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     strTmp := ecfHandle^.ECF.NumGRG;
     StrPLCopy(Buffer, strTmp, BufferLen);
     Result := length(strTmp);
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;


Function ECF_GetNumCDC(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
var
   strTmp : String;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     strTmp := ecfHandle^.ECF.NumCDC;
     StrPLCopy(Buffer, strTmp, BufferLen);
     Result := length(strTmp);
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;



Function ECF_GetNumCOOInicial(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
var
   strTmp : String;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     strTmp := ecfHandle^.ECF.NumCOOInicial;
     StrPLCopy(Buffer, strTmp, BufferLen);
     Result := length(strTmp);
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;

Function ECF_GetVendaBruta(const ecfHandle: PECFHandle; var VendaBruta : Double) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     VendaBruta := ecfHandle^.ECF.VendaBruta;
     Result := 0 ;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;

Function ECF_GetGrandeTotal(const ecfHandle: PECFHandle; var GrandeTotal : Double ) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     GrandeTotal := ecfHandle^.ECF.GrandeTotal;
     Result := 0 ;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;

Function ECF_GetTotalCancelamentos(const ecfHandle: PECFHandle; var TotalCancelamentos : Double ) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     TotalCancelamentos := ecfHandle^.ECF.TotalCancelamentos;
     Result := 0 ;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;

Function ECF_GetTotalDescontos(const ecfHandle: PECFHandle; var TotalDescontos : Double ) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     TotalDescontos := ecfHandle^.ECF.TotalDescontos;
     Result := 0 ;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;

Function ECF_GetTotalAcrescimos(const ecfHandle: PECFHandle; var TotalAcrescimos : Double ) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     TotalAcrescimos := ecfHandle^.ECF.TotalAcrescimos;
     Result := 0 ;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;


Function ECF_GetTotalTroco(const ecfHandle: PECFHandle; var TotalTroco : Double ) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     TotalTroco := ecfHandle^.ECF.TotalTroco;
     Result := 0 ;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;


Function ECF_GetTotalSubstituicaoTributaria(const ecfHandle: PECFHandle; var TotalSubstituicaoTributaria : Double) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     TotalSubstituicaoTributaria := ecfHandle^.ECF.TotalSubstituicaoTributaria;
     Result := 0 ;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;

Function ECF_GetTotalNaoTributado(const ecfHandle: PECFHandle; var TotalNaoTributado : Double) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     TotalNaoTributado := ecfHandle^.ECF.TotalNaoTributado;
     Result := 0 ;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;

Function ECF_GetTotalIsencao(const ecfHandle: PECFHandle; var TotalIsencao : Double) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     TotalIsencao := ecfHandle^.ECF.TotalIsencao;
     Result := 0 ;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;


Function ECF_GetTotalCancelamentosISSQN(const ecfHandle: PECFHandle; var TotalCancelamentosISSQN : Double) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     TotalCancelamentosISSQN := ecfHandle^.ECF.TotalCancelamentosISSQN;
     Result := 0 ;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;


Function ECF_GetTotalDescontosISSQN(const ecfHandle: PECFHandle; var TotalDescontosISSQN : Double) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     TotalDescontosISSQN := ecfHandle^.ECF.TotalDescontosISSQN;
     Result := 0 ;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;

Function ECF_GetTotalAcrescimosISSQN(const ecfHandle: PECFHandle; var TotalAcrescimosISSQN : Double) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     TotalAcrescimosISSQN := ecfHandle^.ECF.TotalAcrescimosISSQN;
     Result := 0 ;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;

Function ECF_GetTotalSubstituicaoTributariaISSQN(const ecfHandle: PECFHandle; var TotalSubstituicaoTributariaISSQN : Double) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     TotalSubstituicaoTributariaISSQN := ecfHandle^.ECF.TotalSubstituicaoTributariaISSQN;
     Result := 0 ;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;


Function ECF_GetTotalNaoTributadoISSQN(const ecfHandle: PECFHandle; var TotalNaoTributadoISSQN : Double) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     TotalNaoTributadoISSQN := ecfHandle^.ECF.TotalNaoTributadoISSQN;
     Result := 0 ;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;

Function ECF_GetTotalIsencaoISSQN(const ecfHandle: PECFHandle; var TotalIsencaoISSQN : Double) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     TotalIsencaoISSQN := ecfHandle^.ECF.TotalIsencaoISSQN;
     Result := 0 ;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;

Function ECF_GetTotalNaoFiscal(const ecfHandle: PECFHandle; var TotalNaoFiscal : Double) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     TotalNaoFiscal := ecfHandle^.ECF.TotalNaoFiscal;
     Result := 0 ;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;

Function ECF_GetNumUltItem(const ecfHandle: PECFHandle) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

   try
      Result := ecfHandle^.ECF.NumUltItem;
   except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
   end;
end;


{ ECF - Flags }


Function ECF_GetEmLinha(const ecfHandle: PECFHandle; const TimeOut : Integer) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try

     if (ecfHandle^.ECF.EmLinha(TimeOut)) then
       Result := 1
     else
       Result := 0;

  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;

Function ECF_GetPoucoPapel(const ecfHandle: PECFHandle) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try

     if (ecfHandle^.ECF.PoucoPapel) then
       Result := 1
     else
       Result := 0;

  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;

Function ECF_GetEstado(const ecfHandle: PECFHandle) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     Result := integer(ecfHandle^.ECF.Estado);
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;

Function ECF_GetHorarioVerao(const ecfHandle: PECFHandle) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     If ecfHandle^.ECF.HorarioVerao then
        Result := 1
     Else
        Result := 0;


  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;

Function ECF_GetArredonda(const ecfHandle: PECFHandle) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     If ecfHandle^.ECF.Arredonda then
        Result := 1
     Else
        Result := 0;

  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;

Function ECF_GetTermica(const ecfHandle: PECFHandle) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     If ecfHandle^.ECF.Termica then
        Result := 1
     Else
        Result := 0;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;

Function ECF_GetMFD(const ecfHandle: PECFHandle) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     If ecfHandle^.ECF.MFD then
        Result:= 1
     Else
        Result := 0;

  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;

Function ECF_GetIdentificaConsumidorRodape(const ecfHandle: PECFHandle) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     If ecfHandle^.ECF.IdentificaConsumidorRodape then
        Result:= 1
     Else
        Result := 0;

  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;

Function ECF_GetSubTotal(const ecfHandle: PECFHandle; var SubTotal : double) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;;

  try
     SubTotal := ecfHandle^.ECF.Subtotal;
     Result := 0 ;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;

Function ECF_GetTotalPago(const ecfHandle: PECFHandle; var TotalPago : double) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     TotalPago := ecfHandle^.ECF.TotalPago;
     Result := 0 ;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;

Function ECF_GetGavetaAberta(const ecfHandle: PECFHandle) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     If ecfHandle^.ECF.GavetaAberta then
        Result := 1
     Else
        Result := 0;

  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;

Function ECF_GetChequePronto(const ecfHandle: PECFHandle) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     If ecfHandle^.ECF.ChequePronto then
        Result := 1
     Else
        Result := 0;

  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;


Function ECF_GetIntervaloAposComando(const ecfHandle: PECFHandle) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     Result := ecfHandle^.ECF.IntervaloAposComando;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;


Function ECF_SetIntervaloAposComando(const ecfHandle: PECFHandle; const Intervalo : Integer) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     ecfHandle^.ECF.IntervaloAposComando := Intervalo;
     Result := 0;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;

Function ECF_GetDescricaoGrande(const ecfHandle: PECFHandle) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     if ecfHandle^.ECF.DescricaoGrande then
       Result := 1
     else
       Result := 0;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;


Function ECF_SetDescricaoGrande(const ecfHandle: PECFHandle; const DescricaoGrande : Boolean) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     ecfHandle^.ECF.DescricaoGrande := DescricaoGrande;
     Result := 0;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;

Function ECF_GetGavetaSinalInvertido(const ecfHandle: PECFHandle) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     if ecfHandle^.ECF.GavetaSinalInvertido then
       Result := 1
     else
       Result := 0;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;


Function ECF_SetGavetaSinalInvertido(const ecfHandle: PECFHandle; const GavetaSinalInvertido : Boolean) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     ecfHandle^.ECF.GavetaSinalInvertido := GavetaSinalInvertido;
     Result := 0;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;

Function ECF_GetOperador(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
var
   strTmp : String;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     strTmp := ecfHandle^.ECF.Operador;
     StrPLCopy(Buffer, strTmp, BufferLen);
     Result := length(strTmp);
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;

Function ECF_SetOperador(const ecfHandle: PECFHandle; const Operador : pChar) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;
  try
     ecfHandle^.ECF.Operador := Operador;
     Result := 0;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;

Function ECF_GetLinhasEntreCupons(const ecfHandle: PECFHandle) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
       Result := ecfHandle^.ECF.LinhasEntreCupons;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;

Function ECF_SetLinhasEntreCupons(const ecfHandle: PECFHandle; const LinhasEntreCupons : Integer) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     ecfHandle^.ECF.LinhasEntreCupons := LinhasEntreCupons;
     Result := 0;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;

Function ECF_GetDecimaisPreco(const ecfHandle: PECFHandle) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
       Result := ecfHandle^.ECF.DecimaisPreco;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;

Function ECF_SetDecimaisPreco(const ecfHandle: PECFHandle; const DecimaisPreco : Integer) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     ecfHandle^.ECF.DecimaisPreco := DecimaisPreco;
     Result := 0;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;

Function ECF_GetDecimaisQtd(const ecfHandle: PECFHandle) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
       Result := ecfHandle^.ECF.DecimaisQtd;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;

Function ECF_SetDecimaisQtd(const ecfHandle: PECFHandle; const DecimaisQtd : Integer) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     ecfHandle^.ECF.DecimaisQtd := DecimaisQtd;
     Result := 0;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;

{M�todos do componente}

{
M�todos do cupom fiscal
}

Function ECF_IdentificaConsumidor(const ecfHandle: PECFHandle; const CPF_CNPJ, Nome, Endereco : pChar) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF}  export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     ecfHandle^.ECF.IdentificaConsumidor( CPF_CNPJ, Nome, Endereco );
     Result := 0 ;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;

end;

Function ECF_AbreCupom(const ecfHandle: PECFHandle; const CPF_CNPJ, Nome, Endereco : pChar) : Integer; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF}  export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     ecfHandle^.ECF.AbreCupom( CPF_CNPJ, Nome, Endereco );
     Result := 0;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;

end;

Function ECF_LegendaInmetroProximoItem(const ecfHandle: PECFHandle) : Integer; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF}  export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     ecfHandle^.ECF.LegendaInmetroProximoItem;
     Result := 0;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;

end;

Function ECF_VendeItem(const ecfHandle: PECFHandle;
                       const Codigo, Descricao, AliquotaICMS : pChar;
                       const Qtd, ValorUnitario, DescontoPorc : Double;
                       const Unidade, TipoDescontoAcrescimo, DescontoAcrescimo : pChar) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF}  export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     ecfHandle^.ECF.VendeItem(Codigo, Descricao, AliquotaICMS, Qtd, ValorUnitario, DescontoPorc, Unidade, TipoDescontoAcrescimo, DescontoAcrescimo );
     Result := 0 ;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;

end;


Function ECF_DescontoAcrescimoItemAnterior(const ecfHandle: PECFHandle;
                                           const ValorDescontoAcrescimo : Double; const DescontoAcrescimo : pChar) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF}  export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     ecfHandle^.ECF.DescontoAcrescimoItemAnterior(ValorDescontoAcrescimo, DescontoAcrescimo);
     Result := 0 ;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;

end;


Function ECF_SubtotalizaCupom(const ecfHandle: PECFHandle; const DescontoAcrescimo : Double ; const MensagemRodape : pChar) : Integer; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     ecfHandle^.ECF.SubtotalizaCupom( DescontoAcrescimo, MensagemRodape );
     Result := 0 ;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;

Function ECF_EfetuaPagamento(const ecfHandle: PECFHandle; const CodFormaPagto : pChar; const Valor : Double; const Observacao : pChar ; const ImprimeVinculado : Boolean) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     ecfHandle^.ECF.EfetuaPagamento(CodFormaPagto, Valor, Observacao, ImprimeVinculado);
     Result := 0 ;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;

Function ECF_EstornaPagamento(const ecfHandle: PECFHandle; const CodFormaPagtoEstornar : pChar; const CodFormaPagtoEfetivar : pChar; const Valor: Double; const Observacao : pChar) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     ecfHandle^.ECF.EstornaPagamento(CodFormaPagtoEstornar, CodFormaPagtoEfetivar, Valor, Observacao);
     Result := 0 ;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;


Function ECF_FechaCupom(const ecfHandle: PECFHandle; const Observacao : pChar) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     ecfHandle^.ECF.FechaCupom( Observacao );
     Result := 0 ;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;

Function ECF_CancelaCupom(const ecfHandle: PECFHandle) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     ecfHandle^.ECF.CancelaCupom;
     Result := 0;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;

Function ECF_CancelaItemVendido(const ecfHandle: PECFHandle; const NumItem : Integer ) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     ecfHandle^.ECF.CancelaItemVendido( NumItem );
     Result := 0;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;

Function ECF_CancelaItemVendidoParcial(const ecfHandle: PECFHandle; const NumItem : Integer; const Quantidade : Double ) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     ecfHandle^.ECF.CancelaItemVendidoParcial(NumItem, Quantidade);
     Result := 0;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;

Function ECF_CancelaDescontoAcrescimoItem(const ecfHandle: PECFHandle; const NumItem : Integer) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     ecfHandle^.ECF.CancelaDescontoAcrescimoItem(NumItem);
     Result := 0;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;

Function ECF_CancelaDescontoAcrescimoSubTotal(const ecfHandle: PECFHandle; const TipoAcrescimoDesconto : Char) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     ecfHandle^.ECF.CancelaDescontoAcrescimoSubTotal(TipoAcrescimoDesconto);
     Result := 0;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;


{
 Relat�rios
}

Function ECF_LeituraX(const ecfHandle: PECFHandle) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     ecfHandle^.ECF.LeituraX;
     Result := 0;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;

Function ECF_ReducaoZ(const ecfHandle: PECFHandle) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     ecfHandle^.ECF.ReducaoZ;
     Result := 0 ;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;


Function ECF_AbreRelatorioGerencial(const ecfHandle: PECFHandle; const Indice : Integer) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     ecfHandle^.ECF.AbreRelatorioGerencial(Indice);
     Result := 0 ;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;

Function ECF_LinhaRelatorioGerencial(const ecfHandle: PECFHandle; const Linha : pChar; const IndiceBMP : Integer) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     ecfHandle^.ECF.LinhaRelatorioGerencial(Linha, IndiceBMP);
     Result := 0 ;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;

Function ECF_AbreCupomVinculado(const ecfHandle: PECFHandle; const COO, CodFormaPagto : pChar; const Valor : Double) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     ecfHandle^.ECF.AbreCupomVinculado(COO, CodFormaPagto, Valor);
     Result := 0 ;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;

Function ECF_AbreCupomVinculadoCNF(const ecfHandle: PECFHandle; const COO, CodFormaPagto, CodComprovanteNaoFiscal : pChar; const Valor : Double) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     ecfHandle^.ECF.AbreCupomVinculado(COO, CodFormaPagto, CodComprovanteNaoFiscal, Valor);
     Result := 0 ;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;

Function ECF_LinhaCupomVinculado(const ecfHandle: PECFHandle; const Linha : pChar) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     ecfHandle^.ECF.LinhaCupomVinculado(Linha);
     Result := 0 ;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;

Function ECF_FechaRelatorio(const ecfHandle: PECFHandle) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     ecfHandle^.ECF.FechaRelatorio;
     Result := 0 ;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;


Function ECF_PulaLinhas(const ecfHandle: PECFHandle; const NumLinhas : Integer) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     ecfHandle^.ECF.PulaLinhas(NumLinhas);
     Result := 0 ;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;

Function ECF_CortaPapel(const ecfHandle: PECFHandle; const CorteParcial : Boolean) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     ecfHandle^.ECF.CortaPapel(CorteParcial);
     Result := 0 ;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;


{
Al�quotas
}

Function ECF_GetAliquota(const ecfHandle: PECFHandle; var retAliquota : TAliquotaRec; const index : Integer) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
var
  aliquota : TACBrECFAliquota;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

   try

      if (index >= 0) and (index < ecfHandle^.ECF.Aliquotas.Count) then
      begin
              aliquota := ecfHandle^.ECF.Aliquotas[index];

              StrPLCopy(retAliquota.Indice, aliquota.Indice, 4);
              retAliquota.Aliquota := aliquota.Aliquota;
              retAliquota.Tipo := aliquota.Tipo;
              retAliquota.Total := aliquota.Total;
              retAliquota.Sequencia := aliquota.Sequencia;
              Result := 0;

      end
      else
      begin
              Result := -3;
      end;

   except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
   end;
end;

Function ECF_CarregaAliquotas(const ecfHandle: PECFHandle) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF}  export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     ecfHandle^.ECF.CarregaAliquotas;
     Result := ecfHandle^.ECF.Aliquotas.Count;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;

end;

Function ECF_GetAliquotasStr(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
Var
  I : Integer;
  strTmp : string ;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

   try
      strTmp := '' ;
      if ecfHandle^.ECF.Aliquotas.Count < 1 then
        ecfHandle^.ECF.CarregaAliquotas ;

      for I := 0 to ecfHandle^.ECF.Aliquotas.Count -1 do
         strTmp := strTmp + padL(ecfHandle^.ECF.Aliquotas[I].Indice,4)
                      + ' '
                      + ecfHandle^.ECF.Aliquotas[I].Tipo
                      + FormatFloat('#0.00', ecfHandle^.ECF.Aliquotas[I].Aliquota) + '|' ;

     StrPLCopy(Buffer, strTmp, BufferLen);
     Result := length(strTmp);

   except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
   end;
end;

Function ECF_LerTotaisAliquota(const ecfHandle: PECFHandle) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

   try
     ecfHandle^.ECF.LerTotaisAliquota;
     Result := ecfHandle^.ECF.Aliquotas.Count;
   except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
   end;
end;

Function ECF_LerTotaisAliquotaStr(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
Var
  I : Integer;
  strTmp : string ;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

   try
      strTmp := '' ;
      ecfHandle^.ECF.LerTotaisAliquota ;

      for I := 0 to ecfHandle^.ECF.Aliquotas.Count -1 do
         strTmp := strTmp + padL(ecfHandle^.ECF.Aliquotas[I].Indice,4) +
                            FormatFloat('########0.00', ecfHandle^.ECF.Aliquotas[I].Total ) + '|' ;


     StrPLCopy(Buffer, strTmp, BufferLen);
     Result := length(strTmp);

   except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
   end;
end;


Function ECF_ProgramaAliquota(const ecfHandle: PECFHandle; const Aliquota : Double; const Tipo : Char) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

   try
      ecfHandle^.ECF.ProgramaAliquota(Aliquota, Tipo);
      Result := 0 ;
   except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
   end;
end;


Function ECF_AchaIcmsAliquota(const ecfHandle: PECFHandle;
                              const Aliq : Double ;
                              const Tipo : Char ;
                              var ret_pos : pchar ) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
var
    ICMS : TACBrECFAliquota;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

   try
      ICMS := ecfHandle^.ECF.AchaICMSAliquota( Aliq, Tipo  ) ;
      if ICMS <> nil then
              ret_pos := pchar(padL(ICMS.Indice,4))
      else
         ret_pos := pchar(padL('-1',4));
      Result := 0 ;
   except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
   end;
end;


{
 Forma de pagamento
}


Function ECF_GetFormaPagamento(const ecfHandle: PECFHandle; var retFormaPagamento : TFormaPagamentoRec; const index : Integer) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
var
  formaPagamento : TACBrECFFormaPagamento;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

   try

      if (index >= 0) and (index < ecfHandle^.ECF.FormasPagamento.Count) then
      begin

              formaPagamento := ecfHandle^.ECF.FormasPagamento[index];

              StrPLCopy(retFormaPagamento.Indice, formaPagamento.Indice, 4);
              StrPLCopy(retFormaPagamento.Descricao, formaPagamento.Descricao, 30);
              retFormaPagamento.PermiteVinculado := formaPagamento.PermiteVinculado;
              retFormaPagamento.Total := formaPagamento.Total;
              Result := 0;
      end
      else
      begin
              Result := -3;
      end;

   except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
   end;
end;

Function ECF_CarregaFormasPagamento(const ecfHandle: PECFHandle) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF}  export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     ecfHandle^.ECF.CarregaFormasPagamento;
     Result := ecfHandle^.ECF.FormasPagamento.Count;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;

end;

Function ECF_LerTotaisFormaPagamento(const ecfHandle: PECFHandle) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

   try
      ecfHandle^.ECF.LerTotaisFormaPagamento ;
      Result := ecfHandle^.ECF.FormasPagamento.Count;
   except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
   end;
end;

Function ECF_GetFormasPagamentoStr(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
Var
  I : Integer;
  strTmp : string;
  Vinc : Char ;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

   try
      strTmp := '' ;
      if ecfHandle^.ECF.FormasPagamento.Count < 1 then
         ecfHandle^.ECF.CarregaFormasPagamento ;


      for I := 0 to ecfHandle^.ECF.FormasPagamento.Count -1 do
      begin
         Vinc := ' ' ;
         if ecfHandle^.ECF.FormasPagamento[I].PermiteVinculado then
            Vinc := 'V' ;

         strTmp := strTmp + padL(ecfHandle^.ECF.FormasPagamento[I].Indice,4)
                      + ' '
                      + Vinc
                      + ecfHandle^.ECF.FormasPagamento[I].Descricao
                      + '|' ;
      end;

      StrPLCopy(Buffer, strTmp, BufferLen);
      Result := length(strTmp)
   except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
   end;
end;

Function ECF_LerTotaisFormaPagamentoStr(const ecfHandle: PECFHandle; Buffer : pChar; const BufferLen : Integer) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
Var
  I : Integer;
  strTmp : string ;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

   try
      strTmp := '' ;
      ecfHandle^.ECF.LerTotaisFormaPagamento ;

      for I := 0 to ecfHandle^.ECF.FormasPagamento.Count -1 do
         strTmp := strTmp + padL(ecfHandle^.ECF.FormasPagamento[I].Indice,4)
                      + FormatFloat('########0.00', ecfHandle^.ECF.FormasPagamento[I].Total ) + '|' ;


      StrPLCopy(Buffer, strTmp, BufferLen);
      Result := length(strTmp)
   except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
   end;
end;

Function ECF_ProgramaFormaPagamento(const ecfHandle: PECFHandle; const Descricao : pChar ; const PermiteVinculado : Boolean) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
var
  pDesc : String;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

   try
      pDesc := String(Descricao);
      ecfHandle^.ECF.ProgramaFormaPagamento(pDesc, PermiteVinculado);
      Result := 0;
   except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
   end;
end;


{
 Comprovantes N�o Fiscais
}

Function ECF_GetComprovanteNaoFiscal(const ecfHandle: PECFHandle; var retComprovanteNaoFiscal : TComprovanteNaoFiscalRec; const index : Integer) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
var
  comprovanteNaoFiscal : TACBrECFComprovanteNaoFiscal;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

   try

      if (index >= 0) and (index < ecfHandle^.ECF.ComprovantesNaoFiscais.Count) then
      begin
              comprovanteNaoFiscal := ecfHandle^.ECF.ComprovantesNaoFiscais[index];

              StrPLCopy(retComprovanteNaoFiscal.Indice, comprovanteNaoFiscal.Indice, 4);
              StrPLCopy(retComprovanteNaoFiscal.Descricao, comprovanteNaoFiscal.Descricao, 30);
              retComprovanteNaoFiscal.PermiteVinculado := comprovanteNaoFiscal.PermiteVinculado;
              StrPLCopy(retComprovanteNaoFiscal.FormaPagamento, comprovanteNaoFiscal.FormaPagamento, 4);
              retComprovanteNaoFiscal.Total := comprovanteNaoFiscal.Total;
              retComprovanteNaoFiscal.Contador := comprovanteNaoFiscal.Contador;
              Result := 0;
      end
      else
      begin
              Result := -3;
      end;

   except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
   end;
end;

Function ECF_CarregaComprovantesNaoFiscais(const ecfHandle: PECFHandle) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF}  export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     ecfHandle^.ECF.CarregaComprovantesNaoFiscais;
     Result := ecfHandle^.ECF.ComprovantesNaoFiscais.Count;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;

end;

Function ECF_LerTotaisComprovanteNaoFiscal(const ecfHandle: PECFHandle) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

   try
     ecfHandle^.ECF.LerTotaisComprovanteNaoFiscal;
     Result := ecfHandle^.ECF.Aliquotas.Count;
   except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
   end;
end;

Function ECF_ComprovantesNaoFiscais(const ecfHandle: PECFHandle; var v_ComprovantesNaoFiscais : pchar ) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
Var
  I : Integer;
  resp : string;
  Vinc : Char;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

   try
      resp := '' ;
      if ecfHandle^.ECF.ComprovantesNaoFiscais.Count < 1 then
         ecfHandle^.ECF.CarregaComprovantesNaoFiscais ;


      for I := 0 to ecfHandle^.ECF.ComprovantesNaoFiscais.Count -1 do
      begin
         Vinc := ' ' ;
         if ecfHandle^.ECF.ComprovantesNaoFiscais[I].PermiteVinculado then
            Vinc := 'V' ;

         resp := resp + padL(ecfHandle^.ECF.ComprovantesNaoFiscais[I].Indice,4)
                      + ' '
                      + Vinc
                      + ecfHandle^.ECF.ComprovantesNaoFiscais[I].Descricao
                      + '|' ;
      end;
      if resp <> '' then
      begin
         v_ComprovantesNaoFiscais := pchar(copy(resp,1,Length(resp)-1)) ;
      End;
      Result := 0;
   except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result  := -1;
     end
   end;
end;

Function ECF_LerTotaisComprovante(const ecfHandle: PECFHandle; var v_LerTotaisComprovante : pchar ) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
   Var I : Integer;
      resp : string ;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

   try
      resp := '' ;
      ecfHandle^.ECF.LerTotaisComprovanteNaoFiscal;

      for I := 0 to ecfHandle^.ECF.ComprovantesNaoFiscais.Count -1 do
         resp := resp + padL(ecfHandle^.ECF.ComprovantesNaoFiscais[I].Indice,4)
                      + FormatFloat('########0.00', ecfHandle^.ECF.ComprovantesNaoFiscais[I].Total ) + '|' ;


      if resp <> '' then
      begin
         v_LerTotaisComprovante := pchar(copy(resp,1,Length(resp)-1)) ;
      End;
      Result := 0 ;
   except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result  := -1;
     end
   end;
end;

Function ECF_ProgramaComprovanteNaoFiscal(const ecfHandle: PECFHandle; const Descricao, Tipo : pChar) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
var
  pDesc : String;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

   try
      pDesc := String(Descricao);
      ecfHandle^.ECF.ProgramaComprovanteNaoFiscal(pDesc, Tipo);
      Result := 0;
   except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
   end;
end;

{
Function ECF_AchaCNFDescricao( Descricao : String ;  var retorno : pchar  ) : Integer ;  cdecl;  export;
   var CNF    : TACBrECFComprovanteNaoFiscal  ;
       vinc   : string;

begin
   if ECF = nil then
    begin
      Result := -2;
      Exit ;
    end;

   try
      CNF := ecfHandle^.ECF.AchaCNFDescricao( Descricao, False  ) ;

      if CNF <> nil then
      begin
         Vinc := ' ';
         If CNF.PermiteVinculado then
           Vinc := 'V';

         retorno := pchar(padL(CNF.Indice,4) +
                          Vinc+
                          padL( CNF.Descricao, 30));
      end
      else
         retorno := pchar(padL('-1',4));

      Result := 0 ;

   except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result  := -1;
     end
   end;
end;

}

{
 ...
}


Function ECF_TestaPodeAbrirCupom(const ecfHandle: PECFHandle) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

   try
      ecfHandle^.ECF.TestaPodeAbrirCupom;
      Result := 0 ;
   except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
   end;
end;


Function ECF_Sangria(const ecfHandle: PECFHandle; const Valor: Double; const Obs: pChar) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
begin


  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     ecfHandle^.ECF.Sangria(Valor, Obs);
     Result := 0 ;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;

Function ECF_Suprimento(const ecfHandle: PECFHandle; const Valor: Double; const Obs: pChar) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     ecfHandle^.ECF.Suprimento(Valor, Obs);
     Result := 0 ;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;


Function ECF_AbreGaveta(const ecfHandle: PECFHandle) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     ecfHandle^.ECF.AbreGaveta;
     Result := 0 ;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;

Function ECF_MudaHorarioVerao(const ecfHandle: PECFHandle) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     ecfHandle^.ECF.MudaHorarioVerao;
     Result := 0 ;
  except
      on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function ECF_MudaArredondamento(const ecfHandle: PECFHandle;  const Arredondar: Boolean) : Integer ; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF} export;
begin

  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     ecfHandle^.ECF.MudaArredondamento(Arredondar);
     Result := 0 ;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;


Function ECF_AbreNaoFiscal(const ecfHandle: PECFHandle; const CPF_CNPJ : pChar) : Integer; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF}  export;
begin
  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     ecfHandle^.ECF.AbreNaoFiscal(CPF_CNPJ);
     Result := 0 ;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result := -1;
     end
  end;
end;


Function ECF_RegistraItemNaoFiscal(const ecfHandle: PECFHandle; const CodCNF: pChar; const Valor: Double; const Obs: pChar) : Integer; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF}  export;
begin
  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     ecfHandle^.ECF.RegistraItemNaoFiscal(CodCNF,Valor,Obs);
     Result := 0 ;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function ECF_SubtotalizaNaoFiscal(const ecfHandle: PECFHandle; const DescontoAcrescimo: Double; const MensagemRodape: pChar) : Integer; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF}  export;
begin
  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     ecfHandle^.ECF.SubtotalizaNaoFiscal(DescontoAcrescimo,MensagemRodape);
     Result := 0 ;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function ECF_EfetuaPagamentoNaoFiscal(const ecfHandle: PECFHandle; const CodFormaPagto: pChar; const Valor: Double; const Observacao: pChar; const ImprimeVinculado: Boolean) : Integer; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF}  export;
begin
  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     ecfHandle^.ECF.EfetuaPagamentoNaoFiscal(CodFormaPagto,Valor,Observacao,ImprimeVinculado);
     Result := 0 ;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function ECF_FechaNaoFiscal(const ecfHandle: PECFHandle; const Observacao: pChar) : Integer; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF}  export;
begin
  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     ecfHandle^.ECF.FechaNaoFiscal(Observacao);
     Result := 0 ;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function ECF_CancelaNaoFiscal(const ecfHandle: PECFHandle) : Integer; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF}  export;
begin
  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     ecfHandle^.ECF.CancelaNaoFiscal;
     Result := 0 ;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function ECF_CorrigeEstadoErro(const ecfHandle: PECFHandle; const ReducaoZ: Boolean) : Integer; {$IFDEF STDCALL} stdcall; {$ELSE} cdecl; {$ENDIF}  export;
begin
  if (ecfHandle = nil) then
  begin
     Result := -2;
     Exit;
  end;

  try
     ecfHandle^.ECF.CorrigeEstadoErro(ReducaoZ);
     Result := 0;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result  := -1;
     end
  end;
end;

{
N�O IMPLEMENTADO

Function ECF_ImprimeCheque(const ecfHandle: PECFHandle;
                           const Banco: pChar;
                           const Valor: Double;
                           const Favorecido : pChar;
                           const Cidade: pChar;
                           const Data: TDateTime;
                           const Observacao: String) : Integer ; cdecl;  export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     ecfHandle^.ECF.ImprimeCheque(Banco,Valor,Favorecido,Cidade,Data,Observacao);
     Result := 0 ;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function ECF_CancelaImpressaoCheque(const ecfHandle: PECFHandle) : Integer ; cdecl;export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     ecfHandle^.ECF.CancelaImpressaoCheque;
     Result := 0 ;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result  := -1;
     end
  end;
end;


Function ECF_AchaFPGDescricao(const ecfHandle: PECFHandle;
const Descricao : pChar ;  var retorno : pchar  ) : Integer ;cdecl; export;
   var FPG    : TACBrECFFormaPagamento  ;
       vinc   : string;

begin
   if ECF = nil then
    begin
      Result := -2;
      Exit ;
    end;

   try
      FPG := ecfHandle^.ECF.AchaFPGDescricao( Descricao, False  ) ;

      if FPG <> nil then
      begin
         Vinc := ' ';
         If FPG.PermiteVinculado then
           Vinc := 'V';

         retorno := pchar(padL(FPG.Indice,4) +
                          Vinc+
                          padL( FPG.Descricao, 30));
      end
      else
         retorno := pchar(padL('-1',4));

      Result := 0 ;

   except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result  := -1;
     end
   end;
end;




Function PreparaTEF : Integer ;  cdecl; export;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     ecfHandle^.ECF.PreparaTEF;
     Result := 0 ;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function EnviaComando(cmd: AnsiString; var resp : pchar ) : Integer ; cdecl;export; overload;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     resp := pchar(ecfHandle^.ECF.EnviaComando(cmd));
     Result := 0 ;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function EnviaComando(cmd: AnsiString; lTimeOut: Integer; var resp : pchar ) : Integer ; cdecl;  export; overload;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     resp := pchar(ecfHandle^.ECF.EnviaComando(cmd,lTimeOut));
     Result := 0 ;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function LeituraMemoriaFiscal(ReducaoInicial, ReducaoFinal: Integer;
   Simplificada : Boolean = False) : Integer ; cdecl; export; overload;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     ecfHandle^.ECF.LeituraMemoriaFiscal(ReducaoInicial, ReducaoFinal,
                                   Simplificada);
     Result := 0 ;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function LeituraMemoriaFiscal(DataInicial, DataFinal: TDateTime;
   Simplificada : Boolean) : Integer ;  cdecl;  export ; overload;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     ecfHandle^.ECF.LeituraMemoriaFiscal(DataInicial, DataFinal,
                                   Simplificada);
     Result := 0 ;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function LeituraMemoriaFiscalSerial(ReducaoInicial,ReducaoFinal: Integer;
                                    Simplificada : Boolean; var Linhas : pchar ) : Integer ;  cdecl;  export; overload;
   var v_linha : TStringList;
begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;
  try
     v_linha := TStringList.Create;
     ecfHandle^.ECF.LeituraMemoriaFiscalSerial(ReducaoInicial, ReducaoFinal, v_linha,
                                   Simplificada);
     Linhas := pchar(v_linha);
     v_linha.Free;
     Result := 0 ;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result  := -1;
     end
  end;
end;

Function LeituraMemoriaFiscalSerial(DataInicial,DataFinal: TDateTime; Simplificada : Boolean ;
                                    var Linhas : pchar ) : Integer ;  cdecl;  export ; overload;
  var v_linha : TStringList;

begin
  if ECF = nil then
   begin
     Result := -2;
     Exit ;
   end;

  try
     v_linha := TStringList.Create;
     ecfHandle^.ECF.LeituraMemoriaFiscalSerial(DataInicial, DataFinal, v_linha,
                                   Simplificada);
     Linhas := pchar(v_linha);
     v_linha.Free;
     Result := 0 ;
  except
     on exception : Exception do
     begin
        ecfHandle^.UltimoErro := exception.Message;
        Result  := -1;
     end
  end;
end;

}

exports

{ Fun��es }

ECF_Create,
ECF_Destroy,
ECF_GetUltimoErro,
ECF_Ativar, ECF_Desativar,

{ Propriedades do Componente }

ECF_GetModelo, ECF_SetModelo, ECF_GetPorta, ECF_SetPorta, ECF_GetVelocidade, ECF_SetVelocidade, ECF_GetTimeOut, ECF_SetTimeOut, ECF_GetAtivo,

ECF_GetColunas, ECF_GetAguardandoResposta, ECF_GetComandoEnviado, ECF_GetRespostaComando, ECF_GetComandoLOG, ECF_SetComandoLOG,
ECF_GetAguardaImpressao, ECF_SetAguardaImpressao,

ECF_GetModeloStr, ECF_GetRFDID, ECF_GetDataHora, ECF_GetDataHoraStr,
ECF_GetNumCupom, ECF_GetNumCOO, ECF_GetNumLoja, ECF_GetNumECF, ECF_GetNumSerie, ECF_GetNumVersao,

ECF_GetDataMovimento, ECF_GetDataMovimentoStr, ECF_GetDataHoraSB, ECF_GetDataHoraSBStr,
ECF_GetCNPJ, ECF_GetIE, ECF_GetIM, ECF_GetCliche, ECF_GetUsuarioAtual, ECF_GetSubModeloECF,

ECF_GetPAF, ECF_GetNumCRZ, ECF_GetNumCRO, ECF_GetNumCCF, ECF_GetNumGNF, ECF_GetNumGRG, ECF_GetNumCDC,
ECF_GetNumCOOInicial, ECF_GetVendaBruta, ECF_GetGrandeTotal,
ECF_GetTotalCancelamentos, ECF_GetTotalDescontos, ECF_GetTotalAcrescimos, ECF_GetTotalTroco,
ECF_GetTotalSubstituicaoTributaria, ECF_GetTotalNaoTributado, ECF_GetTotalIsencao,

ECF_GetTotalCancelamentosISSQN, ECF_GetTotalDescontosISSQN,
ECF_GetTotalAcrescimosISSQN, ECF_GetTotalSubstituicaoTributariaISSQN,
ECF_GetTotalNaoTributadoISSQN, ECF_GetTotalIsencaoISSQN, ECF_GetTotalNaoFiscal,

ECF_GetNumUltItem,

ECF_GetEmLinha, ECF_GetPoucoPapel, ECF_GetEstado, ECF_GetHorarioVerao, ECF_GetArredonda,
ECF_GetTermica, ECF_GetMFD, ECF_GetIdentificaConsumidorRodape,

ECF_GetSubTotal, ECF_GetTotalPago, ECF_GetGavetaAberta,

ECF_GetChequePronto,
ECF_GetIntervaloAposComando, ECF_SetIntervaloAposComando,
ECF_GetDescricaoGrande, ECF_SetDescricaoGrande,
ECF_GetGavetaSinalInvertido, ECF_SetGavetaSinalInvertido,
ECF_GetOperador, ECF_SetOperador,
ECF_GetLinhasEntreCupons, ECF_SetLinhasEntreCupons,
ECF_GetDecimaisPreco, ECF_SetDecimaisPreco,
ECF_GetDecimaisQtd, ECF_SetDecimaisQtd,

{ M�todos do Componente }

ECF_IdentificaConsumidor, ECF_AbreCupom, ECF_LegendaInmetroProximoItem, ECF_VendeItem,
ECF_DescontoAcrescimoItemAnterior,  ECF_SubtotalizaCupom,
ECF_EfetuaPagamento, ECF_EstornaPagamento, ECF_FechaCupom, ECF_CancelaCupom,
ECF_CancelaItemVendido, ECF_CancelaItemVendidoParcial,
ECF_CancelaDescontoAcrescimoItem, ECF_CancelaDescontoAcrescimoSubTotal,

ECF_LeituraX, ECF_ReducaoZ, ECF_AbreRelatorioGerencial,
ECF_LinhaRelatorioGerencial, ECF_LinhaCupomVinculado,
ECF_FechaRelatorio, ECF_PulaLinhas, ECF_CortaPapel,

ECF_AbreCupomVinculado, ECF_AbreCupomVinculadoCNF,

ECF_GetAliquota, ECF_CarregaAliquotas, ECF_LerTotaisAliquota,
ECF_GetAliquotasStr, ECF_LerTotaisAliquotaStr,
ECF_ProgramaAliquota, ECF_AchaIcmsAliquota,

ECF_GetFormaPagamento, ECF_CarregaFormasPagamento, ECF_LerTotaisFormaPagamento,
ECF_GetFormasPagamentoStr, ECF_LerTotaisFormaPagamentoStr,
ECF_ProgramaFormaPagamento,
{ECF_AchaFPGDescricao,}

ECF_GetComprovanteNaoFiscal, ECF_CarregaComprovantesNaoFiscais,
ECF_LerTotaisComprovanteNaoFiscal, ECF_ProgramaComprovanteNaoFiscal,

ECF_ComprovantesNaoFiscais, ECF_LerTotaisComprovante, {ECF_AchaCNFDescricao,}

ECF_TestaPodeAbrirCupom,
ECF_Sangria, ECF_Suprimento,
ECF_AbreNaoFiscal,
ECF_RegistraItemNaoFiscal, ECF_SubtotalizaNaoFiscal, ECF_EfetuaPagamentoNaoFiscal,
ECF_FechaNaoFiscal, ECF_CancelaNaoFiscal,

ECF_AbreGaveta,
{
ECF_ImprimeCheque, ECF_CancelaImpressaoCheque,
}

ECF_MudaHorarioVerao, ECF_MudaArredondamento,

ECF_CorrigeEstadoErro;

{N�o implementado}

{
PreparaTEF,

exports EnviaComando(cmd: AnsiString; var resp : pchar ) overload;
exports EnviaComando(cmd: AnsiString; lTimeOut: Integer; var resp : pchar ) overload;

exports LeituraMemoriaFiscal(DataInicial, DataFinal: TDateTime;
   Simplificada : Boolean) overload;
exports LeituraMemoriaFiscal(ReducaoInicial, ReducaoFinal: Integer;
   Simplificada : Boolean = False)  overload ;

exports LeituraMemoriaFiscalSerial(DataInicial, DataFinal: TDateTime;
   Simplificada : Boolean; const Linhas : pchar = nil) overload;
exports LeituraMemoriaFiscalSerial(ReducaoInicial, ReducaoFinal: Integer;
   Simplificada : Boolean = False; const Linhas : pchar = nil)  overload ;
}

end.

