unit prog0001;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, dxGDIPlusClasses, ExtCtrls, Menus, dxSkinsCore,
  dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom,
  dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSharp, dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinXmas2008Blue, cxLookAndFeels,
  dxSkinsForm, cxGraphics, cxLookAndFeelPainters, StdCtrls, cxButtons, UCBase,
  UCDataConnector, UCUniDACConn, RLConsts, ACBrBase, ACBrDownload, SOAPHTTPClient,
  EWall;

type
  TFormPrincipal = class(TForm)
    menu: TMainMenu;
    Cadastro1: TMenuItem;
    Emrpesa1: TMenuItem;
    Image1: TImage;
    sb: TStatusBar;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    BalloonHint1: TBalloonHint;
    dxSkinController1: TdxSkinController;
    Local1: TMenuItem;
    Entidade1: TMenuItem;
    Itens1: TMenuItem;
    Grupo1: TMenuItem;
    SubGrupo1: TMenuItem;
    Pas1: TMenuItem;
    Municipios1: TMenuItem;
    UnidadedeMedida1: TMenuItem;
    CentrodeCusto1: TMenuItem;
    FormadePagamento1: TMenuItem;
    NaturezadeOperao1: TMenuItem;
    MensagemFiscal1: TMenuItem;
    Srie1: TMenuItem;
    ipodeEntidade1: TMenuItem;
    N1: TMenuItem;
    Sair1: TMenuItem;
    Veculos1: TMenuItem;
    Usurio1: TMenuItem;
    Image6: TImage;
    controle: TUserControl;
    UCUniDACConn1: TUCUniDACConn;
    Utilitrios1: TMenuItem;
    LogOff1: TMenuItem;
    AlterarSenha1: TMenuItem;
    Image7: TImage;
    Label1: TLabel;
    AtualizarSistema1: TMenuItem;
    AtualizarBasedeDados1: TMenuItem;
    ChatOnline1: TMenuItem;
    Label2: TLabel;
    GenerodeProdutos1: TMenuItem;
    Movimento1: TMenuItem;
    Requisies1: TMenuItem;
    EntradaSada1: TMenuItem;
    abeladePreo1: TMenuItem;
    ExtratodeMovimento1: TMenuItem;
    N2: TMenuItem;
    NFe1: TMenuItem;
    Fiscal1: TMenuItem;
    LivrodeEntrada1: TMenuItem;
    LivrodeSada1: TMenuItem;
    ApuraodeICMS1: TMenuItem;
    Sintegra1: TMenuItem;
    SpedFiscal1: TMenuItem;
    SpedPisCofins1: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    ransmisso1: TMenuItem;
    Contingncia1: TMenuItem;
    N6: TMenuItem;
    Inutilizao1: TMenuItem;
    CartadeCorreo1: TMenuItem;
    Relatrios1: TMenuItem;
    Entidades1: TMenuItem;
    SituaodoEstoque1: TMenuItem;
    SaldodeEstoque1: TMenuItem;
    Requisies2: TMenuItem;
    ExtratodeMovimento2: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    NFe2: TMenuItem;
    Entradas1: TMenuItem;
    EntradaxSada1: TMenuItem;
    Produtos1: TMenuItem;
    Cidades1: TMenuItem;
    abeladePreo2: TMenuItem;
    Parametros1: TMenuItem;
    Financeiro1: TMenuItem;
    CAP1: TMenuItem;
    CAR1: TMenuItem;
    download: TACBrDownload;
    Button1: TButton;
    itulosaPagar1: TMenuItem;
    itulosaReceber1: TMenuItem;
    BaixaTitulos1: TMenuItem;
    BaixaTitulos2: TMenuItem;
    Confronto1: TMenuItem;
    Memo1: TMemo;
    LogOff2: TMenuItem;
    Sobre1: TMenuItem;
    AjusteICMS1: TMenuItem;
    N11: TMenuItem;
    procedure Image3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure Pas1Click(Sender: TObject);
    procedure Grupo1Click(Sender: TObject);
    procedure SubGrupo1Click(Sender: TObject);
    procedure CentrodeCusto1Click(Sender: TObject);
    procedure Municipios1Click(Sender: TObject);
    procedure FormadePagamento1Click(Sender: TObject);
    procedure ipodeEntidade1Click(Sender: TObject);
    procedure Srie1Click(Sender: TObject);
    procedure UnidadedeMedida1Click(Sender: TObject);
    procedure MensagemFiscal1Click(Sender: TObject);
    procedure NaturezadeOperao1Click(Sender: TObject);
    procedure GenerodeProdutos1Click(Sender: TObject);
    procedure Itens1Click(Sender: TObject);
    procedure Emrpesa1Click(Sender: TObject);
    procedure Requisies1Click(Sender: TObject);
    procedure EntradaSada1Click(Sender: TObject);
    procedure Entidade1Click(Sender: TObject);
    procedure Veculos1Click(Sender: TObject);
    procedure abeladePreo1Click(Sender: TObject);
    procedure ExtratodeMovimento1Click(Sender: TObject);
    procedure ransmisso1Click(Sender: TObject);
    procedure Inutilizao1Click(Sender: TObject);
    procedure CartadeCorreo1Click(Sender: TObject);
    procedure Contingncia1Click(Sender: TObject);
    procedure Entidades1Click(Sender: TObject);
    procedure Produtos1Click(Sender: TObject);
    procedure Cidades1Click(Sender: TObject);
    procedure abeladePreo2Click(Sender: TObject);
    procedure AtualizarBasedeDados1Click(Sender: TObject);
    procedure Parametros1Click(Sender: TObject);
    procedure ExtratodeMovimento2Click(Sender: TObject);
    procedure Image5Click(Sender: TObject);
    procedure EntradaxSada1Click(Sender: TObject);
    procedure SituaodoEstoque1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure itulosaPagar1Click(Sender: TObject);
    procedure itulosaReceber1Click(Sender: TObject);
    procedure ApuraodeICMS1Click(Sender: TObject);
  private
    { Private declarations }
  public
    puempresa,
    pulocal : integer;
    puLogiUsuario,
    puNomeUsuario : string;
    puNomeEmpresa : string;
  end;

