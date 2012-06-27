unit prog0025;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, Menus, ComCtrls, StdCtrls, cxButtons, cxPC, cxLabel,
  dxGDIPlusClasses, ExtCtrls, cxCurrencyEdit, cxDropDownEdit, cxCalendar,
  cxTextEdit, cxMaskEdit, cxButtonEdit, ACBrBase, ACBrEnterTab, DB, DBAccess,
  Uni, MemDS, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxGridCustomView, cxGrid, cxCheckBox, RLReport, dateutils, ELibFnc;

type
  TFormExtratoMovimento = class(TForm)
    Image1: TImage;
    lbTitu: TcxLabel;
    cxTabControl1: TcxTabControl;
    btnFechar: TcxButton;
    btnConsulta: TcxButton;
    sb: TStatusBar;
    cxTabControl2: TcxTabControl;
    cxTabControl3: TcxTabControl;
    cxTabControl4: TcxTabControl;
    edProd: TcxButtonEdit;
    cxLabel1: TcxLabel;
    edNomeProd: TcxTextEdit;
    cxLabel2: TcxLabel;
    cxLabel3: TcxLabel;
    edData: TcxDateEdit;
    quExtr: TUniQuery;
    dsExtr: TUniDataSource;
    ACBrEnterTab1: TACBrEnterTab;
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
    cxGrid1DBTableView1Column11: TcxGridDBColumn;
    sqlaux: TUniQuery;
    edEsto: TcxCheckBox;
    RLReport1: TRLReport;
    RLBand1: TRLBand;
    RLLabel1: TRLLabel;
    rlLogo: TRLImage;
    RLSystemInfo1: TRLSystemInfo;
    RLSystemInfo2: TRLSystemInfo;
    RLLabel2: TRLLabel;
    RLLabel3: TRLLabel;
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
    RLBand3: TRLBand;
    RLLabel4: TRLLabel;
    rlEmpresa: TRLLabel;
    RLLabel10: TRLLabel;
    RLLabel11: TRLLabel;
    RLDBText6: TRLDBText;
    RLDBText7: TRLDBText;
    RLLabel12: TRLLabel;
    RLLabel13: TRLLabel;
    RLLabel14: TRLLabel;
    RLLabel15: TRLLabel;
    RLLabel16: TRLLabel;
    RLDBText8: TRLDBText;
    RLDBText9: TRLDBText;
    RLDBText10: TRLDBText;
    RLDBText11: TRLDBText;
    RLDBText12: TRLDBText;
    RLBand5: TRLBand;
    RLDBResult1: TRLDBResult;
    RLDBResult2: TRLDBResult;
    RLDBResult3: TRLDBResult;
    btnImprimir: TcxButton;
    cxGrid1DBTableView1Column12: TcxGridDBColumn;
    cxGrid1DBTableView1Column13: TcxGridDBColumn;
    RLLabel9: TRLLabel;
    RLDBText5: TRLDBText;
    RLLabel17: TRLLabel;
    RLDBText13: TRLDBText;
    EvLibFunctions1: TEvLibFunctions;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnFecharClick(Sender: TObject);
    procedure edDataExit(Sender: TObject);
    procedure edProdExit(Sender: TObject);
    procedure edProdPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure btnConsultaClick(Sender: TObject);
    procedure cxGrid1DBTableView1CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure btnImprimirClick(Sender: TObject);
    procedure RLDBText10BeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormExtratoMovimento: TFormExtratoMovimento;

implementation

uses prog0001, prog0003, rotinas;

{$R *.dfm}

procedure TFormExtratoMovimento.btnConsultaClick(Sender: TObject);
begin
  quExtr.Close;
  quExtr.SQL.text:= 'select * from movimento.fnc_extratro_movimento(:empr, :loca, :prod, :data) '+
                    '              as '+
                    '              (empresa integer, '+
                    '              local integer, '+
                    '              titulo integer, '+
                    '              data date, '+
                    '              serie varchar, '+
                    '              prod_codi numeric, '+
                    '              prod_desc varchar, '+
                    '              quan_entr numeric, '+
                    '              quan_said numeric, '+
                    '              tipo varchar, '+
                    '              valor numeric, '+
                    '              saldo_anterior numeric, '+
                    '              saldo_atual numeric)';

  quExtr.parambyname('empr').AsInteger:= FormPrincipal.puempresa;
  quExtr.ParamByName('data').asdatetime:= edData.Date;
  if not edesto.Checked then
   begin
     quExtr.ParamByName('loca').AsInteger:= 0;
   end else
    begin
      quExtr.ParamByName('loca').AsInteger:= FormPrincipal.pulocal;
    end;

  if StrToIntDef(edProd.Text,0) > 0 then
   begin
     quExtr.ParamByName('prod').asfloat:= StrToFloatdef(edProd.Text,0);
   end else
    begin
      quExtr.ParamByName('prod').asfloat:= 0;
    end;
  quExtr.Open;
end;

procedure TFormExtratoMovimento.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFormExtratoMovimento.btnImprimirClick(Sender: TObject);
begin
  quExtr.DisableControls;
  Imprimir(RLReport1,RLBand4);
  quExtr.EnableControls;
end;

procedure TFormExtratoMovimento.cxGrid1DBTableView1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  If AViewInfo.GridRecord.RecordIndex mod 2 = 0 Then
    ACanvas.Brush.Color := $FFFAFA
  Else
    ACanvas.Brush.Color := $CDC9C9;

  ACanvas.Font.Color := clBlack;
end;

procedure TFormExtratoMovimento.edDataExit(Sender: TObject);
begin
  btnConsulta.SetFocus;
end;

procedure TFormExtratoMovimento.edProdExit(Sender: TObject);
begin
  edNomeProd.Clear;
  if StrToFloatdef(edProd.Text,0) > 0 then
    begin
      sqlaux.Close;
      sqlaux.SQL.Text:= 'select prod_desc from cadastro.prod where prod_codi = :prod';
      sqlaux.ParamByName('prod').AsFloat:= StrToFloatDef(edProd.Text,0);
      sqlaux.Open;
      if sqlaux.IsEmpty then
        begin
          ShowMessage('Produto não encontrado');
          Exit;
        end;
      edNomeProd.Text:= sqlaux.FieldByName('prod_desc').AsString;
    end;
end;

procedure TFormExtratoMovimento.edProdPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  edProd.Text:= consulta('cons_produto');
  edProdExit(Self);
end;

procedure TFormExtratoMovimento.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action:= caFree;
  FormExtratoMovimento:= nil;
end;

procedure TFormExtratoMovimento.FormShow(Sender: TObject);
begin
  sqlaux.Close;
  sqlaux.sql.Text:= 'select empr_raza, empr_logo from cadastro.empr where empr_codi = :codi';
  sqlaux.ParamByName('codi').AsInteger:= FormPrincipal.puempresa;
  sqlaux.Open;

  edData.Date:= EndOfMonth(Date);
  rlEmpresa.Caption:= sqlaux.FieldByName('empr_raza').AsString;
  rlLogo.Picture.LoadFromFile(sqlaux.FieldByName('empr_logo').AsString);
end;

procedure TFormExtratoMovimento.RLDBText10BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  text:= FormatFloat('###,###,##0.00', StrToFloatDef(Text,0));
end;

end.
