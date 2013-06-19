unit pnfsConversao;

interface

uses
  SysUtils,
  {$IFNDEF VER130}
    Variants,
  {$ENDIF}
  Classes, pcnConversao;

type
  TStatusACBrNFSe = ( stNFSeIdle, stNFSeRecepcao, stNFSeConsulta, stNFSeCancelamento, stNFSeEmail );
  TLayOut = (LayNfseRecepcaoLote, LayNfseConsultaLote, LayNfseConsultaNfseRps, LayNfseConsultaSitLoteRps,
             LayNfseConsultaNfse, LayNfseCancelaNfse, LayNfseGerar, LayNfseRecepcaoLoteSincrono);

  TnfseTagAssinatura = ( taSempre, taNunca, taSomenteSeAssinada, taSomenteParaNaoAssinada );
  TnfsePadraoLayout = ( plABRASF );
  TnfseStatusRPS = ( srNormal, srCancelado );
  TnfseStatusNFSe = ( snNormal, snCancelado );

  TnfseNaturezaOperacao = ( noTributacaoNoMunicipio, noTributacaoForaMunicipio, noIsencao, noImune,
                            noSuspensaDecisaoJudicial, noSuspensaProcedimentoAdministrativo,
                            noNaoIncidencia,
                            noTributacaoNoMunicipio51, noTributacaoNoMunicipioSemISS52, noNaoTributa58,
                            noSimplesNacional59, noTributacaoNoMunicipio61, noTributacaoNoMunicipioSemISS62,
                            noTributacaoForaMunicipio63, noTributacaoForaMunicipioSemISS64,
                            noNaoTributa68, noSimplesNacional69, noNaoTributa78 );

  TnfseExigibilidadeISS = ( exiExigivel, exiNaoIncidencia, exiIsencao, exiExportacao, exiImunidade,
                            exiSuspensaDecisaoJudicial, exiSuspensaProcessoAdministrativo );

  TnfseRegimeEspecialTributacao = ( retNenhum, retMicroempresaMunicipal, retEstimativa, retSociedadeProfissionais, retCooperativa,
                                    retMicroempresarioIndividual, retMicroempresarioEmpresaPP );
  TnfseSimNao = ( snSim, snNao );
  TnfseTipoRPS = ( trRPS, trNFConjugada, trCupom );
  TnfseIndicacaoCpfCnpj = ( iccCPF, iccCNPJ, iccNaoInformado );
  TnfseSituacaoLoteRPS = ( slrNaoRecibo, slrNaoProcessado, slrProcessadoErro, slrProcessadoSucesso );

  TnfseProvedor = ( proNenhum, proTiplan, proISSNET, proWebISS, proGINFES, proDSF, proProdemge, proAbaco, proBetha,
                    proEquiplano, proISSIntel, proProdam, proGovBR, proRecife, proSimplISS, proThema, proRJ,
                    proPublica, profintelISS, proDigifred, proBetim, proSaatri, proFISSLEX,
                    proGoiania, proIssCuritiba, proBHISS, proNatal, proISSDigital, proISSe, pro4R,
                    proGovDigital, proFiorilli );

  TnfseAcao = ( acRecepcionar, acConsSit, acConsLote, acConsNFSeRps, acConsNFSe, acCancelar, acGerar, acRecSincrono );

  TnfseSituacaoTributaria = ( stRetencao, stNormal, stSubstituicao );

  TnfseResponsavelRetencao = ( rtPrestador, ptTomador );

function PadraoLayoutToStr(const t: TnfsePadraoLayout):string;
function StrToPadraoLayout(var ok: boolean; const s: string):TnfsePadraoLayout;

function StatusRPSToStr(const t: TnfseStatusRPS):string;
function StrToStatusRPS(var ok: boolean; const s: string):TnfseStatusRPS;

function StatusNFSeToStr(const t: TnfseStatusNFSe):string;
function StrToStatusNFSe(var ok: boolean; const s: string):TnfseStatusNFSe;

function NaturezaOperacaoToStr(const t: TnfseNaturezaOperacao):string;
function StrToNaturezaOperacao(var ok: boolean; const s: string):TnfseNaturezaOperacao;

function ExigibilidadeISSToStr(const t: TnfseExigibilidadeISS):string;
function StrToExigibilidadeISS(var ok: boolean; const s: string):TnfseExigibilidadeISS;

function RegimeEspecialTributacaoToStr(const t: TnfseRegimeEspecialTributacao):string;
function StrToRegimeEspecialTributacao(var ok: boolean; const s: string):TnfseRegimeEspecialTributacao;

function SimNaoToStr(const t: TnfseSimNao):string;
function StrToSimNao(var ok: boolean; const s: string):TnfseSimNao;

function TipoRPSToStr(const t: TnfseTipoRPS):string;
function StrToTipoRPS(var ok: boolean; const s: string):TnfseTipoRPS;

function IndicacaoCpfCnpjToStr(const t: TnfseIndicacaoCpfCnpj):string;
function StrToIndicacaoCpfCnpj(var ok: boolean; const s: string):TnfseIndicacaoCpfCnpj;

function SituacaoLoteRPSToStr(const t: TnfseSituacaoLoteRPS):string;
function StrToSituacaoLoteRPS(var ok: boolean; const s: string):TnfseSituacaoLoteRPS;

function ProvedorToStr(const t: TnfseProvedor):string;
function StrToProvedor(var ok: boolean; const s: string):TnfseProvedor;

function CodigoToDesc(const s: string): ansistring;
function CodCidadeToProvedor(const ACodigo: Integer): string;
function CodCidadeToCidade(const ACodigo: Integer): string;

function SituacaoTributariaToStr(const t: TnfseSituacaoTributaria):string;
function StrToSituacaoTributaria(var ok: boolean; const s: string):TnfseSituacaoTributaria;

function ResponsavelRetencaoToStr(const t: TnfseResponsavelRetencao):string;
function StrToResponsavelRetencao(var ok: boolean; const s: string):TnfseResponsavelRetencao;

implementation

// Padrao Layout ***************************************************************

function PadraoLayoutToStr(const t: TnfsePadraoLayout):string;
begin
  result := EnumeradoToStr(t,
                           ['1'],
                           [plABRASF]);
end;

function StrToPadraoLayout(var ok: boolean; const s: string):TnfsePadraoLayout;
begin
  result := StrToEnumerado(ok, s,
                           ['1'],
                           [plABRASF]);
end;

// Status RPS ******************************************************************

function StatusRPSToStr(const t: TnfseStatusRPS):string;
begin
  result := EnumeradoToStr(t,
                           ['1','2'],
                           [srNormal, srCancelado]);
end;

function StrToStatusRPS(var ok: boolean; const s: string):TnfseStatusRPS;
begin
  result := StrToEnumerado(ok, s,
                           ['1','2'],
                           [srNormal, srCancelado]);
end;

// Status NFSe *****************************************************************

function StatusNFSeToStr(const t: TnfseStatusNFSe):string;
begin
  result := EnumeradoToStr(t,
                           ['1','2'],
                           [srNormal, srCancelado]);
end;

function StrToStatusNFSe(var ok: boolean; const s: string):TnfseStatusNFSe;
begin
  result := StrToEnumerado(ok, s,
                           ['1','2'],
                           [snNormal, snCancelado]);
end;

// Natureza Opera��o ***********************************************************

function NaturezaOperacaoToStr(const t: TnfseNaturezaOperacao):string;
begin
  result := EnumeradoToStr(t,
                           ['1','2','3','4','5','6','7',
                            '51','52','58','59','61','62','63','64','68','69','78'],
                           [noTributacaoNoMunicipio, noTributacaoForaMunicipio,
                            noIsencao, noImune, noSuspensaDecisaoJudicial,
                            noSuspensaProcedimentoAdministrativo,
                            noNaoIncidencia,
                            noTributacaoNoMunicipio51, noTributacaoNoMunicipioSemISS52,
                            noNaoTributa58, noSimplesNacional59, noTributacaoNoMunicipio61,
                            noTributacaoNoMunicipioSemISS62, noTributacaoForaMunicipio63,
                            noTributacaoForaMunicipioSemISS64,
                            noNaoTributa68, noSimplesNacional69, noNaoTributa78]);
end;

function StrToNaturezaOperacao(var ok: boolean; const s: string):TnfseNaturezaOperacao;
begin
  result := StrToEnumerado(ok, s,
                          ['1','2','3','4','5','6','7',
                           '51','52','58','59','61','62','63','64','68','69','78'],
                          [noTributacaoNoMunicipio, noTributacaoForaMunicipio,
                           noIsencao, noImune, noSuspensaDecisaoJudicial,
                           noSuspensaProcedimentoAdministrativo,
                           noNaoIncidencia,
                           noTributacaoNoMunicipio51, noTributacaoNoMunicipioSemISS52,
                           noNaoTributa58, noSimplesNacional59, noTributacaoNoMunicipio61,
                           noTributacaoNoMunicipioSemISS62, noTributacaoForaMunicipio63,
                           noTributacaoForaMunicipioSemISS64,
                           noNaoTributa68, noSimplesNacional69, noNaoTributa78]);
end;

// Exigibilidade ISS ***********************************************************

function ExigibilidadeISSToStr(const t: TnfseExigibilidadeISS):string;
begin
  result := EnumeradoToStr(t,
                           ['1','2','3','4','5','6','7'],
                           [exiExigivel, exiNaoIncidencia, exiIsencao, exiExportacao, exiImunidade,
                            exiSuspensaDecisaoJudicial, exiSuspensaProcessoAdministrativo]);
end;

function StrToExigibilidadeISS(var ok: boolean; const s: string):TnfseExigibilidadeISS;
begin
  result := StrToEnumerado(ok, s,
                          ['1','2','3','4','5','6','7'],
                           [exiExigivel, exiNaoIncidencia, exiIsencao, exiExportacao, exiImunidade,
                            exiSuspensaDecisaoJudicial, exiSuspensaProcessoAdministrativo]);
end;

// Regime Especial de Tributa��o ***********************************************

function RegimeEspecialTributacaoToStr(const t: TnfseRegimeEspecialTributacao):string;
begin
  result := EnumeradoToStr(t,
                           ['0','1','2','3','4','5','6'],
                           [retNenhum, retMicroempresaMunicipal, retEstimativa,
                            retSociedadeProfissionais, retCooperativa,
                            retMicroempresarioIndividual, retMicroempresarioEmpresaPP]);
end;

function StrToRegimeEspecialTributacao(var ok: boolean; const s: string):TnfseRegimeEspecialTributacao;
begin
  result := StrToEnumerado(ok, s,
                          ['0','1','2','3','4','5','6'],
                          [retNenhum, retMicroempresaMunicipal, retEstimativa,
                           retSociedadeProfissionais, retCooperativa,
                           retMicroempresarioIndividual, retMicroempresarioEmpresaPP]);
end;

// Sim/Nao *********************************************************************

function SimNaoToStr(const t: TnfseSimNao):string;
begin
  result := EnumeradoToStr(t,
                           ['1','2'],
                           [snSim, snNao]);
end;

function StrToSimNao(var ok: boolean; const s: string):TnfseSimNao;
begin
  result := StrToEnumerado(ok, s,
                           ['1','2'],
                           [snSim, snNao]);
end;

// Tipo RPS ********************************************************************

function TipoRPSToStr(const t: TnfseTipoRPS):string;
begin
  result := EnumeradoToStr(t,
                           ['1','2','3'],
                           [trRPS, trNFConjugada, trCupom]);
end;

function StrToTipoRPS(var ok: boolean; const s: string):TnfseTipoRPS;
begin
  result := StrToEnumerado(ok, s,
                           ['1','2','3'],
                           [trRPS, trNFConjugada, trCupom]);
end;

// Indicacao CPF/CNPJ **********************************************************

function IndicacaoCpfCnpjtoStr(const t: TnfseIndicacaoCpfCnpj):string;
begin
  result := EnumeradoToStr(t,
                           ['1','2','3'],
                           [iccCPF, iccCNPJ, iccNaoInformado]);
end;

function StrToIndicacaoCpfCnpj(var ok: boolean; const s: string):TnfseIndicacaoCpfCnpj;
begin
  result := StrToEnumerado(ok, s,
                           ['1','2','3'],
                           [iccCPF, iccCNPJ, iccNaoInformado]);
end;

// Situacao Lote Rps ***********************************************************

function SituacaoLoteRPSToStr(const t: TnfseSituacaoLoteRPS):string;
begin
  result := EnumeradoToStr(t,
                           ['1','2','3','4'],
                           [slrNaoRecibo, slrNaoProcessado, slrProcessadoErro,
                            slrProcessadoSucesso]);
end;

function StrToSituacaoLoteRPS(var ok: boolean; const s: string):TnfseSituacaoLoteRPS;
begin
  result := StrToEnumerado(ok, s,
                           ['1','2','3','4'],
                           [slrNaoRecibo, slrNaoProcessado, slrProcessadoErro,
                            slrProcessadoSucesso]);
end;

// Provedor ********************************************************************

function ProvedorToStr(const t: TnfseProvedor):string;
begin
  result := EnumeradoToStr(t,
                           ['Nenhum', 'Tiplan', 'ISSNET', 'WebISS', 'GINFES', 'DSF', 'Prodemge', 'Abaco',
                            'Betha', 'Equiplano', 'ISSIntel', 'Prodam', 'GovBR', 'Recife',
                            'SimplISS', 'Thema', 'RJ', 'Publica', 'fintelISS', 'Digifred', 'Betim', 'Saatri',
                            'FISSLEX', 'Goiania', 'IssCuritiba', 'BHISS', 'Natal', 'ISSDigital', 'ISSe',
                            '4R', 'GovDigital', 'Fiorilli'],
                           [proNenhum, proTiplan, proISSNET, proWebISS, proGINFES, proDSF, proProdemge, proAbaco,
                            proBetha, proEquiplano, proISSIntel, proProdam, proGovBR, proRecife,
                            proSimplISS, proThema, proRJ, proPublica, profintelISS, proDigifred, proBetim,
                            proSaatri, proFISSLEX, proGoiania, proIssCuritiba, proBHISS, proNatal,
                            proISSDigital, proISSe, pro4R, proGovDigital, proFiorilli]);
end;

function StrToProvedor(var ok: boolean; const s: string):TnfseProvedor;
begin
  result := StrToEnumerado(ok, s,
                           ['Nenhum', 'Tiplan', 'ISSNET', 'WebISS', 'GINFES', 'DSF', 'Prodemge', 'Abaco',
                            'Betha', 'Equiplano', 'ISSIntel', 'Prodam', 'GovBR', 'Recife',
                            'SimplISS', 'Thema', 'RJ', 'Publica', 'fintelISS', 'Digifred', 'Betim', 'Saatri',
                            'FISSLEX', 'Goiania', 'IssCuritiba', 'BHISS', 'Natal', 'ISSDigital', 'ISSe',
                            '4R', 'GovDigital', 'Fiorilli'],
                           [proNenhum, proTiplan, proISSNET, proWebISS, proGINFES, proDSF, proProdemge, proAbaco,
                            proBetha, proEquiplano, proISSIntel, proProdam, proGovBR, proRecife,
                            proSimplISS, proThema, proRJ, proPublica, profintelISS, proDigifred, proBetim,
                            proSaatri, proFISSLEX, proGoiania, proIssCuritiba, proBHISS, proNatal,
                            proISSDigital, proISSe, pro4R, proGovDigital, proFiorilli]);
end;

// Descri��o do Servi�o ********************************************************

function CodigotoDesc(const s: string): ansistring;
var
 i: Integer;
 r: ansistring;
begin
  i := StrToInt(copy(s, 1, 2) + copy(s, 4, 2));
  r := '';
  case i of
  0101: r := 'Analise e desenvolvimento de sistemas.';
  0102: r := 'Programacao.';
  0103: r := 'Processamento de dados e congeneres.';
  0104: r := 'Elaboracao de programas de computadores, inclusive de jogos eletronicos.';
  0105: r := 'Licenciamento ou cessao de direito de uso de programas de computacao.';
  0106: r := 'Assessoria e consultoria em informatica.';
  0107: r := 'Suporte tecnico em informatica, inclusive instalacao, configuracao e manutencao de programas de computacao e bancos de dados.';
  0108: r := 'Planejamento, confeccao, manutencao e atualizacao de paginas eletronicas.';
  0201: r := 'Servicos de pesquisas e desenvolvimento de qualquer natureza.';
  0301: r := '(VETADO)';
  0302: r := 'Cessao de direito de uso de marcas e de sinais de propaganda.';
  0303: r := 'Exploracao de saloes de festas, centro de convencoes, escritorios virtuais, stands,quadras esportivas, estadios, ' +
             'ginasios, auditorios, casas de espetaculos, parques de diversoes, canchas e congeneres, para realizacao de eventos ou negocios de qualquer natureza.';
  0304: r := 'Locacao, sublocacao, arrendamento, direito de passagem ou permissao de uso, compartilhado ou nao, de ferrovia, rodovia, postes, cabos, dutos e condutos de qualquer natureza.';
  0305: r := 'Cessao de andaimes, palcos, coberturas e outras estruturas de uso temporario.';
  0401: r := 'Medicina e biomedicina.';
  0402: r := 'Analises clinicas, patologia, eletricidade medica, radioterapia, quimioterapia, ultra-sonografia, ressonancia magnetica, radiologia, tomografia e congeneres.';
  0403: r := 'Hospitais, clinicas, laboratorios, sanatorios, manicomios, casas de saude, prontos-socorros, ambulatorios e congeneres.';
  0404: r := 'Instrumentacao cirurgica.';
  0405: r := 'Acupuntura.';
  0406: r := 'Enfermagem, inclusive servicos auxiliares.';
  0407: r := 'Servicos farmaceuticos.';
  0408: r := 'Terapia ocupacional, fisioterapia e fonoaudiologia.';
  0409: r := 'Terapias de qualquer especie destinadas ao tratamento fisico, organico e mental.';
  0410: r := 'Nutricao.';
  0411: r := 'Obstetricia.';
  0412: r := 'Odontologia.';
  0413: r := 'Ortoptica.';
  0414: r := 'Proteses sob encomenda.';
  0415: r := 'Psicanalise.';
  0416: r := 'Psicologia.';
  0417: r := 'Casas de repouso e de recuperacao, creches, asilos e congeneres.';
  0418: r := 'Inseminacao artificial, fertilizacao in vitro e congeneres.';
  0419: r := 'Bancos de sangue, leite, pele, olhos, ovulos, semen e congeneres.';
  0420: r := 'Coleta de sangue, leite, tecidos, semen, orgaos e materiais biologicos de qualquer especie.';
  0421: r := 'Unidade de atendimento, assistencia ou tratamento movel, e congeneres.';
  0422: r := 'Planos de medicina de grupo ou individual e convenios para prestacao de assistencia medica, hospitalar, odontologica e congeneres.';
  0423: r := 'Outros planos de saude que se cumpram atraves de servicos de terceiros contratados, credenciados, cooperados ou apenas pagos pelo operador do plano mediante indicacao do beneficiario.';
  0501: r := 'Medicina veterinaria e zootecnia.';
  0502: r := 'Hospitais, clinicas, ambulatorios, prontos-socorros e congeneres, na area veterinaria.';
  0503: r := 'Laboratorios de analise na area veterinaria.';
  0504: r := 'Inseminacao artificial, fertilizacao in vitro e congeneres.';
  0505: r := 'Bancos de sangue e de orgaos e congeneres.';
  0506: r := 'Coleta de sangue, leite, tecidos, semen, orgaos e materiais biologicos de qualquer especie.';
  0507: r := 'Unidade de atendimento, assistencia ou tratamento movel e congeneres.';
  0508: r := 'Guarda, tratamento, amestramento, embelezamento, alojamento e congeneres.';
  0509: r := 'Planos de atendimento e assistencia medico-veterinaria.';
  0601: r := 'Barbearia, cabeleireiros, manicuros, pedicuros e congeneres.';
  0602: r := 'Esteticistas, tratamento de pele, depilacao e congeneres.';
  0603: r := 'Banhos, duchas, sauna, massagens e congeneres.';
  0604: r := 'Ginastica, danca, esportes, natacao, artes marciais e demais atividades fisicas.';
  0605: r := 'Centros de emagrecimento, spa e congeneres.';
  0701: r := 'Engenharia, agronomia, agrimensura, arquitetura, geologia, urbanismo, paisagismo e congeneres.';
  0702: r := 'Execucao, por administracao, empreitada ou subempreitada, de obras de construcao civil, hidraulica ou eletrica e de ' +
             'outras obras semelhantes, inclusive sondagem, perfuracao de pocos, escavacao, drenagem e irrigacao, terraplanagem, ' +
             'pavimentacao, concretagem e a instalacao e montagem de produtos, pecas e equipamentos (exceto o fornecimento de mercadorias produzidas pelo prestador de servicos fora do local da prestacao dos servicos, que fica sujeito ao ICMS).';
  0703: r := 'Elaboracao de planos diretores, estudos de viabilidade, estudos organizacionais e outros, relacionados com obras e servicos de engenharia; elaboracao de anteprojetos, projetos basicos e projetos executivos para trabalhos de engenharia.';
  0704: r := 'Demolicao.';
  0705: r := 'Reparacao, conservacao e reforma de edificios, estradas, pontes, portos e congeneres (exceto o fornecimento de mercadorias produzidas pelo prestador dos servicos, fora do local da prestacao dos servicos, que fica sujeito ao ICMS).';
  0706: r := 'Colocacao e instalacao de tapetes, carpetes, assoalhos, cortinas, revestimentos de parede, vidros, divisorias, placas de gesso e congeneres, com material fornecido pelo tomador do servico.';
  0707: r := 'Recuperacao, raspagem, polimento e lustracao de pisos e congeneres.';
  0708: r := 'Calafetacao.';
  0709: r := 'Varricao, coleta, remocao, incineracao, tratamento, reciclagem, separacao e destinacao final de lixo, rejeitos e outros residuos Quaisquer. a) reciclagem b) demais casos.';
  0710: r := 'Limpeza, manutencao e conservacao de vias e logradouros publicos, imoveis, chamines, piscinas, parques, jardins e congeneres.';
  0711: r := 'Decoracao e jardinagem, inclusive corte e poda de arvores.';
  0712: r := 'Controle e tratamento de efluentes de qualquer natureza e de agentes fisicos, quimicos e biologicos.';
  0713: r := 'Dedetizacao, desinfeccao, desinsetizacao, imunizacao, higienizacao, desratizacao, pulverizacao e congeneres.';
  0714: r := '(VETADO)';
  0715: r := '(VETADO)';
  0716: r := 'Florestamento, reflorestamento, semeadura, adubacao e congeneres.';
  0717: r := 'Escoramento, contencao de encostas e servicos congeneres.';
  0718: r := 'Limpeza e dragagem de rios, portos, canais, baias, lagos, lagoas, represas, acudes e congeneres.';
  0719: r := 'Acompanhamento e fiscalizacao da execucao de obras de engenharia, arquitetura e urbanismo.';
  0720: r := 'Aerofotogrametria (inclusive interpretacao), cartografia, mapeamento, levantamentos topograficos, batimetricos, geograficos, geodesicos, geologicos, geofisicos e congeneres.';
  0721: r := 'Pesquisa, perfuracao, cimentacao, mergulho, perfilagem, concretacao, testemunhagem, pescaria, estimulacao e outros servicos relacionados com a exploracao e explotacao de petroleo, gas natural e de outros recursos minerais.';
  0722: r := 'Nucleacao e bombardeamento de nuvens e congeneres.';
  0801: r := 'Ensino regular pre-escolar, fundamental, medio e superior.';
  0802: r := 'Instrucao, treinamento, orientacao pedagogica e educacional, avaliacao de conhecimentos de qualquer natureza.';
  0901: r := 'Hospedagem de qualquer natureza em hoteis, apartservice condominiais, flat , apart-hoteis, hoteis residencia, ' +
             'residence-service , suite service , hotelaria maritima, moteis, pensoes e congeneres; ocupacao por temporada com fornecimento de servico (o valor da alimentacao e gorjeta, quando incluido no preco da diaria, fica sujeito ao Imposto Sobre Servicos).';
  0902: r := 'Agenciamento, organizacao, promocao, intermediacao e execucao de programas de turismo, passeios, viagens, excursoes, hospedagens e congeneres.';
  0903: r := 'Guias de turismo.';
  1001: r := 'Agenciamento, corretagem ou intermediacao de cambio, de seguros, de cartoes de credito, de planos de saude e de planos de previdencia privada.';
  1002: r := 'Agenciamento, corretagem ou intermediacao de titulos em geral e valores mobiliarios e contratos quaisquer.';
  1003: r := 'Agenciamento, corretagem ou intermediacao de direitos de propriedade industrial, artistica ou literaria.';
  1004: r := 'Agenciamento, corretagem ou intermediacao de contratos de arrendamento mercantil (leasing), de franquia (franchising) e de faturizacao (factoring).';
  1005: r := 'Agenciamento, corretagem ou intermediacao de bens moveis ou imoveis, nao abrangidos em outros itens ou subitens, inclusive aqueles realizados no ambito de Bolsas de Mercadorias e Futuros, por quaisquer meios.';
  1006: r := 'Agenciamento maritimo.';
  1007: r := 'Agenciamento de noticias.';
  1008: r := 'Agenciamento de publicidade e propaganda, inclusive o agenciamento de veiculacao por quaisquer meios.';
  1009: r := 'Representacao de qualquer natureza, inclusive comercial.';
  1010: r := 'Distribuicao de bens de terceiros.';
  1101: r := 'Guarda e estacionamento de veiculos terrestres automotores, de aeronaves e de embarcacoes.';
  1102: r := 'Vigilancia, seguranca ou monitoramento de bens e pessoas.';
  1103: r := 'Escolta, inclusive de veiculos e cargas.';
  1104: r := 'Armazenamento, deposito, carga, descarga, arrumacao e guarda de bens de qualquer especie.';
  1201: r := 'Espetaculos teatrais.';
  1202: r := 'Exibicoes cinematograficas.';
  1203: r := 'Espetaculos circenses.';
  1204: r := 'Programas de auditorio.';
  1205: r := 'Parques de diversoes, centros de lazer e congeneres.';
  1206: r := 'Boates, taxi-dancing e congeneres.';
  1207: r := 'Shows, ballet, dancas, desfiles, bailes, operas, concertos, recitais, festivais e congeneres.';
  1208: r := 'Feiras, exposicoes, congressos e congeneres.';
  1209: r := 'Bilhares, boliches e diversoes eletronicas ou nao.';
  1210: r := 'Corridas e competicoes de animais.';
  1211: r := 'Competicoes esportivas ou de destreza fisica ou intelectual, com ou sem a participacao do espectador.';
  1212: r := 'Execucao de musica.';
  1213: r := 'Producao, mediante ou sem encomenda previa, de eventos, espetaculos, entrevistas, shows, ballet, dancas, desfiles, bailes, teatros, operas, concertos, recitais, festivais e congeneres.';
  1214: r := 'Fornecimento de musica para ambientes fechados ou nao, mediante transmissao por qualquer processo.';
  1215: r := 'Desfiles de blocos carnavalescos ou folcloricos, trios eletricos e congeneres.';
  1216: r := 'Exibicao de filmes, entrevistas, musicais, espetaculos, shows, concertos, desfiles, operas, competicoes esportivas, de destreza intelectual ou congeneres.';
  1217: r := 'Recreacao e animacao, inclusive em festas e eventos de qualquer natureza.';
  1301: r := '(VETADO)';
  1302: r := 'Fonografia ou gravacao de sons, inclusive trucagem, dublagem, mixagem e congeneres.';
  1303: r := 'Fotografia e cinematografia, inclusive revelacao, ampliacao, copia, reproducao, trucagem e congeneres.';
  1304: r := 'Reprografia, Microfilmagem e digitalizacao.';
  1305: r := 'Composicao grafica, fotocomposicao, clicheria, zincografia, litografia, fotolitografia.';
  1401: r := 'Lubrificacao, limpeza, lustracao, revisao, carga e recarga, conserto, restauracao, blindagem, manutencao e conservacao ' +
             'de maquinas, veiculos, aparelhos, equipamentos, motores, elevadores ou de qualquer objeto (exceto pecas e partes empregadas, que ficam sujeitas ao ICMS).';
  1402: r := 'Assistencia tecnica.';
  1403: r := 'Recondicionamento de motores (exceto pecas e partes empregadas, que ficam sujeitas ao ICMS).';
  1404: r := 'Recauchutagem ou regeneracao de pneus.';
  1405: r := 'Restauracao, recondicionamento, acondicionamento, pintura, beneficiamento, lavagem, secagem, tingimento, galvanoplastia, anodizacao, corte, recorte, polimento, plastificacao e congeneres, de objetos quaisquer.';
  1406: r := 'Instalacao e montagem de aparelhos, maquinas e equipamentos, inclusive montagem industrial, prestados ao usuario final, exclusivamente com material por ele fornecido.';
  1407: r := 'Colocacao de molduras e congeneres.';
  1408: r := 'Encadernacao, gravacao e douracao de livros, revistas e congeneres.';
  1409: r := 'Alfaiataria e costura, quando o material for fornecido pelo usuario final, exceto aviamento.';
  1410: r := 'Tinturaria e lavanderia.';
  1411: r := 'Tapecaria e reforma de estofamentos em geral.';
  1412: r := 'Funilaria e lanternagem.';
  1413: r := 'Carpintaria e serralheria.';
  1501: r := 'Administracao de fundos quaisquer, de consorcio, de cartao de credito ou debito e congeneres, de carteira de clientes, de cheques pre-datados e congeneres.';
  1502: r := 'Abertura de contas em geral, inclusive conta-corrente, conta de investimentos e aplicacao e caderneta de poupanca, no Pais e no exterior, bem como a manutencao das referidas contas ativas e inativas.';
  1503: r := 'Locacao e manutencao de cofres particulares, de terminais eletronicos, de terminais de atendimento e de bens e equipamentos em geral.';
  1504: r := 'Fornecimento ou emissao de atestados em geral, inclusive atestado de idoneidade, atestado de capacidade financeira e congeneres.';
  1505: r := 'Cadastro, elaboracao de ficha cadastral, renovacao cadastral e congeneres, inclusao ou exclusao no Cadastro de Emitentes de Cheques sem Fundos CCF ou em quaisquer outros bancos cadastrais.';
  1506: r := 'Emissao, reemissao e fornecimento de avisos, comprovantes e documentos em geral; abono de firmas; coleta e entrega de ' +
             'documentos, bens e valores; comunicacao com outra agencia ou com a administracao central; licenciamento eletronico de veiculos; transferencia de veiculos; agenciamento fiduciario ou depositario; devolucao de bens em custodia.';
  1507: r := 'Acesso, movimentacao, atendimento e consulta a contas em geral, por qualquer meio ou processo, inclusive por telefone, ' +
             'fac-simile, Internet e telex, acesso a terminais de atendimento, inclusive vinte e quatro horas; acesso a outro banco e a rede compartilhada; fornecimento de saldo, extrato e demais informacoes relativas a contas em geral, por qualquer meio ou processo.';
  1508: r := 'Emissao, reemissao, alteracao, cessao, substituicao, cancelamento e registro de contrato de credito; estudo, analise e ' +
             'avaliacao de operacoes de credito; emissao, concessao, alteracao ou contratacao de aval, fianca, anuencia e congeneres; servicos relativos a abertura de credito, para quaisquer fins.';
  1509: r := 'Arrendamento mercantil (leasing) de quaisquer bens, inclusive cessao de direitos e obrigacoes, substituicao de garantia, alteracao, cancelamento e registro de contrato, e demais servicos relacionados ao arrendamento mercantil (leasing).';
  1510: r := 'Servicos relacionados a cobrancas, recebimentos ou pagamentos em geral, de titulos quaisquer, de contas ou carnes, de ' +
             'cambio, de tributos e por conta de terceiros, inclusive os efetuados por meio eletronico, automatico ou por maquinas de ' +
             'atendimento; fornecimento de posicao de cobranca, recebimento ou pagamento; emissao de carnes, fichas de compensacao, impressos e documentos em geral.';
  1511: r := 'Devolucao de titulos, protesto de titulos, sustacao de protesto, manutencao de titulos, reapresentacao de titulos, e demais servicos a eles relacionados.';
  1512: r := 'Custodia em geral, inclusive de titulos e valores mobiliarios.';
  1513: r := 'Servicos relacionados a operacoes de cambio em geral, edicao, alteracao, prorrogacao, cancelamento e baixa de contrato ' +
             'de cambio; emissao de registro de exportacao ou de credito; cobranca ou deposito no exterior; emissao, fornecimento e ' +
             'cancelamento de cheques de viagem; fornecimento, transferencia, cancelamento e demais servicos relativos a carta de credito de importacao, exportacao e garantias recebidas; envio e recebimento de mensagens em geral relacionadas a operacoes de cambio.';
  1514: r := 'Fornecimento, emissao, reemissao, renovacao e manutencao de cartao magnetico, cartao de credito, cartao de debito, cartao salario e congeneres.';
  1515: r := 'Compensacao de cheques e titulos quaisquer; servicos relacionados a deposito, inclusive deposito identificado, a saque de contas quaisquer, por qualquer meio ou processo, inclusive em terminais eletronicos e de atendimento.';
  1516: r := 'Emissao, reemissao, liquidacao, alteracao, cancelamento e baixa de ordens de pagamento, ordens de credito e similares, ' +
             'por qualquer meio ou processo; servicos relacionados a transferencia de valores, dados, fundos, pagamentos e similares, inclusive entre contas em geral.';
  1517: r := 'Emissao, fornecimento, devolucao, sustacao, cancelamento e oposicao de cheques quaisquer, avulso ou por talao.';
  1518: r := 'Servicos relacionados a credito imobiliario, avaliacao e vistoria de imovel ou obra, analise tecnica e juridica, emissao, ' +
             'reemissao, alteracao, transferencia e renegociacao de contrato, emissao e reemissao do termo de quitacao e demais servicos relacionados a credito imobiliario.';
  1601: r := 'Servicos de transporte de natureza municipal.';
  1701: r := 'Assessoria ou consultoria de qualquer natureza, nao contida em outros itens desta lista; analise, exame, pesquisa, coleta, compilacao e fornecimento de dados e informacoes de qualquer natureza, inclusive cadastro e similares.';
  1702: r := 'Datilografia, digitacao, estenografia, expediente, secretaria em geral, resposta audivel, redacao, edicao, interpretacao, revisao, traducao, apoio e infra-estrutura administrativa e congeneres.';
  1703: r := 'Planejamento, coordenacao, programacao ou organizacao tecnica, financeira ou administrativa.';
  1704: r := 'Recrutamento, agenciamento, selecao e colocacao de mao-de-obra.';
  1705: r := 'Fornecimento de mao-de-obra, mesmo em carater temporario, inclusive de empregados ou trabalhadores, avulsos ou temporarios, contratados pelo prestador de servico.';
  1706: r := 'Propaganda e publicidade, inclusive promocao de vendas, planejamento de campanhas ou sistemas de publicidade, elaboracao de desenhos, textos e demais materiais publicitarios.';
  1707: r := '(VETADO)';
  1708: r := 'Franquia (franchising).';
  1709: r := 'Pericias, laudos, exames tecnicos e analises tecnicas.';
  1710: r := 'Planejamento, organizacao e administracao de feiras, exposicoes, congressos e congeneres.';
  1711: r := 'Organizacao de festas e recepcoes; bufe (exceto o fornecimento de alimentacao e bebidas, que fica sujeito ao ICMS).';
  1712: r := 'Administracao em geral, inclusive de bens e negocios de terceiros.';
  1713: r := 'Leilao e congeneres.';
  1714: r := 'Advocacia.';
  1715: r := 'Arbitragem de qualquer especie, inclusive juridica.';
  1716: r := 'Auditoria.';
  1717: r := 'Analise de Organizacao e Metodos.';
  1718: r := 'Atuaria e calculos tecnicos de qualquer natureza.';
  1719: r := 'Contabilidade, inclusive servicos tecnicos e auxiliares.';
  1720: r := 'Consultoria e assessoria economica ou financeira.';
  1721: r := 'Estatistica.';
  1722: r := 'Cobranca em geral.';
  1723: r := 'Assessoria, analise, avaliacao, atendimento, consulta, cadastro, selecao, gerenciamento de informacoes, administracao de contas a receber ou a pagar e em geral, relacionados a operacoes de faturizacao (factoring).';
  1724: r := 'Apresentacao de palestras, conferencias, seminarios e congeneres.';
  1801: r := 'Servicos de regulacao de sinistros vinculados a contratos de seguros; inspecao e avaliacao de riscos para cobertura de contratos de seguros; prevencao e gerencia de riscos seguraveis e congeneres.';
  1901: r := 'Servicos de distribuicao e venda de bilhetes e demais produtos de loteria, bingos, cartoes, pules ou cupons de apostas, sorteios, premios, inclusive os decorrentes de titulos de capitalizacao e congeneres. a) Bingo; b) Demais casos.';
  2001: r := 'Servicos portuarios, ferroportuarios, utilizacao de porto, movimentacao de passageiros, reboque de embarcacoes, rebocador ' +
             'escoteiro, atracacao, desatracacao, servicos de praticagem, capatazia, armazenagem de qualquer natureza, servicos ' +
             'acessorios, movimentacao de mercadorias, servicos de apoio maritimo, de movimentacao ao largo, servicos de armadores, estiva, conferencia, logistica e congeneres.';
  2002: r := 'Servicos aeroportuarios, utilizacao de aeroporto, movimentacao de passageiros, armazenagem de qualquer natureza, capatazia, ' +
             'movimentacao de aeronaves, servicos de apoio aeroportuarios, servicos acessorios, movimentacao de mercadorias, logistica e congeneres.';
  2003: r := 'Servicos de terminais rodoviarios, ferroviarios, metroviarios, movimentacao de passageiros, mercadorias, inclusive suas operacoes, logistica e congeneres.';
  2101: r := 'Servicos de registros publicos, cartorarios e notariais.';
  2201: r := 'Servicos de exploracao de rodovia mediante cobranca de preco ou pedagio dos usuarios, envolvendo execucao de servicos de ' +
             'conservacao, manutencao, melhoramentos para adequacao de capacidade e seguranca de transito, operacao, monitoracao, assistencia aos usuarios e outros servicos definidos em contratos, atos de concessao ou de permissao ou em normas oficiais.';
  2301: r := 'Servicos de programacao e comunicacao visual, desenho industrial e congeneres.';
  2401: r := 'Servicos de chaveiros, confeccao de carimbos, placas, sinalizacao visual, banners, adesivos e congeneres.';
  2501: r := 'Funerais, inclusive fornecimento de caixao, urna ou esquifes; aluguel de capela; transporte do corpo cadaverico; fornecimento de ' +
             'flores, coroas e outros paramentos; desembaraco de certidao de obito; fornecimento de veu, essa e outros adornos; embalsamento, embelezamento, conservacao ou restauracao de cadaveres.';
  2502: r := 'Cremacao de corpos e partes de corpos cadavericos.';
  2503: r := 'Planos ou convenio funerarios.';
  2504: r := 'Manutencao e conservacao de jazigos e cemiterios.';
  2601: r := 'Servicos de coleta remessa ou entrega de correspondencias, documentos, objetos, bens ou valores, inclusive pelos correios e suas agencias franqueadas; courrier e congeneres.';
  2701: r := 'Servicos de assistencia social.';
  2801: r := 'Servicos de avaliacao de bens e servicos de qualquer natureza.';
  2901: r := 'Servicos de biblioteconomia.';
  3001: r := 'Servicos de biologia, biotecnologia e quimica.';
  3101: r := 'Servicos tecnicos em edificacoes, eletronica, eletrotecnica, mecanica, telecomunicacoes e congeneres.';
  3201: r := 'Servicos de desenhos tecnicos.';
  3301: r := 'Servicos de desembaraco aduaneiro, comissarios, despachantes e congeneres.';
  3401: r := 'Servicos de investigacoes particulares, detetives e congeneres.';
  3501: r := 'Servicos de reportagem, assessoria de imprensa, jornalismo e relacoes publicas.';
  3601: r := 'Servicos de meteorologia.';
  3701: r := 'Servicos de artistas, atletas, modelos e manequins.';
  3801: r := 'Servicos de museologia.';
  3901: r := 'Servicos de ourivesaria e lapidacao (quando o material for fornecido pelo tomador do servico).';
  4001: r := 'Obras de arte sob encomenda.';
  end;

  result := r;
end;

// Provedor com base ao c�digo da cidade ***************************************

function CodCidadeToProvedor(const ACodigo: Integer): string;
var
 Provedor: String;
begin
 Provedor := 'Nenhum';
 case ACodigo of
  1302603, // Manaus/AM
  1500800, // Ananindeua/PA
  1505536, // Parauapebas/PA
  1506807, // Santarem/PA
  2304285, // Eusebio/PA
  2304400, // Fortaleza/CE
  2307650, // Maracanau/CE
  2507507, // Joao Pessoa/PB
  2513653, // Santarem/PB
  2604106, // Caruaru/PE
  2700300, // Arapiraca/AL
  2704302, // Maceio/AL
  2704708, // Marechal Deodoro/AL
//  2910727, // Eunapolis/BA
  2933307, // Vitoria da Conquista/BA
  3101607, // Alfenas/MG
  3115300, // Cataguases/MG
  3117504, // Conceicao do Mato Dentro/MG
  3137601, // Lagoa Santa/MG
  3143906, // Muriae/MG
  3145604, // Oliveira/MG
  3147105, // Para de Minas/MG
  3154606, // Ribeirao das Neves/MG
  3156908, // Sacramento/MG
  3169901, // Uba/MG
  3170701, // Varginha/MG
  3300456, // Belford Roxo/RJ
  3301009, // Campos dos Goytacazes/RJ
  3301900, // Itaborai/RJ
  3302700, // Marica/RJ
  3304300, // Rio Bonito/RJ
  3503208, // Araraquara/SP
  3506359, // Bertioga/SP
  3510401, // Capivari/SP
  3511300, // Cedral/SP
  3512001, // Colina/SP
  3513009, // Cotia/SP
  3513801, // Diadema/SP
  3515509, // Fernandopolis/SP
  3516200, // Franca/SP
  3518305, // Guararema/SP
  3518404, // Guaratinguet�/SP
  3518701, // Guaruja/SP
  3518800, // Guarulhos/SP
  3519071, // Hortolandia/SP
  3523909, // Itu/SP
//  3524709, // Jaguariuna/SP
  3525102, // Jardinopolis/SP
  3525300, // Jau/SP
  3525904, // Jundiai/SP
  3529401, // Maua/SP
  3530508, // Mococa/SP
  3533908, // Olimpia/SP
  3536505, // Paulinia/SP
  3538006, // Pindamonhangaba/SP
  3542602, // Registro/SP
  3543303, // Ribeirao Pires/SP
  3543402, // Ribeirao Preto/SP
  3543907, // Rio Claro/SP
  3545209, // Salto/SP
  3547809, // Santo Andre/SP
  3548500, // Santos/SP
  3548708, // Sao Bernardo do Campos/SP
  3548807, // Sao Caetano do Sul/SP
  3548906, // Sao Carlos/SP
  3549805, // Sao Jose do Rio Preto/SP
  3549904, // Sao Jose dos Campos/SP
  3550605, // Sao Roque/SP
  3550704, // Sao Sebastiao
  3552502, // Suzano/SP
  3557105, // Votuporanga/SP
  3704708, // Marechal Deodoro/AL
  4118204, // Paranagua/PR
  4125506, // Sao Jose dos Pinhais/PR
  4128104, // Umuarama/PR
  4202404, // Blumenau/SC
  4309308, // Guaiba/RS
  4314407  // Pelotas/RS
         : Provedor := 'GINFES';

      999, // Adicionado por ronnei, esse c�digo � usado na homologa��o
  1702109, // Aragua�na/TO
  3139607, // Mantena/MG
  3169307, // Tr�s Cora��es/MG
  3502101, // Andradina/SP
  3502507, // Aparecida/SP
  3522307, // Itapetininga/SP
  3524402, // Jacare�/SP
  3524709, // Jaguariuna/SP
  3527207, // Lorena/SP
  3530607, // Mogi das Cruzes/SP
  3541000, // Praia Grande/SP
  3551009, // S�o Vicente/SP
  3551504, // Serrana/SP
  4104808, // Cascavel/PR
  4219507, // Xanxer�/SC
  4306106, // Cruz Alta/RS
  4313409, // Novo Hamburgo/RS
  4316907, // Santa Maria/RS
  5002209, // Bonito/MS
  5003702, // Dourados/MT
  5005707, // Navira�/MS
  5006002, // Nova Alvorada do Sul/MS
  5007208, // Rio Brilhante/MS
  5007901, // Sidrol�ndia/MS
  5100250, // Alta Floresta/MT
  5103403, // Cuiaba/MT
  5105101, // Juara/MT
  5105903, // Nobres/MT
  5106232, // Nova Olimpia/MT
  5107925, // Sorriso/MT
  5108402, // V�rzea Grande/MT
  5201108, // Anapolis/GO
  5201405  // Aparecida de Goiania/GO
         : Provedor := 'ISSNET';

  1100049, // Cacoal/RO
  2800308, // Aracaju/SE
  2801009, // Campo do Brito/SE
  2802106, // Est�ncia/SE
  2803500, // Lagarto/SE
  2901007, // Amargosa/BA
  2907509, // Catu/BA
  2910800, // Feira de Santana/BA
  2925204, // Pojuca/BA
  3104205, // Arcos/MG
  3105608, // Barbacena/MG
  3105905, // Barroso/MG
  3110509, // Camanducaia/MG
  3111200, // Campo Belo/MG
  3119401, // Coronel Fabriciano/MG
  3126109, // Formiga/MG
  3127107, // Frutal/MG
  3133808, // Ita�na/MG
  3136207, // Jo�o Monlevade/MG
  3150703, // Pirajuba/MG
  3155702, // Rio Piracicaba/MG
  3159605, // Santa Rita do Sapuca�/MG
  3162104, // S�o Gotardo/MG
  3170107, // Uberaba/MG
  3300209, // Araruama/RJ
  3300803, // Cachoeiras de Macacu/RJ
  3301207, // Carmo/RJ
  3301306, // Casimiro de Abreu/RJ
  3301504, // Cordeiro/RJ
  3302908, // Miguel Pereira/RJ
  3303302, // Niteroi/RJ
  3303401, // Nova Friburgo/RJ
  3303856, // Paty do Alferes/RJ
  3304110, // Porto Real/RJ
  3304144, // Queimados/RJ
  3304607, // Santa Maria Madalena/RJ
  3305000, // S�o Jo�o da Barra/RJ
  3305604, // Silva Jardim/RJ
  3305802, // Teres�polis/RJ
  4301602, // Bage/RS
  5105259, // Lucas do Rio Verde/MT
  5107909, // Sinop/MT
  5204508  // Caldas Novas/GO
         : Provedor := 'WebISS';

  3118601, // Contagem/MG
  3143302, // Montes Claros/MG
  3202405, // Guarapari/ES
  3305505, // Saquarema/RJ
  3511102, // Catanduva/SP
  3530300, // Mirassol/SP'
  3541505, // Presidente Venceslau/SP
  4205902, // Gaspar/SC
  4309407, // Guapore/RS
  4310207  // Ijui/RS
         : Provedor := 'GovBR';

  2611606  // Recife/PE
         : Provedor := 'Recife';

  3106200, // Belo Horizonte/MG
  3136702  // Juiz de Fora/MG
         : Provedor := 'BHISS';

  3106705  // Betim/MG
         : Provedor := 'Betim';

  3304557  // Rio de Janeiro/RJ
         : Provedor := 'RJ';

  3301702, // Duque de Caxias/RJ
  3501608  // Americana/SP
         : Provedor := 'Tiplan';

  3148103, // Patrocinio/MG
  3503307, // Araras/SP
  3538709, // Piracicaba/SP
  3541406, // Presidente Prudente/SP
  3549102, // S�o Jo�o da Boa Vista/SP
  3549706, // S�o Jos� do Rio Pardo/SP
  3556404  // Vargem Grande do Sul/SP
         : Provedor := 'SimplISS';

  4108403  // Francisco Beltrao/PR
         : Provedor := 'Equiplano';

  4119905  // Ponta Grossa/PR
         : Provedor := 'fintelISS';

  3302254, // Itatiaia/RJ
  3303955, // Pinheiral/RJ
  3304508, // Rio das Flores/RJ
  3510104, // Candido Rodrigues/SP
  4100301, // Agudos do Sul/PR
  4100400, // Almirante Tamandar�/PR
  4101002, // Amp�re/PR
  4104253, // Campo Magro/PR
  4106407, // Corn�lio Proc�pio/PR
  4107652, // Fazenda Rio Grande/PR
  4108601, // Goioer�/PR
  4114302, // Mandirituba/PR
  4118402, // Paranava�/PR
  4120853, // Quatro Pontes/PR
  4125605, // S�o Mateus do Sul/PR
  4127106, // Telemaco Borba/PR
  4128203, // Uni�o da Vit�ria/PR
  4202131, // Bela Vista do Toldo/SC
  4202305, // Bigua�u/SC
  4202453, // Bombinhas/SC
  4202800, // Bra�o do Norte/SC
  4203600, // Campos Novos/SC
  4203808, // Canoinhas/SC
  4204202, // Chapec�/SC
  4204350, // Cordilheira Alta/SC
  4204509, // Corup�/SC
  4204608, // Crici�ma/SC
  4205555, // Frei Rog�rio/SC
  4205704, // Garopaba/SC
  4206207, // Gravatal/SC
  4206405, // Guaraciaba/SC
  4206900, // Ibirama/SC
  4207304, // Imbituba/SC
  4208302, // Itapema/SC
  4208401, // Itapiranga/SC
  4208500, // Ituporanga/SC
  4209003, // Joa�aba/SC
  4209300, // Lages/SC
  4210001, // Luiz Alves/SC
  4211306, // Navegantes/SC
  4211900, // Palho�a/SC
  4212106, // Palmitos/SC
  4212502, // Penha/SC
  4212908, // Pinhalzinho/SC
  4213104, // Piratuba/SC
  4213153, // Planalto Alegre/SC
  4213609, // Porto Uni�o/SC
  4213708, // Pouso Redondo/SC
  4214805, // Rio do Sul/SC
  4215000, // Rio Negrinho/SC
  4215505, // Santa Cec�lia/SC
  4215802, // S�o Bento do Sul/SC
  4216008, // S�o Carlos/SC
  4216305, // S�o Jo�o Batista/SC
  4216602, // S�o Jos�/SC
  4216909, // S�o Louren�o do Oeste/SC
  4217204, // S�o Miguel do Oeste/SC
  4217402, // Schroeder/SC
  4217600, // Sider�polis/SC
  4217808, // Tai�/SC
  4217907, // Tangar�/SC
  4218004, // Tijucas/SC
  4219002, // Urussanga/SC
  4219606, // Xavantina/SC
  4219705, // Xaxim/SC
  4302105, // Bento Gon�alves/RS
  4305801, // Constantina/RS
  4318002, // S�o Borja/RS
  5006200, // Nova Andradina/MS
  5100201, // �gua Boa/MT
  5102686, // Campos de J�lio/MT
  5103502  // Diamantino/MT
         : Provedor := 'Betha';

  4208203  // Itajai/SC
         : Provedor := 'Publica';

  4308508  // Frederico Westphalen/RS
         : Provedor := 'Digifred';

  4303103, // Cachoeirinha/RS
  4314100, // Passo Fundo/RS
  4318705  // Sao Leopoldo/RS
         : Provedor := 'Thema';

  1709500, // Gurupi/TO
  2112209, // Timon/MA
  2207009, // Oeiras/PI
  2208007, // Picos/PI
  2211209, // Uru�u�/PI
  2307304, // Juazeiro do Norte/CE
  2910727, // Eunapolis/BA
  2925303, // Porto Seguro/BA
  3107109, // Boa Esperan�a/MG
  3112505, // Capim Branco/MG
  3113305, // Carangola/MG
  3114402, // Carmo do Rio Claro/MG
  3116605, // Cl�udio/MG
  3128006, // Guanh�es/MG
  3128105, // Guap�/MG
  3131307, // Ipatinga/MG
  3147907, // Passos/MG
  3148004, // Patos de Minas/MG
  3149903, // Perd�es/MG
  3151503, // Piumhi/MG
  3152600, // Pouso Alto/MG
  3153905, // Raposos/MG
  3170800, // V�rzea da Palma/MG
  3171303, // Vi�osa/MG
  3200102, // Afonso Cl�udio/ES
  3200300, // Alfredo Chaves/ES
  3204708, // S�o Gabriel da Palha/ES
  4109609, // Guaratuba/PR
  4300406, // Alegrete/RS
  4313953, // Pantano Grande/RS
  5106505, // Pocon�/MT
  5106778, // Porto Alegre do Norte/MT
  5107107  // S�o Jos� dos Quatro Marcos/MT
         : Provedor := 'ISSIntel';

  1400100, // Boa Vista/RR
  1400209, // Caracarai/RR
  2900801, // Alcobaca/BA
  2902708, // Barra/BA
  2903201, // Barreiras/BA
  2903904, // Bom Jesus Da Lapa/BA
  2905602, // Camacan/BA
  2906006, // Campo Formoso/BA
  2907202, // Casa Nova/BA
  2909307, // Correntina/BA
  2910057, // Dias D Avila/BA
  2910602, // Esplanada/BA
  2913200, // Ibotirama/BA
  2913903, // Ipiau/BA
  2914505, // Irara/BA
  2914653, // Itabela/BA
  2914703, // Itaberaba/BA
  2917003, // Itiuba/BA
  2917508, // Jacobina/BA
  2917706, // Jaguarari/BA
  2919157, // Lapao/BA
  2919926, // Madre De Deus/BA
  2922003, // Mucuri/BA
  2922656, // Nordestina/BA
  2927705, // Santa Cruz Cabralia/BA
  2928901, // Sao Desiderio/BA
  2931350, // Teixeira De Freitas/BA
  2932804, // Utinga/BA
  2933208, // Vera Cruz/BA
  4201653, // Arvoredo/SC
  4204558  // Correia Pinto/SC
         : Provedor := 'Saatri';

  1100304, // Vilhena/RO
  5101704, // Barra do Bugres/MT
  5102504, // C�ceres/MT
  5102702, // Canarana/MT
  5103007, // Chapada dos Guimar�es/MT
  5104559, // Ita�ba/MT
  5104609, // Itiquira/MT
  5107248, // Santa Carmen/MT
  5107800, // Santo Ant�nio do Leverger/MT
  5107875, // Sapezal/MT
  5107958  // Tangara da Serra/MT
         : Provedor := 'FISSLEX';

  3201209, // Cachoeiro do Itapemirim/ES
  4304606, // Canoas/RS
  5107040, // Primavera do Leste/MT
  5107602  // Rondonopolis/MT
         : Provedor := 'Abaco';

    25300, // Goi�nia/GO
  5208707  // Goiania/GO
         : Provedor := 'Goiania';

  4106902  // Curitiba/PR
         : Provedor := 'IssCuritiba';

  2408102  // Natal/RN
         : Provedor := 'Natal';

  3157807  // Santa Luzia/MG
         : Provedor := 'ISSDigital';

  4115200  // Maringa/PR
         : Provedor := 'ISSe';

  3127701, // Governador Valadares/MG
  3500105, // Adamantina/SP
  3510203, // Cap�o Bonito/SP
  3523503, // Itatinga/SP
  3554003  // Tatui/SP
         : Provedor := '4R';

  3132404, // Itajub�/MG
  3151800  // Po�os de Caldas/MG
//  3522307  // Itapetininga/SP
         : Provedor := 'GovDigital';

  2103000, // Caxias/MA
  3504800  // Balsamo/SP
         : Provedor := 'Fiorilli';
 end;
 Result := Provedor;
end;

// Nome da cidade com base ao c�digo da cidade *********************************

function CodCidadeToCidade(const ACodigo: Integer): string;
var
 Cidade: String;

 procedure P00;
 begin
   case ACodigo of
        // Alterado por Cleiver em 26/02/2013
        25300: Cidade := 'Goi�nia/GO';
       530020: Cidade := 'Brazlandia/DF';
   end;
 end;

 procedure P11;
 begin
   case ACodigo of
      1100015: Cidade := 'Alta Floresta D Oeste/RO';
      1100023: Cidade := 'Ariquemes/RO';
      1100031: Cidade := 'Cabixi/RO';
      1100049: Cidade := 'Cacoal/RO';
      1100056: Cidade := 'Cerejeiras/RO';
      1100064: Cidade := 'Colorado Do Oeste/RO';
      1100072: Cidade := 'Corumbiara/RO';
      1100080: Cidade := 'Costa Marques/RO';
      1100098: Cidade := 'Espigao D Oeste/RO';
      1100106: Cidade := 'Guajara-Mirim/RO';
      1100114: Cidade := 'Jaru/RO';
      1100122: Cidade := 'Ji-Parana/RO';
      1100130: Cidade := 'Machadinho Doeste/RO';
      1100148: Cidade := 'Nova Brasilandia D Oeste/RO';
      1100155: Cidade := 'Ouro Preto Do Oeste/RO';
      1100189: Cidade := 'Pimenta Bueno/RO';
      1100205: Cidade := 'Porto Velho/RO';
      1100254: Cidade := 'Presidente Medici/RO';
      1100262: Cidade := 'Rio Crespo/RO';
      1100288: Cidade := 'Rolim De Moura/RO';
      1100296: Cidade := 'Santa Luzia D Oeste/RO';
      1100304: Cidade := 'Vilhena/RO';
      1100320: Cidade := 'Sao Miguel Do Guapore/RO';
      1100338: Cidade := 'Nova Mamore/RO';
      1100346: Cidade := 'Alvorada D Oeste/RO';
      1100379: Cidade := 'Alto Alegre Dos Parecis/RO';
      1100403: Cidade := 'Alto Paraiso/RO';
      1100452: Cidade := 'Buritis/RO';
      1100502: Cidade := 'Novo Horizonte Do Oeste/RO';
      1100601: Cidade := 'Cacaulandia/RO';
      1100700: Cidade := 'Campo Novo De Rondonia/RO';
      1100809: Cidade := 'Candeias Do Jamari/RO';
      1100908: Cidade := 'Castanheiras/RO';
      1100924: Cidade := 'Chupinguaia/RO';
      1100940: Cidade := 'Cujubim/RO';
      1101005: Cidade := 'Governador Jorge Teixeira/RO';
      1101104: Cidade := 'Itapua Do Oeste/RO';
      1101203: Cidade := 'Ministro Andreazza/RO';
      1101302: Cidade := 'Mirante Da Serra/RO';
      1101401: Cidade := 'Monte Negro/RO';
      1101435: Cidade := 'Nova Uniao/RO';
      1101450: Cidade := 'Parecis/RO';
      1101468: Cidade := 'Pimenteiras Do Oeste/RO';
      1101476: Cidade := 'Primavera De Rondonia/RO';
      1101484: Cidade := 'Sao Felipe D Oeste/RO';
      1101492: Cidade := 'Sao Francisco Do Guapore/RO';
      1101500: Cidade := 'Seringueiras/RO';
      1101559: Cidade := 'Teixeiropolis/RO';
      1101609: Cidade := 'Theobroma/RO';
      1101708: Cidade := 'Urupa/RO';
      1101757: Cidade := 'Vale Do Anari/RO';
      1101807: Cidade := 'Vale Do Paraiso/RO';
   end;
 end;

 procedure P12;
 begin
   case ACodigo of
      1200013: Cidade := 'Acrelandia/AC';
      1200054: Cidade := 'Assis Brasil/AC';
      1200104: Cidade := 'Brasileia/AC';
      1200138: Cidade := 'Bujari/AC';
      1200179: Cidade := 'Capixaba/AC';
      1200203: Cidade := 'Cruzeiro Do Sul/AC';
      1200252: Cidade := 'Epitaciolandia/AC';
      1200302: Cidade := 'Feijo/AC';
      1200328: Cidade := 'Jordao/AC';
      1200336: Cidade := 'Mancio Lima/AC';
      1200344: Cidade := 'Manoel Urbano/AC';
      1200351: Cidade := 'Marechal Thaumaturgo/AC';
      1200385: Cidade := 'Placido De Castro/AC';
      1200393: Cidade := 'Porto Walter/AC';
      1200401: Cidade := 'Rio Branco/AC';
      1200427: Cidade := 'Rodrigues Alves/AC';
      1200435: Cidade := 'Santa Rosa Do Purus/AC';
      1200450: Cidade := 'Senador Guiomard/AC';
      1200500: Cidade := 'Sena Madureira/AC';
      1200609: Cidade := 'Tarauaca/AC';
      1200708: Cidade := 'Xapuri/AC';
      1200807: Cidade := 'Porto Acre/AC';
   end;
 end;

 procedure P13;
 begin
   case ACodigo of
      1300029: Cidade := 'Alvaraes/AM';
      1300060: Cidade := 'Amatura/AM';
      1300086: Cidade := 'Anama/AM';
      1300102: Cidade := 'Anori/AM';
      1300144: Cidade := 'Apui/AM';
      1300201: Cidade := 'Atalaia Do Norte/AM';
      1300300: Cidade := 'Autazes/AM';
      1300409: Cidade := 'Barcelos/AM';
      1300508: Cidade := 'Barreirinha/AM';
      1300607: Cidade := 'Benjamin Constant/AM';
      1300631: Cidade := 'Beruri/AM';
      1300680: Cidade := 'Boa Vista Do Ramos/AM';
      1300706: Cidade := 'Boca Do Acre/AM';
      1300805: Cidade := 'Borba/AM';
      1300839: Cidade := 'Caapiranga/AM';
      1300904: Cidade := 'Canutama/AM';
      1301001: Cidade := 'Carauari/AM';
      1301100: Cidade := 'Careiro/AM';
      1301159: Cidade := 'Careiro Da Varzea/AM';
      1301209: Cidade := 'Coari/AM';
      1301308: Cidade := 'Codajas/AM';
      1301407: Cidade := 'Eirunepe/AM';
      1301506: Cidade := 'Envira/AM';
      1301605: Cidade := 'Fonte Boa/AM';
      1301654: Cidade := 'Guajara/AM';
      1301704: Cidade := 'Humaita/AM';
      1301803: Cidade := 'Ipixuna/AM';
      1301852: Cidade := 'Iranduba/AM';
      1301902: Cidade := 'Itacoatiara/AM';
      1301951: Cidade := 'Itamarati/AM';
      1302009: Cidade := 'Itapiranga/AM';
      1302108: Cidade := 'Japura/AM';
      1302207: Cidade := 'Jurua/AM';
      1302306: Cidade := 'Jutai/AM';
      1302405: Cidade := 'Labrea/AM';
      1302504: Cidade := 'Manacapuru/AM';
      1302553: Cidade := 'Manaquiri/AM';
      1302603: Cidade := 'Manaus/AM';
      1302702: Cidade := 'Manicore/AM';
      1302801: Cidade := 'Maraa/AM';
      1302900: Cidade := 'Maues/AM';
      1303007: Cidade := 'Nhamunda/AM';
      1303106: Cidade := 'Nova Olinda Do Norte/AM';
      1303205: Cidade := 'Novo Airao/AM';
      1303304: Cidade := 'Novo Aripuana/AM';
      1303403: Cidade := 'Parintins/AM';
      1303502: Cidade := 'Pauini/AM';
      1303536: Cidade := 'Presidente Figueiredo/AM';
      1303569: Cidade := 'Rio Preto Da Eva/AM';
      1303601: Cidade := 'Santa Isabel Do Rio Negro/AM';
      1303700: Cidade := 'Santo Antonio Do Ica/AM';
      1303809: Cidade := 'Sao Gabriel Da Cachoeira/AM';
      1303908: Cidade := 'Sao Paulo De Olivenca/AM';
      1303957: Cidade := 'Sao Sebastiao Do Uatuma/AM';
      1304005: Cidade := 'Silves/AM';
      1304062: Cidade := 'Tabatinga/AM';
      1304104: Cidade := 'Tapaua/AM';
      1304203: Cidade := 'Tefe/AM';
      1304237: Cidade := 'Tonantins/AM';
      1304260: Cidade := 'Uarini/AM';
      1304302: Cidade := 'Urucara/AM';
      1304401: Cidade := 'Urucurituba/AM';
   end;
 end;

 procedure P14;
 begin
   case ACodigo of
      1400027: Cidade := 'Amajari/RR';
      1400050: Cidade := 'Alto Alegre/RR';
      1400100: Cidade := 'Boa Vista/RR';
      1400159: Cidade := 'Bonfim/RR';
      1400175: Cidade := 'Canta/RR';
      1400209: Cidade := 'Caracarai/RR';
      1400233: Cidade := 'Caroebe/RR';
      1400282: Cidade := 'Iracema/RR';
      1400308: Cidade := 'Mucajai/RR';
      1400407: Cidade := 'Normandia/RR';
      1400456: Cidade := 'Pacaraima/RR';
      1400472: Cidade := 'Rorainopolis/RR';
      1400506: Cidade := 'Sao Joao Da Baliza/RR';
      1400605: Cidade := 'Sao Luiz/RR';
      1400704: Cidade := 'Uiramuta/RR';
   end;
 end;

 procedure P15;
 begin
   case ACodigo of
      1500107: Cidade := 'Abaetetuba/PA';
      1500131: Cidade := 'Abel Figueiredo/PA';
      1500206: Cidade := 'Acara/PA';
      1500305: Cidade := 'Afua/PA';
      1500347: Cidade := 'Agua Azul Do Norte/PA';
      1500404: Cidade := 'Alenquer/PA';
      1500503: Cidade := 'Almeirim/PA';
      1500602: Cidade := 'Altamira/PA';
      1500701: Cidade := 'Anajas/PA';
      1500800: Cidade := 'Ananindeua/PA';
      1500859: Cidade := 'Anapu/PA';
      1500909: Cidade := 'Augusto Correa/PA';
      1500958: Cidade := 'Aurora Do Para/PA';
      1501006: Cidade := 'Aveiro/PA';
      1501105: Cidade := 'Bagre/PA';
      1501204: Cidade := 'Baiao/PA';
      1501253: Cidade := 'Bannach/PA';
      1501303: Cidade := 'Barcarena/PA';
      1501402: Cidade := 'Belem/PA';
      1501451: Cidade := 'Belterra/PA';
      1501501: Cidade := 'Benevides/PA';
      1501576: Cidade := 'Bom Jesus Do Tocantins/PA';
      1501600: Cidade := 'Bonito/PA';
      1501709: Cidade := 'Braganca/PA';
      1501725: Cidade := 'Brasil Novo/PA';
      1501758: Cidade := 'Brejo Grande Do Araguaia/PA';
      1501782: Cidade := 'Breu Branco/PA';
      1501808: Cidade := 'Breves/PA';
      1501907: Cidade := 'Bujaru/PA';
      1501956: Cidade := 'Cachoeira Do Piria/PA';
      1502004: Cidade := 'Cachoeira Do Arari/PA';
      1502103: Cidade := 'Cameta/PA';
      1502152: Cidade := 'Canaa Dos Carajas/PA';
      1502202: Cidade := 'Capanema/PA';
      1502301: Cidade := 'Capitao Poco/PA';
      1502400: Cidade := 'Castanhal/PA';
      1502509: Cidade := 'Chaves/PA';
      1502608: Cidade := 'Colares/PA';
      1502707: Cidade := 'Conceicao Do Araguaia/PA';
      1502756: Cidade := 'Concordia Do Para/PA';
      1502764: Cidade := 'Cumaru Do Norte/PA';
      1502772: Cidade := 'Curionopolis/PA';
      1502806: Cidade := 'Curralinho/PA';
      1502855: Cidade := 'Curua/PA';
      1502905: Cidade := 'Curuca/PA';
      1502939: Cidade := 'Dom Eliseu/PA';
      1502954: Cidade := 'Eldorado Dos Carajas/PA';
      1503002: Cidade := 'Faro/PA';
      1503044: Cidade := 'Floresta Do Araguaia/PA';
      1503077: Cidade := 'Garrafao Do Norte/PA';
      1503093: Cidade := 'Goianesia Do Para/PA';
      1503101: Cidade := 'Gurupa/PA';
      1503200: Cidade := 'Igarape-Acu/PA';
      1503309: Cidade := 'Igarape-Miri/PA';
      1503408: Cidade := 'Inhangapi/PA';
      1503457: Cidade := 'Ipixuna Do Para/PA';
      1503507: Cidade := 'Irituia/PA';
      1503606: Cidade := 'Itaituba/PA';
      1503705: Cidade := 'Itupiranga/PA';
      1503754: Cidade := 'Jacareacanga/PA';
      1503804: Cidade := 'Jacunda/PA';
      1503903: Cidade := 'Juruti/PA';
      1504000: Cidade := 'Limoeiro Do Ajuru/PA';
      1504059: Cidade := 'Mae Do Rio/PA';
      1504109: Cidade := 'Magalhaes Barata/PA';
      1504208: Cidade := 'Maraba/PA';
      1504307: Cidade := 'Maracana/PA';
      1504406: Cidade := 'Marapanim/PA';
      1504422: Cidade := 'Marituba/PA';
      1504455: Cidade := 'Medicilandia/PA';
      1504505: Cidade := 'Melgaco/PA';
      1504604: Cidade := 'Mocajuba/PA';
      1504703: Cidade := 'Moju/PA';
      1504802: Cidade := 'Monte Alegre/PA';
      1504901: Cidade := 'Muana/PA';
      1504950: Cidade := 'Nova Esperanca Do Piria/PA';
      1504976: Cidade := 'Nova Ipixuna/PA';
      1505007: Cidade := 'Nova Timboteua/PA';
      1505031: Cidade := 'Novo Progresso/PA';
      1505064: Cidade := 'Novo Repartimento/PA';
      1505106: Cidade := 'Obidos/PA';
      1505205: Cidade := 'Oeiras Do Para/PA';
      1505304: Cidade := 'Oriximina/PA';
      1505403: Cidade := 'Ourem/PA';
      1505437: Cidade := 'Ourilandia Do Norte/PA';
      1505486: Cidade := 'Pacaja/PA';
      1505494: Cidade := 'Palestina Do Para/PA';
      1505502: Cidade := 'Paragominas/PA';
      1505536: Cidade := 'Parauapebas/PA';
      1505551: Cidade := 'Pau D Arco/PA';
      1505601: Cidade := 'Peixe-Boi/PA';
      1505635: Cidade := 'Picarra/PA';
      1505650: Cidade := 'Placas/PA';
      1505700: Cidade := 'Ponta De Pedras/PA';
      1505809: Cidade := 'Portel/PA';
      1505908: Cidade := 'Porto De Moz/PA';
      1506005: Cidade := 'Prainha/PA';
      1506104: Cidade := 'Primavera/PA';
      1506112: Cidade := 'Quatipuru/PA';
      1506138: Cidade := 'Redencao/PA';
      1506161: Cidade := 'Rio Maria/PA';
      1506187: Cidade := 'Rondon Do Para/PA';
      1506195: Cidade := 'Ruropolis/PA';
      1506203: Cidade := 'Salinopolis/PA';
      1506302: Cidade := 'Salvaterra/PA';
      1506351: Cidade := 'Santa Barbara Do Para/PA';
      1506401: Cidade := 'Santa Cruz Do Arari/PA';
      1506500: Cidade := 'Santa Isabel Do Para/PA';
      1506559: Cidade := 'Santa Luzia Do Para/PA';
      1506583: Cidade := 'Santa Maria Das Barreiras/PA';
      1506609: Cidade := 'Santa Maria Do Para/PA';
      1506708: Cidade := 'Santana Do Araguaia/PA';
      1506807: Cidade := 'Santarem/PA';
      1506906: Cidade := 'Santarem Novo/PA';
      1507003: Cidade := 'Santo Antonio Do Taua/PA';
      1507102: Cidade := 'Sao Caetano De Odivelas/PA';
      1507151: Cidade := 'Sao Domingos Do Araguaia/PA';
      1507201: Cidade := 'Sao Domingos Do Capim/PA';
      1507300: Cidade := 'Sao Felix Do Xingu/PA';
      1507409: Cidade := 'Sao Francisco Do Para/PA';
      1507458: Cidade := 'Sao Geraldo Do Araguaia/PA';
      1507466: Cidade := 'Sao Joao Da Ponta/PA';
      1507474: Cidade := 'Sao Joao De Pirabas/PA';
      1507508: Cidade := 'Sao Joao Do Araguaia/PA';
      1507607: Cidade := 'Sao Miguel Do Guama/PA';
      1507706: Cidade := 'Sao Sebastiao Da Boa Vista/PA';
      1507755: Cidade := 'Sapucaia/PA';
      1507805: Cidade := 'Senador Jose Porfirio/PA';
      1507904: Cidade := 'Soure/PA';
      1507953: Cidade := 'Tailandia/PA';
      1507961: Cidade := 'Terra Alta/PA';
      1507979: Cidade := 'Terra Santa/PA';
      1508001: Cidade := 'Tome-Acu/PA';
      1508035: Cidade := 'Tracuateua/PA';
      1508050: Cidade := 'Trairao/PA';
      1508084: Cidade := 'Tucuma/PA';
      1508100: Cidade := 'Tucurui/PA';
      1508126: Cidade := 'Ulianopolis/PA';
      1508159: Cidade := 'Uruara/PA';
      1508209: Cidade := 'Vigia/PA';
      1508308: Cidade := 'Viseu/PA';
      1508357: Cidade := 'Vitoria Do Xingu/PA';
      1508407: Cidade := 'Xinguara/PA';
   end;
 end;

 procedure P16;
 begin
   case ACodigo of
      1600055: Cidade := 'Serra Do Navio/AP';
      1600105: Cidade := 'Amapa/AP';
      1600154: Cidade := 'Pedra Branca Do Amapari/AP';
      1600204: Cidade := 'Calcoene/AP';
      1600212: Cidade := 'Cutias/AP';
      1600238: Cidade := 'Ferreira Gomes/AP';
      1600253: Cidade := 'Itaubal/AP';
      1600279: Cidade := 'Laranjal Do Jari/AP';
      1600303: Cidade := 'Macapa/AP';
      1600402: Cidade := 'Mazagao/AP';
      1600501: Cidade := 'Oiapoque/AP';
      1600535: Cidade := 'Porto Grande/AP';
      1600550: Cidade := 'Pracuuba/AP';
      1600600: Cidade := 'Santana/AP';
      1600709: Cidade := 'Tartarugalzinho/AP';
      1600808: Cidade := 'Vitoria Do Jari/AP';
   end;
 end;

 procedure P17;
 begin
   case ACodigo of
      1700251: Cidade := 'Abreulandia/TO';
      1700301: Cidade := 'Aguiarnopolis/TO';
      1700350: Cidade := 'Alianca Do Tocantins/TO';
      1700400: Cidade := 'Almas/TO';
      1700707: Cidade := 'Alvorada/TO';
      1701002: Cidade := 'Ananas/TO';
      1701051: Cidade := 'Angico/TO';
      1701101: Cidade := 'Aparecida Do Rio Negro/TO';
      1701309: Cidade := 'Aragominas/TO';
      1701903: Cidade := 'Araguacema/TO';
      1702000: Cidade := 'Araguacu/TO';
      1702109: Cidade := 'Araguaina/TO';
      1702158: Cidade := 'Araguana/TO';
      1702208: Cidade := 'Araguatins/TO';
      1702307: Cidade := 'Arapoema/TO';
      1702406: Cidade := 'Arraias/TO';
      1702554: Cidade := 'Augustinopolis/TO';
      1702703: Cidade := 'Aurora Do Tocantins/TO';
      1702901: Cidade := 'Axixa Do Tocantins/TO';
      1703008: Cidade := 'Babaculandia/TO';
      1703057: Cidade := 'Bandeirantes Do Tocantins/TO';
      1703073: Cidade := 'Barra Do Ouro/TO';
      1703107: Cidade := 'Barrolandia/TO';
      1703206: Cidade := 'Bernardo Sayao/TO';
      1703305: Cidade := 'Bom Jesus Do Tocantins/TO';
      1703602: Cidade := 'Brasilandia Do Tocantins/TO';
      1703701: Cidade := 'Brejinho De Nazare/TO';
      1703800: Cidade := 'Buriti Do Tocantins/TO';
      1703826: Cidade := 'Cachoeirinha/TO';
      1703842: Cidade := 'Campos Lindos/TO';
      1703867: Cidade := 'Cariri Do Tocantins/TO';
      1703883: Cidade := 'Carmolandia/TO';
      1703891: Cidade := 'Carrasco Bonito/TO';
      1703909: Cidade := 'Caseara/TO';
      1704105: Cidade := 'Centenario/TO';
      1704600: Cidade := 'Chapada De Areia/TO';
      1705102: Cidade := 'Chapada Da Natividade/TO';
      1705508: Cidade := 'Colinas Do Tocantins/TO';
      1705557: Cidade := 'Combinado/TO';
      1705607: Cidade := 'Conceicao Do Tocantins/TO';
      1706001: Cidade := 'Couto Magalhaes/TO';
      1706100: Cidade := 'Cristalandia/TO';
      1706258: Cidade := 'Crixas Do Tocantins/TO';
      1706506: Cidade := 'Darcinopolis/TO';
      1707009: Cidade := 'Dianopolis/TO';
      1707108: Cidade := 'Divinopolis Do Tocantins/TO';
      1707207: Cidade := 'Dois Irmaos Do Tocantins/TO';
      1707306: Cidade := 'Duere/TO';
      1707405: Cidade := 'Esperantina/TO';
      1707553: Cidade := 'Fatima/TO';
      1707652: Cidade := 'Figueiropolis/TO';
      1707702: Cidade := 'Filadelfia/TO';
      1708205: Cidade := 'Formoso Do Araguaia/TO';
      1708254: Cidade := 'Fortaleza Do Tabocao/TO';
      1708304: Cidade := 'Goianorte/TO';
      1709005: Cidade := 'Goiatins/TO';
      1709302: Cidade := 'Guarai/TO';
      1709500: Cidade := 'Gurupi/TO';
      1709807: Cidade := 'Ipueiras/TO';
      1710508: Cidade := 'Itacaja/TO';
      1710706: Cidade := 'Itaguatins/TO';
      1710904: Cidade := 'Itapiratins/TO';
      1711100: Cidade := 'Itapora Do Tocantins/TO';
      1711506: Cidade := 'Jau Do Tocantins/TO';
      1711803: Cidade := 'Juarina/TO';
      1711902: Cidade := 'Lagoa Da Confusao/TO';
      1711951: Cidade := 'Lagoa Do Tocantins/TO';
      1712009: Cidade := 'Lajeado/TO';
      1712157: Cidade := 'Lavandeira/TO';
      1712405: Cidade := 'Lizarda/TO';
      1712454: Cidade := 'Luzinopolis/TO';
      1712504: Cidade := 'Marianopolis Do Tocantins/TO';
      1712702: Cidade := 'Mateiros/TO';
      1712801: Cidade := 'Maurilandia Do Tocantins/TO';
      1713205: Cidade := 'Miracema Do Tocantins/TO';
      1713304: Cidade := 'Miranorte/TO';
      1713601: Cidade := 'Monte Do Carmo/TO';
      1713700: Cidade := 'Monte Santo Do Tocantins/TO';
      1713809: Cidade := 'Palmeiras Do Tocantins/TO';
      1713957: Cidade := 'Muricilandia/TO';
      1714203: Cidade := 'Natividade/TO';
      1714302: Cidade := 'Nazare/TO';
      1714880: Cidade := 'Nova Olinda/TO';
      1715002: Cidade := 'Nova Rosalandia/TO';
      1715101: Cidade := 'Novo Acordo/TO';
      1715150: Cidade := 'Novo Alegre/TO';
      1715259: Cidade := 'Novo Jardim/TO';
      1715507: Cidade := 'Oliveira De Fatima/TO';
      1715705: Cidade := 'Palmeirante/TO';
      1715754: Cidade := 'Palmeiropolis/TO';
      1716109: Cidade := 'Paraiso Do Tocantins/TO';
      1716208: Cidade := 'Parana/TO';
      1716307: Cidade := 'Pau D Arco/TO';
      1716505: Cidade := 'Pedro Afonso/TO';
      1716604: Cidade := 'Peixe/TO';
      1716653: Cidade := 'Pequizeiro/TO';
      1716703: Cidade := 'Colmeia/TO';
      1717008: Cidade := 'Pindorama Do Tocantins/TO';
      1717206: Cidade := 'Piraque/TO';
      1717503: Cidade := 'Pium/TO';
      1717800: Cidade := 'Ponte Alta Do Bom Jesus/TO';
      1717909: Cidade := 'Ponte Alta Do Tocantins/TO';
      1718006: Cidade := 'Porto Alegre Do Tocantins/TO';
      1718204: Cidade := 'Porto Nacional/TO';
      1718303: Cidade := 'Praia Norte/TO';
      1718402: Cidade := 'Presidente Kennedy/TO';
      1718451: Cidade := 'Pugmil/TO';
      1718501: Cidade := 'Recursolandia/TO';
      1718550: Cidade := 'Riachinho/TO';
      1718659: Cidade := 'Rio Da Conceicao/TO';
      1718709: Cidade := 'Rio Dos Bois/TO';
      1718758: Cidade := 'Rio Sono/TO';
      1718808: Cidade := 'Sampaio/TO';
      1718840: Cidade := 'Sandolandia/TO';
      1718865: Cidade := 'Santa Fe Do Araguaia/TO';
      1718881: Cidade := 'Santa Maria Do Tocantins/TO';
      1718899: Cidade := 'Santa Rita Do Tocantins/TO';
      1718907: Cidade := 'Santa Rosa Do Tocantins/TO';
      1719004: Cidade := 'Santa Tereza Do Tocantins/TO';
      1720002: Cidade := 'Santa Terezinha Do Tocantins/TO';
      1720101: Cidade := 'Sao Bento Do Tocantins/TO';
      1720150: Cidade := 'Sao Felix Do Tocantins/TO';
      1720200: Cidade := 'Sao Miguel Do Tocantins/TO';
      1720259: Cidade := 'Sao Salvador Do Tocantins/TO';
      1720309: Cidade := 'Sao Sebastiao Do Tocantins/TO';
      1720499: Cidade := 'Sao Valerio Da Natividade/TO';
      1720655: Cidade := 'Silvanopolis/TO';
      1720804: Cidade := 'Sitio Novo Do Tocantins/TO';
      1720853: Cidade := 'Sucupira/TO';
      1720903: Cidade := 'Taguatinga/TO';
      1720937: Cidade := 'Taipas Do Tocantins/TO';
      1720978: Cidade := 'Talisma/TO';
      1721000: Cidade := 'Palmas/TO';
      1721109: Cidade := 'Tocantinia/TO';
      1721208: Cidade := 'Tocantinopolis/TO';
      1721257: Cidade := 'Tupirama/TO';
      1721307: Cidade := 'Tupiratins/TO';
      1722081: Cidade := 'Wanderlandia/TO';
      1722107: Cidade := 'Xambioa/TO';
   end;
 end;

 procedure P21;
 begin
   case ACodigo of
      2100055: Cidade := 'Acailandia/MA';
      2100105: Cidade := 'Afonso Cunha/MA';
      2100154: Cidade := 'Agua Doce Do Maranhao/MA';
      2100204: Cidade := 'Alcantara/MA';
      2100303: Cidade := 'Aldeias Altas/MA';
      2100402: Cidade := 'Altamira Do Maranhao/MA';
      2100436: Cidade := 'Alto Alegre Do Maranhao/MA';
      2100477: Cidade := 'Alto Alegre Do Pindare/MA';
      2100501: Cidade := 'Alto Parnaiba/MA';
      2100550: Cidade := 'Amapa Do Maranhao/MA';
      2100600: Cidade := 'Amarante Do Maranhao/MA';
      2100709: Cidade := 'Anajatuba/MA';
      2100808: Cidade := 'Anapurus/MA';
      2100832: Cidade := 'Apicum-Acu/MA';
      2100873: Cidade := 'Araguana/MA';
      2100907: Cidade := 'Araioses/MA';
      2100956: Cidade := 'Arame/MA';
      2101004: Cidade := 'Arari/MA';
      2101103: Cidade := 'Axixa/MA';
      2101202: Cidade := 'Bacabal/MA';
      2101251: Cidade := 'Bacabeira/MA';
      2101301: Cidade := 'Bacuri/MA';
      2101350: Cidade := 'Bacurituba/MA';
      2101400: Cidade := 'Balsas/MA';
      2101509: Cidade := 'Barao De Grajau/MA';
      2101608: Cidade := 'Barra Do Corda/MA';
      2101707: Cidade := 'Barreirinhas/MA';
      2101731: Cidade := 'Belagua/MA';
      2101772: Cidade := 'Bela Vista Do Maranhao/MA';
      2101806: Cidade := 'Benedito Leite/MA';
      2101905: Cidade := 'Bequimao/MA';
      2101939: Cidade := 'Bernardo Do Mearim/MA';
      2101970: Cidade := 'Boa Vista Do Gurupi/MA';
      2102002: Cidade := 'Bom Jardim/MA';
      2102036: Cidade := 'Bom Jesus Das Selvas/MA';
      2102077: Cidade := 'Bom Lugar/MA';
      2102101: Cidade := 'Brejo/MA';
      2102150: Cidade := 'Brejo De Areia/MA';
      2102200: Cidade := 'Buriti/MA';
      2102309: Cidade := 'Buriti Bravo/MA';
      2102325: Cidade := 'Buriticupu/MA';
      2102358: Cidade := 'Buritirana/MA';
      2102374: Cidade := 'Cachoeira Grande/MA';
      2102408: Cidade := 'Cajapio/MA';
      2102507: Cidade := 'Cajari/MA';
      2102556: Cidade := 'Campestre Do Maranhao/MA';
      2102606: Cidade := 'Candido Mendes/MA';
      2102705: Cidade := 'Cantanhede/MA';
      2102754: Cidade := 'Capinzal Do Norte/MA';
      2102804: Cidade := 'Carolina/MA';
      2102903: Cidade := 'Carutapera/MA';
      2103000: Cidade := 'Caxias/MA';
      2103109: Cidade := 'Cedral/MA';
      2103125: Cidade := 'Central Do Maranhao/MA';
      2103158: Cidade := 'Centro Do Guilherme/MA';
      2103174: Cidade := 'Centro Novo Do Maranhao/MA';
      2103208: Cidade := 'Chapadinha/MA';
      2103257: Cidade := 'Cidelandia/MA';
      2103307: Cidade := 'Codo/MA';
      2103406: Cidade := 'Coelho Neto/MA';
      2103505: Cidade := 'Colinas/MA';
      2103554: Cidade := 'Conceicao Do Lago-Acu/MA';
      2103604: Cidade := 'Coroata/MA';
      2103703: Cidade := 'Cururupu/MA';
      2103752: Cidade := 'Davinopolis/MA';
      2103802: Cidade := 'Dom Pedro/MA';
      2103901: Cidade := 'Duque Bacelar/MA';
      2104008: Cidade := 'Esperantinopolis/MA';
      2104057: Cidade := 'Estreito/MA';
      2104073: Cidade := 'Feira Nova Do Maranhao/MA';
      2104081: Cidade := 'Fernando Falcao/MA';
      2104099: Cidade := 'Formosa Da Serra Negra/MA';
      2104107: Cidade := 'Fortaleza Dos Nogueiras/MA';
      2104206: Cidade := 'Fortuna/MA';
      2104305: Cidade := 'Godofredo Viana/MA';
      2104404: Cidade := 'Goncalves Dias/MA';
      2104503: Cidade := 'Governador Archer/MA';
      2104552: Cidade := 'Governador Edison Lobao/MA';
      2104602: Cidade := 'Governador Eugenio Barros/MA';
      2104628: Cidade := 'Governador Luiz Rocha/MA';
      2104651: Cidade := 'Governador Newton Bello/MA';
      2104677: Cidade := 'Governador Nunes Freire/MA';
      2104701: Cidade := 'Graca Aranha/MA';
      2104800: Cidade := 'Grajau/MA';
      2104909: Cidade := 'Guimaraes/MA';
      2105005: Cidade := 'Humberto De Campos/MA';
      2105104: Cidade := 'Icatu/MA';
      2105153: Cidade := 'Igarape Do Meio/MA';
      2105203: Cidade := 'Igarape Grande/MA';
      2105302: Cidade := 'Imperatriz/MA';
      2105351: Cidade := 'Itaipava Do Grajau/MA';
      2105401: Cidade := 'Itapecuru Mirim/MA';
      2105427: Cidade := 'Itinga Do Maranhao/MA';
      2105450: Cidade := 'Jatoba/MA';
      2105476: Cidade := 'Jenipapo Dos Vieiras/MA';
      2105500: Cidade := 'Joao Lisboa/MA';
      2105609: Cidade := 'Joselandia/MA';
      2105658: Cidade := 'Junco Do Maranhao/MA';
      2105708: Cidade := 'Lago Da Pedra/MA';
      2105807: Cidade := 'Lago Do Junco/MA';
      2105906: Cidade := 'Lago Verde/MA';
      2105922: Cidade := 'Lagoa Do Mato/MA';
      2105948: Cidade := 'Lago Dos Rodrigues/MA';
      2105963: Cidade := 'Lagoa Grande Do Maranhao/MA';
      2105989: Cidade := 'Lajeado Novo/MA';
      2106003: Cidade := 'Lima Campos/MA';
      2106102: Cidade := 'Loreto/MA';
      2106201: Cidade := 'Luis Domingues/MA';
      2106300: Cidade := 'Magalhaes De Almeida/MA';
      2106326: Cidade := 'Maracacume/MA';
      2106359: Cidade := 'Maraja Do Sena/MA';
      2106375: Cidade := 'Maranhaozinho/MA';
      2106409: Cidade := 'Mata Roma/MA';
      2106508: Cidade := 'Matinha/MA';
      2106607: Cidade := 'Matoes/MA';
      2106631: Cidade := 'Matoes Do Norte/MA';
      2106672: Cidade := 'Milagres Do Maranhao/MA';
      2106706: Cidade := 'Mirador/MA';
      2106755: Cidade := 'Miranda Do Norte/MA';
      2106805: Cidade := 'Mirinzal/MA';
      2106904: Cidade := 'Moncao/MA';
      2107001: Cidade := 'Montes Altos/MA';
      2107100: Cidade := 'Morros/MA';
      2107209: Cidade := 'Nina Rodrigues/MA';
      2107258: Cidade := 'Nova Colinas/MA';
      2107308: Cidade := 'Nova Iorque/MA';
      2107357: Cidade := 'Nova Olinda Do Maranhao/MA';
      2107407: Cidade := 'Olho D Agua Das Cunhas/MA';
      2107456: Cidade := 'Olinda Nova Do Maranhao/MA';
      2107506: Cidade := 'Paco Do Lumiar/MA';
      2107605: Cidade := 'Palmeirandia/MA';
      2107704: Cidade := 'Paraibano/MA';
      2107803: Cidade := 'Parnarama/MA';
      2107902: Cidade := 'Passagem Franca/MA';
      2108009: Cidade := 'Pastos Bons/MA';
      2108058: Cidade := 'Paulino Neves/MA';
      2108108: Cidade := 'Paulo Ramos/MA';
      2108207: Cidade := 'Pedreiras/MA';
      2108256: Cidade := 'Pedro Do Rosario/MA';
      2108306: Cidade := 'Penalva/MA';
      2108405: Cidade := 'Peri Mirim/MA';
      2108454: Cidade := 'Peritoro/MA';
      2108504: Cidade := 'Pindare-Mirim/MA';
      2108603: Cidade := 'Pinheiro/MA';
      2108702: Cidade := 'Pio Xii/MA';
      2108801: Cidade := 'Pirapemas/MA';
      2108900: Cidade := 'Pocao De Pedras/MA';
      2109007: Cidade := 'Porto Franco/MA';
      2109056: Cidade := 'Porto Rico Do Maranhao/MA';
      2109106: Cidade := 'Presidente Dutra/MA';
      2109205: Cidade := 'Presidente Juscelino/MA';
      2109239: Cidade := 'Presidente Medici/MA';
      2109270: Cidade := 'Presidente Sarney/MA';
      2109304: Cidade := 'Presidente Vargas/MA';
      2109403: Cidade := 'Primeira Cruz/MA';
      2109452: Cidade := 'Raposa/MA';
      2109502: Cidade := 'Riachao/MA';
      2109551: Cidade := 'Ribamar Fiquene/MA';
      2109601: Cidade := 'Rosario/MA';
      2109700: Cidade := 'Sambaiba/MA';
      2109759: Cidade := 'Santa Filomena Do Maranhao/MA';
      2109809: Cidade := 'Santa Helena/MA';
      2109908: Cidade := 'Santa Ines/MA';
      2110005: Cidade := 'Santa Luzia/MA';
      2110039: Cidade := 'Santa Luzia Do Parua/MA';
      2110104: Cidade := 'Santa Quiteria Do Maranhao/MA';
      2110203: Cidade := 'Santa Rita/MA';
      2110237: Cidade := 'Santana Do Maranhao/MA';
      2110278: Cidade := 'Santo Amaro Do Maranhao/MA';
      2110302: Cidade := 'Santo Antonio Dos Lopes/MA';
      2110401: Cidade := 'Sao Benedito Do Rio Preto/MA';
      2110500: Cidade := 'Sao Bento/MA';
      2110609: Cidade := 'Sao Bernardo/MA';
      2110658: Cidade := 'Sao Domingos Do Azeitao/MA';
      2110708: Cidade := 'Sao Domingos Do Maranhao/MA';
      2110807: Cidade := 'Sao Felix De Balsas/MA';
      2110856: Cidade := 'Sao Francisco Do Brejao/MA';
      2110906: Cidade := 'Sao Francisco Do Maranhao/MA';
      2111003: Cidade := 'Sao Joao Batista/MA';
      2111029: Cidade := 'Sao Joao Do Caru/MA';
      2111052: Cidade := 'Sao Joao Do Paraiso/MA';
      2111078: Cidade := 'Sao Joao Do Soter/MA';
      2111102: Cidade := 'Sao Joao Dos Patos/MA';
      2111201: Cidade := 'Sao Jose De Ribamar/MA';
      2111250: Cidade := 'Sao Jose Dos Basilios/MA';
      2111300: Cidade := 'Sao Luis/MA';
      2111409: Cidade := 'Sao Luis Gonzaga Do Maranhao/MA';
      2111508: Cidade := 'Sao Mateus Do Maranhao/MA';
      2111532: Cidade := 'Sao Pedro Da Agua Branca/MA';
      2111573: Cidade := 'Sao Pedro Dos Crentes/MA';
      2111607: Cidade := 'Sao Raimundo Das Mangabeiras/MA';
      2111631: Cidade := 'Sao Raimundo Do Doca Bezerra/MA';
      2111672: Cidade := 'Sao Roberto/MA';
      2111706: Cidade := 'Sao Vicente Ferrer/MA';
      2111722: Cidade := 'Satubinha/MA';
      2111748: Cidade := 'Senador Alexandre Costa/MA';
      2111763: Cidade := 'Senador La Rocque/MA';
      2111789: Cidade := 'Serrano Do Maranhao/MA';
      2111805: Cidade := 'Sitio Novo/MA';
      2111904: Cidade := 'Sucupira Do Norte/MA';
      2111953: Cidade := 'Sucupira Do Riachao/MA';
      2112001: Cidade := 'Tasso Fragoso/MA';
      2112100: Cidade := 'Timbiras/MA';
      2112209: Cidade := 'Timon/MA';
      2112233: Cidade := 'Trizidela Do Vale/MA';
      2112274: Cidade := 'Tufilandia/MA';
      2112308: Cidade := 'Tuntum/MA';
      2112407: Cidade := 'Turiacu/MA';
      2112456: Cidade := 'Turilandia/MA';
      2112506: Cidade := 'Tutoia/MA';
      2112605: Cidade := 'Urbano Santos/MA';
      2112704: Cidade := 'Vargem Grande/MA';
      2112803: Cidade := 'Viana/MA';
      2112852: Cidade := 'Vila Nova Dos Martirios/MA';
      2112902: Cidade := 'Vitoria Do Mearim/MA';
      2113009: Cidade := 'Vitorino Freire/MA';
      2114007: Cidade := 'Ze Doca/MA';
   end;
 end;

 procedure P22;
 begin
   case ACodigo of
      2200053: Cidade := 'Acaua/PI';
      2200103: Cidade := 'Agricolandia/PI';
      2200202: Cidade := 'Agua Branca/PI';
      2200251: Cidade := 'Alagoinha Do Piaui/PI';
      2200277: Cidade := 'Alegrete Do Piaui/PI';
      2200301: Cidade := 'Alto Longa/PI';
      2200400: Cidade := 'Altos/PI';
      2200459: Cidade := 'Alvorada Do Gurgueia/PI';
      2200509: Cidade := 'Amarante/PI';
      2200608: Cidade := 'Angical Do Piaui/PI';
      2200707: Cidade := 'Anisio De Abreu/PI';
      2200806: Cidade := 'Antonio Almeida/PI';
      2200905: Cidade := 'Aroazes/PI';
      2200954: Cidade := 'Aroeiras Do Itaim/PI';
      2201002: Cidade := 'Arraial/PI';
      2201051: Cidade := 'Assuncao Do Piaui/PI';
      2201101: Cidade := 'Avelino Lopes/PI';
      2201150: Cidade := 'Baixa Grande Do Ribeiro/PI';
      2201176: Cidade := 'Barra D Alcantara/PI';
      2201200: Cidade := 'Barras/PI';
      2201309: Cidade := 'Barreiras Do Piaui/PI';
      2201408: Cidade := 'Barro Duro/PI';
      2201507: Cidade := 'Batalha/PI';
      2201556: Cidade := 'Bela Vista Do Piaui/PI';
      2201572: Cidade := 'Belem Do Piaui/PI';
      2201606: Cidade := 'Beneditinos/PI';
      2201705: Cidade := 'Bertolinia/PI';
      2201739: Cidade := 'Betania Do Piaui/PI';
      2201770: Cidade := 'Boa Hora/PI';
      2201804: Cidade := 'Bocaina/PI';
      2201903: Cidade := 'Bom Jesus/PI';
      2201919: Cidade := 'Bom Principio Do Piaui/PI';
      2201929: Cidade := 'Bonfim Do Piaui/PI';
      2201945: Cidade := 'Boqueirao Do Piaui/PI';
      2201960: Cidade := 'Brasileira/PI';
      2201988: Cidade := 'Brejo Do Piaui/PI';
      2202000: Cidade := 'Buriti Dos Lopes/PI';
      2202026: Cidade := 'Buriti Dos Montes/PI';
      2202059: Cidade := 'Cabeceiras Do Piaui/PI';
      2202075: Cidade := 'Cajazeiras Do Piaui/PI';
      2202083: Cidade := 'Cajueiro Da Praia/PI';
      2202091: Cidade := 'Caldeirao Grande Do Piaui/PI';
      2202109: Cidade := 'Campinas Do Piaui/PI';
      2202117: Cidade := 'Campo Alegre Do Fidalgo/PI';
      2202133: Cidade := 'Campo Grande Do Piaui/PI';
      2202174: Cidade := 'Campo Largo Do Piaui/PI';
      2202208: Cidade := 'Campo Maior/PI';
      2202251: Cidade := 'Canavieira/PI';
      2202307: Cidade := 'Canto Do Buriti/PI';
      2202406: Cidade := 'Capitao De Campos/PI';
      2202455: Cidade := 'Capitao Gervasio Oliveira/PI';
      2202505: Cidade := 'Caracol/PI';
      2202539: Cidade := 'Caraubas Do Piaui/PI';
      2202554: Cidade := 'Caridade Do Piaui/PI';
      2202604: Cidade := 'Castelo Do Piaui/PI';
      2202653: Cidade := 'Caxingo/PI';
      2202703: Cidade := 'Cocal/PI';
      2202711: Cidade := 'Cocal De Telha/PI';
      2202729: Cidade := 'Cocal Dos Alves/PI';
      2202737: Cidade := 'Coivaras/PI';
      2202752: Cidade := 'Colonia Do Gurgueia/PI';
      2202778: Cidade := 'Colonia Do Piaui/PI';
      2202802: Cidade := 'Conceicao Do Caninde/PI';
      2202851: Cidade := 'Coronel Jose Dias/PI';
      2202901: Cidade := 'Corrente/PI';
      2203008: Cidade := 'Cristalandia Do Piaui/PI';
      2203107: Cidade := 'Cristino Castro/PI';
      2203206: Cidade := 'Curimata/PI';
      2203230: Cidade := 'Currais/PI';
      2203255: Cidade := 'Curralinhos/PI';
      2203271: Cidade := 'Curral Novo Do Piaui/PI';
      2203305: Cidade := 'Demerval Lobao/PI';
      2203354: Cidade := 'Dirceu Arcoverde/PI';
      2203404: Cidade := 'Dom Expedito Lopes/PI';
      2203420: Cidade := 'Domingos Mourao/PI';
      2203453: Cidade := 'Dom Inocencio/PI';
      2203503: Cidade := 'Elesbao Veloso/PI';
      2203602: Cidade := 'Eliseu Martins/PI';
      2203701: Cidade := 'Esperantina/PI';
      2203750: Cidade := 'Fartura Do Piaui/PI';
      2203800: Cidade := 'Flores Do Piaui/PI';
      2203859: Cidade := 'Floresta Do Piaui/PI';
      2203909: Cidade := 'Floriano/PI';
      2204006: Cidade := 'Francinopolis/PI';
      2204105: Cidade := 'Francisco Ayres/PI';
      2204154: Cidade := 'Francisco Macedo/PI';
      2204204: Cidade := 'Francisco Santos/PI';
      2204303: Cidade := 'Fronteiras/PI';
      2204352: Cidade := 'Geminiano/PI';
      2204402: Cidade := 'Gilbues/PI';
      2204501: Cidade := 'Guadalupe/PI';
      2204550: Cidade := 'Guaribas/PI';
      2204600: Cidade := 'Hugo Napoleao/PI';
      2204659: Cidade := 'Ilha Grande/PI';
      2204709: Cidade := 'Inhuma/PI';
      2204808: Cidade := 'Ipiranga Do Piaui/PI';
      2204907: Cidade := 'Isaias Coelho/PI';
      2205003: Cidade := 'Itainopolis/PI';
      2205102: Cidade := 'Itaueira/PI';
      2205151: Cidade := 'Jacobina Do Piaui/PI';
      2205201: Cidade := 'Jaicos/PI';
      2205250: Cidade := 'Jardim Do Mulato/PI';
      2205276: Cidade := 'Jatoba Do Piaui/PI';
      2205300: Cidade := 'Jerumenha/PI';
      2205359: Cidade := 'Joao Costa/PI';
      2205409: Cidade := 'Joaquim Pires/PI';
      2205458: Cidade := 'Joca Marques/PI';
      2205508: Cidade := 'Jose De Freitas/PI';
      2205516: Cidade := 'Juazeiro Do Piaui/PI';
      2205524: Cidade := 'Julio Borges/PI';
      2205532: Cidade := 'Jurema/PI';
      2205540: Cidade := 'Lagoinha Do Piaui/PI';
      2205557: Cidade := 'Lagoa Alegre/PI';
      2205565: Cidade := 'Lagoa Do Barro Do Piaui/PI';
      2205573: Cidade := 'Lagoa De Sao Francisco/PI';
      2205581: Cidade := 'Lagoa Do Piaui/PI';
      2205599: Cidade := 'Lagoa Do Sitio/PI';
      2205607: Cidade := 'Landri Sales/PI';
      2205706: Cidade := 'Luis Correia/PI';
      2205805: Cidade := 'Luzilandia/PI';
      2205854: Cidade := 'Madeiro/PI';
      2205904: Cidade := 'Manoel Emidio/PI';
      2205953: Cidade := 'Marcolandia/PI';
      2206001: Cidade := 'Marcos Parente/PI';
      2206050: Cidade := 'Massape Do Piaui/PI';
      2206100: Cidade := 'Matias Olimpio/PI';
      2206209: Cidade := 'Miguel Alves/PI';
      2206308: Cidade := 'Miguel Leao/PI';
      2206357: Cidade := 'Milton Brandao/PI';
      2206407: Cidade := 'Monsenhor Gil/PI';
      2206506: Cidade := 'Monsenhor Hipolito/PI';
      2206605: Cidade := 'Monte Alegre Do Piaui/PI';
      2206654: Cidade := 'Morro Cabeca No Tempo/PI';
      2206670: Cidade := 'Morro Do Chapeu Do Piaui/PI';
      2206696: Cidade := 'Murici Dos Portelas/PI';
      2206704: Cidade := 'Nazare Do Piaui/PI';
      2206753: Cidade := 'Nossa Senhora De Nazare/PI';
      2206803: Cidade := 'Nossa Senhora Dos Remedios/PI';
      2206902: Cidade := 'Novo Oriente Do Piaui/PI';
      2206951: Cidade := 'Novo Santo Antonio/PI';
      2207009: Cidade := 'Oeiras/PI';
      2207108: Cidade := 'Olho D Agua Do Piaui/PI';
      2207207: Cidade := 'Padre Marcos/PI';
      2207306: Cidade := 'Paes Landim/PI';
      2207355: Cidade := 'Pajeu Do Piaui/PI';
      2207405: Cidade := 'Palmeira Do Piaui/PI';
      2207504: Cidade := 'Palmeirais/PI';
      2207553: Cidade := 'Paqueta/PI';
      2207603: Cidade := 'Parnagua/PI';
      2207702: Cidade := 'Parnaiba/PI';
      2207751: Cidade := 'Passagem Franca Do Piaui/PI';
      2207777: Cidade := 'Patos Do Piaui/PI';
      2207793: Cidade := 'Pau D Arco Do Piaui/PI';
      2207801: Cidade := 'Paulistana/PI';
      2207850: Cidade := 'Pavussu/PI';
      2207900: Cidade := 'Pedro Ii/PI';
      2207934: Cidade := 'Pedro Laurentino/PI';
      2207959: Cidade := 'Nova Santa Rita/PI';
      2208007: Cidade := 'Picos/PI';
      2208106: Cidade := 'Pimenteiras/PI';
      2208205: Cidade := 'Pio Ix/PI';
      2208304: Cidade := 'Piracuruca/PI';
      2208403: Cidade := 'Piripiri/PI';
      2208502: Cidade := 'Porto/PI';
      2208551: Cidade := 'Porto Alegre Do Piaui/PI';
      2208601: Cidade := 'Prata Do Piaui/PI';
      2208650: Cidade := 'Queimada Nova/PI';
      2208700: Cidade := 'Redencao Do Gurgueia/PI';
      2208809: Cidade := 'Regeneracao/PI';
      2208858: Cidade := 'Riacho Frio/PI';
      2208874: Cidade := 'Ribeira Do Piaui/PI';
      2208908: Cidade := 'Ribeiro Goncalves/PI';
      2209005: Cidade := 'Rio Grande Do Piaui/PI';
      2209104: Cidade := 'Santa Cruz Do Piaui/PI';
      2209153: Cidade := 'Santa Cruz Dos Milagres/PI';
      2209203: Cidade := 'Santa Filomena/PI';
      2209302: Cidade := 'Santa Luz/PI';
      2209351: Cidade := 'Santana Do Piaui/PI';
      2209377: Cidade := 'Santa Rosa Do Piaui/PI';
      2209401: Cidade := 'Santo Antonio De Lisboa/PI';
      2209450: Cidade := 'Santo Antonio Dos Milagres/PI';
      2209500: Cidade := 'Santo Inacio Do Piaui/PI';
      2209559: Cidade := 'Sao Braz Do Piaui/PI';
      2209609: Cidade := 'Sao Felix Do Piaui/PI';
      2209658: Cidade := 'Sao Francisco De Assis Do Piaui/PI';
      2209708: Cidade := 'Sao Francisco Do Piaui/PI';
      2209757: Cidade := 'Sao Goncalo Do Gurgueia/PI';
      2209807: Cidade := 'Sao Goncalo Do Piaui/PI';
      2209856: Cidade := 'Sao Joao Da Canabrava/PI';
      2209872: Cidade := 'Sao Joao Da Fronteira/PI';
      2209906: Cidade := 'Sao Joao Da Serra/PI';
      2209955: Cidade := 'Sao Joao Da Varjota/PI';
      2209971: Cidade := 'Sao Joao Do Arraial/PI';
      2210003: Cidade := 'Sao Joao Do Piaui/PI';
      2210052: Cidade := 'Sao Jose Do Divino/PI';
      2210102: Cidade := 'Sao Jose Do Peixe/PI';
      2210201: Cidade := 'Sao Jose Do Piaui/PI';
      2210300: Cidade := 'Sao Juliao/PI';
      2210359: Cidade := 'Sao Lourenco Do Piaui/PI';
      2210375: Cidade := 'Sao Luis Do Piaui/PI';
      2210383: Cidade := 'Sao Miguel Da Baixa Grande/PI';
      2210391: Cidade := 'Sao Miguel Do Fidalgo/PI';
      2210409: Cidade := 'Sao Miguel Do Tapuio/PI';
      2210508: Cidade := 'Sao Pedro Do Piaui/PI';
      2210607: Cidade := 'Sao Raimundo Nonato/PI';
      2210623: Cidade := 'Sebastiao Barros/PI';
      2210631: Cidade := 'Sebastiao Leal/PI';
      2210656: Cidade := 'Sigefredo Pacheco/PI';
      2210706: Cidade := 'Simoes/PI';
      2210805: Cidade := 'Simplicio Mendes/PI';
      2210904: Cidade := 'Socorro Do Piaui/PI';
      2210938: Cidade := 'Sussuapara/PI';
      2210953: Cidade := 'Tamboril Do Piaui/PI';
      2210979: Cidade := 'Tanque Do Piaui/PI';
      2211001: Cidade := 'Teresina/PI';
      2211100: Cidade := 'Uniao/PI';
      2211209: Cidade := 'Urucui/PI';
      2211308: Cidade := 'Valenca Do Piaui/PI';
      2211357: Cidade := 'Varzea Branca/PI';
      2211407: Cidade := 'Varzea Grande/PI';
      2211506: Cidade := 'Vera Mendes/PI';
      2211605: Cidade := 'Vila Nova Do Piaui/PI';
      2211704: Cidade := 'Wall Ferraz/PI';
   end;
 end;

 procedure P23;
 begin
   case ACodigo of
      2300101: Cidade := 'Abaiara/CE';
      2300150: Cidade := 'Acarape/CE';
      2300200: Cidade := 'Acarau/CE';
      2300309: Cidade := 'Acopiara/CE';
      2300408: Cidade := 'Aiuaba/CE';
      2300507: Cidade := 'Alcantaras/CE';
      2300606: Cidade := 'Altaneira/CE';
      2300705: Cidade := 'Alto Santo/CE';
      2300754: Cidade := 'Amontada/CE';
      2300804: Cidade := 'Antonina Do Norte/CE';
      2300903: Cidade := 'Apuiares/CE';
      2301000: Cidade := 'Aquiraz/CE';
      2301109: Cidade := 'Aracati/CE';
      2301208: Cidade := 'Aracoiaba/CE';
      2301257: Cidade := 'Ararenda/CE';
      2301307: Cidade := 'Araripe/CE';
      2301406: Cidade := 'Aratuba/CE';
      2301505: Cidade := 'Arneiroz/CE';
      2301604: Cidade := 'Assare/CE';
      2301703: Cidade := 'Aurora/CE';
      2301802: Cidade := 'Baixio/CE';
      2301851: Cidade := 'Banabuiu/CE';
      2301901: Cidade := 'Barbalha/CE';
      2301950: Cidade := 'Barreira/CE';
      2302008: Cidade := 'Barro/CE';
      2302057: Cidade := 'Barroquinha/CE';
      2302107: Cidade := 'Baturite/CE';
      2302206: Cidade := 'Beberibe/CE';
      2302305: Cidade := 'Bela Cruz/CE';
      2302404: Cidade := 'Boa Viagem/CE';
      2302503: Cidade := 'Brejo Santo/CE';
      2302602: Cidade := 'Camocim/CE';
      2302701: Cidade := 'Campos Sales/CE';
      2302800: Cidade := 'Caninde/CE';
      2302909: Cidade := 'Capistrano/CE';
      2303006: Cidade := 'Caridade/CE';
      2303105: Cidade := 'Carire/CE';
      2303204: Cidade := 'Caririacu/CE';
      2303303: Cidade := 'Carius/CE';
      2303402: Cidade := 'Carnaubal/CE';
      2303501: Cidade := 'Cascavel/CE';
      2303600: Cidade := 'Catarina/CE';
      2303659: Cidade := 'Catunda/CE';
      2303709: Cidade := 'Caucaia/CE';
      2303808: Cidade := 'Cedro/CE';
      2303907: Cidade := 'Chaval/CE';
      2303931: Cidade := 'Choro/CE';
      2303956: Cidade := 'Chorozinho/CE';
      2304004: Cidade := 'Coreau/CE';
      2304103: Cidade := 'Crateus/CE';
      2304202: Cidade := 'Crato/CE';
      2304236: Cidade := 'Croata/CE';
      2304251: Cidade := 'Cruz/CE';
      2304269: Cidade := 'Deputado Irapuan Pinheiro/CE';
      2304277: Cidade := 'Erere/CE';
      2304285: Cidade := 'Eusebio/CE';
      2304301: Cidade := 'Farias Brito/CE';
      2304350: Cidade := 'Forquilha/CE';
      2304400: Cidade := 'Fortaleza/CE';
      2304459: Cidade := 'Fortim/CE';
      2304509: Cidade := 'Frecheirinha/CE';
      2304608: Cidade := 'General Sampaio/CE';
      2304657: Cidade := 'Graca/CE';
      2304707: Cidade := 'Granja/CE';
      2304806: Cidade := 'Granjeiro/CE';
      2304905: Cidade := 'Groairas/CE';
      2304954: Cidade := 'Guaiuba/CE';
      2305001: Cidade := 'Guaraciaba Do Norte/CE';
      2305100: Cidade := 'Guaramiranga/CE';
      2305209: Cidade := 'Hidrolandia/CE';
      2305233: Cidade := 'Horizonte/CE';
      2305266: Cidade := 'Ibaretama/CE';
      2305308: Cidade := 'Ibiapina/CE';
      2305332: Cidade := 'Ibicuitinga/CE';
      2305357: Cidade := 'Icapui/CE';
      2305407: Cidade := 'Ico/CE';
      2305506: Cidade := 'Iguatu/CE';
      2305605: Cidade := 'Independencia/CE';
      2305654: Cidade := 'Ipaporanga/CE';
      2305704: Cidade := 'Ipaumirim/CE';
      2305803: Cidade := 'Ipu/CE';
      2305902: Cidade := 'Ipueiras/CE';
      2306009: Cidade := 'Iracema/CE';
      2306108: Cidade := 'Iraucuba/CE';
      2306207: Cidade := 'Itaicaba/CE';
      2306256: Cidade := 'Itaitinga/CE';
      2306306: Cidade := 'Itapage/CE';
      2306405: Cidade := 'Itapipoca/CE';
      2306504: Cidade := 'Itapiuna/CE';
      2306553: Cidade := 'Itarema/CE';
      2306603: Cidade := 'Itatira/CE';
      2306702: Cidade := 'Jaguaretama/CE';
      2306801: Cidade := 'Jaguaribara/CE';
      2306900: Cidade := 'Jaguaribe/CE';
      2307007: Cidade := 'Jaguaruana/CE';
      2307106: Cidade := 'Jardim/CE';
      2307205: Cidade := 'Jati/CE';
      2307254: Cidade := 'Jijoca De Jericoacoara/CE';
      2307304: Cidade := 'Juazeiro Do Norte/CE';
      2307403: Cidade := 'Jucas/CE';
      2307502: Cidade := 'Lavras Da Mangabeira/CE';
      2307601: Cidade := 'Limoeiro Do Norte/CE';
      2307635: Cidade := 'Madalena/CE';
      2307650: Cidade := 'Maracanau/CE';
      2307700: Cidade := 'Maranguape/CE';
      2307809: Cidade := 'Marco/CE';
      2307908: Cidade := 'Martinopole/CE';
      2308005: Cidade := 'Massape/CE';
      2308104: Cidade := 'Mauriti/CE';
      2308203: Cidade := 'Meruoca/CE';
      2308302: Cidade := 'Milagres/CE';
      2308351: Cidade := 'Milha/CE';
      2308377: Cidade := 'Miraima/CE';
      2308401: Cidade := 'Missao Velha/CE';
      2308500: Cidade := 'Mombaca/CE';
      2308609: Cidade := 'Monsenhor Tabosa/CE';
      2308708: Cidade := 'Morada Nova/CE';
      2308807: Cidade := 'Moraujo/CE';
      2308906: Cidade := 'Morrinhos/CE';
      2309003: Cidade := 'Mucambo/CE';
      2309102: Cidade := 'Mulungu/CE';
      2309201: Cidade := 'Nova Olinda/CE';
      2309300: Cidade := 'Nova Russas/CE';
      2309409: Cidade := 'Novo Oriente/CE';
      2309458: Cidade := 'Ocara/CE';
      2309508: Cidade := 'Oros/CE';
      2309607: Cidade := 'Pacajus/CE';
      2309706: Cidade := 'Pacatuba/CE';
      2309805: Cidade := 'Pacoti/CE';
      2309904: Cidade := 'Pacuja/CE';
      2310001: Cidade := 'Palhano/CE';
      2310100: Cidade := 'Palmacia/CE';
      2310209: Cidade := 'Paracuru/CE';
      2310258: Cidade := 'Paraipaba/CE';
      2310308: Cidade := 'Parambu/CE';
      2310407: Cidade := 'Paramoti/CE';
      2310506: Cidade := 'Pedra Branca/CE';
      2310605: Cidade := 'Penaforte/CE';
      2310704: Cidade := 'Pentecoste/CE';
      2310803: Cidade := 'Pereiro/CE';
      2310852: Cidade := 'Pindoretama/CE';
      2310902: Cidade := 'Piquet Carneiro/CE';
      2310951: Cidade := 'Pires Ferreira/CE';
      2311009: Cidade := 'Poranga/CE';
      2311108: Cidade := 'Porteiras/CE';
      2311207: Cidade := 'Potengi/CE';
      2311231: Cidade := 'Potiretama/CE';
      2311264: Cidade := 'Quiterianopolis/CE';
      2311306: Cidade := 'Quixada/CE';
      2311355: Cidade := 'Quixelo/CE';
      2311405: Cidade := 'Quixeramobim/CE';
      2311504: Cidade := 'Quixere/CE';
      2311603: Cidade := 'Redencao/CE';
      2311702: Cidade := 'Reriutaba/CE';
      2311801: Cidade := 'Russas/CE';
      2311900: Cidade := 'Saboeiro/CE';
      2311959: Cidade := 'Salitre/CE';
      2312007: Cidade := 'Santana Do Acarau/CE';
      2312106: Cidade := 'Santana Do Cariri/CE';
      2312205: Cidade := 'Santa Quiteria/CE';
      2312304: Cidade := 'Sao Benedito/CE';
      2312403: Cidade := 'Sao Goncalo Do Amarante/CE';
      2312502: Cidade := 'Sao Joao Do Jaguaribe/CE';
      2312601: Cidade := 'Sao Luis Do Curu/CE';
      2312700: Cidade := 'Senador Pompeu/CE';
      2312809: Cidade := 'Senador Sa/CE';
      2312908: Cidade := 'Sobral/CE';
      2313005: Cidade := 'Solonopole/CE';
      2313104: Cidade := 'Tabuleiro Do Norte/CE';
      2313203: Cidade := 'Tamboril/CE';
      2313252: Cidade := 'Tarrafas/CE';
      2313302: Cidade := 'Taua/CE';
      2313351: Cidade := 'Tejucuoca/CE';
      2313401: Cidade := 'Tiangua/CE';
      2313500: Cidade := 'Trairi/CE';
      2313559: Cidade := 'Tururu/CE';
      2313609: Cidade := 'Ubajara/CE';
      2313708: Cidade := 'Umari/CE';
      2313757: Cidade := 'Umirim/CE';
      2313807: Cidade := 'Uruburetama/CE';
      2313906: Cidade := 'Uruoca/CE';
      2313955: Cidade := 'Varjota/CE';
      2314003: Cidade := 'Varzea Alegre/CE';
      2314102: Cidade := 'Vicosa Do Ceara/CE';
   end;
 end;

 procedure P24;
 begin
   case ACodigo of
      2400109: Cidade := 'Acari/RN';
      2400208: Cidade := 'Acu/RN';
      2400307: Cidade := 'Afonso Bezerra/RN';
      2400406: Cidade := 'Agua Nova/RN';
      2400505: Cidade := 'Alexandria/RN';
      2400604: Cidade := 'Almino Afonso/RN';
      2400703: Cidade := 'Alto Do Rodrigues/RN';
      2400802: Cidade := 'Angicos/RN';
      2400901: Cidade := 'Antonio Martins/RN';
      2401008: Cidade := 'Apodi/RN';
      2401107: Cidade := 'Areia Branca/RN';
      2401206: Cidade := 'Ares/RN';
      2401305: Cidade := 'Augusto Severo/RN';
      2401404: Cidade := 'Baia Formosa/RN';
      2401453: Cidade := 'Barauna/RN';
      2401503: Cidade := 'Barcelona/RN';
      2401602: Cidade := 'Bento Fernandes/RN';
      2401651: Cidade := 'Bodo/RN';
      2401701: Cidade := 'Bom Jesus/RN';
      2401800: Cidade := 'Brejinho/RN';
      2401859: Cidade := 'Caicara Do Norte/RN';
      2401909: Cidade := 'Caicara Do Rio Do Vento/RN';
      2402006: Cidade := 'Caico/RN';
      2402105: Cidade := 'Campo Redondo/RN';
      2402204: Cidade := 'Canguaretama/RN';
      2402303: Cidade := 'Caraubas/RN';
      2402402: Cidade := 'Carnauba Dos Dantas/RN';
      2402501: Cidade := 'Carnaubais/RN';
      2402600: Cidade := 'Ceara-Mirim/RN';
      2402709: Cidade := 'Cerro Cora/RN';
      2402808: Cidade := 'Coronel Ezequiel/RN';
      2402907: Cidade := 'Coronel Joao Pessoa/RN';
      2403004: Cidade := 'Cruzeta/RN';
      2403103: Cidade := 'Currais Novos/RN';
      2403202: Cidade := 'Doutor Severiano/RN';
      2403251: Cidade := 'Parnamirim/RN';
      2403301: Cidade := 'Encanto/RN';
      2403400: Cidade := 'Equador/RN';
      2403509: Cidade := 'Espirito Santo/RN';
      2403608: Cidade := 'Extremoz/RN';
      2403707: Cidade := 'Felipe Guerra/RN';
      2403756: Cidade := 'Fernando Pedroza/RN';
      2403806: Cidade := 'Florania/RN';
      2403905: Cidade := 'Francisco Dantas/RN';
      2404002: Cidade := 'Frutuoso Gomes/RN';
      2404101: Cidade := 'Galinhos/RN';
      2404200: Cidade := 'Goianinha/RN';
      2404309: Cidade := 'Governador Dix-Sept Rosado/RN';
      2404408: Cidade := 'Grossos/RN';
      2404507: Cidade := 'Guamare/RN';
      2404606: Cidade := 'Ielmo Marinho/RN';
      2404705: Cidade := 'Ipanguacu/RN';
      2404804: Cidade := 'Ipueira/RN';
      2404853: Cidade := 'Itaja/RN';
      2404903: Cidade := 'Itau/RN';
      2405009: Cidade := 'Jacana/RN';
      2405108: Cidade := 'Jandaira/RN';
      2405207: Cidade := 'Janduis/RN';
      2405306: Cidade := 'Januario Cicco/RN';
      2405405: Cidade := 'Japi/RN';
      2405504: Cidade := 'Jardim De Angicos/RN';
      2405603: Cidade := 'Jardim De Piranhas/RN';
      2405702: Cidade := 'Jardim Do Serido/RN';
      2405801: Cidade := 'Joao Camara/RN';
      2405900: Cidade := 'Joao Dias/RN';
      2406007: Cidade := 'Jose Da Penha/RN';
      2406106: Cidade := 'Jucurutu/RN';
      2406155: Cidade := 'Jundia/RN';
      2406205: Cidade := 'Lagoa D Anta/RN';
      2406304: Cidade := 'Lagoa De Pedras/RN';
      2406403: Cidade := 'Lagoa De Velhos/RN';
      2406502: Cidade := 'Lagoa Nova/RN';
      2406601: Cidade := 'Lagoa Salgada/RN';
      2406700: Cidade := 'Lajes/RN';
      2406809: Cidade := 'Lajes Pintadas/RN';
      2406908: Cidade := 'Lucrecia/RN';
      2407005: Cidade := 'Luis Gomes/RN';
      2407104: Cidade := 'Macaiba/RN';
      2407203: Cidade := 'Macau/RN';
      2407252: Cidade := 'Major Sales/RN';
      2407302: Cidade := 'Marcelino Vieira/RN';
      2407401: Cidade := 'Martins/RN';
      2407500: Cidade := 'Maxaranguape/RN';
      2407609: Cidade := 'Messias Targino/RN';
      2407708: Cidade := 'Montanhas/RN';
      2407807: Cidade := 'Monte Alegre/RN';
      2407906: Cidade := 'Monte Das Gameleiras/RN';
      2408003: Cidade := 'Mossoro/RN';
      2408102: Cidade := 'Natal/RN';
      2408201: Cidade := 'Nisia Floresta/RN';
      2408300: Cidade := 'Nova Cruz/RN';
      2408409: Cidade := 'Olho-D Agua Do Borges/RN';
      2408508: Cidade := 'Ouro Branco/RN';
      2408607: Cidade := 'Parana/RN';
      2408706: Cidade := 'Parau/RN';
      2408805: Cidade := 'Parazinho/RN';
      2408904: Cidade := 'Parelhas/RN';
      2408953: Cidade := 'Rio Do Fogo/RN';
      2409100: Cidade := 'Passa E Fica/RN';
      2409209: Cidade := 'Passagem/RN';
      2409308: Cidade := 'Patu/RN';
      2409332: Cidade := 'Santa Maria/RN';
      2409407: Cidade := 'Pau Dos Ferros/RN';
      2409506: Cidade := 'Pedra Grande/RN';
      2409605: Cidade := 'Pedra Preta/RN';
      2409704: Cidade := 'Pedro Avelino/RN';
      2409803: Cidade := 'Pedro Velho/RN';
      2409902: Cidade := 'Pendencias/RN';
      2410009: Cidade := 'Piloes/RN';
      2410108: Cidade := 'Poco Branco/RN';
      2410207: Cidade := 'Portalegre/RN';
      2410256: Cidade := 'Porto Do Mangue/RN';
      2410306: Cidade := 'Presidente Juscelino/RN';
      2410405: Cidade := 'Pureza/RN';
      2410504: Cidade := 'Rafael Fernandes/RN';
      2410603: Cidade := 'Rafael Godeiro/RN';
      2410702: Cidade := 'Riacho Da Cruz/RN';
      2410801: Cidade := 'Riacho De Santana/RN';
      2410900: Cidade := 'Riachuelo/RN';
      2411007: Cidade := 'Rodolfo Fernandes/RN';
      2411056: Cidade := 'Tibau/RN';
      2411106: Cidade := 'Ruy Barbosa/RN';
      2411205: Cidade := 'Santa Cruz/RN';
      2411403: Cidade := 'Santana Do Matos/RN';
      2411429: Cidade := 'Santana Do Serido/RN';
      2411502: Cidade := 'Santo Antonio/RN';
      2411601: Cidade := 'Sao Bento Do Norte/RN';
      2411700: Cidade := 'Sao Bento Do Trairi/RN';
      2411809: Cidade := 'Sao Fernando/RN';
      2411908: Cidade := 'Sao Francisco Do Oeste/RN';
      2412005: Cidade := 'Sao Goncalo Do Amarante/RN';
      2412104: Cidade := 'Sao Joao Do Sabugi/RN';
      2412203: Cidade := 'Sao Jose De Mipibu/RN';
      2412302: Cidade := 'Sao Jose Do Campestre/RN';
      2412401: Cidade := 'Sao Jose Do Serido/RN';
      2412500: Cidade := 'Sao Miguel/RN';
      2412559: Cidade := 'Sao Miguel Do Gostoso/RN';
      2412609: Cidade := 'Sao Paulo Do Potengi/RN';
      2412708: Cidade := 'Sao Pedro/RN';
      2412807: Cidade := 'Sao Rafael/RN';
      2412906: Cidade := 'Sao Tome/RN';
      2413003: Cidade := 'Sao Vicente/RN';
      2413102: Cidade := 'Senador Eloi De Souza/RN';
      2413201: Cidade := 'Senador Georgino Avelino/RN';
      2413300: Cidade := 'Serra De Sao Bento/RN';
      2413359: Cidade := 'Serra Do Mel/RN';
      2413409: Cidade := 'Serra Negra Do Norte/RN';
      2413508: Cidade := 'Serrinha/RN';
      2413557: Cidade := 'Serrinha Dos Pintos/RN';
      2413607: Cidade := 'Severiano Melo/RN';
      2413706: Cidade := 'Sitio Novo/RN';
      2413805: Cidade := 'Taboleiro Grande/RN';
      2413904: Cidade := 'Taipu/RN';
      2414001: Cidade := 'Tangara/RN';
      2414100: Cidade := 'Tenente Ananias/RN';
      2414159: Cidade := 'Tenente Laurentino Cruz/RN';
      2414209: Cidade := 'Tibau Do Sul/RN';
      2414308: Cidade := 'Timbauba Dos Batistas/RN';
      2414407: Cidade := 'Touros/RN';
      2414456: Cidade := 'Triunfo Potiguar/RN';
      2414506: Cidade := 'Umarizal/RN';
      2414605: Cidade := 'Upanema/RN';
      2414704: Cidade := 'Varzea/RN';
      2414753: Cidade := 'Venha-Ver/RN';
      2414803: Cidade := 'Vera Cruz/RN';
      2414902: Cidade := 'Vicosa/RN';
      2415008: Cidade := 'Vila Flor/RN';
   end;
 end;

 procedure P25;
 begin
   case ACodigo of
      2500106: Cidade := 'Agua Branca/PB';
      2500205: Cidade := 'Aguiar/PB';
      2500304: Cidade := 'Alagoa Grande/PB';
      2500403: Cidade := 'Alagoa Nova/PB';
      2500502: Cidade := 'Alagoinha/PB';
      2500536: Cidade := 'Alcantil/PB';
      2500577: Cidade := 'Algodao De Jandaira/PB';
      2500601: Cidade := 'Alhandra/PB';
      2500700: Cidade := 'Sao Joao Do Rio Do Peixe/PB';
      2500734: Cidade := 'Amparo/PB';
      2500775: Cidade := 'Aparecida/PB';
      2500809: Cidade := 'Aracagi/PB';
      2500908: Cidade := 'Arara/PB';
      2501005: Cidade := 'Araruna/PB';
      2501104: Cidade := 'Areia/PB';
      2501153: Cidade := 'Areia De Baraunas/PB';
      2501203: Cidade := 'Areial/PB';
      2501302: Cidade := 'Aroeiras/PB';
      2501351: Cidade := 'Assuncao/PB';
      2501401: Cidade := 'Baia Da Traicao/PB';
      2501500: Cidade := 'Bananeiras/PB';
      2501534: Cidade := 'Barauna/PB';
      2501575: Cidade := 'Barra De Santana/PB';
      2501609: Cidade := 'Barra De Santa Rosa/PB';
      2501708: Cidade := 'Barra De Sao Miguel/PB';
      2501807: Cidade := 'Bayeux/PB';
      2501906: Cidade := 'Belem/PB';
      2502003: Cidade := 'Belem Do Brejo Do Cruz/PB';
      2502052: Cidade := 'Bernardino Batista/PB';
      2502102: Cidade := 'Boa Ventura/PB';
      2502151: Cidade := 'Boa Vista/PB';
      2502201: Cidade := 'Bom Jesus/PB';
      2502300: Cidade := 'Bom Sucesso/PB';
      2502409: Cidade := 'Bonito De Santa Fe/PB';
      2502508: Cidade := 'Boqueirao/PB';
      2502607: Cidade := 'Igaracy/PB';
      2502706: Cidade := 'Borborema/PB';
      2502805: Cidade := 'Brejo Do Cruz/PB';
      2502904: Cidade := 'Brejo Dos Santos/PB';
      2503001: Cidade := 'Caapora/PB';
      2503100: Cidade := 'Cabaceiras/PB';
      2503209: Cidade := 'Cabedelo/PB';
      2503308: Cidade := 'Cachoeira Dos Indios/PB';
      2503407: Cidade := 'Cacimba De Areia/PB';
      2503506: Cidade := 'Cacimba De Dentro/PB';
      2503555: Cidade := 'Cacimbas/PB';
      2503605: Cidade := 'Caicara/PB';
      2503704: Cidade := 'Cajazeiras/PB';
      2503753: Cidade := 'Cajazeirinhas/PB';
      2503803: Cidade := 'Caldas Brandao/PB';
      2503902: Cidade := 'Camalau/PB';
      2504009: Cidade := 'Campina Grande/PB';
      2504033: Cidade := 'Capim/PB';
      2504074: Cidade := 'Caraubas/PB';
      2504108: Cidade := 'Carrapateira/PB';
      2504157: Cidade := 'Casserengue/PB';
      2504207: Cidade := 'Catingueira/PB';
      2504306: Cidade := 'Catole Do Rocha/PB';
      2504355: Cidade := 'Caturite/PB';
      2504405: Cidade := 'Conceicao/PB';
      2504504: Cidade := 'Condado/PB';
      2504603: Cidade := 'Conde/PB';
      2504702: Cidade := 'Congo/PB';
      2504801: Cidade := 'Coremas/PB';
      2504850: Cidade := 'Coxixola/PB';
      2504900: Cidade := 'Cruz Do Espirito Santo/PB';
      2505006: Cidade := 'Cubati/PB';
      2505105: Cidade := 'Cuite/PB';
      2505204: Cidade := 'Cuitegi/PB';
      2505238: Cidade := 'Cuite De Mamanguape/PB';
      2505279: Cidade := 'Curral De Cima/PB';
      2505303: Cidade := 'Curral Velho/PB';
      2505352: Cidade := 'Damiao/PB';
      2505402: Cidade := 'Desterro/PB';
      2505501: Cidade := 'Vista Serrana/PB';
      2505600: Cidade := 'Diamante/PB';
      2505709: Cidade := 'Dona Ines/PB';
      2505808: Cidade := 'Duas Estradas/PB';
      2505907: Cidade := 'Emas/PB';
      2506004: Cidade := 'Esperanca/PB';
      2506103: Cidade := 'Fagundes/PB';
      2506202: Cidade := 'Frei Martinho/PB';
      2506251: Cidade := 'Gado Bravo/PB';
      2506301: Cidade := 'Guarabira/PB';
      2506400: Cidade := 'Gurinhem/PB';
      2506509: Cidade := 'Gurjao/PB';
      2506608: Cidade := 'Ibiara/PB';
      2506707: Cidade := 'Imaculada/PB';
      2506806: Cidade := 'Inga/PB';
      2506905: Cidade := 'Itabaiana/PB';
      2507002: Cidade := 'Itaporanga/PB';
      2507101: Cidade := 'Itapororoca/PB';
      2507200: Cidade := 'Itatuba/PB';
      2507309: Cidade := 'Jacarau/PB';
      2507408: Cidade := 'Jerico/PB';
      2507507: Cidade := 'Joao Pessoa/PB';
      2507606: Cidade := 'Juarez Tavora/PB';
      2507705: Cidade := 'Juazeirinho/PB';
      2507804: Cidade := 'Junco Do Serido/PB';
      2507903: Cidade := 'Juripiranga/PB';
      2508000: Cidade := 'Juru/PB';
      2508109: Cidade := 'Lagoa/PB';
      2508208: Cidade := 'Lagoa De Dentro/PB';
      2508307: Cidade := 'Lagoa Seca/PB';
      2508406: Cidade := 'Lastro/PB';
      2508505: Cidade := 'Livramento/PB';
      2508554: Cidade := 'Logradouro/PB';
      2508604: Cidade := 'Lucena/PB';
      2508703: Cidade := 'Mae D Agua/PB';
      2508802: Cidade := 'Malta/PB';
      2508901: Cidade := 'Mamanguape/PB';
      2509008: Cidade := 'Manaira/PB';
      2509057: Cidade := 'Marcacao/PB';
      2509107: Cidade := 'Mari/PB';
      2509156: Cidade := 'Marizopolis/PB';
      2509206: Cidade := 'Massaranduba/PB';
      2509305: Cidade := 'Mataraca/PB';
      2509339: Cidade := 'Matinhas/PB';
      2509370: Cidade := 'Mato Grosso/PB';
      2509396: Cidade := 'Matureia/PB';
      2509404: Cidade := 'Mogeiro/PB';
      2509503: Cidade := 'Montadas/PB';
      2509602: Cidade := 'Monte Horebe/PB';
      2509701: Cidade := 'Monteiro/PB';
      2509800: Cidade := 'Mulungu/PB';
      2509909: Cidade := 'Natuba/PB';
      2510006: Cidade := 'Nazarezinho/PB';
      2510105: Cidade := 'Nova Floresta/PB';
      2510204: Cidade := 'Nova Olinda/PB';
      2510303: Cidade := 'Nova Palmeira/PB';
      2510402: Cidade := 'Olho D Agua/PB';
      2510501: Cidade := 'Olivedos/PB';
      2510600: Cidade := 'Ouro Velho/PB';
      2510659: Cidade := 'Parari/PB';
      2510709: Cidade := 'Passagem/PB';
      2510808: Cidade := 'Patos/PB';
      2510907: Cidade := 'Paulista/PB';
      2511004: Cidade := 'Pedra Branca/PB';
      2511103: Cidade := 'Pedra Lavrada/PB';
      2511202: Cidade := 'Pedras De Fogo/PB';
      2511301: Cidade := 'Pianco/PB';
      2511400: Cidade := 'Picui/PB';
      2511509: Cidade := 'Pilar/PB';
      2511608: Cidade := 'Piloes/PB';
      2511707: Cidade := 'Piloezinhos/PB';
      2511806: Cidade := 'Pirpirituba/PB';
      2511905: Cidade := 'Pitimbu/PB';
      2512002: Cidade := 'Pocinhos/PB';
      2512036: Cidade := 'Poco Dantas/PB';
      2512077: Cidade := 'Poco De Jose De Moura/PB';
      2512101: Cidade := 'Pombal/PB';
      2512200: Cidade := 'Prata/PB';
      2512309: Cidade := 'Princesa Isabel/PB';
      2512408: Cidade := 'Puxinana/PB';
      2512507: Cidade := 'Queimadas/PB';
      2512606: Cidade := 'Quixaba/PB';
      2512705: Cidade := 'Remigio/PB';
      2512721: Cidade := 'Pedro Regis/PB';
      2512747: Cidade := 'Riachao/PB';
      2512754: Cidade := 'Riachao Do Bacamarte/PB';
      2512762: Cidade := 'Riachao Do Poco/PB';
      2512788: Cidade := 'Riacho De Santo Antonio/PB';
      2512804: Cidade := 'Riacho Dos Cavalos/PB';
      2512903: Cidade := 'Rio Tinto/PB';
      2513000: Cidade := 'Salgadinho/PB';
      2513109: Cidade := 'Salgado De Sao Felix/PB';
      2513158: Cidade := 'Santa Cecilia/PB';
      2513208: Cidade := 'Santa Cruz/PB';
      2513307: Cidade := 'Santa Helena/PB';
      2513356: Cidade := 'Santa Ines/PB';
      2513406: Cidade := 'Santa Luzia/PB';
      2513505: Cidade := 'Santana De Mangueira/PB';
      2513604: Cidade := 'Santana Dos Garrotes/PB';
      2513653: Cidade := 'Santarem/PB';
      2513703: Cidade := 'Santa Rita/PB';
      2513802: Cidade := 'Santa Teresinha/PB';
      2513851: Cidade := 'Santo Andre/PB';
      2513901: Cidade := 'Sao Bento/PB';
      2513927: Cidade := 'Sao Bentinho/PB';
      2513943: Cidade := 'Sao Domingos Do Cariri/PB';
      2513968: Cidade := 'Sao Domingos/PB';
      2513984: Cidade := 'Sao Francisco/PB';
      2514008: Cidade := 'Sao Joao Do Cariri/PB';
      2514107: Cidade := 'Sao Joao Do Tigre/PB';
      2514206: Cidade := 'Sao Jose Da Lagoa Tapada/PB';
      2514305: Cidade := 'Sao Jose De Caiana/PB';
      2514404: Cidade := 'Sao Jose De Espinharas/PB';
      2514453: Cidade := 'Sao Jose Dos Ramos/PB';
      2514503: Cidade := 'Sao Jose De Piranhas/PB';
      2514552: Cidade := 'Sao Jose De Princesa/PB';
      2514602: Cidade := 'Sao Jose Do Bonfim/PB';
      2514651: Cidade := 'Sao Jose Do Brejo Do Cruz/PB';
      2514701: Cidade := 'Sao Jose Do Sabugi/PB';
      2514800: Cidade := 'Sao Jose Dos Cordeiros/PB';
      2514909: Cidade := 'Sao Mamede/PB';
      2515005: Cidade := 'Sao Miguel De Taipu/PB';
      2515104: Cidade := 'Sao Sebastiao De Lagoa De Roca/PB';
      2515203: Cidade := 'Sao Sebastiao Do Umbuzeiro/PB';
      2515302: Cidade := 'Sape/PB';
      2515401: Cidade := 'Serido/PB';
      2515500: Cidade := 'Serra Branca/PB';
      2515609: Cidade := 'Serra Da Raiz/PB';
      2515708: Cidade := 'Serra Grande/PB';
      2515807: Cidade := 'Serra Redonda/PB';
      2515906: Cidade := 'Serraria/PB';
      2515930: Cidade := 'Sertaozinho/PB';
      2515971: Cidade := 'Sobrado/PB';
      2516003: Cidade := 'Solanea/PB';
      2516102: Cidade := 'Soledade/PB';
      2516151: Cidade := 'Sossego/PB';
      2516201: Cidade := 'Sousa/PB';
      2516300: Cidade := 'Sume/PB';
      2516409: Cidade := 'Campo De Santana/PB';
      2516508: Cidade := 'Taperoa/PB';
      2516607: Cidade := 'Tavares/PB';
      2516706: Cidade := 'Teixeira/PB';
      2516755: Cidade := 'Tenorio/PB';
      2516805: Cidade := 'Triunfo/PB';
      2516904: Cidade := 'Uirauna/PB';
      2517001: Cidade := 'Umbuzeiro/PB';
      2517100: Cidade := 'Varzea/PB';
      2517209: Cidade := 'Vieiropolis/PB';
      2517407: Cidade := 'Zabele/PB';
   end;
 end;

 procedure P26;
 begin
   case ACodigo of
      2600054: Cidade := 'Abreu E Lima/PE';
      2600104: Cidade := 'Afogados Da Ingazeira/PE';
      2600203: Cidade := 'Afranio/PE';
      2600302: Cidade := 'Agrestina/PE';
      2600401: Cidade := 'Agua Preta/PE';
      2600500: Cidade := 'Aguas Belas/PE';
      2600609: Cidade := 'Alagoinha/PE';
      2600708: Cidade := 'Alianca/PE';
      2600807: Cidade := 'Altinho/PE';
      2600906: Cidade := 'Amaraji/PE';
      2601003: Cidade := 'Angelim/PE';
      2601052: Cidade := 'Aracoiaba/PE';
      2601102: Cidade := 'Araripina/PE';
      2601201: Cidade := 'Arcoverde/PE';
      2601300: Cidade := 'Barra De Guabiraba/PE';
      2601409: Cidade := 'Barreiros/PE';
      2601508: Cidade := 'Belem De Maria/PE';
      2601607: Cidade := 'Belem De Sao Francisco/PE';
      2601706: Cidade := 'Belo Jardim/PE';
      2601805: Cidade := 'Betania/PE';
      2601904: Cidade := 'Bezerros/PE';
      2602001: Cidade := 'Bodoco/PE';
      2602100: Cidade := 'Bom Conselho/PE';
      2602209: Cidade := 'Bom Jardim/PE';
      2602308: Cidade := 'Bonito/PE';
      2602407: Cidade := 'Brejao/PE';
      2602506: Cidade := 'Brejinho/PE';
      2602605: Cidade := 'Brejo Da Madre De Deus/PE';
      2602704: Cidade := 'Buenos Aires/PE';
      2602803: Cidade := 'Buique/PE';
      2602902: Cidade := 'Cabo De Santo Agostinho/PE';
      2603009: Cidade := 'Cabrobo/PE';
      2603108: Cidade := 'Cachoeirinha/PE';
      2603207: Cidade := 'Caetes/PE';
      2603306: Cidade := 'Calcado/PE';
      2603405: Cidade := 'Calumbi/PE';
      2603454: Cidade := 'Camaragibe/PE';
      2603504: Cidade := 'Camocim De Sao Felix/PE';
      2603603: Cidade := 'Camutanga/PE';
      2603702: Cidade := 'Canhotinho/PE';
      2603801: Cidade := 'Capoeiras/PE';
      2603900: Cidade := 'Carnaiba/PE';
      2603926: Cidade := 'Carnaubeira Da Penha/PE';
      2604007: Cidade := 'Carpina/PE';
      2604106: Cidade := 'Caruaru/PE';
      2604155: Cidade := 'Casinhas/PE';
      2604205: Cidade := 'Catende/PE';
      2604304: Cidade := 'Cedro/PE';
      2604403: Cidade := 'Cha De Alegria/PE';
      2604502: Cidade := 'Cha Grande/PE';
      2604601: Cidade := 'Condado/PE';
      2604700: Cidade := 'Correntes/PE';
      2604809: Cidade := 'Cortes/PE';
      2604908: Cidade := 'Cumaru/PE';
      2605004: Cidade := 'Cupira/PE';
      2605103: Cidade := 'Custodia/PE';
      2605152: Cidade := 'Dormentes/PE';
      2605202: Cidade := 'Escada/PE';
      2605301: Cidade := 'Exu/PE';
      2605400: Cidade := 'Feira Nova/PE';
      2605459: Cidade := 'Fernando De Noronha/PE';
      2605509: Cidade := 'Ferreiros/PE';
      2605608: Cidade := 'Flores/PE';
      2605707: Cidade := 'Floresta/PE';
      2605806: Cidade := 'Frei Miguelinho/PE';
      2605905: Cidade := 'Gameleira/PE';
      2606002: Cidade := 'Garanhuns/PE';
      2606101: Cidade := 'Gloria Do Goita/PE';
      2606200: Cidade := 'Goiana/PE';
      2606309: Cidade := 'Granito/PE';
      2606408: Cidade := 'Gravata/PE';
      2606507: Cidade := 'Iati/PE';
      2606606: Cidade := 'Ibimirim/PE';
      2606705: Cidade := 'Ibirajuba/PE';
      2606804: Cidade := 'Igarassu/PE';
      2606903: Cidade := 'Iguaraci/PE';
      2607000: Cidade := 'Inaja/PE';
      2607109: Cidade := 'Ingazeira/PE';
      2607208: Cidade := 'Ipojuca/PE';
      2607307: Cidade := 'Ipubi/PE';
      2607406: Cidade := 'Itacuruba/PE';
      2607505: Cidade := 'Itaiba/PE';
      2607604: Cidade := 'Ilha De Itamaraca/PE';
      2607653: Cidade := 'Itambe/PE';
      2607703: Cidade := 'Itapetim/PE';
      2607752: Cidade := 'Itapissuma/PE';
      2607802: Cidade := 'Itaquitinga/PE';
      2607901: Cidade := 'Jaboatao Dos Guararapes/PE';
      2607950: Cidade := 'Jaqueira/PE';
      2608008: Cidade := 'Jatauba/PE';
      2608057: Cidade := 'Jatoba/PE';
      2608107: Cidade := 'Joao Alfredo/PE';
      2608206: Cidade := 'Joaquim Nabuco/PE';
      2608255: Cidade := 'Jucati/PE';
      2608305: Cidade := 'Jupi/PE';
      2608404: Cidade := 'Jurema/PE';
      2608453: Cidade := 'Lagoa Do Carro/PE';
      2608503: Cidade := 'Lagoa Do Itaenga/PE';
      2608602: Cidade := 'Lagoa Do Ouro/PE';
      2608701: Cidade := 'Lagoa Dos Gatos/PE';
      2608750: Cidade := 'Lagoa Grande/PE';
      2608800: Cidade := 'Lajedo/PE';
      2608909: Cidade := 'Limoeiro/PE';
      2609006: Cidade := 'Macaparana/PE';
      2609105: Cidade := 'Machados/PE';
      2609154: Cidade := 'Manari/PE';
      2609204: Cidade := 'Maraial/PE';
      2609303: Cidade := 'Mirandiba/PE';
      2609402: Cidade := 'Moreno/PE';
      2609501: Cidade := 'Nazare Da Mata/PE';
      2609600: Cidade := 'Olinda/PE';
      2609709: Cidade := 'Orobo/PE';
      2609808: Cidade := 'Oroco/PE';
      2609907: Cidade := 'Ouricuri/PE';
      2610004: Cidade := 'Palmares/PE';
      2610103: Cidade := 'Palmeirina/PE';
      2610202: Cidade := 'Panelas/PE';
      2610301: Cidade := 'Paranatama/PE';
      2610400: Cidade := 'Parnamirim/PE';
      2610509: Cidade := 'Passira/PE';
      2610608: Cidade := 'Paudalho/PE';
      2610707: Cidade := 'Paulista/PE';
      2610806: Cidade := 'Pedra/PE';
      2610905: Cidade := 'Pesqueira/PE';
      2611002: Cidade := 'Petrolandia/PE';
      2611101: Cidade := 'Petrolina/PE';
      2611200: Cidade := 'Pocao/PE';
      2611309: Cidade := 'Pombos/PE';
      2611408: Cidade := 'Primavera/PE';
      2611507: Cidade := 'Quipapa/PE';
      2611533: Cidade := 'Quixaba/PE';
      2611606: Cidade := 'Recife/PE';
      2611705: Cidade := 'Riacho Das Almas/PE';
      2611804: Cidade := 'Ribeirao/PE';
      2611903: Cidade := 'Rio Formoso/PE';
      2612000: Cidade := 'Saire/PE';
      2612109: Cidade := 'Salgadinho/PE';
      2612208: Cidade := 'Salgueiro/PE';
      2612307: Cidade := 'Saloa/PE';
      2612406: Cidade := 'Sanharo/PE';
      2612455: Cidade := 'Santa Cruz/PE';
      2612471: Cidade := 'Santa Cruz Da Baixa Verde/PE';
      2612505: Cidade := 'Santa Cruz Do Capibaribe/PE';
      2612554: Cidade := 'Santa Filomena/PE';
      2612604: Cidade := 'Santa Maria Da Boa Vista/PE';
      2612703: Cidade := 'Santa Maria Do Cambuca/PE';
      2612802: Cidade := 'Santa Terezinha/PE';
      2612901: Cidade := 'Sao Benedito Do Sul/PE';
      2613008: Cidade := 'Sao Bento Do Una/PE';
      2613107: Cidade := 'Sao Caitano/PE';
      2613206: Cidade := 'Sao Joao/PE';
      2613305: Cidade := 'Sao Joaquim Do Monte/PE';
      2613404: Cidade := 'Sao Jose Da Coroa Grande/PE';
      2613503: Cidade := 'Sao Jose Do Belmonte/PE';
      2613602: Cidade := 'Sao Jose Do Egito/PE';
      2613701: Cidade := 'Sao Lourenco Da Mata/PE';
      2613800: Cidade := 'Sao Vicente Ferrer/PE';
      2613909: Cidade := 'Serra Talhada/PE';
      2614006: Cidade := 'Serrita/PE';
      2614105: Cidade := 'Sertania/PE';
      2614204: Cidade := 'Sirinhaem/PE';
      2614303: Cidade := 'Moreilandia/PE';
      2614402: Cidade := 'Solidao/PE';
      2614501: Cidade := 'Surubim/PE';
      2614600: Cidade := 'Tabira/PE';
      2614709: Cidade := 'Tacaimbo/PE';
      2614808: Cidade := 'Tacaratu/PE';
      2614857: Cidade := 'Tamandare/PE';
      2615003: Cidade := 'Taquaritinga Do Norte/PE';
      2615102: Cidade := 'Terezinha/PE';
      2615201: Cidade := 'Terra Nova/PE';
      2615300: Cidade := 'Timbauba/PE';
      2615409: Cidade := 'Toritama/PE';
      2615508: Cidade := 'Tracunhaem/PE';
      2615607: Cidade := 'Trindade/PE';
      2615706: Cidade := 'Triunfo/PE';
      2615805: Cidade := 'Tupanatinga/PE';
      2615904: Cidade := 'Tuparetama/PE';
      2616001: Cidade := 'Venturosa/PE';
      2616100: Cidade := 'Verdejante/PE';
      2616183: Cidade := 'Vertente Do Lerio/PE';
      2616209: Cidade := 'Vertentes/PE';
      2616308: Cidade := 'Vicencia/PE';
      2616407: Cidade := 'Vitoria De Santo Antao/PE';
      2616506: Cidade := 'Xexeu/PE';
   end;
 end;

 procedure P27;
 begin
   case ACodigo of
      2700102: Cidade := 'Agua Branca/AL';
      2700201: Cidade := 'Anadia/AL';
      2700300: Cidade := 'Arapiraca/AL';
      2700409: Cidade := 'Atalaia/AL';
      2700508: Cidade := 'Barra De Santo Antonio/AL';
      2700607: Cidade := 'Barra De Sao Miguel/AL';
      2700706: Cidade := 'Batalha/AL';
      2700805: Cidade := 'Belem/AL';
      2700904: Cidade := 'Belo Monte/AL';
      2701001: Cidade := 'Boca Da Mata/AL';
      2701100: Cidade := 'Branquinha/AL';
      2701209: Cidade := 'Cacimbinhas/AL';
      2701308: Cidade := 'Cajueiro/AL';
      2701357: Cidade := 'Campestre/AL';
      2701407: Cidade := 'Campo Alegre/AL';
      2701506: Cidade := 'Campo Grande/AL';
      2701605: Cidade := 'Canapi/AL';
      2701704: Cidade := 'Capela/AL';
      2701803: Cidade := 'Carneiros/AL';
      2701902: Cidade := 'Cha Preta/AL';
      2702009: Cidade := 'Coite Do Noia/AL';
      2702108: Cidade := 'Colonia Leopoldina/AL';
      2702207: Cidade := 'Coqueiro Seco/AL';
      2702306: Cidade := 'Coruripe/AL';
      2702355: Cidade := 'Craibas/AL';
      2702405: Cidade := 'Delmiro Gouveia/AL';
      2702504: Cidade := 'Dois Riachos/AL';
      2702553: Cidade := 'Estrela De Alagoas/AL';
      2702603: Cidade := 'Feira Grande/AL';
      2702702: Cidade := 'Feliz Deserto/AL';
      2702801: Cidade := 'Flexeiras/AL';
      2702900: Cidade := 'Girau Do Ponciano/AL';
      2703007: Cidade := 'Ibateguara/AL';
      2703106: Cidade := 'Igaci/AL';
      2703205: Cidade := 'Igreja Nova/AL';
      2703304: Cidade := 'Inhapi/AL';
      2703403: Cidade := 'Jacare Dos Homens/AL';
      2703502: Cidade := 'Jacuipe/AL';
      2703601: Cidade := 'Japaratinga/AL';
      2703700: Cidade := 'Jaramataia/AL';
      2703759: Cidade := 'Jequia Da Praia/AL';
      2703809: Cidade := 'Joaquim Gomes/AL';
      2703908: Cidade := 'Jundia/AL';
      2704005: Cidade := 'Junqueiro/AL';
      2704104: Cidade := 'Lagoa Da Canoa/AL';
      2704203: Cidade := 'Limoeiro De Anadia/AL';
      2704302: Cidade := 'Maceio/AL';
      2704401: Cidade := 'Major Isidoro/AL';
      2704500: Cidade := 'Maragogi/AL';
      2704609: Cidade := 'Maravilha/AL';
      2704708: Cidade := 'Marechal Deodoro/AL';
      2704807: Cidade := 'Maribondo/AL';
      2704906: Cidade := 'Mar Vermelho/AL';
      2705002: Cidade := 'Mata Grande/AL';
      2705101: Cidade := 'Matriz De Camaragibe/AL';
      2705200: Cidade := 'Messias/AL';
      2705309: Cidade := 'Minador Do Negrao/AL';
      2705408: Cidade := 'Monteiropolis/AL';
      2705507: Cidade := 'Murici/AL';
      2705606: Cidade := 'Novo Lino/AL';
      2705705: Cidade := 'Olho D Agua Das Flores/AL';
      2705804: Cidade := 'Olho D Agua Do Casado/AL';
      2705903: Cidade := 'Olho D Agua Grande/AL';
      2706000: Cidade := 'Olivenca/AL';
      2706109: Cidade := 'Ouro Branco/AL';
      2706208: Cidade := 'Palestina/AL';
      2706307: Cidade := 'Palmeira Dos Indios/AL';
      2706406: Cidade := 'Pao De Acucar/AL';
      2706422: Cidade := 'Pariconha/AL';
      2706448: Cidade := 'Paripueira/AL';
      2706505: Cidade := 'Passo De Camaragibe/AL';
      2706604: Cidade := 'Paulo Jacinto/AL';
      2706703: Cidade := 'Penedo/AL';
      2706802: Cidade := 'Piacabucu/AL';
      2706901: Cidade := 'Pilar/AL';
      2707008: Cidade := 'Pindoba/AL';
      2707107: Cidade := 'Piranhas/AL';
      2707206: Cidade := 'Poco Das Trincheiras/AL';
      2707305: Cidade := 'Porto Calvo/AL';
      2707404: Cidade := 'Porto De Pedras/AL';
      2707503: Cidade := 'Porto Real Do Colegio/AL';
      2707602: Cidade := 'Quebrangulo/AL';
      2707701: Cidade := 'Rio Largo/AL';
      2707800: Cidade := 'Roteiro/AL';
      2707909: Cidade := 'Santa Luzia Do Norte/AL';
      2708006: Cidade := 'Santana Do Ipanema/AL';
      2708105: Cidade := 'Santana Do Mundau/AL';
      2708204: Cidade := 'Sao Bras/AL';
      2708303: Cidade := 'Sao Jose Da Laje/AL';
      2708402: Cidade := 'Sao Jose Da Tapera/AL';
      2708501: Cidade := 'Sao Luis Do Quitunde/AL';
      2708600: Cidade := 'Sao Miguel Dos Campos/AL';
      2708709: Cidade := 'Sao Miguel Dos Milagres/AL';
      2708808: Cidade := 'Sao Sebastiao/AL';
      2708907: Cidade := 'Satuba/AL';
      2708956: Cidade := 'Senador Rui Palmeira/AL';
      2709004: Cidade := 'Tanque D Arca/AL';
      2709103: Cidade := 'Taquarana/AL';
      2709152: Cidade := 'Teotonio Vilela/AL';
      2709202: Cidade := 'Traipu/AL';
      2709301: Cidade := 'Uniao Dos Palmares/AL';
      2709400: Cidade := 'Vicosa/AL';
   end;
 end;

 procedure P28;
 begin
   case ACodigo of
      2800100: Cidade := 'Amparo De Sao Francisco/SE';
      2800209: Cidade := 'Aquidaba/SE';
      2800308: Cidade := 'Aracaju/SE';
      2800407: Cidade := 'Araua/SE';
      2800506: Cidade := 'Areia Branca/SE';
      2800605: Cidade := 'Barra Dos Coqueiros/SE';
      2800670: Cidade := 'Boquim/SE';
      2800704: Cidade := 'Brejo Grande/SE';
      2801009: Cidade := 'Campo Do Brito/SE';
      2801108: Cidade := 'Canhoba/SE';
      2801207: Cidade := 'Caninde De Sao Francisco/SE';
      2801306: Cidade := 'Capela/SE';
      2801405: Cidade := 'Carira/SE';
      2801504: Cidade := 'Carmopolis/SE';
      2801603: Cidade := 'Cedro De Sao Joao/SE';
      2801702: Cidade := 'Cristinapolis/SE';
      2801900: Cidade := 'Cumbe/SE';
      2802007: Cidade := 'Divina Pastora/SE';
      2802106: Cidade := 'Estancia/SE';
      2802205: Cidade := 'Feira Nova/SE';
      2802304: Cidade := 'Frei Paulo/SE';
      2802403: Cidade := 'Gararu/SE';
      2802502: Cidade := 'General Maynard/SE';
      2802601: Cidade := 'Gracho Cardoso/SE';
      2802700: Cidade := 'Ilha Das Flores/SE';
      2802809: Cidade := 'Indiaroba/SE';
      2802908: Cidade := 'Itabaiana/SE';
      2803005: Cidade := 'Itabaianinha/SE';
      2803104: Cidade := 'Itabi/SE';
      2803203: Cidade := 'Itaporanga D Ajuda/SE';
      2803302: Cidade := 'Japaratuba/SE';
      2803401: Cidade := 'Japoata/SE';
      2803500: Cidade := 'Lagarto/SE';
      2803609: Cidade := 'Laranjeiras/SE';
      2803708: Cidade := 'Macambira/SE';
      2803807: Cidade := 'Malhada Dos Bois/SE';
      2803906: Cidade := 'Malhador/SE';
      2804003: Cidade := 'Maruim/SE';
      2804102: Cidade := 'Moita Bonita/SE';
      2804201: Cidade := 'Monte Alegre De Sergipe/SE';
      2804300: Cidade := 'Muribeca/SE';
      2804409: Cidade := 'Neopolis/SE';
      2804458: Cidade := 'Nossa Senhora Aparecida/SE';
      2804508: Cidade := 'Nossa Senhora Da Gloria/SE';
      2804607: Cidade := 'Nossa Senhora Das Dores/SE';
      2804706: Cidade := 'Nossa Senhora De Lourdes/SE';
      2804805: Cidade := 'Nossa Senhora Do Socorro/SE';
      2804904: Cidade := 'Pacatuba/SE';
      2805000: Cidade := 'Pedra Mole/SE';
      2805109: Cidade := 'Pedrinhas/SE';
      2805208: Cidade := 'Pinhao/SE';
      2805307: Cidade := 'Pirambu/SE';
      2805406: Cidade := 'Poco Redondo/SE';
      2805505: Cidade := 'Poco Verde/SE';
      2805604: Cidade := 'Porto Da Folha/SE';
      2805703: Cidade := 'Propria/SE';
      2805802: Cidade := 'Riachao Do Dantas/SE';
      2805901: Cidade := 'Riachuelo/SE';
      2806008: Cidade := 'Ribeiropolis/SE';
      2806107: Cidade := 'Rosario Do Catete/SE';
      2806206: Cidade := 'Salgado/SE';
      2806305: Cidade := 'Santa Luzia Do Itanhy/SE';
      2806404: Cidade := 'Santana Do Sao Francisco/SE';
      2806503: Cidade := 'Santa Rosa De Lima/SE';
      2806602: Cidade := 'Santo Amaro Das Brotas/SE';
      2806701: Cidade := 'Sao Cristovao/SE';
      2806800: Cidade := 'Sao Domingos/SE';
      2806909: Cidade := 'Sao Francisco/SE';
      2807006: Cidade := 'Sao Miguel Do Aleixo/SE';
      2807105: Cidade := 'Simao Dias/SE';
      2807204: Cidade := 'Siriri/SE';
      2807303: Cidade := 'Telha/SE';
      2807402: Cidade := 'Tobias Barreto/SE';
      2807501: Cidade := 'Tomar Do Geru/SE';
      2807600: Cidade := 'Umbauba/SE';
   end;
 end;

 procedure P29;
 begin
   case ACodigo of
      2900108: Cidade := 'Abaira/BA';
      2900207: Cidade := 'Abare/BA';
      2900306: Cidade := 'Acajutiba/BA';
      2900355: Cidade := 'Adustina/BA';
      2900405: Cidade := 'Agua Fria/BA';
      2900504: Cidade := 'Erico Cardoso/BA';
      2900603: Cidade := 'Aiquara/BA';
      2900702: Cidade := 'Alagoinhas/BA';
      2900801: Cidade := 'Alcobaca/BA';
      2900900: Cidade := 'Almadina/BA';
      2901007: Cidade := 'Amargosa/BA';
      2901106: Cidade := 'Amelia Rodrigues/BA';
      2901155: Cidade := 'America Dourada/BA';
      2901205: Cidade := 'Anage/BA';
      2901304: Cidade := 'Andarai/BA';
      2901353: Cidade := 'Andorinha/BA';
      2901403: Cidade := 'Angical/BA';
      2901502: Cidade := 'Anguera/BA';
      2901601: Cidade := 'Antas/BA';
      2901700: Cidade := 'Antonio Cardoso/BA';
      2901809: Cidade := 'Antonio Goncalves/BA';
      2901908: Cidade := 'Apora/BA';
      2901957: Cidade := 'Apuarema/BA';
      2902005: Cidade := 'Aracatu/BA';
      2902054: Cidade := 'Aracas/BA';
      2902104: Cidade := 'Araci/BA';
      2902203: Cidade := 'Aramari/BA';
      2902252: Cidade := 'Arataca/BA';
      2902302: Cidade := 'Aratuipe/BA';
      2902401: Cidade := 'Aurelino Leal/BA';
      2902500: Cidade := 'Baianopolis/BA';
      2902609: Cidade := 'Baixa Grande/BA';
      2902658: Cidade := 'Banzae/BA';
      2902708: Cidade := 'Barra/BA';
      2902807: Cidade := 'Barra Da Estiva/BA';
      2902906: Cidade := 'Barra Do Choca/BA';
      2903003: Cidade := 'Barra Do Mendes/BA';
      2903102: Cidade := 'Barra Do Rocha/BA';
      2903201: Cidade := 'Barreiras/BA';
      2903235: Cidade := 'Barro Alto/BA';
      2903276: Cidade := 'Barrocas/BA';
      2903300: Cidade := 'Barro Preto/BA';
      2903409: Cidade := 'Belmonte/BA';
      2903508: Cidade := 'Belo Campo/BA';
      2903607: Cidade := 'Biritinga/BA';
      2903706: Cidade := 'Boa Nova/BA';
      2903805: Cidade := 'Boa Vista Do Tupim/BA';
      2903904: Cidade := 'Bom Jesus Da Lapa/BA';
      2903953: Cidade := 'Bom Jesus Da Serra/BA';
      2904001: Cidade := 'Boninal/BA';
      2904050: Cidade := 'Bonito/BA';
      2904100: Cidade := 'Boquira/BA';
      2904209: Cidade := 'Botupora/BA';
      2904308: Cidade := 'Brejoes/BA';
      2904407: Cidade := 'Brejolandia/BA';
      2904506: Cidade := 'Brotas De Macaubas/BA';
      2904605: Cidade := 'Brumado/BA';
      2904704: Cidade := 'Buerarema/BA';
      2904753: Cidade := 'Buritirama/BA';
      2904803: Cidade := 'Caatiba/BA';
      2904852: Cidade := 'Cabaceiras Do Paraguacu/BA';
      2904902: Cidade := 'Cachoeira/BA';
      2905008: Cidade := 'Cacule/BA';
      2905107: Cidade := 'Caem/BA';
      2905156: Cidade := 'Caetanos/BA';
      2905206: Cidade := 'Caetite/BA';
      2905305: Cidade := 'Cafarnaum/BA';
      2905404: Cidade := 'Cairu/BA';
      2905503: Cidade := 'Caldeirao Grande/BA';
      2905602: Cidade := 'Camacan/BA';
      2905701: Cidade := 'Camacari/BA';
      2905800: Cidade := 'Camamu/BA';
      2905909: Cidade := 'Campo Alegre De Lourdes/BA';
      2906006: Cidade := 'Campo Formoso/BA';
      2906105: Cidade := 'Canapolis/BA';
      2906204: Cidade := 'Canarana/BA';
      2906303: Cidade := 'Canavieiras/BA';
      2906402: Cidade := 'Candeal/BA';
      2906501: Cidade := 'Candeias/BA';
      2906600: Cidade := 'Candiba/BA';
      2906709: Cidade := 'Candido Sales/BA';
      2906808: Cidade := 'Cansancao/BA';
      2906824: Cidade := 'Canudos/BA';
      2906857: Cidade := 'Capela Do Alto Alegre/BA';
      2906873: Cidade := 'Capim Grosso/BA';
      2906899: Cidade := 'Caraibas/BA';
      2906907: Cidade := 'Caravelas/BA';
      2907004: Cidade := 'Cardeal Da Silva/BA';
      2907103: Cidade := 'Carinhanha/BA';
      2907202: Cidade := 'Casa Nova/BA';
      2907301: Cidade := 'Castro Alves/BA';
      2907400: Cidade := 'Catolandia/BA';
      2907509: Cidade := 'Catu/BA';
      2907558: Cidade := 'Caturama/BA';
      2907608: Cidade := 'Central/BA';
      2907707: Cidade := 'Chorrocho/BA';
      2907806: Cidade := 'Cicero Dantas/BA';
      2907905: Cidade := 'Cipo/BA';
      2908002: Cidade := 'Coaraci/BA';
      2908101: Cidade := 'Cocos/BA';
      2908200: Cidade := 'Conceicao Da Feira/BA';
      2908309: Cidade := 'Conceicao Do Almeida/BA';
      2908408: Cidade := 'Conceicao Do Coite/BA';
      2908507: Cidade := 'Conceicao Do Jacuipe/BA';
      2908606: Cidade := 'Conde/BA';
      2908705: Cidade := 'Condeuba/BA';
      2908804: Cidade := 'Contendas Do Sincora/BA';
      2908903: Cidade := 'Coracao De Maria/BA';
      2909000: Cidade := 'Cordeiros/BA';
      2909109: Cidade := 'Coribe/BA';
      2909208: Cidade := 'Coronel Joao Sa/BA';
      2909307: Cidade := 'Correntina/BA';
      2909406: Cidade := 'Cotegipe/BA';
      2909505: Cidade := 'Cravolandia/BA';
      2909604: Cidade := 'Crisopolis/BA';
      2909703: Cidade := 'Cristopolis/BA';
      2909802: Cidade := 'Cruz Das Almas/BA';
      2909901: Cidade := 'Curaca/BA';
      2910008: Cidade := 'Dario Meira/BA';
      2910057: Cidade := 'Dias D Avila/BA';
      2910107: Cidade := 'Dom Basilio/BA';
      2910206: Cidade := 'Dom Macedo Costa/BA';
      2910305: Cidade := 'Elisio Medrado/BA';
      2910404: Cidade := 'Encruzilhada/BA';
      2910503: Cidade := 'Entre Rios/BA';
      2910602: Cidade := 'Esplanada/BA';
      2910701: Cidade := 'Euclides Da Cunha/BA';
      2910727: Cidade := 'Eunapolis/BA';
      2910750: Cidade := 'Fatima/BA';
      2910776: Cidade := 'Feira Da Mata/BA';
      2910800: Cidade := 'Feira De Santana/BA';
      2910859: Cidade := 'Filadelfia/BA';
      2910909: Cidade := 'Firmino Alves/BA';
      2911006: Cidade := 'Floresta Azul/BA';
      2911105: Cidade := 'Formosa Do Rio Preto/BA';
      2911204: Cidade := 'Gandu/BA';
      2911253: Cidade := 'Gaviao/BA';
      2911303: Cidade := 'Gentio Do Ouro/BA';
      2911402: Cidade := 'Gloria/BA';
      2911501: Cidade := 'Gongogi/BA';
      2911600: Cidade := 'Governador Mangabeira/BA';
      2911659: Cidade := 'Guajeru/BA';
      2911709: Cidade := 'Guanambi/BA';
      2911808: Cidade := 'Guaratinga/BA';
      2911857: Cidade := 'Heliopolis/BA';
      2911907: Cidade := 'Iacu/BA';
      2912004: Cidade := 'Ibiassuce/BA';
      2912103: Cidade := 'Ibicarai/BA';
      2912202: Cidade := 'Ibicoara/BA';
      2912301: Cidade := 'Ibicui/BA';
      2912400: Cidade := 'Ibipeba/BA';
      2912509: Cidade := 'Ibipitanga/BA';
      2912608: Cidade := 'Ibiquera/BA';
      2912707: Cidade := 'Ibirapitanga/BA';
      2912806: Cidade := 'Ibirapua/BA';
      2912905: Cidade := 'Ibirataia/BA';
      2913002: Cidade := 'Ibitiara/BA';
      2913101: Cidade := 'Ibitita/BA';
      2913200: Cidade := 'Ibotirama/BA';
      2913309: Cidade := 'Ichu/BA';
      2913408: Cidade := 'Igapora/BA';
      2913457: Cidade := 'Igrapiuna/BA';
      2913507: Cidade := 'Iguai/BA';
      2913606: Cidade := 'Ilheus/BA';
      2913705: Cidade := 'Inhambupe/BA';
      2913804: Cidade := 'Ipecaeta/BA';
      2913903: Cidade := 'Ipiau/BA';
      2914000: Cidade := 'Ipira/BA';
      2914109: Cidade := 'Ipupiara/BA';
      2914208: Cidade := 'Irajuba/BA';
      2914307: Cidade := 'Iramaia/BA';
      2914406: Cidade := 'Iraquara/BA';
      2914505: Cidade := 'Irara/BA';
      2914604: Cidade := 'Irece/BA';
      2914653: Cidade := 'Itabela/BA';
      2914703: Cidade := 'Itaberaba/BA';
      2914802: Cidade := 'Itabuna/BA';
      2914901: Cidade := 'Itacare/BA';
      2915007: Cidade := 'Itaete/BA';
      2915106: Cidade := 'Itagi/BA';
      2915205: Cidade := 'Itagiba/BA';
      2915304: Cidade := 'Itagimirim/BA';
      2915353: Cidade := 'Itaguacu Da Bahia/BA';
      2915403: Cidade := 'Itaju Do Colonia/BA';
      2915502: Cidade := 'Itajuipe/BA';
      2915601: Cidade := 'Itamaraju/BA';
      2915700: Cidade := 'Itamari/BA';
      2915809: Cidade := 'Itambe/BA';
      2915908: Cidade := 'Itanagra/BA';
      2916005: Cidade := 'Itanhem/BA';
      2916104: Cidade := 'Itaparica/BA';
      2916203: Cidade := 'Itape/BA';
      2916302: Cidade := 'Itapebi/BA';
      2916401: Cidade := 'Itapetinga/BA';
      2916500: Cidade := 'Itapicuru/BA';
      2916609: Cidade := 'Itapitanga/BA';
      2916708: Cidade := 'Itaquara/BA';
      2916807: Cidade := 'Itarantim/BA';
      2916856: Cidade := 'Itatim/BA';
      2916906: Cidade := 'Itirucu/BA';
      2917003: Cidade := 'Itiuba/BA';
      2917102: Cidade := 'Itororo/BA';
      2917201: Cidade := 'Ituacu/BA';
      2917300: Cidade := 'Itubera/BA';
      2917334: Cidade := 'Iuiu/BA';
      2917359: Cidade := 'Jaborandi/BA';
      2917409: Cidade := 'Jacaraci/BA';
      2917508: Cidade := 'Jacobina/BA';
      2917607: Cidade := 'Jaguaquara/BA';
      2917706: Cidade := 'Jaguarari/BA';
      2917805: Cidade := 'Jaguaripe/BA';
      2917904: Cidade := 'Jandaira/BA';
      2918001: Cidade := 'Jequie/BA';
      2918100: Cidade := 'Jeremoabo/BA';
      2918209: Cidade := 'Jiquirica/BA';
      2918308: Cidade := 'Jitauna/BA';
      2918357: Cidade := 'Joao Dourado/BA';
      2918407: Cidade := 'Juazeiro/BA';
      2918456: Cidade := 'Jucurucu/BA';
      2918506: Cidade := 'Jussara/BA';
      2918555: Cidade := 'Jussari/BA';
      2918605: Cidade := 'Jussiape/BA';
      2918704: Cidade := 'Lafaiete Coutinho/BA';
      2918753: Cidade := 'Lagoa Real/BA';
      2918803: Cidade := 'Laje/BA';
      2918902: Cidade := 'Lajedao/BA';
      2919009: Cidade := 'Lajedinho/BA';
      2919058: Cidade := 'Lajedo Do Tabocal/BA';
      2919108: Cidade := 'Lamarao/BA';
      2919157: Cidade := 'Lapao/BA';
      2919207: Cidade := 'Lauro De Freitas/BA';
      2919306: Cidade := 'Lencois/BA';
      2919405: Cidade := 'Licinio De Almeida/BA';
      2919504: Cidade := 'Livramento De Nossa Senhora/BA';
      2919553: Cidade := 'Luis Eduardo Magalhaes/BA';
      2919603: Cidade := 'Macajuba/BA';
      2919702: Cidade := 'Macarani/BA';
      2919801: Cidade := 'Macaubas/BA';
      2919900: Cidade := 'Macurure/BA';
      2919926: Cidade := 'Madre De Deus/BA';
      2919959: Cidade := 'Maetinga/BA';
      2920007: Cidade := 'Maiquinique/BA';
      2920106: Cidade := 'Mairi/BA';
      2920205: Cidade := 'Malhada/BA';
      2920304: Cidade := 'Malhada De Pedras/BA';
      2920403: Cidade := 'Manoel Vitorino/BA';
      2920452: Cidade := 'Mansidao/BA';
      2920502: Cidade := 'Maracas/BA';
      2920601: Cidade := 'Maragogipe/BA';
      2920700: Cidade := 'Marau/BA';
      2920809: Cidade := 'Marcionilio Souza/BA';
      2920908: Cidade := 'Mascote/BA';
      2921005: Cidade := 'Mata De Sao Joao/BA';
      2921054: Cidade := 'Matina/BA';
      2921104: Cidade := 'Medeiros Neto/BA';
      2921203: Cidade := 'Miguel Calmon/BA';
      2921302: Cidade := 'Milagres/BA';
      2921401: Cidade := 'Mirangaba/BA';
      2921450: Cidade := 'Mirante/BA';
      2921500: Cidade := 'Monte Santo/BA';
      2921609: Cidade := 'Morpara/BA';
      2921708: Cidade := 'Morro Do Chapeu/BA';
      2921807: Cidade := 'Mortugaba/BA';
      2921906: Cidade := 'Mucuge/BA';
      2922003: Cidade := 'Mucuri/BA';
      2922052: Cidade := 'Mulungu Do Morro/BA';
      2922102: Cidade := 'Mundo Novo/BA';
      2922201: Cidade := 'Muniz Ferreira/BA';
      2922250: Cidade := 'Muquem De Sao Francisco/BA';
      2922300: Cidade := 'Muritiba/BA';
      2922409: Cidade := 'Mutuipe/BA';
      2922508: Cidade := 'Nazare/BA';
      2922607: Cidade := 'Nilo Pecanha/BA';
      2922656: Cidade := 'Nordestina/BA';
      2922706: Cidade := 'Nova Canaa/BA';
      2922730: Cidade := 'Nova Fatima/BA';
      2922755: Cidade := 'Nova Ibia/BA';
      2922805: Cidade := 'Nova Itarana/BA';
      2922854: Cidade := 'Nova Redencao/BA';
      2922904: Cidade := 'Nova Soure/BA';
      2923001: Cidade := 'Nova Vicosa/BA';
      2923035: Cidade := 'Novo Horizonte/BA';
      2923050: Cidade := 'Novo Triunfo/BA';
      2923100: Cidade := 'Olindina/BA';
      2923209: Cidade := 'Oliveira Dos Brejinhos/BA';
      2923308: Cidade := 'Ouricangas/BA';
      2923357: Cidade := 'Ourolandia/BA';
      2923407: Cidade := 'Palmas De Monte Alto/BA';
      2923506: Cidade := 'Palmeiras/BA';
      2923605: Cidade := 'Paramirim/BA';
      2923704: Cidade := 'Paratinga/BA';
      2923803: Cidade := 'Paripiranga/BA';
      2923902: Cidade := 'Pau Brasil/BA';
      2924009: Cidade := 'Paulo Afonso/BA';
      2924058: Cidade := 'Pe De Serra/BA';
      2924108: Cidade := 'Pedrao/BA';
      2924207: Cidade := 'Pedro Alexandre/BA';
      2924306: Cidade := 'Piata/BA';
      2924405: Cidade := 'Pilao Arcado/BA';
      2924504: Cidade := 'Pindai/BA';
      2924603: Cidade := 'Pindobacu/BA';
      2924652: Cidade := 'Pintadas/BA';
      2924678: Cidade := 'Pirai Do Norte/BA';
      2924702: Cidade := 'Piripa/BA';
      2924801: Cidade := 'Piritiba/BA';
      2924900: Cidade := 'Planaltino/BA';
      2925006: Cidade := 'Planalto/BA';
      2925105: Cidade := 'Pocoes/BA';
      2925204: Cidade := 'Pojuca/BA';
      2925253: Cidade := 'Ponto Novo/BA';
      2925303: Cidade := 'Porto Seguro/BA';
      2925402: Cidade := 'Potiragua/BA';
      2925501: Cidade := 'Prado/BA';
      2925600: Cidade := 'Presidente Dutra/BA';
      2925709: Cidade := 'Presidente Janio Quadros/BA';
      2925758: Cidade := 'Presidente Tancredo Neves/BA';
      2925808: Cidade := 'Queimadas/BA';
      2925907: Cidade := 'Quijingue/BA';
      2925931: Cidade := 'Quixabeira/BA';
      2925956: Cidade := 'Rafael Jambeiro/BA';
      2926004: Cidade := 'Remanso/BA';
      2926103: Cidade := 'Retirolandia/BA';
      2926202: Cidade := 'Riachao Das Neves/BA';
      2926301: Cidade := 'Riachao Do Jacuipe/BA';
      2926400: Cidade := 'Riacho De Santana/BA';
      2926509: Cidade := 'Ribeira Do Amparo/BA';
      2926608: Cidade := 'Ribeira Do Pombal/BA';
      2926657: Cidade := 'Ribeirao Do Largo/BA';
      2926707: Cidade := 'Rio De Contas/BA';
      2926806: Cidade := 'Rio Do Antonio/BA';
      2926905: Cidade := 'Rio Do Pires/BA';
      2927002: Cidade := 'Rio Real/BA';
      2927101: Cidade := 'Rodelas/BA';
      2927200: Cidade := 'Ruy Barbosa/BA';
      2927309: Cidade := 'Salinas Da Margarida/BA';
      2927408: Cidade := 'Salvador/BA';
      2927507: Cidade := 'Santa Barbara/BA';
      2927606: Cidade := 'Santa Brigida/BA';
      2927705: Cidade := 'Santa Cruz Cabralia/BA';
      2927804: Cidade := 'Santa Cruz Da Vitoria/BA';
      2927903: Cidade := 'Santa Ines/BA';
      2928000: Cidade := 'Santaluz/BA';
      2928059: Cidade := 'Santa Luzia/BA';
      2928109: Cidade := 'Santa Maria Da Vitoria/BA';
      2928208: Cidade := 'Santana/BA';
      2928307: Cidade := 'Santanopolis/BA';
      2928406: Cidade := 'Santa Rita De Cassia/BA';
      2928505: Cidade := 'Santa Teresinha/BA';
      2928604: Cidade := 'Santo Amaro/BA';
      2928703: Cidade := 'Santo Antonio De Jesus/BA';
      2928802: Cidade := 'Santo Estevao/BA';
      2928901: Cidade := 'Sao Desiderio/BA';
      2928950: Cidade := 'Sao Domingos/BA';
      2929008: Cidade := 'Sao Felix/BA';
      2929057: Cidade := 'Sao Felix Do Coribe/BA';
      2929107: Cidade := 'Sao Felipe/BA';
      2929206: Cidade := 'Sao Francisco Do Conde/BA';
      2929255: Cidade := 'Sao Gabriel/BA';
      2929305: Cidade := 'Sao Goncalo Dos Campos/BA';
      2929354: Cidade := 'Sao Jose Da Vitoria/BA';
      2929370: Cidade := 'Sao Jose Do Jacuipe/BA';
      2929404: Cidade := 'Sao Miguel Das Matas/BA';
      2929503: Cidade := 'Sao Sebastiao Do Passe/BA';
      2929602: Cidade := 'Sapeacu/BA';
      2929701: Cidade := 'Satiro Dias/BA';
      2929750: Cidade := 'Saubara/BA';
      2929800: Cidade := 'Saude/BA';
      2929909: Cidade := 'Seabra/BA';
      2930006: Cidade := 'Sebastiao Laranjeiras/BA';
      2930105: Cidade := 'Senhor Do Bonfim/BA';
      2930154: Cidade := 'Serra Do Ramalho/BA';
      2930204: Cidade := 'Sento Se/BA';
      2930303: Cidade := 'Serra Dourada/BA';
      2930402: Cidade := 'Serra Preta/BA';
      2930501: Cidade := 'Serrinha/BA';
      2930600: Cidade := 'Serrolandia/BA';
      2930709: Cidade := 'Simoes Filho/BA';
      2930758: Cidade := 'Sitio Do Mato/BA';
      2930766: Cidade := 'Sitio Do Quinto/BA';
      2930774: Cidade := 'Sobradinho/BA';
      2930808: Cidade := 'Souto Soares/BA';
      2930907: Cidade := 'Tabocas Do Brejo Velho/BA';
      2931004: Cidade := 'Tanhacu/BA';
      2931053: Cidade := 'Tanque Novo/BA';
      2931103: Cidade := 'Tanquinho/BA';
      2931202: Cidade := 'Taperoa/BA';
      2931301: Cidade := 'Tapiramuta/BA';
      2931350: Cidade := 'Teixeira De Freitas/BA';
      2931400: Cidade := 'Teodoro Sampaio/BA';
      2931509: Cidade := 'Teofilandia/BA';
      2931608: Cidade := 'Teolandia/BA';
      2931707: Cidade := 'Terra Nova/BA';
      2931806: Cidade := 'Tremedal/BA';
      2931905: Cidade := 'Tucano/BA';
      2932002: Cidade := 'Uaua/BA';
      2932101: Cidade := 'Ubaira/BA';
      2932200: Cidade := 'Ubaitaba/BA';
      2932309: Cidade := 'Ubata/BA';
      2932408: Cidade := 'Uibai/BA';
      2932457: Cidade := 'Umburanas/BA';
      2932507: Cidade := 'Una/BA';
      2932606: Cidade := 'Urandi/BA';
      2932705: Cidade := 'Urucuca/BA';
      2932804: Cidade := 'Utinga/BA';
      2932903: Cidade := 'Valenca/BA';
      2933000: Cidade := 'Valente/BA';
      2933059: Cidade := 'Varzea Da Roca/BA';
      2933109: Cidade := 'Varzea Do Poco/BA';
      2933158: Cidade := 'Varzea Nova/BA';
      2933174: Cidade := 'Varzedo/BA';
      2933208: Cidade := 'Vera Cruz/BA';
      2933257: Cidade := 'Vereda/BA';
      2933307: Cidade := 'Vitoria Da Conquista/BA';
      2933406: Cidade := 'Wagner/BA';
      2933455: Cidade := 'Wanderley/BA';
      2933505: Cidade := 'Wenceslau Guimaraes/BA';
      2933604: Cidade := 'Xique-Xique/BA';
   end;
 end;

 procedure P31;
 begin
   case ACodigo of
      3100104: Cidade := 'Abadia Dos Dourados/MG';
      3100203: Cidade := 'Abaete/MG';
      3100302: Cidade := 'Abre Campo/MG';
      3100401: Cidade := 'Acaiaca/MG';
      3100500: Cidade := 'Acucena/MG';
      3100609: Cidade := 'Agua Boa/MG';
      3100708: Cidade := 'Agua Comprida/MG';
      3100807: Cidade := 'Aguanil/MG';
      3100906: Cidade := 'Aguas Formosas/MG';
      3101003: Cidade := 'Aguas Vermelhas/MG';
      3101102: Cidade := 'Aimores/MG';
      3101201: Cidade := 'Aiuruoca/MG';
      3101300: Cidade := 'Alagoa/MG';
      3101409: Cidade := 'Albertina/MG';
      3101508: Cidade := 'Alem Paraiba/MG';
      3101607: Cidade := 'Alfenas/MG';
      3101631: Cidade := 'Alfredo Vasconcelos/MG';
      3101706: Cidade := 'Almenara/MG';
      3101805: Cidade := 'Alpercata/MG';
      3101904: Cidade := 'Alpinopolis/MG';
      3102001: Cidade := 'Alterosa/MG';
      3102050: Cidade := 'Alto Caparao/MG';
      3102100: Cidade := 'Alto Rio Doce/MG';
      3102209: Cidade := 'Alvarenga/MG';
      3102308: Cidade := 'Alvinopolis/MG';
      3102407: Cidade := 'Alvorada De Minas/MG';
      3102506: Cidade := 'Amparo Do Serra/MG';
      3102605: Cidade := 'Andradas/MG';
      3102704: Cidade := 'Cachoeira De Pajeu/MG';
      3102803: Cidade := 'Andrelandia/MG';
      3102852: Cidade := 'Angelandia/MG';
      3102902: Cidade := 'Antonio Carlos/MG';
      3103009: Cidade := 'Antonio Dias/MG';
      3103108: Cidade := 'Antonio Prado De Minas/MG';
      3103207: Cidade := 'Aracai/MG';
      3103306: Cidade := 'Aracitaba/MG';
      3103405: Cidade := 'Aracuai/MG';
      3103504: Cidade := 'Araguari/MG';
      3103603: Cidade := 'Arantina/MG';
      3103702: Cidade := 'Araponga/MG';
      3103751: Cidade := 'Arapora/MG';
      3103801: Cidade := 'Arapua/MG';
      3103900: Cidade := 'Araujos/MG';
      3104007: Cidade := 'Araxa/MG';
      3104106: Cidade := 'Arceburgo/MG';
      3104205: Cidade := 'Arcos/MG';
      3104304: Cidade := 'Areado/MG';
      3104403: Cidade := 'Argirita/MG';
      3104452: Cidade := 'Aricanduva/MG';
      3104502: Cidade := 'Arinos/MG';
      3104601: Cidade := 'Astolfo Dutra/MG';
      3104700: Cidade := 'Ataleia/MG';
      3104809: Cidade := 'Augusto De Lima/MG';
      3104908: Cidade := 'Baependi/MG';
      3105004: Cidade := 'Baldim/MG';
      3105103: Cidade := 'Bambui/MG';
      3105202: Cidade := 'Bandeira/MG';
      3105301: Cidade := 'Bandeira Do Sul/MG';
      3105400: Cidade := 'Barao De Cocais/MG';
      3105509: Cidade := 'Barao De Monte Alto/MG';
      3105608: Cidade := 'Barbacena/MG';
      3105707: Cidade := 'Barra Longa/MG';
      3105905: Cidade := 'Barroso/MG';
      3106002: Cidade := 'Bela Vista De Minas/MG';
      3106101: Cidade := 'Belmiro Braga/MG';
      3106200: Cidade := 'Belo Horizonte/MG';
      3106309: Cidade := 'Belo Oriente/MG';
      3106408: Cidade := 'Belo Vale/MG';
      3106507: Cidade := 'Berilo/MG';
      3106606: Cidade := 'Bertopolis/MG';
      3106655: Cidade := 'Berizal/MG';
      3106705: Cidade := 'Betim/MG';
      3106804: Cidade := 'Bias Fortes/MG';
      3106903: Cidade := 'Bicas/MG';
      3107000: Cidade := 'Biquinhas/MG';
      3107109: Cidade := 'Boa Esperanca/MG';
      3107208: Cidade := 'Bocaina De Minas/MG';
      3107307: Cidade := 'Bocaiuva/MG';
      3107406: Cidade := 'Bom Despacho/MG';
      3107505: Cidade := 'Bom Jardim De Minas/MG';
      3107604: Cidade := 'Bom Jesus Da Penha/MG';
      3107703: Cidade := 'Bom Jesus Do Amparo/MG';
      3107802: Cidade := 'Bom Jesus Do Galho/MG';
      3107901: Cidade := 'Bom Repouso/MG';
      3108008: Cidade := 'Bom Sucesso/MG';
      3108107: Cidade := 'Bonfim/MG';
      3108206: Cidade := 'Bonfinopolis De Minas/MG';
      3108255: Cidade := 'Bonito De Minas/MG';
      3108305: Cidade := 'Borda Da Mata/MG';
      3108404: Cidade := 'Botelhos/MG';
      3108503: Cidade := 'Botumirim/MG';
      3108552: Cidade := 'Brasilandia De Minas/MG';
      3108602: Cidade := 'Brasilia De Minas/MG';
      3108701: Cidade := 'Bras Pires/MG';
      3108800: Cidade := 'Braunas/MG';
      3108909: Cidade := 'Brasopolis/MG';
      3109006: Cidade := 'Brumadinho/MG';
      3109105: Cidade := 'Bueno Brandao/MG';
      3109204: Cidade := 'Buenopolis/MG';
      3109253: Cidade := 'Bugre/MG';
      3109303: Cidade := 'Buritis/MG';
      3109402: Cidade := 'Buritizeiro/MG';
      3109451: Cidade := 'Cabeceira Grande/MG';
      3109501: Cidade := 'Cabo Verde/MG';
      3109600: Cidade := 'Cachoeira Da Prata/MG';
      3109709: Cidade := 'Cachoeira De Minas/MG';
      3109808: Cidade := 'Cachoeira Dourada/MG';
      3109907: Cidade := 'Caetanopolis/MG';
      3110004: Cidade := 'Caete/MG';
      3110103: Cidade := 'Caiana/MG';
      3110202: Cidade := 'Cajuri/MG';
      3110301: Cidade := 'Caldas/MG';
      3110400: Cidade := 'Camacho/MG';
      3110509: Cidade := 'Camanducaia/MG';
      3110608: Cidade := 'Cambui/MG';
      3110707: Cidade := 'Cambuquira/MG';
      3110806: Cidade := 'Campanario/MG';
      3110905: Cidade := 'Campanha/MG';
      3111002: Cidade := 'Campestre/MG';
      3111101: Cidade := 'Campina Verde/MG';
      3111150: Cidade := 'Campo Azul/MG';
      3111200: Cidade := 'Campo Belo/MG';
      3111309: Cidade := 'Campo Do Meio/MG';
      3111408: Cidade := 'Campo Florido/MG';
      3111507: Cidade := 'Campos Altos/MG';
      3111606: Cidade := 'Campos Gerais/MG';
      3111705: Cidade := 'Canaa/MG';
      3111804: Cidade := 'Canapolis/MG';
      3111903: Cidade := 'Cana Verde/MG';
      3112000: Cidade := 'Candeias/MG';
      3112059: Cidade := 'Cantagalo/MG';
      3112109: Cidade := 'Caparao/MG';
      3112208: Cidade := 'Capela Nova/MG';
      3112307: Cidade := 'Capelinha/MG';
      3112406: Cidade := 'Capetinga/MG';
      3112505: Cidade := 'Capim Branco/MG';
      3112604: Cidade := 'Capinopolis/MG';
      3112653: Cidade := 'Capitao Andrade/MG';
      3112703: Cidade := 'Capitao Eneas/MG';
      3112802: Cidade := 'Capitolio/MG';
      3112901: Cidade := 'Caputira/MG';
      3113008: Cidade := 'Carai/MG';
      3113107: Cidade := 'Caranaiba/MG';
      3113206: Cidade := 'Carandai/MG';
      3113305: Cidade := 'Carangola/MG';
      3113404: Cidade := 'Caratinga/MG';
      3113503: Cidade := 'Carbonita/MG';
      3113602: Cidade := 'Careacu/MG';
      3113701: Cidade := 'Carlos Chagas/MG';
      3113800: Cidade := 'Carmesia/MG';
      3113909: Cidade := 'Carmo Da Cachoeira/MG';
      3114006: Cidade := 'Carmo Da Mata/MG';
      3114105: Cidade := 'Carmo De Minas/MG';
      3114204: Cidade := 'Carmo Do Cajuru/MG';
      3114303: Cidade := 'Carmo Do Paranaiba/MG';
      3114402: Cidade := 'Carmo Do Rio Claro/MG';
      3114501: Cidade := 'Carmopolis De Minas/MG';
      3114550: Cidade := 'Carneirinho/MG';
      3114600: Cidade := 'Carrancas/MG';
      3114709: Cidade := 'Carvalhopolis/MG';
      3114808: Cidade := 'Carvalhos/MG';
      3114907: Cidade := 'Casa Grande/MG';
      3115003: Cidade := 'Cascalho Rico/MG';
      3115102: Cidade := 'Cassia/MG';
      3115201: Cidade := 'Conceicao Da Barra De Minas/MG';
      3115300: Cidade := 'Cataguases/MG';
      3115359: Cidade := 'Catas Altas/MG';
      3115409: Cidade := 'Catas Altas Da Noruega/MG';
      3115458: Cidade := 'Catuji/MG';
      3115474: Cidade := 'Catuti/MG';
      3115508: Cidade := 'Caxambu/MG';
      3115607: Cidade := 'Cedro Do Abaete/MG';
      3115706: Cidade := 'Central De Minas/MG';
      3115805: Cidade := 'Centralina/MG';
      3115904: Cidade := 'Chacara/MG';
      3116001: Cidade := 'Chale/MG';
      3116100: Cidade := 'Chapada Do Norte/MG';
      3116159: Cidade := 'Chapada Gaucha/MG';
      3116209: Cidade := 'Chiador/MG';
      3116308: Cidade := 'Cipotanea/MG';
      3116407: Cidade := 'Claraval/MG';
      3116506: Cidade := 'Claro Dos Pocoes/MG';
      3116605: Cidade := 'Claudio/MG';
      3116704: Cidade := 'Coimbra/MG';
      3116803: Cidade := 'Coluna/MG';
      3116902: Cidade := 'Comendador Gomes/MG';
      3117009: Cidade := 'Comercinho/MG';
      3117108: Cidade := 'Conceicao Da Aparecida/MG';
      3117207: Cidade := 'Conceicao Das Pedras/MG';
      3117306: Cidade := 'Conceicao Das Alagoas/MG';
      3117405: Cidade := 'Conceicao De Ipanema/MG';
      3117504: Cidade := 'Conceicao Do Mato Dentro/MG';
      3117603: Cidade := 'Conceicao Do Para/MG';
      3117702: Cidade := 'Conceicao Do Rio Verde/MG';
      3117801: Cidade := 'Conceicao Dos Ouros/MG';
      3117836: Cidade := 'Conego Marinho/MG';
      3117876: Cidade := 'Confins/MG';
      3117900: Cidade := 'Congonhal/MG';
      3118007: Cidade := 'Congonhas/MG';
      3118106: Cidade := 'Congonhas Do Norte/MG';
      3118205: Cidade := 'Conquista/MG';
      3118304: Cidade := 'Conselheiro Lafaiete/MG';
      3118403: Cidade := 'Conselheiro Pena/MG';
      3118502: Cidade := 'Consolacao/MG';
      3118601: Cidade := 'Contagem/MG';
      3118700: Cidade := 'Coqueiral/MG';
      3118809: Cidade := 'Coracao De Jesus/MG';
      3118908: Cidade := 'Cordisburgo/MG';
      3119005: Cidade := 'Cordislandia/MG';
      3119104: Cidade := 'Corinto/MG';
      3119203: Cidade := 'Coroaci/MG';
      3119302: Cidade := 'Coromandel/MG';
      3119401: Cidade := 'Coronel Fabriciano/MG';
      3119500: Cidade := 'Coronel Murta/MG';
      3119609: Cidade := 'Coronel Pacheco/MG';
      3119708: Cidade := 'Coronel Xavier Chaves/MG';
      3119807: Cidade := 'Corrego Danta/MG';
      3119906: Cidade := 'Corrego Do Bom Jesus/MG';
      3119955: Cidade := 'Corrego Fundo/MG';
      3120003: Cidade := 'Corrego Novo/MG';
      3120102: Cidade := 'Couto De Magalhaes De Minas/MG';
      3120151: Cidade := 'Crisolita/MG';
      3120201: Cidade := 'Cristais/MG';
      3120300: Cidade := 'Cristalia/MG';
      3120409: Cidade := 'Cristiano Otoni/MG';
      3120508: Cidade := 'Cristina/MG';
      3120607: Cidade := 'Crucilandia/MG';
      3120706: Cidade := 'Cruzeiro Da Fortaleza/MG';
      3120805: Cidade := 'Cruzilia/MG';
      3120839: Cidade := 'Cuparaque/MG';
      3120870: Cidade := 'Curral De Dentro/MG';
      3120904: Cidade := 'Curvelo/MG';
      3121001: Cidade := 'Datas/MG';
      3121100: Cidade := 'Delfim Moreira/MG';
      3121209: Cidade := 'Delfinopolis/MG';
      3121258: Cidade := 'Delta/MG';
      3121308: Cidade := 'Descoberto/MG';
      3121407: Cidade := 'Desterro De Entre Rios/MG';
      3121506: Cidade := 'Desterro Do Melo/MG';
      3121605: Cidade := 'Diamantina/MG';
      3121704: Cidade := 'Diogo De Vasconcelos/MG';
      3121803: Cidade := 'Dionisio/MG';
      3121902: Cidade := 'Divinesia/MG';
      3122009: Cidade := 'Divino/MG';
      3122108: Cidade := 'Divino Das Laranjeiras/MG';
      3122207: Cidade := 'Divinolandia De Minas/MG';
      3122306: Cidade := 'Divinopolis/MG';
      3122355: Cidade := 'Divisa Alegre/MG';
      3122405: Cidade := 'Divisa Nova/MG';
      3122454: Cidade := 'Divisopolis/MG';
      3122470: Cidade := 'Dom Bosco/MG';
      3122504: Cidade := 'Dom Cavati/MG';
      3122603: Cidade := 'Dom Joaquim/MG';
      3122702: Cidade := 'Dom Silverio/MG';
      3122801: Cidade := 'Dom Vicoso/MG';
      3122900: Cidade := 'Dona Eusebia/MG';
      3123007: Cidade := 'Dores De Campos/MG';
      3123106: Cidade := 'Dores De Guanhaes/MG';
      3123205: Cidade := 'Dores Do Indaia/MG';
      3123304: Cidade := 'Dores Do Turvo/MG';
      3123403: Cidade := 'Doresopolis/MG';
      3123502: Cidade := 'Douradoquara/MG';
      3123528: Cidade := 'Durande/MG';
      3123601: Cidade := 'Eloi Mendes/MG';
      3123700: Cidade := 'Engenheiro Caldas/MG';
      3123809: Cidade := 'Engenheiro Navarro/MG';
      3123858: Cidade := 'Entre Folhas/MG';
      3123908: Cidade := 'Entre Rios De Minas/MG';
      3124005: Cidade := 'Ervalia/MG';
      3124104: Cidade := 'Esmeraldas/MG';
      3124203: Cidade := 'Espera Feliz/MG';
      3124302: Cidade := 'Espinosa/MG';
      3124401: Cidade := 'Espirito Santo Do Dourado/MG';
      3124500: Cidade := 'Estiva/MG';
      3124609: Cidade := 'Estrela Dalva/MG';
      3124708: Cidade := 'Estrela Do Indaia/MG';
      3124807: Cidade := 'Estrela Do Sul/MG';
      3124906: Cidade := 'Eugenopolis/MG';
      3125002: Cidade := 'Ewbank Da Camara/MG';
      3125101: Cidade := 'Extrema/MG';
      3125200: Cidade := 'Fama/MG';
      3125309: Cidade := 'Faria Lemos/MG';
      3125408: Cidade := 'Felicio Dos Santos/MG';
      3125507: Cidade := 'Sao Goncalo Do Rio Preto/MG';
      3125606: Cidade := 'Felisburgo/MG';
      3125705: Cidade := 'Felixlandia/MG';
      3125804: Cidade := 'Fernandes Tourinho/MG';
      3125903: Cidade := 'Ferros/MG';
      3125952: Cidade := 'Fervedouro/MG';
      3126000: Cidade := 'Florestal/MG';
      3126109: Cidade := 'Formiga/MG';
      3126208: Cidade := 'Formoso/MG';
      3126307: Cidade := 'Fortaleza De Minas/MG';
      3126406: Cidade := 'Fortuna De Minas/MG';
      3126505: Cidade := 'Francisco Badaro/MG';
      3126604: Cidade := 'Francisco Dumont/MG';
      3126703: Cidade := 'Francisco Sa/MG';
      3126752: Cidade := 'Franciscopolis/MG';
      3126802: Cidade := 'Frei Gaspar/MG';
      3126901: Cidade := 'Frei Inocencio/MG';
      3126950: Cidade := 'Frei Lagonegro/MG';
      3127008: Cidade := 'Fronteira/MG';
      3127057: Cidade := 'Fronteira Dos Vales/MG';
      3127073: Cidade := 'Fruta De Leite/MG';
      3127107: Cidade := 'Frutal/MG';
      3127206: Cidade := 'Funilandia/MG';
      3127305: Cidade := 'Galileia/MG';
      3127339: Cidade := 'Gameleiras/MG';
      3127354: Cidade := 'Glaucilandia/MG';
      3127370: Cidade := 'Goiabeira/MG';
      3127388: Cidade := 'Goiana/MG';
      3127404: Cidade := 'Goncalves/MG';
      3127503: Cidade := 'Gonzaga/MG';
      3127602: Cidade := 'Gouveia/MG';
      3127701: Cidade := 'Governador Valadares/MG';
      3127800: Cidade := 'Grao Mogol/MG';
      3127909: Cidade := 'Grupiara/MG';
      3128006: Cidade := 'Guanhaes/MG';
      3128105: Cidade := 'Guape/MG';
      3128204: Cidade := 'Guaraciaba/MG';
      3128253: Cidade := 'Guaraciama/MG';
      3128303: Cidade := 'Guaranesia/MG';
      3128402: Cidade := 'Guarani/MG';
      3128501: Cidade := 'Guarara/MG';
      3128600: Cidade := 'Guarda-Mor/MG';
      3128709: Cidade := 'Guaxupe/MG';
      3128808: Cidade := 'Guidoval/MG';
      3128907: Cidade := 'Guimarania/MG';
      3129004: Cidade := 'Guiricema/MG';
      3129103: Cidade := 'Gurinhata/MG';
      3129202: Cidade := 'Heliodora/MG';
      3129301: Cidade := 'Iapu/MG';
      3129400: Cidade := 'Ibertioga/MG';
      3129509: Cidade := 'Ibia/MG';
      3129608: Cidade := 'Ibiai/MG';
      3129657: Cidade := 'Ibiracatu/MG';
      3129707: Cidade := 'Ibiraci/MG';
      3129806: Cidade := 'Ibirite/MG';
      3129905: Cidade := 'Ibitiura De Minas/MG';
      3130002: Cidade := 'Ibituruna/MG';
      3130051: Cidade := 'Icarai De Minas/MG';
      3130101: Cidade := 'Igarape/MG';
      3130200: Cidade := 'Igaratinga/MG';
      3130309: Cidade := 'Iguatama/MG';
      3130408: Cidade := 'Ijaci/MG';
      3130507: Cidade := 'Ilicinea/MG';
      3130556: Cidade := 'Imbe De Minas/MG';
      3130606: Cidade := 'Inconfidentes/MG';
      3130655: Cidade := 'Indaiabira/MG';
      3130705: Cidade := 'Indianopolis/MG';
      3130804: Cidade := 'Ingai/MG';
      3130903: Cidade := 'Inhapim/MG';
      3131000: Cidade := 'Inhauma/MG';
      3131109: Cidade := 'Inimutaba/MG';
      3131158: Cidade := 'Ipaba/MG';
      3131208: Cidade := 'Ipanema/MG';
      3131307: Cidade := 'Ipatinga/MG';
      3131406: Cidade := 'Ipiacu/MG';
      3131505: Cidade := 'Ipuiuna/MG';
      3131604: Cidade := 'Irai De Minas/MG';
      3131703: Cidade := 'Itabira/MG';
      3131802: Cidade := 'Itabirinha/MG';
      3131901: Cidade := 'Itabirito/MG';
      3132008: Cidade := 'Itacambira/MG';
      3132107: Cidade := 'Itacarambi/MG';
      3132206: Cidade := 'Itaguara/MG';
      3132305: Cidade := 'Itaipe/MG';
      3132404: Cidade := 'Itajuba/MG';
      3132503: Cidade := 'Itamarandiba/MG';
      3132602: Cidade := 'Itamarati De Minas/MG';
      3132701: Cidade := 'Itambacuri/MG';
      3132800: Cidade := 'Itambe Do Mato Dentro/MG';
      3132909: Cidade := 'Itamogi/MG';
      3133006: Cidade := 'Itamonte/MG';
      3133105: Cidade := 'Itanhandu/MG';
      3133204: Cidade := 'Itanhomi/MG';
      3133303: Cidade := 'Itaobim/MG';
      3133402: Cidade := 'Itapagipe/MG';
      3133501: Cidade := 'Itapecerica/MG';
      3133600: Cidade := 'Itapeva/MG';
      3133709: Cidade := 'Itatiaiucu/MG';
      3133758: Cidade := 'Itau De Minas/MG';
      3133808: Cidade := 'Itauna/MG';
      3133907: Cidade := 'Itaverava/MG';
      3134004: Cidade := 'Itinga/MG';
      3134103: Cidade := 'Itueta/MG';
      3134202: Cidade := 'Ituiutaba/MG';
      3134301: Cidade := 'Itumirim/MG';
      3134400: Cidade := 'Iturama/MG';
      3134509: Cidade := 'Itutinga/MG';
      3134608: Cidade := 'Jaboticatubas/MG';
      3134707: Cidade := 'Jacinto/MG';
      3134806: Cidade := 'Jacui/MG';
      3134905: Cidade := 'Jacutinga/MG';
      3135001: Cidade := 'Jaguaracu/MG';
      3135050: Cidade := 'Jaiba/MG';
      3135076: Cidade := 'Jampruca/MG';
      3135100: Cidade := 'Janauba/MG';
      3135209: Cidade := 'Januaria/MG';
      3135308: Cidade := 'Japaraiba/MG';
      3135357: Cidade := 'Japonvar/MG';
      3135407: Cidade := 'Jeceaba/MG';
      3135456: Cidade := 'Jenipapo De Minas/MG';
      3135506: Cidade := 'Jequeri/MG';
      3135605: Cidade := 'Jequitai/MG';
      3135704: Cidade := 'Jequitiba/MG';
      3135803: Cidade := 'Jequitinhonha/MG';
      3135902: Cidade := 'Jesuania/MG';
      3136009: Cidade := 'Joaima/MG';
      3136108: Cidade := 'Joanesia/MG';
      3136207: Cidade := 'Joao Monlevade/MG';
      3136306: Cidade := 'Joao Pinheiro/MG';
      3136405: Cidade := 'Joaquim Felicio/MG';
      3136504: Cidade := 'Jordania/MG';
      3136520: Cidade := 'Jose Goncalves De Minas/MG';
      3136553: Cidade := 'Jose Raydan/MG';
      3136579: Cidade := 'Josenopolis/MG';
      3136603: Cidade := 'Nova Uniao/MG';
      3136652: Cidade := 'Juatuba/MG';
      3136702: Cidade := 'Juiz De Fora/MG';
      3136801: Cidade := 'Juramento/MG';
      3136900: Cidade := 'Juruaia/MG';
      3136959: Cidade := 'Juvenilia/MG';
      3137007: Cidade := 'Ladainha/MG';
      3137106: Cidade := 'Lagamar/MG';
      3137205: Cidade := 'Lagoa Da Prata/MG';
      3137304: Cidade := 'Lagoa Dos Patos/MG';
      3137403: Cidade := 'Lagoa Dourada/MG';
      3137502: Cidade := 'Lagoa Formosa/MG';
      3137536: Cidade := 'Lagoa Grande/MG';
      3137601: Cidade := 'Lagoa Santa/MG';
      3137700: Cidade := 'Lajinha/MG';
      3137809: Cidade := 'Lambari/MG';
      3137908: Cidade := 'Lamim/MG';
      3138005: Cidade := 'Laranjal/MG';
      3138104: Cidade := 'Lassance/MG';
      3138203: Cidade := 'Lavras/MG';
      3138302: Cidade := 'Leandro Ferreira/MG';
      3138351: Cidade := 'Leme Do Prado/MG';
      3138401: Cidade := 'Leopoldina/MG';
      3138500: Cidade := 'Liberdade/MG';
      3138609: Cidade := 'Lima Duarte/MG';
      3138625: Cidade := 'Limeira Do Oeste/MG';
      3138658: Cidade := 'Lontra/MG';
      3138674: Cidade := 'Luisburgo/MG';
      3138682: Cidade := 'Luislandia/MG';
      3138708: Cidade := 'Luminarias/MG';
      3138807: Cidade := 'Luz/MG';
      3138906: Cidade := 'Machacalis/MG';
      3139003: Cidade := 'Machado/MG';
      3139102: Cidade := 'Madre De Deus De Minas/MG';
      3139201: Cidade := 'Malacacheta/MG';
      3139250: Cidade := 'Mamonas/MG';
      3139300: Cidade := 'Manga/MG';
      3139409: Cidade := 'Manhuacu/MG';
      3139508: Cidade := 'Manhumirim/MG';
      3139607: Cidade := 'Mantena/MG';
      3139706: Cidade := 'Maravilhas/MG';
      3139805: Cidade := 'Mar De Espanha/MG';
      3139904: Cidade := 'Maria Da Fe/MG';
      3140001: Cidade := 'Mariana/MG';
      3140100: Cidade := 'Marilac/MG';
      3140159: Cidade := 'Mario Campos/MG';
      3140209: Cidade := 'Maripa De Minas/MG';
      3140308: Cidade := 'Marlieria/MG';
      3140407: Cidade := 'Marmelopolis/MG';
      3140506: Cidade := 'Martinho Campos/MG';
      3140530: Cidade := 'Martins Soares/MG';
      3140555: Cidade := 'Mata Verde/MG';
      3140605: Cidade := 'Materlandia/MG';
      3140704: Cidade := 'Mateus Leme/MG';
      3140803: Cidade := 'Matias Barbosa/MG';
      3140852: Cidade := 'Matias Cardoso/MG';
      3140902: Cidade := 'Matipo/MG';
      3141009: Cidade := 'Mato Verde/MG';
      3141108: Cidade := 'Matozinhos/MG';
      3141207: Cidade := 'Matutina/MG';
      3141306: Cidade := 'Medeiros/MG';
      3141405: Cidade := 'Medina/MG';
      3141504: Cidade := 'Mendes Pimentel/MG';
      3141603: Cidade := 'Merces/MG';
      3141702: Cidade := 'Mesquita/MG';
      3141801: Cidade := 'Minas Novas/MG';
      3141900: Cidade := 'Minduri/MG';
      3142007: Cidade := 'Mirabela/MG';
      3142106: Cidade := 'Miradouro/MG';
      3142205: Cidade := 'Mirai/MG';
      3142254: Cidade := 'Miravania/MG';
      3142304: Cidade := 'Moeda/MG';
      3142403: Cidade := 'Moema/MG';
      3142502: Cidade := 'Monjolos/MG';
      3142601: Cidade := 'Monsenhor Paulo/MG';
      3142700: Cidade := 'Montalvania/MG';
      3142809: Cidade := 'Monte Alegre De Minas/MG';
      3142908: Cidade := 'Monte Azul/MG';
      3143005: Cidade := 'Monte Belo/MG';
      3143104: Cidade := 'Monte Carmelo/MG';
      3143153: Cidade := 'Monte Formoso/MG';
      3143203: Cidade := 'Monte Santo De Minas/MG';
      3143302: Cidade := 'Montes Claros/MG';
      3143401: Cidade := 'Monte Siao/MG';
      3143450: Cidade := 'Montezuma/MG';
      3143500: Cidade := 'Morada Nova De Minas/MG';
      3143609: Cidade := 'Morro Da Garca/MG';
      3143708: Cidade := 'Morro Do Pilar/MG';
      3143807: Cidade := 'Munhoz/MG';
      3143906: Cidade := 'Muriae/MG';
      3144003: Cidade := 'Mutum/MG';
      3144102: Cidade := 'Muzambinho/MG';
      3144201: Cidade := 'Nacip Raydan/MG';
      3144300: Cidade := 'Nanuque/MG';
      3144359: Cidade := 'Naque/MG';
      3144375: Cidade := 'Natalandia/MG';
      3144409: Cidade := 'Natercia/MG';
      3144508: Cidade := 'Nazareno/MG';
      3144607: Cidade := 'Nepomuceno/MG';
      3144656: Cidade := 'Ninheira/MG';
      3144672: Cidade := 'Nova Belem/MG';
      3144706: Cidade := 'Nova Era/MG';
      3144805: Cidade := 'Nova Lima/MG';
      3144904: Cidade := 'Nova Modica/MG';
      3145000: Cidade := 'Nova Ponte/MG';
      3145059: Cidade := 'Nova Porteirinha/MG';
      3145109: Cidade := 'Nova Resende/MG';
      3145208: Cidade := 'Nova Serrana/MG';
      3145307: Cidade := 'Novo Cruzeiro/MG';
      3145356: Cidade := 'Novo Oriente De Minas/MG';
      3145372: Cidade := 'Novorizonte/MG';
      3145406: Cidade := 'Olaria/MG';
      3145455: Cidade := 'Olhos-D Agua/MG';
      3145505: Cidade := 'Olimpio Noronha/MG';
      3145604: Cidade := 'Oliveira/MG';
      3145703: Cidade := 'Oliveira Fortes/MG';
      3145802: Cidade := 'Onca De Pitangui/MG';
      3145851: Cidade := 'Oratorios/MG';
      3145877: Cidade := 'Orizania/MG';
      3145901: Cidade := 'Ouro Branco/MG';
      3146008: Cidade := 'Ouro Fino/MG';
      3146107: Cidade := 'Ouro Preto/MG';
      3146206: Cidade := 'Ouro Verde De Minas/MG';
      3146255: Cidade := 'Padre Carvalho/MG';
      3146305: Cidade := 'Padre Paraiso/MG';
      3146404: Cidade := 'Paineiras/MG';
      3146503: Cidade := 'Pains/MG';
      3146552: Cidade := 'Pai Pedro/MG';
      3146602: Cidade := 'Paiva/MG';
      3146701: Cidade := 'Palma/MG';
      3146750: Cidade := 'Palmopolis/MG';
      3146909: Cidade := 'Papagaios/MG';
      3147006: Cidade := 'Paracatu/MG';
      3147105: Cidade := 'Para De Minas/MG';
      3147204: Cidade := 'Paraguacu/MG';
      3147303: Cidade := 'Paraisopolis/MG';
      3147402: Cidade := 'Paraopeba/MG';
      3147501: Cidade := 'Passabem/MG';
      3147600: Cidade := 'Passa Quatro/MG';
      3147709: Cidade := 'Passa Tempo/MG';
      3147808: Cidade := 'Passa-Vinte/MG';
      3147907: Cidade := 'Passos/MG';
      3147956: Cidade := 'Patis/MG';
      3148004: Cidade := 'Patos De Minas/MG';
      3148103: Cidade := 'Patrocinio/MG';
      3148202: Cidade := 'Patrocinio Do Muriae/MG';
      3148301: Cidade := 'Paula Candido/MG';
      3148400: Cidade := 'Paulistas/MG';
      3148509: Cidade := 'Pavao/MG';
      3148608: Cidade := 'Pecanha/MG';
      3148707: Cidade := 'Pedra Azul/MG';
      3148756: Cidade := 'Pedra Bonita/MG';
      3148806: Cidade := 'Pedra Do Anta/MG';
      3148905: Cidade := 'Pedra Do Indaia/MG';
      3149002: Cidade := 'Pedra Dourada/MG';
      3149101: Cidade := 'Pedralva/MG';
      3149150: Cidade := 'Pedras De Maria Da Cruz/MG';
      3149200: Cidade := 'Pedrinopolis/MG';
      3149309: Cidade := 'Pedro Leopoldo/MG';
      3149408: Cidade := 'Pedro Teixeira/MG';
      3149507: Cidade := 'Pequeri/MG';
      3149606: Cidade := 'Pequi/MG';
      3149705: Cidade := 'Perdigao/MG';
      3149804: Cidade := 'Perdizes/MG';
      3149903: Cidade := 'Perdoes/MG';
      3149952: Cidade := 'Periquito/MG';
      3150000: Cidade := 'Pescador/MG';
      3150109: Cidade := 'Piau/MG';
      3150158: Cidade := 'Piedade De Caratinga/MG';
      3150208: Cidade := 'Piedade De Ponte Nova/MG';
      3150307: Cidade := 'Piedade Do Rio Grande/MG';
      3150406: Cidade := 'Piedade Dos Gerais/MG';
      3150505: Cidade := 'Pimenta/MG';
      3150539: Cidade := 'Pingo-D Agua/MG';
      3150570: Cidade := 'Pintopolis/MG';
      3150604: Cidade := 'Piracema/MG';
      3150703: Cidade := 'Pirajuba/MG';
      3150802: Cidade := 'Piranga/MG';
      3150901: Cidade := 'Pirangucu/MG';
      3151008: Cidade := 'Piranguinho/MG';
      3151107: Cidade := 'Pirapetinga/MG';
      3151206: Cidade := 'Pirapora/MG';
      3151305: Cidade := 'Pirauba/MG';
      3151404: Cidade := 'Pitangui/MG';
      3151503: Cidade := 'Piumhi/MG';
      3151602: Cidade := 'Planura/MG';
      3151701: Cidade := 'Poco Fundo/MG';
      3151800: Cidade := 'Pocos De Caldas/MG';
      3151909: Cidade := 'Pocrane/MG';
      3152006: Cidade := 'Pompeu/MG';
      3152105: Cidade := 'Ponte Nova/MG';
      3152131: Cidade := 'Ponto Chique/MG';
      3152170: Cidade := 'Ponto Dos Volantes/MG';
      3152204: Cidade := 'Porteirinha/MG';
      3152303: Cidade := 'Porto Firme/MG';
      3152402: Cidade := 'Pote/MG';
      3152501: Cidade := 'Pouso Alegre/MG';
      3152600: Cidade := 'Pouso Alto/MG';
      3152709: Cidade := 'Prados/MG';
      3152808: Cidade := 'Prata/MG';
      3152907: Cidade := 'Pratapolis/MG';
      3153004: Cidade := 'Pratinha/MG';
      3153103: Cidade := 'Presidente Bernardes/MG';
      3153202: Cidade := 'Presidente Juscelino/MG';
      3153301: Cidade := 'Presidente Kubitschek/MG';
      3153400: Cidade := 'Presidente Olegario/MG';
      3153509: Cidade := 'Alto Jequitiba/MG';
      3153608: Cidade := 'Prudente De Morais/MG';
      3153707: Cidade := 'Quartel Geral/MG';
      3153806: Cidade := 'Queluzito/MG';
      3153905: Cidade := 'Raposos/MG';
      3154002: Cidade := 'Raul Soares/MG';
      3154101: Cidade := 'Recreio/MG';
      3154150: Cidade := 'Reduto/MG';
      3154200: Cidade := 'Resende Costa/MG';
      3154309: Cidade := 'Resplendor/MG';
      3154408: Cidade := 'Ressaquinha/MG';
      3154457: Cidade := 'Riachinho/MG';
      3154507: Cidade := 'Riacho Dos Machados/MG';
      3154606: Cidade := 'Ribeirao Das Neves/MG';
      3154705: Cidade := 'Ribeirao Vermelho/MG';
      3154804: Cidade := 'Rio Acima/MG';
      3154903: Cidade := 'Rio Casca/MG';
      3155009: Cidade := 'Rio Doce/MG';
      3155108: Cidade := 'Rio Do Prado/MG';
      3155207: Cidade := 'Rio Espera/MG';
      3155306: Cidade := 'Rio Manso/MG';
      3155405: Cidade := 'Rio Novo/MG';
      3155504: Cidade := 'Rio Paranaiba/MG';
      3155603: Cidade := 'Rio Pardo De Minas/MG';
      3155702: Cidade := 'Rio Piracicaba/MG';
      3155801: Cidade := 'Rio Pomba/MG';
      3155900: Cidade := 'Rio Preto/MG';
      3156007: Cidade := 'Rio Vermelho/MG';
      3156106: Cidade := 'Ritapolis/MG';
      3156205: Cidade := 'Rochedo De Minas/MG';
      3156304: Cidade := 'Rodeiro/MG';
      3156403: Cidade := 'Romaria/MG';
      3156452: Cidade := 'Rosario Da Limeira/MG';
      3156502: Cidade := 'Rubelita/MG';
      3156601: Cidade := 'Rubim/MG';
      3156700: Cidade := 'Sabara/MG';
      3156809: Cidade := 'Sabinopolis/MG';
      3156908: Cidade := 'Sacramento/MG';
      3157005: Cidade := 'Salinas/MG';
      3157104: Cidade := 'Salto Da Divisa/MG';
      3157203: Cidade := 'Santa Barbara/MG';
      3157252: Cidade := 'Santa Barbara Do Leste/MG';
      3157278: Cidade := 'Santa Barbara Do Monte Verde/MG';
      3157302: Cidade := 'Santa Barbara Do Tugurio/MG';
      3157336: Cidade := 'Santa Cruz De Minas/MG';
      3157377: Cidade := 'Santa Cruz De Salinas/MG';
      3157401: Cidade := 'Santa Cruz Do Escalvado/MG';
      3157500: Cidade := 'Santa Efigenia De Minas/MG';
      3157609: Cidade := 'Santa Fe De Minas/MG';
      3157658: Cidade := 'Santa Helena De Minas/MG';
      3157708: Cidade := 'Santa Juliana/MG';
      3157807: Cidade := 'Santa Luzia/MG';
      3157906: Cidade := 'Santa Margarida/MG';
      3158003: Cidade := 'Santa Maria De Itabira/MG';
      3158102: Cidade := 'Santa Maria Do Salto/MG';
      3158201: Cidade := 'Santa Maria Do Suacui/MG';
      3158300: Cidade := 'Santana Da Vargem/MG';
      3158409: Cidade := 'Santana De Cataguases/MG';
      3158508: Cidade := 'Santana De Pirapama/MG';
      3158607: Cidade := 'Santana Do Deserto/MG';
      3158706: Cidade := 'Santana Do Garambeu/MG';
      3158805: Cidade := 'Santana Do Jacare/MG';
      3158904: Cidade := 'Santana Do Manhuacu/MG';
      3158953: Cidade := 'Santana Do Paraiso/MG';
      3159001: Cidade := 'Santana Do Riacho/MG';
      3159100: Cidade := 'Santana Dos Montes/MG';
      3159209: Cidade := 'Santa Rita De Caldas/MG';
      3159308: Cidade := 'Santa Rita De Jacutinga/MG';
      3159357: Cidade := 'Santa Rita De Minas/MG';
      3159407: Cidade := 'Santa Rita De Ibitipoca/MG';
      3159506: Cidade := 'Santa Rita Do Itueto/MG';
      3159605: Cidade := 'Santa Rita Do Sapucai/MG';
      3159704: Cidade := 'Santa Rosa Da Serra/MG';
      3159803: Cidade := 'Santa Vitoria/MG';
      3159902: Cidade := 'Santo Antonio Do Amparo/MG';
      3160009: Cidade := 'Santo Antonio Do Aventureiro/MG';
      3160108: Cidade := 'Santo Antonio Do Grama/MG';
      3160207: Cidade := 'Santo Antonio Do Itambe/MG';
      3160306: Cidade := 'Santo Antonio Do Jacinto/MG';
      3160405: Cidade := 'Santo Antonio Do Monte/MG';
      3160454: Cidade := 'Santo Antonio Do Retiro/MG';
      3160504: Cidade := 'Santo Antonio Do Rio Abaixo/MG';
      3160603: Cidade := 'Santo Hipolito/MG';
      3160702: Cidade := 'Santos Dumont/MG';
      3160801: Cidade := 'Sao Bento Abade/MG';
      3160900: Cidade := 'Sao Bras Do Suacui/MG';
      3160959: Cidade := 'Sao Domingos Das Dores/MG';
      3161007: Cidade := 'Sao Domingos Do Prata/MG';
      3161056: Cidade := 'Sao Felix De Minas/MG';
      3161106: Cidade := 'Sao Francisco/MG';
      3161205: Cidade := 'Sao Francisco De Paula/MG';
      3161304: Cidade := 'Sao Francisco De Sales/MG';
      3161403: Cidade := 'Sao Francisco Do Gloria/MG';
      3161502: Cidade := 'Sao Geraldo/MG';
      3161601: Cidade := 'Sao Geraldo Da Piedade/MG';
      3161650: Cidade := 'Sao Geraldo Do Baixio/MG';
      3161700: Cidade := 'Sao Goncalo Do Abaete/MG';
      3161809: Cidade := 'Sao Goncalo Do Para/MG';
      3161908: Cidade := 'Sao Goncalo Do Rio Abaixo/MG';
      3162005: Cidade := 'Sao Goncalo Do Sapucai/MG';
      3162104: Cidade := 'Sao Gotardo/MG';
      3162203: Cidade := 'Sao Joao Batista Do Gloria/MG';
      3162252: Cidade := 'Sao Joao Da Lagoa/MG';
      3162302: Cidade := 'Sao Joao Da Mata/MG';
      3162401: Cidade := 'Sao Joao Da Ponte/MG';
      3162450: Cidade := 'Sao Joao Das Missoes/MG';
      3162500: Cidade := 'Sao Joao Del Rei/MG';
      3162559: Cidade := 'Sao Joao Do Manhuacu/MG';
      3162575: Cidade := 'Sao Joao Do Manteninha/MG';
      3162609: Cidade := 'Sao Joao Do Oriente/MG';
      3162658: Cidade := 'Sao Joao Do Pacui/MG';
      3162708: Cidade := 'Sao Joao Do Paraiso/MG';
      3162807: Cidade := 'Sao Joao Evangelista/MG';
      3162906: Cidade := 'Sao Joao Nepomuceno/MG';
      3162922: Cidade := 'Sao Joaquim De Bicas/MG';
      3162948: Cidade := 'Sao Jose Da Barra/MG';
      3162955: Cidade := 'Sao Jose Da Lapa/MG';
      3163003: Cidade := 'Sao Jose Da Safira/MG';
      3163102: Cidade := 'Sao Jose Da Varginha/MG';
      3163201: Cidade := 'Sao Jose Do Alegre/MG';
      3163300: Cidade := 'Sao Jose Do Divino/MG';
      3163409: Cidade := 'Sao Jose Do Goiabal/MG';
      3163508: Cidade := 'Sao Jose Do Jacuri/MG';
      3163607: Cidade := 'Sao Jose Do Mantimento/MG';
      3163706: Cidade := 'Sao Lourenco/MG';
      3163805: Cidade := 'Sao Miguel Do Anta/MG';
      3163904: Cidade := 'Sao Pedro Da Uniao/MG';
      3164001: Cidade := 'Sao Pedro Dos Ferros/MG';
      3164100: Cidade := 'Sao Pedro Do Suacui/MG';
      3164209: Cidade := 'Sao Romao/MG';
      3164308: Cidade := 'Sao Roque De Minas/MG';
      3164407: Cidade := 'Sao Sebastiao Da Bela Vista/MG';
      3164431: Cidade := 'Sao Sebastiao Da Vargem Alegre/MG';
      3164472: Cidade := 'Sao Sebastiao Do Anta/MG';
      3164506: Cidade := 'Sao Sebastiao Do Maranhao/MG';
      3164605: Cidade := 'Sao Sebastiao Do Oeste/MG';
      3164704: Cidade := 'Sao Sebastiao Do Paraiso/MG';
      3164803: Cidade := 'Sao Sebastiao Do Rio Preto/MG';
      3164902: Cidade := 'Sao Sebastiao Do Rio Verde/MG';
      3165008: Cidade := 'Sao Tiago/MG';
      3165107: Cidade := 'Sao Tomas De Aquino/MG';
      3165206: Cidade := 'Sao Thome Das Letras/MG';
      3165305: Cidade := 'Sao Vicente De Minas/MG';
      3165404: Cidade := 'Sapucai-Mirim/MG';
      3165503: Cidade := 'Sardoa/MG';
      3165537: Cidade := 'Sarzedo/MG';
      3165552: Cidade := 'Setubinha/MG';
      3165560: Cidade := 'Sem-Peixe/MG';
      3165578: Cidade := 'Senador Amaral/MG';
      3165602: Cidade := 'Senador Cortes/MG';
      3165701: Cidade := 'Senador Firmino/MG';
      3165800: Cidade := 'Senador Jose Bento/MG';
      3165909: Cidade := 'Senador Modestino Goncalves/MG';
      3166006: Cidade := 'Senhora De Oliveira/MG';
      3166105: Cidade := 'Senhora Do Porto/MG';
      3166204: Cidade := 'Senhora Dos Remedios/MG';
      3166303: Cidade := 'Sericita/MG';
      3166402: Cidade := 'Seritinga/MG';
      3166501: Cidade := 'Serra Azul De Minas/MG';
      3166600: Cidade := 'Serra Da Saudade/MG';
      3166709: Cidade := 'Serra Dos Aimores/MG';
      3166808: Cidade := 'Serra Do Salitre/MG';
      3166907: Cidade := 'Serrania/MG';
      3166956: Cidade := 'Serranopolis De Minas/MG';
      3167004: Cidade := 'Serranos/MG';
      3167103: Cidade := 'Serro/MG';
      3167202: Cidade := 'Sete Lagoas/MG';
      3167301: Cidade := 'Silveirania/MG';
      3167400: Cidade := 'Silvianopolis/MG';
      3167509: Cidade := 'Simao Pereira/MG';
      3167608: Cidade := 'Simonesia/MG';
      3167707: Cidade := 'Sobralia/MG';
      3167806: Cidade := 'Soledade De Minas/MG';
      3167905: Cidade := 'Tabuleiro/MG';
      3168002: Cidade := 'Taiobeiras/MG';
      3168051: Cidade := 'Taparuba/MG';
      3168101: Cidade := 'Tapira/MG';
      3168200: Cidade := 'Tapirai/MG';
      3168309: Cidade := 'Taquaracu De Minas/MG';
      3168408: Cidade := 'Tarumirim/MG';
      3168507: Cidade := 'Teixeiras/MG';
      3168606: Cidade := 'Teofilo Otoni/MG';
      3168705: Cidade := 'Timoteo/MG';
      3168804: Cidade := 'Tiradentes/MG';
      3168903: Cidade := 'Tiros/MG';
      3169000: Cidade := 'Tocantins/MG';
      3169059: Cidade := 'Tocos Do Moji/MG';
      3169109: Cidade := 'Toledo/MG';
      3169208: Cidade := 'Tombos/MG';
      3169307: Cidade := 'Tres Coracoes/MG';
      3169356: Cidade := 'Tres Marias/MG';
      3169406: Cidade := 'Tres Pontas/MG';
      3169505: Cidade := 'Tumiritinga/MG';
      3169604: Cidade := 'Tupaciguara/MG';
      3169703: Cidade := 'Turmalina/MG';
      3169802: Cidade := 'Turvolandia/MG';
      3169901: Cidade := 'Uba/MG';
      3170008: Cidade := 'Ubai/MG';
      3170057: Cidade := 'Ubaporanga/MG';
      3170107: Cidade := 'Uberaba/MG';
      3170206: Cidade := 'Uberlandia/MG';
      3170305: Cidade := 'Umburatiba/MG';
      3170404: Cidade := 'Unai/MG';
      3170438: Cidade := 'Uniao De Minas/MG';
      3170479: Cidade := 'Uruana De Minas/MG';
      3170503: Cidade := 'Urucania/MG';
      3170529: Cidade := 'Urucuia/MG';
      3170578: Cidade := 'Vargem Alegre/MG';
      3170602: Cidade := 'Vargem Bonita/MG';
      3170651: Cidade := 'Vargem Grande Do Rio Pardo/MG';
      3170701: Cidade := 'Varginha/MG';
      3170750: Cidade := 'Varjao De Minas/MG';
      3170800: Cidade := 'Varzea Da Palma/MG';
      3170909: Cidade := 'Varzelandia/MG';
      3171006: Cidade := 'Vazante/MG';
      3171030: Cidade := 'Verdelandia/MG';
      3171071: Cidade := 'Veredinha/MG';
      3171105: Cidade := 'Verissimo/MG';
      3171154: Cidade := 'Vermelho Novo/MG';
      3171204: Cidade := 'Vespasiano/MG';
      3171303: Cidade := 'Vicosa/MG';
      3171402: Cidade := 'Vieiras/MG';
      3171501: Cidade := 'Mathias Lobato/MG';
      3171600: Cidade := 'Virgem Da Lapa/MG';
      3171709: Cidade := 'Virginia/MG';
      3171808: Cidade := 'Virginopolis/MG';
      3171907: Cidade := 'Virgolandia/MG';
      3172004: Cidade := 'Visconde Do Rio Branco/MG';
      3172103: Cidade := 'Volta Grande/MG';
      3172202: Cidade := 'Wenceslau Braz/MG';
   end;
 end;

 procedure P32;
 begin
   case ACodigo of
      3200102: Cidade := 'Afonso Claudio/ES';
      3200136: Cidade := 'Aguia Branca/ES';
      3200169: Cidade := 'Agua Doce Do Norte/ES';
      3200201: Cidade := 'Alegre/ES';
      3200300: Cidade := 'Alfredo Chaves/ES';
      3200359: Cidade := 'Alto Rio Novo/ES';
      3200409: Cidade := 'Anchieta/ES';
      3200508: Cidade := 'Apiaca/ES';
      3200607: Cidade := 'Aracruz/ES';
      3200706: Cidade := 'Atilio Vivacqua/ES';
      3200805: Cidade := 'Baixo Guandu/ES';
      3200904: Cidade := 'Barra De Sao Francisco/ES';
      3201001: Cidade := 'Boa Esperanca/ES';
      3201100: Cidade := 'Bom Jesus Do Norte/ES';
      3201159: Cidade := 'Brejetuba/ES';
      3201209: Cidade := 'Cachoeiro De Itapemirim/ES';
      3201308: Cidade := 'Cariacica/ES';
      3201407: Cidade := 'Castelo/ES';
      3201506: Cidade := 'Colatina/ES';
      3201605: Cidade := 'Conceicao Da Barra/ES';
      3201704: Cidade := 'Conceicao Do Castelo/ES';
      3201803: Cidade := 'Divino De Sao Lourenco/ES';
      3201902: Cidade := 'Domingos Martins/ES';
      3202009: Cidade := 'Dores Do Rio Preto/ES';
      3202108: Cidade := 'Ecoporanga/ES';
      3202207: Cidade := 'Fundao/ES';
      3202256: Cidade := 'Governador Lindenberg/ES';
      3202306: Cidade := 'Guacui/ES';
      3202405: Cidade := 'Guarapari/ES';
      3202454: Cidade := 'Ibatiba/ES';
      3202504: Cidade := 'Ibiracu/ES';
      3202553: Cidade := 'Ibitirama/ES';
      3202603: Cidade := 'Iconha/ES';
      3202652: Cidade := 'Irupi/ES';
      3202702: Cidade := 'Itaguacu/ES';
      3202801: Cidade := 'Itapemirim/ES';
      3202900: Cidade := 'Itarana/ES';
      3203007: Cidade := 'Iuna/ES';
      3203056: Cidade := 'Jaguare/ES';
      3203106: Cidade := 'Jeronimo Monteiro/ES';
      3203130: Cidade := 'Joao Neiva/ES';
      3203163: Cidade := 'Laranja Da Terra/ES';
      3203205: Cidade := 'Linhares/ES';
      3203304: Cidade := 'Mantenopolis/ES';
      3203320: Cidade := 'Marataizes/ES';
      3203346: Cidade := 'Marechal Floriano/ES';
      3203353: Cidade := 'Marilandia/ES';
      3203403: Cidade := 'Mimoso Do Sul/ES';
      3203502: Cidade := 'Montanha/ES';
      3203601: Cidade := 'Mucurici/ES';
      3203700: Cidade := 'Muniz Freire/ES';
      3203809: Cidade := 'Muqui/ES';
      3203908: Cidade := 'Nova Venecia/ES';
      3204005: Cidade := 'Pancas/ES';
      3204054: Cidade := 'Pedro Canario/ES';
      3204104: Cidade := 'Pinheiros/ES';
      3204203: Cidade := 'Piuma/ES';
      3204252: Cidade := 'Ponto Belo/ES';
      3204302: Cidade := 'Presidente Kennedy/ES';
      3204351: Cidade := 'Rio Bananal/ES';
      3204401: Cidade := 'Rio Novo Do Sul/ES';
      3204500: Cidade := 'Santa Leopoldina/ES';
      3204559: Cidade := 'Santa Maria De Jetiba/ES';
      3204609: Cidade := 'Santa Teresa/ES';
      3204658: Cidade := 'Sao Domingos Do Norte/ES';
      3204708: Cidade := 'Sao Gabriel Da Palha/ES';
      3204807: Cidade := 'Sao Jose Do Calcado/ES';
      3204906: Cidade := 'Sao Mateus/ES';
      3204955: Cidade := 'Sao Roque Do Canaa/ES';
      3205002: Cidade := 'Serra/ES';
      3205010: Cidade := 'Sooretama/ES';
      3205036: Cidade := 'Vargem Alta/ES';
      3205069: Cidade := 'Venda Nova Do Imigrante/ES';
      3205101: Cidade := 'Viana/ES';
      3205150: Cidade := 'Vila Pavao/ES';
      3205176: Cidade := 'Vila Valerio/ES';
      3205200: Cidade := 'Vila Velha/ES';
      3205309: Cidade := 'Vitoria/ES';
   end;
 end;

 procedure P33;
 begin
   case ACodigo of
      3300100: Cidade := 'Angra Dos Reis/RJ';
      3300159: Cidade := 'Aperibe/RJ';
      3300209: Cidade := 'Araruama/RJ';
      3300225: Cidade := 'Areal/RJ';
      3300233: Cidade := 'Armacao Dos Buzios/RJ';
      3300258: Cidade := 'Arraial Do Cabo/RJ';
      3300308: Cidade := 'Barra Do Pirai/RJ';
      3300407: Cidade := 'Barra Mansa/RJ';
      3300456: Cidade := 'Belford Roxo/RJ';
      3300506: Cidade := 'Bom Jardim/RJ';
      3300605: Cidade := 'Bom Jesus Do Itabapoana/RJ';
      3300704: Cidade := 'Cabo Frio/RJ';
      3300803: Cidade := 'Cachoeiras De Macacu/RJ';
      3300902: Cidade := 'Cambuci/RJ';
      3300936: Cidade := 'Carapebus/RJ';
      3300951: Cidade := 'Comendador Levy Gasparian/RJ';
      3301009: Cidade := 'Campos Dos Goytacazes/RJ';
      3301108: Cidade := 'Cantagalo/RJ';
      3301157: Cidade := 'Cardoso Moreira/RJ';
      3301207: Cidade := 'Carmo/RJ';
      3301306: Cidade := 'Casimiro De Abreu/RJ';
      3301405: Cidade := 'Conceicao De Macabu/RJ';
      3301504: Cidade := 'Cordeiro/RJ';
      3301603: Cidade := 'Duas Barras/RJ';
      3301702: Cidade := 'Duque De Caxias/RJ';
      3301801: Cidade := 'Engenheiro Paulo De Frontin/RJ';
      3301850: Cidade := 'Guapimirim/RJ';
      3301876: Cidade := 'Iguaba Grande/RJ';
      3301900: Cidade := 'Itaborai/RJ';
      3302007: Cidade := 'Itaguai/RJ';
      3302056: Cidade := 'Italva/RJ';
      3302106: Cidade := 'Itaocara/RJ';
      3302205: Cidade := 'Itaperuna/RJ';
      3302254: Cidade := 'Itatiaia/RJ';
      3302270: Cidade := 'Japeri/RJ';
      3302304: Cidade := 'Laje Do Muriae/RJ';
      3302403: Cidade := 'Macae/RJ';
      3302452: Cidade := 'Macuco/RJ';
      3302502: Cidade := 'Mage/RJ';
      3302601: Cidade := 'Mangaratiba/RJ';
      3302700: Cidade := 'Marica/RJ';
      3302809: Cidade := 'Mendes/RJ';
      3302858: Cidade := 'Mesquita/RJ';
      3302908: Cidade := 'Miguel Pereira/RJ';
      3303005: Cidade := 'Miracema/RJ';
      3303104: Cidade := 'Natividade/RJ';
      3303203: Cidade := 'Nilopolis/RJ';
      3303302: Cidade := 'Niteroi/RJ';
      3303401: Cidade := 'Nova Friburgo/RJ';
      3303500: Cidade := 'Nova Iguacu/RJ';
      3303609: Cidade := 'Paracambi/RJ';
      3303708: Cidade := 'Paraiba Do Sul/RJ';
      3303807: Cidade := 'Parati/RJ';
      3303856: Cidade := 'Paty Do Alferes/RJ';
      3303906: Cidade := 'Petropolis/RJ';
      3303955: Cidade := 'Pinheiral/RJ';
      3304003: Cidade := 'Pirai/RJ';
      3304102: Cidade := 'Porciuncula/RJ';
      3304110: Cidade := 'Porto Real/RJ';
      3304128: Cidade := 'Quatis/RJ';
      3304144: Cidade := 'Queimados/RJ';
      3304151: Cidade := 'Quissama/RJ';
      3304201: Cidade := 'Resende/RJ';
      3304300: Cidade := 'Rio Bonito/RJ';
      3304409: Cidade := 'Rio Claro/RJ';
      3304508: Cidade := 'Rio Das Flores/RJ';
      3304524: Cidade := 'Rio Das Ostras/RJ';
      3304557: Cidade := 'Rio De Janeiro/RJ';
      3304607: Cidade := 'Santa Maria Madalena/RJ';
      3304706: Cidade := 'Santo Antonio De Padua/RJ';
      3304755: Cidade := 'Sao Francisco De Itabapoana/RJ';
      3304805: Cidade := 'Sao Fidelis/RJ';
      3304904: Cidade := 'Sao Goncalo/RJ';
      3305000: Cidade := 'Sao Joao Da Barra/RJ';
      3305109: Cidade := 'Sao Joao De Meriti/RJ';
      3305133: Cidade := 'Sao Jose De Uba/RJ';
      3305158: Cidade := 'Sao Jose Do Vale Do Rio Preto/RJ';
      3305208: Cidade := 'Sao Pedro Da Aldeia/RJ';
      3305307: Cidade := 'Sao Sebastiao Do Alto/RJ';
      3305406: Cidade := 'Sapucaia/RJ';
      3305505: Cidade := 'Saquarema/RJ';
      3305554: Cidade := 'Seropedica/RJ';
      3305604: Cidade := 'Silva Jardim/RJ';
      3305703: Cidade := 'Sumidouro/RJ';
      3305752: Cidade := 'Tangua/RJ';
      3305802: Cidade := 'Teresopolis/RJ';
      3305901: Cidade := 'Trajano De Morais/RJ';
      3306008: Cidade := 'Tres Rios/RJ';
      3306107: Cidade := 'Valenca/RJ';
      3306156: Cidade := 'Varre-Sai/RJ';
      3306206: Cidade := 'Vassouras/RJ';
      3306305: Cidade := 'Volta Redonda/RJ';
   end;
 end;

 procedure P35;
 begin
   case ACodigo of
      3500105: Cidade := 'Adamantina/SP';
      3500204: Cidade := 'Adolfo/SP';
      3500303: Cidade := 'Aguai/SP';
      3500402: Cidade := 'Aguas Da Prata/SP';
      3500501: Cidade := 'Aguas De Lindoia/SP';
      3500550: Cidade := 'Aguas De Santa Barbara/SP';
      3500600: Cidade := 'Aguas De Sao Pedro/SP';
      3500709: Cidade := 'Agudos/SP';
      3500758: Cidade := 'Alambari/SP';
      3500808: Cidade := 'Alfredo Marcondes/SP';
      3500907: Cidade := 'Altair/SP';
      3501004: Cidade := 'Altinopolis/SP';
      3501103: Cidade := 'Alto Alegre/SP';
      3501152: Cidade := 'Aluminio/SP';
      3501202: Cidade := 'Alvares Florence/SP';
      3501301: Cidade := 'Alvares Machado/SP';
      3501400: Cidade := 'Alvaro De Carvalho/SP';
      3501509: Cidade := 'Alvinlandia/SP';
      3501608: Cidade := 'Americana/SP';
      3501707: Cidade := 'Americo Brasiliense/SP';
      3501806: Cidade := 'Americo De Campos/SP';
      3501905: Cidade := 'Amparo/SP';
      3502002: Cidade := 'Analandia/SP';
      3502101: Cidade := 'Andradina/SP';
      3502200: Cidade := 'Angatuba/SP';
      3502309: Cidade := 'Anhembi/SP';
      3502408: Cidade := 'Anhumas/SP';
      3502507: Cidade := 'Aparecida/SP';
      3502606: Cidade := 'Aparecida D Oeste/SP';
      3502705: Cidade := 'Apiai/SP';
      3502754: Cidade := 'Aracariguama/SP';
      3502804: Cidade := 'Aracatuba/SP';
      3502903: Cidade := 'Aracoiaba Da Serra/SP';
      3503000: Cidade := 'Aramina/SP';
      3503109: Cidade := 'Arandu/SP';
      3503158: Cidade := 'Arapei/SP';
      3503208: Cidade := 'Araraquara/SP';
      3503307: Cidade := 'Araras/SP';
      3503356: Cidade := 'Arco-Iris/SP';
      3503406: Cidade := 'Arealva/SP';
      3503505: Cidade := 'Areias/SP';
      3503604: Cidade := 'Areiopolis/SP';
      3503703: Cidade := 'Ariranha/SP';
      3503802: Cidade := 'Artur Nogueira/SP';
      3503901: Cidade := 'Aruja/SP';
      3503950: Cidade := 'Aspasia/SP';
      3504008: Cidade := 'Assis/SP';
      3504107: Cidade := 'Atibaia/SP';
      3504206: Cidade := 'Auriflama/SP';
      3504305: Cidade := 'Avai/SP';
      3504404: Cidade := 'Avanhandava/SP';
      3504503: Cidade := 'Avare/SP';
      3504602: Cidade := 'Bady Bassitt/SP';
      3504701: Cidade := 'Balbinos/SP';
      3504800: Cidade := 'Balsamo/SP';
      3504909: Cidade := 'Bananal/SP';
      3505005: Cidade := 'Barao De Antonina/SP';
      3505104: Cidade := 'Barbosa/SP';
      3505203: Cidade := 'Bariri/SP';
      3505302: Cidade := 'Barra Bonita/SP';
      3505351: Cidade := 'Barra Do Chapeu/SP';
      3505401: Cidade := 'Barra Do Turvo/SP';
      3505500: Cidade := 'Barretos/SP';
      3505609: Cidade := 'Barrinha/SP';
      3505708: Cidade := 'Barueri/SP';
      3505807: Cidade := 'Bastos/SP';
      3505906: Cidade := 'Batatais/SP';
      3506003: Cidade := 'Bauru/SP';
      3506102: Cidade := 'Bebedouro/SP';
      3506201: Cidade := 'Bento De Abreu/SP';
      3506300: Cidade := 'Bernardino De Campos/SP';
      3506359: Cidade := 'Bertioga/SP';
      3506409: Cidade := 'Bilac/SP';
      3506508: Cidade := 'Birigui/SP';
      3506607: Cidade := 'Biritiba-Mirim/SP';
      3506706: Cidade := 'Boa Esperanca Do Sul/SP';
      3506805: Cidade := 'Bocaina/SP';
      3506904: Cidade := 'Bofete/SP';
      3507001: Cidade := 'Boituva/SP';
      3507100: Cidade := 'Bom Jesus Dos Perdoes/SP';
      3507159: Cidade := 'Bom Sucesso De Itarare/SP';
      3507209: Cidade := 'Bora/SP';
      3507308: Cidade := 'Boraceia/SP';
      3507407: Cidade := 'Borborema/SP';
      3507456: Cidade := 'Borebi/SP';
      3507506: Cidade := 'Botucatu/SP';
      3507605: Cidade := 'Braganca Paulista/SP';
      3507704: Cidade := 'Brauna/SP';
      3507753: Cidade := 'Brejo Alegre/SP';
      3507803: Cidade := 'Brodowski/SP';
      3507902: Cidade := 'Brotas/SP';
      3508009: Cidade := 'Buri/SP';
      3508108: Cidade := 'Buritama/SP';
      3508207: Cidade := 'Buritizal/SP';
      3508306: Cidade := 'Cabralia Paulista/SP';
      3508405: Cidade := 'Cabreuva/SP';
      3508504: Cidade := 'Cacapava/SP';
      3508603: Cidade := 'Cachoeira Paulista/SP';
      3508702: Cidade := 'Caconde/SP';
      3508801: Cidade := 'Cafelandia/SP';
      3508900: Cidade := 'Caiabu/SP';
      3509007: Cidade := 'Caieiras/SP';
      3509106: Cidade := 'Caiua/SP';
      3509205: Cidade := 'Cajamar/SP';
      3509254: Cidade := 'Cajati/SP';
      3509304: Cidade := 'Cajobi/SP';
      3509403: Cidade := 'Cajuru/SP';
      3509452: Cidade := 'Campina Do Monte Alegre/SP';
      3509502: Cidade := 'Campinas/SP';
      3509601: Cidade := 'Campo Limpo Paulista/SP';
      3509700: Cidade := 'Campos Do Jordao/SP';
      3509809: Cidade := 'Campos Novos Paulista/SP';
      3509908: Cidade := 'Cananeia/SP';
      3509957: Cidade := 'Canas/SP';
      3510005: Cidade := 'Candido Mota/SP';
      3510104: Cidade := 'Candido Rodrigues/SP';
      3510153: Cidade := 'Canitar/SP';
      3510203: Cidade := 'Capao Bonito/SP';
      3510302: Cidade := 'Capela Do Alto/SP';
      3510401: Cidade := 'Capivari/SP';
      3510500: Cidade := 'Caraguatatuba/SP';
      3510609: Cidade := 'Carapicuiba/SP';
      3510708: Cidade := 'Cardoso/SP';
      3510807: Cidade := 'Casa Branca/SP';
      3510906: Cidade := 'Cassia Dos Coqueiros/SP';
      3511003: Cidade := 'Castilho/SP';
      3511102: Cidade := 'Catanduva/SP';
      3511201: Cidade := 'Catigua/SP';
      3511300: Cidade := 'Cedral/SP';
      3511409: Cidade := 'Cerqueira Cesar/SP';
      3511508: Cidade := 'Cerquilho/SP';
      3511607: Cidade := 'Cesario Lange/SP';
      3511706: Cidade := 'Charqueada/SP';
      3511904: Cidade := 'Clementina/SP';
      3512001: Cidade := 'Colina/SP';
      3512100: Cidade := 'Colombia/SP';
      3512209: Cidade := 'Conchal/SP';
      3512308: Cidade := 'Conchas/SP';
      3512407: Cidade := 'Cordeiropolis/SP';
      3512506: Cidade := 'Coroados/SP';
      3512605: Cidade := 'Coronel Macedo/SP';
      3512704: Cidade := 'Corumbatai/SP';
      3512803: Cidade := 'Cosmopolis/SP';
      3512902: Cidade := 'Cosmorama/SP';
      3513009: Cidade := 'Cotia/SP';
      3513108: Cidade := 'Cravinhos/SP';
      3513207: Cidade := 'Cristais Paulista/SP';
      3513306: Cidade := 'Cruzalia/SP';
      3513405: Cidade := 'Cruzeiro/SP';
      3513504: Cidade := 'Cubatao/SP';
      3513603: Cidade := 'Cunha/SP';
      3513702: Cidade := 'Descalvado/SP';
      3513801: Cidade := 'Diadema/SP';
      3513850: Cidade := 'Dirce Reis/SP';
      3513900: Cidade := 'Divinolandia/SP';
      3514007: Cidade := 'Dobrada/SP';
      3514106: Cidade := 'Dois Corregos/SP';
      3514205: Cidade := 'Dolcinopolis/SP';
      3514304: Cidade := 'Dourado/SP';
      3514403: Cidade := 'Dracena/SP';
      3514502: Cidade := 'Duartina/SP';
      3514601: Cidade := 'Dumont/SP';
      3514700: Cidade := 'Echapora/SP';
      3514809: Cidade := 'Eldorado/SP';
      3514908: Cidade := 'Elias Fausto/SP';
      3514924: Cidade := 'Elisiario/SP';
      3514957: Cidade := 'Embauba/SP';
      3515004: Cidade := 'Embu/SP';
      3515103: Cidade := 'Embu-Guacu/SP';
      3515129: Cidade := 'Emilianopolis/SP';
      3515152: Cidade := 'Engenheiro Coelho/SP';
      3515186: Cidade := 'Espirito Santo Do Pinhal/SP';
      3515194: Cidade := 'Espirito Santo Do Turvo/SP';
      3515202: Cidade := 'Estrela D Oeste/SP';
      3515301: Cidade := 'Estrela Do Norte/SP';
      3515350: Cidade := 'Euclides Da Cunha Paulista/SP';
      3515400: Cidade := 'Fartura/SP';
      3515509: Cidade := 'Fernandopolis/SP';
      3515608: Cidade := 'Fernando Prestes/SP';
      3515657: Cidade := 'Fernao/SP';
      3515707: Cidade := 'Ferraz De Vasconcelos/SP';
      3515806: Cidade := 'Flora Rica/SP';
      3515905: Cidade := 'Floreal/SP';
      3516002: Cidade := 'Florida Paulista/SP';
      3516101: Cidade := 'Florinia/SP';
      3516200: Cidade := 'Franca/SP';
      3516309: Cidade := 'Francisco Morato/SP';
      3516408: Cidade := 'Franco Da Rocha/SP';
      3516507: Cidade := 'Gabriel Monteiro/SP';
      3516606: Cidade := 'Galia/SP';
      3516705: Cidade := 'Garca/SP';
      3516804: Cidade := 'Gastao Vidigal/SP';
      3516853: Cidade := 'Gaviao Peixoto/SP';
      3516903: Cidade := 'General Salgado/SP';
      3517000: Cidade := 'Getulina/SP';
      3517109: Cidade := 'Glicerio/SP';
      3517208: Cidade := 'Guaicara/SP';
      3517307: Cidade := 'Guaimbe/SP';
      3517406: Cidade := 'Guaira/SP';
      3517505: Cidade := 'Guapiacu/SP';
      3517604: Cidade := 'Guapiara/SP';
      3517703: Cidade := 'Guara/SP';
      3517802: Cidade := 'Guaracai/SP';
      3517901: Cidade := 'Guaraci/SP';
      3518008: Cidade := 'Guarani D Oeste/SP';
      3518107: Cidade := 'Guaranta/SP';
      3518206: Cidade := 'Guararapes/SP';
      3518305: Cidade := 'Guararema/SP';
      3518404: Cidade := 'Guaratingueta/SP';
      3518503: Cidade := 'Guarei/SP';
      3518602: Cidade := 'Guariba/SP';
      3518701: Cidade := 'Guaruja/SP';
      3518800: Cidade := 'Guarulhos/SP';
      3518859: Cidade := 'Guatapara/SP';
      3518909: Cidade := 'Guzolandia/SP';
      3519006: Cidade := 'Herculandia/SP';
      3519055: Cidade := 'Holambra/SP';
      3519071: Cidade := 'Hortolandia/SP';
      3519105: Cidade := 'Iacanga/SP';
      3519204: Cidade := 'Iacri/SP';
      3519253: Cidade := 'Iaras/SP';
      3519303: Cidade := 'Ibate/SP';
      3519402: Cidade := 'Ibira/SP';
      3519501: Cidade := 'Ibirarema/SP';
      3519600: Cidade := 'Ibitinga/SP';
      3519709: Cidade := 'Ibiuna/SP';
      3519808: Cidade := 'Icem/SP';
      3519907: Cidade := 'Iepe/SP';
      3520004: Cidade := 'Igaracu Do Tiete/SP';
      3520103: Cidade := 'Igarapava/SP';
      3520202: Cidade := 'Igarata/SP';
      3520301: Cidade := 'Iguape/SP';
      3520400: Cidade := 'Ilhabela/SP';
      3520426: Cidade := 'Ilha Comprida/SP';
      3520442: Cidade := 'Ilha Solteira/SP';
      3520509: Cidade := 'Indaiatuba/SP';
      3520608: Cidade := 'Indiana/SP';
      3520707: Cidade := 'Indiapora/SP';
      3520806: Cidade := 'Inubia Paulista/SP';
      3520905: Cidade := 'Ipaussu/SP';
      3521002: Cidade := 'Ipero/SP';
      3521101: Cidade := 'Ipeuna/SP';
      3521150: Cidade := 'Ipigua/SP';
      3521200: Cidade := 'Iporanga/SP';
      3521309: Cidade := 'Ipua/SP';
      3521408: Cidade := 'Iracemapolis/SP';
      3521507: Cidade := 'Irapua/SP';
      3521606: Cidade := 'Irapuru/SP';
      3521705: Cidade := 'Itabera/SP';
      3521804: Cidade := 'Itai/SP';
      3521903: Cidade := 'Itajobi/SP';
      3522000: Cidade := 'Itaju/SP';
      3522109: Cidade := 'Itanhaem/SP';
      3522158: Cidade := 'Itaoca/SP';
      3522208: Cidade := 'Itapecerica Da Serra/SP';
      3522307: Cidade := 'Itapetininga/SP';
      3522406: Cidade := 'Itapeva/SP';
      3522505: Cidade := 'Itapevi/SP';
      3522604: Cidade := 'Itapira/SP';
      3522653: Cidade := 'Itapirapua Paulista/SP';
      3522703: Cidade := 'Itapolis/SP';
      3522802: Cidade := 'Itaporanga/SP';
      3522901: Cidade := 'Itapui/SP';
      3523008: Cidade := 'Itapura/SP';
      3523107: Cidade := 'Itaquaquecetuba/SP';
      3523206: Cidade := 'Itarare/SP';
      3523305: Cidade := 'Itariri/SP';
      3523404: Cidade := 'Itatiba/SP';
      3523503: Cidade := 'Itatinga/SP';
      3523602: Cidade := 'Itirapina/SP';
      3523701: Cidade := 'Itirapua/SP';
      3523800: Cidade := 'Itobi/SP';
      3523909: Cidade := 'Itu/SP';
      3524006: Cidade := 'Itupeva/SP';
      3524105: Cidade := 'Ituverava/SP';
      3524204: Cidade := 'Jaborandi/SP';
      3524303: Cidade := 'Jaboticabal/SP';
      3524402: Cidade := 'Jacarei/SP';
      3524501: Cidade := 'Jaci/SP';
      3524600: Cidade := 'Jacupiranga/SP';
      3524709: Cidade := 'Jaguariuna/SP';
      3524808: Cidade := 'Jales/SP';
      3524907: Cidade := 'Jambeiro/SP';
      3525003: Cidade := 'Jandira/SP';
      3525102: Cidade := 'Jardinopolis/SP';
      3525201: Cidade := 'Jarinu/SP';
      3525300: Cidade := 'Jau/SP';
      3525409: Cidade := 'Jeriquara/SP';
      3525508: Cidade := 'Joanopolis/SP';
      3525607: Cidade := 'Joao Ramalho/SP';
      3525706: Cidade := 'Jose Bonifacio/SP';
      3525805: Cidade := 'Julio Mesquita/SP';
      3525854: Cidade := 'Jumirim/SP';
      3525904: Cidade := 'Jundiai/SP';
      3526001: Cidade := 'Junqueiropolis/SP';
      3526100: Cidade := 'Juquia/SP';
      3526209: Cidade := 'Juquitiba/SP';
      3526308: Cidade := 'Lagoinha/SP';
      3526407: Cidade := 'Laranjal Paulista/SP';
      3526506: Cidade := 'Lavinia/SP';
      3526605: Cidade := 'Lavrinhas/SP';
      3526704: Cidade := 'Leme/SP';
      3526803: Cidade := 'Lencois Paulista/SP';
      3526902: Cidade := 'Limeira/SP';
      3527009: Cidade := 'Lindoia/SP';
      3527108: Cidade := 'Lins/SP';
      3527207: Cidade := 'Lorena/SP';
      3527256: Cidade := 'Lourdes/SP';
      3527306: Cidade := 'Louveira/SP';
      3527405: Cidade := 'Lucelia/SP';
      3527504: Cidade := 'Lucianopolis/SP';
      3527603: Cidade := 'Luis Antonio/SP';
      3527702: Cidade := 'Luiziania/SP';
      3527801: Cidade := 'Lupercio/SP';
      3527900: Cidade := 'Lutecia/SP';
      3528007: Cidade := 'Macatuba/SP';
      3528106: Cidade := 'Macaubal/SP';
      3528205: Cidade := 'Macedonia/SP';
      3528304: Cidade := 'Magda/SP';
      3528403: Cidade := 'Mairinque/SP';
      3528502: Cidade := 'Mairipora/SP';
      3528601: Cidade := 'Manduri/SP';
      3528700: Cidade := 'Maraba Paulista/SP';
      3528809: Cidade := 'Maracai/SP';
      3528858: Cidade := 'Marapoama/SP';
      3528908: Cidade := 'Mariapolis/SP';
      3529005: Cidade := 'Marilia/SP';
      3529104: Cidade := 'Marinopolis/SP';
      3529203: Cidade := 'Martinopolis/SP';
      3529302: Cidade := 'Matao/SP';
      3529401: Cidade := 'Maua/SP';
      3529500: Cidade := 'Mendonca/SP';
      3529609: Cidade := 'Meridiano/SP';
      3529658: Cidade := 'Mesopolis/SP';
      3529708: Cidade := 'Miguelopolis/SP';
      3529807: Cidade := 'Mineiros Do Tiete/SP';
      3529906: Cidade := 'Miracatu/SP';
      3530003: Cidade := 'Mira Estrela/SP';
      3530102: Cidade := 'Mirandopolis/SP';
      3530201: Cidade := 'Mirante Do Paranapanema/SP';
      3530300: Cidade := 'Mirassol/SP';
      3530409: Cidade := 'Mirassolandia/SP';
      3530508: Cidade := 'Mococa/SP';
      3530607: Cidade := 'Mogi Das Cruzes/SP';
      3530706: Cidade := 'Mogi Guacu/SP';
      3530805: Cidade := 'Mogi Mirim/SP';
      3530904: Cidade := 'Mombuca/SP';
      3531001: Cidade := 'Moncoes/SP';
      3531100: Cidade := 'Mongagua/SP';
      3531209: Cidade := 'Monte Alegre Do Sul/SP';
      3531308: Cidade := 'Monte Alto/SP';
      3531407: Cidade := 'Monte Aprazivel/SP';
      3531506: Cidade := 'Monte Azul Paulista/SP';
      3531605: Cidade := 'Monte Castelo/SP';
      3531704: Cidade := 'Monteiro Lobato/SP';
      3531803: Cidade := 'Monte Mor/SP';
      3531902: Cidade := 'Morro Agudo/SP';
      3532009: Cidade := 'Morungaba/SP';
      3532058: Cidade := 'Motuca/SP';
      3532108: Cidade := 'Murutinga Do Sul/SP';
      3532157: Cidade := 'Nantes/SP';
      3532207: Cidade := 'Narandiba/SP';
      3532306: Cidade := 'Natividade Da Serra/SP';
      3532405: Cidade := 'Nazare Paulista/SP';
      3532504: Cidade := 'Neves Paulista/SP';
      3532603: Cidade := 'Nhandeara/SP';
      3532702: Cidade := 'Nipoa/SP';
      3532801: Cidade := 'Nova Alianca/SP';
      3532827: Cidade := 'Nova Campina/SP';
      3532843: Cidade := 'Nova Canaa Paulista/SP';
      3532868: Cidade := 'Nova Castilho/SP';
      3532900: Cidade := 'Nova Europa/SP';
      3533007: Cidade := 'Nova Granada/SP';
      3533106: Cidade := 'Nova Guataporanga/SP';
      3533205: Cidade := 'Nova Independencia/SP';
      3533254: Cidade := 'Novais/SP';
      3533304: Cidade := 'Nova Luzitania/SP';
      3533403: Cidade := 'Nova Odessa/SP';
      3533502: Cidade := 'Novo Horizonte/SP';
      3533601: Cidade := 'Nuporanga/SP';
      3533700: Cidade := 'Ocaucu/SP';
      3533809: Cidade := 'Oleo/SP';
      3533908: Cidade := 'Olimpia/SP';
      3534005: Cidade := 'Onda Verde/SP';
      3534104: Cidade := 'Oriente/SP';
      3534203: Cidade := 'Orindiuva/SP';
      3534302: Cidade := 'Orlandia/SP';
      3534401: Cidade := 'Osasco/SP';
      3534500: Cidade := 'Oscar Bressane/SP';
      3534609: Cidade := 'Osvaldo Cruz/SP';
      3534708: Cidade := 'Ourinhos/SP';
      3534757: Cidade := 'Ouroeste/SP';
      3534807: Cidade := 'Ouro Verde/SP';
      3534906: Cidade := 'Pacaembu/SP';
      3535002: Cidade := 'Palestina/SP';
      3535101: Cidade := 'Palmares Paulista/SP';
      3535200: Cidade := 'Palmeira D Oeste/SP';
      3535309: Cidade := 'Palmital/SP';
      3535408: Cidade := 'Panorama/SP';
      3535507: Cidade := 'Paraguacu Paulista/SP';
      3535606: Cidade := 'Paraibuna/SP';
      3535705: Cidade := 'Paraiso/SP';
      3535804: Cidade := 'Paranapanema/SP';
      3535903: Cidade := 'Paranapua/SP';
      3536000: Cidade := 'Parapua/SP';
      3536109: Cidade := 'Pardinho/SP';
      3536208: Cidade := 'Pariquera-Acu/SP';
      3536257: Cidade := 'Parisi/SP';
      3536307: Cidade := 'Patrocinio Paulista/SP';
      3536406: Cidade := 'Pauliceia/SP';
      3536505: Cidade := 'Paulinia/SP';
      3536570: Cidade := 'Paulistania/SP';
      3536604: Cidade := 'Paulo De Faria/SP';
      3536703: Cidade := 'Pederneiras/SP';
      3536802: Cidade := 'Pedra Bela/SP';
      3536901: Cidade := 'Pedranopolis/SP';
      3537008: Cidade := 'Pedregulho/SP';
      3537107: Cidade := 'Pedreira/SP';
      3537156: Cidade := 'Pedrinhas Paulista/SP';
      3537206: Cidade := 'Pedro De Toledo/SP';
      3537305: Cidade := 'Penapolis/SP';
      3537404: Cidade := 'Pereira Barreto/SP';
      3537503: Cidade := 'Pereiras/SP';
      3537602: Cidade := 'Peruibe/SP';
      3537701: Cidade := 'Piacatu/SP';
      3537800: Cidade := 'Piedade/SP';
      3537909: Cidade := 'Pilar Do Sul/SP';
      3538006: Cidade := 'Pindamonhangaba/SP';
      3538105: Cidade := 'Pindorama/SP';
      3538204: Cidade := 'Pinhalzinho/SP';
      3538303: Cidade := 'Piquerobi/SP';
      3538501: Cidade := 'Piquete/SP';
      3538600: Cidade := 'Piracaia/SP';
      3538709: Cidade := 'Piracicaba/SP';
      3538808: Cidade := 'Piraju/SP';
      3538907: Cidade := 'Pirajui/SP';
      3539004: Cidade := 'Pirangi/SP';
      3539103: Cidade := 'Pirapora Do Bom Jesus/SP';
      3539202: Cidade := 'Pirapozinho/SP';
      3539301: Cidade := 'Pirassununga/SP';
      3539400: Cidade := 'Piratininga/SP';
      3539509: Cidade := 'Pitangueiras/SP';
      3539608: Cidade := 'Planalto/SP';
      3539707: Cidade := 'Platina/SP';
      3539806: Cidade := 'Poa/SP';
      3539905: Cidade := 'Poloni/SP';
      3540002: Cidade := 'Pompeia/SP';
      3540101: Cidade := 'Pongai/SP';
      3540200: Cidade := 'Pontal/SP';
      3540259: Cidade := 'Pontalinda/SP';
      3540309: Cidade := 'Pontes Gestal/SP';
      3540408: Cidade := 'Populina/SP';
      3540507: Cidade := 'Porangaba/SP';
      3540606: Cidade := 'Porto Feliz/SP';
      3540705: Cidade := 'Porto Ferreira/SP';
      3540754: Cidade := 'Potim/SP';
      3540804: Cidade := 'Potirendaba/SP';
      3540853: Cidade := 'Pracinha/SP';
      3540903: Cidade := 'Pradopolis/SP';
      3541000: Cidade := 'Praia Grande/SP';
      3541059: Cidade := 'Pratania/SP';
      3541109: Cidade := 'Presidente Alves/SP';
      3541208: Cidade := 'Presidente Bernardes/SP';
      3541307: Cidade := 'Presidente Epitacio/SP';
      3541406: Cidade := 'Presidente Prudente/SP';
      3541505: Cidade := 'Presidente Venceslau/SP';
      3541604: Cidade := 'Promissao/SP';
      3541653: Cidade := 'Quadra/SP';
      3541703: Cidade := 'Quata/SP';
      3541802: Cidade := 'Queiroz/SP';
      3541901: Cidade := 'Queluz/SP';
      3542008: Cidade := 'Quintana/SP';
      3542107: Cidade := 'Rafard/SP';
      3542206: Cidade := 'Rancharia/SP';
      3542305: Cidade := 'Redencao Da Serra/SP';
      3542404: Cidade := 'Regente Feijo/SP';
      3542503: Cidade := 'Reginopolis/SP';
      3542602: Cidade := 'Registro/SP';
      3542701: Cidade := 'Restinga/SP';
      3542800: Cidade := 'Ribeira/SP';
      3542909: Cidade := 'Ribeirao Bonito/SP';
      3543006: Cidade := 'Ribeirao Branco/SP';
      3543105: Cidade := 'Ribeirao Corrente/SP';
      3543204: Cidade := 'Ribeirao Do Sul/SP';
      3543238: Cidade := 'Ribeirao Dos Indios/SP';
      3543253: Cidade := 'Ribeirao Grande/SP';
      3543303: Cidade := 'Ribeirao Pires/SP';
      3543402: Cidade := 'Ribeirao Preto/SP';
      3543501: Cidade := 'Riversul/SP';
      3543600: Cidade := 'Rifaina/SP';
      3543709: Cidade := 'Rincao/SP';
      3543808: Cidade := 'Rinopolis/SP';
      3543907: Cidade := 'Rio Claro/SP';
      3544004: Cidade := 'Rio Das Pedras/SP';
      3544103: Cidade := 'Rio Grande Da Serra/SP';
      3544202: Cidade := 'Riolandia/SP';
      3544251: Cidade := 'Rosana/SP';
      3544301: Cidade := 'Roseira/SP';
      3544400: Cidade := 'Rubiacea/SP';
      3544509: Cidade := 'Rubineia/SP';
      3544608: Cidade := 'Sabino/SP';
      3544707: Cidade := 'Sagres/SP';
      3544806: Cidade := 'Sales/SP';
      3544905: Cidade := 'Sales Oliveira/SP';
      3545001: Cidade := 'Salesopolis/SP';
      3545100: Cidade := 'Salmourao/SP';
      3545159: Cidade := 'Saltinho/SP';
      3545209: Cidade := 'Salto/SP';
      3545308: Cidade := 'Salto De Pirapora/SP';
      3545407: Cidade := 'Salto Grande/SP';
      3545506: Cidade := 'Sandovalina/SP';
      3545605: Cidade := 'Santa Adelia/SP';
      3545704: Cidade := 'Santa Albertina/SP';
      3545803: Cidade := 'Santa Barbara D Oeste/SP';
      3546009: Cidade := 'Santa Branca/SP';
      3546108: Cidade := 'Santa Clara D Oeste/SP';
      3546207: Cidade := 'Santa Cruz Da Conceicao/SP';
      3546256: Cidade := 'Santa Cruz Da Esperanca/SP';
      3546306: Cidade := 'Santa Cruz Das Palmeiras/SP';
      3546405: Cidade := 'Santa Cruz Do Rio Pardo/SP';
      3546504: Cidade := 'Santa Ernestina/SP';
      3546603: Cidade := 'Santa Fe Do Sul/SP';
      3546702: Cidade := 'Santa Gertrudes/SP';
      3546801: Cidade := 'Santa Isabel/SP';
      3546900: Cidade := 'Santa Lucia/SP';
      3547007: Cidade := 'Santa Maria Da Serra/SP';
      3547106: Cidade := 'Santa Mercedes/SP';
      3547205: Cidade := 'Santana Da Ponte Pensa/SP';
      3547304: Cidade := 'Santana De Parnaiba/SP';
      3547403: Cidade := 'Santa Rita D Oeste/SP';
      3547502: Cidade := 'Santa Rita Do Passa Quatro/SP';
      3547601: Cidade := 'Santa Rosa De Viterbo/SP';
      3547650: Cidade := 'Santa Salete/SP';
      3547700: Cidade := 'Santo Anastacio/SP';
      3547809: Cidade := 'Santo Andre/SP';
      3547908: Cidade := 'Santo Antonio Da Alegria/SP';
      3548005: Cidade := 'Santo Antonio De Posse/SP';
      3548054: Cidade := 'Santo Antonio Do Aracangua/SP';
      3548104: Cidade := 'Santo Antonio Do Jardim/SP';
      3548203: Cidade := 'Santo Antonio Do Pinhal/SP';
      3548302: Cidade := 'Santo Expedito/SP';
      3548401: Cidade := 'Santopolis Do Aguapei/SP';
      3548500: Cidade := 'Santos/SP';
      3548609: Cidade := 'Sao Bento Do Sapucai/SP';
      3548708: Cidade := 'Sao Bernardo Do Campo/SP';
      3548807: Cidade := 'Sao Caetano Do Sul/SP';
      3548906: Cidade := 'Sao Carlos/SP';
      3549003: Cidade := 'Sao Francisco/SP';
      3549102: Cidade := 'Sao Joao Da Boa Vista/SP';
      3549201: Cidade := 'Sao Joao Das Duas Pontes/SP';
      3549250: Cidade := 'Sao Joao De Iracema/SP';
      3549300: Cidade := 'Sao Joao Do Pau D Alho/SP';
      3549409: Cidade := 'Sao Joaquim Da Barra/SP';
      3549508: Cidade := 'Sao Jose Da Bela Vista/SP';
      3549607: Cidade := 'Sao Jose Do Barreiro/SP';
      3549706: Cidade := 'Sao Jose Do Rio Pardo/SP';
      3549805: Cidade := 'Sao Jose Do Rio Preto/SP';
      3549904: Cidade := 'Sao Jose Dos Campos/SP';
      3549953: Cidade := 'Sao Lourenco Da Serra/SP';
      3550001: Cidade := 'Sao Luis Do Paraitinga/SP';
      3550100: Cidade := 'Sao Manuel/SP';
      3550209: Cidade := 'Sao Miguel Arcanjo/SP';
      3550308: Cidade := 'Sao Paulo/SP';
      3550407: Cidade := 'Sao Pedro/SP';
      3550506: Cidade := 'Sao Pedro Do Turvo/SP';
      3550605: Cidade := 'Sao Roque/SP';
      3550704: Cidade := 'Sao Sebastiao/SP';
      3550803: Cidade := 'Sao Sebastiao Da Grama/SP';
      3550902: Cidade := 'Sao Simao/SP';
      3551009: Cidade := 'Sao Vicente/SP';
      3551108: Cidade := 'Sarapui/SP';
      3551207: Cidade := 'Sarutaia/SP';
      3551306: Cidade := 'Sebastianopolis Do Sul/SP';
      3551405: Cidade := 'Serra Azul/SP';
      3551504: Cidade := 'Serrana/SP';
      3551603: Cidade := 'Serra Negra/SP';
      3551702: Cidade := 'Sertaozinho/SP';
      3551801: Cidade := 'Sete Barras/SP';
      3551900: Cidade := 'Severinia/SP';
      3552007: Cidade := 'Silveiras/SP';
      3552106: Cidade := 'Socorro/SP';
      3552205: Cidade := 'Sorocaba/SP';
      3552304: Cidade := 'Sud Mennucci/SP';
      3552403: Cidade := 'Sumare/SP';
      3552502: Cidade := 'Suzano/SP';
      3552551: Cidade := 'Suzanapolis/SP';
      3552601: Cidade := 'Tabapua/SP';
      3552700: Cidade := 'Tabatinga/SP';
      3552809: Cidade := 'Taboao Da Serra/SP';
      3552908: Cidade := 'Taciba/SP';
      3553005: Cidade := 'Taguai/SP';
      3553104: Cidade := 'Taiacu/SP';
      3553203: Cidade := 'Taiuva/SP';
      3553302: Cidade := 'Tambau/SP';
      3553401: Cidade := 'Tanabi/SP';
      3553500: Cidade := 'Tapirai/SP';
      3553609: Cidade := 'Tapiratiba/SP';
      3553658: Cidade := 'Taquaral/SP';
      3553708: Cidade := 'Taquaritinga/SP';
      3553807: Cidade := 'Taquarituba/SP';
      3553856: Cidade := 'Taquarivai/SP';
      3553906: Cidade := 'Tarabai/SP';
      3553955: Cidade := 'Taruma/SP';
      3554003: Cidade := 'Tatui/SP';
      3554102: Cidade := 'Taubate/SP';
      3554201: Cidade := 'Tejupa/SP';
      3554300: Cidade := 'Teodoro Sampaio/SP';
      3554409: Cidade := 'Terra Roxa/SP';
      3554508: Cidade := 'Tiete/SP';
      3554607: Cidade := 'Timburi/SP';
      3554656: Cidade := 'Torre De Pedra/SP';
      3554706: Cidade := 'Torrinha/SP';
      3554755: Cidade := 'Trabiju/SP';
      3554805: Cidade := 'Tremembe/SP';
      3554904: Cidade := 'Tres Fronteiras/SP';
      3554953: Cidade := 'Tuiuti/SP';
      3555000: Cidade := 'Tupa/SP';
      3555109: Cidade := 'Tupi Paulista/SP';
      3555208: Cidade := 'Turiuba/SP';
      3555307: Cidade := 'Turmalina/SP';
      3555356: Cidade := 'Ubarana/SP';
      3555406: Cidade := 'Ubatuba/SP';
      3555505: Cidade := 'Ubirajara/SP';
      3555604: Cidade := 'Uchoa/SP';
      3555703: Cidade := 'Uniao Paulista/SP';
      3555802: Cidade := 'Urania/SP';
      3555901: Cidade := 'Uru/SP';
      3556008: Cidade := 'Urupes/SP';
      3556107: Cidade := 'Valentim Gentil/SP';
      3556206: Cidade := 'Valinhos/SP';
      3556305: Cidade := 'Valparaiso/SP';
      3556354: Cidade := 'Vargem/SP';
      3556404: Cidade := 'Vargem Grande Do Sul/SP';
      3556453: Cidade := 'Vargem Grande Paulista/SP';
      3556503: Cidade := 'Varzea Paulista/SP';
      3556602: Cidade := 'Vera Cruz/SP';
      3556701: Cidade := 'Vinhedo/SP';
      3556800: Cidade := 'Viradouro/SP';
      3556909: Cidade := 'Vista Alegre Do Alto/SP';
      3556958: Cidade := 'Vitoria Brasil/SP';
      3557006: Cidade := 'Votorantim/SP';
      3557105: Cidade := 'Votuporanga/SP';
      3557154: Cidade := 'Zacarias/SP';
      3557204: Cidade := 'Chavantes/SP';
      3557303: Cidade := 'Estiva Gerbi/SP';
   end;
 end;

 procedure P41;
 begin
   case ACodigo of
      4100103: Cidade := 'Abatia/PR';
      4100202: Cidade := 'Adrianopolis/PR';
      4100301: Cidade := 'Agudos Do Sul/PR';
      4100400: Cidade := 'Almirante Tamandare/PR';
      4100459: Cidade := 'Altamira Do Parana/PR';
      4100509: Cidade := 'Altonia/PR';
      4100608: Cidade := 'Alto Parana/PR';
      4100707: Cidade := 'Alto Piquiri/PR';
      4100806: Cidade := 'Alvorada Do Sul/PR';
      4100905: Cidade := 'Amapora/PR';
      4101002: Cidade := 'Ampere/PR';
      4101051: Cidade := 'Anahy/PR';
      4101101: Cidade := 'Andira/PR';
      4101150: Cidade := 'Angulo/PR';
      4101200: Cidade := 'Antonina/PR';
      4101309: Cidade := 'Antonio Olinto/PR';
      4101408: Cidade := 'Apucarana/PR';
      4101507: Cidade := 'Arapongas/PR';
      4101606: Cidade := 'Arapoti/PR';
      4101655: Cidade := 'Arapua/PR';
      4101705: Cidade := 'Araruna/PR';
      4101804: Cidade := 'Araucaria/PR';
      4101853: Cidade := 'Ariranha Do Ivai/PR';
      4101903: Cidade := 'Assai/PR';
      4102000: Cidade := 'Assis Chateaubriand/PR';
      4102109: Cidade := 'Astorga/PR';
      4102208: Cidade := 'Atalaia/PR';
      4102307: Cidade := 'Balsa Nova/PR';
      4102406: Cidade := 'Bandeirantes/PR';
      4102505: Cidade := 'Barbosa Ferraz/PR';
      4102604: Cidade := 'Barracao/PR';
      4102703: Cidade := 'Barra Do Jacare/PR';
      4102752: Cidade := 'Bela Vista Da Caroba/PR';
      4102802: Cidade := 'Bela Vista Do Paraiso/PR';
      4102901: Cidade := 'Bituruna/PR';
      4103008: Cidade := 'Boa Esperanca/PR';
      4103024: Cidade := 'Boa Esperanca Do Iguacu/PR';
      4103040: Cidade := 'Boa Ventura De Sao Roque/PR';
      4103057: Cidade := 'Boa Vista Da Aparecida/PR';
      4103107: Cidade := 'Bocaiuva Do Sul/PR';
      4103156: Cidade := 'Bom Jesus Do Sul/PR';
      4103206: Cidade := 'Bom Sucesso/PR';
      4103222: Cidade := 'Bom Sucesso Do Sul/PR';
      4103305: Cidade := 'Borrazopolis/PR';
      4103354: Cidade := 'Braganey/PR';
      4103370: Cidade := 'Brasilandia Do Sul/PR';
      4103404: Cidade := 'Cafeara/PR';
      4103453: Cidade := 'Cafelandia/PR';
      4103479: Cidade := 'Cafezal Do Sul/PR';
      4103503: Cidade := 'California/PR';
      4103602: Cidade := 'Cambara/PR';
      4103701: Cidade := 'Cambe/PR';
      4103800: Cidade := 'Cambira/PR';
      4103909: Cidade := 'Campina Da Lagoa/PR';
      4103958: Cidade := 'Campina Do Simao/PR';
      4104006: Cidade := 'Campina Grande Do Sul/PR';
      4104055: Cidade := 'Campo Bonito/PR';
      4104105: Cidade := 'Campo Do Tenente/PR';
      4104204: Cidade := 'Campo Largo/PR';
      4104253: Cidade := 'Campo Magro/PR';
      4104303: Cidade := 'Campo Mourao/PR';
      4104402: Cidade := 'Candido De Abreu/PR';
      4104428: Cidade := 'Candoi/PR';
      4104451: Cidade := 'Cantagalo/PR';
      4104501: Cidade := 'Capanema/PR';
      4104600: Cidade := 'Capitao Leonidas Marques/PR';
      4104659: Cidade := 'Carambei/PR';
      4104709: Cidade := 'Carlopolis/PR';
      4104808: Cidade := 'Cascavel/PR';
      4104907: Cidade := 'Castro/PR';
      4105003: Cidade := 'Catanduvas/PR';
      4105102: Cidade := 'Centenario Do Sul/PR';
      4105201: Cidade := 'Cerro Azul/PR';
      4105300: Cidade := 'Ceu Azul/PR';
      4105409: Cidade := 'Chopinzinho/PR';
      4105508: Cidade := 'Cianorte/PR';
      4105607: Cidade := 'Cidade Gaucha/PR';
      4105706: Cidade := 'Clevelandia/PR';
      4105805: Cidade := 'Colombo/PR';
      4105904: Cidade := 'Colorado/PR';
      4106001: Cidade := 'Congonhinhas/PR';
      4106100: Cidade := 'Conselheiro Mairinck/PR';
      4106209: Cidade := 'Contenda/PR';
      4106308: Cidade := 'Corbelia/PR';
      4106407: Cidade := 'Cornelio Procopio/PR';
      4106456: Cidade := 'Coronel Domingos Soares/PR';
      4106506: Cidade := 'Coronel Vivida/PR';
      4106555: Cidade := 'Corumbatai Do Sul/PR';
      4106571: Cidade := 'Cruzeiro Do Iguacu/PR';
      4106605: Cidade := 'Cruzeiro Do Oeste/PR';
      4106704: Cidade := 'Cruzeiro Do Sul/PR';
      4106803: Cidade := 'Cruz Machado/PR';
      4106852: Cidade := 'Cruzmaltina/PR';
      4106902: Cidade := 'Curitiba/PR';
      4107009: Cidade := 'Curiuva/PR';
      4107108: Cidade := 'Diamante Do Norte/PR';
      4107124: Cidade := 'Diamante Do Sul/PR';
      4107157: Cidade := 'Diamante D Oeste/PR';
      4107207: Cidade := 'Dois Vizinhos/PR';
      4107256: Cidade := 'Douradina/PR';
      4107306: Cidade := 'Doutor Camargo/PR';
      4107405: Cidade := 'Eneas Marques/PR';
      4107504: Cidade := 'Engenheiro Beltrao/PR';
      4107520: Cidade := 'Esperanca Nova/PR';
      4107538: Cidade := 'Entre Rios Do Oeste/PR';
      4107546: Cidade := 'Espigao Alto Do Iguacu/PR';
      4107553: Cidade := 'Farol/PR';
      4107603: Cidade := 'Faxinal/PR';
      4107652: Cidade := 'Fazenda Rio Grande/PR';
      4107702: Cidade := 'Fenix/PR';
      4107736: Cidade := 'Fernandes Pinheiro/PR';
      4107751: Cidade := 'Figueira/PR';
      4107801: Cidade := 'Florai/PR';
      4107850: Cidade := 'Flor Da Serra Do Sul/PR';
      4107900: Cidade := 'Floresta/PR';
      4108007: Cidade := 'Florestopolis/PR';
      4108106: Cidade := 'Florida/PR';
      4108205: Cidade := 'Formosa Do Oeste/PR';
      4108304: Cidade := 'Foz Do Iguacu/PR';
      4108320: Cidade := 'Francisco Alves/PR';
      4108403: Cidade := 'Francisco Beltrao/PR';
      4108452: Cidade := 'Foz Do Jordao/PR';
      4108502: Cidade := 'General Carneiro/PR';
      4108551: Cidade := 'Godoy Moreira/PR';
      4108601: Cidade := 'Goioere/PR';
      4108650: Cidade := 'Goioxim/PR';
      4108700: Cidade := 'Grandes Rios/PR';
      4108809: Cidade := 'Guaira/PR';
      4108908: Cidade := 'Guairaca/PR';
      4108957: Cidade := 'Guamiranga/PR';
      4109005: Cidade := 'Guapirama/PR';
      4109104: Cidade := 'Guaporema/PR';
      4109203: Cidade := 'Guaraci/PR';
      4109302: Cidade := 'Guaraniacu/PR';
      4109401: Cidade := 'Guarapuava/PR';
      4109500: Cidade := 'Guaraquecaba/PR';
      4109609: Cidade := 'Guaratuba/PR';
      4109658: Cidade := 'Honorio Serpa/PR';
      4109708: Cidade := 'Ibaiti/PR';
      4109757: Cidade := 'Ibema/PR';
      4109807: Cidade := 'Ibipora/PR';
      4109906: Cidade := 'Icaraima/PR';
      4110003: Cidade := 'Iguaracu/PR';
      4110052: Cidade := 'Iguatu/PR';
      4110078: Cidade := 'Imbau/PR';
      4110102: Cidade := 'Imbituva/PR';
      4110201: Cidade := 'Inacio Martins/PR';
      4110300: Cidade := 'Inaja/PR';
      4110409: Cidade := 'Indianopolis/PR';
      4110508: Cidade := 'Ipiranga/PR';
      4110607: Cidade := 'Ipora/PR';
      4110656: Cidade := 'Iracema Do Oeste/PR';
      4110706: Cidade := 'Irati/PR';
      4110805: Cidade := 'Iretama/PR';
      4110904: Cidade := 'Itaguaje/PR';
      4110953: Cidade := 'Itaipulandia/PR';
      4111001: Cidade := 'Itambaraca/PR';
      4111100: Cidade := 'Itambe/PR';
      4111209: Cidade := 'Itapejara D Oeste/PR';
      4111258: Cidade := 'Itaperucu/PR';
      4111308: Cidade := 'Itauna Do Sul/PR';
      4111407: Cidade := 'Ivai/PR';
      4111506: Cidade := 'Ivaipora/PR';
      4111555: Cidade := 'Ivate/PR';
      4111605: Cidade := 'Ivatuba/PR';
      4111704: Cidade := 'Jaboti/PR';
      4111803: Cidade := 'Jacarezinho/PR';
      4111902: Cidade := 'Jaguapita/PR';
      4112009: Cidade := 'Jaguariaiva/PR';
      4112108: Cidade := 'Jandaia Do Sul/PR';
      4112207: Cidade := 'Janiopolis/PR';
      4112306: Cidade := 'Japira/PR';
      4112405: Cidade := 'Japura/PR';
      4112504: Cidade := 'Jardim Alegre/PR';
      4112603: Cidade := 'Jardim Olinda/PR';
      4112702: Cidade := 'Jataizinho/PR';
      4112751: Cidade := 'Jesuitas/PR';
      4112801: Cidade := 'Joaquim Tavora/PR';
      4112900: Cidade := 'Jundiai Do Sul/PR';
      4112959: Cidade := 'Juranda/PR';
      4113007: Cidade := 'Jussara/PR';
      4113106: Cidade := 'Kalore/PR';
      4113205: Cidade := 'Lapa/PR';
      4113254: Cidade := 'Laranjal/PR';
      4113304: Cidade := 'Laranjeiras Do Sul/PR';
      4113403: Cidade := 'Leopolis/PR';
      4113429: Cidade := 'Lidianopolis/PR';
      4113452: Cidade := 'Lindoeste/PR';
      4113502: Cidade := 'Loanda/PR';
      4113601: Cidade := 'Lobato/PR';
      4113700: Cidade := 'Londrina/PR';
      4113734: Cidade := 'Luiziana/PR';
      4113759: Cidade := 'Lunardelli/PR';
      4113809: Cidade := 'Lupionopolis/PR';
      4113908: Cidade := 'Mallet/PR';
      4114005: Cidade := 'Mambore/PR';
      4114104: Cidade := 'Mandaguacu/PR';
      4114203: Cidade := 'Mandaguari/PR';
      4114302: Cidade := 'Mandirituba/PR';
      4114351: Cidade := 'Manfrinopolis/PR';
      4114401: Cidade := 'Mangueirinha/PR';
      4114500: Cidade := 'Manoel Ribas/PR';
      4114609: Cidade := 'Marechal Candido Rondon/PR';
      4114708: Cidade := 'Maria Helena/PR';
      4114807: Cidade := 'Marialva/PR';
      4114906: Cidade := 'Marilandia Do Sul/PR';
      4115002: Cidade := 'Marilena/PR';
      4115101: Cidade := 'Mariluz/PR';
      4115200: Cidade := 'Maringa/PR';
      4115309: Cidade := 'Mariopolis/PR';
      4115358: Cidade := 'Maripa/PR';
      4115408: Cidade := 'Marmeleiro/PR';
      4115457: Cidade := 'Marquinho/PR';
      4115507: Cidade := 'Marumbi/PR';
      4115606: Cidade := 'Matelandia/PR';
      4115705: Cidade := 'Matinhos/PR';
      4115739: Cidade := 'Mato Rico/PR';
      4115754: Cidade := 'Maua Da Serra/PR';
      4115804: Cidade := 'Medianeira/PR';
      4115853: Cidade := 'Mercedes/PR';
      4115903: Cidade := 'Mirador/PR';
      4116000: Cidade := 'Miraselva/PR';
      4116059: Cidade := 'Missal/PR';
      4116109: Cidade := 'Moreira Sales/PR';
      4116208: Cidade := 'Morretes/PR';
      4116307: Cidade := 'Munhoz De Melo/PR';
      4116406: Cidade := 'Nossa Senhora Das Gracas/PR';
      4116505: Cidade := 'Nova Alianca Do Ivai/PR';
      4116604: Cidade := 'Nova America Da Colina/PR';
      4116703: Cidade := 'Nova Aurora/PR';
      4116802: Cidade := 'Nova Cantu/PR';
      4116901: Cidade := 'Nova Esperanca/PR';
      4116950: Cidade := 'Nova Esperanca Do Sudoeste/PR';
      4117008: Cidade := 'Nova Fatima/PR';
      4117057: Cidade := 'Nova Laranjeiras/PR';
      4117107: Cidade := 'Nova Londrina/PR';
      4117206: Cidade := 'Nova Olimpia/PR';
      4117214: Cidade := 'Nova Santa Barbara/PR';
      4117222: Cidade := 'Nova Santa Rosa/PR';
      4117255: Cidade := 'Nova Prata Do Iguacu/PR';
      4117271: Cidade := 'Nova Tebas/PR';
      4117297: Cidade := 'Novo Itacolomi/PR';
      4117305: Cidade := 'Ortigueira/PR';
      4117404: Cidade := 'Ourizona/PR';
      4117453: Cidade := 'Ouro Verde Do Oeste/PR';
      4117503: Cidade := 'Paicandu/PR';
      4117602: Cidade := 'Palmas/PR';
      4117701: Cidade := 'Palmeira/PR';
      4117800: Cidade := 'Palmital/PR';
      4117909: Cidade := 'Palotina/PR';
      4118006: Cidade := 'Paraiso Do Norte/PR';
      4118105: Cidade := 'Paranacity/PR';
      4118204: Cidade := 'Paranagua/PR';
      4118303: Cidade := 'Paranapoema/PR';
      4118402: Cidade := 'Paranavai/PR';
      4118451: Cidade := 'Pato Bragado/PR';
      4118501: Cidade := 'Pato Branco/PR';
      4118600: Cidade := 'Paula Freitas/PR';
      4118709: Cidade := 'Paulo Frontin/PR';
      4118808: Cidade := 'Peabiru/PR';
      4118857: Cidade := 'Perobal/PR';
      4118907: Cidade := 'Perola/PR';
      4119004: Cidade := 'Perola D Oeste/PR';
      4119103: Cidade := 'Pien/PR';
      4119152: Cidade := 'Pinhais/PR';
      4119202: Cidade := 'Pinhalao/PR';
      4119251: Cidade := 'Pinhal De Sao Bento/PR';
      4119301: Cidade := 'Pinhao/PR';
      4119400: Cidade := 'Pirai Do Sul/PR';
      4119509: Cidade := 'Piraquara/PR';
      4119608: Cidade := 'Pitanga/PR';
      4119657: Cidade := 'Pitangueiras/PR';
      4119707: Cidade := 'Planaltina Do Parana/PR';
      4119806: Cidade := 'Planalto/PR';
      4119905: Cidade := 'Ponta Grossa/PR';
      4119954: Cidade := 'Pontal Do Parana/PR';
      4120002: Cidade := 'Porecatu/PR';
      4120101: Cidade := 'Porto Amazonas/PR';
      4120150: Cidade := 'Porto Barreiro/PR';
      4120200: Cidade := 'Porto Rico/PR';
      4120309: Cidade := 'Porto Vitoria/PR';
      4120333: Cidade := 'Prado Ferreira/PR';
      4120358: Cidade := 'Pranchita/PR';
      4120408: Cidade := 'Presidente Castelo Branco/PR';
      4120507: Cidade := 'Primeiro De Maio/PR';
      4120606: Cidade := 'Prudentopolis/PR';
      4120655: Cidade := 'Quarto Centenario/PR';
      4120705: Cidade := 'Quatigua/PR';
      4120804: Cidade := 'Quatro Barras/PR';
      4120853: Cidade := 'Quatro Pontes/PR';
      4120903: Cidade := 'Quedas Do Iguacu/PR';
      4121000: Cidade := 'Querencia Do Norte/PR';
      4121109: Cidade := 'Quinta Do Sol/PR';
      4121208: Cidade := 'Quitandinha/PR';
      4121257: Cidade := 'Ramilandia/PR';
      4121307: Cidade := 'Rancho Alegre/PR';
      4121356: Cidade := 'Rancho Alegre D Oeste/PR';
      4121406: Cidade := 'Realeza/PR';
      4121505: Cidade := 'Reboucas/PR';
      4121604: Cidade := 'Renascenca/PR';
      4121703: Cidade := 'Reserva/PR';
      4121752: Cidade := 'Reserva Do Iguacu/PR';
      4121802: Cidade := 'Ribeirao Claro/PR';
      4121901: Cidade := 'Ribeirao Do Pinhal/PR';
      4122008: Cidade := 'Rio Azul/PR';
      4122107: Cidade := 'Rio Bom/PR';
      4122156: Cidade := 'Rio Bonito Do Iguacu/PR';
      4122172: Cidade := 'Rio Branco Do Ivai/PR';
      4122206: Cidade := 'Rio Branco Do Sul/PR';
      4122305: Cidade := 'Rio Negro/PR';
      4122404: Cidade := 'Rolandia/PR';
      4122503: Cidade := 'Roncador/PR';
      4122602: Cidade := 'Rondon/PR';
      4122651: Cidade := 'Rosario Do Ivai/PR';
      4122701: Cidade := 'Sabaudia/PR';
      4122800: Cidade := 'Salgado Filho/PR';
      4122909: Cidade := 'Salto Do Itarare/PR';
      4123006: Cidade := 'Salto Do Lontra/PR';
      4123105: Cidade := 'Santa Amelia/PR';
      4123204: Cidade := 'Santa Cecilia Do Pavao/PR';
      4123303: Cidade := 'Santa Cruz De Monte Castelo/PR';
      4123402: Cidade := 'Santa Fe/PR';
      4123501: Cidade := 'Santa Helena/PR';
      4123600: Cidade := 'Santa Ines/PR';
      4123709: Cidade := 'Santa Isabel Do Ivai/PR';
      4123808: Cidade := 'Santa Izabel Do Oeste/PR';
      4123824: Cidade := 'Santa Lucia/PR';
      4123857: Cidade := 'Santa Maria Do Oeste/PR';
      4123907: Cidade := 'Santa Mariana/PR';
      4123956: Cidade := 'Santa Monica/PR';
      4124004: Cidade := 'Santana Do Itarare/PR';
      4124020: Cidade := 'Santa Tereza Do Oeste/PR';
      4124053: Cidade := 'Santa Terezinha De Itaipu/PR';
      4124103: Cidade := 'Santo Antonio Da Platina/PR';
      4124202: Cidade := 'Santo Antonio Do Caiua/PR';
      4124301: Cidade := 'Santo Antonio Do Paraiso/PR';
      4124400: Cidade := 'Santo Antonio Do Sudoeste/PR';
      4124509: Cidade := 'Santo Inacio/PR';
      4124608: Cidade := 'Sao Carlos Do Ivai/PR';
      4124707: Cidade := 'Sao Jeronimo Da Serra/PR';
      4124806: Cidade := 'Sao Joao/PR';
      4124905: Cidade := 'Sao Joao Do Caiua/PR';
      4125001: Cidade := 'Sao Joao Do Ivai/PR';
      4125100: Cidade := 'Sao Joao Do Triunfo/PR';
      4125209: Cidade := 'Sao Jorge D Oeste/PR';
      4125308: Cidade := 'Sao Jorge Do Ivai/PR';
      4125357: Cidade := 'Sao Jorge Do Patrocinio/PR';
      4125407: Cidade := 'Sao Jose Da Boa Vista/PR';
      4125456: Cidade := 'Sao Jose Das Palmeiras/PR';
      4125506: Cidade := 'Sao Jose Dos Pinhais/PR';
      4125555: Cidade := 'Sao Manoel Do Parana/PR';
      4125605: Cidade := 'Sao Mateus Do Sul/PR';
      4125704: Cidade := 'Sao Miguel Do Iguacu/PR';
      4125753: Cidade := 'Sao Pedro Do Iguacu/PR';
      4125803: Cidade := 'Sao Pedro Do Ivai/PR';
      4125902: Cidade := 'Sao Pedro Do Parana/PR';
      4126009: Cidade := 'Sao Sebastiao Da Amoreira/PR';
      4126108: Cidade := 'Sao Tome/PR';
      4126207: Cidade := 'Sapopema/PR';
      4126256: Cidade := 'Sarandi/PR';
      4126272: Cidade := 'Saudade Do Iguacu/PR';
      4126306: Cidade := 'Senges/PR';
      4126355: Cidade := 'Serranopolis Do Iguacu/PR';
      4126405: Cidade := 'Sertaneja/PR';
      4126504: Cidade := 'Sertanopolis/PR';
      4126603: Cidade := 'Siqueira Campos/PR';
      4126652: Cidade := 'Sulina/PR';
      4126678: Cidade := 'Tamarana/PR';
      4126702: Cidade := 'Tamboara/PR';
      4126801: Cidade := 'Tapejara/PR';
      4126900: Cidade := 'Tapira/PR';
      4127007: Cidade := 'Teixeira Soares/PR';
      4127106: Cidade := 'Telemaco Borba/PR';
      4127205: Cidade := 'Terra Boa/PR';
      4127304: Cidade := 'Terra Rica/PR';
      4127403: Cidade := 'Terra Roxa/PR';
      4127502: Cidade := 'Tibagi/PR';
      4127601: Cidade := 'Tijucas Do Sul/PR';
      4127700: Cidade := 'Toledo/PR';
      4127809: Cidade := 'Tomazina/PR';
      4127858: Cidade := 'Tres Barras Do Parana/PR';
      4127882: Cidade := 'Tunas Do Parana/PR';
      4127908: Cidade := 'Tuneiras Do Oeste/PR';
      4127957: Cidade := 'Tupassi/PR';
      4127965: Cidade := 'Turvo/PR';
      4128005: Cidade := 'Ubirata/PR';
      4128104: Cidade := 'Umuarama/PR';
      4128203: Cidade := 'Uniao Da Vitoria/PR';
      4128302: Cidade := 'Uniflor/PR';
      4128401: Cidade := 'Urai/PR';
      4128500: Cidade := 'Wenceslau Braz/PR';
      4128534: Cidade := 'Ventania/PR';
      4128559: Cidade := 'Vera Cruz Do Oeste/PR';
      4128609: Cidade := 'Vere/PR';
      4128625: Cidade := 'Alto Paraiso/PR';
      4128633: Cidade := 'Doutor Ulysses/PR';
      4128658: Cidade := 'Virmond/PR';
      4128708: Cidade := 'Vitorino/PR';
      4128807: Cidade := 'Xambre/PR';
   end;
 end;

 procedure P42;
 begin
   case ACodigo of
      4200051: Cidade := 'Abdon Batista/SC';
      4200101: Cidade := 'Abelardo Luz/SC';
      4200200: Cidade := 'Agrolandia/SC';
      4200309: Cidade := 'Agronomica/SC';
      4200408: Cidade := 'Agua Doce/SC';
      4200507: Cidade := 'Aguas De Chapeco/SC';
      4200556: Cidade := 'Aguas Frias/SC';
      4200606: Cidade := 'Aguas Mornas/SC';
      4200705: Cidade := 'Alfredo Wagner/SC';
      4200754: Cidade := 'Alto Bela Vista/SC';
      4200804: Cidade := 'Anchieta/SC';
      4200903: Cidade := 'Angelina/SC';
      4201000: Cidade := 'Anita Garibaldi/SC';
      4201109: Cidade := 'Anitapolis/SC';
      4201208: Cidade := 'Antonio Carlos/SC';
      4201257: Cidade := 'Apiuna/SC';
      4201273: Cidade := 'Arabuta/SC';
      4201307: Cidade := 'Araquari/SC';
      4201406: Cidade := 'Ararangua/SC';
      4201505: Cidade := 'Armazem/SC';
      4201604: Cidade := 'Arroio Trinta/SC';
      4201653: Cidade := 'Arvoredo/SC';
      4201703: Cidade := 'Ascurra/SC';
      4201802: Cidade := 'Atalanta/SC';
      4201901: Cidade := 'Aurora/SC';
      4201950: Cidade := 'Balneario Arroio Do Silva/SC';
      4202008: Cidade := 'Balneario Camboriu/SC';
      4202057: Cidade := 'Balneario Barra Do Sul/SC';
      4202073: Cidade := 'Balneario Gaivota/SC';
      4202081: Cidade := 'Bandeirante/SC';
      4202099: Cidade := 'Barra Bonita/SC';
      4202107: Cidade := 'Barra Velha/SC';
      4202131: Cidade := 'Bela Vista Do Toldo/SC';
      4202156: Cidade := 'Belmonte/SC';
      4202206: Cidade := 'Benedito Novo/SC';
      4202305: Cidade := 'Biguacu/SC';
      4202404: Cidade := 'Blumenau/SC';
      4202438: Cidade := 'Bocaina Do Sul/SC';
      4202453: Cidade := 'Bombinhas/SC';
      4202503: Cidade := 'Bom Jardim Da Serra/SC';
      4202537: Cidade := 'Bom Jesus/SC';
      4202578: Cidade := 'Bom Jesus Do Oeste/SC';
      4202602: Cidade := 'Bom Retiro/SC';
      4202701: Cidade := 'Botuvera/SC';
      4202800: Cidade := 'Braco Do Norte/SC';
      4202859: Cidade := 'Braco Do Trombudo/SC';
      4202875: Cidade := 'Brunopolis/SC';
      4202909: Cidade := 'Brusque/SC';
      4203006: Cidade := 'Cacador/SC';
      4203105: Cidade := 'Caibi/SC';
      4203154: Cidade := 'Calmon/SC';
      4203204: Cidade := 'Camboriu/SC';
      4203253: Cidade := 'Capao Alto/SC';
      4203303: Cidade := 'Campo Alegre/SC';
      4203402: Cidade := 'Campo Belo Do Sul/SC';
      4203501: Cidade := 'Campo Ere/SC';
      4203600: Cidade := 'Campos Novos/SC';
      4203709: Cidade := 'Canelinha/SC';
      4203808: Cidade := 'Canoinhas/SC';
      4203907: Cidade := 'Capinzal/SC';
      4203956: Cidade := 'Capivari De Baixo/SC';
      4204004: Cidade := 'Catanduvas/SC';
      4204103: Cidade := 'Caxambu Do Sul/SC';
      4204152: Cidade := 'Celso Ramos/SC';
      4204178: Cidade := 'Cerro Negro/SC';
      4204194: Cidade := 'Chapadao Do Lageado/SC';
      4204202: Cidade := 'Chapeco/SC';
      4204251: Cidade := 'Cocal Do Sul/SC';
      4204301: Cidade := 'Concordia/SC';
      4204350: Cidade := 'Cordilheira Alta/SC';
      4204400: Cidade := 'Coronel Freitas/SC';
      4204459: Cidade := 'Coronel Martins/SC';
      4204509: Cidade := 'Corupa/SC';
      4204558: Cidade := 'Correia Pinto/SC';
      4204608: Cidade := 'Criciuma/SC';
      4204707: Cidade := 'Cunha Pora/SC';
      4204756: Cidade := 'Cunhatai/SC';
      4204806: Cidade := 'Curitibanos/SC';
      4204905: Cidade := 'Descanso/SC';
      4205001: Cidade := 'Dionisio Cerqueira/SC';
      4205100: Cidade := 'Dona Emma/SC';
      4205159: Cidade := 'Doutor Pedrinho/SC';
      4205175: Cidade := 'Entre Rios/SC';
      4205191: Cidade := 'Ermo/SC';
      4205209: Cidade := 'Erval Velho/SC';
      4205308: Cidade := 'Faxinal Dos Guedes/SC';
      4205357: Cidade := 'Flor Do Sertao/SC';
      4205407: Cidade := 'Florianopolis/SC';
      4205431: Cidade := 'Formosa Do Sul/SC';
      4205456: Cidade := 'Forquilhinha/SC';
      4205506: Cidade := 'Fraiburgo/SC';
      4205555: Cidade := 'Frei Rogerio/SC';
      4205605: Cidade := 'Galvao/SC';
      4205704: Cidade := 'Garopaba/SC';
      4205803: Cidade := 'Garuva/SC';
      4205902: Cidade := 'Gaspar/SC';
      4206009: Cidade := 'Governador Celso Ramos/SC';
      4206108: Cidade := 'Grao Para/SC';
      4206207: Cidade := 'Gravatal/SC';
      4206306: Cidade := 'Guabiruba/SC';
      4206405: Cidade := 'Guaraciaba/SC';
      4206504: Cidade := 'Guaramirim/SC';
      4206603: Cidade := 'Guaruja Do Sul/SC';
      4206652: Cidade := 'Guatambu/SC';
      4206702: Cidade := 'Herval D Oeste/SC';
      4206751: Cidade := 'Ibiam/SC';
      4206801: Cidade := 'Ibicare/SC';
      4206900: Cidade := 'Ibirama/SC';
      4207007: Cidade := 'Icara/SC';
      4207106: Cidade := 'Ilhota/SC';
      4207205: Cidade := 'Imarui/SC';
      4207304: Cidade := 'Imbituba/SC';
      4207403: Cidade := 'Imbuia/SC';
      4207502: Cidade := 'Indaial/SC';
      4207577: Cidade := 'Iomere/SC';
      4207601: Cidade := 'Ipira/SC';
      4207650: Cidade := 'Ipora Do Oeste/SC';
      4207684: Cidade := 'Ipuacu/SC';
      4207700: Cidade := 'Ipumirim/SC';
      4207759: Cidade := 'Iraceminha/SC';
      4207809: Cidade := 'Irani/SC';
      4207858: Cidade := 'Irati/SC';
      4207908: Cidade := 'Irineopolis/SC';
      4208005: Cidade := 'Ita/SC';
      4208104: Cidade := 'Itaiopolis/SC';
      4208203: Cidade := 'Itajai/SC';
      4208302: Cidade := 'Itapema/SC';
      4208401: Cidade := 'Itapiranga/SC';
      4208450: Cidade := 'Itapoa/SC';
      4208500: Cidade := 'Ituporanga/SC';
      4208609: Cidade := 'Jabora/SC';
      4208708: Cidade := 'Jacinto Machado/SC';
      4208807: Cidade := 'Jaguaruna/SC';
      4208906: Cidade := 'Jaragua Do Sul/SC';
      4208955: Cidade := 'Jardinopolis/SC';
      4209003: Cidade := 'Joacaba/SC';
      4209102: Cidade := 'Joinville/SC';
      4209151: Cidade := 'Jose Boiteux/SC';
      4209177: Cidade := 'Jupia/SC';
      4209201: Cidade := 'Lacerdopolis/SC';
      4209300: Cidade := 'Lages/SC';
      4209409: Cidade := 'Laguna/SC';
      4209458: Cidade := 'Lajeado Grande/SC';
      4209508: Cidade := 'Laurentino/SC';
      4209607: Cidade := 'Lauro Muller/SC';
      4209706: Cidade := 'Lebon Regis/SC';
      4209805: Cidade := 'Leoberto Leal/SC';
      4209854: Cidade := 'Lindoia Do Sul/SC';
      4209904: Cidade := 'Lontras/SC';
      4210001: Cidade := 'Luiz Alves/SC';
      4210035: Cidade := 'Luzerna/SC';
      4210050: Cidade := 'Macieira/SC';
      4210100: Cidade := 'Mafra/SC';
      4210209: Cidade := 'Major Gercino/SC';
      4210308: Cidade := 'Major Vieira/SC';
      4210407: Cidade := 'Maracaja/SC';
      4210506: Cidade := 'Maravilha/SC';
      4210555: Cidade := 'Marema/SC';
      4210605: Cidade := 'Massaranduba/SC';
      4210704: Cidade := 'Matos Costa/SC';
      4210803: Cidade := 'Meleiro/SC';
      4210852: Cidade := 'Mirim Doce/SC';
      4210902: Cidade := 'Modelo/SC';
      4211009: Cidade := 'Mondai/SC';
      4211058: Cidade := 'Monte Carlo/SC';
      4211108: Cidade := 'Monte Castelo/SC';
      4211207: Cidade := 'Morro Da Fumaca/SC';
      4211256: Cidade := 'Morro Grande/SC';
      4211306: Cidade := 'Navegantes/SC';
      4211405: Cidade := 'Nova Erechim/SC';
      4211454: Cidade := 'Nova Itaberaba/SC';
      4211504: Cidade := 'Nova Trento/SC';
      4211603: Cidade := 'Nova Veneza/SC';
      4211652: Cidade := 'Novo Horizonte/SC';
      4211702: Cidade := 'Orleans/SC';
      4211751: Cidade := 'Otacilio Costa/SC';
      4211801: Cidade := 'Ouro/SC';
      4211850: Cidade := 'Ouro Verde/SC';
      4211876: Cidade := 'Paial/SC';
      4211892: Cidade := 'Painel/SC';
      4211900: Cidade := 'Palhoca/SC';
      4212007: Cidade := 'Palma Sola/SC';
      4212056: Cidade := 'Palmeira/SC';
      4212106: Cidade := 'Palmitos/SC';
      4212205: Cidade := 'Papanduva/SC';
      4212239: Cidade := 'Paraiso/SC';
      4212254: Cidade := 'Passo De Torres/SC';
      4212270: Cidade := 'Passos Maia/SC';
      4212304: Cidade := 'Paulo Lopes/SC';
      4212403: Cidade := 'Pedras Grandes/SC';
      4212502: Cidade := 'Penha/SC';
      4212601: Cidade := 'Peritiba/SC';
      4212700: Cidade := 'Petrolandia/SC';
      4212809: Cidade := 'Balneario Picarras/SC';
      4212908: Cidade := 'Pinhalzinho/SC';
      4213005: Cidade := 'Pinheiro Preto/SC';
      4213104: Cidade := 'Piratuba/SC';
      4213153: Cidade := 'Planalto Alegre/SC';
      4213203: Cidade := 'Pomerode/SC';
      4213302: Cidade := 'Ponte Alta/SC';
      4213351: Cidade := 'Ponte Alta Do Norte/SC';
      4213401: Cidade := 'Ponte Serrada/SC';
      4213500: Cidade := 'Porto Belo/SC';
      4213609: Cidade := 'Porto Uniao/SC';
      4213708: Cidade := 'Pouso Redondo/SC';
      4213807: Cidade := 'Praia Grande/SC';
      4213906: Cidade := 'Presidente Castello Branco/SC';
      4214003: Cidade := 'Presidente Getulio/SC';
      4214102: Cidade := 'Presidente Nereu/SC';
      4214151: Cidade := 'Princesa/SC';
      4214201: Cidade := 'Quilombo/SC';
      4214300: Cidade := 'Rancho Queimado/SC';
      4214409: Cidade := 'Rio Das Antas/SC';
      4214508: Cidade := 'Rio Do Campo/SC';
      4214607: Cidade := 'Rio Do Oeste/SC';
      4214706: Cidade := 'Rio Dos Cedros/SC';
      4214805: Cidade := 'Rio Do Sul/SC';
      4214904: Cidade := 'Rio Fortuna/SC';
      4215000: Cidade := 'Rio Negrinho/SC';
      4215059: Cidade := 'Rio Rufino/SC';
      4215075: Cidade := 'Riqueza/SC';
      4215109: Cidade := 'Rodeio/SC';
      4215208: Cidade := 'Romelandia/SC';
      4215307: Cidade := 'Salete/SC';
      4215356: Cidade := 'Saltinho/SC';
      4215406: Cidade := 'Salto Veloso/SC';
      4215455: Cidade := 'Sangao/SC';
      4215505: Cidade := 'Santa Cecilia/SC';
      4215554: Cidade := 'Santa Helena/SC';
      4215604: Cidade := 'Santa Rosa De Lima/SC';
      4215653: Cidade := 'Santa Rosa Do Sul/SC';
      4215679: Cidade := 'Santa Terezinha/SC';
      4215687: Cidade := 'Santa Terezinha Do Progresso/SC';
      4215695: Cidade := 'Santiago Do Sul/SC';
      4215703: Cidade := 'Santo Amaro Da Imperatriz/SC';
      4215752: Cidade := 'Sao Bernardino/SC';
      4215802: Cidade := 'Sao Bento Do Sul/SC';
      4215901: Cidade := 'Sao Bonifacio/SC';
      4216008: Cidade := 'Sao Carlos/SC';
      4216057: Cidade := 'Sao Cristovao Do Sul/SC';
      4216107: Cidade := 'Sao Domingos/SC';
      4216206: Cidade := 'Sao Francisco Do Sul/SC';
      4216255: Cidade := 'Sao Joao Do Oeste/SC';
      4216305: Cidade := 'Sao Joao Batista/SC';
      4216354: Cidade := 'Sao Joao Do Itaperiu/SC';
      4216404: Cidade := 'Sao Joao Do Sul/SC';
      4216503: Cidade := 'Sao Joaquim/SC';
      4216602: Cidade := 'Sao Jose/SC';
      4216701: Cidade := 'Sao Jose Do Cedro/SC';
      4216800: Cidade := 'Sao Jose Do Cerrito/SC';
      4216909: Cidade := 'Sao Lourenco Do Oeste/SC';
      4217006: Cidade := 'Sao Ludgero/SC';
      4217105: Cidade := 'Sao Martinho/SC';
      4217154: Cidade := 'Sao Miguel Da Boa Vista/SC';
      4217204: Cidade := 'Sao Miguel Do Oeste/SC';
      4217253: Cidade := 'Sao Pedro De Alcantara/SC';
      4217303: Cidade := 'Saudades/SC';
      4217402: Cidade := 'Schroeder/SC';
      4217501: Cidade := 'Seara/SC';
      4217550: Cidade := 'Serra Alta/SC';
      4217600: Cidade := 'Sideropolis/SC';
      4217709: Cidade := 'Sombrio/SC';
      4217758: Cidade := 'Sul Brasil/SC';
      4217808: Cidade := 'Taio/SC';
      4217907: Cidade := 'Tangara/SC';
      4217956: Cidade := 'Tigrinhos/SC';
      4218004: Cidade := 'Tijucas/SC';
      4218103: Cidade := 'Timbe Do Sul/SC';
      4218202: Cidade := 'Timbo/SC';
      4218251: Cidade := 'Timbo Grande/SC';
      4218301: Cidade := 'Tres Barras/SC';
      4218350: Cidade := 'Treviso/SC';
      4218400: Cidade := 'Treze De Maio/SC';
      4218509: Cidade := 'Treze Tilias/SC';
      4218608: Cidade := 'Trombudo Central/SC';
      4218707: Cidade := 'Tubarao/SC';
      4218756: Cidade := 'Tunapolis/SC';
      4218806: Cidade := 'Turvo/SC';
      4218855: Cidade := 'Uniao Do Oeste/SC';
      4218905: Cidade := 'Urubici/SC';
      4218954: Cidade := 'Urupema/SC';
      4219002: Cidade := 'Urussanga/SC';
      4219101: Cidade := 'Vargeao/SC';
      4219150: Cidade := 'Vargem/SC';
      4219176: Cidade := 'Vargem Bonita/SC';
      4219200: Cidade := 'Vidal Ramos/SC';
      4219309: Cidade := 'Videira/SC';
      4219358: Cidade := 'Vitor Meireles/SC';
      4219408: Cidade := 'Witmarsum/SC';
      4219507: Cidade := 'Xanxere/SC';
      4219606: Cidade := 'Xavantina/SC';
      4219705: Cidade := 'Xaxim/SC';
      4219853: Cidade := 'Zortea/SC';
   end;
 end;

 procedure P43;
 begin
   case ACodigo of
      4300034: Cidade := 'Acegua/RS';
      4300059: Cidade := 'Agua Santa/RS';
      4300109: Cidade := 'Agudo/RS';
      4300208: Cidade := 'Ajuricaba/RS';
      4300307: Cidade := 'Alecrim/RS';
      4300406: Cidade := 'Alegrete/RS';
      4300455: Cidade := 'Alegria/RS';
      4300471: Cidade := 'Almirante Tamandare Do Sul/RS';
      4300505: Cidade := 'Alpestre/RS';
      4300554: Cidade := 'Alto Alegre/RS';
      4300570: Cidade := 'Alto Feliz/RS';
      4300604: Cidade := 'Alvorada/RS';
      4300638: Cidade := 'Amaral Ferrador/RS';
      4300646: Cidade := 'Ametista Do Sul/RS';
      4300661: Cidade := 'Andre Da Rocha/RS';
      4300703: Cidade := 'Anta Gorda/RS';
      4300802: Cidade := 'Antonio Prado/RS';
      4300851: Cidade := 'Arambare/RS';
      4300877: Cidade := 'Ararica/RS';
      4300901: Cidade := 'Aratiba/RS';
      4301008: Cidade := 'Arroio Do Meio/RS';
      4301057: Cidade := 'Arroio Do Sal/RS';
      4301073: Cidade := 'Arroio Do Padre/RS';
      4301107: Cidade := 'Arroio Dos Ratos/RS';
      4301206: Cidade := 'Arroio Do Tigre/RS';
      4301305: Cidade := 'Arroio Grande/RS';
      4301404: Cidade := 'Arvorezinha/RS';
      4301503: Cidade := 'Augusto Pestana/RS';
      4301552: Cidade := 'Aurea/RS';
      4301602: Cidade := 'Bage/RS';
      4301636: Cidade := 'Balneario Pinhal/RS';
      4301651: Cidade := 'Barao/RS';
      4301701: Cidade := 'Barao De Cotegipe/RS';
      4301750: Cidade := 'Barao Do Triunfo/RS';
      4301800: Cidade := 'Barracao/RS';
      4301859: Cidade := 'Barra Do Guarita/RS';
      4301875: Cidade := 'Barra Do Quarai/RS';
      4301909: Cidade := 'Barra Do Ribeiro/RS';
      4301925: Cidade := 'Barra Do Rio Azul/RS';
      4301958: Cidade := 'Barra Funda/RS';
      4302006: Cidade := 'Barros Cassal/RS';
      4302055: Cidade := 'Benjamin Constant Do Sul/RS';
      4302105: Cidade := 'Bento Goncalves/RS';
      4302154: Cidade := 'Boa Vista Das Missoes/RS';
      4302204: Cidade := 'Boa Vista Do Burica/RS';
      4302220: Cidade := 'Boa Vista Do Cadeado/RS';
      4302238: Cidade := 'Boa Vista Do Incra/RS';
      4302253: Cidade := 'Boa Vista Do Sul/RS';
      4302303: Cidade := 'Bom Jesus/RS';
      4302352: Cidade := 'Bom Principio/RS';
      4302378: Cidade := 'Bom Progresso/RS';
      4302402: Cidade := 'Bom Retiro Do Sul/RS';
      4302451: Cidade := 'Boqueirao Do Leao/RS';
      4302501: Cidade := 'Bossoroca/RS';
      4302584: Cidade := 'Bozano/RS';
      4302600: Cidade := 'Braga/RS';
      4302659: Cidade := 'Brochier/RS';
      4302709: Cidade := 'Butia/RS';
      4302808: Cidade := 'Cacapava Do Sul/RS';
      4302907: Cidade := 'Cacequi/RS';
      4303004: Cidade := 'Cachoeira Do Sul/RS';
      4303103: Cidade := 'Cachoeirinha/RS';
      4303202: Cidade := 'Cacique Doble/RS';
      4303301: Cidade := 'Caibate/RS';
      4303400: Cidade := 'Caicara/RS';
      4303509: Cidade := 'Camaqua/RS';
      4303558: Cidade := 'Camargo/RS';
      4303608: Cidade := 'Cambara Do Sul/RS';
      4303673: Cidade := 'Campestre Da Serra/RS';
      4303707: Cidade := 'Campina Das Missoes/RS';
      4303806: Cidade := 'Campinas Do Sul/RS';
      4303905: Cidade := 'Campo Bom/RS';
      4304002: Cidade := 'Campo Novo/RS';
      4304101: Cidade := 'Campos Borges/RS';
      4304200: Cidade := 'Candelaria/RS';
      4304309: Cidade := 'Candido Godoi/RS';
      4304358: Cidade := 'Candiota/RS';
      4304408: Cidade := 'Canela/RS';
      4304507: Cidade := 'Cangucu/RS';
      4304606: Cidade := 'Canoas/RS';
      4304614: Cidade := 'Canudos Do Vale/RS';
      4304622: Cidade := 'Capao Bonito Do Sul/RS';
      4304630: Cidade := 'Capao Da Canoa/RS';
      4304655: Cidade := 'Capao Do Cipo/RS';
      4304663: Cidade := 'Capao Do Leao/RS';
      4304671: Cidade := 'Capivari Do Sul/RS';
      4304689: Cidade := 'Capela De Santana/RS';
      4304697: Cidade := 'Capitao/RS';
      4304705: Cidade := 'Carazinho/RS';
      4304713: Cidade := 'Caraa/RS';
      4304804: Cidade := 'Carlos Barbosa/RS';
      4304853: Cidade := 'Carlos Gomes/RS';
      4304903: Cidade := 'Casca/RS';
      4304952: Cidade := 'Caseiros/RS';
      4305009: Cidade := 'Catuipe/RS';
      4305108: Cidade := 'Caxias Do Sul/RS';
      4305116: Cidade := 'Centenario/RS';
      4305124: Cidade := 'Cerrito/RS';
      4305132: Cidade := 'Cerro Branco/RS';
      4305157: Cidade := 'Cerro Grande/RS';
      4305173: Cidade := 'Cerro Grande Do Sul/RS';
      4305207: Cidade := 'Cerro Largo/RS';
      4305306: Cidade := 'Chapada/RS';
      4305355: Cidade := 'Charqueadas/RS';
      4305371: Cidade := 'Charrua/RS';
      4305405: Cidade := 'Chiapetta/RS';
      4305439: Cidade := 'Chui/RS';
      4305447: Cidade := 'Chuvisca/RS';
      4305454: Cidade := 'Cidreira/RS';
      4305504: Cidade := 'Ciriaco/RS';
      4305587: Cidade := 'Colinas/RS';
      4305603: Cidade := 'Colorado/RS';
      4305702: Cidade := 'Condor/RS';
      4305801: Cidade := 'Constantina/RS';
      4305835: Cidade := 'Coqueiro Baixo/RS';
      4305850: Cidade := 'Coqueiros Do Sul/RS';
      4305871: Cidade := 'Coronel Barros/RS';
      4305900: Cidade := 'Coronel Bicaco/RS';
      4305934: Cidade := 'Coronel Pilar/RS';
      4305959: Cidade := 'Cotipora/RS';
      4305975: Cidade := 'Coxilha/RS';
      4306007: Cidade := 'Crissiumal/RS';
      4306056: Cidade := 'Cristal/RS';
      4306072: Cidade := 'Cristal Do Sul/RS';
      4306106: Cidade := 'Cruz Alta/RS';
      4306130: Cidade := 'Cruzaltense/RS';
      4306205: Cidade := 'Cruzeiro Do Sul/RS';
      4306304: Cidade := 'David Canabarro/RS';
      4306320: Cidade := 'Derrubadas/RS';
      4306353: Cidade := 'Dezesseis De Novembro/RS';
      4306379: Cidade := 'Dilermando De Aguiar/RS';
      4306403: Cidade := 'Dois Irmaos/RS';
      4306429: Cidade := 'Dois Irmaos Das Missoes/RS';
      4306452: Cidade := 'Dois Lajeados/RS';
      4306502: Cidade := 'Dom Feliciano/RS';
      4306551: Cidade := 'Dom Pedro De Alcantara/RS';
      4306601: Cidade := 'Dom Pedrito/RS';
      4306700: Cidade := 'Dona Francisca/RS';
      4306734: Cidade := 'Doutor Mauricio Cardoso/RS';
      4306759: Cidade := 'Doutor Ricardo/RS';
      4306767: Cidade := 'Eldorado Do Sul/RS';
      4306809: Cidade := 'Encantado/RS';
      4306908: Cidade := 'Encruzilhada Do Sul/RS';
      4306924: Cidade := 'Engenho Velho/RS';
      4306932: Cidade := 'Entre-Ijuis/RS';
      4306957: Cidade := 'Entre Rios Do Sul/RS';
      4306973: Cidade := 'Erebango/RS';
      4307005: Cidade := 'Erechim/RS';
      4307054: Cidade := 'Ernestina/RS';
      4307104: Cidade := 'Herval/RS';
      4307203: Cidade := 'Erval Grande/RS';
      4307302: Cidade := 'Erval Seco/RS';
      4307401: Cidade := 'Esmeralda/RS';
      4307450: Cidade := 'Esperanca Do Sul/RS';
      4307500: Cidade := 'Espumoso/RS';
      4307559: Cidade := 'Estacao/RS';
      4307609: Cidade := 'Estancia Velha/RS';
      4307708: Cidade := 'Esteio/RS';
      4307807: Cidade := 'Estrela/RS';
      4307815: Cidade := 'Estrela Velha/RS';
      4307831: Cidade := 'Eugenio De Castro/RS';
      4307864: Cidade := 'Fagundes Varela/RS';
      4307906: Cidade := 'Farroupilha/RS';
      4308003: Cidade := 'Faxinal Do Soturno/RS';
      4308052: Cidade := 'Faxinalzinho/RS';
      4308078: Cidade := 'Fazenda Vilanova/RS';
      4308102: Cidade := 'Feliz/RS';
      4308201: Cidade := 'Flores Da Cunha/RS';
      4308250: Cidade := 'Floriano Peixoto/RS';
      4308300: Cidade := 'Fontoura Xavier/RS';
      4308409: Cidade := 'Formigueiro/RS';
      4308433: Cidade := 'Forquetinha/RS';
      4308458: Cidade := 'Fortaleza Dos Valos/RS';
      4308508: Cidade := 'Frederico Westphalen/RS';
      4308607: Cidade := 'Garibaldi/RS';
      4308656: Cidade := 'Garruchos/RS';
      4308706: Cidade := 'Gaurama/RS';
      4308805: Cidade := 'General Camara/RS';
      4308854: Cidade := 'Gentil/RS';
      4308904: Cidade := 'Getulio Vargas/RS';
      4309001: Cidade := 'Girua/RS';
      4309050: Cidade := 'Glorinha/RS';
      4309100: Cidade := 'Gramado/RS';
      4309126: Cidade := 'Gramado Dos Loureiros/RS';
      4309159: Cidade := 'Gramado Xavier/RS';
      4309209: Cidade := 'Gravatai/RS';
      4309258: Cidade := 'Guabiju/RS';
      4309308: Cidade := 'Guaiba/RS';
      4309407: Cidade := 'Guapore/RS';
      4309506: Cidade := 'Guarani Das Missoes/RS';
      4309555: Cidade := 'Harmonia/RS';
      4309571: Cidade := 'Herveiras/RS';
      4309605: Cidade := 'Horizontina/RS';
      4309654: Cidade := 'Hulha Negra/RS';
      4309704: Cidade := 'Humaita/RS';
      4309753: Cidade := 'Ibarama/RS';
      4309803: Cidade := 'Ibiaca/RS';
      4309902: Cidade := 'Ibiraiaras/RS';
      4309951: Cidade := 'Ibirapuita/RS';
      4310009: Cidade := 'Ibiruba/RS';
      4310108: Cidade := 'Igrejinha/RS';
      4310207: Cidade := 'Ijui/RS';
      4310306: Cidade := 'Ilopolis/RS';
      4310330: Cidade := 'Imbe/RS';
      4310363: Cidade := 'Imigrante/RS';
      4310405: Cidade := 'Independencia/RS';
      4310413: Cidade := 'Inhacora/RS';
      4310439: Cidade := 'Ipe/RS';
      4310462: Cidade := 'Ipiranga Do Sul/RS';
      4310504: Cidade := 'Irai/RS';
      4310538: Cidade := 'Itaara/RS';
      4310553: Cidade := 'Itacurubi/RS';
      4310579: Cidade := 'Itapuca/RS';
      4310603: Cidade := 'Itaqui/RS';
      4310652: Cidade := 'Itati/RS';
      4310702: Cidade := 'Itatiba Do Sul/RS';
      4310751: Cidade := 'Ivora/RS';
      4310801: Cidade := 'Ivoti/RS';
      4310850: Cidade := 'Jaboticaba/RS';
      4310876: Cidade := 'Jacuizinho/RS';
      4310900: Cidade := 'Jacutinga/RS';
      4311007: Cidade := 'Jaguarao/RS';
      4311106: Cidade := 'Jaguari/RS';
      4311122: Cidade := 'Jaquirana/RS';
      4311130: Cidade := 'Jari/RS';
      4311155: Cidade := 'Joia/RS';
      4311205: Cidade := 'Julio De Castilhos/RS';
      4311239: Cidade := 'Lagoa Bonita Do Sul/RS';
      4311254: Cidade := 'Lagoao/RS';
      4311270: Cidade := 'Lagoa Dos Tres Cantos/RS';
      4311304: Cidade := 'Lagoa Vermelha/RS';
      4311403: Cidade := 'Lajeado/RS';
      4311429: Cidade := 'Lajeado Do Bugre/RS';
      4311502: Cidade := 'Lavras Do Sul/RS';
      4311601: Cidade := 'Liberato Salzano/RS';
      4311627: Cidade := 'Lindolfo Collor/RS';
      4311643: Cidade := 'Linha Nova/RS';
      4311700: Cidade := 'Machadinho/RS';
      4311718: Cidade := 'Macambara/RS';
      4311734: Cidade := 'Mampituba/RS';
      4311759: Cidade := 'Manoel Viana/RS';
      4311775: Cidade := 'Maquine/RS';
      4311791: Cidade := 'Marata/RS';
      4311809: Cidade := 'Marau/RS';
      4311908: Cidade := 'Marcelino Ramos/RS';
      4311981: Cidade := 'Mariana Pimentel/RS';
      4312005: Cidade := 'Mariano Moro/RS';
      4312054: Cidade := 'Marques De Souza/RS';
      4312104: Cidade := 'Mata/RS';
      4312138: Cidade := 'Mato Castelhano/RS';
      4312153: Cidade := 'Mato Leitao/RS';
      4312179: Cidade := 'Mato Queimado/RS';
      4312203: Cidade := 'Maximiliano De Almeida/RS';
      4312252: Cidade := 'Minas Do Leao/RS';
      4312302: Cidade := 'Miraguai/RS';
      4312351: Cidade := 'Montauri/RS';
      4312377: Cidade := 'Monte Alegre Dos Campos/RS';
      4312385: Cidade := 'Monte Belo Do Sul/RS';
      4312401: Cidade := 'Montenegro/RS';
      4312427: Cidade := 'Mormaco/RS';
      4312443: Cidade := 'Morrinhos Do Sul/RS';
      4312450: Cidade := 'Morro Redondo/RS';
      4312476: Cidade := 'Morro Reuter/RS';
      4312500: Cidade := 'Mostardas/RS';
      4312609: Cidade := 'Mucum/RS';
      4312617: Cidade := 'Muitos Capoes/RS';
      4312625: Cidade := 'Muliterno/RS';
      4312658: Cidade := 'Nao-Me-Toque/RS';
      4312674: Cidade := 'Nicolau Vergueiro/RS';
      4312708: Cidade := 'Nonoai/RS';
      4312757: Cidade := 'Nova Alvorada/RS';
      4312807: Cidade := 'Nova Araca/RS';
      4312906: Cidade := 'Nova Bassano/RS';
      4312955: Cidade := 'Nova Boa Vista/RS';
      4313003: Cidade := 'Nova Brescia/RS';
      4313011: Cidade := 'Nova Candelaria/RS';
      4313037: Cidade := 'Nova Esperanca Do Sul/RS';
      4313060: Cidade := 'Nova Hartz/RS';
      4313086: Cidade := 'Nova Padua/RS';
      4313102: Cidade := 'Nova Palma/RS';
      4313201: Cidade := 'Nova Petropolis/RS';
      4313300: Cidade := 'Nova Prata/RS';
      4313334: Cidade := 'Nova Ramada/RS';
      4313359: Cidade := 'Nova Roma Do Sul/RS';
      4313375: Cidade := 'Nova Santa Rita/RS';
      4313391: Cidade := 'Novo Cabrais/RS';
      4313409: Cidade := 'Novo Hamburgo/RS';
      4313425: Cidade := 'Novo Machado/RS';
      4313441: Cidade := 'Novo Tiradentes/RS';
      4313466: Cidade := 'Novo Xingu/RS';
      4313490: Cidade := 'Novo Barreiro/RS';
      4313508: Cidade := 'Osorio/RS';
      4313607: Cidade := 'Paim Filho/RS';
      4313656: Cidade := 'Palmares Do Sul/RS';
      4313706: Cidade := 'Palmeira Das Missoes/RS';
      4313805: Cidade := 'Palmitinho/RS';
      4313904: Cidade := 'Panambi/RS';
      4313953: Cidade := 'Pantano Grande/RS';
      4314001: Cidade := 'Parai/RS';
      4314027: Cidade := 'Paraiso Do Sul/RS';
      4314035: Cidade := 'Pareci Novo/RS';
      4314050: Cidade := 'Parobe/RS';
      4314068: Cidade := 'Passa Sete/RS';
      4314076: Cidade := 'Passo Do Sobrado/RS';
      4314100: Cidade := 'Passo Fundo/RS';
      4314134: Cidade := 'Paulo Bento/RS';
      4314159: Cidade := 'Paverama/RS';
      4314175: Cidade := 'Pedras Altas/RS';
      4314209: Cidade := 'Pedro Osorio/RS';
      4314308: Cidade := 'Pejucara/RS';
      4314407: Cidade := 'Pelotas/RS';
      4314423: Cidade := 'Picada Cafe/RS';
      4314456: Cidade := 'Pinhal/RS';
      4314464: Cidade := 'Pinhal Da Serra/RS';
      4314472: Cidade := 'Pinhal Grande/RS';
      4314498: Cidade := 'Pinheirinho Do Vale/RS';
      4314506: Cidade := 'Pinheiro Machado/RS';
      4314555: Cidade := 'Pirapo/RS';
      4314605: Cidade := 'Piratini/RS';
      4314704: Cidade := 'Planalto/RS';
      4314753: Cidade := 'Poco Das Antas/RS';
      4314779: Cidade := 'Pontao/RS';
      4314787: Cidade := 'Ponte Preta/RS';
      4314803: Cidade := 'Portao/RS';
      4314902: Cidade := 'Porto Alegre/RS';
      4315008: Cidade := 'Porto Lucena/RS';
      4315057: Cidade := 'Porto Maua/RS';
      4315073: Cidade := 'Porto Vera Cruz/RS';
      4315107: Cidade := 'Porto Xavier/RS';
      4315131: Cidade := 'Pouso Novo/RS';
      4315149: Cidade := 'Presidente Lucena/RS';
      4315156: Cidade := 'Progresso/RS';
      4315172: Cidade := 'Protasio Alves/RS';
      4315206: Cidade := 'Putinga/RS';
      4315305: Cidade := 'Quarai/RS';
      4315313: Cidade := 'Quatro Irmaos/RS';
      4315321: Cidade := 'Quevedos/RS';
      4315354: Cidade := 'Quinze De Novembro/RS';
      4315404: Cidade := 'Redentora/RS';
      4315453: Cidade := 'Relvado/RS';
      4315503: Cidade := 'Restinga Seca/RS';
      4315552: Cidade := 'Rio Dos Indios/RS';
      4315602: Cidade := 'Rio Grande/RS';
      4315701: Cidade := 'Rio Pardo/RS';
      4315750: Cidade := 'Riozinho/RS';
      4315800: Cidade := 'Roca Sales/RS';
      4315909: Cidade := 'Rodeio Bonito/RS';
      4315958: Cidade := 'Rolador/RS';
      4316006: Cidade := 'Rolante/RS';
      4316105: Cidade := 'Ronda Alta/RS';
      4316204: Cidade := 'Rondinha/RS';
      4316303: Cidade := 'Roque Gonzales/RS';
      4316402: Cidade := 'Rosario Do Sul/RS';
      4316428: Cidade := 'Sagrada Familia/RS';
      4316436: Cidade := 'Saldanha Marinho/RS';
      4316451: Cidade := 'Salto Do Jacui/RS';
      4316477: Cidade := 'Salvador Das Missoes/RS';
      4316501: Cidade := 'Salvador Do Sul/RS';
      4316600: Cidade := 'Sananduva/RS';
      4316709: Cidade := 'Santa Barbara Do Sul/RS';
      4316733: Cidade := 'Santa Cecilia Do Sul/RS';
      4316758: Cidade := 'Santa Clara Do Sul/RS';
      4316808: Cidade := 'Santa Cruz Do Sul/RS';
      4316907: Cidade := 'Santa Maria/RS';
      4316956: Cidade := 'Santa Maria Do Herval/RS';
      4316972: Cidade := 'Santa Margarida Do Sul/RS';
      4317004: Cidade := 'Santana Da Boa Vista/RS';
      4317103: Cidade := 'Sant  Ana Do Livramento/RS';
      4317202: Cidade := 'Santa Rosa/RS';
      4317251: Cidade := 'Santa Tereza/RS';
      4317301: Cidade := 'Santa Vitoria Do Palmar/RS';
      4317400: Cidade := 'Santiago/RS';
      4317509: Cidade := 'Santo Angelo/RS';
      4317558: Cidade := 'Santo Antonio Do Palma/RS';
      4317608: Cidade := 'Santo Antonio Da Patrulha/RS';
      4317707: Cidade := 'Santo Antonio Das Missoes/RS';
      4317756: Cidade := 'Santo Antonio Do Planalto/RS';
      4317806: Cidade := 'Santo Augusto/RS';
      4317905: Cidade := 'Santo Cristo/RS';
      4317954: Cidade := 'Santo Expedito Do Sul/RS';
      4318002: Cidade := 'Sao Borja/RS';
      4318051: Cidade := 'Sao Domingos Do Sul/RS';
      4318101: Cidade := 'Sao Francisco De Assis/RS';
      4318200: Cidade := 'Sao Francisco De Paula/RS';
      4318309: Cidade := 'Sao Gabriel/RS';
      4318408: Cidade := 'Sao Jeronimo/RS';
      4318424: Cidade := 'Sao Joao Da Urtiga/RS';
      4318432: Cidade := 'Sao Joao Do Polesine/RS';
      4318440: Cidade := 'Sao Jorge/RS';
      4318457: Cidade := 'Sao Jose Das Missoes/RS';
      4318465: Cidade := 'Sao Jose Do Herval/RS';
      4318481: Cidade := 'Sao Jose Do Hortencio/RS';
      4318499: Cidade := 'Sao Jose Do Inhacora/RS';
      4318507: Cidade := 'Sao Jose Do Norte/RS';
      4318606: Cidade := 'Sao Jose Do Ouro/RS';
      4318614: Cidade := 'Sao Jose Do Sul/RS';
      4318622: Cidade := 'Sao Jose Dos Ausentes/RS';
      4318705: Cidade := 'Sao Leopoldo/RS';
      4318804: Cidade := 'Sao Lourenco Do Sul/RS';
      4318903: Cidade := 'Sao Luiz Gonzaga/RS';
      4319000: Cidade := 'Sao Marcos/RS';
      4319109: Cidade := 'Sao Martinho/RS';
      4319125: Cidade := 'Sao Martinho Da Serra/RS';
      4319158: Cidade := 'Sao Miguel Das Missoes/RS';
      4319208: Cidade := 'Sao Nicolau/RS';
      4319307: Cidade := 'Sao Paulo Das Missoes/RS';
      4319356: Cidade := 'Sao Pedro Da Serra/RS';
      4319364: Cidade := 'Sao Pedro Das Missoes/RS';
      4319372: Cidade := 'Sao Pedro Do Butia/RS';
      4319406: Cidade := 'Sao Pedro Do Sul/RS';
      4319505: Cidade := 'Sao Sebastiao Do Cai/RS';
      4319604: Cidade := 'Sao Sepe/RS';
      4319703: Cidade := 'Sao Valentim/RS';
      4319711: Cidade := 'Sao Valentim Do Sul/RS';
      4319737: Cidade := 'Sao Valerio Do Sul/RS';
      4319752: Cidade := 'Sao Vendelino/RS';
      4319802: Cidade := 'Sao Vicente Do Sul/RS';
      4319901: Cidade := 'Sapiranga/RS';
      4320008: Cidade := 'Sapucaia Do Sul/RS';
      4320107: Cidade := 'Sarandi/RS';
      4320206: Cidade := 'Seberi/RS';
      4320230: Cidade := 'Sede Nova/RS';
      4320263: Cidade := 'Segredo/RS';
      4320305: Cidade := 'Selbach/RS';
      4320321: Cidade := 'Senador Salgado Filho/RS';
      4320354: Cidade := 'Sentinela Do Sul/RS';
      4320404: Cidade := 'Serafina Correa/RS';
      4320453: Cidade := 'Serio/RS';
      4320503: Cidade := 'Sertao/RS';
      4320552: Cidade := 'Sertao Santana/RS';
      4320578: Cidade := 'Sete De Setembro/RS';
      4320602: Cidade := 'Severiano De Almeida/RS';
      4320651: Cidade := 'Silveira Martins/RS';
      4320677: Cidade := 'Sinimbu/RS';
      4320701: Cidade := 'Sobradinho/RS';
      4320800: Cidade := 'Soledade/RS';
      4320859: Cidade := 'Tabai/RS';
      4320909: Cidade := 'Tapejara/RS';
      4321006: Cidade := 'Tapera/RS';
      4321105: Cidade := 'Tapes/RS';
      4321204: Cidade := 'Taquara/RS';
      4321303: Cidade := 'Taquari/RS';
      4321329: Cidade := 'Taquarucu Do Sul/RS';
      4321352: Cidade := 'Tavares/RS';
      4321402: Cidade := 'Tenente Portela/RS';
      4321436: Cidade := 'Terra De Areia/RS';
      4321451: Cidade := 'Teutonia/RS';
      4321469: Cidade := 'Tio Hugo/RS';
      4321477: Cidade := 'Tiradentes Do Sul/RS';
      4321493: Cidade := 'Toropi/RS';
      4321501: Cidade := 'Torres/RS';
      4321600: Cidade := 'Tramandai/RS';
      4321626: Cidade := 'Travesseiro/RS';
      4321634: Cidade := 'Tres Arroios/RS';
      4321667: Cidade := 'Tres Cachoeiras/RS';
      4321709: Cidade := 'Tres Coroas/RS';
      4321808: Cidade := 'Tres De Maio/RS';
      4321832: Cidade := 'Tres Forquilhas/RS';
      4321857: Cidade := 'Tres Palmeiras/RS';
      4321907: Cidade := 'Tres Passos/RS';
      4321956: Cidade := 'Trindade Do Sul/RS';
      4322004: Cidade := 'Triunfo/RS';
      4322103: Cidade := 'Tucunduva/RS';
      4322152: Cidade := 'Tunas/RS';
      4322186: Cidade := 'Tupanci Do Sul/RS';
      4322202: Cidade := 'Tupancireta/RS';
      4322251: Cidade := 'Tupandi/RS';
      4322301: Cidade := 'Tuparendi/RS';
      4322327: Cidade := 'Turucu/RS';
      4322343: Cidade := 'Ubiretama/RS';
      4322350: Cidade := 'Uniao Da Serra/RS';
      4322376: Cidade := 'Unistalda/RS';
      4322400: Cidade := 'Uruguaiana/RS';
      4322509: Cidade := 'Vacaria/RS';
      4322525: Cidade := 'Vale Verde/RS';
      4322533: Cidade := 'Vale Do Sol/RS';
      4322541: Cidade := 'Vale Real/RS';
      4322558: Cidade := 'Vanini/RS';
      4322608: Cidade := 'Venancio Aires/RS';
      4322707: Cidade := 'Vera Cruz/RS';
      4322806: Cidade := 'Veranopolis/RS';
      4322855: Cidade := 'Vespasiano Correa/RS';
      4322905: Cidade := 'Viadutos/RS';
      4323002: Cidade := 'Viamao/RS';
      4323101: Cidade := 'Vicente Dutra/RS';
      4323200: Cidade := 'Victor Graeff/RS';
      4323309: Cidade := 'Vila Flores/RS';
      4323358: Cidade := 'Vila Langaro/RS';
      4323408: Cidade := 'Vila Maria/RS';
      4323457: Cidade := 'Vila Nova Do Sul/RS';
      4323507: Cidade := 'Vista Alegre/RS';
      4323606: Cidade := 'Vista Alegre Do Prata/RS';
      4323705: Cidade := 'Vista Gaucha/RS';
      4323754: Cidade := 'Vitoria Das Missoes/RS';
      4323770: Cidade := 'Westfalia/RS';
      4323804: Cidade := 'Xangri-La/RS';
   end;
 end;

 procedure P50;
 begin
   case ACodigo of
      5000203: Cidade := 'Agua Clara/MS';
      5000252: Cidade := 'Alcinopolis/MS';
      5000609: Cidade := 'Amambai/MS';
      5000708: Cidade := 'Anastacio/MS';
      5000807: Cidade := 'Anaurilandia/MS';
      5000856: Cidade := 'Angelica/MS';
      5000906: Cidade := 'Antonio Joao/MS';
      5001003: Cidade := 'Aparecida Do Taboado/MS';
      5001102: Cidade := 'Aquidauana/MS';
      5001243: Cidade := 'Aral Moreira/MS';
      5001508: Cidade := 'Bandeirantes/MS';
      5001904: Cidade := 'Bataguassu/MS';
      5002001: Cidade := 'Bataypora/MS';
      5002100: Cidade := 'Bela Vista/MS';
      5002159: Cidade := 'Bodoquena/MS';
      5002209: Cidade := 'Bonito/MS';
      5002308: Cidade := 'Brasilandia/MS';
      5002407: Cidade := 'Caarapo/MS';
      5002605: Cidade := 'Camapua/MS';
      5002704: Cidade := 'Campo Grande/MS';
      5002803: Cidade := 'Caracol/MS';
      5002902: Cidade := 'Cassilandia/MS';
      5002951: Cidade := 'Chapadao Do Sul/MS';
      5003108: Cidade := 'Corguinho/MS';
      5003157: Cidade := 'Coronel Sapucaia/MS';
      5003207: Cidade := 'Corumba/MS';
      5003256: Cidade := 'Costa Rica/MS';
      5003306: Cidade := 'Coxim/MS';
      5003454: Cidade := 'Deodapolis/MS';
      5003488: Cidade := 'Dois Irmaos Do Buriti/MS';
      5003504: Cidade := 'Douradina/MS';
      5003702: Cidade := 'Dourados/MS';
      5003751: Cidade := 'Eldorado/MS';
      5003801: Cidade := 'Fatima Do Sul/MS';
      5003900: Cidade := 'Figueirao/MS';
      5004007: Cidade := 'Gloria De Dourados/MS';
      5004106: Cidade := 'Guia Lopes Da Laguna/MS';
      5004304: Cidade := 'Iguatemi/MS';
      5004403: Cidade := 'Inocencia/MS';
      5004502: Cidade := 'Itapora/MS';
      5004601: Cidade := 'Itaquirai/MS';
      5004700: Cidade := 'Ivinhema/MS';
      5004809: Cidade := 'Japora/MS';
      5004908: Cidade := 'Jaraguari/MS';
      5005004: Cidade := 'Jardim/MS';
      5005103: Cidade := 'Jatei/MS';
      5005152: Cidade := 'Juti/MS';
      5005202: Cidade := 'Ladario/MS';
      5005251: Cidade := 'Laguna Carapa/MS';
      5005400: Cidade := 'Maracaju/MS';
      5005608: Cidade := 'Miranda/MS';
      5005681: Cidade := 'Mundo Novo/MS';
      5005707: Cidade := 'Navirai/MS';
      5005806: Cidade := 'Nioaque/MS';
      5006002: Cidade := 'Nova Alvorada Do Sul/MS';
      5006200: Cidade := 'Nova Andradina/MS';
      5006259: Cidade := 'Novo Horizonte Do Sul/MS';
      5006309: Cidade := 'Paranaiba/MS';
      5006358: Cidade := 'Paranhos/MS';
      5006408: Cidade := 'Pedro Gomes/MS';
      5006606: Cidade := 'Ponta Pora/MS';
      5006903: Cidade := 'Porto Murtinho/MS';
      5007109: Cidade := 'Ribas Do Rio Pardo/MS';
      5007208: Cidade := 'Rio Brilhante/MS';
      5007307: Cidade := 'Rio Negro/MS';
      5007406: Cidade := 'Rio Verde De Mato Grosso/MS';
      5007505: Cidade := 'Rochedo/MS';
      5007554: Cidade := 'Santa Rita Do Pardo/MS';
      5007695: Cidade := 'Sao Gabriel Do Oeste/MS';
      5007703: Cidade := 'Sete Quedas/MS';
      5007802: Cidade := 'Selviria/MS';
      5007901: Cidade := 'Sidrolandia/MS';
      5007935: Cidade := 'Sonora/MS';
      5007950: Cidade := 'Tacuru/MS';
      5007976: Cidade := 'Taquarussu/MS';
      5008008: Cidade := 'Terenos/MS';
      5008305: Cidade := 'Tres Lagoas/MS';
      5008404: Cidade := 'Vicentina/MS';
   end;
 end;

 procedure P51;
 begin
   case ACodigo of
      5100102: Cidade := 'Acorizal/MT';
      5100201: Cidade := 'Agua Boa/MT';
      5100250: Cidade := 'Alta Floresta/MT';
      5100300: Cidade := 'Alto Araguaia/MT';
      5100359: Cidade := 'Alto Boa Vista/MT';
      5100409: Cidade := 'Alto Garcas/MT';
      5100508: Cidade := 'Alto Paraguai/MT';
      5100607: Cidade := 'Alto Taquari/MT';
      5100805: Cidade := 'Apiacas/MT';
      5101001: Cidade := 'Araguaiana/MT';
      5101209: Cidade := 'Araguainha/MT';
      5101258: Cidade := 'Araputanga/MT';
      5101308: Cidade := 'Arenapolis/MT';
      5101407: Cidade := 'Aripuana/MT';
      5101605: Cidade := 'Barao De Melgaco/MT';
      5101704: Cidade := 'Barra Do Bugres/MT';
      5101803: Cidade := 'Barra Do Garcas/MT';
      5101852: Cidade := 'Bom Jesus Do Araguaia/MT';
      5101902: Cidade := 'Brasnorte/MT';
      5102504: Cidade := 'Caceres/MT';
      5102603: Cidade := 'Campinapolis/MT';
      5102637: Cidade := 'Campo Novo Do Parecis/MT';
      5102678: Cidade := 'Campo Verde/MT';
      5102686: Cidade := 'Campos De Julio/MT';
      5102694: Cidade := 'Canabrava Do Norte/MT';
      5102702: Cidade := 'Canarana/MT';
      5102793: Cidade := 'Carlinda/MT';
      5102850: Cidade := 'Castanheira/MT';
      5103007: Cidade := 'Chapada Dos Guimaraes/MT';
      5103056: Cidade := 'Claudia/MT';
      5103106: Cidade := 'Cocalinho/MT';
      5103205: Cidade := 'Colider/MT';
      5103254: Cidade := 'Colniza/MT';
      5103304: Cidade := 'Comodoro/MT';
      5103353: Cidade := 'Confresa/MT';
      5103361: Cidade := 'Conquista D Oeste/MT';
      5103379: Cidade := 'Cotriguacu/MT';
      5103403: Cidade := 'Cuiaba/MT';
      5103437: Cidade := 'Curvelandia/MT';
      5103452: Cidade := 'Denise/MT';
      5103502: Cidade := 'Diamantino/MT';
      5103601: Cidade := 'Dom Aquino/MT';
      5103700: Cidade := 'Feliz Natal/MT';
      5103809: Cidade := 'Figueiropolis D Oeste/MT';
      5103858: Cidade := 'Gaucha Do Norte/MT';
      5103908: Cidade := 'General Carneiro/MT';
      5103957: Cidade := 'Gloria D Oeste/MT';
      5104104: Cidade := 'Guaranta Do Norte/MT';
      5104203: Cidade := 'Guiratinga/MT';
      5104500: Cidade := 'Indiavai/MT';
      5104526: Cidade := 'Ipiranga Do Norte/MT';
      5104542: Cidade := 'Itanhanga/MT';
      5104559: Cidade := 'Itauba/MT';
      5104609: Cidade := 'Itiquira/MT';
      5104807: Cidade := 'Jaciara/MT';
      5104906: Cidade := 'Jangada/MT';
      5105002: Cidade := 'Jauru/MT';
      5105101: Cidade := 'Juara/MT';
      5105150: Cidade := 'Juina/MT';
      5105176: Cidade := 'Juruena/MT';
      5105200: Cidade := 'Juscimeira/MT';
      5105234: Cidade := 'Lambari D Oeste/MT';
      5105259: Cidade := 'Lucas Do Rio Verde/MT';
      5105309: Cidade := 'Luciara/MT';
      5105507: Cidade := 'Vila Bela Da Santissima Trindade/MT';
      5105580: Cidade := 'Marcelandia/MT';
      5105606: Cidade := 'Matupa/MT';
      5105622: Cidade := 'Mirassol D Oeste/MT';
      5105903: Cidade := 'Nobres/MT';
      5106000: Cidade := 'Nortelandia/MT';
      5106109: Cidade := 'Nossa Senhora Do Livramento/MT';
      5106158: Cidade := 'Nova Bandeirantes/MT';
      5106174: Cidade := 'Nova Nazare/MT';
      5106182: Cidade := 'Nova Lacerda/MT';
      5106190: Cidade := 'Nova Santa Helena/MT';
      5106208: Cidade := 'Nova Brasilandia/MT';
      5106216: Cidade := 'Nova Canaa Do Norte/MT';
      5106224: Cidade := 'Nova Mutum/MT';
      5106232: Cidade := 'Nova Olimpia/MT';
      5106240: Cidade := 'Nova Ubirata/MT';
      5106257: Cidade := 'Nova Xavantina/MT';
      5106265: Cidade := 'Novo Mundo/MT';
      5106273: Cidade := 'Novo Horizonte Do Norte/MT';
      5106281: Cidade := 'Novo Sao Joaquim/MT';
      5106299: Cidade := 'Paranaita/MT';
      5106307: Cidade := 'Paranatinga/MT';
      5106315: Cidade := 'Novo Santo Antonio/MT';
      5106372: Cidade := 'Pedra Preta/MT';
      5106422: Cidade := 'Peixoto De Azevedo/MT';
      5106455: Cidade := 'Planalto Da Serra/MT';
      5106505: Cidade := 'Pocone/MT';
      5106653: Cidade := 'Pontal Do Araguaia/MT';
      5106703: Cidade := 'Ponte Branca/MT';
      5106752: Cidade := 'Pontes E Lacerda/MT';
      5106778: Cidade := 'Porto Alegre Do Norte/MT';
      5106802: Cidade := 'Porto Dos Gauchos/MT';
      5106828: Cidade := 'Porto Esperidiao/MT';
      5106851: Cidade := 'Porto Estrela/MT';
      5107008: Cidade := 'Poxoreo/MT';
      5107040: Cidade := 'Primavera Do Leste/MT';
      5107065: Cidade := 'Querencia/MT';
      5107107: Cidade := 'Sao Jose Dos Quatro Marcos/MT';
      5107156: Cidade := 'Reserva Do Cabacal/MT';
      5107180: Cidade := 'Ribeirao Cascalheira/MT';
      5107198: Cidade := 'Ribeiraozinho/MT';
      5107206: Cidade := 'Rio Branco/MT';
      5107248: Cidade := 'Santa Carmem/MT';
      5107263: Cidade := 'Santo Afonso/MT';
      5107297: Cidade := 'Sao Jose Do Povo/MT';
      5107305: Cidade := 'Sao Jose Do Rio Claro/MT';
      5107354: Cidade := 'Sao Jose Do Xingu/MT';
      5107404: Cidade := 'Sao Pedro Da Cipa/MT';
      5107578: Cidade := 'Rondolandia/MT';
      5107602: Cidade := 'Rondonopolis/MT';
      5107701: Cidade := 'Rosario Oeste/MT';
      5107743: Cidade := 'Santa Cruz Do Xingu/MT';
      5107750: Cidade := 'Salto Do Ceu/MT';
      5107768: Cidade := 'Santa Rita Do Trivelato/MT';
      5107776: Cidade := 'Santa Terezinha/MT';
      5107792: Cidade := 'Santo Antonio Do Leste/MT';
      5107800: Cidade := 'Santo Antonio Do Leverger/MT';
      5107859: Cidade := 'Sao Felix Do Araguaia/MT';
      5107875: Cidade := 'Sapezal/MT';
      5107883: Cidade := 'Serra Nova Dourada/MT';
      5107909: Cidade := 'Sinop/MT';
      5107925: Cidade := 'Sorriso/MT';
      5107941: Cidade := 'Tabapora/MT';
      5107958: Cidade := 'Tangara Da Serra/MT';
      5108006: Cidade := 'Tapurah/MT';
      5108055: Cidade := 'Terra Nova Do Norte/MT';
      5108105: Cidade := 'Tesouro/MT';
      5108204: Cidade := 'Torixoreu/MT';
      5108303: Cidade := 'Uniao Do Sul/MT';
      5108352: Cidade := 'Vale De Sao Domingos/MT';
      5108402: Cidade := 'Varzea Grande/MT';
      5108501: Cidade := 'Vera/MT';
      5108600: Cidade := 'Vila Rica/MT';
      5108808: Cidade := 'Nova Guarita/MT';
      5108857: Cidade := 'Nova Marilandia/MT';
      5108907: Cidade := 'Nova Maringa/MT';
      5108956: Cidade := 'Nova Monte Verde/MT';
   end;
 end;

 procedure P52;
 begin
   case ACodigo of
      5200050: Cidade := 'Abadia De Goias/GO';
      5200100: Cidade := 'Abadiania/GO';
      5200134: Cidade := 'Acreuna/GO';
      5200159: Cidade := 'Adelandia/GO';
      5200175: Cidade := 'Agua Fria De Goias/GO';
      5200209: Cidade := 'Agua Limpa/GO';
      5200258: Cidade := 'Aguas Lindas De Goias/GO';
      5200308: Cidade := 'Alexania/GO';
      5200506: Cidade := 'Aloandia/GO';
      5200555: Cidade := 'Alto Horizonte/GO';
      5200605: Cidade := 'Alto Paraiso De Goias/GO';
      5200803: Cidade := 'Alvorada Do Norte/GO';
      5200829: Cidade := 'Amaralina/GO';
      5200852: Cidade := 'Americano Do Brasil/GO';
      5200902: Cidade := 'Amorinopolis/GO';
      5201108: Cidade := 'Anapolis/GO';
      5201207: Cidade := 'Anhanguera/GO';
      5201306: Cidade := 'Anicuns/GO';
      5201405: Cidade := 'Aparecida De Goiania/GO';
      5201454: Cidade := 'Aparecida Do Rio Doce/GO';
      5201504: Cidade := 'Apore/GO';
      5201603: Cidade := 'Aracu/GO';
      5201702: Cidade := 'Aragarcas/GO';
      5201801: Cidade := 'Aragoiania/GO';
      5202155: Cidade := 'Araguapaz/GO';
      5202353: Cidade := 'Arenopolis/GO';
      5202502: Cidade := 'Aruana/GO';
      5202601: Cidade := 'Aurilandia/GO';
      5202809: Cidade := 'Avelinopolis/GO';
      5203104: Cidade := 'Baliza/GO';
      5203203: Cidade := 'Barro Alto/GO';
      5203302: Cidade := 'Bela Vista De Goias/GO';
      5203401: Cidade := 'Bom Jardim De Goias/GO';
      5203500: Cidade := 'Bom Jesus De Goias/GO';
      5203559: Cidade := 'Bonfinopolis/GO';
      5203575: Cidade := 'Bonopolis/GO';
      5203609: Cidade := 'Brazabrantes/GO';
      5203807: Cidade := 'Britania/GO';
      5203906: Cidade := 'Buriti Alegre/GO';
      5203939: Cidade := 'Buriti De Goias/GO';
      5203962: Cidade := 'Buritinopolis/GO';
      5204003: Cidade := 'Cabeceiras/GO';
      5204102: Cidade := 'Cachoeira Alta/GO';
      5204201: Cidade := 'Cachoeira De Goias/GO';
      5204250: Cidade := 'Cachoeira Dourada/GO';
      5204300: Cidade := 'Cacu/GO';
      5204409: Cidade := 'Caiaponia/GO';
      5204508: Cidade := 'Caldas Novas/GO';
      5204557: Cidade := 'Caldazinha/GO';
      5204607: Cidade := 'Campestre De Goias/GO';
      5204656: Cidade := 'Campinacu/GO';
      5204706: Cidade := 'Campinorte/GO';
      5204805: Cidade := 'Campo Alegre De Goias/GO';
      5204854: Cidade := 'Campo Limpo De Goias/GO';
      5204904: Cidade := 'Campos Belos/GO';
      5204953: Cidade := 'Campos Verdes/GO';
      5205000: Cidade := 'Carmo Do Rio Verde/GO';
      5205059: Cidade := 'Castelandia/GO';
      5205109: Cidade := 'Catalao/GO';
      5205208: Cidade := 'Caturai/GO';
      5205307: Cidade := 'Cavalcante/GO';
      5205406: Cidade := 'Ceres/GO';
      5205455: Cidade := 'Cezarina/GO';
      5205471: Cidade := 'Chapadao Do Ceu/GO';
      5205497: Cidade := 'Cidade Ocidental/GO';
      5205513: Cidade := 'Cocalzinho De Goias/GO';
      5205521: Cidade := 'Colinas Do Sul/GO';
      5205703: Cidade := 'Corrego Do Ouro/GO';
      5205802: Cidade := 'Corumba De Goias/GO';
      5205901: Cidade := 'Corumbaiba/GO';
      5206206: Cidade := 'Cristalina/GO';
      5206305: Cidade := 'Cristianopolis/GO';
      5206404: Cidade := 'Crixas/GO';
      5206503: Cidade := 'Crominia/GO';
      5206602: Cidade := 'Cumari/GO';
      5206701: Cidade := 'Damianopolis/GO';
      5206800: Cidade := 'Damolandia/GO';
      5206909: Cidade := 'Davinopolis/GO';
      5207105: Cidade := 'Diorama/GO';
      5207253: Cidade := 'Doverlandia/GO';
      5207352: Cidade := 'Edealina/GO';
      5207402: Cidade := 'Edeia/GO';
      5207501: Cidade := 'Estrela Do Norte/GO';
      5207535: Cidade := 'Faina/GO';
      5207600: Cidade := 'Fazenda Nova/GO';
      5207808: Cidade := 'Firminopolis/GO';
      5207907: Cidade := 'Flores De Goias/GO';
      5208004: Cidade := 'Formosa/GO';
      5208103: Cidade := 'Formoso/GO';
      5208152: Cidade := 'Gameleira De Goias/GO';
      5208301: Cidade := 'Divinopolis De Goias/GO';
      5208400: Cidade := 'Goianapolis/GO';
      5208509: Cidade := 'Goiandira/GO';
      5208608: Cidade := 'Goianesia/GO';
      5208707: Cidade := 'Goiania/GO';
      5208806: Cidade := 'Goianira/GO';
      5208905: Cidade := 'Goias/GO';
      5209101: Cidade := 'Goiatuba/GO';
      5209150: Cidade := 'Gouvelandia/GO';
      5209200: Cidade := 'Guapo/GO';
      5209291: Cidade := 'Guaraita/GO';
      5209408: Cidade := 'Guarani De Goias/GO';
      5209457: Cidade := 'Guarinos/GO';
      5209606: Cidade := 'Heitorai/GO';
      5209705: Cidade := 'Hidrolandia/GO';
      5209804: Cidade := 'Hidrolina/GO';
      5209903: Cidade := 'Iaciara/GO';
      5209937: Cidade := 'Inaciolandia/GO';
      5209952: Cidade := 'Indiara/GO';
      5210000: Cidade := 'Inhumas/GO';
      5210109: Cidade := 'Ipameri/GO';
      5210158: Cidade := 'Ipiranga De Goias/GO';
      5210208: Cidade := 'Ipora/GO';
      5210307: Cidade := 'Israelandia/GO';
      5210406: Cidade := 'Itaberai/GO';
      5210562: Cidade := 'Itaguari/GO';
      5210604: Cidade := 'Itaguaru/GO';
      5210802: Cidade := 'Itaja/GO';
      5210901: Cidade := 'Itapaci/GO';
      5211008: Cidade := 'Itapirapua/GO';
      5211206: Cidade := 'Itapuranga/GO';
      5211305: Cidade := 'Itaruma/GO';
      5211404: Cidade := 'Itaucu/GO';
      5211503: Cidade := 'Itumbiara/GO';
      5211602: Cidade := 'Ivolandia/GO';
      5211701: Cidade := 'Jandaia/GO';
      5211800: Cidade := 'Jaragua/GO';
      5211909: Cidade := 'Jatai/GO';
      5212006: Cidade := 'Jaupaci/GO';
      5212055: Cidade := 'Jesupolis/GO';
      5212105: Cidade := 'Joviania/GO';
      5212204: Cidade := 'Jussara/GO';
      5212253: Cidade := 'Lagoa Santa/GO';
      5212303: Cidade := 'Leopoldo De Bulhoes/GO';
      5212501: Cidade := 'Luziania/GO';
      5212600: Cidade := 'Mairipotaba/GO';
      5212709: Cidade := 'Mambai/GO';
      5212808: Cidade := 'Mara Rosa/GO';
      5212907: Cidade := 'Marzagao/GO';
      5212956: Cidade := 'Matrincha/GO';
      5213004: Cidade := 'Maurilandia/GO';
      5213053: Cidade := 'Mimoso De Goias/GO';
      5213087: Cidade := 'Minacu/GO';
      5213103: Cidade := 'Mineiros/GO';
      5213400: Cidade := 'Moipora/GO';
      5213509: Cidade := 'Monte Alegre De Goias/GO';
      5213707: Cidade := 'Montes Claros De Goias/GO';
      5213756: Cidade := 'Montividiu/GO';
      5213772: Cidade := 'Montividiu Do Norte/GO';
      5213806: Cidade := 'Morrinhos/GO';
      5213855: Cidade := 'Morro Agudo De Goias/GO';
      5213905: Cidade := 'Mossamedes/GO';
      5214002: Cidade := 'Mozarlandia/GO';
      5214051: Cidade := 'Mundo Novo/GO';
      5214101: Cidade := 'Mutunopolis/GO';
      5214408: Cidade := 'Nazario/GO';
      5214507: Cidade := 'Neropolis/GO';
      5214606: Cidade := 'Niquelandia/GO';
      5214705: Cidade := 'Nova America/GO';
      5214804: Cidade := 'Nova Aurora/GO';
      5214838: Cidade := 'Nova Crixas/GO';
      5214861: Cidade := 'Nova Gloria/GO';
      5214879: Cidade := 'Nova Iguacu De Goias/GO';
      5214903: Cidade := 'Nova Roma/GO';
      5215009: Cidade := 'Nova Veneza/GO';
      5215207: Cidade := 'Novo Brasil/GO';
      5215231: Cidade := 'Novo Gama/GO';
      5215256: Cidade := 'Novo Planalto/GO';
      5215306: Cidade := 'Orizona/GO';
      5215405: Cidade := 'Ouro Verde De Goias/GO';
      5215504: Cidade := 'Ouvidor/GO';
      5215603: Cidade := 'Padre Bernardo/GO';
      5215652: Cidade := 'Palestina De Goias/GO';
      5215702: Cidade := 'Palmeiras De Goias/GO';
      5215801: Cidade := 'Palmelo/GO';
      5215900: Cidade := 'Palminopolis/GO';
      5216007: Cidade := 'Panama/GO';
      5216304: Cidade := 'Paranaiguara/GO';
      5216403: Cidade := 'Parauna/GO';
      5216452: Cidade := 'Perolandia/GO';
      5216809: Cidade := 'Petrolina De Goias/GO';
      5216908: Cidade := 'Pilar De Goias/GO';
      5217104: Cidade := 'Piracanjuba/GO';
      5217203: Cidade := 'Piranhas/GO';
      5217302: Cidade := 'Pirenopolis/GO';
      5217401: Cidade := 'Pires Do Rio/GO';
      5217609: Cidade := 'Planaltina/GO';
      5217708: Cidade := 'Pontalina/GO';
      5218003: Cidade := 'Porangatu/GO';
      5218052: Cidade := 'Porteirao/GO';
      5218102: Cidade := 'Portelandia/GO';
      5218300: Cidade := 'Posse/GO';
      5218391: Cidade := 'Professor Jamil/GO';
      5218508: Cidade := 'Quirinopolis/GO';
      5218607: Cidade := 'Rialma/GO';
      5218706: Cidade := 'Rianapolis/GO';
      5218789: Cidade := 'Rio Quente/GO';
      5218805: Cidade := 'Rio Verde/GO';
      5218904: Cidade := 'Rubiataba/GO';
      5219001: Cidade := 'Sanclerlandia/GO';
      5219100: Cidade := 'Santa Barbara De Goias/GO';
      5219209: Cidade := 'Santa Cruz De Goias/GO';
      5219258: Cidade := 'Santa Fe De Goias/GO';
      5219308: Cidade := 'Santa Helena De Goias/GO';
      5219357: Cidade := 'Santa Isabel/GO';
      5219407: Cidade := 'Santa Rita Do Araguaia/GO';
      5219456: Cidade := 'Santa Rita Do Novo Destino/GO';
      5219506: Cidade := 'Santa Rosa De Goias/GO';
      5219605: Cidade := 'Santa Tereza De Goias/GO';
      5219704: Cidade := 'Santa Terezinha De Goias/GO';
      5219712: Cidade := 'Santo Antonio Da Barra/GO';
      5219738: Cidade := 'Santo Antonio De Goias/GO';
      5219753: Cidade := 'Santo Antonio Do Descoberto/GO';
      5219803: Cidade := 'Sao Domingos/GO';
      5219902: Cidade := 'Sao Francisco De Goias/GO';
      5220009: Cidade := 'Sao Joao D Alianca/GO';
      5220058: Cidade := 'Sao Joao Da Parauna/GO';
      5220108: Cidade := 'Sao Luis De Montes Belos/GO';
      5220157: Cidade := 'Sao Luiz Do Norte/GO';
      5220207: Cidade := 'Sao Miguel Do Araguaia/GO';
      5220264: Cidade := 'Sao Miguel Do Passa Quatro/GO';
      5220280: Cidade := 'Sao Patricio/GO';
      5220405: Cidade := 'Sao Simao/GO';
      5220454: Cidade := 'Senador Canedo/GO';
      5220504: Cidade := 'Serranopolis/GO';
      5220603: Cidade := 'Silvania/GO';
      5220686: Cidade := 'Simolandia/GO';
      5220702: Cidade := 'Sitio D Abadia/GO';
      5221007: Cidade := 'Taquaral De Goias/GO';
      5221080: Cidade := 'Teresina De Goias/GO';
      5221197: Cidade := 'Terezopolis De Goias/GO';
      5221304: Cidade := 'Tres Ranchos/GO';
      5221403: Cidade := 'Trindade/GO';
      5221452: Cidade := 'Trombas/GO';
      5221502: Cidade := 'Turvania/GO';
      5221551: Cidade := 'Turvelandia/GO';
      5221577: Cidade := 'Uirapuru/GO';
      5221601: Cidade := 'Uruacu/GO';
      5221700: Cidade := 'Uruana/GO';
      5221809: Cidade := 'Urutai/GO';
      5221858: Cidade := 'Valparaiso De Goias/GO';
      5221908: Cidade := 'Varjao/GO';
      5222005: Cidade := 'Vianopolis/GO';
      5222054: Cidade := 'Vicentinopolis/GO';
      5222203: Cidade := 'Vila Boa/GO';
      5222302: Cidade := 'Vila Propicio/GO';
   end;
 end;

 procedure P53;
 begin
   case ACodigo of
      5300108: Cidade := 'Brasilia/DF';
   end;
 end;

begin
   Cidade := '';

   if (ACodigo >= 0) and (ACodigo < 1100015) then P00
    else if (ACodigo >= 1100015) and (ACodigo <= 1101807) then P11
    else if (ACodigo >= 1200013) and (ACodigo <= 1200807) then P12
    else if (ACodigo >= 1300029) and (ACodigo <= 1304401) then P13
    else if (ACodigo >= 1400027) and (ACodigo <= 1400704) then P14
    else if (ACodigo >= 1500107) and (ACodigo <= 1508407) then P15
    else if (ACodigo >= 1600055) and (ACodigo <= 1600808) then P16
    else if (ACodigo >= 1700251) and (ACodigo <= 1722107) then P17
    else if (ACodigo >= 2100055) and (ACodigo <= 2114007) then P21
    else if (ACodigo >= 2200053) and (ACodigo <= 2211704) then P22
    else if (ACodigo >= 2300101) and (ACodigo <= 2314102) then P23
    else if (ACodigo >= 2400109) and (ACodigo <= 2415008) then P24
    else if (ACodigo >= 2500106) and (ACodigo <= 2517407) then P25
    else if (ACodigo >= 2600054) and (ACodigo <= 2616506) then P26
    else if (ACodigo >= 2700102) and (ACodigo <= 2709400) then P27
    else if (ACodigo >= 2800100) and (ACodigo <= 2807600) then P28
    else if (ACodigo >= 2900108) and (ACodigo <= 2933604) then P29
    else if (ACodigo >= 3100104) and (ACodigo <= 3172202) then P31
    else if (ACodigo >= 3200102) and (ACodigo <= 3205309) then P32
    else if (ACodigo >= 3300100) and (ACodigo <= 3306305) then P33
    else if (ACodigo >= 3500105) and (ACodigo <= 3557303) then P35
    else if (ACodigo >= 4100103) and (ACodigo <= 4128807) then P41
    else if (ACodigo >= 4200051) and (ACodigo <= 4219853) then P42
    else if (ACodigo >= 4300034) and (ACodigo <= 4323804) then P43
    else if (ACodigo >= 5000203) and (ACodigo <= 5008404) then P50
    else if (ACodigo >= 5100102) and (ACodigo <= 5108956) then P51
    else if (ACodigo >= 5200050) and (ACodigo <= 5222302) then P52
    else P53;

   Result := Cidade;
end;

// Situacao Tribut�ria *********************************************************

function SituacaoTributariaToStr(const t: TnfseSituacaoTributaria):string;
begin
  result := EnumeradoToStr(t,
                           ['1','2','3'],
                           [stRetencao, stNormal, stSubstituicao]);
end;

function StrToSituacaoTributaria(var ok: boolean; const s: string):TnfseSituacaoTributaria;
begin
  result := StrToEnumerado(ok, s,
                           ['1','2','3'],
                           [stRetencao, stNormal, stSubstituicao]);
end;

function ResponsavelRetencaoToStr(const t: TnfseResponsavelRetencao):string;
begin
  result := EnumeradoToStr(t,
                           ['1', '2'],
                           [rtPrestador, ptTomador]);
end;

function StrToResponsavelRetencao(var ok: boolean; const s: string):TnfseResponsavelRetencao;
begin
  result := StrToEnumerado(ok, s,
                           ['1', '2'],
                           [rtPrestador, ptTomador]);
end;

end.

