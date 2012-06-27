unit prog0043;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, Menus, ImgList, UCBase, ACBrBase, ACBrEnterTab, StdCtrls,
  cxButtons, cxPC, ComCtrls, dxGDIPlusClasses, ExtCtrls, cxLabel, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, DB, cxDBData, cxCurrencyEdit,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxGridCustomView, cxGrid, cxCheckBox, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxCalendar, MemDS, DBAccess, Uni, RLReport;

type
  TFormApuracaoIcms = class(TForm)
    lbTitu: TcxLabel;
    Image1: TImage;
    sb: TStatusBar;
    cxTabControl1: TcxTabControl;
    btnFechar: TcxButton;
    ACBrEnterTab1: TACBrEnterTab;
    controle: TUCControls;
    imagem: TImageList;
    cxTabControl2: TcxTabControl;
    btnExecuta: TcxButton;
    cxPageControl1: TcxPageControl;
    cxTabSheet1: TcxTabSheet;
    cxTabSheet2: TcxTabSheet;
    cxTabSheet3: TcxTabSheet;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1Column1: TcxGridDBColumn;
    cxGrid1DBTableView1Column2: TcxGridDBColumn;
    cxGrid1DBTableView1Column3: TcxGridDBColumn;
    cxGrid1DBTableView1Column4: TcxGridDBColumn;
    cxGrid1DBTableView1Column5: TcxGridDBColumn;
    cxGrid1DBTableView1Column6: TcxGridDBColumn;
    cxGrid1DBTableView1Column7: TcxGridDBColumn;
    cxGrid1DBTableView1Column8: TcxGridDBColumn;
    cxGrid1DBTableView1Column9: TcxGridDBColumn;
    cxGrid1DBTableView1Column10: TcxGridDBColumn;
    cxGrid2: TcxGrid;
    cxGridDBTableView1: TcxGridDBTableView;
    cxGridDBColumn1: TcxGridDBColumn;
    cxGridDBColumn2: TcxGridDBColumn;
    cxGridDBColumn3: TcxGridDBColumn;
    cxGridDBColumn4: TcxGridDBColumn;
    cxGridDBColumn5: TcxGridDBColumn;
    cxGridDBColumn6: TcxGridDBColumn;
    cxGridDBColumn7: TcxGridDBColumn;
    cxGridDBColumn8: TcxGridDBColumn;
    cxGridDBColumn9: TcxGridDBColumn;
    cxGridDBColumn10: TcxGridDBColumn;
    cxGridLevel1: TcxGridLevel;
    cxLabel3: TcxLabel;
    edMesAno: TcxTextEdit;
    cxLabel4: TcxLabel;
    edSaldo: TcxCurrencyEdit;
    cxTabSheet4: TcxTabSheet;
    cxTabSheet5: TcxTabSheet;
    cxGrid3: TcxGrid;
    cxGridDBTableView2: TcxGridDBTableView;
    cxGridDBColumn12: TcxGridDBColumn;
    cxGridDBColumn13: TcxGridDBColumn;
    cxGridDBColumn14: TcxGridDBColumn;
    cxGridDBColumn15: TcxGridDBColumn;
    cxGridDBColumn16: TcxGridDBColumn;
    cxGridDBColumn17: TcxGridDBColumn;
    cxGridDBColumn18: TcxGridDBColumn;
    cxGridDBColumn19: TcxGridDBColumn;
    cxGridDBColumn20: TcxGridDBColumn;
    cxGridLevel2: TcxGridLevel;
    cxGrid4: TcxGrid;
    cxGridDBTableView3: TcxGridDBTableView;
    cxGridDBColumn22: TcxGridDBColumn;
    cxGridDBColumn23: TcxGridDBColumn;
    cxGridDBColumn24: TcxGridDBColumn;
    cxGridDBColumn25: TcxGridDBColumn;
    cxGridDBColumn26: TcxGridDBColumn;
    cxGridDBColumn27: TcxGridDBColumn;
    cxGridDBColumn28: TcxGridDBColumn;
    cxGridDBColumn29: TcxGridDBColumn;
    cxGridDBColumn30: TcxGridDBColumn;
    cxGridLevel3: TcxGridLevel;
    dsEntrAnal: TUniDataSource;
    dsSaidAnal: TUniDataSource;
    quEntrAnal: TUniQuery;
    quSaidAnal: TUniQuery;
    quSaidSint: TUniQuery;
    dsSaidSint: TUniDataSource;
    quEntrSint: TUniQuery;
    dsEntrSint: TUniDataSource;
    Label1: TLabel;
    vl_tot_debitos: TcxCurrencyEdit;
    vl_aj_debitos: TcxCurrencyEdit;
    Label2: TLabel;
    vl_tot_aj_debitos: TcxCurrencyEdit;
    Label4: TLabel;
    vl_estornos_cred: TcxCurrencyEdit;
    Label5: TLabel;
    vl_tot_creditos: TcxCurrencyEdit;
    Label6: TLabel;
    vl_aj_creditos: TcxCurrencyEdit;
    Label7: TLabel;
    vl_tot_aj_creditos: TcxCurrencyEdit;
    Label8: TLabel;
    vl_estornos_deb: TcxCurrencyEdit;
    Label9: TLabel;
    vl_sld_credor_ant: TcxCurrencyEdit;
    Label10: TLabel;
    vl_sld_apurado: TcxCurrencyEdit;
    Label11: TLabel;
    vl_tot_ded: TcxCurrencyEdit;
    Label12: TLabel;
    vl_icms_recolher: TcxCurrencyEdit;
    Label13: TLabel;
    vl_sld_credor_transportar: TcxCurrencyEdit;
    Label14: TLabel;
    deb_esp: TcxCurrencyEdit;
    Label15: TLabel;
    sqlaux: TUniQuery;
    quApur: TUniQuery;
    RLReport1: TRLReport;
    RLBand1: TRLBand;
    RLLabel1: TRLLabel;
    rlLogo: TRLImage;
    RLSystemInfo1: TRLSystemInfo;
    RLSystemInfo2: TRLSystemInfo;
    RLLabel2: TRLLabel;
    rltituentr: TRLLabel;
    RLGroup1: TRLGroup;
    RLBand2: TRLBand;
    RLLabel5: TRLLabel;
    RLLabel6: TRLLabel;
    RLLabel7: TRLLabel;
    RLLabel8: TRLLabel;
    RLBand4: TRLBand;
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    RLDBText5: TRLDBText;
    RLBand3: TRLBand;
    RLLabel4: TRLLabel;
    rlEmpresa: TRLLabel;
    RLLabel3: TRLLabel;
    RLLabel10: TRLLabel;
    RLLabel11: TRLLabel;
    RLLabel9: TRLLabel;
    RLDBText6: TRLDBText;
    RLDBText7: TRLDBText;
    RLDBText8: TRLDBText;
    RLBand5: TRLBand;
    RLDBResult1: TRLDBResult;
    RLDBResult2: TRLDBResult;
    RLDBResult3: TRLDBResult;
    RLDBResult4: TRLDBResult;
    RLDBResult5: TRLDBResult;
    RLDBResult6: TRLDBResult;
    btnImprimir: TcxButton;
    RLLabel12: TRLLabel;
    RLReport2: TRLReport;
    RLBand6: TRLBand;
    RLLabel13: TRLLabel;
    rllogo1: TRLImage;
    RLSystemInfo3: TRLSystemInfo;
    RLSystemInfo4: TRLSystemInfo;
    RLLabel14: TRLLabel;
    rltitusaid: TRLLabel;
    RLGroup2: TRLGroup;
    RLBand7: TRLBand;
    RLLabel16: TRLLabel;
    RLLabel17: TRLLabel;
    RLLabel18: TRLLabel;
    RLLabel19: TRLLabel;
    RLLabel20: TRLLabel;
    RLLabel21: TRLLabel;
    RLLabel22: TRLLabel;
    RLLabel23: TRLLabel;
    RLBand8: TRLBand;
    RLDBText9: TRLDBText;
    RLDBText10: TRLDBText;
    RLDBText11: TRLDBText;
    RLDBText12: TRLDBText;
    RLDBText13: TRLDBText;
    RLDBText14: TRLDBText;
    RLDBText15: TRLDBText;
    RLDBText16: TRLDBText;
    RLBand9: TRLBand;
    RLDBResult7: TRLDBResult;
    RLDBResult8: TRLDBResult;
    RLDBResult9: TRLDBResult;
    RLDBResult10: TRLDBResult;
    RLDBResult11: TRLDBResult;
    RLDBResult12: TRLDBResult;
    RLLabel24: TRLLabel;
    RLBand10: TRLBand;
    RLLabel25: TRLLabel;
    rlempresa1: TRLLabel;
    RLReport3: TRLReport;
    RLBand11: TRLBand;
    RLLabel15: TRLLabel;
    rllogo2: TRLImage;
    RLSystemInfo5: TRLSystemInfo;
    RLSystemInfo6: TRLSystemInfo;
    RLLabel26: TRLLabel;
    rltituapur: TRLLabel;
    RLBand15: TRLBand;
    RLLabel37: TRLLabel;
    rlempresa2: TRLLabel;
    RLDraw14: TRLDraw;
    RLLabel30: TRLLabel;
    RLDraw13: TRLDraw;
    RLLabel29: TRLLabel;
    RLLabel28: TRLLabel;
    RLDraw12: TRLDraw;
    RLDraw11: TRLDraw;
    RLLabel31: TRLLabel;
    RLDraw10: TRLDraw;
    RLLabel32: TRLLabel;
    RLDraw9: TRLDraw;
    RLLabel33: TRLLabel;
    RLDraw8: TRLDraw;
    RLLabel34: TRLLabel;
    RLDraw7: TRLDraw;
    RLLabel35: TRLLabel;
    RLDraw6: TRLDraw;
    RLLabel36: TRLLabel;
    RLDraw5: TRLDraw;
    RLLabel39: TRLLabel;
    RLDraw4: TRLDraw;
    RLLabel40: TRLLabel;
    RLDraw3: TRLDraw;
    RLLabel41: TRLLabel;
    RLDraw2: TRLDraw;
    RLLabel42: TRLLabel;
    RLDraw1: TRLDraw;
    RLLabel43: TRLLabel;
    rlTotaDebi: TRLLabel;
    rlAjusDebiFisc: TRLLabel;
    rlEstoCred: TRLLabel;
    rlAjusDebi: TRLLabel;
    rlAjusEstoDebi: TRLLabel;
    rlAjusCred: TRLLabel;
    rlAjusCredDeco: TRLLabel;
    rlTotaAjusCred: TRLLabel;
    rlTotaSaldTran: TRLLabel;
    rlTotaReco: TRLLabel;
    rlTotaDedu: TRLLabel;
    rlSaldDeve: TRLLabel;
    rlSaldCredAnte: TRLLabel;
    rlValorReco: TRLLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnFecharClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnExecutaClick(Sender: TObject);
    procedure edMesAnoExit(Sender: TObject);
    procedure RLReport1BeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure btnImprimirClick(Sender: TObject);
    procedure RLDBText3BeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure RLDBText30BeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormApuracaoIcms: TFormApuracaoIcms;

