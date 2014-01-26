{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit ACBr_SAT;

interface

uses
  ACBrSAT, ACBrSATClass, ACBrSATDinamico_cdecl, ACBrSATExtratoClass, 
  ACBrSATExtratoESCPOS, pcnCFe, pcnCFeR, pcnCFeW, pcnCFeCanc, pcnCFeCancR, 
  pcnCFeCancW, LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('ACBrSAT', @ACBrSAT.Register);
end;

initialization
  RegisterPackage('ACBr_SAT', @Register);
end.
