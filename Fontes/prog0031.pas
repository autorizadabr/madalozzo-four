unit prog0031;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, Menus, ACBrBase, ACBrEnterTab, UCBase, ComCtrls,
  StdCtrls, cxButtons, cxPC, cxLabel, dxGDIPlusClasses, ExtCtrls, cxCheckBox,
  cxTextEdit, cxMaskEdit, cxButtonEdit, DB, DBAccess, Uni, MemDS, RLReport;

type
  TFormRelPadrao = class(TForm)
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
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edEmprPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure edEmprExit(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure edEntiExit(Sender: TObject);
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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormRelPadrao: TFormRelPadrao;

implementation

uses prog0003, rotinas, prog0001;

{$R *.dfm}

procedure TFormRelPadrao.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFormRelPadrao.btnImprimirClick(Sender: TObject);
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
     sqlaux.sql.Add('and enti_enti = :enti ');
     sqlaux.ParamByName('enti').AsInteger:= StrToIntDef(edenti.Text,0);
   end;
  if StrToIntDef(edGrup.Text,0) > 0 then
   begin
     sqlaux.sql.Add('and enti_Grup = :Grup ');
     sqlaux.ParamByName('Grup').AsInteger:= StrToIntDef(edGrup.Text,0);
   end;
  if StrToIntDef(edSugr.Text,0) > 0 then
   begin
     sqlaux.sql.Add('and enti_Sugr = :Sugr ');
     sqlaux.ParamByName('Sugr').AsInteger:= StrToIntDef(edSugr.Text,0);
   end;
  if StrToIntDef(edGene.Text,0) > 0 then
   begin
     sqlaux.sql.Add('and enti_Gene = :Gene ');
     sqlaux.ParamByName('Gene').AsInteger:= StrToIntDef(edGene.Text,0);
   end;
  if edAtiv.Checked then
   begin
     sqlaux.sql.Add('and enti_ativ is true ');
   end;
  sqlaux.Open;
  imprimir(rlreport1,RLBand4);
end;

procedure TFormRelPadrao.edEmprExit(Sender: TObject);
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

procedure TFormRelPadrao.edEmprPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  edEmpr.Text:= consulta('cons_empresa');
  edemprexit(Self);
end;

procedure TFormRelPadrao.edGeneExit(Sender: TObject);
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
        ShowMessage('Genero não encontrado');
        Exit;
      end;
     edNomegene.Text:= sqlaux.FieldByName('gene_desc').AsString;
   end;

end;

procedure TFormRelPadrao.edGenePropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  edGene.Text:= consulta('cons_genero');
  edGeneExit(Self);
end;

procedure TFormRelPadrao.edGrupExit(Sender: TObject);
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
        ShowMessage('Grupo não encontrado');
        Exit;
      end;
     edNomegrup.Text:= sqlaux.FieldByName('grup_desc').AsString;
   end;

end;

procedure TFormRelPadrao.edGrupPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  edGrup.Text:= consulta('cons_grupo');
  edGrupExit(Self);
end;

procedure TFormRelPadrao.edEntiExit(Sender: TObject);
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

procedure TFormRelPadrao.edEntiPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  edEnti.Text:= consulta('cons_entidade');
  edEntiExit(Self);
end;

procedure TFormRelPadrao.edSugrExit(Sender: TObject);
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
        ShowMessage('SubGrupo não encontrado');
        Exit;
      end;
     edNomesugr.Text:= sqlaux.FieldByName('sugr_desc').AsString;
   end;

end;

procedure TFormRelPadrao.edSugrPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  edSugr.Text:= consulta('cons_subgrupo');
  edSugrExit(Self);
end;

procedure TFormRelPadrao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action:= caFree;
  FormRelPadrao:= nil;
end;

procedure TFormRelPadrao.FormShow(Sender: TObject);
begin
  caption:= '..::PROG0031::..';
  lbtitu.Caption:= 'Relatório Padrão';

  sqlaux.Close;
  sqlaux.sql.Text:= 'select empr_raza, empr_logo from cadastro.empr where empr_codi = :codi';
  sqlaux.ParamByName('codi').AsInteger:= FormPrincipal.puempresa;
  sqlaux.Open;

  rlEmpresa.Caption:= sqlaux.FieldByName('empr_raza').AsString;
  rlLogo.Picture.LoadFromFile(sqlaux.FieldByName('empr_logo').AsString);
end;

end.
