unit prog0024;

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
  cxMaskEdit, cxButtonEdit, ACBrBase, ACBrEnterTab, cxCurrencyEdit;

type
  TFormTabelaPreco = class(TForm)
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
    cxLabel2: TcxLabel;
    ACBrEnterTab1: TACBrEnterTab;
    cxPageControl2: TcxPageControl;
    edNomeProd: TcxTextEdit;
    cxLabel3: TcxLabel;
    cxLabel4: TcxLabel;
    cxLabel5: TcxLabel;
    cxLabel6: TcxLabel;
    cxDBCurrencyEdit1: TcxDBCurrencyEdit;
    cxDBCurrencyEdit2: TcxDBCurrencyEdit;
    cxDBCurrencyEdit3: TcxDBCurrencyEdit;
    cxDBCurrencyEdit4: TcxDBCurrencyEdit;
    cxDBCurrencyEdit5: TcxDBCurrencyEdit;
    cxLabel7: TcxLabel;
    cxDBCurrencyEdit6: TcxDBCurrencyEdit;
    cxLabel8: TcxLabel;
    cxDBCurrencyEdit7: TcxDBCurrencyEdit;
    cxLabel9: TcxLabel;
    cxDBCurrencyEdit8: TcxDBCurrencyEdit;
    cxLabel10: TcxLabel;
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
    procedure cxDBCurrencyEdit3PropertiesChange(Sender: TObject);
  private
    v_tabela,
    v_esquema : string;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormTabelaPreco: TFormTabelaPreco;

implementation

uses prog0001, prog0003, rotinas;

{$R *.dfm}

procedure TFormTabelaPreco.brnExcluirClick(Sender: TObject);
begin
  if MessageDlg('Deseja Realmente Excluir o Registro?',  mtConfirmation, [mbYes, mbNo], 0) = mrYes then
   begin
     // grava log
     formprincipal.controle.Log('Excluiu o registro: '+qutable.fieldbyname(v_tabela+'_codi').asstring+' - '+
                                                       '',
                                                       Caption,3);
     qutable.Delete;
     qutable.ApplyUpdates();
     edcodi.Clear;
   end;
end;

procedure TFormTabelaPreco.btnFecharClick(Sender: TObject);
begin
  close;
end;

procedure TFormTabelaPreco.btnGravarClick(Sender: TObject);
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
  qutable.FieldByName(v_tabela+'_prod').Asfloat  := strtofloatdef(edcodi.Text,0);
  qutable.Post;
  qutable.ApplyUpdates();

  //grava log
  if v_status then
    begin
      formprincipal.controle.Log('Inseriu o registro: '+qutable.fieldbyname(v_tabela+'_prod').AsString+' - '+
                                                        '',
                                                        Caption,1);
    end else
     begin
       formprincipal.controle.Log('Editou o registro: '+qutable.fieldbyname(v_tabela+'_prod').AsString+' - '+
                                                        '',
                                                        caption,2);
     end;
  edCodi.SetFocus;
end;

procedure TFormTabelaPreco.cxDBCurrencyEdit3PropertiesChange(Sender: TObject);
var
  v_valo_vist,
  v_valo_praz : Currency;
begin
  v_valo_vist:= 0;
  v_valo_praz:= 0;
  if quTable.State in [dsEdit, dsInsert] then
   begin
     //valor a vista
     v_valo_vist:= ((quTable.FieldByName('tapr_valo_comp').AsFloat +
                     quTable.FieldByName('tapr_outr_valo').AsFloat) *
                     quTable.FieldByName('tapr_perc_lucr').AsFloat) / 100;

     quTable.FieldByName('tapr_valo_vend').asfloat:= quTable.FieldByName('tapr_valo_comp').AsFloat +
                                                     quTable.FieldByName('tapr_outr_valo').AsFloat +
                                                     v_valo_vist;
     //valor a prazo
     v_valo_praz:= ((quTable.FieldByName('tapr_valo_vend').AsFloat) *
                     quTable.FieldByName('tapr_perc_praz').AsFloat) / 100;
     quTable.FieldByName('tapr_valo_praz').asfloat:= quTable.FieldByName('tapr_valo_vend').AsFloat +
                                                     v_valo_praz;
   end;
end;

procedure TFormTabelaPreco.edCodiExit(Sender: TObject);
begin
  //carrega tabela referente
  qutable.Close;
  qutable.SQL.Text:= 'select * from '+v_esquema+'.'+v_tabela+' where '+
                                                    v_tabela+'_empr = :empr and '+
                                                    v_tabela+'_loca = :loca and '+
                                                    v_tabela+'_prod = :codi';
  qutable.ParamByName('empr').AsInteger:= formprincipal.puempresa;
  qutable.ParamByName('loca').AsInteger:= formprincipal.pulocal;
  qutable.ParamByName('codi').AsFloat  := strtofloatdef(edcodi.Text,0);
  qutable.Open;
  if qutable.IsEmpty then
    begin
      qutable.Append;
    end else
     begin
       qutable.Edit;
     end;


  edNomeProd.Clear;
  if StrToFloatdef(edcodi.Text,0) > 0 then
    begin
      sqlaux.Close;
      sqlaux.SQL.Text:= 'select prod_desc from cadastro.prod where prod_codi = :prod';
      sqlaux.ParamByName('prod').AsFloat:= StrToFloatDef(edcodi.Text,0);
      sqlaux.Open;
      if sqlaux.IsEmpty then
        begin
          ShowMessage('Produto não encontrado');
          Exit;
        end;
      edNomeProd.Text:= sqlaux.FieldByName('prod_desc').AsString;
    end;
end;

procedure TFormTabelaPreco.edCodiPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  edcodi.Text:= consulta('cons_produto');
  edCodiExit(self);
end;

procedure TFormTabelaPreco.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action:= cafree;
  FormTabelaPreco:= nil;
end;

procedure TFormTabelaPreco.FormShow(Sender: TObject);
begin
  // carrega os dados do form
  lbTitu.Caption               := 'Tabela de Preço';
  Caption                      := '..::PROG0024::..';
  v_tabela                     := 'tapr';
  v_esquema                    := 'cadastro';
  sb.Panels[0].Text            := 'Navegando...';
  controle.GroupName           := caption+' - '+lbtitu.Caption;
end;

procedure TFormTabelaPreco.quTableAfterCancel(DataSet: TDataSet);
begin
  sb.Panels[0].text:= 'Navegando...';
end;

procedure TFormTabelaPreco.quTableAfterPost(DataSet: TDataSet);
begin
  sb.Panels[0].text:= 'Navegando...';
end;

procedure TFormTabelaPreco.quTableBeforeEdit(DataSet: TDataSet);
begin
  sb.Panels[0].text:= 'Editando registro...';
end;

procedure TFormTabelaPreco.quTableBeforeInsert(DataSet: TDataSet);
begin
  sb.Panels[0].text:= 'Inserindo Registro...';
end;

end.
