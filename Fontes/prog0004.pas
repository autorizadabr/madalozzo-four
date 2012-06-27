unit prog0004;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinCaramel,
  dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinXmas2008Blue, dxSkinscxPCPainter, Menus, cxPC, ComCtrls, StdCtrls,
  cxButtons, cxLabel, dxGDIPlusClasses, ExtCtrls, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, DB,
  cxDBData, cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, DBAccess, Uni, MemDS, ACBrBase,
  ACBrEnterTab;

type
  TFormConsulta = class(TForm)
    Image1: TImage;
    titulo: TcxLabel;
    cxTabControl1: TcxTabControl;
    btnFechar: TcxButton;
    cxPageControl1: TcxPageControl;
    cxTabControl2: TcxTabControl;
    edForm: TcxComboBox;
    edCons: TcxTextEdit;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    qConsulta: TUniQuery;
    dsConsulta: TUniDataSource;
    ACBrEnterTab1: TACBrEnterTab;
    cxGrid1: TcxGrid;
    grid: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    lbCount: TLabel;
    procedure btnFecharClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure gridCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure edConsPropertiesChange(Sender: TObject);
    procedure gridCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure qConsultaAfterScroll(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormConsulta: TFormConsulta;

implementation

uses prog0003, prog0001;

{$R *.dfm}

procedure TFormConsulta.btnFecharClick(Sender: TObject);
begin
  close;
end;

procedure TFormConsulta.edConsPropertiesChange(Sender: TObject);
begin
  qconsulta.Locate(edform.Text,edcons.Text,[]);
end;

procedure TFormConsulta.FormCreate(Sender: TObject);
begin
  grid.ClearItems;
  edform.Clear;
  edcons.Clear;
end;

procedure TFormConsulta.FormShow(Sender: TObject);
var
  i : integer;
begin
  //carrega as colunas da consulta
  grid.DataController.CreateAllItems();

  // carrega forma de consulta
  for i:= 0 to grid.ItemCount -1 do
   begin
     edform.Properties.Items.Add(grid.Columns[i].DataBinding.FieldName);
   end;

  edform.ItemIndex:= 0;
  edcons.SetFocus;
end;

procedure TFormConsulta.gridCellDblClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
  AShift: TShiftState; var AHandled: Boolean);
begin
  btnFecharClick(self);
end;

procedure TFormConsulta.gridCustomDrawCell(Sender: TcxCustomGridTableView;
  ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
  var ADone: Boolean);
begin
  If AViewInfo.GridRecord.RecordIndex mod 2 = 0 Then
    ACanvas.Brush.Color := $FFFAFA
  Else
    ACanvas.Brush.Color := $CDC9C9;

  ACanvas.Font.Color := clBlack;
end;

procedure TFormConsulta.qConsultaAfterScroll(DataSet: TDataSet);
begin
  lbCount.Caption:= 'Nº de Registros: '+inttostr(qconsulta.RecordCount);
end;

end.