var
  FormPrincipal: TFormPrincipal;

implementation

uses prog0002, prog0003, rotinas, prog0005, prog0006, prog0007, prog0008,
     prog0009, prog0010, prog0011, prog0012, prog0013, prog0014, prog0015,
  prog0016, prog0018, prog0017, prog0019, prog0020, prog0021, prog0022,
  prog0023, prog0024, prog0025, prog0027, prog0028, prog0029, prog0030,
  prog0031, prog0032, prog0033, prog0034, prog0035, prog0154, prog0036,
  prog0037, prog0038, prog0039, ILiberacaoInicial1, prog0041, prog0042,
  prog0043;

{$R *.dfm}

procedure TFormPrincipal.abeladePreo1Click(Sender: TObject);
begin
  criaform(tFormTabelaPreco, FormTabelaPreco);
end;

procedure TFormPrincipal.abeladePreo2Click(Sender: TObject);
begin
  criaform(TFormRelTabelaPreco, FormRelTabelaPreco);
end;

procedure TFormPrincipal.ApuraodeICMS1Click(Sender: TObject);
begin
  criaform(TFormApuracaoIcms, FormApuracaoIcms);
end;

procedure TFormPrincipal.AtualizarBasedeDados1Click(Sender: TObject);
begin
  FormAtualizaBanco   := TFormAtualizaBanco.Create(Application);
  FormAtualizaBanco.ShowModal;
  FormAtualizaBanco.Free;
end;

procedure TFormPrincipal.Button1Click(Sender: TObject);
var
 op : ILiberacaoInicial;
 rio: THTTPRIO;
begin
   RIO := THTTPRIO.Create(nil);
   RIO.WSDLLocation := '';
   op:= GetILiberacaoInicial(false,'',rio);
   if op.liberacao(dmDados.tbEmpr.FieldByName('empr_cnpj').asstring) then
     showmessage('Liberado Para: '+op.registrado)
   else
     showmessage('Não Liberado');
end;

procedure TFormPrincipal.CartadeCorreo1Click(Sender: TObject);
begin
  CriaForm(tFormCartaCorrecao, FormCartaCorrecao);
