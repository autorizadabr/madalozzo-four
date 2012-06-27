unit prog0016;

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
  cxMaskEdit, cxButtonEdit, ACBrBase, ACBrEnterTab, cxGroupBox, cxRadioGroup,
  cxCurrencyEdit, cxDropDownEdit, cxImageComboBox, cxMemo;

type
  TFormNaturezaOperacao = class(TForm)
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
    ACBrEnterTab1: TACBrEnterTab;
    cxTabControl2: TcxTabControl;
    edCodi: TcxButtonEdit;
    edDesc: TcxDBTextEdit;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    cxTabSheet1: TcxTabSheet;
    cxTabSheet2: TcxTabSheet;
    cxTabSheet3: TcxTabSheet;
    cxDBRadioGroup1: TcxDBRadioGroup;
    cxLabel20: TcxLabel;
    cxLabel21: TcxLabel;
    cxDBImageComboBox2: TcxDBImageComboBox;
    cxDBImageComboBox3: TcxDBImageComboBox;
    cxLabel22: TcxLabel;
    cxDBImageComboBox4: TcxDBImageComboBox;
    cxLabel23: TcxLabel;
    cxDBCurrencyEdit2: TcxDBCurrencyEdit;
    cxDBCurrencyEdit15: TcxDBCurrencyEdit;
    cxLabel45: TcxLabel;
    cxDBCurrencyEdit4: TcxDBCurrencyEdit;
    cxLabel26: TcxLabel;
    cxDBCurrencyEdit3: TcxDBCurrencyEdit;
    cxLabel25: TcxLabel;
    cxDBImageComboBox5: TcxDBImageComboBox;
    cxLabel24: TcxLabel;
    cxLabel28: TcxLabel;
    cxDBImageComboBox7: TcxDBImageComboBox;
    cxDBImageComboBox6: TcxDBImageComboBox;
    cxLabel27: TcxLabel;
    cxDBCurrencyEdit5: TcxDBCurrencyEdit;
    cxLabel29: TcxLabel;
    cxDBCurrencyEdit6: TcxDBCurrencyEdit;
    cxLabel31: TcxLabel;
    cxDBCurrencyEdit8: TcxDBCurrencyEdit;
    cxLabel34: TcxLabel;
    cxDBImageComboBox9: TcxDBImageComboBox;
    cxDBImageComboBox8: TcxDBImageComboBox;
    cxLabel33: TcxLabel;
    cxLabel30: TcxLabel;
    cxGroupBox1: TcxGroupBox;
    cxDBCheckBox8: TcxDBCheckBox;
    cxDBCheckBox9: TcxDBCheckBox;
    cxDBCheckBox10: TcxDBCheckBox;
    cxDBCheckBox11: TcxDBCheckBox;
    cxDBCheckBox12: TcxDBCheckBox;
    cxDBCheckBox13: TcxDBCheckBox;
    cxDBCheckBox14: TcxDBCheckBox;
    cxDBCheckBox15: TcxDBCheckBox;
    cxDBCheckBox27: TcxDBCheckBox;
    cxDBCheckBox29: TcxDBCheckBox;
    cxDBCheckBox30: TcxDBCheckBox;
    cxDBCheckBox31: TcxDBCheckBox;
    cxDBCheckBox32: TcxDBCheckBox;
    cxDBCheckBox33: TcxDBCheckBox;
    cxGroupBox2: TcxGroupBox;
    cxDBCheckBox16: TcxDBCheckBox;
    cxDBCheckBox17: TcxDBCheckBox;
    cxDBCheckBox18: TcxDBCheckBox;
    cxDBCheckBox19: TcxDBCheckBox;
    cxDBCheckBox23: TcxDBCheckBox;
    cxGroupBox3: TcxGroupBox;
    cxDBCheckBox20: TcxDBCheckBox;
    cxDBCheckBox21: TcxDBCheckBox;
    cxDBCheckBox22: TcxDBCheckBox;
    cxDBCheckBox24: TcxDBCheckBox;
    cxDBCheckBox25: TcxDBCheckBox;
    cxDBCheckBox26: TcxDBCheckBox;
    cxDBCheckBox28: TcxDBCheckBox;
    cxTabSheet4: TcxTabSheet;
    cxTabControl3: TcxTabControl;
    edCodiMens: TcxButtonEdit;
    cxLabel3: TcxLabel;
    edNomeMens: TcxTextEdit;
    cxLabel4: TcxLabel;
    cxTabControl4: TcxTabControl;
    cxLabel5: TcxLabel;
    cxDBMemo1: TcxDBMemo;
    cxDBTextEdit1: TcxDBTextEdit;
    cxLabel6: TcxLabel;
    cxGroupBox4: TcxGroupBox;
    edAtiv: TcxDBCheckBox;
    cxDBCheckBox5: TcxDBCheckBox;
    cxDBCheckBox1: TcxDBCheckBox;
    cxDBCheckBox2: TcxDBCheckBox;
    cxDBCheckBox6: TcxDBCheckBox;
    cxDBCheckBox7: TcxDBCheckBox;
    cxDBCheckBox3: TcxDBCheckBox;
    cxDBCheckBox4: TcxDBCheckBox;
    cxDBCheckBox34: TcxDBCheckBox;
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
    procedure edCodiMensPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure edCodiMensExit(Sender: TObject);
  private
    v_tabela,
    v_esquema : string;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormNaturezaOperacao: TFormNaturezaOperacao;

