unit prog0022;

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
  cxMaskEdit, cxButtonEdit, ACBrBase, ACBrEnterTab, cxDropDownEdit, cxCalendar,
  cxMemo, cxGroupBox, ACBrValidador, RLReport, cefvcl, ceflib, cefgui;


type
  TFormCadEntidade = class(TForm)
    cxPageControl1: TcxPageControl;
    cxTabControl1: TcxTabControl;
    btnFechar: TcxButton;
    btnGravar: TcxButton;
    brnExcluir: TcxButton;
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
    cxTabSheet1: TcxTabSheet;
    cxTabSheet3: TcxTabSheet;
    cxDBTextEdit1: TcxDBTextEdit;
    cxLabel3: TcxLabel;
    cxLabel4: TcxLabel;
    edTien: TcxButtonEdit;
    edNomeTien: TcxTextEdit;
    edCodiCida: TcxButtonEdit;
    cxLabel5: TcxLabel;
    edNomeCida: TcxTextEdit;
    cxLabel6: TcxLabel;
    edEsta: TcxTextEdit;
    cxLabel7: TcxLabel;
    edCep: TcxDBTextEdit;
    cxDBTextEdit3: TcxDBTextEdit;
    cxLabel8: TcxLabel;
    cxDBTextEdit5: TcxDBTextEdit;
    cxLabel9: TcxLabel;
    cxDBTextEdit4: TcxDBTextEdit;
    cxLabel10: TcxLabel;
    cxDBTextEdit6: TcxDBTextEdit;
    cxLabel11: TcxLabel;
    edCnpj: TcxDBTextEdit;
    cxLabel12: TcxLabel;
    edIe: TcxDBTextEdit;
    cxLabel13: TcxLabel;
    cxDBTextEdit9: TcxDBTextEdit;
    cxLabel14: TcxLabel;
    edFone: TcxDBTextEdit;
    cxLabel15: TcxLabel;
    cxDBTextEdit11: TcxDBTextEdit;
    cxLabel16: TcxLabel;
    cxDBTextEdit12: TcxDBTextEdit;
    cxLabel17: TcxLabel;
    cxDBTextEdit13: TcxDBTextEdit;
    cxLabel18: TcxLabel;
    edCpf: TcxDBTextEdit;
    cxLabel19: TcxLabel;
    cxDBTextEdit15: TcxDBTextEdit;
    cxLabel20: TcxLabel;
    cxLabel21: TcxLabel;
    cxDBDateEdit1: TcxDBDateEdit;
    edVend: TcxButtonEdit;
    cxLabel22: TcxLabel;
    edNomeVend: TcxTextEdit;
    edAtiv: TcxDBCheckBox;
    cxDBCheckBox1: TcxDBCheckBox;
    cxDBCheckBox2: TcxDBCheckBox;
    cxGroupBox1: TcxGroupBox;
    cxGroupBox2: TcxGroupBox;
    cxDBMemo1: TcxDBMemo;
    valida: TACBrValidador;
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
    procedure brnExcluirClick(Sender: TObject);
    procedure edCodiCidaExit(Sender: TObject);
    procedure edCodiCidaPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure edTienPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure edTienExit(Sender: TObject);
    procedure edVendPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure edVendExit(Sender: TObject);
    procedure edCnpjExit(Sender: TObject);
    procedure validaMsgErro(Mensagem: string);
    procedure edIeExit(Sender: TObject);
    procedure edCpfExit(Sender: TObject);
    procedure edCepExit(Sender: TObject);
  private
    v_tabela,
    v_esquema : string;
    { Private declarations }
  public
    { Public declarations }
  end;


var
  FormCadEntidade: TFormCadEntidade;

implementation

uses prog0001, prog0003, rotinas, prog0026, superobject, prog0040;

{$R *.dfm}




