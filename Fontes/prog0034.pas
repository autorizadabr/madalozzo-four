unit prog0034;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, Menus, ACBrBase, ACBrEnterTab, UCBase, ComCtrls,
  StdCtrls, cxButtons, cxPC, cxLabel, dxGDIPlusClasses, ExtCtrls, cxCheckBox,
  cxTextEdit, cxMaskEdit, cxButtonEdit, DB, DBAccess, Uni, MemDS, RLReport;

type
  TFormRelCidade = class(TForm)
    Image1: TImage;
    lbTitu: TcxLabel;
    cxTabControl1: TcxTabControl;
    btnFechar: TcxButton;
    btnImprimir: TcxButton;
    sb: TStatusBar;
    controle: TUCControls;
    ACBrEnterTab1: TACBrEnterTab;
    cxTabControl2: TcxTabControl;
    edCida: TcxButtonEdit;
    edNomeCida: TcxTextEdit;
    cxLabel3: TcxLabel;
    edAtiv: TcxCheckBox;
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
    RLDBText6: TRLDBText;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnImprimirClick(Sender: TObject);
    procedure edCidaExit(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure edEntiPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormRelCidade: TFormRelCidade;

implementation

uses prog0003, rotinas, prog0001;

{$R *.dfm}

procedure TFormRelCidade.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFormRelCidade.btnImprimirClick(Sender: TObject);
begin
  sqlaux.Close;
  sqlaux.SQL.Text:= 'select * from cadastro.cida where cida_codi > 0 ';
  if StrToIntDef(edCida.Text,0) > 0 then
   begin
     sqlaux.sql.Add('and cida_codi = :cida ');
     sqlaux.ParamByName('cida').AsInteger:= StrToIntDef(edCida.Text,0);
   end;
  if edAtiv.Checked then
   begin
     sqlaux.sql.Add('and cida_ativ is true ');
   end;
  sqlaux.SQL.Add('order by cida_codi');
  sqlaux.Open;
  imprimir(rlreport1,RLBand4);
end;

procedure TFormRelCidade.edCidaExit(Sender: TObject);
begin
  edNomecida.Clear;
  if StrToIntDef(edcida.Text,0) > 0 then
   begin
     sqlaux.Close;
     sqlaux.SQL.Text:= 'select cida_desc from cadastro.cida where cida_codi = :codi';
     sqlaux.ParamByName('codi').AsInteger:= StrToIntDef(edcida.Text,0);
     sqlaux.Open;
     if sqlaux.IsEmpty then
      begin
        ShowMessage('Cidade não encontrada');
        Exit;
      end;
     edNomecida.Text:= sqlaux.FieldByName('cida_desc').AsString;
   end;
end;

procedure TFormRelCidade.edEntiPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  edCida.Text:= consulta('cons_cidade');
  edCidaExit(Self);
end;

procedure TFormRelCidade.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action:= caFree;
  FormRelCidade:= nil;
end;

procedure TFormRelCidade.FormShow(Sender: TObject);
begin
  caption:= '..::PROG0034::..';
  lbtitu.Caption:= 'Relação de Cidades';

  sqlaux.Close;
  sqlaux.sql.Text:= 'select empr_raza, empr_logo from cadastro.empr where empr_codi = :codi';
  sqlaux.ParamByName('codi').AsInteger:= FormPrincipal.puempresa;
  sqlaux.Open;

  rlEmpresa.Caption:= sqlaux.FieldByName('empr_raza').AsString;
  rlLogo.Picture.LoadFromFile(sqlaux.FieldByName('empr_logo').AsString);
end;

end.
