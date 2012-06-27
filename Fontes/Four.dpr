program Four;

uses
  Forms,
  prog0001 in 'prog0001.pas' {FormPrincipal},
  prog0003 in 'prog0003.pas' {dmDados: TDataModule},
  prog0004 in 'prog0004.pas' {FormConsulta},
  rotinas in 'rotinas.pas',
  prog0005 in 'prog0005.pas' {FormAtendimento},
  prog0006 in 'prog0006.pas' {FormCadPais},
  prog0007 in 'prog0007.pas' {FormCadGrupo},
  prog0008 in 'prog0008.pas' {FormCadSubGrupo},
  prog0009 in 'prog0009.pas' {FormCentroCusto},
  prog0010 in 'prog0010.pas' {FormCidade},
  prog0011 in 'prog0011.pas' {FormFormaPagamento},
  prog0012 in 'prog0012.pas' {FormCadTipoEntidade},
  prog0013 in 'prog0013.pas' {FormCadSerie},
  prog0014 in 'prog0014.pas' {FormUnidadeMedida},
  prog0015 in 'prog0015.pas' {FormMensagem},
  prog0016 in 'prog0016.pas' {FormNaturezaOperacao},
  prog0017 in 'prog0017.pas' {FormCadProdutos},
  prog0018 in 'prog0018.pas' {FormGenero},
  prog0019 in 'prog0019.pas' {FormCadEmpresa},
  prog0020 in 'prog0020.pas' {FormRequisicao},
  prog0021 in 'prog0021.pas' {FormEntrSaid},
  prog0022 in 'prog0022.pas' {FormCadEntidade},
  UClsCalcNF in 'UClsCalcNF.pas',
  prog0023 in 'prog0023.pas' {FormCadVeiculos},
  prog0024 in 'prog0024.pas' {FormTabelaPreco},
  prog0025 in 'prog0025.pas' {FormExtratoMovimento},
  prog0026 in 'prog0026.pas' {FormRelatorio},
  prog0027 in 'prog0027.pas' {FormEmissaoNFe},
  ufrmStatus in 'ufrmStatus.pas' {frmStatus},
  prog0029 in 'prog0029.pas' {FormCartaCorrecao},
  prog0028 in 'prog0028.pas' {FormInutilizar},
  prog0030 in 'prog0030.pas' {FormContingencia},
  prog0032 in 'prog0032.pas' {FormRelEntidade},
  prog0034 in 'prog0034.pas' {FormRelCidade},
  prog0035 in 'prog0035.pas' {FormRelTabelaPreco},
  prog0031 in 'prog0031.pas' {FormRelPadrao},
  prog0154 in 'prog0154.pas' {FormAtualizaBanco},
  DMScript in 'DMScript.pas' {DMScriptAtualizacao: TDataModule},
  prog0036 in 'prog0036.pas' {FormParametro},
  prog0037 in 'prog0037.pas' {FormRelExtratoMovimento},
  prog0039 in 'prog0039.pas' {FormSituacaoEstoque},
  prog0038 in 'prog0038.pas' {FormRelEntradaSaida},
  superobject in 'superobject.pas',
  prog0040 in 'prog0040.pas' {FormCaptcha},
  ILiberacaoInicial1 in 'ILiberacaoInicial1.pas',
  prog0042 in 'prog0042.pas' {FormConsultaReceber},
  prog0041 in 'prog0041.pas' {FormConsultaPagar},
  prog0043 in 'prog0043.pas' {FormApuracaoIcms},
  prog0044 in 'prog0044.pas' {FormLivroEntrada};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Four';
  Application.CreateForm(TdmDados, dmDados);
  Application.CreateForm(TFormPrincipal, FormPrincipal);
  Application.CreateForm(TDMScriptAtualizacao, DMScriptAtualizacao);
  Application.Run;
end.
