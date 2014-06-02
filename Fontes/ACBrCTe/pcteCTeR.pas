////////////////////////////////////////////////////////////////////////////////
//                                                                            //
//              PCN - Projeto Cooperar CTe                                    //
//                                                                            //
//   Descri��o: Classes para gera��o/leitura dos arquivos xml da CTe          //
//                                                                            //
//        site: www.projetocooperar.org/cte                                   //
//       email: projetocooperar@zipmail.com.br                                //
//       forum: http://br.groups.yahoo.com/group/projeto_cooperar_cte/        //
//     projeto: http://code.google.com/p/projetocooperar/                     //
//         svn: http://projetocooperar.googlecode.com/svn/trunk/              //
//                                                                            //
// Coordena��o: (c) 2009 - Paulo Casagrande                                   //
//                                                                            //
//      Equipe: Vide o arquivo leiame.txt na pasta raiz do projeto            //
//                                                                            //
//      Vers�o: Vide o arquivo leiame.txt na pasta raiz do projeto            //
//                                                                            //
//     Licen�a: GNU Lesser General Public License (GNU LGPL)                  //
//                                                                            //
//              - Este programa � software livre; voc� pode redistribu�-lo    //
//              e/ou modific�-lo sob os termos da Licen�a P�blica Geral GNU,  //
//              conforme publicada pela Free Software Foundation; tanto a     //
//              vers�o 2 da Licen�a como (a seu crit�rio) qualquer vers�o     //
//              mais nova.                                                    //
//                                                                            //
//              - Este programa � distribu�do na expectativa de ser �til,     //
//              mas SEM QUALQUER GARANTIA; sem mesmo a garantia impl�cita de  //
//              COMERCIALIZA��O ou de ADEQUA��O A QUALQUER PROP�SITO EM       //
//              PARTICULAR. Consulte a Licen�a P�blica Geral GNU para obter   //
//              mais detalhes. Voc� deve ter recebido uma c�pia da Licen�a    //
//              P�blica Geral GNU junto com este programa; se n�o, escreva    //
//              para a Free Software Foundation, Inc., 59 Temple Place,       //
//              Suite 330, Boston, MA - 02111-1307, USA ou consulte a         //
//              licen�a oficial em http://www.gnu.org/licenses/gpl.txt        //
//                                                                            //
//    Nota (1): - Esta  licen�a  n�o  concede  o  direito  de  uso  do nome   //
//              "PCN  -  Projeto  Cooperar  CTe", n�o  podendo o mesmo ser    //
//              utilizado sem previa autoriza��o.                             //
//                                                                            //
//    Nota (2): - O uso integral (ou parcial) das units do projeto esta       //
//              condicionado a manuten��o deste cabe�alho junto ao c�digo     //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

{$I ACBr.inc}

unit pcteCTeR;

interface

uses
  SysUtils, Classes,
{$IFNDEF VER130}
  Variants,
{$ENDIF}
  pcnAuxiliar, pcnConversao, pcnLeitor, pcteCTe;

type

  TCTeR = class(TPersistent)
  private
    FLeitor: TLeitor;
    FCTe: TCTe;
  public
    constructor Create(AOwner: TCTe);
    destructor Destroy; override;
    function LerXml: boolean;
  published
    property Leitor: TLeitor read FLeitor write FLeitor;
    property CTe: TCTe read FCTe write FCTe;
  end;

implementation

{ TCTeR }

constructor TCTeR.Create(AOwner: TCTe);
begin
  FLeitor := TLeitor.Create;
  FCTe := AOwner;
end;

destructor TCTeR.Destroy;
begin
  FLeitor.Free;
  inherited Destroy;
end;

{$IFDEF PL_103}
 {$I pcteCTeR_V103.inc}
{$ENDIF}

{$IFDEF PL_104}
 {$I pcteCTeR_V104.inc}
{$ENDIF}

{$IFDEF PL_200}
// {$I pcteCTeR_V200.inc}
////////////////////////////////////////////////////////////////////////////////
//                                                                            //
//              Le o XML da vers�o 2.00                                       //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

function TCTeR.LerXml: boolean;
var
  ok: boolean;
  i, j, i01, i02, i03, i04: integer;
  sCST, Aspas: String;
