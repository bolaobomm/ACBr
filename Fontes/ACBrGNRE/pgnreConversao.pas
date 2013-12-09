unit pgnreConversao;

interface

uses
  SysUtils,
  {$IFNDEF VER130}
    Variants,
  {$ENDIF}
  Classes, pcnConversao;

type
  TStatusACBrGNRE = ( stGNREIdle, stGNRERecepcao, stGNRERetRecepcao, stGNREConsulta, stGNREConsultaConfigUF );
  TLayOut = ( LayGNRERecepcao, LayGNRERetRecepcao, LayGNREConsultaConfigUF );

implementation

end.

