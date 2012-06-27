unit prog0042;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, Menus, StdCtrls, cxButtons, cxPC, cxLabel,
  dxGDIPlusClasses, ExtCtrls, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, DB, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  cxDropDownEdit, cxImageComboBox, cxCalendar, cxTextEdit, cxMaskEdit,
  cxButtonEdit, cxCurrencyEdit, DBAccess, Uni, MemDS, ELibFnc, RLReport,
  ACBrBase, ACBrEnterTab, cxGridExportLink;

type
  TFormConsultaReceber = class(TForm)
    Image1: TImage;
    titulo: TcxLabel;
    cxTabControl1: TcxTabControl;
    btnFechar: TcxButton;
    cxTabControl2: TcxTabControl;
    cxTabControl3: TcxTabControl;
    btnConsultar: TcxButton;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    cxLabel1: TcxLabel;
    edEnti: TcxButtonEdit;
    edNomeEnti: TcxTextEdit;
    cxLabel2: TcxLabel;
    cxLabel3: TcxLabel;
    edEmisInic: TcxDateEdit;
    edEmisFina: TcxDateEdit;
    edVencFina: TcxDateEdit;
    edVencInic: TcxDateEdit;
    cxLabel4: TcxLabel;
    cxLabel5: TcxLabel;
    edTipo: TcxImageComboBox;
    cxLabel6: TcxLabel;
    edProrInic: TcxDateEdit;
    edProrFina: TcxDateEdit;
    cxLabel7: TcxLabel;
    cxLabel8: TcxLabel;
    cxGrid1DBTableView1Column1: TcxGridDBColumn;
    cxGrid1DBTableView1Column2: TcxGridDBColumn;
    cxGrid1DBTableView1Column3: TcxGridDBColumn;
    cxGrid1DBTableView1Column4: TcxGridDBColumn;
    cxGrid1DBTableView1Column5: TcxGridDBColumn;
    cxGrid1DBTableView1Column6: TcxGridDBColumn;
    cxGrid1DBTableView1Column7: TcxGridDBColumn;
    cxGrid1DBTableView1Column8: TcxGridDBColumn;
    cxGrid1DBTableView1Column9: TcxGridDBColumn;
    sqlaux: TUniQuery;
    dsAux: TUniDataSource;
    EvLibFunctions1: TEvLibFunctions;
    btnImprimir: TcxButton;
    btnExportar: TcxButton;
    RLReport1: TRLReport;
    RLBand1: TRLBand;
    RLLabel1: TRLLabel;
    rlLogo: TRLImage;
    RLSystemInfo1: TRLSystemInfo;
    RLSystemInfo2: TRLSystemInfo;
    lbTitu: TRLLabel;
    RLLabel3: TRLLabel;
    RLGroup1: TRLGroup;
    RLBand2: TRLBand;
    RLLabel5: TRLLabel;
    RLLabel6: TRLLabel;
    RLLabel7: TRLLabel;
    RLLabel8: TRLLabel;
    RLLabel9: TRLLabel;
    RLBand4: TRLBand;
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    RLDBText5: TRLDBText;
    RLBand3: TRLBand;
    RLLabel4: TRLLabel;
    rlEmpresa: TRLLabel;
    RLLabel2: TRLLabel;
    RLLabel10: TRLLabel;
    RLLabel11: TRLLabel;
    RLLabel12: TRLLabel;
    RLLabel13: TRLLabel;
    RLLabel14: TRLLabel;
    RLDBText6: TRLDBText;
    RLDBText7: TRLDBText;
    RLDBText8: TRLDBText;
    RLDBText9: TRLDBText;
    RLDBText10: TRLDBText;
    RLDBText11: TRLDBText;
    RLBand5: TRLBand;
    RLDBResult1: TRLDBResult;
    RLDBResult2: TRLDBResult;
    RLDBResult3: TRLDBResult;
    RLLabel15: TRLLabel;
    ACBrEnterTab1: TACBrEnterTab;
    cxGrid1DBTableView1Column10: TcxGridDBColumn;
    sd: TSaveDialog;
    procedure btnFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxGrid1DBTableView1CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure btnConsultarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edEntiPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure edEntiExit(Sender: TObject);
    procedure RLDBText10BeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure btnImprimirClick(Sender: TObject);
    procedure btnExportarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormConsultaReceber: TFormConsultaReceber;

implementation

uses prog0003, prog0001, rotinas;

{$R *.dfm}