implementation

uses prog0001, prog0003, rotinas;

{$R *.dfm}

procedure TFormNaturezaOperacao.btnFecharClick(Sender: TObject);
begin
  close;
end;

procedure TFormNaturezaOperacao.btnGravarClick(Sender: TObject);
var
  v_status : boolean;
begin
  if not (quTable.State in [dsEdit, dsInsert]) then Exit;

  if qutable.State in [dsInsert] then
    v_status:= true
  else
  if qutable.State in [dsEdit] then
    v_status:= false;

  qutable.FieldByName(v_tabela+'_empr').AsInteger:= formprincipal.puempresa;
  qutable.FieldByName(v_tabela+'_loca').AsInteger:= formprincipal.pulocal;
  qutable.FieldByName(v_tabela+'_codi').Asfloat  := strtofloatdef(edcodi.Text,0);
  qutable.FieldByName(v_tabela+'_codi_mens').AsInteger:= strtointdef(edCodiMens.Text,0);
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

procedure TFormNaturezaOperacao.edCodiExit(Sender: TObject);
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
      edCodiMens.Clear;
      edNomeMens.Clear
    end else
     begin
       qutable.Edit;
       edCodiMens.Text:= qutable.FieldByName('natu_codi_mens').AsString;
       edCodiMensExit(self);
     end;
end;

procedure TFormNaturezaOperacao.edCodiMensExit(Sender: TObject);
begin
  edNomeMens.Clear;
  qutable.FieldByName('natu_obse').AsString:= '';
  if strtointdef(edCodiMens.Text,0) > 0 then
   begin
     sqlaux.Close;
     sqlaux.SQL.Text:= 'select mens_desc, mens_mens from cadastro.mens where mens_codi = :codi '+
                       'and mens_empr = :empr and mens_loca = :loca';
     sqlaux.ParamByName('empr').AsInteger:= formprincipal.puempresa;
     sqlaux.ParamByName('loca').AsInteger:= formprincipal.pulocal;
     sqlaux.ParamByName('codi').AsFloat:= strtofloatdef(edCodiMens.Text,0);
     sqlaux.Open;
     if not sqlaux.IsEmpty then
      begin
        edNomeMens.Text:= sqlaux.FieldByName('mens_desc').AsString;
        qutable.FieldByName('natu_obse').AsString:= sqlaux.FieldByName('mens_mens').AsString;
      end else
       begin
         showmessage('Mensagem Fiscal não Encontrada');
         exit;
       end;
   end;
end;

procedure TFormNaturezaOperacao.edCodiMensPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  edCodiMens.Text:= consulta('cons_mensagem');
  edCodiMensexit(self);
end;

procedure TFormNaturezaOperacao.edCodiPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  edcodi.Text:= consulta('cons_cfop');
  edCodiExit(self);
  eddesc.SetFocus;
end;

procedure TFormNaturezaOperacao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action:= cafree;
  FormNaturezaOperacao:= nil;
end;

procedure TFormNaturezaOperacao.FormShow(Sender: TObject);
begin
  // carrega os dados do form
  cxpagecontrol1.ActivePageIndex:= 0;
  lbTitu.Caption               := 'Natureza de Operação';
  Caption                      := '..::PROG0016::..';
  v_tabela                     := 'natu';
  v_esquema                    := 'cadastro';
  sb.Panels[0].Text            := 'Navegando...';
  eddesc.DataBinding.DataField := v_tabela+'_desc';
  edAtiv.DataBinding.DataField := v_tabela+'_ativ';
  controle.GroupName           := caption+' - '+lbtitu.Caption;
end;

procedure TFormNaturezaOperacao.quTableAfterCancel(DataSet: TDataSet);
begin
  sb.Panels[0].text:= 'Navegando...';
end;

procedure TFormNaturezaOperacao.quTableAfterPost(DataSet: TDataSet);
begin
  sb.Panels[0].text:= 'Navegando...';
end;

procedure TFormNaturezaOperacao.quTableBeforeEdit(DataSet: TDataSet);
begin
  sb.Panels[0].text:= 'Editando registro...';
end;

procedure TFormNaturezaOperacao.quTableBeforeInsert(DataSet: TDataSet);
begin
  sb.Panels[0].text:= 'Inserindo Registro...';
end;

end.
