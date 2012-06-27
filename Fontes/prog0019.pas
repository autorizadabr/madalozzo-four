unit prog0019;

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
  cxImageComboBox, cxGroupBox, cxMemo, ExtDlgs, ACBrValidador;

type
  TFormCadEmpresa = class(TForm)
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
    cxTabSheet2: TcxTabSheet;
    cxDBTextEdit1: TcxDBTextEdit;
    cxLabel3: TcxLabel;
    cxLabel4: TcxLabel;
    edCep: TcxDBTextEdit;
    edCodiCida: TcxButtonEdit;
    cxLabel5: TcxLabel;
    edNomeCida: TcxTextEdit;
    edEsta: TcxTextEdit;
    cxLabel6: TcxLabel;
    cxDBTextEdit3: TcxDBTextEdit;
    cxLabel7: TcxLabel;
    cxDBTextEdit4: TcxDBTextEdit;
    cxLabel8: TcxLabel;
    cxDBTextEdit5: TcxDBTextEdit;
    cxLabel9: TcxLabel;
    cxDBTextEdit6: TcxDBTextEdit;
    cxLabel10: TcxLabel;
    edCnpj: TcxDBTextEdit;
    cxLabel11: TcxLabel;
    edIe: TcxDBTextEdit;
    cxLabel12: TcxLabel;
    cxDBImageComboBox1: TcxDBImageComboBox;
    cxLabel13: TcxLabel;
    cxDBTextEdit9: TcxDBTextEdit;
    cxLabel14: TcxLabel;
    cxDBTextEdit10: TcxDBTextEdit;
    cxLabel15: TcxLabel;
    cxLabel16: TcxLabel;
    cxDBTextEdit11: TcxDBTextEdit;
    cxDBTextEdit12: TcxDBTextEdit;
    cxLabel17: TcxLabel;
    cxDBTextEdit13: TcxDBTextEdit;
    cxLabel18: TcxLabel;
    cxGroupBox1: TcxGroupBox;
    edCert: TcxButtonEdit;
    cxLabel19: TcxLabel;
    cxDBTextEdit14: TcxDBTextEdit;
    cxLabel20: TcxLabel;
    cxLabel21: TcxLabel;
    cxDBImageComboBox2: TcxDBImageComboBox;
    cxLabel22: TcxLabel;
    cxDBImageComboBox3: TcxDBImageComboBox;
    cxGroupBox2: TcxGroupBox;
    cxDBTextEdit15: TcxDBTextEdit;
    cxLabel23: TcxLabel;
    cxDBTextEdit16: TcxDBTextEdit;
    cxLabel24: TcxLabel;
    cxDBTextEdit17: TcxDBTextEdit;
    cxLabel25: TcxLabel;
    cxDBTextEdit18: TcxDBTextEdit;
    cxLabel26: TcxLabel;
    cxGroupBox3: TcxGroupBox;
    cxLabel27: TcxLabel;
    cxDBTextEdit19: TcxDBTextEdit;
    cxLabel28: TcxLabel;
    cxDBTextEdit20: TcxDBTextEdit;
    cxDBTextEdit21: TcxDBTextEdit;
    cxLabel29: TcxLabel;
    cxDBTextEdit22: TcxDBTextEdit;
    cxLabel30: TcxLabel;
    cxDBCheckBox1: TcxDBCheckBox;
    cxDBCheckBox2: TcxDBCheckBox;
    cxDBCheckBox3: TcxDBCheckBox;
    cxDBCheckBox4: TcxDBCheckBox;
    cxDBCheckBox5: TcxDBCheckBox;
    cxLabel31: TcxLabel;
    cxDBTextEdit23: TcxDBTextEdit;
    cxTabSheet3: TcxTabSheet;
    cxGroupBox4: TcxGroupBox;
    cxDBTextEdit24: TcxDBTextEdit;
    cxGroupBox5: TcxGroupBox;
    cxDBMemo1: TcxDBMemo;
    cxLabel32: TcxLabel;
    cxDBImageComboBox4: TcxDBImageComboBox;
    cxLabel33: TcxLabel;
    cxDBImageComboBox5: TcxDBImageComboBox;
    cxDBTextEdit25: TcxDBTextEdit;
    cxLabel34: TcxLabel;
    cxTabSheet4: TcxTabSheet;
    cxGroupBox6: TcxGroupBox;
    edlogo: TcxButtonEdit;
    logo: TcxImage;
    od: TOpenPictureDialog;
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
    procedure edCodiCidaPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure edCodiCidaExit(Sender: TObject);
    procedure edlogoPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure edCertPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure validaMsgErro(Mensagem: string);
    procedure edCepExit(Sender: TObject);
    procedure edCnpjExit(Sender: TObject);
    procedure edIeExit(Sender: TObject);
  private
    v_tabela,
    v_esquema : string;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormCadEmpresa: TFormCadEmpresa;

