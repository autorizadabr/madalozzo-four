unit prog0039;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, Menus, ACBrBase, ACBrEnterTab, UCBase, ComCtrls,
  StdCtrls, cxButtons, cxPC, cxLabel, dxGDIPlusClasses, ExtCtrls, cxCheckBox,
  cxTextEdit, cxMaskEdit, cxButtonEdit, DB, DBAccess, Uni, MemDS, RLReport,
  cxDropDownEdit, cxCalendar, dateutils, ELibFnc;

type
  TFormSituacaoEstoque = class(TForm)
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
    RLLabel10: TRLLabel;
    RLLabel11: TRLLabel;
    RLLabel14: TRLLabel;
    RLLabel15: TRLLabel;
    RLBand4: TRLBand;
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLDBText6: TRLDBText;
    RLDBText7: TRLDBText;
    RLDBText10: TRLDBText;
    RLDBText11: TRLDBText;
    RLBand3: TRLBand;
    RLLabel4: TRLLabel;
    rlEmpresa: TRLLabel;
    EvLibFunctions1: TEvLibFunctions;
    RLLabel8: TRLLabel;
    RLDBText4: TRLDBText;
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
    procedure RLBand4BeforePrint(Sender: TObject; var PrintIt: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormSituacaoEstoque: TFormSituacaoEstoque;

implementation

uses prog0003, rotinas, prog0001;

{$R *.dfm}

procedure TFormSituacaoEstoque.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFormSituacaoEstoque.btnImprimirClick(Sender: TObject);
begin
  sqlaux.Close;
  sqlaux.SQL.text:= 'select * from movimento.prog0039 where empresa = :empr ';
  sqlaux.parambyname('empr').AsInteger:= StrToIntDef(edEmpr.Text,0);
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
  imprimir(rlreport1,RLBand4,False);
end;

procedure TFormSituacaoEstoque.edEmprExit(Sender: TObject);
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

procedure TFormSituacaoEstoque.edEmprPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  edEmpr.Text:= consulta('cons_empresa');
  edemprexit(Self);
end;

procedure TFormSituacaoEstoque.edProdExit(Sender: TObject);
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

procedure TFormSituacaoEstoque.edEntiPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  edProd.Text:= consulta('cons_produto');
  edProdExit(Self);
end;

procedure TFormSituacaoEstoque.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action:= caFree;
  FormSituacaoEstoque:= nil;
end;

procedure TFormSituacaoEstoque.FormShow(Sender: TObject);
begin
  caption:= '..::PROG0039::..';
  lbtitu.Caption:= 'Situação do Estoque';
  edEmpr.Text:= IntToStr(FormPrincipal.puempresa);
  edEmprExit(Self);

  sqlaux.Close;
  sqlaux.sql.Text:= 'select empr_raza, empr_logo from cadastro.empr where empr_codi = :codi';
  sqlaux.ParamByName('codi').AsInteger:= FormPrincipal.puempresa;
  sqlaux.Open;

  rlEmpresa.Caption:= sqlaux.FieldByName('empr_raza').AsString;
  rlLogo.Picture.LoadFromFile(sqlaux.FieldByName('empr_logo').AsString);
end;

procedure TFormSituacaoEstoque.RLBand4BeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  if sqlaux.FieldByName('saldo').AsFloat < sqlaux.FieldByName('prod_mini').AsFloat then
   begin
     RLBand4.Color:= clRed;
   end else
  if sqlaux.FieldByName('saldo').AsFloat > sqlaux.FieldByName('prod_maxi').AsFloat then
   begin
     RLBand4.Color:= clLime;
   end else
     RLBand4.Color:= clWhite;
end;

procedure TFormSituacaoEstoque.RLDBText3BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  text:= FormatFloat('###,###,##0.00', StrToFloatDef(Text,0));
end;

end.
