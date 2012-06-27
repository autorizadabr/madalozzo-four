unit prog0021;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, dxGDIPlusClasses, ExtCtrls, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore, dxSkinBlack, dxSkinBlue,
  dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy,
  dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue,
  dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver,
  dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters,
  dxSkinValentine, dxSkinXmas2008Blue, dxSkinscxPCPainter, cxPC, StdCtrls,
  Menus, cxButtons, cxContainer, cxEdit, cxImage, AdvReflectionLabel, cxLabel,
  UCBase, DB, MemDS, DBAccess, Uni, ImgList, cxCheckBox, cxDBEdit, cxTextEdit,
  cxMaskEdit, cxButtonEdit, ACBrBase, ACBrEnterTab, cxGroupBox, cxRadioGroup,
  cxDropDownEdit, cxCalendar, cxMemo, cxImageComboBox, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxDBData, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridLevel, cxClasses, cxGridCustomView,
  cxGrid, cxCurrencyEdit, cxSpinEdit, ACBrValidador, strutils, ELibFnc, ECmpCol;

type
  TFormEntrSaid = class(TForm)
    cxPageControl1: TcxPageControl;
    cxTabControl1: TcxTabControl;
    btnFechar: TcxButton;
    btnGravar: TcxButton;
    btnExcluirNota: TcxButton;
    Image1: TImage;
    lbTitu: TcxLabel;
    controle: TUCControls;
    dsTable: TUniDataSource;
    quTable: TUniQuery;
    sqlaux: TUniQuery;
    sb: TStatusBar;
    imagem: TImageList;
    edCodi: TcxButtonEdit;
    cxLabel1: TcxLabel;
    ACBrEnterTab1: TACBrEnterTab;
    cxPageControl2: TcxPageControl;
    cxTabSheet1: TcxTabSheet;
    cxTabSheet2: TcxTabSheet;
    cxTabSheet3: TcxTabSheet;
    cxTabSheet4: TcxTabSheet;
    cxTabSheet5: TcxTabSheet;
    edTipoMovi: TcxDBRadioGroup;
    edTipoEmis: TcxDBRadioGroup;
    cxGroupBox1: TcxGroupBox;
    cxLabel2: TcxLabel;
    edEnti: TcxButtonEdit;
    edNomeEnti: TcxTextEdit;
    edCnpj: TcxTextEdit;
    cxGroupBox2: TcxGroupBox;
    cxLabel3: TcxLabel;
    cxDBDateEdit1: TcxDBDateEdit;
    cxDBDateEdit2: TcxDBDateEdit;
    cxLabel4: TcxLabel;
    edNatu: TcxButtonEdit;
    cxLabel5: TcxLabel;
    edNomeNatu: TcxTextEdit;
    cxLabel6: TcxLabel;
    cxLabel7: TcxLabel;
    cxDBTextEdit1: TcxDBTextEdit;
    edSeri: TcxButtonEdit;
    edNomeSeri: TcxTextEdit;
    cxLabel9: TcxLabel;
    cxDBImageComboBox1: TcxDBImageComboBox;
    cxLabel10: TcxLabel;
    edtipofrete: TcxDBImageComboBox;
    cxGroupBox4: TcxGroupBox;
    cxGroupBox5: TcxGroupBox;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1Column1: TcxGridDBColumn;
    cxGrid1DBTableView1Column2: TcxGridDBColumn;
    cxGrid1DBTableView1Column3: TcxGridDBColumn;
    cxGrid1DBTableView1Column4: TcxGridDBColumn;
    cxGrid1DBTableView1Column5: TcxGridDBColumn;
    cxGrid1DBTableView1Column6: TcxGridDBColumn;
    edProd: TcxButtonEdit;
    cxLabel11: TcxLabel;
    edNomeProd: TcxTextEdit;
    edSequ: TcxTextEdit;
    cxLabel12: TcxLabel;
    edQuan: TcxTextEdit;
    edUnit: TcxCurrencyEdit;
    cxLabel13: TcxLabel;
    cxLabel14: TcxLabel;
    edIpi: TcxCurrencyEdit;
    cxLabel15: TcxLabel;
    cxLabel16: TcxLabel;
    edMva: TcxCurrencyEdit;
    edReduSt: TcxCurrencyEdit;
    cxLabel17: TcxLabel;
    edCfop: TcxButtonEdit;
    edNomeCfop: TcxTextEdit;
    cxLabel18: TcxLabel;
    cxLabel19: TcxLabel;
    cxDBCurrencyEdit1: TcxDBCurrencyEdit;
    cxDBCurrencyEdit2: TcxDBCurrencyEdit;
    cxLabel20: TcxLabel;
    cxDBCurrencyEdit3: TcxDBCurrencyEdit;
    cxLabel21: TcxLabel;
    btnIncluir: TcxButton;
    btnExcluir: TcxButton;
    cxGroupBox6: TcxGroupBox;
    cxGroupBox7: TcxGroupBox;
    cxLabel22: TcxLabel;
    edCecu: TcxButtonEdit;
    edNomeCecu: TcxTextEdit;
    edNomeFopa: TcxTextEdit;
    edFopa: TcxButtonEdit;
    cxLabel23: TcxLabel;
    cxGroupBox8: TcxGroupBox;
    cxLabel24: TcxLabel;
    edDataParc: TcxDateEdit;
    cxLabel25: TcxLabel;
    edNumeParc: TcxSpinEdit;
    edDiasParc: TcxSpinEdit;
    cxLabel26: TcxLabel;
    cxGrid2DBTableView1: TcxGridDBTableView;
    cxGrid2Level1: TcxGridLevel;
    cxGrid2: TcxGrid;
    cxGrid2DBTableView1Column1: TcxGridDBColumn;
    cxGrid2DBTableView1Column2: TcxGridDBColumn;
    cxGrid2DBTableView1Column3: TcxGridDBColumn;
    cxLabel27: TcxLabel;
    edValoParc: TcxCurrencyEdit;
    btnGerar: TcxButton;
    btnExcluirParc: TcxButton;
    edTota: TcxCurrencyEdit;
    cxLabel28: TcxLabel;
    cxLabel29: TcxLabel;
    edTotaParc: TcxCurrencyEdit;
    cxLabel30: TcxLabel;
    edDife: TcxCurrencyEdit;
    edParc: TcxTextEdit;
    cxLabel31: TcxLabel;
    cxGroupBox9: TcxGroupBox;
    cxLabel32: TcxLabel;
    cxLabel33: TcxLabel;
    cxLabel34: TcxLabel;
    cxLabel35: TcxLabel;
    cxLabel37: TcxLabel;
    cxLabel38: TcxLabel;
    cxLabel39: TcxLabel;
    cxLabel40: TcxLabel;
    cxLabel41: TcxLabel;
    cxLabel42: TcxLabel;
    cxLabel43: TcxLabel;
    cxLabel44: TcxLabel;
    cxLabel45: TcxLabel;
    cxLabel46: TcxLabel;
    cxLabel47: TcxLabel;
    cxLabel48: TcxLabel;
    cxLabel49: TcxLabel;
    cxLabel53: TcxLabel;
    cxGroupBox10: TcxGroupBox;
    cxLabel36: TcxLabel;
    cxLabel50: TcxLabel;
    cxLabel51: TcxLabel;
    cxLabel52: TcxLabel;
    cxLabel54: TcxLabel;
    cxDBTextEdit2: TcxDBTextEdit;
    cxDBTextEdit3: TcxDBTextEdit;
    cxLabel55: TcxLabel;
    edTran: TcxButtonEdit;
    cxLabel56: TcxLabel;
    edNomeTran: TcxTextEdit;
    cxPageControl3: TcxPageControl;
    cxTabSheet6: TcxTabSheet;
    cxDBMemo1: TcxDBMemo;
    cxTabSheet7: TcxTabSheet;
    cxDBMemo2: TcxDBMemo;
    cxDBCurrencyEdit4: TcxDBCurrencyEdit;
    cxDBCurrencyEdit5: TcxDBCurrencyEdit;
    cxDBCurrencyEdit6: TcxDBCurrencyEdit;
    cxDBCurrencyEdit7: TcxDBCurrencyEdit;
    quImov: TUniQuery;
    dsImov: TUniDataSource;
    quFina: TUniQuery;
    dsFina: TUniDataSource;
    cxGrid2DBTableView1Column4: TcxGridDBColumn;
    quNatu: TUniQuery;
    EvLibFunctions1: TEvLibFunctions;
    cxDBCurrencyEdit8: TcxDBCurrencyEdit;
    cxDBCurrencyEdit9: TcxDBCurrencyEdit;
    cxDBCurrencyEdit10: TcxDBCurrencyEdit;
    cxDBCurrencyEdit11: TcxDBCurrencyEdit;
    cxDBCurrencyEdit12: TcxDBCurrencyEdit;
    cxDBCurrencyEdit13: TcxDBCurrencyEdit;
    cxDBCurrencyEdit14: TcxDBCurrencyEdit;
    cxDBCurrencyEdit15: TcxDBCurrencyEdit;
    cxDBCurrencyEdit16: TcxDBCurrencyEdit;
    cxDBCurrencyEdit17: TcxDBCurrencyEdit;
    cxDBCurrencyEdit18: TcxDBCurrencyEdit;
    cxDBCurrencyEdit19: TcxDBCurrencyEdit;
    cxDBCurrencyEdit20: TcxDBCurrencyEdit;
    cxDBCurrencyEdit21: TcxDBCurrencyEdit;
    cxDBCurrencyEdit22: TcxDBCurrencyEdit;
    cxDBCurrencyEdit23: TcxDBCurrencyEdit;
    cxDBCurrencyEdit24: TcxDBCurrencyEdit;
    cxDBCurrencyEdit25: TcxDBCurrencyEdit;
    cxDBCurrencyEdit26: TcxDBCurrencyEdit;
    cxLabel67: TcxLabel;
    cxDBCurrencyEdit27: TcxDBCurrencyEdit;
    cxLabel68: TcxLabel;
    cxDBCurrencyEdit28: TcxDBCurrencyEdit;
    cxLabel69: TcxLabel;
    cxDBCurrencyEdit29: TcxDBCurrencyEdit;
    cxLabel70: TcxLabel;
    edNomeVeic: TcxTextEdit;
    edVeic: TcxButtonEdit;
    cxLabel71: TcxLabel;
    cxGroupBox13: TcxGroupBox;
    edMens: TcxButtonEdit;
    cxLabel8: TcxLabel;
    cxGroupBox3: TcxGroupBox;
    edNomeMens: TcxMemo;
    cxDBTextEdit4: TcxDBTextEdit;
    cxLabel58: TcxLabel;
    cxDBTextEdit5: TcxDBTextEdit;
    cxLabel59: TcxLabel;
    cxDBTextEdit6: TcxDBTextEdit;
    cxLabel60: TcxLabel;
    edVend: TcxButtonEdit;
    cxLabel57: TcxLabel;
    edNomeVend: TcxTextEdit;
    EvCompCollector1: TEvCompCollector;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnFecharClick(Sender: TObject);
    procedure quTableBeforeEdit(DataSet: TDataSet);
    procedure quTableBeforeInsert(DataSet: TDataSet);
    procedure quTableAfterPost(DataSet: TDataSet);
    procedure quTableAfterCancel(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure edCodiPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure edCodiExit(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure cxGrid1DBTableView1CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxGrid2DBTableView1CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure edEntiPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure edEntiExit(Sender: TObject);
    procedure edNatuPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure edNatuExit(Sender: TObject);
    procedure edMensPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure edMensExit(Sender: TObject);
    procedure edProdPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure edProdExit(Sender: TObject);
    procedure edCfopPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure edCfopExit(Sender: TObject);
    procedure edCecuPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure edCecuExit(Sender: TObject);
    procedure edFopaPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure edFopaExit(Sender: TObject);
    procedure edTranPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure edTranExit(Sender: TObject);
    procedure edVendPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure edVendExit(Sender: TObject);
    procedure edSeriPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure edSeriExit(Sender: TObject);
    procedure quTableAfterScroll(DataSet: TDataSet);
    procedure edSequExit(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure cxGrid1DBTableView1CellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure btnGerarClick(Sender: TObject);
    procedure CalcImposto;
    procedure edVeicExit(Sender: TObject);
    procedure edVeicPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure edParcPropertiesChange(Sender: TObject);
    procedure edParcExit(Sender: TObject);
    procedure cxDBCurrencyEdit1Exit(Sender: TObject);
    procedure btnExcluirNotaClick(Sender: TObject);
  private
    v_tabela,
    v_esquema : string;
    seq : Integer;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormEntrSaid: TFormEntrSaid;

implementation

uses prog0001, prog0003, rotinas, UClsCalcNF;

{$R *.dfm}



procedure TFormEntrSaid.CalcImposto;
var
  lItemNF      : TItemNF;
  FNotaFiscal  : TNotaFiscal;
  i : Integer;
  v_isentas,
  v_diferidas,
  v_outras,
  v_isentas_ipi,
  v_diferidas_ipi,
  v_outras_ipi,
  v_base_ipi,
  v_valor_ipi,
  v_base_pis,
  v_base_cofins,
  v_valor_pis,
  v_valor_cofins : Real;
begin
  FNotaFiscal := TNotaFiscal.Create(Self);
  lItemNF := TItemNF.Create(FNotaFiscal);
  i:= 0;
  v_isentas:= 0;
  v_outras:= 0;
  v_diferidas:= 0;
  v_isentas_ipi:= 0;
  v_outras_ipi:= 0;
  v_diferidas_ipi:= 0;
  v_base_ipi:= 0;
  v_valor_ipi:= 0;
  v_base_pis:= 0;
  v_base_cofins:= 0;
  v_valor_pis:= 0;
  v_valor_cofins:= 0;

  // emitente
  sqlaux.Close;
  sqlaux.sql.Text:= 'select empr_raza, empr_form_trib, '+
                    '(select cida_sigl from cadastro.cida where cida_codi = empr_cida) as "empr_esta" '+
                    'from cadastro.empr where empr_codi = :codi';
  sqlaux.ParamByName('codi').AsInteger:= formprincipal.puempresa;
  sqlaux.Open;
  fnotafiscal.EmitenteNF.NomeRazaoSocial:= sqlaux.FieldByName('empr_raza').AsString;
  fnotafiscal.EmitenteNF.Estado:= sqlaux.FieldByName('empr_esta').AsString;
  case sqlaux.FieldByName('empr_form_trib').AsInteger of
    1 : fnotafiscal.EmitenteNF.CRT:= crtSimplesNacional;
    2 : fnotafiscal.EmitenteNF.CRT:= crtSimplesExcessoReceita;
    3 : fnotafiscal.EmitenteNF.CRT:= crtRegimeNormal;
  end;

  // cliente
  sqlaux.Close;
  sqlaux.sql.Text:= 'select enti_desc, '+
                    '(select cida_sigl from cadastro.cida where cida_codi = enti_cida) as "enti_esta" '+
                    'from cadastro.enti where enti_codi = :codi '+
                    'and enti_empr = :empr and enti_loca = :loca';
  sqlaux.ParamByName('empr').AsInteger:= FormPrincipal.puempresa;
  sqlaux.ParamByName('loca').AsInteger:= FormPrincipal.pulocal;
  sqlaux.ParamByName('codi').AsInteger:= StrToIntDef(edEnti.Text,0);
  sqlaux.Open;
  fnotafiscal.DestinatarioNF.NomeRazaoSocial:= sqlaux.FieldByName('enti_desc').AsString;
  fnotafiscal.DestinatarioNF.Estado:= sqlaux.FieldByName('enti_esta').AsString;

  with fnotafiscal.ValoresNF do
  begin
     VL_FRETE:= quTable.FieldByName('movi_valo_fret').AsFloat;
     VL_SEGURO:= quTable.FieldByName('movi_valo_segu').AsFloat;
     VL_DESPACESS:= quTable.FieldByName('movi_valo_desp').AsFloat;
  end;

  lItemNF.Inicializar;
  quImov.First;
  while not quImov.Eof do
   begin
      with lItemNF do
        begin
          sqlaux.Close;
          sqlaux.SQL.Text:= 'select * from cadastro.natu where natu_codi = :codi and natu_empr = :empr and natu_loca = :loca';
          sqlaux.ParamByName('empr').AsInteger:= FormPrincipal.puempresa;
          sqlaux.ParamByName('loca').AsInteger:= FormPrincipal.pulocal;
          sqlaux.ParamByName('codi').AsInteger:= quImov.FieldByName('imov_natu').AsInteger;
          sqlaux.Open;

          Item := i;
          CodProduto:= quImov.FieldByName('imov_prod').AsString;
          DescProduto:= '';
          Quantidade:=  quImov.FieldByName('imov_quan').AsFloat;
          ValorUnitario:= quimov.FieldByName('imov_unit').asfloat;
          ValorDesconto:= 0;
          NCMSH:= '';
          case AnsiIndexStr(sqlaux.fieldbyname('natu_cst_icms').asstring,['0','10','20','30','40','41','50','51','60','70','90']) of
            0 : CST_ICMS      := cst00;
            1 : CST_ICMS      := cst10;
            2 : CST_ICMS      := cst20;
            3 : CST_ICMS      := cst30;
            4 : CST_ICMS      := cst40;
            5 : CST_ICMS      := cst41;
            6 : CST_ICMS      := cst50;
            7 : CST_ICMS      := cst51;
            8 : CST_ICMS      := cst60;
            9 : CST_ICMS      := cst70;
            10: CST_ICMS      := cst90;
          end;

          if (sqlaux.fieldbyname('natu_cst_ipi_trib').asstring = '0') or
             (sqlaux.fieldbyname('natu_cst_ipi_trib').asstring = '50') or
             (sqlaux.fieldbyname('natu_cst_ipi_trib').asstring = '49') or
             (sqlaux.fieldbyname('natu_cst_ipi_trib').asstring = '99') then
          begin
              case AnsiIndexStr(sqlaux.fieldbyname('natu_cst_ipi_trib').asstring,['0','50','49','99']) of
                0 : CST_IPI := ipi00;
                1 : CST_IPI := ipi50;
                2 : CST_IPI := ipi49;
                3 : CST_IPI := ipi99;
              end;
           end
           else
           begin
              case AnsiIndexStr(sqlaux.fieldbyname('natu_cst_ipi_trib').asstring,['01','02','03','04','05','51','52','53','54','55']) of
                0 : CST_IPI := ipi01;
                1 : CST_IPI := ipi02;
                2 : CST_IPI := ipi03;
                3 : CST_IPI := ipi04;
                4 : CST_IPI := ipi05;
                5 : CST_IPI := ipi51;
                6 : CST_IPI := ipi52;
                7 : CST_IPI := ipi53;
                8 : CST_IPI := ipi54;
                9 : CST_IPI := ipi55;
              end;
           end;
           case AnsiIndexStr(sqlaux.fieldbyname('natu_cst_pis').asstring,['01','02','03','04','06','07','08','09','99']) of
             0 : CST_PIS      := pis01;
             1 : CST_PIS      := pis02;
             2 : CST_PIS      := pis03;
             3 : CST_PIS      := pis04;
             4 : CST_PIS      := pis06;
             5 : CST_PIS      := pis07;
             6 : CST_PIS      := pis08;
             7 : CST_PIS      := pis09;
             8 : CST_PIS      := pis99;
           end;
           case AnsiIndexStr(sqlaux.fieldbyname('natu_cst_cofi').asstring,['01','02','03','04','06','07','08','09','99']) of
             0 : CST_COFINS      := cof01;
             1 : CST_COFINS      := cof02;
             2 : CST_COFINS      := cof03;
             3 : CST_COFINS      := cof04;
             4 : CST_COFINS      := cof06;
             5 : CST_COFINS      := cof07;
             6 : CST_COFINS      := cof08;
             7 : CST_COFINS      := cof09;
             8 : CST_COFINS      := cof99;
           end;
           AliqIPI:= quimov.FieldByName('imov_aliq_ipi').AsFloat;
           AliqMVA:= quimov.FieldByName('imov_aliq_mva').asfloat;
           Peso := 0;
           ReducaoICMS:= quimov.FieldByName('imov_aliq_st').AsFloat;
           FNotaFiscal.ItensNF.Add(FNotaFiscal, lItemNF);
        end;

        quimov.Edit;
        quimov.FieldByName('imov_aliq_icms').AsFloat:= UClsCalcNF.TEstados.AliquotaInterEstadual(fnotafiscal.EmitenteNF.Estado, fnotafiscal.DestinatarioNF.Estado);
        quimov.FieldByName('imov_base_icms').AsFloat:= FNotaFiscal.ItensNF.Items[i].BC_ICMS_OP;
        quimov.FieldByName('imov_valo_icms').AsFloat:= FNotaFiscal.ItensNF.Items[i].VL_ICMS_OP;
        quimov.FieldByName('imov_tota').AsFloat:= FNotaFiscal.ItensNF.Items[i].VL_TOTAL_BRT;
        if quimov.FieldByName('imov_tota').AsFloat > quImov.FieldByName('imov_base_icms').AsFloat then
          begin
            if sqlaux.FieldByName('natu_icms_isen').AsBoolean then
              begin
                if quimov.fieldbyname('imov_tota').asfloat > quimov.fieldbyname('imov_base_icms').asfloat then
                 begin
                   v_isentas:= v_isentas + (quimov.FieldByName('imov_tota').AsFloat - quImov.FieldByName('imov_base_icms').AsFloat);
                   quimov.FieldByName('imov_isen_icms').asfloat:= (quimov.FieldByName('imov_tota').AsFloat - quImov.FieldByName('imov_base_icms').AsFloat);
                 end;
              end else
            if sqlaux.FieldByName('natu_icms_dife').AsBoolean then
              begin
                if quimov.fieldbyname('imov_tota').asfloat > quimov.fieldbyname('imov_base_icms').asfloat then
                 begin
                   v_diferidas:= v_diferidas + (quimov.FieldByName('imov_tota').AsFloat - quImov.FieldByName('imov_base_icms').AsFloat);
                   quimov.FieldByName('imov_dife_icms').asfloat:= (quimov.FieldByName('imov_tota').AsFloat - quImov.FieldByName('imov_base_icms').AsFloat);
                 end;
              end else
            if sqlaux.FieldByName('natu_icms_outr').AsBoolean then
              begin
                if quimov.fieldbyname('imov_tota').asfloat > quimov.fieldbyname('imov_base_icms').asfloat then
                 begin
                   v_outras:= v_outras + (quimov.FieldByName('imov_tota').AsFloat - quImov.FieldByName('imov_base_icms').AsFloat);
                   quimov.FieldByName('imov_outr_icms').asfloat:= (quimov.FieldByName('imov_tota').AsFloat - quImov.FieldByName('imov_base_icms').AsFloat);
                 end;
              end;
          end;
        quimov.FieldByName('imov_base_ipi').asfloat:= FNotaFiscal.ItensNF.Items[i].BC_IPI;
        quimov.FieldByName('imov_valo_ipi').asfloat:= FNotaFiscal.ItensNF.Items[i].VL_IPI;
        if quimov.FieldByName('imov_tota').AsFloat > quimov.FieldByName('imov_base_ipi').asfloat then
          begin
            if sqlaux.FieldByName('natu_ipi_isen').AsBoolean then
              begin
                v_isentas_ipi:= v_isentas_ipi + (quimov.FieldByName('imov_tota').AsFloat - quImov.FieldByName('imov_base_ipi').AsFloat);
                quimov.FieldByName('imov_isen_ipi').asfloat:= (quimov.FieldByName('imov_tota').AsFloat - quImov.FieldByName('imov_base_ipi').AsFloat);
              end else
            if sqlaux.FieldByName('natu_icms_dife').AsBoolean then
              begin
                v_diferidas_ipi:= v_diferidas_ipi  + (quimov.FieldByName('imov_tota').AsFloat - quImov.FieldByName('imov_base_ipi').AsFloat);
                quimov.FieldByName('imov_dife_ipi').asfloat:= (quimov.FieldByName('imov_tota').AsFloat - quImov.FieldByName('imov_base_ipi').AsFloat);
              end else
            if sqlaux.FieldByName('natu_icms_outr').AsBoolean then
              begin
                v_outras_ipi:= v_outras_ipi  + (quimov.FieldByName('imov_tota').AsFloat - quImov.FieldByName('imov_base_ipi').AsFloat);
                quimov.FieldByName('imov_outr_ipi').asfloat:= (quimov.FieldByName('imov_tota').AsFloat - quImov.FieldByName('imov_base_ipi').AsFloat);
              end;
            quimov.FieldByName('imov_base_ipi').asfloat:= quimov.FieldByName('imov_base_ipi').asfloat - (quimov.FieldByName('imov_tota').AsFloat - quImov.FieldByName('imov_base_ipi').AsFloat);
            v_base_ipi:= v_base_ipi + quimov.FieldByName('imov_base_ipi').AsFloat;
          end else
           begin
              v_base_ipi := v_base_ipi + FNotaFiscal.ItensNF.Items[i].BC_IPI;
           end;

        v_valor_ipi:= v_valor_ipi + FNotaFiscal.ItensNF.Items[i].VL_IPI;
        quimov.FieldByName('imov_base_pis').asfloat:= MRound(FNotaFiscal.ItensNF.Items[i].VL_TOTAL_LIQ,2);
        v_base_pis:= v_base_pis + quImov.fieldbyname('imov_base_pis').asfloat;

        quimov.FieldByName('imov_valo_pis').asfloat:= MRound(((quimov.FieldByName('imov_base_pis').asfloat *
                                                               sqlaux.FieldByName('natu_aliq_pis').AsFloat) /100),2);
        v_valor_pis:= v_valor_pis + quImov.FieldByName('imov_valo_pis').AsFloat;

        quimov.FieldByName('imov_base_cofins').asfloat:= MRound(FNotaFiscal.ItensNF.Items[i].VL_TOTAL_LIQ,2);
        v_base_cofins:= v_base_cofins + quimov.FieldByName('imov_base_cofins').AsFloat;

        quimov.FieldByName('imov_valo_cofins').asfloat:= MRound(((quimov.FieldByName('imov_base_cofins').asfloat *
                                                                  sqlaux.FieldByName('natu_aliq_cofi').AsFloat) /100),2);
        v_valor_cofins:= v_valor_cofins + quimov.FieldByName('imov_valo_cofins').asfloat;

        quimov.FieldByName('imov_valo_mva').asfloat:= FNotaFiscal.ItensNF.Items[i].VL_MVA;
        quimov.FieldByName('imov_unli').asfloat:= FNotaFiscal.ItensNF.Items[i].VL_TOTAL_LIQ;

        quimov.FieldByName('imov_valo_icms_st').asfloat:= FNotaFiscal.ItensNF.Items[i].VL_ICMS_ST;
        quimov.FieldByName('imov_base_icms_st').asfloat:= FNotaFiscal.ItensNF.Items[i].BC_ICMS_ST;
        quimov.FieldByName('imov_valo_fret').asfloat:= FNotaFiscal.ItensNF.Items[i].VL_FRETE_PROP;
        quimov.FieldByName('imov_valo_segu').asfloat:= FNotaFiscal.ItensNF.Items[i].VL_SEGUR_PROP;
        quimov.FieldByName('imov_valo_desp').asfloat:= FNotaFiscal.ItensNF.Items[i].VL_DESPAC_PROP;
        quimov.next;
        Inc(i);
   end;
   quTable.Edit;
   quTable.FieldByName('movi_base_icms').asfloat:= FNotaFiscal.ValoresNF.BS_ICMS;
   quTable.FieldByName('movi_valo_icms').asfloat:= FNotaFiscal.ValoresNF.VL_ICMS;
   quTable.FieldByName('movi_base_ipi').asfloat:= v_base_ipi;
   quTable.FieldByName('movi_valo_ipi').asfloat:= v_valor_ipi;
   quTable.FieldByName('movi_outr_ipi').asfloat:= v_outras_ipi;
   quTable.FieldByName('movi_isen_ipi').asfloat:= v_isentas_ipi;
   quTable.FieldByName('movi_dife_ipi').asfloat:= v_diferidas_ipi;
   quTable.FieldByName('movi_base_pis').asfloat:= v_base_pis;
   quTable.FieldByName('movi_base_cofins').asfloat:= v_base_cofins;
   quTable.FieldByName('movi_valo_pis').asfloat:= v_valor_pis;
   quTable.FieldByName('movi_valo_cofins').asfloat:= v_valor_cofins;
   quTable.FieldByName('movi_outr_icms').asfloat:= v_outras;
   quTable.FieldByName('movi_isen_icms').asfloat:= v_isentas;
   quTable.FieldByName('movi_dife_icms').asfloat:= v_diferidas;
   quTable.FieldByName('movi_base_st').AsFloat:= fnotafiscal.ValoresNF.BS_ICMS_ST;
   qutable.FieldByName('movi_valo_st').AsFloat:= fnotafiscal.ValoresNF.VL_ICMS_ST;
   quTable.FieldByName('movi_valo_desc').asfloat:= fnotafiscal.ValoresNF.VL_DESCONTO;
   quTable.FieldByName('movi_valo_fret').asfloat:= fnotafiscal.ValoresNF.VL_FRETE;
   quTable.FieldByName('movi_valo_segu').asfloat:= fnotafiscal.ValoresNF.VL_SEGURO;
   quTable.FieldByName('movi_valo_desp').AsFloat:= fnotafiscal.ValoresNF.VL_DESPACESS;
   quTable.FieldByName('movi_tota_prod').asfloat:= fnotafiscal.ValoresNF.VL_TOTAL_PROD;
   qutable.FieldByName('movi_tota_nota').asfloat:= fnotafiscal.ValoresNF.VL_TOTAL_NF;
   edTota.Value:= fnotafiscal.ValoresNF.VL_TOTAL_NF;
   edDife.Value:= MRound(edTota.Value,2) - MRound(edTotaParc.Value,2);
   FreeAndNil(FNotaFiscal);
end;


procedure TFormEntrSaid.btnExcluirClick(Sender: TObject);
begin
  if MessageDlg('Deseja Realmente Excluir o Registro?',  mtConfirmation, [mbYes, mbNo], 0) = mrYes then
   begin
     quImov.Delete;
   end;

  CalcImposto;

  edProd.Clear;
  edProdExit(Self);
  edQuan.Clear;
  edUnit.Clear;
  edCfop.Clear;
  edCfopExit(Self);
  edIpi.Clear;
  edMva.Clear;
  edReduSt.Clear;
end;

procedure TFormEntrSaid.btnExcluirNotaClick(Sender: TObject);
begin
  if MessageDlg('Deseja Realmente Excluir o Registro?',  mtConfirmation, [mbYes, mbNo], 0) = mrYes then
   begin
     // grava log
     formprincipal.controle.Log('Excluiu o registro: '+qutable.fieldbyname(v_tabela+'_codi').asstring+' - '+
                                                       '',
                                                       Caption,3);
     // apaga tabela de itens do movimento
     sqlaux.Close;
     sqlaux.SQL.Text:= 'delete from imov where imov_empr = :empr and imov_loca = :loca and imov_codi = :codi';
     sqlaux.ParamByName('empr').AsInteger:= FormPrincipal.puempresa;
     sqlaux.ParamByName('loca').AsInteger:= FormPrincipal.pulocal;
     sqlaux.ParamByName('codi').AsInteger:= quTable.FieldByName('movi_codi').AsInteger;
     sqlaux.ExecSQL;

     // apaga tabela principal
     qutable.Delete;
     qutable.ApplyUpdates();
     edcodi.Clear;
     edEnti.Clear;
     edEntiExit(Self);
     edNatu.Clear;
     edNatuExit(Self);
     edseri.Clear;
     edseriexit(Self);
     edMens.Clear;
     edMensExit(Self);
     edCecu.Clear;
     edCecuExit(Self);
     edFopa.Clear;
     edFopaExit(Self);
     edVeic.Clear;
     edVeicExit(Self);
     edVend.Clear;
     edVendExit(Self);
   end;
end;

procedure TFormEntrSaid.btnFecharClick(Sender: TObject);
begin
  close;
end;

procedure TFormEntrSaid.btnGerarClick(Sender: TObject);
var
  v_venc : TDateTime;
  v_parc : Integer;
  v_valo_parc,
  v_tota,
  v_dife : Real;
begin
  v_valo_parc:= 0;
  v_tota:= 0;
  v_venc:= edDataParc.Date;

  sqlaux.Close;
  sqlaux.SQL.Text:= 'select natu_mofi from cadastro.natu where natu_codi = :codi and natu_empr = :empr and natu_loca = :loca';
  sqlaux.ParamByName('empr').AsInteger:= FormPrincipal.puempresa;
  sqlaux.ParamByName('loca').AsInteger:= FormPrincipal.pulocal;
  sqlaux.ParamByName('codi').AsInteger:= StrToIntDef(edNatu.Text,0);
  sqlaux.Open;
  if not sqlaux.FieldByName('natu_mofi').AsBoolean then
   begin
     ShowMessage('Pedido com natureza de operação que não movimenta financeiro');
     Exit;
   end;

  if edParc.Text = '' then
    begin
      sqlaux.Close;
      sqlaux.SQL.Text:= 'delete from movimento.mofi where mofi_empr = :empr and mofi_loca = :loca '+
                        'and mofi_titu = :titu';
      sqlaux.ParamByName('empr').AsInteger:= FormPrincipal.puempresa;
      sqlaux.ParamByName('loca').AsInteger:= FormPrincipal.pulocal;
      sqlaux.ParamByName('titu').AsInteger:= StrToIntDef(edcodi.Text,0);
      sqlaux.ExecSQL;
      quFina.Refresh;
      v_valo_parc:= MRound((quTable.FieldByName('movi_tota_nota').AsFloat / edNumeParc.Value),2);
      v_venc:= edDataParc.Date;
      if qufina.isempty then
        begin
          for v_parc:= 1 to StrToIntDef(edNumeParc.Text,0) do
          begin
            qufina.Append;
            quFina.FieldByName('mofi_titu').AsInteger:= StrToIntDef(quTable.FieldByName('movi_codi').Asstring,-9999);
            case edTipoMovi.ItemIndex of
              0 : quFina.FieldByName('mofi_tipo').AsString:= 'E';
              1 : quFina.FieldByName('mofi_tipo').AsString:= 'S';
            end;
            case edTipoEmis.ItemIndex of
              0 : quFina.FieldByName('mofi_seri').AsString:= 'ORC';
              1 : quFina.FieldByName('mofi_seri').AsString:= 'PED';
              2 : quFina.FieldByName('mofi_seri').AsString:= 'NOT';
            end;
            quFina.FieldByName('mofi_emis').AsDateTime:= quTable.FieldByName('movi_emis').AsDateTime;
            quFina.FieldByName('mofi_venc').AsDateTime:= v_venc;
            qufina.FieldByName('mofi_pror').AsDateTime:= v_venc;
            quFina.FieldByName('mofi_valo_tota').asfloat:= v_valo_parc;
            qufina.FieldByName('mofi_enti').AsInteger:= quTable.FieldByName('movi_enti').AsInteger;
            quFina.FieldByName('mofi_empr').AsInteger:= FormPrincipal.puempresa;
            quFina.FieldByName('mofi_loca').AsInteger:= FormPrincipal.pulocal;
            quFina.FieldByName('mofi_parc').AsInteger:= v_parc;
            quFina.FieldByName('mofi_stat').asstring:= 'A';
            quFina.FieldByName('mofi_cecu').AsInteger:= quTable.FieldByName('movi_cecu').AsInteger;
            quFina.FieldByName('mofi_valo_sald').asfloat:= v_valo_parc;
            quFina.FieldByName('mofi_valo_pago').asfloat:= 0;
            quFina.Post;
            v_venc:= v_venc + StrToIntDef(edDiasParc.Text,0);
          end;
        end;
    end else
  if edParc.Text <> '' then
     begin
       quFina.Edit;
       quFina.FieldByName('mofi_valo_tota').asfloat:= edValoParc.Value;
       quFina.Post;
     end;

    edTotaParc.Value:= 0;
    quFina.First;
    if not quFina.IsEmpty then
     begin
       while not quFina.Eof do
         begin
            edTotaParc.Value:= MRound((edTotaParc.Value + quFina.FieldByName('mofi_valo_tota').AsFloat),2);
            qufina.Next;
         end;
     end;

    if MRound(edTota.Value,2) > MRound(edTotaParc.Value,2) then
     begin
       v_dife:= Abs(MRound((edTota.Value - edTotaParc.Value),2));
       if v_dife < 0.03 then
         begin
           quFina.First;
           quFina.Edit;
           quFina.FieldByName('mofi_valo_tota').asfloat:= MRound((quFina.FieldByName('mofi_valo_tota').asfloat + v_dife),2);
           qufina.Post;
         end;
     end else
    if MRound(edTota.Value,2) < MRound(edTotaParc.Value,2) then
      begin
        v_dife:= Abs(MRound((edTotaParc.Value - edTota.Value),2));
        if v_dife < 0.03 then
          begin
            quFina.First;
            quFina.Edit;
            quFina.FieldByName('mofi_valo_tota').asfloat:= MRound((quFina.FieldByName('mofi_valo_tota').asfloat - v_dife),2);
            qufina.Post;
          end;
      end;

    edTotaParc.Value:= 0;
    quFina.First;
    if not quFina.IsEmpty then
     begin
       while not quFina.Eof do
         begin
            edTotaParc.Value:= MRound((edTotaParc.Value + quFina.FieldByName('mofi_valo_tota').AsFloat),2);
            qufina.Next;
         end;
     end;
    edDife.Value:= MRound(edTota.Value,2) - MRound(edTotaParc.Value,2);
end;

procedure TFormEntrSaid.btnGravarClick(Sender: TObject);
var
  v_status : boolean;
  i : Integer;
begin
  CalcImposto;

  sqlaux.Close;
  sqlaux.SQL.Text:= 'select natu_mofi from cadastro.natu where natu_codi = :codi and natu_empr = :empr and natu_loca = :loca';
  sqlaux.ParamByName('empr').AsInteger:= FormPrincipal.puempresa;
  sqlaux.ParamByName('loca').AsInteger:= FormPrincipal.pulocal;
  sqlaux.ParamByName('codi').AsInteger:= StrToIntDef(edNatu.Text,0);
  sqlaux.Open;
  if not sqlaux.FieldByName('natu_mofi').AsBoolean then
   begin
     showmessage('Natureza de operação não gera financeiro');
     exit;
   end;

  if (MRound(edDife.Value,2) <> 0) and
     (sqlaux.FieldByName('natu_mofi').AsBoolean) then
    begin
      ShowMessage('Existe diferença no financeiro, favor verificar !!!');
      Exit;
    end;

  if qutable.State in [dsInsert] then
   begin
     // pega o codigo do ultimo registro
     sqlaux.Close;
     sqlaux.SQL.Text:= 'select max('+v_tabela+'_codi) as "codigo" from '+v_esquema+'.'+v_tabela+' where '+
                        v_tabela+'_empr = :empr and '+
                        v_tabela+'_loca = :loca ';
     sqlaux.ParamByName('empr').AsInteger:= formprincipal.puempresa;
     sqlaux.ParamByName('loca').AsInteger:= formprincipal.pulocal;
     sqlaux.Open;
     sqlaux.Tag:= sqlaux.FieldByName('codigo').AsInteger + 1;
     edcodi.Text:= inttostr(sqlaux.Tag);

     v_status:= true;
   end
  else
  if qutable.State in [dsEdit] then
   begin
     v_status:= false;
   end;

  quTable.FieldByName('movi_vend').AsInteger:= StrToIntDef(edVend.Text,0);
  quTable.FieldByName('movi_veic').AsInteger:= StrToIntDef(edVeic.Text,0);
  quTable.FieldByName('movi_enti').AsInteger:= StrToIntDef(edEnti.Text,0);
  quTable.FieldByName('movi_natu').AsInteger:= StrToIntDef(edNatu.Text,0);
  quTable.FieldByName('movi_seri').AsInteger:= StrToIntDef(edSeri.Text,0);
  quTable.FieldByName('movi_mens_fisc').AsInteger:= StrToIntDef(edMens.Text,0);
  quTable.FieldByName('movi_cecu').AsInteger:= StrToIntDef(edCecu.Text,0);
  quTable.FieldByName('movi_fopa').AsInteger:= StrToIntDef(edFopa.Text,0);
  quTable.FieldByName('movi_tran').AsInteger:= StrToIntDef(edTran.Text,0);
  qutable.FieldByName(v_tabela+'_empr').AsInteger:= formprincipal.puempresa;
  qutable.FieldByName(v_tabela+'_loca').AsInteger:= formprincipal.pulocal;
  qutable.FieldByName(v_tabela+'_codi').Asfloat  := strtofloatdef(edcodi.Text,0);
  qutable.Post;
  qutable.ApplyUpdates();

  // atualiza tabela de itens
  i:= 1;
  quimov.First;
  while not quimov.Eof do
    begin
      quimov.Edit;
      quimov.FieldByName('imov_codi').AsInteger:= quTable.FieldByName('movi_codi').AsInteger;
      quimov.FieldByName('imov_sequ').AsInteger:= i;
      quimov.Post;
      quimov.Next;
      Inc(i);
    end;
  quimov.ApplyUpdates();
  quimov.Refresh;

  // atualiza tabela financeiro
  quFina.First;
  while not quFina.Eof do
    begin
      quFina.Edit;
      quFina.FieldByName('mofi_titu').AsInteger:= quTable.FieldByName('movi_codi').AsInteger;
      qufina.Post;
      quFina.Next;
    end;
  qufina.ApplyUpdates();
  quFina.Refresh;

  //grava log
  if v_status then
    begin
      formprincipal.controle.Log('Inseriu o registro: '+qutable.fieldbyname(v_tabela+'_codi').AsString+' - '+
                                                        '',
                                                        Caption,1);
    end else
     begin
       formprincipal.controle.Log('Editou o registro: '+qutable.fieldbyname(v_tabela+'_codi').AsString+' - '+
                                                        '',
                                                        caption,2);
     end;
  edCodi.SetFocus;
end;

procedure TFormEntrSaid.btnIncluirClick(Sender: TObject);
begin
  if quImov.State in [dsBrowse] then
    begin
      quimov.Append;
      edSequ.Text:= inttostr(seq + 1);
      Inc(seq);
      quimov.FieldByName('imov_sequ').AsInteger:= StrToIntDef(edSequ.Text,0);
      quimov.FieldByName('imov_empr').AsInteger:= FormPrincipal.puempresa;
      quimov.FieldByName('imov_loca').asinteger:= FormPrincipal.pulocal;
      quimov.FieldByName('imov_codi').AsInteger:= StrToIntDef(quTable.FieldByName('movi_codi').AsString,-9999);
      quImov.FieldByName('imov_emis').AsDateTime:= quTable.FieldByName('movi_emis').AsDateTime;
      quimov.FieldByName('imov_ensa').AsDateTime:= quTable.FieldByName('movi_ensa').AsDateTime;
    end;

  quimov.FieldByName('imov_prod').AsFloat:= StrToFloatDef(edProd.Text,0);
  quImov.FieldByName('imov_quan').AsFloat:= edQuan.EditValue;
  quimov.FieldByName('imov_unit').AsFloat:= edUnit.EditValue;
  quImov.FieldByName('imov_natu').AsInteger:= StrToIntDef(edCfop.Text,0);
  quImov.FieldByName('imov_aliq_ipi').AsFloat:= StrToFloatDef(edIpi.Text,0);
  quimov.FieldByName('imov_aliq_mva').AsFloat:= StrToFloatDef(edMva.Text,0);
  quimov.FieldByName('imov_aliq_st').AsFloat:= StrToFloatDef(edReduSt.Text,0);
  quimov.FieldByName('imov_tota').AsFloat:= StrToFloatDef(edUnit.Text,0) * StrToFloatDef(edQuan.text,0);
  quimov.Post;

  CalcImposto;

  edProd.Clear;
  edProdExit(Self);
  edQuan.Clear;
  edUnit.Clear;
  edCfop.Clear;
  edCfopExit(Self);
  edIpi.Clear;
  edMva.Clear;
  edReduSt.Clear;
  edSequ.SetFocus;
end;

procedure TFormEntrSaid.cxDBCurrencyEdit1Exit(Sender: TObject);
begin
  if quTable.FieldByName('movi_valo_fret').AsFloat = 0 then
    quTable.FieldByName('movi_tipo_fret').AsInteger:= 2
  else
  if quTable.FieldByName('movi_tipo_fret').AsInteger = 2 then
   begin
     ShowMessage('Favor indicar o tipo de frete');
     edtipofrete.SetFocus;
   end;
end;

procedure TFormEntrSaid.cxGrid1DBTableView1CellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  edSequ.Text:= quImov.FieldByName('imov_sequ').AsString;
  edProd.Text:= quImov.FieldByName('imov_prod').AsString;
  edProdExit(Self);
  edQuan.EditValue:= quimov.FieldByName('imov_quan').AsFloat;
  edUnit.EditValue:= quimov.FieldByName('imov_unit').AsFloat;
  edCfop.Text:= quImov.FieldByName('imov_natu').AsString;
  edCfopExit(Self);
  edIpi.EditValue:= quimov.FieldByName('imov_aliq_ipi').AsFloat;
  edMva.EditValue:= quimov.FieldByName('imov_aliq_mva').AsFloat;
  edReduSt.EditValue:= quimov.FieldByName('imov_aliq_st').AsFloat;
end;

procedure TFormEntrSaid.cxGrid1DBTableView1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  If AViewInfo.GridRecord.RecordIndex mod 2 = 0 Then
    ACanvas.Brush.Color := $FFFAFA
  Else
    ACanvas.Brush.Color := $CDC9C9;

  ACanvas.Font.Color := clBlack;
end;

procedure TFormEntrSaid.cxGrid2DBTableView1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  If AViewInfo.GridRecord.RecordIndex mod 2 = 0 Then
    ACanvas.Brush.Color := $FFFAFA
  Else
    ACanvas.Brush.Color := $CDC9C9;

  ACanvas.Font.Color := clBlack;
end;

procedure TFormEntrSaid.edCecuExit(Sender: TObject);
begin
  edNomececu.Clear;
  if StrToIntDef(edcecu.Text,0) > 0 then
    begin
      sqlaux.Close;
      sqlaux.SQL.Text:= 'select cecu_desc from cadastro.cecu where cecu_codi = :codi '+
                        'and cecu_empr = :empr and cecu_loca = :loca';
      sqlaux.ParamByName('empr').AsInteger:= FormPrincipal.puempresa;
      sqlaux.ParamByName('loca').AsInteger:= FormPrincipal.pulocal;
      sqlaux.ParamByName('codi').AsInteger:= StrToIntDef(edcecu.Text,0);
      sqlaux.Open;
      if sqlaux.IsEmpty then
        begin
          ShowMessage('Centro de Custo não encontrado');
          Exit;
        end;
      edNomececu.Text:= sqlaux.FieldByName('cecu_desc').AsString;
    end;
end;

procedure TFormEntrSaid.edCecuPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  edCecu.Text:= consulta('cons_centro');
  edcecuexit(Self);
end;

procedure TFormEntrSaid.edCfopExit(Sender: TObject);
begin
  edNomeCfop.Clear;
  if StrToIntDef(edCfop.Text,0) > 0 then
    begin
      sqlaux.Close;
      sqlaux.SQL.Text:= 'select natu_desc, natu_perc_redu_st, natu_mva_icms_st, natu_aliq_ipi from cadastro.natu where natu_codi = :codi '+
                        'and natu_empr = :empr and natu_loca = :loca';
      sqlaux.ParamByName('empr').AsInteger:= FormPrincipal.puempresa;
      sqlaux.ParamByName('loca').AsInteger:= FormPrincipal.pulocal;
      sqlaux.ParamByName('codi').AsInteger:= StrToIntDef(edCfop.Text,0);
      sqlaux.Open;
      if sqlaux.IsEmpty then
        begin
          ShowMessage('CFOP não encontrado');
          Exit;
        end;
      edNomeCfop.Text:= sqlaux.FieldByName('natu_desc').AsString;
      if (edIpi.Value = 0) and
         (edMva.Value = 0) and
         (edReduSt.Value = 0) then
      begin
        edIpi.Value:= sqlaux.FieldByName('natu_aliq_ipi').AsFloat;
        edMva.Value:= sqlaux.FieldByName('natu_mva_icms_st').AsFloat;
        edReduSt.Value:= sqlaux.FieldByName('natu_perc_redu_st').AsFloat;
      end;
    end;
end;

procedure TFormEntrSaid.edCfopPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  edCfop.Text:= consulta('cons_cfop');
  edcfopexit(Self);
end;

procedure TFormEntrSaid.edCodiExit(Sender: TObject);
begin
  //carrega tabela referente
  qutable.Close;
  qutable.SQL.Text:= 'select *, '+
                     '       case when movi_stat_nfe = 100 then ''Autorizada'' '+
                     '            when movi_stat_nfe = 101 then ''Cancelada'' '+
                     '            when movi_stat_nfe = 302 then ''Denegada'' '+
                     '            when movi_stat_nfe = 103 then ''Denegada'' '+
                     '            when coalesce(movi_stat_nfe,0) = 0 then ''Não Transmitida'' '+
                     '       end as "status" '+
                     'from '+v_esquema+'.'+v_tabela+' where '+
                                                    v_tabela+'_empr = :empr and '+
                                                    v_tabela+'_loca = :loca and '+
                                                    v_tabela+'_codi = :codi';
  qutable.ParamByName('empr').AsInteger:= formprincipal.puempresa;
  qutable.ParamByName('loca').AsInteger:= formprincipal.pulocal;
  qutable.ParamByName('codi').AsFloat  := strtofloatdef(edcodi.Text,0);
  qutable.Open;
  if (quTable.FieldByName('movi_stat_nfe').AsInteger = 100) or
     (quTable.FieldByName('movi_stat_nfe').AsInteger = 101) or
     (quTable.FieldByName('movi_stat_nfe').AsInteger = 303) or
     (quTable.FieldByName('movi_stat_nfe').AsInteger = 302) then
   begin
     btnGravar.Enabled:= False;
     btnExcluirNota.Enabled:= False;
     btnexcluir.enabled:= false;
     btnincluir.enabled:= false;
     btnexcluirparc.enabled:= false;
     btngerar.enabled:= false;
   end else
    begin
      btnGravar.Enabled:= true;
      btnExcluirNota.Enabled:= true;
      btnexcluir.enabled:= true;
      btnincluir.enabled:= true;
      btnexcluirparc.enabled:= true;
      btngerar.enabled:= true;
    end;

  if qutable.IsEmpty then
    begin
      seq:= 0;
      qutable.Append;
      edEnti.Clear;
      edEntiExit(Self);
      edNatu.Clear;
      edNatuExit(Self);
      edseri.Clear;
      edseriexit(Self);
      edMens.Clear;
      edMensExit(Self);
      edCecu.Clear;
      edCecuExit(Self);
      edFopa.Clear;
      edFopaExit(Self);
      edVeic.Clear;
      edVeicExit(Self);
      edTota.Clear;
      edTotaParc.Clear;
      edDife.Clear;
      edVend.Clear;
      edVendExit(Self);
    end else
     begin
       sqlaux.Close;
       sqlaux.SQL.Text:= 'select max(imov_sequ) as "sequencia" from movimento.imov '+
                         'where imov_empr = :empr and imov_loca = :loca and imov_codi = :codi';
       sqlaux.ParamByName('empr').AsInteger:= FormPrincipal.puempresa;
       sqlaux.ParamByName('loca').AsInteger:= FormPrincipal.pulocal;
       sqlaux.ParamByName('codi').AsInteger:= StrToIntDef(edcodi.Text,0);
       sqlaux.Open;
       seq:= sqlaux.FieldByName('sequencia').AsInteger;

       qutable.Edit;
       edEnti.Text:= quTable.FieldByName('movi_enti').AsString;
       edEntiExit(Self);
       edNatu.Text:= quTable.FieldByName('movi_natu').AsString;
       edNatuExit(Self);
       edSeri.Text:= quTable.FieldByName('movi_seri').AsString;
       edseriexit(Self);
       edMens.Text:= quTable.FieldByName('movi_mens_fisc').AsString;
       edMensExit(Self);
       edCecu.Text:= quTable.FieldByName('movi_cecu').AsString;
       edCecuExit(Self);
       edFopa.Text:= quTable.FieldByName('movi_fopa').AsString;
       edFopaExit(Self);
       edVeic.Text:= quTable.FieldByName('movi_veic').AsString;
       edVeicExit(Self);
       edVend.Text:= quTable.FieldByName('movi_vend').AsString;
       edVendExit(Self);

       // carrega valor financeiro
       edTotaParc.Value:= 0;
       edDife.Value:= 0;
       edTota.Value:= 0;
       if not quFina.IsEmpty then
        begin
          while not quFina.Eof do
            begin
               edTotaParc.Value:= MRound((edTotaParc.Value + quFina.FieldByName('mofi_valo_tota').AsFloat),2);
               qufina.Next;
            end;
        end;
       edtota.Value:= MRound(quTable.FieldByName('movi_tota_nota').AsFloat,2);
       edDife.Value:= MRound(edTota.Value,2) - MRound(edTotaParc.Value,2);
     end;
end;

procedure TFormEntrSaid.edCodiPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  edcodi.Text:= consulta('cons_movimento');
  edCodiExit(self);
end;

procedure TFormEntrSaid.edEntiExit(Sender: TObject);
begin
  edNomeEnti.Clear;
  edCnpj.Clear;
  if StrToIntDef(edEnti.Text,0) > 0 then
    begin
      sqlaux.Close;
      sqlaux.SQL.Text:= 'select enti_desc, enti_cnpj, enti_vend from cadastro.enti '+
                        'where enti_codi = :codi';
      sqlaux.ParamByName('codi').AsInteger:= StrToIntDef(edEnti.Text,0);
      sqlaux.Open;
      if sqlaux.IsEmpty then
        begin
          ShowMessage('Entidade não encontrada');
          Exit;
        end;
      edNomeEnti.Text:= sqlaux.FieldByName('enti_desc').AsString;
      edCnpj.Text:= sqlaux.FieldByName('enti_cnpj').AsString;
      edvend.Text:= sqlaux.FieldByName('enti_vend').AsString;
      edVendExit(Self);
    end;
end;

procedure TFormEntrSaid.edEntiPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  edEnti.Text:= consulta('cons_entidade');
  edEntiexit(Self);
end;

procedure TFormEntrSaid.edFopaExit(Sender: TObject);
begin
  edNomeFopa.Clear;
  edNumeParc.Clear;
  edDataParc.Clear;
  edDiasParc.Clear;
  if StrToIntDef(edFopa.Text,0) > 0 then
    begin
      sqlaux.Close;
      sqlaux.SQL.Text:= 'select * from cadastro.Fopa where Fopa_codi = :codi '+
                        'and Fopa_empr = :empr and Fopa_loca = :loca';
      sqlaux.ParamByName('empr').AsInteger:= FormPrincipal.puempresa;
      sqlaux.ParamByName('loca').AsInteger:= FormPrincipal.pulocal;
      sqlaux.ParamByName('codi').AsInteger:= StrToIntDef(edFopa.Text,0);
      sqlaux.Open;
      if sqlaux.IsEmpty then
        begin
          ShowMessage('Forma de Pagamento não encontrado');
          Exit;
        end;
      edNomeFopa.Text:= sqlaux.FieldByName('Fopa_desc').AsString;
      edNumeParc.text:= sqlaux.FieldByName('fopa_nume_parc').AsString;
      edDataParc.Date:= Date + sqlaux.FieldByName('fopa_prim_dia').AsInteger;
      edDiasParc.Text:= sqlaux.FieldByName('fopa_dias_entr').AsString;
    end;
end;

procedure TFormEntrSaid.edFopaPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  edFopa.Text:= consulta('cons_formapagamento');
  edFopaexit(Self);
end;

procedure TFormEntrSaid.edMensExit(Sender: TObject);
begin
  edNomeMens.Clear;
  if StrToIntDef(edMens.Text,0) > 0 then
    begin
      sqlaux.Close;
      sqlaux.SQL.Text:= 'select mens_mens from cadastro.mens where mens_codi = :codi '+
                        'and mens_empr = :empr and mens_loca = :loca';
      sqlaux.ParamByName('empr').AsInteger:= formprincipal.puempresa;
      sqlaux.ParamByName('loca').asinteger:= FormPrincipal.pulocal;
      sqlaux.ParamByName('codi').AsInteger:= StrToIntDef(edMens.Text,0);
      sqlaux.Open;
      if sqlaux.IsEmpty then
        begin
          ShowMessage('Mensagem não encontrada');
          Exit;
        end;
      edNomeMens.Text:= sqlaux.FieldByName('mens_mens').AsString;
    end;
end;

procedure TFormEntrSaid.edMensPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  edMens.Text:= consulta('cons_mensagem');
  edMensexit(Self);
end;

procedure TFormEntrSaid.edNatuExit(Sender: TObject);
begin
  edNomeNatu.Clear;
  if StrToIntDef(ednatu.Text,0) > 0 then
   begin
     sqlaux.Close;
     sqlaux.SQL.Text:= 'select natu_desc, natu_mofi from cadastro.natu where natu_codi = :codi '+
                       'and natu_empr = :empr and natu_loca = :loca';
     sqlaux.ParamByName('empr').AsInteger:= FormPrincipal.puempresa;
     sqlaux.ParamByName('loca').AsInteger:= FormPrincipal.pulocal;
     sqlaux.ParamByName('codi').AsInteger:= StrToIntDef(edNatu.Text,0);
     sqlaux.Open;
     if sqlaux.IsEmpty then
       begin
         ShowMessage('Natureza de Operação não encontrada');
         Exit;
       end;
     edNomeNatu.Text:= sqlaux.FieldByName('natu_desc').AsString;
     if not sqlaux.FieldByName('natu_mofi').AsBoolean then
       quTable.FieldByName('movi_tipo_fina').AsInteger:= 9;
   end;
end;

procedure TFormEntrSaid.edNatuPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  edNatu.Text:= consulta('cons_cfop');
  edNatuexit(Self);
end;

procedure TFormEntrSaid.edParcExit(Sender: TObject);
begin
  if edParc.Text <> '' then
    btnGerar.Caption:= 'Gravar'
  else
   begin
     btnGerar.Caption:= 'Gerar';
     edValoParc.Clear;
   end;
end;

procedure TFormEntrSaid.edParcPropertiesChange(Sender: TObject);
begin
  if qufina.Locate('mofi_parc', edParc.Text, []) then
    begin
      edValoParc.Value:= qufina.FieldByName('mofi_valo_tota').AsFloat;
    end;
end;

procedure TFormEntrSaid.edProdExit(Sender: TObject);
begin
  edNomeProd.Clear;
  if StrToFloatdef(edProd.Text,0) > 0 then
    begin
      sqlaux.Close;
      sqlaux.SQL.Text:= 'select prod_desc, '+
                        '(select tapr_valo_vend from cadastro.tapr where tapr_prod = prod_codi) as "tapr_vend" '+
                        'from cadastro.prod where prod_codi = :prod';
      sqlaux.ParamByName('prod').AsFloat:= StrToFloatDef(edProd.Text,0);
      sqlaux.Open;
      if sqlaux.IsEmpty then
        begin
          ShowMessage('Produto não encontrado');
          Exit;
        end;
      edNomeProd.Text:= sqlaux.FieldByName('prod_desc').AsString;
      if edUnit.Value = 0 then
        edUnit.Value:= sqlaux.FieldByName('tapr_vend').AsFloat;
    end;
end;

procedure TFormEntrSaid.edProdPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  edProd.Text:= consulta('cons_produto');
  edprodexit(Self);
end;

procedure TFormEntrSaid.edSequExit(Sender: TObject);
begin
  if ActiveControl = cxGrid1 then Exit;

  if quImov.Locate('imov_empr;imov_loca;imov_sequ;imov_codi',VarArrayOf([formprincipal.puempresa,
                                                                         formprincipal.pulocal,
                                                                         StrToIntDef(edSequ.Text,0),
                                                                         strtointdef(qutable.fieldbyname('movi_codi').asstring,-9999)]),[]) then
   begin
     quimov.Edit;
     btnIncluir.Caption:= 'Gravar';
     edProd.Text:= quImov.FieldByName('imov_prod').AsString;
     edProdExit(Self);
     edQuan.EditValue:= quimov.FieldByName('imov_quan').AsFloat;
     edUnit.EditValue:= quimov.FieldByName('imov_unit').AsFloat;
     edCfop.Text:= quImov.FieldByName('imov_natu').AsString;
     edCfopExit(Self);
     edIpi.EditValue:= quimov.FieldByName('imov_aliq_ipi').AsFloat;
     edMva.EditValue:= quimov.FieldByName('imov_aliq_mva').AsFloat;
     edReduSt.EditValue:= quimov.FieldByName('imov_aliq_st').AsFloat;
   end else
    begin
      btnIncluir.Caption:= 'Incluir';
      edProd.Clear;
      edProdExit(Self);
      edQuan.text:= '0';
      edUnit.Value:= 0;
      edCfop.Clear;
      edCfopExit(Self);
      edIpi.Value:= 0;
      edMva.Value:= 0;
      edReduSt.Value:= 0;
    end;
end;

procedure TFormEntrSaid.edSeriExit(Sender: TObject);
begin
  edNomeseri.Clear;
  if StrToIntDef(edseri.Text,0) > 0 then
    begin
      sqlaux.Close;
      sqlaux.SQL.Text:= 'select seri_desc from cadastro.seri '+
                        'where seri_codi = :codi';
      sqlaux.ParamByName('codi').AsInteger:= StrToIntDef(edseri.Text,0);
      sqlaux.Open;
      if sqlaux.IsEmpty then
        begin
          ShowMessage('Série não encontrada');
          Exit;
        end;
      edNomeseri.Text:= sqlaux.FieldByName('seri_desc').AsString;
    end;
end;

procedure TFormEntrSaid.edSeriPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  edSeri.Text:= consulta('cons_serie');
  edseriexit(Self);
end;

procedure TFormEntrSaid.edTranExit(Sender: TObject);
begin
  edNometran.Clear;
  if StrToIntDef(edtran.Text,0) > 0 then
    begin
      sqlaux.Close;
      sqlaux.SQL.Text:= 'select enti_desc from cadastro.enti '+
                        'where enti_codi = :codi';
      sqlaux.ParamByName('codi').AsInteger:= StrToIntDef(edtran.Text,0);
      sqlaux.Open;
      if sqlaux.IsEmpty then
        begin
          ShowMessage('Entidade não encontrada');
          Exit;
        end;
      edNometran.Text:= sqlaux.FieldByName('enti_desc').AsString;
    end;
end;

procedure TFormEntrSaid.edTranPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  edTran.Text:= consulta('cons_entidade');
  edtranexit(Self);
end;

procedure TFormEntrSaid.edVeicExit(Sender: TObject);
begin
  edNomeveic.Clear;
  if StrToIntDef(edveic.Text,0) > 0 then
    begin
      sqlaux.Close;
      sqlaux.SQL.Text:= 'select veic_desc from cadastro.veic where veic_empr = :empr and veic_loca = :loca '+
                        'and veic_codi = :codi';
      sqlaux.ParamByName('codi').AsInteger:= StrToIntDef(edveic.Text,0);
      sqlaux.ParamByName('empr').AsInteger:= FormPrincipal.puempresa;
      sqlaux.ParamByName('loca').AsInteger:= FormPrincipal.pulocal;
      sqlaux.Open;
      if sqlaux.IsEmpty then
        begin
          ShowMessage('Veículo não encontrado');
          Exit;
        end;
      edNomeveic.Text:= sqlaux.FieldByName('veic_desc').AsString;
    end;
end;

procedure TFormEntrSaid.edVeicPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  edVeic.Text:= consulta('cons_veiculo');
  edVeicExit(Self);
end;

procedure TFormEntrSaid.edVendExit(Sender: TObject);
begin
  edNomevend.Clear;
  if StrToIntDef(edvend.Text,0) > 0 then
    begin
      sqlaux.Close;
      sqlaux.SQL.Text:= 'select enti_desc from cadastro.enti '+
                        'where enti_codi = :codi';
      sqlaux.ParamByName('codi').AsInteger:= StrToIntDef(edvend.Text,0);
      sqlaux.Open;
      if sqlaux.IsEmpty then
        begin
          ShowMessage('Vendedor não encontrada');
          Exit;
        end;
      edNomevend.Text:= sqlaux.FieldByName('enti_desc').AsString;
    end;
end;

procedure TFormEntrSaid.edVendPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  edVend.Text:= consulta('cons_entidade');
  edvendexit(Self);
end;

procedure TFormEntrSaid.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action:= cafree;
  FormEntrSaid:= nil;
end;

procedure TFormEntrSaid.FormShow(Sender: TObject);
begin
  // carrega os dados do form
  lbTitu.Caption               := 'Entrada / Saída';
  Caption                      := '..::PROG0021::..';
  v_tabela                     := 'movi';
  v_esquema                    := 'movimento';
  sb.Panels[0].Text            := 'Navegando...';
  controle.GroupName           := caption+' - '+lbtitu.Caption;
  cxPageControl2.ActivePageIndex:= 0;
end;

procedure TFormEntrSaid.quTableAfterCancel(DataSet: TDataSet);
begin
  sb.Panels[0].text:= 'Navegando...';
end;

procedure TFormEntrSaid.quTableAfterPost(DataSet: TDataSet);
begin
  sb.Panels[0].text:= 'Navegando...';
end;

procedure TFormEntrSaid.quTableAfterScroll(DataSet: TDataSet);
begin
  if quTable.Active then
    begin
      quImov.Close;
      quimov.ParamByName('empr').AsInteger:= FormPrincipal.puempresa;
      quimov.ParamByName('loca').AsInteger:= FormPrincipal.pulocal;
      quimov.ParamByName('codi').AsInteger:= StrToIntDef(quTable.FieldByName('movi_codi').AsString,-9999);
      quimov.Open;

      quFina.close;
      quFina.parambyname('empr').asinteger:= FormPrincipal.puempresa;
      quFina.parambyname('loca').AsInteger:= FormPrincipal.pulocal;
      quFina.ParamByName('titu').AsInteger:= quTable.FieldByName('movi_codi').AsInteger;
      qufina.Open;
    end;
end;

procedure TFormEntrSaid.quTableBeforeEdit(DataSet: TDataSet);
begin
  if quTable.FieldByName('movi_stat_nfe').AsInteger = 100 then
     sb.Panels[0].Text:= 'Não é possivel alterar, Nota Autorizada...'
  else
  if quTable.FieldByName('movi_stat_nfe').AsInteger = 101 then
     sb.Panels[0].Text:= 'Não é possivel alterar, Nota Cancelada...'
  else
  if quTable.FieldByName('movi_stat_nfe').AsInteger = 303 then
     sb.Panels[0].Text:= 'Não é possivel alterar, Nota Denegada...'
  else
  if quTable.FieldByName('movi_stat_nfe').AsInteger = 302 then
     sb.Panels[0].Text:= 'Não é possivel alterar, Nota Denegada...'
  else
     sb.Panels[0].text:= 'Editando registro...';
end;

procedure TFormEntrSaid.quTableBeforeInsert(DataSet: TDataSet);
begin
  if quTable.FieldByName('movi_stat_nfe').AsInteger = 100 then
     sb.Panels[0].Text:= 'Não é possivel alterar, Nota Autorizada...'
  else
  if quTable.FieldByName('movi_stat_nfe').AsInteger = 101 then
     sb.Panels[0].Text:= 'Não é possivel alterar, Nota Cancelada...'
  else
  if quTable.FieldByName('movi_stat_nfe').AsInteger = 303 then
     sb.Panels[0].Text:= 'Não é possivel alterar, Nota Denegada...'
  else
  if quTable.FieldByName('movi_stat_nfe').AsInteger = 302 then
     sb.Panels[0].Text:= 'Não é possivel alterar, Nota Denegada...'
  else
     sb.Panels[0].text:= 'Inserindo Registro...';
end;

end.