procedure TFormConsultaReceber.btnConsultarClick(Sender: TObject);
begin
  sqlaux.close;
  sqlaux.sql.text:= 'select *, '+
                    '(select enti_desc from cadastro.enti where enti_codi = mofi_enti) as "enti_desc"' +
                    'from movimento.mofi where mofi_emis between :emisinic and :emisfina '+
                    'and mofi_venc between :vencinic and :vencfina and mofi_pror between :prorinic and :prorfina '+
                    'and mofi_empr = :empr and mofi_loca = :loca and mofi_tipo = ''S'' ';
  sqlaux.parambyname('empr').asinteger:= formprincipal.puempresa;
  sqlaux.parambyname('loca').asinteger:= formprincipal.pulocal;
  sqlaux.parambyname('emisinic').asdatetime:= edemisinic.date;
  sqlaux.parambyname('emisfina').asdatetime:= edemisfina.date;
  sqlaux.parambyname('vencinic').asdatetime:= edvencinic.date;
  sqlaux.parambyname('vencfina').asdatetime:= edvencfina.date;
  sqlaux.parambyname('prorinic').asdatetime:= edprorinic.date;
  sqlaux.parambyname('prorfina').asdatetime:= edprorfina.date;

  if StrToIntDef(edEnti.Text,0) > 0 then
   begin
     sqlaux.SQL.Add('and mofi_enti = :enti ');
     sqlaux.ParamByName('enti').AsInteger:= StrToIntDef(edEnti.Text,0);
   end;

  if edTipo.EditValue <> 3 then
    sqlaux.SQL.Add('and mofi_stat = :stat ');

  case edtipo.EditValue of
    0 : sqlaux.parambyname('stat').asstring := 'T';
    1 : sqlaux.parambyname('stat').asstring := 'P';
    2 : sqlaux.parambyname('stat').asstring := 'A';
    9 : sqlaux.parambyname('stat').asstring := 'R';
  end;
  sqlaux.open;
end;

procedure TFormConsultaReceber.btnExportarClick(Sender: TObject);
begin
  if sd.execute then
   begin
     case sd.FilterIndex of
       1 : ExportGridToExcel(sd.filename,cxGrid1);
       2 : ExportGridToHTML(sd.filename,cxGrid1);
       3 : ExportGridToText(sd.filename,cxGrid1);
       4 : ExportGridToXML(sd.filename,cxGrid1);
     end;
   end;
end;

procedure TFormConsultaReceber.btnFecharClick(Sender: TObject);
begin
  close;
end;

procedure TFormConsultaReceber.btnImprimirClick(Sender: TObject);
begin
  imprimir(rlreport1,RLBand4);
end;

procedure TFormConsultaReceber.cxGrid1DBTableView1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  If AViewInfo.GridRecord.RecordIndex mod 2 = 0 Then
    ACanvas.Brush.Color := $FFFAFA
  Else
    ACanvas.Brush.Color := $CDC9C9;

  ACanvas.Font.Color := clBlack;
end;

procedure TFormConsultaReceber.edEntiExit(Sender: TObject);
begin
  edNomeEnti.Clear;
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
    end;
end;

procedure TFormConsultaReceber.edEntiPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  edenti.text:= consulta('cons_entidade');
  edentiexit(self);
end;

procedure TFormConsultaReceber.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  cxGrid1DBTableView1.StoreToRegistry('prog0041');

  action:= cafree;
  FormConsultaReceber:= nil;
end;

procedure TFormConsultaReceber.FormShow(Sender: TObject);
begin
  cxGrid1DBTableView1.RestoreFromRegistry('prog0041');

  edemisinic.date:= encodedate(1500,01,01);
  edemisfina.date:= encodedate(2100,12,31);
  edvencinic.date:= beginofmonth(date);
  edvencfina.date:= endofmonth(date);
  edprorinic.date:= encodedate(1500,01,01);
  edprorfina.date:= encodedate(2100,12,31);

  caption:= '..::PROG0042::..';
  lbtitu.Caption:= 'Titutlos a Receber';

  sqlaux.Close;
  sqlaux.sql.Text:= 'select empr_raza, empr_logo from cadastro.empr where empr_codi = :codi';
  sqlaux.ParamByName('codi').AsInteger:= FormPrincipal.puempresa;
  sqlaux.Open;

  rlEmpresa.Caption:= sqlaux.FieldByName('empr_raza').AsString;
  rlLogo.Picture.LoadFromFile(sqlaux.FieldByName('empr_logo').AsString);
end;

procedure TFormConsultaReceber.RLDBText10BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  text:= FormatCurr('###,###,##0.00', StrToCurrdef(Text,0));
end;

end.