implementation

uses prog0003, prog0001, rotinas;

{$R *.dfm}

procedure TFormApuracaoIcms.btnExecutaClick(Sender: TObject);
var
 v_tota_creditos,
 v_tota_debitos,
 v_saldo_transportar,
 v_saldo_mes_anterior : real;
begin
  v_tota_creditos:= 0;
  v_tota_debitos:= 0;
  v_saldo_transportar:= 0;
  v_saldo_mes_anterior:= 0;

  // entrada analitica
  quentranal.close;
  quentranal.sql.text:= 'select * from fiscal.vw_apur_entr_anal where imov_empr = :empr '+
                        'and mes = :mes and ano = :ano';
  quentranal.parambyname('empr').asinteger:= formprincipal.puempresa;
  quentranal.parambyname('mes').asstring  := copy(edmesano.text,1,2);
  quentranal.parambyname('ano').asstring  := copy(edmesano.text,3,4);
  quentranal.open;

  // saida analitica
  qusaidanal.close;
  qusaidanal.sql.text:= 'select * from fiscal.vw_apur_said_anal where imov_empr = :empr '+
                        'and mes = :mes and ano = :ano';
  qusaidanal.parambyname('empr').asinteger:= formprincipal.puempresa;
  qusaidanal.parambyname('mes').asstring  := copy(edmesano.text,1,2);
  qusaidanal.parambyname('ano').asstring  := copy(edmesano.text,3,4);
  qusaidanal.open;

  // entrada sintetica
  quentrsint.close;
  quentrsint.sql.text:= 'select * from fiscal.vw_apur_entr_sint where imov_empr = :empr '+
                        'and mes = :mes and ano = :ano';
  quentrsint.parambyname('empr').asinteger:= formprincipal.puempresa;
  quentrsint.parambyname('mes').asstring  := copy(edmesano.text,1,2);
  quentrsint.parambyname('ano').asstring  := copy(edmesano.text,3,4);
  quentrsint.open;

  // saida sintetica
  qusaidsint.close;
  qusaidsint.sql.text:= 'select * from fiscal.vw_apur_said_sint where imov_empr = :empr '+
                        'and mes = :mes and ano = :ano';
  qusaidsint.parambyname('empr').asinteger:= formprincipal.puempresa;
  qusaidsint.parambyname('mes').asstring  := copy(edmesano.text,1,2);
  qusaidsint.parambyname('ano').asstring  := copy(edmesano.text,3,4);
  qusaidsint.open;

  // processa débitos
  sqlaux.close;
  sqlaux.sql.text:= 'select sum(valo_icms) as "icms" from fiscal.vw_apur_said_anal where '+
                    'imov_empr = :empr and mes = :mes and ano = :ano';
  sqlaux.parambyname('empr').asinteger:= formprincipal.puempresa;
  sqlaux.parambyname('mes').asstring  := copy(edmesano.text,1,2);
  sqlaux.parambyname('ano').asstring  := copy(edmesano.text,3,4);
  sqlaux.open;
  vl_tot_debitos.value:= sqlaux.fieldbyname('icms').asfloat;

  // processa créditos
  sqlaux.close;
  sqlaux.sql.text:= 'select sum(valo_icms) as "icms" from fiscal.vw_apur_entr_anal where '+
                    'imov_empr = :empr and mes = :mes and ano = :ano';
  sqlaux.parambyname('empr').asinteger:= formprincipal.puempresa;
  sqlaux.parambyname('mes').asstring  := copy(edmesano.text,1,2);
  sqlaux.parambyname('ano').asstring  := copy(edmesano.text,3,4);
  sqlaux.open;
  vl_tot_creditos.value:= sqlaux.fieldbyname('icms').asfloat;

  // abre tabela de apuração de icms
  quapur.close;
  quapur.parambyname('empr').asinteger:= formprincipal.puempresa;
  quapur.parambyname('loca').asinteger:= formprincipal.pulocal;
  quapur.parambyname('refe').asstring := edmesano.text;
  quapur.open;

  // analisa saldo mes anterior
  sqlaux.close;
  sqlaux.sql.text:= 'select apur_icms_sald_cred from fiscal.apur where apur_empr = :empr '+
                    'and apur_loca = :loca and apur_refe = :refe';
  sqlaux.parambyname('empr').asinteger:= formprincipal.puempresa;
  sqlaux.parambyname('loca').asinteger:= formprincipal.pulocal;
  sqlaux.parambyname('refe').asstring := formatfloat('00',strtofloat(copy(edmesano.text,1,2))-1)+copy(edmesano.text,3,4);
  sqlaux.open;
  vl_sld_credor_ant.value:= sqlaux.fieldbyname('apur_icms_sald_cred').asfloat;

  // analisa saldo a transportar mes seguinte
  v_tota_creditos:= (vl_tot_creditos.value + vl_aj_creditos.value + vl_tot_aj_creditos.value + vl_sld_credor_ant.value);
  v_tota_debitos := (vl_aj_debitos.value + vl_tot_aj_debitos.value + vl_tot_debitos.value);
  vl_sld_credor_transportar.value:= 0;

  if v_tota_creditos > v_tota_debitos then
  begin
    // transporta mes que vem
    if (v_tota_creditos - v_tota_debitos) > 0 then
     begin
       vl_sld_credor_transportar.value:= v_tota_creditos - v_tota_debitos;
       if quapur.isempty then
        begin
          quapur.append;
          quapur.fieldbyname('apur_empr').asinteger:= formprincipal.puempresa;
          quapur.fieldbyname('apur_loca').asinteger:= formprincipal.pulocal;
          quapur.fieldbyname('apur_refe').asstring := edmesano.text;
          quapur.fieldbyname('apur_icms_sald_cred').asfloat:= vl_sld_credor_transportar.value;
          quapur.post;
          quapur.applyupdates;
        end else
         begin
           quapur.edit;
           quapur.fieldbyname('apur_icms_sald_cred').asfloat:= vl_sld_credor_transportar.value;
           quapur.post;
           quapur.applyupdates;
         end;
     end;
    vl_icms_recolher.value:= 0;
  end else
   begin
     vl_icms_recolher.value:= v_tota_debitos - v_tota_creditos;
     vl_sld_apurado.value := vl_icms_recolher.value;
   end;
