@ECHO OFF
@ECHO OFF

if "%1" == "" goto param_default

if NOT EXIST %1\lazarus.exe goto erro_param

if NOT EXIST %1\tools\lazres.exe GOTO erro_lazres

:Comum
%1\tools\lazres.exe ACBrComum.lrs TACBrEAD.bmp TACBrAAC.bmp
move ACBrComum.lrs ..\ACBrComum
echo.
echo "****************************************"
echo "* Arquivo   ACBrDiversos.lrs   gerado  *"
echo "****************************************"
echo.

:Diversos
%1\tools\lazres.exe ACBrDiversos.lrs TACBrCalculadora.bmp TACBrExtenso.bmp TACBrValidador.bmp TACBrTroco.bmp TACBrCMC7.bmp TACBrFala.bmp TACBrGIF.bmp TACBrBarCode.bmp TACBrEnterTab.bmp TACBrCargaBal.png TACBrCotacao.bmp TACBrInStore.png
move ACBrDiversos.lrs ..\ACBrDiversos
echo.
echo "****************************************"
echo "* Arquivo   ACBrDiversos.lrs   gerado  *"
echo "****************************************"
echo.

:Serial
%1\tools\lazres.exe ACBrSerial.lrs TACBrECF.bmp TACBrGAV.bmp TACBrCHQ.bmp TACBrLCB.bmp TACBrDIS.bmp TACBrBAL.bmp TACBrTER.bmp TACBrETQ.bmp TACBrRFD.bmp TACBrSMS.bmp TACBrECFVirtualNaoFiscal.png
move ACBrSerial.lrs ..\ACBrSerial
echo.
echo "****************************************"
echo "* Arquivo   ACBrSerial.lrs   gerado    *"
echo "****************************************"
echo.

:TEFD
%1\tools\lazres.exe ACBrTEFD.lrs TACBrTEFD.bmp
move ACBrTEFD.lrs ..\ACBrTEFD
echo.
echo "****************************************"
echo "* Arquivo   ACBrTEFD.lrs   gerado      *"
echo "****************************************"
echo.

:TCP
%1\tools\lazres.exe ACBrTCP.lrs TACBrTCPServer.bmp TACBrCEP.bmp TACBrIBGE.bmp TACBrNFPws.bmp TACBrCNIEE.bmp TACBrSuframa.bmp TACBrDownload.bmp TACBrIBPTax.bmp TACBrConsultaCNPJ.bmp TACBrMail.bmp TACBrConsultaCPF.png TACBrSpedTabelas.bmp TACBrSedex.bmp TACBrNCMs.bmp 
move ACBrTCP.lrs ..\ACBrTCP
echo.
echo "****************************************"
echo "* Arquivo   ACBrTCP.lrs   gerado       *"
echo "****************************************"
echo.

:SPED
%1\tools\lazres.exe ACBrSpedFiscal.lrs TACBrSpedFiscal.bmp
%1\tools\lazres.exe ACBrSpedContabil.lrs TACBrSpedContabil.bmp
%1\tools\lazres.exe ACBrSpedPisCofins.lrs TACBrSpedPisCofins.bmp
%1\tools\lazres.exe ACBrSpedECF.lrs TACBrSpedECF.png
move ACBrSpedFiscal.lrs ..\ACBrSPED\ACBrSPEDFiscal
move ACBrSpedContabil.lrs ..\ACBrSPED\ACBrSPEDContabil
move ACBrSpedPisCofins.lrs ..\ACBrSPED\ACBrSpedPisCofins
move ACBrSpedECF.lrs ..\ACBrSPED\ACBrSPEDECF
echo.
echo "****************************************"
echo "* Arquivo  ACBrSpedFiscal.lrs   gerado *"
echo "* Arquivo  ACBrSpedContabil.lrs gerado *"
echo "* Arquivo  ACBrSpedPisCofins.lrs gerado*"
echo "* Arquivo  ACBrSpedECF.lrs gerado      *"
echo "****************************************"
echo.

:PAF
%1\tools\lazres.exe ACBrPAF.lrs TACBrPAF.bmp
move ACBrPAF.lrs ..\ACBrPAF
echo.
echo "****************************************"
echo "* Arquivo   ACBrPAF.lrs   gerado       *"
echo "****************************************"
echo.

:Boleto
%1\tools\lazres.exe ACBrBoleto.lrs TACBrBoleto.bmp
%1\tools\lazres.exe ACBrBoletoFCFortes.lrs TACBrBoletoFCFortes.bmp
%1\tools\lazres.exe ACBrBoletoFCLazReport.lrs TACBrBoletoFCLazReport.bmp ..\ACBrBoleto\FCLazReport_Padrao.lrf ..\ACBrBoleto\FCLazReport_CompEntrega.lrf ..\ACBrBoleto\FCLazReport_Carne.lrf