implementation

uses prog0001, prog0003, rotinas;

{$R *.dfm}

procedure TFormCadEmpresa.brnExcluirClick(Sender: TObject);
begin
  if MessageDlg('Deseja Realmente Excluir o Registro?',  mtConfirmation, [mbYes, mbNo], 0) = mrYes then
   begin
     // grava log
     formprincipal.controle.Log('Excluiu o registro: '+qutable.fieldbyname(v_tabela+'_codi').asstring+' - '+
                                                       qutable.FieldByName(v_tabela+'_raza').asstring,
                                                       Caption,3);
     qutable.Delete;
     qutable.ApplyUpdates();
     edcodi.Clear;
     edCodiCida.Clear;
     edCodiCidaExit(Self);
     edCert.Clear;
     edlogo.Clear;
     logo.Picture:= nil;
   end;
end;

procedure TFormCadEmpresa.btnFecharClick(Sender: TObject);
begin
  close;
end;

procedure TFormCadEmpresa.btnGravarClick(Sender: TObject);
var
  v_status : boolean;
begin
  if not (quTable.State in [dsEdit, dsInsert]) then Exit;

  if qutable.State in [dsInsert] then
    v_status:= true
  else
  if qutable.State in [dsEdit] then
    v_status:= false;

  quTable.FieldByName('empr_logo').AsString:= edlogo.Text;
  quTable.FieldByName('empr_cert').AsString:= edCert.Text;
  quTable.FieldByName('empr_cida').AsInteger:= StrToIntDef(edCodiCida.Text,0);
  qutable.FieldByName(v_tabela+'_codi').Asfloat  := strtofloatdef(edcodi.Text,0);
  qutable.Post;
  qutable.ApplyUpdates();

  //grava log
  if v_status then
    begin
      formprincipal.controle.Log('Inseriu o registro: '+qutable.fieldbyname(v_tabela+'_codi').AsString+' - '+
                                                        qutable.FieldByName(v_tabela+'_raza').AsString,
                                                        Caption,1);
    end else
     begin
       formprincipal.controle.Log('Editou o registro: '+qutable.fieldbyname(v_tabela+'_codi').AsString+' - '+
                                                        qutable.FieldByName(v_tabela+'_raza').AsString,
                                                        caption,2);
     end;
  FormPrincipal.FormShow(sender);
end;

procedure TFormCadEmpresa.edCepExit(Sender: TObject);
begin
  valida.TipoDocto:= docCEP;
  valida.Documento:= edCep.Text;
  quTable.FieldByName('empr_cep').AsString:= valida.Formatar;
  valida.Validar;
end;

procedure TFormCadEmpresa.edCertPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  with dmdados.nfe do
   begin
     edCert.Text:= Configuracoes.Certificados.SelecionarCertificado;
   end;
end;

procedure TFormCadEmpresa.edCnpjExit(Sender: TObject);
begin
  valida.TipoDocto:= docCNPJ;
  valida.Documento:= edCnpj.Text;
  quTable.FieldByName('empr_cnpj').AsString:= valida.Formatar;
  valida.Validar;
end;

procedure TFormCadEmpresa.edCodiCidaExit(Sender: TObject);
begin
  edNomeCida.Clear;
  edEsta.Clear;
  if StrToIntDef(edCodiCida.Text,0) > 0 then
   begin
     sqlaux.close;
     sqlaux.SQL.Text:= 'select cida_desc, cida_sigl, cida_esta from cadastro.cida where cida_codi = :codi';
     sqlaux.ParamByName('codi').AsInteger:= StrToIntDef(edCodiCida.Text,0);
     sqlaux.Open;
     if sqlaux.IsEmpty then
      begin
        ShowMessage('Cidade não encontrada');
        Exit;
      end;
     edNomeCida.text:= sqlaux.FieldByName('cida_desc').AsString;
     edEsta.Text:= sqlaux.FieldByName('cida_sigl').AsString;
     quTable.FieldByName('empr_codi_esta').AsInteger:= sqlaux.FieldByName('cida_esta').AsInteger;
   end;