end;

procedure TFormApuracaoIcms.btnFecharClick(Sender: TObject);
begin
  close;
end;

procedure TFormApuracaoIcms.btnImprimirClick(Sender: TObject);
begin
  imprimir(rlreport1,rlband4);
end;

procedure TFormApuracaoIcms.edMesAnoExit(Sender: TObject);
begin
  btnexecuta.setfocus;
end;

procedure TFormApuracaoIcms.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action:= cafree;
  FormApuracaoIcms:= nil;
end;

procedure TFormApuracaoIcms.FormShow(Sender: TObject);
begin
  cxpagecontrol1.activepageindex:= 0;
  edmesano.setfocus;

  sqlaux.Close;
  sqlaux.sql.Text:= 'select empr_raza, empr_logo from cadastro.empr where empr_codi = :codi';
  sqlaux.ParamByName('codi').AsInteger:= FormPrincipal.puempresa;
  sqlaux.Open;

  rlEmpresa.Caption:= sqlaux.FieldByName('empr_raza').AsString;
  rlLogo.Picture.LoadFromFile(sqlaux.FieldByName('empr_logo').AsString);
  rlEmpresa1.Caption:= sqlaux.FieldByName('empr_raza').AsString;
  rlLogo1.Picture.LoadFromFile(sqlaux.FieldByName('empr_logo').AsString);
  rlEmpresa2.Caption:= sqlaux.FieldByName('empr_raza').AsString;
  rlLogo2.Picture.LoadFromFile(sqlaux.FieldByName('empr_logo').AsString);