move ACBrBoleto.lrs ..\ACBrBoleto
move ACBrBoletoFCFortes.lrs ..\ACBrBoleto
move ACBrBoletoFCLazReport.lrs ..\ACBrBoleto
echo.
echo "****************************************"
echo "* Arquivo   ACBrBoleto.lrs   gerado    *"
echo "*    ACBrBoletoFCFortes.lrs  gerado    *"
echo "****************************************"
echo.

:NFe2
%1\tools\lazres.exe ACBrNFe.lrs TACBrNFe.bmp TACBrECFVirtualNFCe.png
move ACBrNFe.lrs ..\ACBrNFe2

%1\tools\lazres.exe ACBrNFeDANFeRL.lrs TACBrNFeDANFeRL.bmp 
move ACBrNFeDANFeRL.lrs ..\ACBrNFe2

%1\tools\lazres.exe ACBrNFeDANFCeFortes.lrs TACBrNFeDANFCeFortes.bmp 
move ACBrNFeDANFCeFortes.lrs ..\ACBrNFe2

%1\tools\lazres.exe ACBrNFeDANFeESCPOS.lrs TACBrNFeDANFeESCPOS.bmp 
move ACBrNFeDANFeESCPOS.lrs ..\ACBrNFe2

echo.
echo "**************************************************************"
echo "* Arquivos    ACBrNFe.lrs, ACBrNFeDANFeRL.lrs     gerados    *"
echo "**************************************************************"
echo.

:GNRE
%1\tools\lazres.exe ACBrGNRE.lrs TACBrGNRE.bmp 
move ACBrGNRE.lrs ..\ACBrGNRE

%1\tools\lazres.exe ACBrGNREGuiaFR.lrs TACBrGNREGuiaFR.bmp 
move ACBrGNREGuiaFR.lrs ..\ACBrGNRE

echo.
echo "****************************************"
echo "* Arquivo    ACBrGNRE.lrs     gerado    *"
echo "****************************************"
echo.

:NFSe
%1\tools\lazres.exe ACBrNFSe.lrs TACBrNFSe.bmp TACBrNFSeDANFSeRL.png 
move ACBrNFSe.lrs ..\ACBrNFSe

echo.
echo "****************************************"
echo "* Arquivo    ACBrNFSe.lrs     gerado    *"
echo "****************************************"
echo.

:CTe
%1\tools\lazres.exe ACBrCTe.lrs TACBrCTe.bmp TACBrCTeDACTeRL.png 
move ACBrCTe.lrs ..\ACBrCTe

echo.
echo "****************************************"
echo "* Arquivo    ACBrCTe.lrs     gerado    *"
echo "****************************************"
echo.

:MDFe
%1\tools\lazres.exe ACBrMDFe.lrs TACBrMDFe.bmp TACBrMDFeDAMDFeRL.png
move ACBrMDFe.lrs ..\ACBrMDFe

echo.
echo "****************************************"
echo "* Arquivo    ACBrMDFe.lrs     gerado    *"
echo "****************************************"
echo.

:LFD
%1\tools\lazres.exe ACBrLFD.lrs TACBrLFD.bmp 
move ACBrLFD.lrs ..\ACBrLFD

echo.
echo "****************************************"
echo "* Arquivo    ACBrLFD.lrs     gerado    *"
echo "****************************************"
echo.

:Sintegra
%1\tools\lazres.exe ACBrSintegra.lrs TACBrSintegra.bmp
move ACBrSintegra.lrs ..\ACBrSintegra
echo.
echo "****************************************"
echo "* Arquivo   ACBrSintegra.lrs   gerado  *"
echo "****************************************"
echo.

:SAT
%1\tools\lazres.exe ACBrSAT.lrs TACBrSAT.bmp TACBrSATExtratoESCPOS.bmp
move ACBrSAT.lrs ..\ACBrSAT
                     
%1\tools\lazres.exe ACBrSATExtratoFortes.lrs TACBrSATExtratoFortes.bmp
move ACBrSATExtratoFortes.lrs ..\ACBrSAT

%1\tools\lazres.exe ACBrECFVirtualSAT.lrs TACBrECFVirtualSAT.png
move ACBrECFVirtualSAT.lrs ..\ACBrSAT

echo.
echo "********************************************************************"
echo "*   Arquivos   ACBrSAT.lrs, ACBrSATExtratoFortes.lrs   gerados     *"
echo "********************************************************************"
echo.


:SEF2
%1\tools\lazres.exe ACBrSEF2.lrs TACBrSEF2.bmp
move ACBrSEF2.lrs ..\ACBrSEF2
echo.
echo "****************************************"
echo "*   Arquivo   ACBrSEF2.lrs   gerado     *"
echo "****************************************"
echo.

GOTO fim

:param_default
Compila_LRS.bat c:\lazarus
goto :fim

:erro_param
ECHO "Informe o diretorio do Lazarus. Exemplo:"
echo.
ECHO "Compila_LRS.bat c:\lazarus"
goto :fim

:erro_lazres
ECHO "Arquivo:"
echo %1\tools\lazres.exe
ECHO "nao encontrado... Favor compilar o projeto:  lazres.lpi"
goto fim

:fim
echo "Tecle ENTER para sair" .
pause