procedure TFormCadEntidade.brnExcluirClick(Sender: TObject);
begin
  if MessageDlg('Deseja Realmente Excluir o Registro?',  mtConfirmation, [mbYes, mbNo], 0) = mrYes then
   begin
     // grava log
     formprincipal.controle.Log('Excluiu o registro: '+qutable.fieldbyname(v_tabela+'_codi').asstring+' - '+
                                                       qutable.FieldByName(v_tabela+'_desc').asstring,
                                                       Caption,3);
     qutable.Delete;
     qutable.ApplyUpdates();
     edcodi.Clear;
     edTien.Clear;
     edTienExit(Self);
     edCodiCida.Clear;
     edCodiCidaExit(Self);
     edVend.Clear;
     edVendExit(Self);
   end;
end;

procedure TFormCadEntidade.btnFecharClick(Sender: TObject);
begin
  close;
end;

procedure TFormCadEntidade.btnGravarClick(Sender: TObject);
var
  v_status : boolean;
begin
  if not (quTable.State in [dsEdit, dsInsert]) then Exit;

  if qutable.State in [dsInsert] then
    v_status:= true
  else
  if qutable.State in [dsEdit] then
    v_status:= false;

  quTable.FieldByName('enti_tipo').AsInteger:= StrToIntDef(edTien.Text,0);
  quTable.FieldByName('enti_vend').AsInteger:= StrToIntDef(edVend.Text,0);
  quTable.FieldByName('enti_cida').AsInteger:= StrToIntDef(edcodicida.Text,0);
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

procedure TFormCadEntidade.edCepExit(Sender: TObject);
begin
  valida.TipoDocto:= docCEP;
  valida.Documento:= edCep.Text;
  quTable.FieldByName('enti_cep').AsString:= valida.Formatar;
  valida.Validar;
end;

procedure TFormCadEntidade.edCnpjExit(Sender: TObject);
begin
  valida.TipoDocto:= docCNPJ;
  valida.Documento:= edCnpj.Text;
  quTable.FieldByName('enti_cnpj').AsString:= valida.Formatar;
  valida.Validar;
  if dmDados.quPara.FieldByName('para_auto_enti').AsBoolean then
   begin
     application.CreateForm(TFormCaptcha, FormCaptcha);
     FormCaptcha.cnpj:= quTable.FieldByName('enti_cnpj').asstring;
     FormCaptcha.showmodal;

     sqlaux.Close;
     sqlaux.SQL.text:= 'select cida_codi from cadastro.cida where cida_desc ilike :cida';
     sqlaux.ParamByName('cida').asstring:= edNomeCida.Text;
     sqlaux.Open;
     if not sqlaux.IsEmpty then
      begin
        edCodiCida.Text:= sqlaux.FieldByName('cida_codi').AsString;
      end;
     FormCaptcha.Close;
   end;
end;

procedure TFormCadEntidade.edCodiCidaExit(Sender: TObject);
begin
  edNomeCida.Clear;
  edEsta.Clear;
  if StrToIntDef(edCodiCida.Text,0) > 0 then
   begin
     sqlaux.close;
     sqlaux.SQL.Text:= 'select cida_desc, cida_sigl from cadastro.cida where cida_codi = :codi';
     sqlaux.ParamByName('codi').AsInteger:= StrToIntDef(edCodiCida.Text,0);
     sqlaux.Open;
     if sqlaux.IsEmpty then
      begin
        ShowMessage('Cidade não encontrada');
        Exit;
      end;
     edNomeCida.text:= sqlaux.FieldByName('cida_desc').AsString;
     edEsta.Text:= sqlaux.FieldByName('cida_sigl').AsString;
   end;
end;

procedure TFormCadEntidade.edCodiCidaPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  edCodiCida.Text:= consulta('cons_cidade');
  edcodicidaexit(Self);
end;

procedure TFormCadEntidade.edCodiExit(Sender: TObject);
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
      edTien.Clear;
      edTienExit(Self);
      edCodiCida.Clear;
      edCodiCidaExit(Self);
      edVend.Clear;
      edVendExit(Self);
    end else
     begin
       qutable.Edit;
       edTien.Text:= quTable.FieldByName('enti_tipo').AsString;
       edTienExit(Self);
       edcodicida.text:= qutable.FieldByName('enti_cida').AsString;
       edCodiCidaExit(Self);
       edVend.Text:= quTable.FieldByName('enti_vend').AsString;
       edVendExit(Self);
     end;
end;