end;

procedure TFormPrincipal.CentrodeCusto1Click(Sender: TObject);
begin
  criaform(TFormCentroCusto, FormCentroCusto);
end;

procedure TFormPrincipal.Cidades1Click(Sender: TObject);
begin
  criaform(TFormRelCidade, FormRelCidade);
end;

procedure TFormPrincipal.Contingncia1Click(Sender: TObject);
begin
  CriaForm(TFormContingencia, FormContingencia);
end;

procedure TFormPrincipal.Emrpesa1Click(Sender: TObject);
begin
  criaform(TFormCadEmpresa, FormCadEmpresa);
end;

procedure TFormPrincipal.Entidade1Click(Sender: TObject);
begin
  CriaForm(tFormCadEntidade, FormCadEntidade);
end;

procedure TFormPrincipal.Entidades1Click(Sender: TObject);
begin
  CriaForm(TFormRelEntidade, FormRelEntidade);
end;

procedure TFormPrincipal.EntradaSada1Click(Sender: TObject);
begin
  criaform(tFormEntrSaid, FormEntrSaid);
end;

procedure TFormPrincipal.EntradaxSada1Click(Sender: TObject);
begin
  criaform(TFormRelEntradaSaida, FormRelEntradaSaida);
end;

procedure TFormPrincipal.ExtratodeMovimento1Click(Sender: TObject);
begin
  criaform(TFormExtratoMovimento, FormExtratoMovimento);
end;

procedure TFormPrincipal.ExtratodeMovimento2Click(Sender: TObject);
begin
  criaform(TFormRelExtratoMovimento, FormRelExtratoMovimento);
end;

procedure TFormPrincipal.FormadePagamento1Click(Sender: TObject);
begin
  criaform(TFormFormaPagamento, FormFormaPagamento);
end;

procedure TFormPrincipal.FormCreate(Sender: TObject);
begin
 // formprincipal.controle.Execute;
end;

procedure TFormPrincipal.FormShow(Sender: TObject);
begin
  puempresa:= 1;
  pulocal:= 1;
  ConfigNFe;
  WindowState:= wsMaximized;
  with dmdados.tbEmpr do
   begin
     Close;
     ParamByName('codi').AsInteger:= puempresa;
     Open;
   end;
  puNomeEmpresa:= dmdados.tbempr.FieldByName('empr_raza').AsString;

  with dmDados.quPara do
   begin
     Close;
     ParamByName('empr').AsInteger:= puempresa;
     ParamByName('loca').AsInteger:= pulocal;
     Open;
   end;

  FormAtualizaBanco   := TFormAtualizaBanco.Create(Application);
  if strtointdef(formatualizabanco.cxTextEditAtual.Text,0) <> strtointdef(formatualizabanco.cxTextEditInstalada.Text,0) then
  begin
     FormAtualizaBanco.ShowModal;
     FormAtualizaBanco.Free;
  end
  else
  begin
     FormAtualizaBanco.Free;
  end;

end;

procedure TFormPrincipal.GenerodeProdutos1Click(Sender: TObject);
begin
  criaform(Tformgenero, formgenero);
end;

procedure TFormPrincipal.Grupo1Click(Sender: TObject);
begin
  criaform(tFormCadGrupo, FormCadGrupo);
end;

procedure TFormPrincipal.Image3Click(Sender: TObject);
begin
  application.Terminate;
end;

procedure TFormPrincipal.Image4Click(Sender: TObject);
begin
  criaform(tformatendimento, formatendimento);
end;