end;

procedure TFormCadEmpresa.edCodiCidaPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  edCodiCida.Text:= consulta('cons_cidade');
  edcodicidaexit(Self);
end;

procedure TFormCadEmpresa.edCodiExit(Sender: TObject);
begin
  //carrega tabela referente
  qutable.Close;
  qutable.SQL.Text:= 'select * from '+v_esquema+'.'+v_tabela+' where '+
                                                    v_tabela+'_codi = :codi';
  qutable.ParamByName('codi').AsFloat  := strtofloatdef(edcodi.Text,0);
  qutable.Open;
  if qutable.IsEmpty then
    begin
      // pega o codigo do ultimo registro
      sqlaux.Close;
      sqlaux.SQL.Text:= 'select max('+v_tabela+'_codi) as "codigo" from '+v_esquema+'.'+v_tabela;
      sqlaux.Open;
      sqlaux.Tag:= sqlaux.FieldByName('codigo').AsInteger + 1;

      qutable.Append;
      edcodi.Text:= inttostr(sqlaux.Tag);
      edCodiCida.Clear;
      edCodiCidaExit(Self);
      edcert.Clear;
      edlogo.Clear;
      logo.Picture:= nil;
    end else
     begin
       qutable.Edit;
       edCodiCida.Text:= quTable.FieldByName('empr_cida').AsString;
       edCodiCidaExit(Self);
       edCert.Text:= quTable.FieldByName('empr_cert').AsString;
       edlogo.Text:= quTable.FieldByName('empr_logo').AsString;
       logo.Picture.LoadFromFile(edlogo.Text);
     end;
end;

procedure TFormCadEmpresa.edCodiPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  edcodi.Text:= consulta('cons_empresa');
  edCodiExit(self);
  eddesc.SetFocus;
end;

procedure TFormCadEmpresa.edIeExit(Sender: TObject);
begin
  valida.TipoDocto:= docInscEst;
  valida.Documento:= edIe.Text;
  valida.Complemento:= edEsta.Text;
  quTable.FieldByName('empr_ie').AsString:= valida.Formatar;
  valida.Validar;
end;

procedure TFormCadEmpresa.edlogoPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  if not (qutable.State in [dsInsert, dsEdit]) then
   begin
     ShowMessage('Cadastro não se encontra em modo de Inserção ou Edição');
     Exit;
   end;
  od.Execute;
  edlogo.Text:= od.FileName;
  logo.Picture.LoadFromFile(edlogo.Text);
end;

procedure TFormCadEmpresa.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action:= cafree;
  FormCadEmpresa:= nil;
end;

procedure TFormCadEmpresa.FormShow(Sender: TObject);
begin
  // carrega os dados do form
  lbTitu.Caption               := 'Cadastro de Empresa';
  Caption                      := '..::PROG0019::..';
  v_tabela                     := 'empr';
  v_esquema                    := 'cadastro';
  sb.Panels[0].Text            := 'Navegando...';
  eddesc.DataBinding.DataField := v_tabela+'_raza';
  controle.GroupName           := caption+' - '+lbtitu.Caption;
  cxPageControl2.ActivePageIndex:= 0;
end;

procedure TFormCadEmpresa.quTableAfterCancel(DataSet: TDataSet);
begin
  sb.Panels[0].text:= 'Navegando...';
end;

procedure TFormCadEmpresa.quTableAfterPost(DataSet: TDataSet);
begin
  sb.Panels[0].text:= 'Navegando...';
end;

procedure TFormCadEmpresa.quTableBeforeEdit(DataSet: TDataSet);
begin
  sb.Panels[0].text:= 'Editando registro...';
end;

procedure TFormCadEmpresa.quTableBeforeInsert(DataSet: TDataSet);
begin
  sb.Panels[0].text:= 'Inserindo Registro...';
end;

procedure TFormCadEmpresa.validaMsgErro(Mensagem: string);
begin
  ShowMessage(Valida.MsgErro);
end;

end.