procedure TFormCadEntidade.edCodiPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  edcodi.Text:= consulta('cons_entidade');
  edCodiExit(self);
  eddesc.SetFocus;
end;

procedure TFormCadEntidade.edCpfExit(Sender: TObject);
begin
  valida.TipoDocto:= docCPF;
  valida.Documento:= edCpf.Text;
  quTable.FieldByName('enti_cpf').AsString:= valida.Formatar;
end;

procedure TFormCadEntidade.edIeExit(Sender: TObject);
begin
  valida.TipoDocto:= docInscEst;
  valida.Documento:= edIe.Text;
  valida.Complemento:= edEsta.Text;
  quTable.FieldByName('enti_ie').AsString:= valida.Formatar;
  valida.Validar;
end;

procedure TFormCadEntidade.edTienExit(Sender: TObject);
begin
  edNomeTien.Clear;
  if StrToIntDef(edTien.Text,0) > 0 then
    begin
      sqlaux.Close;
      sqlaux.SQL.Text:= 'select tien_desc from cadastro.tien where tien_codi = :codi '+
                        'and tien_empr = :empr and tien_loca = :loca';
      sqlaux.ParamByName('empr').AsInteger:= FormPrincipal.puempresa;
      sqlaux.ParamByName('loca').AsInteger:= FormPrincipal.pulocal;
      sqlaux.ParamByName('codi').AsInteger:= StrToIntDef(edTien.Text,0);
      sqlaux.Open;
      if sqlaux.IsEmpty then
       begin
         ShowMessage('Tipo de Entidade não encontrada');
         Exit;
       end;
      edNomeTien.Text:= sqlaux.FieldByName('tien_desc').AsString;
    end;
end;

procedure TFormCadEntidade.edTienPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  edTien.Text:= consulta('cons_tipoentidade');
  edTienexit(Self);
end;

procedure TFormCadEntidade.edVendExit(Sender: TObject);
begin
  edNomeVend.Clear;
  if StrToIntDef(edVend.Text,0) > 0 then
    begin
      sqlaux.Close;
      sqlaux.SQL.Text:= 'select enti_desc from cadastro.enti where enti_codi = :codi';
      sqlaux.ParamByName('codi').AsInteger:= StrToIntDef(edVend.Text,0);
      sqlaux.Open;
      if sqlaux.IsEmpty then
        begin
          ShowMessage('Vendedor não encontrado');
          Exit;
        end;
      edNomeVend.Text:= sqlaux.FieldByName('enti_desc').AsString;
    end;
end;

procedure TFormCadEntidade.edVendPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  edVend.Text:= consulta('cons_entidade');
  edvendexit(Self);
end;

procedure TFormCadEntidade.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action:= cafree;
  FormCadEntidade:= nil;
end;

procedure TFormCadEntidade.FormShow(Sender: TObject);
begin
  // carrega os dados do form
  lbTitu.Caption               := 'Cadastro de Entidade';
  Caption                      := '..::PROG0022::..';
  v_tabela                     := 'enti';
  v_esquema                    := 'cadastro';
  sb.Panels[0].Text            := 'Navegando...';
  eddesc.DataBinding.DataField := v_tabela+'_desc';
  edAtiv.DataBinding.DataField := v_tabela+'_ativ';
  controle.GroupName           := caption+' - '+lbtitu.Caption;
end;

procedure TFormCadEntidade.quTableAfterCancel(DataSet: TDataSet);
begin
  sb.Panels[0].text:= 'Navegando...';
end;

procedure TFormCadEntidade.quTableAfterPost(DataSet: TDataSet);
begin
  sb.Panels[0].text:= 'Navegando...';
end;

procedure TFormCadEntidade.quTableBeforeEdit(DataSet: TDataSet);
begin
  sb.Panels[0].text:= 'Editando registro...';
end;

procedure TFormCadEntidade.quTableBeforeInsert(DataSet: TDataSet);
begin
  sb.Panels[0].text:= 'Inserindo Registro...';
end;

procedure TFormCadEntidade.validaMsgErro(Mensagem: string);
begin
  ShowMessage(Valida.MsgErro);
end;
end.