procedure TFormPrincipal.Image5Click(Sender: TObject);
begin
  if MessageDlg('Confirma Atualização do Sistema ?',  mtConfirmation, [mbYes, mbNo], 0) = mrYes then
   begin
     with download do
      begin
        DownloadDest    := ExtractFilePath(Application.ExeName);
        DownloadUrl     := dmdados.quPara.FieldByName('para_link').AsString;
        if dmdados.quPara.FieldByName('para_form_down').AsString = 'HTTP' then
         begin
           Protocolo       := protHTTP;
           Proxy.ProxyHost := dmdados.quPara.FieldByName('para_prox').AsString;
           Proxy.ProxyUser := dmdados.quPara.FieldByName('para_usua').AsString;
           Proxy.ProxyPass := dmdados.quPara.FieldByName('para_senh').AsString;
           Proxy.ProxyPort := dmdados.quPara.FieldByName('para_port').AsString;
         end else
          begin
            Protocolo       := protFTP;
            FTP.FtpHost := dmdados.quPara.FieldByName('para_prox').AsString;
            FTP.FtpUser := dmdados.quPara.FieldByName('para_usua').AsString;
            FTP.FtpPass := dmdados.quPara.FieldByName('para_senh').AsString;
            FTP.FtpPort := dmdados.quPara.FieldByName('para_port').AsString;
          end;
        try
          RenameFile(ExtractFilePath(Application.ExeName)+'wmf.exe',ExtractFilePath(Application.ExeName)+'wmf.ant');
          StartDownload;
        except
          on E: Exception do
          begin
            RenameFile(ExtractFilePath(Application.ExeName)+'wmf.ant',ExtractFilePath(Application.ExeName)+'wmf.exe');
            ShowMessage('Não foi possivel completar a atualização, favor entrar em contato com o suporte');
            Exit;
          end;
        end;
        ShowMessage('Atualização concluída com sucesso');
      end;
   end;
end;

procedure TFormPrincipal.Inutilizao1Click(Sender: TObject);
begin
  criaform(TFormInutilizar, FormInutilizar);
end;

procedure TFormPrincipal.ipodeEntidade1Click(Sender: TObject);
begin
  criaform(tFormCadTipoEntidade, FormCadTipoEntidade);
end;

procedure TFormPrincipal.Itens1Click(Sender: TObject);
begin
  CriaForm(TFormCadProdutos, FormCadProdutos);
end;

procedure TFormPrincipal.itulosaPagar1Click(Sender: TObject);
begin
  criaform(TFormConsultaPagar, FormConsultaPagar);
end;

procedure TFormPrincipal.itulosaReceber1Click(Sender: TObject);
begin
  criaform(TFormConsultaReceber, FormConsultaReceber);
end;

procedure TFormPrincipal.MensagemFiscal1Click(Sender: TObject);
begin
  criaform(TFormMensagem, FormMensagem);
end;

procedure TFormPrincipal.Municipios1Click(Sender: TObject);
begin
  criaform(TFormCidade, FormCidade);
end;

procedure TFormPrincipal.NaturezadeOperao1Click(Sender: TObject);
begin
  criaform(tFormNaturezaOperacao, FormNaturezaOperacao);
end;

procedure TFormPrincipal.Parametros1Click(Sender: TObject);
begin
  criaform(TFormParametro, FormParametro);
end;

procedure TFormPrincipal.Pas1Click(Sender: TObject);
begin
  criaform(TFormCadPais,FormCadPais);
end;

procedure TFormPrincipal.Produtos1Click(Sender: TObject);
begin
  criaform(TFormRelProduto, FormRelProduto);
end;

procedure TFormPrincipal.ransmisso1Click(Sender: TObject);
begin
  criaform(TFormEmissaoNFe, FormEmissaoNFe);
end;

procedure TFormPrincipal.Requisies1Click(Sender: TObject);
begin
  CriaForm(tFormRequisicao, FormRequisicao);
end;

procedure TFormPrincipal.SituaodoEstoque1Click(Sender: TObject);
begin
  criaform(TFormSituacaoEstoque, FormSituacaoEstoque);
end;

procedure TFormPrincipal.Srie1Click(Sender: TObject);
begin
  criaform(TFormCadSerie, FormCadSerie);
end;

procedure TFormPrincipal.SubGrupo1Click(Sender: TObject);
begin
  criaform(TFormCadSubGrupo, FormCadSubGrupo);
end;

procedure TFormPrincipal.UnidadedeMedida1Click(Sender: TObject);
begin
  criaform(TFormUnidadeMedida, FormUnidadeMedida);
end;

procedure TFormPrincipal.Veculos1Click(Sender: TObject);
begin
  criaform(TFormCadVeiculos, FormCadVeiculos);
end;

initialization
  RLConsts.SetVersion(3,71,'B');
end.
