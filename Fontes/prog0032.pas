unit prog0032;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, Menus, ACBrBase, ACBrEnterTab, UCBase, ComCtrls,
  StdCtrls, cxButtons, cxPC, cxLabel, dxGDIPlusClasses, ExtCtrls, cxCheckBox,
  cxTextEdit, cxMaskEdit, cxButtonEdit, DB, DBAccess, Uni, MemDS, RLReport;

type
  TFormRelEntidade = class(TForm)
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
    edEnti: TcxButtonEdit;
    edNomeEnti: TcxTextEdit;
    cxLabel3: TcxLabel;
    edVend: TcxButtonEdit;
    cxLabel4: TcxLabel;
    edNomeVend: TcxTextEdit;
    edTien: TcxButtonEdit;
    cxLabel5: TcxLabel;
    edNomeTien: TcxTextEdit;
    edCida: TcxButtonEdit;
    cxLabel6: TcxLabel;
    edNomeCida: TcxTextEdit;
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
    edOrde: TcxCheckBox;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edEmprPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure edEmprExit(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure edEntiExit(Sender: TObject);
    procedure edCidaExit(Sender: TObject);
    procedure edTienExit(Sender: TObject);
    procedure edVendExit(Sender: TObject);
    procedure edGrupPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure edSugrPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure edGenePropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure btnFecharClick(Sender: TObject);
    procedure edEntiPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormRelEntidade: TFormRelEntidade;

implementation

uses prog0003, rotinas, prog0001;

{$R *.dfm}

procedure TFormRelEntidade.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFormRelEntidade.btnImprimirClick(Sender: TObject);
begin
  sqlaux.Close;
  sqlaux.SQL.Text:= 'select * from cadastro.enti where enti_codi > 0 ';
  if StrToIntDef(edEmpr.Text,0) > 0 then
   begin
     sqlaux.sql.Add('and enti_empr = :empr ');
     sqlaux.ParamByName('empr').AsInteger:= StrToIntDef(edEmpr.Text,0);
   end;
  if StrToIntDef(edenti.Text,0) > 0 then
   begin
     sqlaux.sql.Add('and enti_codi = :enti ');
     sqlaux.ParamByName('enti').AsInteger:= StrToIntDef(edenti.Text,0);
   end;
  if StrToIntDef(edCida.Text,0) > 0 then
   begin
     sqlaux.sql.Add('and enti_cida = :cida ');
     sqlaux.ParamByName('cida').AsInteger:= StrToIntDef(edCida.Text,0);
   end;
  if StrToIntDef(edTien.Text,0) > 0 then
   begin
     sqlaux.sql.Add('and enti_tipo = :tipo ');
     sqlaux.ParamByName('tipo').AsInteger:= StrToIntDef(edTien.Text,0);
   end;
  if StrToIntDef(edVend.Text,0) > 0 then
   begin
     sqlaux.sql.Add('and enti_vend = :vend ');
     sqlaux.ParamByName('vend').AsInteger:= StrToIntDef(edVend.Text,0);
   end;
  if edAtiv.Checked then
   begin
     sqlaux.sql.Add('and enti_ativ is true ');
   end;
  if edOrde.Checked then
    sqlaux.SQL.Add('order by enti_desc')
  else
    sqlaux.SQL.Add('order by enti_codi');

  sqlaux.Open;
  imprimir(rlreport1,RLBand4);
end;

procedure TFormRelEntidade.edEmprExit(Sender: TObject);
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

procedure TFormRelEntidade.edEmprPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  edEmpr.Text:= consulta('cons_empresa');
  edemprexit(Self);
end;

procedure TFormRelEntidade.edVendExit(Sender: TObject);
begin
  edNomevend.Clear;
  if StrToIntDef(edvend.Text,0) > 0 then
   begin
     sqlaux.Close;
     sqlaux.SQL.Text:= 'select enti_desc from cadastro.enti where enti_codi = :codi';
     sqlaux.ParamByName('codi').AsInteger:= StrToIntDef(edvend.Text,0);
     sqlaux.Open;
     if sqlaux.IsEmpty then
      begin
        ShowMessage('Vendedor não encontrado');
        Exit;
      end;
     edNomevend.Text:= sqlaux.FieldByName('enti_desc').AsString;
   end;

end;

procedure TFormRelEntidade.edGenePropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  edvend.Text:= consulta('cons_entidade');
  edVendExit(Self);
end;

procedure TFormRelEntidade.edCidaExit(Sender: TObject);
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

procedure TFormRelEntidade.edGrupPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  edCida.Text:= consulta('cons_cidade');
  edCidaExit(Self);
end;

procedure TFormRelEntidade.edEntiExit(Sender: TObject);
begin
  edNomeenti.Clear;
  if StrToIntDef(edenti.Text,0) > 0 then
   begin
     sqlaux.Close;
     sqlaux.SQL.Text:= 'select enti_desc from cadastro.enti where enti_codi = :codi';
     sqlaux.ParamByName('codi').AsInteger:= StrToIntDef(edenti.Text,0);
     sqlaux.Open;
     if sqlaux.IsEmpty then
      begin
        ShowMessage('Entidade não encontrada');
        Exit;
      end;
     edNomeenti.Text:= sqlaux.FieldByName('enti_desc').AsString;
   end;
end;

procedure TFormRelEntidade.edEntiPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  edEnti.Text:= consulta('cons_entidade');
  edEntiExit(Self);
end;

procedure TFormRelEntidade.edTienExit(Sender: TObject);
begin
  edNometien.Clear;
  if StrToIntDef(edtien.Text,0) > 0 then
   begin
     sqlaux.Close;
     sqlaux.SQL.Text:= 'select tien_desc from cadastro.tien where tien_codi = :codi';
     sqlaux.ParamByName('codi').AsInteger:= StrToIntDef(edtien.Text,0);
     sqlaux.Open;
     if sqlaux.IsEmpty then
      begin
        ShowMessage('Tipo de Entidade não encontrada');
        Exit;
      end;
     edNometien.Text:= sqlaux.FieldByName('tien_desc').AsString;
   end;

end;

procedure TFormRelEntidade.edSugrPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  edTien.Text:= consulta('cons_tipoentidade');
  edTienExit(Self);
end;

procedure TFormRelEntidade.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action:= caFree;
  FormRelEntidade:= nil;
end;

procedure TFormRelEntidade.FormShow(Sender: TObject);
begin
  caption:= '..::PROG0032::..';
  lbtitu.Caption:= 'Relação de Entidades';

  sqlaux.Close;
  sqlaux.sql.Text:= 'select empr_raza, empr_logo from cadastro.empr where empr_codi = :codi';
  sqlaux.ParamByName('codi').AsInteger:= FormPrincipal.puempresa;
  sqlaux.Open;

  rlEmpresa.Caption:= sqlaux.FieldByName('empr_raza').AsString;
  rlLogo.Picture.LoadFromFile(sqlaux.FieldByName('empr_logo').AsString);
end;

end.
