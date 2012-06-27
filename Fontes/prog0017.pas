unit prog0017;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, dxGDIPlusClasses, ExtCtrls, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore, dxSkinBlack, dxSkinBlue,
  dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy,
  dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue,
  dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver,
  dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters,
  dxSkinValentine, dxSkinXmas2008Blue, dxSkinscxPCPainter, cxPC, StdCtrls,
  Menus, cxButtons, cxContainer, cxEdit, cxImage, AdvReflectionLabel, cxLabel,
  UCBase, DB, MemDS, DBAccess, Uni, ImgList, cxCheckBox, cxDBEdit, cxTextEdit,
  cxMaskEdit, cxButtonEdit, ACBrBase, ACBrEnterTab, cxDropDownEdit,
  cxImageComboBox;

type
  TFormCadProdutos = class(TForm)
    cxPageControl1: TcxPageControl;
    cxTabControl1: TcxTabControl;
    btnFechar: TcxButton;
    btnGravar: TcxButton;
    Image1: TImage;
    lbTitu: TcxLabel;
    controle: TUCControls;
    dsTable: TUniDataSource;
    quTable: TUniQuery;
    sqlaux: TUniQuery;
    sb: TStatusBar;
    imagem: TImageList;
    edCodi: TcxButtonEdit;
    edDesc: TcxDBTextEdit;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    ACBrEnterTab1: TACBrEnterTab;
    cxPageControl2: TcxPageControl;
    edAtiv: TcxDBCheckBox;
    cxDBTextEdit1: TcxDBTextEdit;
    cxLabel3: TcxLabel;
    cxDBTextEdit2: TcxDBTextEdit;
    cxLabel4: TcxLabel;
    cxLabel5: TcxLabel;
    cxDBImageComboBox1: TcxDBImageComboBox;
    edCodiUnid: TcxButtonEdit;
    cxLabel6: TcxLabel;
    edNomeUnid: TcxTextEdit;
    cxDBTextEdit3: TcxDBTextEdit;
    cxLabel7: TcxLabel;
    cxDBTextEdit4: TcxDBTextEdit;
    cxLabel8: TcxLabel;
    edCodiGrup: TcxButtonEdit;
    cxLabel9: TcxLabel;
    edNomeGrup: TcxTextEdit;
    edCodiSugr: TcxButtonEdit;
    cxLabel10: TcxLabel;
    edNomeSugr: TcxTextEdit;
    cxDBTextEdit5: TcxDBTextEdit;
    cxLabel11: TcxLabel;
    cxDBTextEdit6: TcxDBTextEdit;
    cxLabel12: TcxLabel;
    edCodiGene: TcxButtonEdit;
    cxLabel13: TcxLabel;
    edNomeGene: TcxTextEdit;
    cxDBCheckBox1: TcxDBCheckBox;
    cxDBTextEdit7: TcxDBTextEdit;
    cxLabel14: TcxLabel;
    cxDBTextEdit8: TcxDBTextEdit;
    cxLabel15: TcxLabel;
    cxLabel16: TcxLabel;
    cxDBImageComboBox2: TcxDBImageComboBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnFecharClick(Sender: TObject);
    procedure quTableBeforeEdit(DataSet: TDataSet);
    procedure quTableBeforeInsert(DataSet: TDataSet);
    procedure quTableAfterPost(DataSet: TDataSet);
    procedure quTableAfterCancel(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure edCodiPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure edCodiExit(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure edCodiUnidPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure edCodiUnidExit(Sender: TObject);
    procedure edCodiGrupExit(Sender: TObject);
    procedure edCodiGrupPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure edCodiSugrExit(Sender: TObject);
    procedure edCodiSugrPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure edCodiGeneExit(Sender: TObject);
    procedure edCodiGenePropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
  private
    v_tabela,
    v_esquema : string;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormCadProdutos: TFormCadProdutos;

implementation

uses prog0001, prog0003, rotinas;

{$R *.dfm}

procedure TFormCadProdutos.btnFecharClick(Sender: TObject);
begin
  close;
end;

procedure TFormCadProdutos.btnGravarClick(Sender: TObject);
var
  v_status : boolean;
begin
  if not (quTable.State in [dsEdit, dsInsert]) then Exit;

  if qutable.State in [dsInsert] then
    v_status:= true
  else
  if qutable.State in [dsEdit] then
    v_status:= false;

  qutable.FieldByName('prod_unid').AsInteger:= StrToIntDef(edCodiUnid.Text,0);
  qutable.FieldByName('prod_grup').AsInteger:= StrToIntDef(edCodiGrup.Text,0);
  qutable.FieldByName('prod_sugr').AsInteger:= StrToIntDef(edCodiSugr.Text,0);
  qutable.FieldByName('prod_gene').AsInteger:= StrToIntDef(edCodiGene.Text,0);
  qutable.FieldByName(v_tabela+'_empr').AsInteger:= formprincipal.puempresa;
  qutable.FieldByName(v_tabela+'_loca').AsInteger:= formprincipal.pulocal;
  qutable.FieldByName(v_tabela+'_codi').Asfloat  := strtofloatdef(edcodi.Text,0);
  qutable.Post;
  qutable.ApplyUpdates();

  //grava log
  if v_status then
    begin
      formprincipal.controle.Log('Inseriu o registro: '+qutable.fieldbyname(v_tabela+'_codi').AsString+' - '+
                                                        qutable.FieldByName(v_tabela+'_desc').AsString,
                                                        Caption,1);
    end else
     begin
       formprincipal.controle.Log('Editou o registro: '+qutable.fieldbyname(v_tabela+'_codi').AsString+' - '+
                                                        qutable.FieldByName(v_tabela+'_desc').AsString,
                                                        caption,2);
     end;
end;

procedure TFormCadProdutos.edCodiExit(Sender: TObject);
begin
  //carrega tabela referente
  qutable.Close;
  qutable.SQL.Text:= 'select * from '+v_esquema+'.'+v_tabela+' where '+
                                                    v_tabela+'_empr = :empr and '+
                                                    v_tabela+'_loca = :loca and '+
                                                    v_tabela+'_codi = :codi';
  qutable.ParamByName('empr').AsInteger:= formprincipal.puempresa;
  qutable.ParamByName('loca').AsInteger:= formprincipal.pulocal;
  qutable.ParamByName('codi').AsFloat  := strtofloatdef(edcodi.Text,0);
  qutable.Open;
  if qutable.IsEmpty then
    begin
      // pega o codigo do ultimo registro
      sqlaux.Close;
      sqlaux.SQL.Text:= 'select max('+v_tabela+'_codi) as "codigo" from '+v_esquema+'.'+v_tabela+' where '+
                         v_tabela+'_empr = :empr and '+
                         v_tabela+'_loca = :loca ';
      sqlaux.ParamByName('empr').AsInteger:= formprincipal.puempresa;
      sqlaux.ParamByName('loca').AsInteger:= formprincipal.pulocal;
      sqlaux.Open;
      sqlaux.Tag:= sqlaux.FieldByName('codigo').AsInteger + 1;

      qutable.Append;
      edcodi.Text:= inttostr(sqlaux.Tag);

      edCodiUnid.Clear;
      edCodiUnidExit(self);
      edCodiGrup.Clear;
      edCodiGrupExit(Self);
      edCodiSugr.Clear;
      edCodiSugrExit(Self);
      edCodiGene.Clear;
      edCodiGeneExit(Self);

      edDesc.Properties.ReadOnly:= False;
    end else
     begin
       qutable.Edit;

       edCodiUnid.Text:= qutable.fieldbyname('prod_unid').asstring;
       edCodiUnidExit(Self);
       edCodiGrup.Text:= quTable.FieldByName('prod_grup').AsString;
       edCodiGrupExit(Self);
       edCodiSugr.Text:= quTable.FieldByName('prod_sugr').AsString;
       edCodiSugrExit(Self);
       edCodiGene.Text:= quTable.FieldByName('prod_gene').AsString;
       edCodiGeneExit(Self);

       edDesc.Properties.ReadOnly:= true;
     end;
end;

procedure TFormCadProdutos.edCodiGeneExit(Sender: TObject);
begin
  edNomegene.Clear;
  if StrToIntDef(edCodigene.Text,0) > 0 then
    begin
      sqlaux.Close;
      sqlaux.SQL.Text:= 'select gene_desc from cadastro.gene where gene_codi = :codi';
      sqlaux.ParamByName('codi').AsInteger:= StrToIntDef(edCodigene.Text,0);
      sqlaux.Open;
      if not sqlaux.IsEmpty then
        begin
          edNomegene.Text:= sqlaux.FieldByName('gene_desc').AsString;
        end else
         begin
           ShowMessage('Genero de Produto não Encontrado');
           Exit;
         end;
    end;
end;

procedure TFormCadProdutos.edCodiGenePropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  edCodiGene.Text:= consulta('cons_genero');
  edCodiGeneExit(Self);
end;

procedure TFormCadProdutos.edCodiGrupExit(Sender: TObject);
begin
  edNomeGrup.Clear;
  if StrToIntDef(edCodiGrup.Text,0) > 0 then
    begin
      sqlaux.Close;
      sqlaux.SQL.Text:= 'select grup_desc from cadastro.grup where grup_codi = :codi and grup_empr = :empr and grup_loca = :loca';
      sqlaux.ParamByName('empr').AsInteger:= FormPrincipal.puempresa;
      sqlaux.ParamByName('loca').AsInteger:= FormPrincipal.pulocal;
      sqlaux.ParamByName('codi').AsInteger:= StrToIntDef(edCodiGrup.Text,0);
      sqlaux.Open;
      if not sqlaux.IsEmpty then
        begin
          edNomeGrup.Text:= sqlaux.FieldByName('grup_desc').AsString;
        end else
         begin
           ShowMessage('Grupo não Encontrado');
           Exit;
         end;
    end;
end;

procedure TFormCadProdutos.edCodiGrupPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  edCodiGrup.Text:= consulta('cons_grupo');
  edCodiGrupExit(Self);
end;

procedure TFormCadProdutos.edCodiPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  edcodi.Text:= consulta('cons_produto');
  edCodiExit(self);
  eddesc.SetFocus;
end;

procedure TFormCadProdutos.edCodiSugrExit(Sender: TObject);
begin
  edNomesugr.Clear;
  if StrToIntDef(edCodisugr.Text,0) > 0 then
    begin
      sqlaux.Close;
      sqlaux.SQL.Text:= 'select sugr_desc from cadastro.sugr where sugr_codi = :codi and sugr_empr = :empr and sugr_loca = :loca';
      sqlaux.ParamByName('empr').AsInteger:= FormPrincipal.puempresa;
      sqlaux.ParamByName('loca').AsInteger:= FormPrincipal.pulocal;
      sqlaux.ParamByName('codi').AsInteger:= StrToIntDef(edCodisugr.Text,0);
      sqlaux.Open;
      if not sqlaux.IsEmpty then
        begin
          edNomesugr.Text:= sqlaux.FieldByName('sugr_desc').AsString;
        end else
         begin
           ShowMessage('Sub. Grupo não Encontrado');
           Exit;
         end;
    end;
end;

procedure TFormCadProdutos.edCodiSugrPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  edCodiSugr.Text:= consulta('cons_subgrupo');
  edCodiSugrExit(self);
end;

procedure TFormCadProdutos.edCodiUnidExit(Sender: TObject);
begin
  edNomeUnid.Clear;
  if StrToIntDef(edCodiUnid.Text,0) > 0 then
    begin
      sqlaux.Close;
      sqlaux.SQL.Text:= 'select unid_desc from cadastro.unid where unid_codi = :codi and unid_empr = :empr and unid_loca = :loca';
      sqlaux.ParamByName('empr').AsInteger:= FormPrincipal.puempresa;
      sqlaux.ParamByName('loca').AsInteger:= FormPrincipal.pulocal;
      sqlaux.ParamByName('codi').AsInteger:= StrToIntDef(edCodiUnid.Text,0);
      sqlaux.Open;
      if not sqlaux.IsEmpty then
        begin
          edNomeUnid.Text:= sqlaux.FieldByName('unid_desc').AsString;
        end else
         begin
           ShowMessage('Unidade de Medida não Encontrada');
           Exit;
         end;
    end;
end;

procedure TFormCadProdutos.edCodiUnidPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  edCodiUnid.Text:= consulta('cons_unidade');
  edCodiUnidExit(Self);
end;

procedure TFormCadProdutos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action:= cafree;
  FormCadProdutos:= nil;
end;

procedure TFormCadProdutos.FormShow(Sender: TObject);
begin
  // carrega os dados do form
  lbTitu.Caption               := 'Cadastro de Produtos';
  Caption                      := '..::PROG0017::..';
  v_tabela                     := 'prod';
  v_esquema                    := 'cadastro';
  sb.Panels[0].Text            := 'Navegando...';
  eddesc.DataBinding.DataField := v_tabela+'_desc';
  edAtiv.DataBinding.DataField := v_tabela+'_ativ';
  controle.GroupName           := caption+' - '+lbtitu.Caption;
end;

procedure TFormCadProdutos.quTableAfterCancel(DataSet: TDataSet);
begin
  sb.Panels[0].text:= 'Navegando...';
end;

procedure TFormCadProdutos.quTableAfterPost(DataSet: TDataSet);
begin
  sb.Panels[0].text:= 'Navegando...';
end;

procedure TFormCadProdutos.quTableBeforeEdit(DataSet: TDataSet);
begin
  sb.Panels[0].text:= 'Editando registro...';
end;

procedure TFormCadProdutos.quTableBeforeInsert(DataSet: TDataSet);
begin
  sb.Panels[0].text:= 'Inserindo Registro...';
end;

end.
