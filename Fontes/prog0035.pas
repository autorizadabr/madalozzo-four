unit prog0035;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, Menus, ACBrBase, ACBrEnterTab, UCBase, ComCtrls,
  StdCtrls, cxButtons, cxPC, cxLabel, dxGDIPlusClasses, ExtCtrls, cxCheckBox,
  cxTextEdit, cxMaskEdit, cxButtonEdit, DB, DBAccess, Uni, MemDS, RLReport;

type
  TFormRelTabelaPreco = class(TForm)
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
    edGene: TcxButtonEdit;
    cxLabel4: TcxLabel;
    edNomeGene: TcxTextEdit;
    edSugr: TcxButtonEdit;
    cxLabel5: TcxLabel;
    edNomeSugr: TcxTextEdit;
    edGrup: TcxButtonEdit;
    cxLabel6: TcxLabel;
    edNomeGrup: TcxTextEdit;
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
    edSald: TcxCheckBox;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edEmprPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure edEmprExit(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure edProdExit(Sender: TObject);
    procedure edGrupExit(Sender: TObject);
    procedure edSugrExit(Sender: TObject);
    procedure edGeneExit(Sender: TObject);
    procedure edGrupPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure edSugrPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure edGenePropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure btnFecharClick(Sender: TObject);
    procedure edEntiPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure RLDBText3BeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure RLDBText4BeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormRelTabelaPreco: TFormRelTabelaPreco;

implementation

uses prog0003, rotinas, prog0001;

{$R *.dfm}

procedure TFormRelTabelaPreco.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFormRelTabelaPreco.btnImprimirClick(Sender: TObject);
begin
  sqlaux.Close;
  sqlaux.SQL.Text:= 'select x.* from (select *, '+
                    '(select saldo from movimento.vw_esto v '+
                    '  where v.prod_codi = p.prod_codi '+
                    '    and v.empresa = p.prod_empr '+
                    '    and v.local = p.prod_loca) as "saldo", '+
                    '(select tapr_valo_vend from cadastro.tapr '+
                    '  where tapr_prod = p.prod_codi '+
                    '    and tapr_empr = p.prod_empr '+
                    '    and tapr_loca = p.prod_loca) as "valor_venda", '+
                    '(select tapr_valo_praz from cadastro.tapr '+
                    '  where tapr_prod = p.prod_codi '+
                    '    and tapr_empr = p.prod_empr '+
                    '    and tapr_loca = p.prod_loca) as "valor_prazo" '+
                    'from cadastro.prod p)x where x.prod_codi > 0 ';
  if StrToIntDef(edEmpr.Text,0) > 0 then
   begin
     sqlaux.sql.Add('and x.prod_empr = :empr ');
     sqlaux.ParamByName('empr').AsInteger:= StrToIntDef(edEmpr.Text,0);
   end;
  if StrToIntDef(edProd.Text,0) > 0 then
   begin
     sqlaux.sql.Add('and x.prod_codi = :prod ');
     sqlaux.ParamByName('prod').AsInteger:= StrToIntDef(edProd.Text,0);
   end;
  if StrToIntDef(edGrup.Text,0) > 0 then
   begin
     sqlaux.sql.Add('and x.prod_Grup = :Grup ');
     sqlaux.ParamByName('Grup').AsInteger:= StrToIntDef(edGrup.Text,0);
   end;
  if StrToIntDef(edSugr.Text,0) > 0 then
   begin
     sqlaux.sql.Add('and x.prod_Sugr = :Sugr ');
     sqlaux.ParamByName('Sugr').AsInteger:= StrToIntDef(edSugr.Text,0);
   end;
  if StrToIntDef(edGene.Text,0) > 0 then
   begin
     sqlaux.sql.Add('and x.prod_Gene = :Gene ');
     sqlaux.ParamByName('Gene').AsInteger:= StrToIntDef(edGene.Text,0);
   end;
  if edAtiv.Checked then
   begin
     sqlaux.sql.Add('and x.prod_ativ is true ');
   end;
  if edsald.Checked then
   begin
     sqlaux.SQL.Add('and x.saldo > 0 ');
   end;
  sqlaux.SQL.Add('order by prod_codi');
  sqlaux.Open;
  imprimir(rlreport1,rlband4);
end;

procedure TFormRelTabelaPreco.edEmprExit(Sender: TObject);
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
        ShowMessage('Empresa n�o encontrada');
        Exit;
      end;
     edNomeEmpr.Text:= sqlaux.FieldByName('empr_raza').AsString;
   end;
end;

procedure TFormRelTabelaPreco.edEmprPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  edEmpr.Text:= consulta('cons_empresa');
  edemprexit(Self);
end;

procedure TFormRelTabelaPreco.edGeneExit(Sender: TObject);
begin
  edNomegene.Clear;
  if StrToIntDef(edgene.Text,0) > 0 then
   begin
     sqlaux.Close;
     sqlaux.SQL.Text:= 'select gene_desc from cadastro.gene where gene_codi = :codi';
     sqlaux.ParamByName('codi').AsInteger:= StrToIntDef(edgene.Text,0);
     sqlaux.Open;
     if sqlaux.IsEmpty then
      begin
        ShowMessage('Genero n�o encontrado');
        Exit;
      end;
     edNomegene.Text:= sqlaux.FieldByName('gene_desc').AsString;
   end;

end;

procedure TFormRelTabelaPreco.edGenePropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  edGene.Text:= consulta('cons_genero');
  edGeneExit(Self);
end;

procedure TFormRelTabelaPreco.edGrupExit(Sender: TObject);
begin
  edNomegrup.Clear;
  if StrToIntDef(edgrup.Text,0) > 0 then
   begin
     sqlaux.Close;
     sqlaux.SQL.Text:= 'select grup_desc from cadastro.grup where grup_codi = :codi';
     sqlaux.ParamByName('codi').AsInteger:= StrToIntDef(edgrup.Text,0);
     sqlaux.Open;
     if sqlaux.IsEmpty then
      begin
        ShowMessage('Grupo n�o encontrado');
        Exit;
      end;
     edNomegrup.Text:= sqlaux.FieldByName('grup_desc').AsString;
   end;

end;

procedure TFormRelTabelaPreco.edGrupPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  edGrup.Text:= consulta('cons_grupo');
  edGrupExit(Self);
end;

procedure TFormRelTabelaPreco.edProdExit(Sender: TObject);
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
        ShowMessage('Produto n�o encontrado');
        Exit;
      end;
     edNomeprod.Text:= sqlaux.FieldByName('prod_desc').AsString;
   end;
end;

procedure TFormRelTabelaPreco.edEntiPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  edProd.Text:= consulta('cons_produto');
  edProdExit(Self);
end;

procedure TFormRelTabelaPreco.edSugrExit(Sender: TObject);
begin
  edNomesugr.Clear;
  if StrToIntDef(edsugr.Text,0) > 0 then
   begin
     sqlaux.Close;
     sqlaux.SQL.Text:= 'select sugr_desc from cadastro.sugr where sugr_codi = :codi';
     sqlaux.ParamByName('codi').AsInteger:= StrToIntDef(edsugr.Text,0);
     sqlaux.Open;
     if sqlaux.IsEmpty then
      begin
        ShowMessage('SubGrupo n�o encontrado');
        Exit;
      end;
     edNomesugr.Text:= sqlaux.FieldByName('sugr_desc').AsString;
   end;

end;

procedure TFormRelTabelaPreco.edSugrPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  edSugr.Text:= consulta('cons_subgrupo');
  edSugrExit(Self);
end;

procedure TFormRelTabelaPreco.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action:= caFree;
  FormRelTabelaPreco:= nil;
end;

procedure TFormRelTabelaPreco.FormShow(Sender: TObject);
begin
  caption:= '..::PROG0035::..';
  lbtitu.Caption:= 'Tabela de Pre�o';

  sqlaux.Close;
  sqlaux.sql.Text:= 'select empr_raza, empr_logo from cadastro.empr where empr_codi = :codi';
  sqlaux.ParamByName('codi').AsInteger:= FormPrincipal.puempresa;
  sqlaux.Open;

  rlEmpresa.Caption:= sqlaux.FieldByName('empr_raza').AsString;
  rlLogo.Picture.LoadFromFile(sqlaux.FieldByName('empr_logo').AsString);
end;

procedure TFormRelTabelaPreco.RLDBText3BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  text:= FormatFloat('###,###,##0.00', StrToFloatDef(Text,0));
end;

procedure TFormRelTabelaPreco.RLDBText4BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  text:= FormatFloat('###,###,##0.00', StrToFloatDef(Text,0));
end;

end.
