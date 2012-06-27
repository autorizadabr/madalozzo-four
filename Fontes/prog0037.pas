unit prog0037;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, Menus, ACBrBase, ACBrEnterTab, UCBase, ComCtrls,
  StdCtrls, cxButtons, cxPC, cxLabel, dxGDIPlusClasses, ExtCtrls, cxCheckBox,
  cxTextEdit, cxMaskEdit, cxButtonEdit, DB, DBAccess, Uni, MemDS, RLReport,
  cxDropDownEdit, cxCalendar, dateutils, ELibFnc;

type
  TFormRelExtratoMovimento = class(TForm)
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
    edData: TcxDateEdit;
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
    RLLabel10: TRLLabel;
    RLLabel11: TRLLabel;
    RLLabel12: TRLLabel;
    RLLabel13: TRLLabel;
    RLLabel14: TRLLabel;
    RLLabel15: TRLLabel;
    RLLabel16: TRLLabel;
    RLLabel9: TRLLabel;
    RLLabel17: TRLLabel;
    RLBand4: TRLBand;
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    RLDBText6: TRLDBText;
    RLDBText7: TRLDBText;
    RLDBText8: TRLDBText;
    RLDBText9: TRLDBText;
    RLDBText10: TRLDBText;
    RLDBText11: TRLDBText;
    RLDBText12: TRLDBText;
    RLDBText5: TRLDBText;
    RLDBText13: TRLDBText;
    RLBand5: TRLBand;
    RLDBResult1: TRLDBResult;
    RLDBResult2: TRLDBResult;
    RLDBResult3: TRLDBResult;
    RLBand3: TRLBand;
    RLLabel4: TRLLabel;
    rlEmpresa: TRLLabel;
    EvLibFunctions1: TEvLibFunctions;
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
  FormRelExtratoMovimento: TFormRelExtratoMovimento;

implementation

uses prog0003, rotinas, prog0001;

{$R *.dfm}

procedure TFormRelExtratoMovimento.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFormRelExtratoMovimento.btnImprimirClick(Sender: TObject);
begin
  sqlaux.Close;
  sqlaux.SQL.text:= 'select * from movimento.fnc_extratro_movimento(:empr, :loca, :prod, :data) '+
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

  sqlaux.parambyname('empr').AsInteger:= StrToIntDef(edEmpr.Text,0);
  sqlaux.ParamByName('data').asdatetime:= edData.Date;

  if StrToIntDef(edLoca.Text,0) > 0 then
   begin
     sqlaux.ParamByName('loca').AsInteger:= FormPrincipal.pulocal;
   end else
    begin
      sqlaux.ParamByName('loca').AsInteger:= 0;
    end;
  if StrToIntDef(edProd.Text,0) > 0 then
   begin
     sqlaux.ParamByName('prod').asfloat:= StrToFloatdef(edProd.Text,0);
   end else
    begin
      sqlaux.ParamByName('prod').asfloat:= 0;
    end;
  sqlaux.SQL.Add('order by prod_codi');
  sqlaux.Open;
  imprimir(rlreport1,RLBand4);
end;

procedure TFormRelExtratoMovimento.edEmprExit(Sender: TObject);
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

procedure TFormRelExtratoMovimento.edEmprPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  edEmpr.Text:= consulta('cons_empresa');
  edemprexit(Self);
end;

procedure TFormRelExtratoMovimento.edProdExit(Sender: TObject);
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

procedure TFormRelExtratoMovimento.edEntiPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  edProd.Text:= consulta('cons_produto');
  edProdExit(Self);
end;

procedure TFormRelExtratoMovimento.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action:= caFree;
  FormRelExtratoMovimento:= nil;
end;

procedure TFormRelExtratoMovimento.FormShow(Sender: TObject);
begin
  caption:= '..::PROG0037::..';
  lbtitu.Caption:= 'Extrato de Movimento';
  edEmpr.Text:= IntToStr(FormPrincipal.puempresa);
  edEmprExit(Self);
  edData.Date:= EndOfMonth(Date);

  sqlaux.Close;
  sqlaux.sql.Text:= 'select empr_raza, empr_logo from cadastro.empr where empr_codi = :codi';
  sqlaux.ParamByName('codi').AsInteger:= FormPrincipal.puempresa;
  sqlaux.Open;

  rlEmpresa.Caption:= sqlaux.FieldByName('empr_raza').AsString;
  rlLogo.Picture.LoadFromFile(sqlaux.FieldByName('empr_logo').AsString);
end;

procedure TFormRelExtratoMovimento.RLDBText3BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  text:= FormatFloat('###,###,##0.00', StrToFloatDef(Text,0));
end;

end.
