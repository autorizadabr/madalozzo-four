unit prog0020;

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
  cxImageComboBox, cxCurrencyEdit;

type
  TFormRequisicao = class(TForm)
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
    cxLabel1: TcxLabel;
    ACBrEnterTab1: TACBrEnterTab;
    cxTabControl2: TcxTabControl;
    edCodiProd: TcxButtonEdit;
    cxLabel3: TcxLabel;
    cxLabel4: TcxLabel;
    cxDBImageComboBox1: TcxDBImageComboBox;
    cxDBDateEdit1: TcxDBDateEdit;
    cxLabel2: TcxLabel;
    edNomeProd: TcxTextEdit;
    edSald: TcxTextEdit;
    cxLabel5: TcxLabel;
    cxLabel6: TcxLabel;
    cxDBTextEdit1: TcxDBTextEdit;
    cxLabel7: TcxLabel;
    cxLabel8: TcxLabel;
    cxDBCurrencyEdit1: TcxDBCurrencyEdit;
    cxDBCurrencyEdit2: TcxDBCurrencyEdit;
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
    procedure cxDBTextEdit1PropertiesEditValueChanged(Sender: TObject);
    procedure edCodiProdPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure edCodiProdExit(Sender: TObject);
  private
    v_tabela,
    v_esquema : string;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormRequisicao: TFormRequisicao;

implementation

uses prog0001, prog0003, rotinas;

{$R *.dfm}

procedure TFormRequisicao.brnExcluirClick(Sender: TObject);
begin
  if MessageDlg('Deseja Realmente Excluir o Registro?',  mtConfirmation, [mbYes, mbNo], 0) = mrYes then
   begin
     // grava log
     formprincipal.controle.Log('Excluiu o registro: '+qutable.fieldbyname(v_tabela+'_codi').asstring+' - '+
                                                       qutable.FieldByName(v_tabela+'_prod').asstring,
                                                       Caption,3);
     qutable.Delete;
     qutable.ApplyUpdates();
     edcodi.Clear;
     edCodiProd.Clear;
     edCodiProdExit(Self);
   end;
end;

procedure TFormRequisicao.btnFecharClick(Sender: TObject);
begin
  close;
end;

procedure TFormRequisicao.btnGravarClick(Sender: TObject);
var
  v_status : boolean;
begin
  if qutable.State in [dsInsert] then
    v_status:= true
  else
  if qutable.State in [dsEdit] then
    v_status:= false;

  quTable.FieldByName('requ_prod').AsFloat:= StrToFloatDef(edCodiProd.Text,0);
  qutable.FieldByName(v_tabela+'_empr').AsInteger:= formprincipal.puempresa;
  qutable.FieldByName(v_tabela+'_loca').AsInteger:= formprincipal.pulocal;
  qutable.FieldByName(v_tabela+'_codi').Asfloat  := strtofloatdef(edcodi.Text,0);
  qutable.Post;
  qutable.ApplyUpdates();

  //grava log
  if v_status then
    begin
      formprincipal.controle.Log('Inseriu o registro: '+qutable.fieldbyname(v_tabela+'_codi').AsString+' - '+
                                                        qutable.FieldByName(v_tabela+'_prod').AsString,
                                                        Caption,1);
    end else
     begin
       formprincipal.controle.Log('Editou o registro: '+qutable.fieldbyname(v_tabela+'_codi').AsString+' - '+
                                                        qutable.FieldByName(v_tabela+'_prod').AsString,
                                                        caption,2);
     end;
end;

procedure TFormRequisicao.cxDBTextEdit1PropertiesEditValueChanged(
  Sender: TObject);
begin
  if quTable.State in [dsInsert, dsEdit] then
    quTable.FieldByName('requ_tota').AsFloat:= quTable.fieldbyname('requ_quan').asfloat * quTable.FieldByName('requ_unit').AsFloat;
end;

procedure TFormRequisicao.edCodiExit(Sender: TObject);
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
      quTable.FieldByName('requ_data').AsDateTime:= Date;
      edCodiProd.Clear;
      edcodiprodexit(Self);
      edSald.Clear;
    end else
     begin
       qutable.Edit;
       edCodiProd.Text:= quTable.FieldByName('requ_prod').AsString;
       edCodiProdExit(Self);
     end;
end;

procedure TFormRequisicao.edCodiProdExit(Sender: TObject);
begin
  edNomeProd.Clear;
  edSald.Clear;
  if StrToIntDef(edCodiProd.Text,0) > 0  then
    begin
      sqlaux.Close;
      sqlaux.SQL.Text:= 'select prod_desc, '+
                        '(select saldo from movimento.vw_esto where prod_codi = prod_codi '+
                        '                                       and empresa = :empr '+
                        '                                       and local = :loca) as "saldo" '+
                        'from cadastro.prod where prod_codi = :prod';
      sqlaux.ParamByName('empr').AsInteger:= FormPrincipal.puempresa;
      sqlaux.ParamByName('loca').AsInteger:= FormPrincipal.pulocal;
      sqlaux.ParamByName('prod').AsFloat:= StrToFloatDef(edCodiProd.Text,0);
      sqlaux.Open;
      if sqlaux.IsEmpty then
        begin
          ShowMessage('Produto não encontrado');
          Exit;
        end;
      edNomeProd.Text:= sqlaux.FieldByName('prod_desc').AsString;
      edSald.Text:= sqlaux.FieldByName('saldo').AsString;
    end;
end;

procedure TFormRequisicao.edCodiProdPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  edCodiProd.Text:= consulta('cons_produto');
  edCodiProdexit(Self);
end;

procedure TFormRequisicao.edCodiPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  edcodi.Text:= consulta('cons_requisicao');
  edCodiExit(self);
end;

procedure TFormRequisicao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action:= cafree;
  FormRequisicao:= nil;
end;

procedure TFormRequisicao.FormShow(Sender: TObject);
begin
  // carrega os dados do form
  lbTitu.Caption               := 'Requisições';
  Caption                      := '..::PROG0020::..';
  v_tabela                     := 'requ';
  v_esquema                    := 'movimento';
  sb.Panels[0].Text            := 'Navegando...';
  controle.GroupName           := caption+' - '+lbtitu.Caption;
end;

procedure TFormRequisicao.quTableAfterCancel(DataSet: TDataSet);
begin
  sb.Panels[0].text:= 'Navegando...';
end;

procedure TFormRequisicao.quTableAfterPost(DataSet: TDataSet);
begin
  sb.Panels[0].text:= 'Navegando...';
end;

procedure TFormRequisicao.quTableBeforeEdit(DataSet: TDataSet);
begin
  sb.Panels[0].text:= 'Enditando registro...';
end;

procedure TFormRequisicao.quTableBeforeInsert(DataSet: TDataSet);
begin
  sb.Panels[0].text:= 'Inserindo Registro...';
end;

end.