begin

  // Incluido por Thiago Pedro em 02/06/2014
  if Pos('versao="', Leitor.Arquivo) <> 0 then
    Aspas := '"'
   else
    Aspas := '''';

  I := 0;
  I := RetornarPosEx('versao=', Leitor.Arquivo, I + 6);
  if I = 0 then
    raise Exception.Create('N�o encontrei inicio do URI: versao=');

  I := RetornarPosEx(Aspas, Leitor.Arquivo, I + 2);
  if I = 0 then
    raise Exception.Create('N�o encontrei inicio do URI: aspas inicial');

  J := RetornarPosEx(Aspas, Leitor.Arquivo, I + 1);
  if J = 0 then
    raise Exception.Create('N�o encontrei inicio do URI: aspas final');

  CTe.infCTe.versao := copy(Leitor.Arquivo, I + 1, J - I -1);
  //-- Fim inclus�o por Thiago Pedro em 02/06/2014



  // Incluido por Italo em 22/04/2013
  if Pos('Id="', Leitor.Arquivo) <> 0 then
    Aspas := '"'
   else
    Aspas := '''';

  I := 0;
  I := RetornarPosEx('Id=', Leitor.Arquivo, I + 6);
  if I = 0 then
    raise Exception.Create('N�o encontrei inicio do URI: Id=');

  I := RetornarPosEx(Aspas, Leitor.Arquivo, I + 2);
  if I = 0 then
    raise Exception.Create('N�o encontrei inicio do URI: aspas inicial');

  J := RetornarPosEx(Aspas, Leitor.Arquivo, I + 1);
  if J = 0 then
    raise Exception.Create('N�o encontrei inicio do URI: aspas final');

  // CTe.infCTe.ID := copy(Leitor.Arquivo, I + 4, J - I - 4);
  CTe.infCTe.ID := copy(Leitor.Arquivo, I + 1, J - I -1);

  (* Grupo da TAG <ide> *******************************************************)
  if Leitor.rExtrai(1, 'ide') <> '' then
  begin
    (*B02*)CTe.Ide.cUF      := Leitor.rCampo(tcInt, 'cUF');
    (*B03*)CTe.Ide.cCT      := Leitor.rCampo(tcStr, 'cCT');
    (*B04*)CTe.Ide.CFOP     := Leitor.rCampo(tcStr, 'CFOP');
    (*B05*)CTe.Ide.natOp    := Leitor.rCampo(tcStr, 'natOp');
    (*B06*)CTe.Ide.forPag   := StrTotpforPag(ok, Leitor.rCampo(tcStr, 'forPag'));
    (*B07*)CTe.Ide.modelo   := Leitor.rCampo(tcStr, 'mod');
    (*B08*)CTe.Ide.serie    := Leitor.rCampo(tcInt, 'serie');
    (*B09*)CTe.Ide.nCT      := Leitor.rCampo(tcInt, 'nCT');
    (*B10*)CTe.Ide.dhEmi    := Leitor.rCampo(tcDatHor, 'dhEmi');
    (*B11*)CTe.Ide.tpImp    := StrToTpImp(ok, Leitor.rCampo(tcStr, 'tpImp'));
    (*B12*)CTe.Ide.tpEmis   := StrToTpEmis(ok, Leitor.rCampo(tcStr, 'tpEmis'));
    (*B13*)CTe.Ide.cDV      := Leitor.rCampo(tcInt, 'cDV');
    (*B14*)CTe.Ide.tpAmb    := StrToTpAmb(ok, Leitor.rCampo(tcStr, 'tpAmb'));
    (*B15*)CTe.Ide.tpCTe    := StrTotpCTe(ok, Leitor.rCampo(tcStr, 'tpCTe'));
    (*B15a*)CTe.Ide.procEmi := StrToprocEmi(ok, Leitor.rCampo(tcStr, 'procEmi'));
    (*B15b*)CTe.Ide.verProc := Leitor.rCampo(tcStr, 'verProc');
    (*B15c*)CTe.Ide.refCTE  := Leitor.rCampo(tcStr, 'refCTE');
    (*B16*)CTe.Ide.cMunEnv  := Leitor.rCampo(tcInt, 'cMunEnv');
    (*B17*)CTe.Ide.xMunEnv  := Leitor.rCampo(tcStr, 'xMunEnv');
    (*B18*)CTe.Ide.UFEnv    := Leitor.rCampo(tcStr, 'UFEnv');
    (*B19*)CTe.Ide.modal    := StrToTpModal(ok, Leitor.rCampo(tcStr, 'modal'));
    (*B20*)CTe.Ide.tpServ   := StrToTpServ(ok, Leitor.rCampo(tcStr, 'tpServ'));
    (*B21*)CTe.Ide.cMunIni  := Leitor.rCampo(tcInt, 'cMunIni');
    (*B22*)CTe.Ide.xMunIni  := Leitor.rCampo(tcStr, 'xMunIni');
    (*B23*)CTe.Ide.UFIni    := Leitor.rCampo(tcStr, 'UFIni');
    (*B24*)CTe.Ide.cMunFim  := Leitor.rCampo(tcInt, 'cMunFim');
    (*B25*)CTe.Ide.xMunFim  := Leitor.rCampo(tcStr, 'xMunFim');
    (*B26*)CTe.Ide.UFFim    := Leitor.rCampo(tcStr, 'UFFim');
    (*B27*)CTe.Ide.retira   := StrToTpRetira(ok, Leitor.rCampo(tcStr, 'retira'));
    (*B27a*)CTe.Ide.xdetretira := Leitor.rCampo(tcStr, 'xDetRetira');
    (*#57*)CTe.Ide.dhCont := Leitor.rCampo(tcDatHor, 'dhCont');
    (*#58*)CTe.Ide.xJust  := Leitor.rCampo(tcStr, 'xJust');
  end;

  (* Grupo da TAG <ide><toma03> ***********************************************)
  if Leitor.rExtrai(1, 'ide') <> '' then
  begin
    if Leitor.rExtrai(2, 'toma03') <> '' then
    begin
      (*B29*)CTe.Ide.Toma03.Toma := StrToTpTomador(ok, Leitor.rCampo(tcStr, 'toma'));
    end;
  end;

  (* Grupo da TAG <ide><toma4> ************************************************)
  if Leitor.rExtrai(1, 'ide') <> '' then
  begin
    if Leitor.rExtrai(2, 'toma4') <> '' then
    begin
      (*B29*)CTe.Ide.Toma4.toma    := StrToTpTomador(ok, Leitor.rCampo(tcStr, 'toma'));
      (*B31*)CTe.Ide.Toma4.CNPJCPF := Leitor.rCampoCNPJCPF;
      (*B33*)CTe.Ide.Toma4.IE      := Leitor.rCampo(tcStr, 'IE');
      (*B34*)CTe.Ide.Toma4.xNome   := Leitor.rCampo(tcStr, 'xNome');
      (*B35*)CTe.Ide.Toma4.xFant   := Leitor.rCampo(tcStr, 'xFant');
      (*#44*)CTe.Ide.Toma4.fone    := Leitor.rCampo(tcStr, 'fone');
      (*#56*)CTe.Ide.Toma4.email   := Leitor.rCampo(tcStr, 'email');

       if Leitor.rExtrai(3, 'enderToma') <> '' then
       begin
         (*B37*)CTe.Ide.Toma4.EnderToma.xLgr    := Leitor.rCampo(tcStr, 'xLgr');
         (*B37*)CTe.Ide.Toma4.EnderToma.nro     := Leitor.rCampo(tcStr, 'nro');
         (*B37*)CTe.Ide.Toma4.EnderToma.xCpl    := Leitor.rCampo(tcStr, 'xCpl');
         (*B37*)CTe.Ide.Toma4.EnderToma.xBairro := Leitor.rCampo(tcStr, 'xBairro');
         (*B37*)CTe.Ide.Toma4.EnderToma.cMun    := Leitor.rCampo(tcInt, 'cMun');
         (*B37*)CTe.Ide.Toma4.EnderToma.xMun    := Leitor.rCampo(tcStr, 'xMun');
         (*B37*)CTe.Ide.Toma4.EnderToma.CEP     := Leitor.rCampo(tcInt, 'CEP');
         (*B37*)CTe.Ide.Toma4.EnderToma.UF      := Leitor.rCampo(tcStr, 'UF');
         (*B37*)CTe.Ide.Toma4.EnderToma.cPais   := Leitor.rCampo(tcInt, 'cPais');
         (*B37*)CTe.Ide.Toma4.EnderToma.xPais   := Leitor.rCampo(tcStr, 'xPais');
       end;
    end;
  end;

  (* Grupo da TAG <compl> *****************************************************)
  if Leitor.rExtrai(1, 'compl') <> '' then
  begin
    CTe.Compl.xCaracAd  := Leitor.rCampo(tcstr,'xCaracAd');
    CTe.Compl.xCaracSer := Leitor.rCampo(tcstr,'xCaracSer');
    CTe.Compl.xEmi      := Leitor.rCampo(tcstr,'xEmi');
    CTe.Compl.origCalc  := Leitor.rCampo(tcstr,'origCalc');
    CTe.Compl.destCalc  := Leitor.rCampo(tcstr,'destCalc');
    CTe.Compl.xObs      := Leitor.rCampo(tcstr,'xObs');

    if Leitor.rExtrai(2, 'fluxo') <> '' then
    begin
      CTe.Compl.fluxo.xOrig := Leitor.rCampo(tcstr,'xOrig');
      CTe.Compl.fluxo.xDest := Leitor.rCampo(tcstr,'xDest');
      CTe.Compl.fluxo.xRota := Leitor.rCampo(tcstr,'xRota');

      i01 := 0;
      while Leitor.rExtrai(3, 'pass', '', i01 + 1) <> '' do
      begin
        CTe.Compl.fluxo.pass.Add;
        CTe.Compl.fluxo.pass[i01].xPass := Leitor.rCampo(tcStr, 'xPass');
        inc(i01);
      end;
    end;

    // Incluido por Italo em 11/09/2013
    CTe.Compl.Entrega.TipoData := tdNaoInformado;
    CTe.Compl.Entrega.TipoHora := thNaoInformado;
    
    if Leitor.rExtrai(2, 'Entrega') <> '' then
    begin
      if Leitor.rExtrai(3, 'semData') <> '' then
      begin
        CTe.Compl.Entrega.TipoData      := tdSemData; // 02/05/2012 13:51:33 - Roberto Godinho
        CTe.Compl.Entrega.semData.tpPer := StrToTpDataPeriodo(ok, Leitor.rCampo(tcStr, 'tpPer'));
      end;

      if Leitor.rExtrai(3, 'comData') <> '' then
      begin
        CTe.Compl.Entrega.TipoData      := tdNaData; // 02/05/2012 13:51:33 - Roberto Godinho
        CTe.Compl.Entrega.comData.tpPer := StrToTpDataPeriodo(ok, Leitor.rCampo(tcStr, 'tpPer'));
        CTe.Compl.Entrega.comData.dProg := Leitor.rCampo(tcDat, 'dProg');
      end;

      if Leitor.rExtrai(3, 'noPeriodo') <> '' then
      begin
        CTe.Compl.Entrega.TipoData        := tdNoPeriodo; // 02/05/2012 13:51:33 - Roberto Godinho
        CTe.Compl.Entrega.noPeriodo.tpPer := StrToTpDataPeriodo(ok, Leitor.rCampo(tcStr, 'tpPer'));
        CTe.Compl.Entrega.noPeriodo.dIni  := Leitor.rCampo(tcDat, 'dIni');
        CTe.Compl.Entrega.noPeriodo.dFim  := Leitor.rCampo(tcDat, 'dFim');
      end;

      if Leitor.rExtrai(3, 'semHora') <> '' then
      begin
        CTe.Compl.Entrega.TipoHora      := thSemHorario; // 02/05/2012 13:51:33 - Roberto Godinho
        CTe.Compl.Entrega.semHora.tpHor := StrToTpHorarioIntervalo(ok, Leitor.rCampo(tcStr, 'tpHor'));
      end;

      if Leitor.rExtrai(3, 'comHora') <> '' then
      begin
        CTe.Compl.Entrega.TipoHora      := thNoHorario; // 02/05/2012 13:51:33 - Roberto Godinho
        CTe.Compl.Entrega.comHora.tpHor := StrToTpHorarioIntervalo(ok, Leitor.rCampo(tcStr, 'tpHor'));
        CTe.Compl.Entrega.comHora.hProg := StrToTime(Leitor.rCampo(tcStr, 'hProg'));
      end;

      if Leitor.rExtrai(3, 'noInter') <> '' then
      begin
        CTe.Compl.Entrega.TipoHora      := thNoIntervalo; // 02/05/2012 13:51:33 - Roberto Godinho
        CTe.Compl.Entrega.noInter.tpHor := StrToTpHorarioIntervalo(ok, Leitor.rCampo(tcStr, 'tpHor'));
        CTe.Compl.Entrega.noInter.hIni  := StrToTime(Leitor.rCampo(tcStr, 'hIni'));
        CTe.Compl.Entrega.noInter.hFim  := StrToTime(Leitor.rCampo(tcStr, 'hFim'));
      end;
    end;

    i01 := 0;
    I := 0;
    while Leitor.rExtrai(2, 'ObsCont', '', i01 + 1) <> '' do
    begin
      I := RetornarPosEx('ObsCont xCampo=', Leitor.Arquivo, I + 1);
      J := RetornarPosEx(Aspas, Leitor.Arquivo, I + 16);
      CTe.Compl.ObsCont.Add;
      CTe.Compl.ObsCont[i01].xCampo := copy(Leitor.Arquivo, I + 16, J - (I + 16));
      CTe.Compl.ObsCont[i01].xTexto := Leitor.rCampo(tcstr,'xTexto');
      inc(i01);
    end;

    i01 := 0;
    I := 0;
    while Leitor.rExtrai(2, 'ObsFisco', '', i01 + 1) <> '' do
    begin
      I := RetornarPosEx('ObsFisco xCampo=', Leitor.Arquivo, I + 1);
      J := RetornarPosEx(Aspas, Leitor.Arquivo, I + 17);
      CTe.Compl.ObsFisco.Add;
      CTe.Compl.ObsFisco[i01].xCampo := copy(Leitor.Arquivo, I + 17, J - (I + 17));
      CTe.Compl.ObsFisco[i01].xTexto := Leitor.rCampo(tcstr,'xTexto');
      inc(i01);
    end;
  end;

  (* Grupo da TAG <emit> ******************************************************)
  if Leitor.rExtrai(1, 'emit') <> '' then
  begin
    CTe.emit.CNPJ  := Leitor.rCampo(tcStr,'CNPJ');
    CTe.emit.IE    := Leitor.rCampo(tcStr, 'IE');
    CTe.emit.xNome := Leitor.rCampo(tcStr, 'xNome');
    CTe.emit.xFant := Leitor.rCampo(tcStr, 'xFant');

    if Leitor.rExtrai(2, 'enderEmit') <> '' then
    begin
      CTe.emit.enderemit.xLgr    := Leitor.rCampo(tcStr, 'xLgr');
      CTe.emit.enderemit.Nro     := Leitor.rCampo(tcStr, 'nro');
      CTe.emit.enderemit.xCpl    := Leitor.rCampo(tcStr, 'xCpl');
      CTe.emit.enderemit.xBairro := Leitor.rCampo(tcStr, 'xBairro');
      CTe.emit.enderemit.cMun    := Leitor.rCampo(tcInt, 'cMun');
      CTe.emit.enderemit.xMun    := Leitor.rCampo(tcStr, 'xMun');
      CTe.emit.enderemit.CEP     := Leitor.rCampo(tcInt, 'CEP');
      CTe.emit.enderemit.UF      := Leitor.rCampo(tcStr, 'UF');
      CTe.emit.enderemit.fone    := Leitor.rCampo(tcStr, 'fone');
    end;
  end;

  (* Grupo da TAG <rem> *******************************************************)
  if Leitor.rExtrai(1, 'rem') <> '' then
  begin
    CTe.Rem.CNPJCPF := Leitor.rCampoCNPJCPF('locColeta');
    CTe.Rem.IE      := Leitor.rCampo(tcStr, 'IE');
    CTe.Rem.xNome   := Leitor.rCampo(tcStr, 'xNome', 'locColeta');
    CTe.Rem.xFant   := Leitor.rCampo(tcStr, 'xFant');
    CTe.Rem.fone    := Leitor.rCampo(tcStr, 'fone');
    CTe.Rem.email   := Leitor.rCampo(tcStr, 'email');

    if Leitor.rExtrai(2, 'enderReme') <> '' then
    begin
      CTe.Rem.enderReme.xLgr    := Leitor.rCampo(tcStr, 'xLgr');
      CTe.Rem.enderReme.Nro     := Leitor.rCampo(tcStr, 'nro');
      CTe.Rem.enderReme.xCpl    := Leitor.rCampo(tcStr, 'xCpl');
      CTe.Rem.enderReme.xBairro := Leitor.rCampo(tcStr, 'xBairro');
      CTe.Rem.enderReme.cMun    := Leitor.rCampo(tcInt, 'cMun');
      CTe.Rem.enderReme.xMun    := Leitor.rCampo(tcStr, 'xMun');
      CTe.Rem.enderReme.CEP     := Leitor.rCampo(tcInt, 'CEP');
      CTe.Rem.enderReme.UF      := Leitor.rCampo(tcStr, 'UF');
      CTe.Rem.enderReme.cPais   := Leitor.rCampo(tcInt, 'cPais');
      CTe.Rem.enderReme.xPais   := Leitor.rCampo(tcStr, 'xPais');
    end;

    if Leitor.rExtrai(2, 'locColeta') <> '' then
    begin
      CTe.Rem.locColeta.CNPJCPF := Leitor.rCampoCNPJCPF;
      CTe.Rem.locColeta.xNome   := Leitor.rCampo(tcStr, 'xNome');
      CTe.Rem.locColeta.xLgr    := Leitor.rCampo(tcStr, 'xLgr');
      CTe.Rem.locColeta.Nro     := Leitor.rCampo(tcStr, 'nro');
      CTe.Rem.locColeta.xCpl    := Leitor.rCampo(tcStr, 'xCpl');
      CTe.Rem.locColeta.xBairro := Leitor.rCampo(tcStr, 'xBairro');
      CTe.Rem.locColeta.cMun    := Leitor.rCampo(tcInt, 'cMun');
      CTe.Rem.locColeta.xMun    := Leitor.rCampo(tcStr, 'xMun');
      CTe.Rem.locColeta.UF      := Leitor.rCampo(tcStr, 'UF');
    end;

    // Inclu�do por Thiago Pedro em 02/06/2014 -- Compatibilidade com CTe 1
    i01 := 0;
    if (Copy(CTe.infCTe.versao,1,1)='1') then
    begin
      while Leitor.rExtrai(2, 'infNFe', '', i01 + 1) <> '' do
      begin
        CTe.infCTeNorm.infDoc.InfNFE.Add;
        CTe.infCTeNorm.infDoc.InfNFE[i01].chave := Leitor.rCampo(tcStr, 'chave');
        CTe.infCTeNorm.infDoc.InfNFE[i01].PIN   := Leitor.rCampo(tcStr, 'PIN');
        inc(i01);
      end;
    end;
    //-- Fim da inclus�o por Thiago Pedro em 02/06/2014
  end;

  (* Grupo da TAG <exped> *****************************************************)
  if Leitor.rExtrai(1, 'exped') <> '' then
  begin
    CTe.Exped.CNPJCPF := Leitor.rCampoCNPJCPF;
    CTe.Exped.IE      := Leitor.rCampo(tcStr, 'IE');
    CTe.Exped.xNome   := Leitor.rCampo(tcStr, 'xNome');
    CTe.Exped.fone    := Leitor.rCampo(tcStr, 'fone');
    CTe.Exped.email   := Leitor.rCampo(tcStr, 'email');

    if Leitor.rExtrai(2, 'enderExped') <> '' then
    begin
      CTe.Exped.EnderExped.xLgr    := Leitor.rCampo(tcStr, 'xLgr');
      CTe.Exped.EnderExped.Nro     := Leitor.rCampo(tcStr, 'nro');
      CTe.Exped.EnderExped.xCpl    := Leitor.rCampo(tcStr, 'xCpl');
      CTe.Exped.EnderExped.xBairro := Leitor.rCampo(tcStr, 'xBairro');
      CTe.Exped.EnderExped.cMun    := Leitor.rCampo(tcInt, 'cMun');
      CTe.Exped.EnderExped.xMun    := Leitor.rCampo(tcStr, 'xMun');
      CTe.Exped.EnderExped.CEP     := Leitor.rCampo(tcInt, 'CEP');
      CTe.Exped.EnderExped.UF      := Leitor.rCampo(tcStr, 'UF');
      CTe.Exped.EnderExped.cPais   := Leitor.rCampo(tcInt, 'cPais');
      CTe.Exped.EnderExped.xPais   := Leitor.rCampo(tcStr, 'xPais');
    end;
  end;

  (* Grupo da TAG <receb> *****************************************************)
  if Leitor.rExtrai(1, 'receb') <> '' then
  begin
    CTe.receb.CNPJCPF := Leitor.rCampoCNPJCPF;
    CTe.receb.IE      := Leitor.rCampo(tcStr, 'IE');
    CTe.receb.xNome   := Leitor.rCampo(tcStr, 'xNome');
    CTe.receb.fone    := Leitor.rCampo(tcStr, 'fone');
    CTe.receb.email   := Leitor.rCampo(tcStr, 'email');

    if Leitor.rExtrai(2, 'enderReceb') <> '' then
    begin
      CTe.receb.Enderreceb.xLgr    := Leitor.rCampo(tcStr, 'xLgr');
      CTe.receb.Enderreceb.Nro     := Leitor.rCampo(tcStr, 'nro');
      CTe.receb.Enderreceb.xCpl    := Leitor.rCampo(tcStr, 'xCpl');
      CTe.receb.Enderreceb.xBairro := Leitor.rCampo(tcStr, 'xBairro');
      CTe.receb.Enderreceb.cMun    := Leitor.rCampo(tcInt, 'cMun');
      CTe.receb.Enderreceb.xMun    := Leitor.rCampo(tcStr, 'xMun');
      CTe.receb.Enderreceb.CEP     := Leitor.rCampo(tcInt, 'CEP');
      CTe.receb.Enderreceb.UF      := Leitor.rCampo(tcStr, 'UF');
      CTe.receb.Enderreceb.cPais   := Leitor.rCampo(tcInt, 'cPais');
      CTe.receb.Enderreceb.xPais   := Leitor.rCampo(tcStr, 'xPais');
    end;
  end;

  (* Grupo da TAG <dest> ******************************************************)
  if Leitor.rExtrai(1, 'dest') <> '' then
  begin
    CTe.Dest.CNPJCPF := Leitor.rCampoCNPJCPF('locEnt');
    CTe.Dest.IE      := Leitor.rCampo(tcStr, 'IE');
    CTe.Dest.xNome   := Leitor.rCampo(tcStr, 'xNome', 'locEnt');
    CTe.Dest.fone    := Leitor.rCampo(tcStr, 'fone');
    CTe.Dest.ISUF    := Leitor.rCampo(tcStr, 'ISUF');
    CTe.Dest.email   := Leitor.rCampo(tcStr, 'email');

    if Leitor.rExtrai(2, 'enderDest') <> '' then
    begin
      CTe.Dest.EnderDest.xLgr    := Leitor.rCampo(tcStr, 'xLgr');
      CTe.Dest.EnderDest.Nro     := Leitor.rCampo(tcStr, 'nro');
      CTe.Dest.EnderDest.xCpl    := Leitor.rCampo(tcStr, 'xCpl');
      CTe.Dest.EnderDest.xBairro := Leitor.rCampo(tcStr, 'xBairro');
      CTe.Dest.EnderDest.cMun    := Leitor.rCampo(tcInt, 'cMun');
      CTe.Dest.EnderDest.xMun    := Leitor.rCampo(tcStr, 'xMun');
      CTe.Dest.EnderDest.CEP     := Leitor.rCampo(tcInt, 'CEP');
      CTe.Dest.EnderDest.UF      := Leitor.rCampo(tcStr, 'UF');
      CTe.Dest.EnderDest.cPais   := Leitor.rCampo(tcInt, 'cPais');
      CTe.Dest.EnderDest.xPais   := Leitor.rCampo(tcStr, 'xPais');
    end;

    if Leitor.rExtrai(2, 'locEnt') <> '' then
    begin
      CTe.Dest.locEnt.CNPJCPF := Leitor.rCampoCNPJCPF;
      CTe.Dest.locEnt.xNome   := Leitor.rCampo(tcStr, 'xNome');
      CTe.Dest.locEnt.xLgr    := Leitor.rCampo(tcStr, 'xLgr');
      CTe.Dest.locEnt.Nro     := Leitor.rCampo(tcStr, 'nro');
      CTe.Dest.locEnt.xCpl    := Leitor.rCampo(tcStr, 'xCpl');
      CTe.Dest.locEnt.xBairro := Leitor.rCampo(tcStr, 'xBairro');
      CTe.Dest.locEnt.cMun    := Leitor.rCampo(tcInt, 'cMun');
      CTe.Dest.locEnt.xMun    := Leitor.rCampo(tcStr, 'xMun');
      CTe.Dest.locEnt.UF      := Leitor.rCampo(tcStr, 'UF');
    end;
  end;

  (* Grupo da TAG <vPrest> ****************************************************)
  if Leitor.rExtrai(1, 'vPrest') <> '' then
  begin
    CTe.vPrest.vTPrest := Leitor.rCampo(tcDe2,'vTPrest');
    CTe.vPrest.vRec    := Leitor.rCampo(tcDe2,'vRec');

    i01 := 0;
    while Leitor.rExtrai(2, 'Comp', '', i01 + 1) <> '' do
    begin
      CTe.vPrest.Comp.Add;
      CTe.vPrest.Comp[i01].xNome := Leitor.rCampo(tcStr, 'xNome');
      CTe.vPrest.Comp[i01].vComp := Leitor.rCampo(tcDe2, 'vComp');
      inc(i01);
    end;
  end;

  (* Grupo da TAG <imp> *******************************************************)
  if Leitor.rExtrai(1, 'imp') <> '' then
  begin
    CTe.Imp.vTotTrib   := Leitor.rCampo(tcDe2,'vTotTrib');
    CTe.Imp.infAdFisco := Leitor.rCampo(tcStr,'infAdFisco');

    if Leitor.rExtrai(2, 'ICMS') <> '' then
    begin
      if Leitor.rExtrai(3, 'ICMS00') <> '' then
      begin
        if Leitor.rCampo(tcStr,'CST')='00'
        then begin
          CTe.Imp.ICMS.SituTrib     := cst00;
          CTe.Imp.ICMS.ICMS00.CST   := StrToCSTICMS(ok, Leitor.rCampo(tcStr,'CST'));
          CTe.Imp.ICMS.ICMS00.vBC   := Leitor.rCampo(tcDe2,'vBC');
          CTe.Imp.ICMS.ICMS00.pICMS := Leitor.rCampo(tcDe2,'pICMS');
          CTe.Imp.ICMS.ICMS00.vICMS := Leitor.rCampo(tcDe2,'vICMS');
        end;
      end;

      if Leitor.rExtrai(3, 'ICMS20') <> '' then
      begin
        if Leitor.rCampo(tcStr,'CST')='20'
        then begin
          CTe.Imp.ICMS.SituTrib      := cst20;
          CTe.Imp.ICMS.ICMS20.CST    := StrToCSTICMS(ok, Leitor.rCampo(tcStr,'CST'));
          CTe.Imp.ICMS.ICMS20.pRedBC := Leitor.rCampo(tcDe2,'pRedBC');
          CTe.Imp.ICMS.ICMS20.vBC    := Leitor.rCampo(tcDe2,'vBC');
          CTe.Imp.ICMS.ICMS20.pICMS  := Leitor.rCampo(tcDe2,'pICMS');
          CTe.Imp.ICMS.ICMS20.vICMS  := Leitor.rCampo(tcDe2,'vICMS');
        end;
      end;

      if Leitor.rExtrai(3, 'ICMS45') <> '' then
      begin
        sCST:=Leitor.rCampo(tcStr,'CST');
        if (sCST='40') or (sCST='41') or (sCST='51')
        then begin
          if sCST='40' then CTe.Imp.ICMS.SituTrib  := cst40;
          if sCST='41' then CTe.Imp.ICMS.SituTrib  := cst41;
          if sCST='51' then CTe.Imp.ICMS.SituTrib  := cst51;
          CTe.Imp.ICMS.ICMS45.CST := StrToCSTICMS(ok, Leitor.rCampo(tcStr,'CST'));
        end;
      end;

      if Leitor.rExtrai(3, 'ICMS60') <> '' then
      begin
        if Leitor.rCampo(tcStr,'CST')='60'
        then begin
          CTe.Imp.ICMS.SituTrib          := cst60;
          CTe.Imp.ICMS.ICMS60.CST        := StrToCSTICMS(ok, Leitor.rCampo(tcStr,'CST'));
          CTe.Imp.ICMS.ICMS60.vBCSTRet   := Leitor.rCampo(tcDe2,'vBCSTRet');
          CTe.Imp.ICMS.ICMS60.vICMSSTRet := Leitor.rCampo(tcDe2,'vICMSSTRet');
          CTe.Imp.ICMS.ICMS60.pICMSSTRet := Leitor.rCampo(tcDe2,'pICMSSTRet');
          CTe.Imp.ICMS.ICMS60.vCred      := Leitor.rCampo(tcDe2,'vCred');
        end;
      end;

      if Leitor.rExtrai(3, 'ICMS90') <> '' then
      begin
        if Leitor.rCampo(tcStr,'CST')='90'
        then begin
          CTe.Imp.ICMS.SituTrib      := cst90;
          CTe.Imp.ICMS.ICMS90.CST    := StrToCSTICMS(ok, Leitor.rCampo(tcStr,'CST'));
          CTe.Imp.ICMS.ICMS90.pRedBC := Leitor.rCampo(tcDe2,'pRedBC');
          CTe.Imp.ICMS.ICMS90.vBC    := Leitor.rCampo(tcDe2,'vBC');
          CTe.Imp.ICMS.ICMS90.pICMS  := Leitor.rCampo(tcDe2,'pICMS');
          CTe.Imp.ICMS.ICMS90.vICMS  := Leitor.rCampo(tcDe2,'vICMS');
          CTe.Imp.ICMS.ICMS90.vCred  := Leitor.rCampo(tcDe2,'vCred');
        end;
      end;

      if Leitor.rExtrai(3, 'ICMSOutraUF') <> '' then
      begin
        if Leitor.rCampo(tcStr,'CST')='90'
        then begin
          // ICMS devido � UF de origem da presta��o, quando diferente da UF do emitente
          CTe.Imp.ICMS.SituTrib                  := cstICMSOutraUF;
          CTe.Imp.ICMS.ICMSOutraUF.CST           := StrToCSTICMS(ok, Leitor.rCampo(tcStr,'CST'));
          CTe.Imp.ICMS.ICMSOutraUF.pRedBCOutraUF := Leitor.rCampo(tcDe2,'pRedBCOutraUF');
          CTe.Imp.ICMS.ICMSOutraUF.vBCOutraUF    := Leitor.rCampo(tcDe2,'vBCOutraUF');
          CTe.Imp.ICMS.ICMSOutraUF.pICMSOutraUF  := Leitor.rCampo(tcDe2,'pICMSOutraUF');
          CTe.Imp.ICMS.ICMSOutraUF.vICMSOutraUF  := Leitor.rCampo(tcDe2,'vICMSOutraUF');
        end;
      end;

      if Leitor.rExtrai(3, 'ICMSSN') <> '' then
      begin
       // ICMS Simples Nacional
       CTe.Imp.ICMS.SituTrib     := cstICMSSN;
       CTe.Imp.ICMS.ICMSSN.indSN := Leitor.rCampo(tcInt,'indSN');
      end;

    end;
  end;

  (* Grupo da TAG <infCTeNorm> ************************************************)
  if Leitor.rExtrai(1, 'infCTeNorm') <> '' then
  begin
    if Leitor.rExtrai(2, 'infCarga') <> ''
    then begin
      CTe.infCTeNorm.infCarga.vCarga  := Leitor.rCampo(tcDe2,'vCarga');
      CTe.infCTeNorm.InfCarga.proPred := Leitor.rCampo(tcStr,'proPred');
      CTe.infCTeNorm.InfCarga.xOutCat := Leitor.rCampo(tcStr,'xOutCat');
    end;

    i01 := 0;
    while Leitor.rExtrai(3, 'infQ', '', i01 + 1) <> '' do
    begin
      CTe.infCTeNorm.InfCarga.infQ.Add;
      CTe.infCTeNorm.InfCarga.infQ[i01].cUnid  := Leitor.rCampo(tcStr, 'cUnid');
      CTe.infCTeNorm.InfCarga.infQ[i01].tpMed  := Leitor.rCampo(tcStr, 'tpMed');
      CTe.infCTeNorm.InfCarga.infQ[i01].qCarga := Leitor.rCampo(tcDe4, 'qCarga');
      inc(i01);
    end;

    if Leitor.rExtrai(2, 'infDoc') <> ''
    then begin
      i01 := 0;
      while Leitor.rExtrai(3, 'infNF', '', i01 + 1) <> '' do
      begin
        CTe.infCTeNorm.infDoc.infNF.Add;
        CTe.infCTeNorm.infDoc.InfNF[i01].nRoma := Leitor.rCampo(tcStr, 'nRoma');
        CTe.infCTeNorm.infDoc.InfNF[i01].nPed  := Leitor.rCampo(tcStr, 'nPed');
        CTe.infCTeNorm.infDoc.InfNF[i01].Modelo := StrToModeloNF(Ok, Leitor.rCampo(tcStr, 'mod'));
        CTe.infCTeNorm.infDoc.InfNF[i01].serie := Leitor.rCampo(tcStr, 'serie');
        CTe.infCTeNorm.infDoc.InfNF[i01].nDoc  := Leitor.rCampo(tcEsp, 'nDoc');
        CTe.infCTeNorm.infDoc.InfNF[i01].dEmi  := Leitor.rCampo(tcDat, 'dEmi');
        CTe.infCTeNorm.infDoc.InfNF[i01].vBC   := Leitor.rCampo(tcDe2, 'vBC');
        CTe.infCTeNorm.infDoc.InfNF[i01].vICMS := Leitor.rCampo(tcDe2, 'vICMS');
        CTe.infCTeNorm.infDoc.InfNF[i01].vBCST := Leitor.rCampo(tcDe2, 'vBCST');
        CTe.infCTeNorm.infDoc.InfNF[i01].vST   := Leitor.rCampo(tcDe2, 'vST');
        CTe.infCTeNorm.infDoc.InfNF[i01].vProd := Leitor.rCampo(tcDe2, 'vProd');
        CTe.infCTeNorm.infDoc.InfNF[i01].vNF   := Leitor.rCampo(tcDe2, 'vNF');
        CTe.infCTeNorm.infDoc.InfNF[i01].nCFOP := Leitor.rCampo(tcInt, 'nCFOP');
        CTe.infCTeNorm.infDoc.InfNF[i01].nPeso := Leitor.rCampo(tcDe3, 'nPeso');
        CTe.infCTeNorm.infDoc.InfNF[i01].PIN   := Leitor.rCampo(tcStr, 'PIN');
        CTe.infCTeNorm.infDoc.InfNF[i01].dPrev := Leitor.rCampo(tcDat, 'dPrev');

        i02 := 0;
        while Leitor.rExtrai(4, 'infUnidTransp', '', i02 + 1) <> '' do
        begin
          CTe.infCTeNorm.infDoc.infNF[i01].infUnidTransp.Add;
          CTe.infCTeNorm.infDoc.infNF[i01].infUnidTransp[i02].tpUnidTransp := StrToUnidTransp(ok, Leitor.rCampo(tcStr, 'tpUnidTransp'));
          CTe.infCTeNorm.infDoc.infNF[i01].infUnidTransp[i02].idUnidTransp := Leitor.rCampo(tcStr, 'idUnidTransp');
          CTe.infCTeNorm.infDoc.infNF[i01].infUnidTransp[i02].qtdRat       := Leitor.rCampo(tcDe2, 'qtdRat');

          i03 := 0;
          while Leitor.rExtrai(5, 'lacUnidTransp', '', i03 + 1) <> '' do
          begin
            CTe.infCTeNorm.infDoc.infNF[i01].infUnidTransp[i02].lacUnidTransp.Add;
            CTe.infCTeNorm.infDoc.infNF[i01].infUnidTransp[i02].lacUnidTransp[i03].nLacre := Leitor.rCampo(tcStr, 'nLacre');
            inc(i03);
          end;

          i03 := 0;
          while Leitor.rExtrai(5, 'infUnidCarga', '', i03 + 1) <> '' do
          begin
            CTe.infCTeNorm.infDoc.infNF[i01].infUnidTransp[i02].infUnidCarga.Add;
            CTe.infCTeNorm.infDoc.infNF[i01].infUnidTransp[i02].infUnidCarga[i03].tpUnidCarga := StrToUnidCarga(ok, Leitor.rCampo(tcStr, 'tpUnidCarga'));
            CTe.infCTeNorm.infDoc.infNF[i01].infUnidTransp[i02].infUnidCarga[i03].idUnidCarga := Leitor.rCampo(tcStr, 'idUnidCarga');
            CTe.infCTeNorm.infDoc.infNF[i01].infUnidTransp[i02].infUnidCarga[i03].qtdRat      := Leitor.rCampo(tcDe2, 'qtdRat');

            i04 := 0;
            while Leitor.rExtrai(6, 'lacUnidCarga', '', i04 + 1) <> '' do
            begin
              CTe.infCTeNorm.infDoc.infNF[i01].infUnidTransp[i02].infUnidCarga[i03].lacUnidCarga.Add;
              CTe.infCTeNorm.infDoc.infNF[i01].infUnidTransp[i02].infUnidCarga[i03].lacUnidCarga[i04].nLacre := Leitor.rCampo(tcStr, 'nLacre');
              inc(i04);
            end;

            inc(i03);
          end;

          inc(i02);
        end;

        i02 := 0;
        while Leitor.rExtrai(4, 'infUnidCarga', '', i02 + 1) <> '' do
        begin
          CTe.infCTeNorm.infDoc.infNF[i01].infUnidCarga.Add;
          CTe.infCTeNorm.infDoc.infNF[i01].infUnidCarga[i02].tpUnidCarga := StrToUnidCarga(ok, Leitor.rCampo(tcStr, 'tpUnidCarga'));
          CTe.infCTeNorm.infDoc.infNF[i01].infUnidCarga[i02].idUnidCarga := Leitor.rCampo(tcStr, 'idUnidCarga');
          CTe.infCTeNorm.infDoc.infNF[i01].infUnidCarga[i02].qtdRat      := Leitor.rCampo(tcDe2, 'qtdRat');

          i03 := 0;
          while Leitor.rExtrai(5, 'lacUnidCarga', '', i03 + 1) <> '' do
          begin
            CTe.infCTeNorm.infDoc.infNF[i01].infUnidCarga[i02].lacUnidCarga.Add;
            CTe.infCTeNorm.infDoc.infNF[i01].infUnidCarga[i02].lacUnidCarga[i03].nLacre := Leitor.rCampo(tcStr, 'nLacre');
            inc(i03);
          end;

          inc(i02);
        end;

        inc(i01);
      end;

      i01 := 0;
      while Leitor.rExtrai(3, 'infNFe', '', i01 + 1) <> '' do
      begin
        CTe.infCTeNorm.infDoc.InfNFE.Add;
        CTe.infCTeNorm.infDoc.InfNFE[i01].chave := Leitor.rCampo(tcStr, 'chave');
        CTe.infCTeNorm.infDoc.InfNFE[i01].PIN   := Leitor.rCampo(tcStr, 'PIN');
        CTe.infCTeNorm.infDoc.InfNFE[i01].dPrev := Leitor.rCampo(tcDat, 'dPrev');

        i02 := 0;
        while Leitor.rExtrai(4, 'infUnidTransp', '', i02 + 1) <> '' do
        begin
          CTe.infCTeNorm.infDoc.InfNFE[i01].infUnidTransp.Add;
          CTe.infCTeNorm.infDoc.InfNFE[i01].infUnidTransp[i02].tpUnidTransp := StrToUnidTransp(ok, Leitor.rCampo(tcStr, 'tpUnidTransp'));
          CTe.infCTeNorm.infDoc.InfNFE[i01].infUnidTransp[i02].idUnidTransp := Leitor.rCampo(tcStr, 'idUnidTransp');
          CTe.infCTeNorm.infDoc.InfNFE[i01].infUnidTransp[i02].qtdRat       := Leitor.rCampo(tcDe2, 'qtdRat');

          i03 := 0;
          while Leitor.rExtrai(5, 'lacUnidTransp', '', i03 + 1) <> '' do
          begin
            CTe.infCTeNorm.infDoc.InfNFE[i01].infUnidTransp[i02].lacUnidTransp.Add;
            CTe.infCTeNorm.infDoc.InfNFE[i01].infUnidTransp[i02].lacUnidTransp[i03].nLacre := Leitor.rCampo(tcStr, 'nLacre');
            inc(i03);
          end;

          i03 := 0;
          while Leitor.rExtrai(5, 'infUnidCarga', '', i03 + 1) <> '' do
          begin
            CTe.infCTeNorm.infDoc.InfNFE[i01].infUnidTransp[i02].infUnidCarga.Add;
            CTe.infCTeNorm.infDoc.InfNFE[i01].infUnidTransp[i02].infUnidCarga[i03].tpUnidCarga := StrToUnidCarga(ok, Leitor.rCampo(tcStr, 'tpUnidCarga'));
            CTe.infCTeNorm.infDoc.InfNFE[i01].infUnidTransp[i02].infUnidCarga[i03].idUnidCarga := Leitor.rCampo(tcStr, 'idUnidCarga');
            CTe.infCTeNorm.infDoc.InfNFE[i01].infUnidTransp[i02].infUnidCarga[i03].qtdRat      := Leitor.rCampo(tcDe2, 'qtdRat');

            i04 := 0;
            while Leitor.rExtrai(6, 'lacUnidCarga', '', i04 + 1) <> '' do
            begin
              CTe.infCTeNorm.infDoc.InfNFE[i01].infUnidTransp[i02].infUnidCarga[i03].lacUnidCarga.Add;
              CTe.infCTeNorm.infDoc.InfNFE[i01].infUnidTransp[i02].infUnidCarga[i03].lacUnidCarga[i04].nLacre := Leitor.rCampo(tcStr, 'nLacre');
              inc(i04);
            end;

            inc(i03);
          end;

          inc(i02);
        end;

        i02 := 0;
        while Leitor.rExtrai(4, 'infUnidCarga', '', i02 + 1) <> '' do
        begin
          CTe.infCTeNorm.infDoc.infNFE[i01].infUnidCarga.Add;
          CTe.infCTeNorm.infDoc.infNFE[i01].infUnidCarga[i02].tpUnidCarga := StrToUnidCarga(ok, Leitor.rCampo(tcStr, 'tpUnidCarga'));
          CTe.infCTeNorm.infDoc.infNFE[i01].infUnidCarga[i02].idUnidCarga := Leitor.rCampo(tcStr, 'idUnidCarga');
          CTe.infCTeNorm.infDoc.infNFE[i01].infUnidCarga[i02].qtdRat      := Leitor.rCampo(tcDe2, 'qtdRat');

          i03 := 0;
          while Leitor.rExtrai(5, 'lacUnidCarga', '', i03 + 1) <> '' do
          begin
            CTe.infCTeNorm.infDoc.infNFE[i01].infUnidCarga[i02].lacUnidCarga.Add;
            CTe.infCTeNorm.infDoc.infNFE[i01].infUnidCarga[i02].lacUnidCarga[i03].nLacre := Leitor.rCampo(tcStr, 'nLacre');
            inc(i03);
          end;

          inc(i02);
        end;

        inc(i01);
      end;

      i01 := 0;
      while Leitor.rExtrai(3, 'infOutros', '', i01 + 1) <> '' do
      begin
        CTe.infCTeNorm.infDoc.InfOutros.Add;
        CTe.infCTeNorm.infDoc.InfOutros[i01].tpDoc      := StrToTpDocumento(ok, Leitor.rCampo(tcStr, 'tpDoc'));
        CTe.infCTeNorm.infDoc.InfOutros[i01].descOutros := Leitor.rCampo(tcStr, 'descOutros');
        CTe.infCTeNorm.infDoc.InfOutros[i01].nDoc       := Leitor.rCampo(tcStr, 'nDoc');
        CTe.infCTeNorm.infDoc.InfOutros[i01].dEmi       := Leitor.rCampo(tcDat, 'dEmi');
        CTe.infCTeNorm.infDoc.InfOutros[i01].vDocFisc   := Leitor.rCampo(tcDe2, 'vDocFisc');
        CTe.infCTeNorm.infDoc.InfOutros[i01].dPrev      := Leitor.rCampo(tcDat, 'dPrev');

        i02 := 0;
        while Leitor.rExtrai(4, 'infUnidTransp', '', i02 + 1) <> '' do
        begin
          CTe.infCTeNorm.infDoc.InfOutros[i01].infUnidTransp.Add;
          CTe.infCTeNorm.infDoc.InfOutros[i01].infUnidTransp[i02].tpUnidTransp := StrToUnidTransp(ok, Leitor.rCampo(tcStr, 'tpUnidTransp'));
          CTe.infCTeNorm.infDoc.InfOutros[i01].infUnidTransp[i02].idUnidTransp := Leitor.rCampo(tcStr, 'idUnidTransp');
          CTe.infCTeNorm.infDoc.InfOutros[i01].infUnidTransp[i02].qtdRat       := Leitor.rCampo(tcDe2, 'qtdRat');

          i03 := 0;
          while Leitor.rExtrai(5, 'lacUnidTransp', '', i03 + 1) <> '' do
          begin
            CTe.infCTeNorm.infDoc.InfOutros[i01].infUnidTransp[i02].lacUnidTransp.Add;
            CTe.infCTeNorm.infDoc.InfOutros[i01].infUnidTransp[i02].lacUnidTransp[i03].nLacre := Leitor.rCampo(tcStr, 'nLacre');
            inc(i03);
          end;

          i03 := 0;
          while Leitor.rExtrai(5, 'infUnidCarga', '', i03 + 1) <> '' do
          begin
            CTe.infCTeNorm.infDoc.InfOutros[i01].infUnidTransp[i02].infUnidCarga.Add;
            CTe.infCTeNorm.infDoc.InfOutros[i01].infUnidTransp[i02].infUnidCarga[i03].tpUnidCarga := StrToUnidCarga(ok, Leitor.rCampo(tcStr, 'tpUnidCarga'));
            CTe.infCTeNorm.infDoc.InfOutros[i01].infUnidTransp[i02].infUnidCarga[i03].idUnidCarga := Leitor.rCampo(tcStr, 'idUnidCarga');
            CTe.infCTeNorm.infDoc.InfOutros[i01].infUnidTransp[i02].infUnidCarga[i03].qtdRat      := Leitor.rCampo(tcDe2, 'qtdRat');

            i04 := 0;
            while Leitor.rExtrai(6, 'lacUnidCarga', '', i04 + 1) <> '' do
            begin
              CTe.infCTeNorm.infDoc.InfOutros[i01].infUnidTransp[i02].infUnidCarga[i03].lacUnidCarga.Add;
              CTe.infCTeNorm.infDoc.InfOutros[i01].infUnidTransp[i02].infUnidCarga[i03].lacUnidCarga[i04].nLacre := Leitor.rCampo(tcStr, 'nLacre');
              inc(i04);
            end;

            inc(i03);
          end;

          inc(i02);
        end;

        i02 := 0;
        while Leitor.rExtrai(4, 'infUnidCarga', '', i02 + 1) <> '' do
        begin
          CTe.infCTeNorm.infDoc.InfOutros[i01].infUnidCarga.Add;
          CTe.infCTeNorm.infDoc.InfOutros[i01].infUnidCarga[i02].tpUnidCarga := StrToUnidCarga(ok, Leitor.rCampo(tcStr, 'tpUnidCarga'));
          CTe.infCTeNorm.infDoc.InfOutros[i01].infUnidCarga[i02].idUnidCarga := Leitor.rCampo(tcStr, 'idUnidCarga');
          CTe.infCTeNorm.infDoc.InfOutros[i01].infUnidCarga[i02].qtdRat      := Leitor.rCampo(tcDe2, 'qtdRat');

          i03 := 0;
          while Leitor.rExtrai(5, 'lacUnidCarga', '', i03 + 1) <> '' do
          begin
            CTe.infCTeNorm.infDoc.InfOutros[i01].infUnidCarga[i02].lacUnidCarga.Add;
            CTe.infCTeNorm.infDoc.InfOutros[i01].infUnidCarga[i02].lacUnidCarga[i03].nLacre := Leitor.rCampo(tcStr, 'nLacre');
            inc(i03);
          end;

          inc(i02);
        end;

        inc(i01);
      end;
    end;

    if Leitor.rExtrai(2, 'docAnt') <> ''
    then begin
      i01 := 0;
      while Leitor.rExtrai(3, 'emiDocAnt', '', i01 + 1) <> '' do
      begin
        CTe.infCTeNorm.docAnt.emiDocAnt.Add;
        CTe.infCTeNorm.docAnt.emiDocAnt[i01].CNPJCPF := Leitor.rCampoCNPJCPF;
        CTe.infCTeNorm.docAnt.emiDocAnt[i01].IE      := Leitor.rCampo(tcStr, 'IE');
        CTe.infCTeNorm.docAnt.emiDocAnt[i01].UF      := Leitor.rCampo(tcStr, 'UF');
        CTe.infCTeNorm.docAnt.emiDocAnt[i01].xNome   := Leitor.rCampo(tcStr, 'xNome');

        i02 := 0;
        while Leitor.rExtrai(4, 'idDocAnt', '', i02 + 1) <> '' do
        begin
          CTe.infCTeNorm.docAnt.emiDocAnt[i01].idDocAnt.Add;

          i03 := 0;
          while Leitor.rExtrai(5, 'idDocAntPap', '', i03 + 1) <> '' do
          begin
            CTe.infCTeNorm.docAnt.emiDocAnt[i01].idDocAnt[i02].idDocAntPap.Add;
            CTe.infCTeNorm.docAnt.emiDocAnt[i01].idDocAnt[i02].idDocAntPap[i03].tpDoc  := StrToTpDocumentoAnterior(ok, Leitor.rCampo(tcStr, 'tpDoc'));
            CTe.infCTeNorm.docAnt.emiDocAnt[i01].idDocAnt[i02].idDocAntPap[i03].serie  := Leitor.rCampo(tcStr, 'serie');
            CTe.infCTeNorm.docAnt.emiDocAnt[i01].idDocAnt[i02].idDocAntPap[i03].subser := Leitor.rCampo(tcStr, 'subser');
            CTe.infCTeNorm.docAnt.emiDocAnt[i01].idDocAnt[i02].idDocAntPap[i03].nDoc   := Leitor.rCampo(tcInt, 'nDoc');
            CTe.infCTeNorm.docAnt.emiDocAnt[i01].idDocAnt[i02].idDocAntPap[i03].dEmi   := Leitor.rCampo(tcDat, 'dEmi');
            inc(i03);
          end;

          i03 := 0;
          while Leitor.rExtrai(5, 'idDocAntEle', '', i03 + 1) <> '' do
          begin
            CTe.infCTeNorm.docAnt.emiDocAnt[i01].idDocAnt[i02].idDocAntEle.Add;
            CTe.infCTeNorm.docAnt.emiDocAnt[i01].idDocAnt[i02].idDocAntEle[i03].chave := Leitor.rCampo(tcStr, 'chave');
            inc(i03);
          end;
          inc(i02);
        end;
        inc(i01);
      end;
      //
    end;

    i01 := 0;
    while Leitor.rExtrai(2, 'seg', '', i01 + 1) <> '' do
    begin
      CTe.infCTeNorm.seg.Add;
      CTe.infCTeNorm.seg[i01].respSeg := StrToTpRspSeguro(ok, Leitor.rCampo(tcStr, 'respSeg'));
      CTe.infCTeNorm.seg[i01].xSeg    := Leitor.rCampo(tcStr, 'xSeg');
      CTe.infCTeNorm.seg[i01].nApol   := Leitor.rCampo(tcStr, 'nApol');
      CTe.infCTeNorm.seg[i01].nAver   := Leitor.rCampo(tcStr, 'nAver');
      CTe.infCTeNorm.seg[i01].vCarga  := Leitor.rCampo(tcDe2, 'vCarga');
      inc(i01);
    end;

    if Leitor.rExtrai(2, 'rodo') <> '' then
    begin
      CTe.infCTeNorm.rodo.RNTRC := Leitor.rCampo(tcStr,'RNTRC');
      CTe.infCTeNorm.rodo.dPrev := Leitor.rCampo(tcDat,'dPrev');
      CTe.infCTeNorm.rodo.lota  := StrToTpLotacao(ok, Leitor.rCampo(tcStr,'lota'));
      CTe.infCTeNorm.rodo.CIOT  := Leitor.rCampo(tcStr, 'CIOT');

      i01 := 0;
      while Leitor.rExtrai(3, 'occ', '', i01 + 1) <> '' do
      begin
        CTe.infCTeNorm.rodo.occ.Add;
        CTe.infCTeNorm.rodo.occ[i01].serie := Leitor.rCampo(tcStr, 'serie');
        CTe.infCTeNorm.rodo.occ[i01].nOcc  := Leitor.rCampo(tcInt, 'nOcc');
        CTe.infCTeNorm.rodo.occ[i01].dEmi  := Leitor.rCampo(tcDat, 'dEmi');

        if Leitor.rExtrai(4, 'emiOcc') <> '' then
        begin
          CTe.infCTeNorm.rodo.occ[i01].emiOcc.CNPJ := Leitor.rCampo(tcStr, 'CNPJ');
          CTe.infCTeNorm.rodo.occ[i01].emiOcc.cInt := Leitor.rCampo(tcStr, 'cInt');
          CTe.infCTeNorm.rodo.occ[i01].emiOcc.IE   := Leitor.rCampo(tcStr, 'IE');
          CTe.infCTeNorm.rodo.occ[i01].emiOcc.UF   := Leitor.rCampo(tcStr, 'UF');
          CTe.infCTeNorm.rodo.occ[i01].emiOcc.fone := Leitor.rCampo(tcStr, 'fone');
        end;
        inc(i01);
      end;

      i01 := 0;
      while Leitor.rExtrai(3, 'valePed', '', i01 + 1) <> '' do
      begin
        CTe.infCTeNorm.rodo.valePed.Add;
        CTe.infCTeNorm.rodo.valePed[i01].CNPJForn := Leitor.rCampo(tcStr, 'CNPJForn');
        CTe.infCTeNorm.rodo.valePed[i01].nCompra  := Leitor.rCampo(tcStr, 'nCompra');
        CTe.infCTeNorm.rodo.valePed[i01].CNPJPg   := Leitor.rCampo(tcStr, 'CNPJPg');
        inc(i01);
      end;

      i01 := 0;
      while Leitor.rExtrai(3, 'veic', '', i01 + 1) <> '' do
      begin
        CTe.infCTeNorm.rodo.veic.Add;
        CTe.infCTeNorm.rodo.veic[i01].cInt    := Leitor.rCampo(tcStr, 'cInt');
        CTe.infCTeNorm.rodo.veic[i01].RENAVAM := Leitor.rCampo(tcStr, 'RENAVAM');
        CTe.infCTeNorm.rodo.veic[i01].placa   := Leitor.rCampo(tcStr, 'placa');
        CTe.infCTeNorm.rodo.veic[i01].tara    := Leitor.rCampo(tcInt, 'tara');
        CTe.infCTeNorm.rodo.veic[i01].capKG   := Leitor.rCampo(tcInt, 'capKG');
        CTe.infCTeNorm.rodo.veic[i01].capM3   := Leitor.rCampo(tcInt, 'capM3');
        CTe.infCTeNorm.rodo.veic[i01].tpProp  := StrToTpPropriedade(ok, Leitor.rCampo(tcStr, 'tpProp'));
        CTe.infCTeNorm.rodo.veic[i01].tpVeic  := StrToTpVeiculo(ok, Leitor.rCampo(tcStr, 'tpVeic'));
        CTe.infCTeNorm.rodo.veic[i01].tpRod   := StrToTpRodado(ok, Leitor.rCampo(tcStr, 'tpRod'));
        CTe.infCTeNorm.rodo.veic[i01].tpCar   := StrToTpCarroceria(ok, Leitor.rCampo(tcStr, 'tpCar'));
        CTe.infCTeNorm.rodo.veic[i01].UF      := Leitor.rCampo(tcStr, 'UF');

        if Leitor.rExtrai(4, 'prop') <> '' then
        begin
          CTe.infCTeNorm.rodo.veic[i01].prop.CNPJCPF := Leitor.rCampoCNPJCPF;
          CTe.infCTeNorm.rodo.veic[i01].prop.RNTRC   := Leitor.rCampo(tcStr, 'RNTRC');
          CTe.infCTeNorm.rodo.veic[i01].prop.xNome   := Leitor.rCampo(tcStr, 'xNome');
          CTe.infCTeNorm.rodo.veic[i01].prop.IE      := Leitor.rCampo(tcStr, 'IE');
          CTe.infCTeNorm.rodo.veic[i01].prop.UF      := Leitor.rCampo(tcStr, 'UF');
          CTe.infCTeNorm.rodo.veic[i01].prop.tpProp  := StrToTpProp(ok, Leitor.rCampo(tcStr, 'tpProp'));
        end;
        inc(i01);
      end;

      i01 := 0;
      while Leitor.rExtrai(3, 'lacRodo', '', i01 + 1) <> '' do
      begin
        CTe.infCTeNorm.rodo.lacRodo.Add;
        CTe.infCTeNorm.rodo.lacRodo[i01].nLacre := Leitor.rCampo(tcStr, 'nLacre');
        inc(i01);
      end;

      i01 := 0;
      while Leitor.rExtrai(3, 'moto', '', i01 + 1) <> '' do
      begin
        CTe.infCTeNorm.Rodo.moto.Add;
        CTe.infCTeNorm.Rodo.moto[i01].xNome := Leitor.rCampo(tcStr, 'xNome');
        CTe.infCTeNorm.Rodo.moto[i01].CPF   := Leitor.rCampo(tcStr, 'CPF');
        inc(i01);
      end;

    end; // fim das informa��es do modal Rodovi�rio

    if Leitor.rExtrai(2, 'aereo') <> '' then
    begin
      CTe.infCTeNorm.aereo.nMinu      := Leitor.rCampo(tcInt,'nMinu');
      CTe.infCTeNorm.aereo.nOCA       := Leitor.rCampo(tcStr,'nOCA');
      CTe.infCTeNorm.aereo.dPrevAereo := Leitor.rCampo(tcDat,'dPrevAereo');
      CTe.infCTeNorm.aereo.xLAgEmi    := Leitor.rCampo(tcStr,'xLAgEmi');
      CTe.infCTeNorm.aereo.IdT        := Leitor.rCampo(tcStr,'IdT');

      if Leitor.rExtrai(3, 'tarifa') <> '' then
      begin
        CTe.infCTeNorm.aereo.tarifa.CL     := Leitor.rCampo(tcStr,'CL');
        CTe.infCTeNorm.aereo.tarifa.cTar   := Leitor.rCampo(tcStr,'cTar');
        CTe.infCTeNorm.aereo.tarifa.vTar   := Leitor.rCampo(tcDe2,'vTar');
      end;

      if Leitor.rExtrai(3, 'natCarga') <> '' then
       begin
         CTe.infCTeNorm.aereo.natCarga.xDime     := Leitor.rCampo(tcStr,'xDime');
         CTe.infCTeNorm.aereo.natCarga.cinfManu  := Leitor.rCampo(tcInt,'cInfManu');
         CTe.infCTeNorm.aereo.natCarga.cIMP      := Leitor.rCampo(tcStr,'cIMP');
       end;
    end; // fim das informa��es do modal A�reo

    if Leitor.rExtrai(2, 'aquav') <> '' then
    begin
      CTe.infCTeNorm.aquav.vPrest   := Leitor.rCampo(tcDe2,'vPrest');
      CTe.infCTeNorm.aquav.vAFRMM   := Leitor.rCampo(tcDe2,'vAFRMM');
      CTe.infCTeNorm.aquav.nBooking := Leitor.rCampo(tcStr,'nBooking');
      CTe.infCTeNorm.aquav.nCtrl    := Leitor.rCampo(tcStr,'nCtrl');
      CTe.infCTeNorm.aquav.xNavio   := Leitor.rCampo(tcStr,'xNavio');
      CTe.infCTeNorm.aquav.nViag    := Leitor.rCampo(tcStr,'nViag');
      CTe.infCTeNorm.aquav.direc    := StrToTpDirecao(ok, Leitor.rCampo(tcStr, 'direc'));
      CTe.infCTeNorm.aquav.prtEmb   := Leitor.rCampo(tcStr,'prtEmb');
      CTe.infCTeNorm.aquav.prtTrans := Leitor.rCampo(tcStr,'prtTrans');
      CTe.infCTeNorm.aquav.prtDest  := Leitor.rCampo(tcStr,'prtDest');
      CTe.infCTeNorm.aquav.tpNav    := StrToTpNavegacao(ok, Leitor.rCampo(tcStr, 'tpNav'));
      CTe.infCTeNorm.aquav.irin     := Leitor.rCampo(tcStr,'irin');

      i01 := 0;
      while Leitor.rExtrai(3, 'balsa', '', i01 + 1) <> '' do
      begin
        CTe.infCTeNorm.aquav.balsa.Add;
        CTe.infCTeNorm.aquav.balsa[i01].xBalsa := Leitor.rCampo(tcStr, 'xBalsa');
        inc(i01);
      end;
    end; // fim das informa��es do modal Aquavi�rio

    if Leitor.rExtrai(2, 'ferrov') <> '' then
    begin
      CTe.infCTeNorm.ferrov.tpTraf := StrToTpTrafego(ok, Leitor.rCampo(tcStr, 'tpTraf'));
      CTe.infCTeNorm.ferrov.fluxo  := Leitor.rCampo(tcStr,'fluxo');
      CTe.infCTeNorm.ferrov.idTrem := Leitor.rCampo(tcStr,'idTrem');
      CTe.infCTeNorm.ferrov.vFrete := Leitor.rCampo(tcDe2,'vFrete');

      if Leitor.rExtrai(3, 'trafMut') <> '' then
      begin
        CTe.infCTeNorm.ferrov.trafMut.respFat := StrToTrafegoMutuo(ok, Leitor.rCampo(tcStr, 'respFat'));
        CTe.infCTeNorm.ferrov.trafMut.ferrEmi := StrToTrafegoMutuo(ok, Leitor.rCampo(tcStr, 'ferrEmi'));
      end;

      i01 := 0;
      while Leitor.rExtrai(3, 'ferroEnv', '', i01 + 1) <> '' do
      begin
        CTe.infCTeNorm.ferrov.ferroEnv.Add;
        CTe.infCTeNorm.ferrov.ferroEnv[i01].CNPJ  := Leitor.rCampo(tcStr,'CNPJ');
        CTe.infCTeNorm.ferrov.ferroEnv[i01].cInt  := Leitor.rCampo(tcStr,'cInt');
        CTe.infCTeNorm.ferrov.ferroEnv[i01].IE    := Leitor.rCampo(tcStr,'IE');
        CTe.infCTeNorm.ferrov.ferroEnv[i01].xNome := Leitor.rCampo(tcStr,'xNome');

        if Leitor.rExtrai(4, 'enderFerro') <> '' then
        begin
          CTe.infCTeNorm.ferrov.ferroEnv[i01].EnderFerro.xLgr    := Leitor.rCampo(tcStr, 'xLgr');
          CTe.infCTeNorm.ferrov.ferroEnv[i01].EnderFerro.nro     := Leitor.rCampo(tcStr, 'nro');
          CTe.infCTeNorm.ferrov.ferroEnv[i01].EnderFerro.xCpl    := Leitor.rCampo(tcStr, 'xCpl');
          CTe.infCTeNorm.ferrov.ferroEnv[i01].EnderFerro.xBairro := Leitor.rCampo(tcStr, 'xBairro');
          CTe.infCTeNorm.ferrov.ferroEnv[i01].EnderFerro.cMun    := Leitor.rCampo(tcInt, 'cMun');
          CTe.infCTeNorm.ferrov.ferroEnv[i01].EnderFerro.xMun    := Leitor.rCampo(tcStr, 'xMun');
          CTe.infCTeNorm.ferrov.ferroEnv[i01].EnderFerro.CEP     := Leitor.rCampo(tcInt, 'CEP');
          CTe.infCTeNorm.ferrov.ferroEnv[i01].EnderFerro.UF      := Leitor.rCampo(tcStr, 'UF');
        end;
        inc(i01);
      end;

      i01 := 0;
      while Leitor.rExtrai(3, 'detVag', '', i01 + 1) <> '' do
      begin
        CTe.infCTeNorm.ferrov.detVag.Add;
        CTe.infCTeNorm.ferrov.detVag[i01].nVag   := Leitor.rCampo(tcInt, 'nVag');
        CTe.infCTeNorm.ferrov.detVag[i01].cap    := Leitor.rCampo(tcDe2, 'cap');
        CTe.infCTeNorm.ferrov.detVag[i01].tpVag  := Leitor.rCampo(tcStr, 'tpVag');
        CTe.infCTeNorm.ferrov.detVag[i01].pesoR  := Leitor.rCampo(tcDe2, 'pesoR');
        CTe.infCTeNorm.ferrov.detVag[i01].pesoBC := Leitor.rCampo(tcDe2, 'pesoBC');
        inc(i01);
      end;
    end; // fim das informa��es do modal Ferrovi�rio

    if Leitor.rExtrai(2, 'duto') <> '' then
    begin
      CTe.infCTeNorm.duto.vTar := Leitor.rCampo(tcDe6, 'vTar');
      CTe.infCTeNorm.duto.dIni := Leitor.rCampo(tcDat, 'dIni');
      CTe.infCTeNorm.duto.dFim := Leitor.rCampo(tcDat, 'dFim');
    end; // fim das informa��es do modal Dutovi�rio

    if Leitor.rExtrai(2, 'multimodal') <> '' then
    begin
      CTe.infCTeNorm.multimodal.COTM          := Leitor.rCampo(tcStr, 'COTM');
      CTe.infCTeNorm.multimodal.indNegociavel := StrToindNegociavel(ok, Leitor.rCampo(tcStr, 'indNegociavel'));
    end; // fim das informa��es do Multimodal

    i01 := 0;
    while Leitor.rExtrai(2, 'peri', '', i01 + 1) <> '' do
    begin
      CTe.infCTeNorm.peri.Add;
      CTe.infCTeNorm.peri[i01].nONU        := Leitor.rCampo(tcStr, 'nONU');
      CTe.infCTeNorm.peri[i01].xNomeAE     := Leitor.rCampo(tcStr, 'xNomeAE');
      CTe.infCTeNorm.peri[i01].xClaRisco   := Leitor.rCampo(tcStr, 'xClaRisco');
      CTe.infCTeNorm.peri[i01].grEmb       := Leitor.rCampo(tcStr, 'grEmb');
      CTe.infCTeNorm.peri[i01].qTotProd    := Leitor.rCampo(tcStr, 'qTotProd');
      CTe.infCTeNorm.peri[i01].qVolTipo    := Leitor.rCampo(tcStr, 'qVolTipo');
      CTe.infCTeNorm.peri[i01].pontoFulgor := Leitor.rCampo(tcStr, 'pontoFulgor');
      inc(i01);
    end;

    i01 := 0;
    while Leitor.rExtrai(2, 'veicNovos', '', i01 + 1) <> '' do
    begin
      CTe.infCTeNorm.veicNovos.Add;
      CTe.infCTeNorm.veicNovos[i01].chassi := Leitor.rCampo(tcStr, 'chassi');
      CTe.infCTeNorm.veicNovos[i01].cCor   := Leitor.rCampo(tcStr, 'cCor');
      CTe.infCTeNorm.veicNovos[i01].xCor   := Leitor.rCampo(tcStr, 'xCor');
      CTe.infCTeNorm.veicNovos[i01].cMod   := Leitor.rCampo(tcStr, 'cMod');
      CTe.infCTeNorm.veicNovos[i01].vUnit  := Leitor.rCampo(tcDe2, 'vUnit');
      CTe.infCTeNorm.veicNovos[i01].vFrete := Leitor.rCampo(tcDe2, 'vFrete');
      inc(i01);
    end;

    if Leitor.rExtrai(2, 'cobr') <> '' then
    begin
      CTe.infCTeNorm.cobr.fat.nFat  := Leitor.rCampo(tcStr, 'nFat');
      CTe.infCTeNorm.cobr.fat.vOrig := Leitor.rCampo(tcDe2, 'vOrig');
      CTe.infCTeNorm.cobr.fat.vDesc := Leitor.rCampo(tcDe2, 'vDesc');
      CTe.infCTeNorm.cobr.fat.vLiq  := Leitor.rCampo(tcDe2, 'vLiq');

      i01 := 0;
      while Leitor.rExtrai(3, 'dup', '', i01 + 1) <> '' do
      begin
        CTe.infCTeNorm.cobr.dup.Add;
        CTe.infCTeNorm.cobr.dup[i01].nDup  := Leitor.rCampo(tcStr, 'nDup');
        CTe.infCTeNorm.cobr.dup[i01].dVenc := Leitor.rCampo(tcDat, 'dVenc');
        CTe.infCTeNorm.cobr.dup[i01].vDup  := Leitor.rCampo(tcDe2, 'vDup');
        inc(i01);
      end;
    end;

    if Leitor.rExtrai(2, 'infCteSub') <> '' then
    begin
     CTe.infCTeNorm.infCTeSub.chCte := Leitor.rCampo(tcStr, 'chCte');
     if Leitor.rExtrai(3, 'tomaICMS') <> '' then
      begin
       CTe.infCTeNorm.infCTeSub.tomaICMS.refNFe := Leitor.rCampo(tcStr, 'refNFe');
       CTe.infCTeNorm.infCTeSub.tomaICMS.refCte := Leitor.rCampo(tcStr, 'refCte');
       if Leitor.rExtrai(4, 'refNF') <> '' then
        begin
         CTe.infCTeNorm.infCTeSub.tomaICMS.refNF.CNPJCPF  := Leitor.rCampoCNPJCPF;
         CTe.infCTeNorm.infCTeSub.tomaICMS.refNF.modelo   := Leitor.rCampo(tcStr, 'mod');
         CTe.infCTeNorm.infCTeSub.tomaICMS.refNF.serie    := Leitor.rCampo(tcInt, 'serie');
         CTe.infCTeNorm.infCTeSub.tomaICMS.refNF.subserie := Leitor.rCampo(tcInt, 'subserie');
         CTe.infCTeNorm.infCTeSub.tomaICMS.refNF.nro      := Leitor.rCampo(tcInt, 'nro');
         CTe.infCTeNorm.infCTeSub.tomaICMS.refNF.valor    := Leitor.rCampo(tcDe2, 'valor');
         CTe.infCTeNorm.infCTeSub.tomaICMS.refNF.dEmi     := Leitor.rCampo(tcDat, 'dEmi');
        end;
      end;
     if Leitor.rExtrai(3, 'tomaNaoICMS') <> '' then
      begin
       CTe.infCTeNorm.infCTeSub.tomaNaoICMS.refCteAnu := Leitor.rCampo(tcStr, 'refCteAnu');
      end;
    end;
  end; // fim do infCTeNorm

  (* Grupo da TAG <infCteComp> ************************************************)
  if Leitor.rExtrai(1, 'infCteComp') <> ''
  then begin
    CTe.InfCTeComp.Chave := Leitor.rCampo(tcStr, 'chave');

    if Leitor.rExtrai(2, 'vPresComp') <> ''
    then begin
      CTe.infCTeComp.vPresComp.vTPrest := Leitor.rCampo(tcDe2,'vTPrest');

      i01 := 0;
      while Leitor.rExtrai(3, 'compComp', '', i01 + 1) <> '' do
      begin
        CTe.InfCTeComp.vPresComp.compComp.Add;
        CTe.InfCTeComp.vPresComp.compComp[i01].xNome := Leitor.rCampo(tcStr, 'xNome');
        CTe.InfCTeComp.vPresComp.compComp[i01].vComp := Leitor.rCampo(tcDe2, 'vComp');
        inc(i01);
      end;
    end;

    if Leitor.rExtrai(2, 'impComp') <> '' then
    begin
      CTe.InfCTeComp.impComp.vTotTrib   := Leitor.rCampo(tcDe2,'vTotTrib');
      CTe.InfCTeComp.impComp.InfAdFisco := Leitor.rCampo(tcStr,'infAdFisco');

      if Leitor.rExtrai(3, 'ICMSComp') <> '' then
      begin
        if Leitor.rExtrai(4, 'ICMS00') <> '' then
        begin
          if Leitor.rCampo(tcStr,'CST')='00'
          then begin
            CTe.InfCTeComp.impComp.ICMSComp.SituTrib     := cst00;
            CTe.InfCTeComp.impComp.ICMSComp.ICMS00.CST   := StrToCSTICMS(ok, Leitor.rCampo(tcStr,'CST'));
            CTe.InfCTeComp.impComp.ICMSComp.ICMS00.vBC   := Leitor.rCampo(tcDe2,'vBC');
            CTe.InfCTeComp.impComp.ICMSComp.ICMS00.pICMS := Leitor.rCampo(tcDe2,'pICMS');
            CTe.InfCTeComp.impComp.ICMSComp.ICMS00.vICMS := Leitor.rCampo(tcDe2,'vICMS');
          end;
        end;

        if Leitor.rExtrai(4, 'ICMS20') <> '' then
        begin
          if Leitor.rCampo(tcStr,'CST')='20'
          then begin
            CTe.InfCTeComp.impComp.ICMSComp.SituTrib      := cst20;
            CTe.InfCTeComp.impComp.ICMSComp.ICMS20.CST    := StrToCSTICMS(ok, Leitor.rCampo(tcStr,'CST'));
            CTe.InfCTeComp.impComp.ICMSComp.ICMS20.pRedBC := Leitor.rCampo(tcDe2,'pRedBC');
            CTe.InfCTeComp.impComp.ICMSComp.ICMS20.vBC    := Leitor.rCampo(tcDe2,'vBC');
            CTe.InfCTeComp.impComp.ICMSComp.ICMS20.pICMS  := Leitor.rCampo(tcDe2,'pICMS');
            CTe.InfCTeComp.impComp.ICMSComp.ICMS20.vICMS  := Leitor.rCampo(tcDe2,'vICMS');
          end;
        end;

        if Leitor.rExtrai(4, 'ICMS45') <> '' then
        begin
          if (Leitor.rCampo(tcStr,'CST')='40') or
             (Leitor.rCampo(tcStr,'CST')='41') or
             (Leitor.rCampo(tcStr,'CST')='51')
          then begin
            CTe.InfCTeComp.impComp.ICMSComp.SituTrib   := StrToCSTICMS(ok, Leitor.rCampo(tcStr,'CST'));
            CTe.InfCTeComp.impComp.ICMSComp.ICMS45.CST := StrToCSTICMS(ok, Leitor.rCampo(tcStr,'CST'));
          end;
        end;

        if Leitor.rExtrai(4, 'ICMS60') <> '' then
        begin
          if Leitor.rCampo(tcStr,'CST')='60'
          then begin
            CTe.InfCTeComp.impComp.ICMSComp.SituTrib          := cst60;
            CTe.InfCTeComp.impComp.ICMSComp.ICMS60.CST        := StrToCSTICMS(ok, Leitor.rCampo(tcStr,'CST'));
            CTe.InfCTeComp.impComp.ICMSComp.ICMS60.vBCSTRet   := Leitor.rCampo(tcDe2,'vBCSTRet');
            CTe.InfCTeComp.impComp.ICMSComp.ICMS60.vICMSSTRet := Leitor.rCampo(tcDe2,'vICMSSTRet');
            CTe.InfCTeComp.impComp.ICMSComp.ICMS60.pICMSSTRet := Leitor.rCampo(tcDe2,'pICMSSTRet');
            CTe.InfCTeComp.impComp.ICMSComp.ICMS60.vCred      := Leitor.rCampo(tcDe2,'vCred');
          end;
        end;

        if Leitor.rExtrai(4, 'ICMS90') <> '' then
        begin
          if Leitor.rCampo(tcStr,'CST')='90'
          then begin
            CTe.InfCTeComp.impComp.ICMSComp.SituTrib      := cst90;
            CTe.InfCTeComp.impComp.ICMSComp.ICMS90.CST    := StrToCSTICMS(ok, Leitor.rCampo(tcStr,'CST'));
            CTe.InfCTeComp.impComp.ICMSComp.ICMS90.pRedBC := Leitor.rCampo(tcDe2,'pRedBC');
            CTe.InfCTeComp.impComp.ICMSComp.ICMS90.vBC    := Leitor.rCampo(tcDe2,'vBC');
            CTe.InfCTeComp.impComp.ICMSComp.ICMS90.pICMS  := Leitor.rCampo(tcDe2,'pICMS');
            CTe.InfCTeComp.impComp.ICMSComp.ICMS90.vICMS  := Leitor.rCampo(tcDe2,'vICMS');
            CTe.InfCTeComp.impComp.ICMSComp.ICMS90.vCred  := Leitor.rCampo(tcDe2,'vCred');
          end;
        end;

        if Leitor.rExtrai(4, 'ICMSOutraUF') <> '' then
        begin
          if Leitor.rCampo(tcStr,'CST')='90'
          then begin
            // ICMS devido � UF de origem da presta��o, quando diferente da UF do emitente
            CTe.InfCTeComp.impComp.ICMSComp.SituTrib                  := cstICMSOutraUF;
            CTe.InfCTeComp.impComp.ICMSComp.ICMSOutraUF.CST           := StrToCSTICMS(ok, Leitor.rCampo(tcStr,'CST'));
            CTe.InfCTeComp.impComp.ICMSComp.ICMSOutraUF.pRedBCOutraUF := Leitor.rCampo(tcDe2,'pRedBCOutraUF');
            CTe.InfCTeComp.impComp.ICMSComp.ICMSOutraUF.vBCOutraUF    := Leitor.rCampo(tcDe2,'vBCOutraUF');
            CTe.InfCTeComp.impComp.ICMSComp.ICMSOutraUF.pICMSOutraUF  := Leitor.rCampo(tcDe2,'pICMSOutraUF');
            CTe.InfCTeComp.impComp.ICMSComp.ICMSOutraUF.vICMSOutraUF  := Leitor.rCampo(tcDe2,'vICMSOutraUF');
          end;
        end;

        if Leitor.rExtrai(4, 'ICMSSN') <> '' then
        begin
         // ICMS Simples Nacional
         CTe.InfCTeComp.impComp.ICMSComp.SituTrib     := cstICMSSN;
         CTe.InfCTeComp.impComp.ICMSComp.ICMSSN.indSN := Leitor.rCampo(tcInt,'indSN');
        end;
      end;
    end;
  end; // fim de infCteComp

  (* Grupo da TAG <infCteAnu> ************************************************)
  if Leitor.rExtrai(1, 'infCteAnu') <> '' then
  begin
    CTe.InfCTeAnu.chCTe := Leitor.rCampo(tcStr,'chCte');
    CTe.InfCTeAnu.dEmi  := Leitor.rCampo(tcDat,'dEmi');
  end;

  (* Grupo da TAG <autXML> ****************************************************)
  i01 := 0;
  while Leitor.rExtrai(1, 'autXML', '', i01 + 1) <> '' do
  begin
    CTe.autXML.Add;
    CTe.autXML[i01].CNPJCPF := Leitor.rCampoCNPJCPF;;
    inc(i01);
  end;

  (* Grupo da TAG <signature> *************************************************)

  Leitor.Grupo := Leitor.Arquivo;

  CTe.signature.URI             := Leitor.rAtributo('Reference URI=');
  CTe.signature.DigestValue     := Leitor.rCampo(tcStr, 'DigestValue');
  CTe.signature.SignatureValue  := Leitor.rCampo(tcStr, 'SignatureValue');
  CTe.signature.X509Certificate := Leitor.rCampo(tcStr, 'X509Certificate');

  (* Grupo da TAG <protCTe> ****************************************************)
  if Leitor.rExtrai(1, 'protCTe') <> '' then
  begin
    CTe.procCTe.tpAmb    := StrToTpAmb(ok, Leitor.rCampo(tcStr, 'tpAmb'));
    CTe.procCTe.verAplic := Leitor.rCampo(tcStr, 'verAplic');
    CTe.procCTe.chCTe    := Leitor.rCampo(tcStr, 'chCTe');
    CTe.procCTe.dhRecbto := Leitor.rCampo(tcDatHor, 'dhRecbto');
    CTe.procCTe.nProt    := Leitor.rCampo(tcStr, 'nProt');
    CTe.procCTe.digVal   := Leitor.rCampo(tcStr, 'digVal');
    CTe.procCTe.cStat    := Leitor.rCampo(tcInt, 'cStat');
    CTe.procCTe.xMotivo  := Leitor.rCampo(tcStr, 'xMotivo');
  end;

  Result := true;
end;
{$ENDIF}

end.

