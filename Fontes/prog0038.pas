unit prog0038;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, Menus, ACBrBase, ACBrEnterTab, UCBase, ComCtrls,
  StdCtrls, cxButtons, cxPC, cxLabel, dxGDIPlusClasses, ExtCtrls, cxCheckBox,
  cxTextEdit, cxMaskEdit, cxButtonEdit, DB, DBAccess, Uni, MemDS, RLReport,
  cxDropDownEdit, cxCalendar, dateutils, ELibFnc;

type
  TFormRelEntradaSaida = class(TForm)
    Image1: TImage;
    lbTitu: TcxLabel;
    cxTabControl1: TcxTabControl;
    btnFechar: TcxButton;
    btnImprimir: TcxButton;
    sb: TStatusBar;
    controle: TUCControls;
    ACBrEnterTab1: TACBrEnterTab;
    cxTabControl2: TcxTabControl;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    edEmpr: TcxButtonEdit;
    edNomeEmpr: TcxTextEdit;
    edNomeLoca: TcxTextEdit;
    edLoca: TcxButtonEdit;
    edProd: TcxButtonEdit;
    edNomeProd: TcxTextEdit;
    cxLabel3: TcxLabel;
    sqlaux: TUniQuery;
    dsaux: TUniDataSource;
    cxLabel4: TcxLabel;
    edInic: TcxDateEdit;
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
    RLLabel10: TRLLabel;
    RLLabel11: TRLLabel;
    RLLabel14: TRLLabel;
    RLLabel15: TRLLabel;
    RLBand4: TRLBand;
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLDBText3: TRLDBText;
    RLDBText6: TRLDBText;
    RLDBText7: TRLDBText;
    RLDBText10: TRLDBText;
    RLDBText11: TRLDBText;
    RLBand5: TRLBand;
    RLDBResult2: TRLDBResult;
    RLDBResult3: TRLDBResult;
    RLBand3: TRLBand;
    RLLabel4: TRLLabel;
    rlEmpresa: TRLLabel;
    EvLibFunctions1: TEvLibFunctions;
    edFina: TcxDateEdit;
    RLLabel8: TRLLabel;
    RLDBText4: TRLDBText;
    RLDBResult1: TRLDBResult;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edEmprPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure edEmprExit(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure edProdExit(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure edEntiPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure RLDBText3BeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormRelEntradaSaida: TFormRelEntradaSaida;

implementation

uses prog0003, rotinas, prog0001;

{$R *.dfm}

procedure TFormRelEntradaSaida.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFormRelEntradaSaida.btnImprimirClick(Sender: TObject);
begin
  sqlaux.Close;
  sqlaux.SQL.text:= 'select *, '+
                    '(entrada - saida) as "saldo" '+
                    'from movimento.vw_entr_said where empresa = :empr '+
                    'and data between :inic and :fina ';
  sqlaux.parambyname('empr').AsInteger:= StrToIntDef(edEmpr.Text,0);
  sqlaux.ParamByName('inic').asdatetime:= edinic.Date;
  sqlaux.ParamByName('fina').asdatetime:= edFina.Date;
  if StrToIntDef(edLoca.Text,0) > 0 then
   begin
     sqlaux.SQL.Add('and local = :loca ');
     sqlaux.ParamByName('loca').AsInteger:= FormPrincipal.pulocal;
   end;

  if StrToIntDef(edProd.Text,0) > 0 then
   begin
     sqlaux.SQL.Add('and prod_codi = :prod ');
     sqlaux.ParamByName('prod').asfloat:= StrToFloatdef(edProd.Text,0);
   end;
  sqlaux.Open;
  if sqlaux.IsEmpty then
   begin
     ShowMessage('Nenhum registro encontrado');
     Exit;
   end;
  imprimir(rlreport1,RLBand4);
end;

procedure TFormRelEntradaSaida.edEmprExit(Sender: TObject);
begin
  edNomeEmpr.Clear;
  if StrToIntDef(edEmpr.Text,0) > 0 then
   begin
     sqlaux.Close;
     sqlaux.SQL.Text:= 'select empr_raza from cadastro.empr where empr_codi = :codi';
     sqlaux.ParamByName('codi').AsInteger:= StrToIntDef(edEmpr.Text,0);
     sqlaux.Open;
     if sqlaux.IsEmpty then
      begin
        ShowMessage('Empresa não encontrada');
        Exit;
      end;
     edNomeEmpr.Text:= sqlaux.FieldByName('empr_raza').AsString;
   end;
end;

procedure TFormRelEntradaSaida.edEmprPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  edEmpr.Text:= consulta('cons_empresa');
  edemprexit(Self);
end;

procedure TFormRelEntradaSaida.edProdExit(Sender: TObject);
begin
  edNomeprod.Clear;
  if StrToIntDef(edprod.Text,0) > 0 then
   begin
     sqlaux.Close;
     sqlaux.SQL.Text:= 'select prod_desc from cadastro.prod where prod_codi = :codi';
     sqlaux.ParamByName('codi').AsInteger:= StrToIntDef(edprod.Text,0);
     sqlaux.Open;
     if sqlaux.IsEmpty then
      begin
        ShowMessage('Produto não encontrado');
        Exit;
      end;
     edNomeprod.Text:= sqlaux.FieldByName('prod_desc').AsString;
   end;
end;

procedure TFormRelEntradaSaida.edEntiPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  edProd.Text:= consulta('cons_produto');
  edProdExit(Self);
end;

procedure TFormRelEntradaSaida.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action:= caFree;
  FormRelEntradaSaida:= nil;
end;

procedure TFormRelEntradaSaida.FormShow(Sender: TObject);
begin
  caption:= '..::PROG0038::..';
  lbtitu.Caption:= 'Entrada x Saida';
  edEmpr.Text:= IntToStr(FormPrincipal.puempresa);
  edEmprExit(Self);
  edInic.Date:= BeginOfMonth(date);
  edFina.Date:= EndOfMonth(Date);

  sqlaux.Close;
  sqlaux.sql.Text:= 'select empr_raza, empr_logo from cadastro.empr where empr_codi = :codi';
  sqlaux.ParamByName('codi').AsInteger:= FormPrincipal.puempresa;
  sqlaux.Open;

  rlEmpresa.Caption:= sqlaux.FieldByName('empr_raza').AsString;
  rlLogo.Picture.LoadFromFile(sqlaux.FieldByName('empr_logo').AsString);
end;

procedure TFormRelEntradaSaida.RLDBText3BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  text:= FormatFloat('###,###,##0.00', StrToFloatDef(Text,0));
end;

end.