end;

procedure TFormApuracaoIcms.RLDBText30BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  text:= formatcurr('###,###,##0.00', strtofloatdef(text,0));
end;

procedure TFormApuracaoIcms.RLDBText3BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  text:= formatcurr('###,###,##0.00', strtofloatdef(text,0));
end;

procedure TFormApuracaoIcms.RLReport1BeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  rltituentr.caption:= 'Ref.: '+edmesano.text;
  rltitusaid.caption:= 'Ref.: '+edmesano.text;
  rltituapur.caption:= 'Ref.: '+edmesano.text;

  rlTotaDebi.caption     := vl_tot_debitos.Text;
  rlajusdebifisc.caption := vl_aj_debitos.text;
  rlajusdebi.caption     := vl_tot_aj_debitos.text;
  rlestocred.caption     := vl_estornos_cred.text;
  rltotaajuscred.caption := vl_tot_creditos.text;
  rlajuscreddeco.caption := vl_aj_creditos.text;
  rlajuscred.caption     := vl_tot_aj_creditos.text;
  rlajusestodebi.caption := vl_estornos_deb.text;
  rlsaldcredante.caption := vl_sld_credor_ant.text;
  rlsalddeve.caption     := vl_sld_apurado.text;
  rltotadedu.caption     := vl_tot_ded.text;
  rltotareco.caption     := vl_icms_recolher.text;
  rltotasaldtran.caption := vl_sld_credor_transportar.text;
  rlvalorreco.caption    := deb_esp.text;
end;

end.
