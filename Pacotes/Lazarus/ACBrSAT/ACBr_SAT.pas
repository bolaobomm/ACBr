{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit ACBr_SAT;

interface

uses
  ACBrSAT, pcnCFeCanc, pcnCFeCancW, pcnCFeW, ACBrSATReg, LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('ACBrSATReg', @ACBrSATReg.Register);
end;

initialization
  RegisterPackage('ACBr_SAT', @Register);
end.
