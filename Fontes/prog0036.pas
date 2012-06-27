unit prog0036;

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
  TFormParametro = class(TForm)
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
    cxLabel1: TcxLabel;
    cxPageControl2: TcxPageControl;
    cxTabSheet1: TcxTabSheet;
    cxDBCheckBox1: TcxDBCheckBox;
    cxDBCheckBox2: TcxDBCheckBox;
    cxTabSheet2: TcxTabSheet;
    cxDBCheckBox3: TcxDBCheckBox;
    cxTabSheet3: TcxTabSheet;
    cxLabel2: TcxLabel;
    cxLabel3: TcxLabel;
    cxLabel4: TcxLabel;
    cxDBTextEdit1: TcxDBTextEdit;
    cxDBTextEdit2: TcxDBTextEdit;
    cxDBTextEdit3: TcxDBTextEdit;
    cxDBTextEdit4: TcxDBTextEdit;
    cxLabel5: TcxLabel;
    cxDBTextEdit5: TcxDBTextEdit;
    cxLabel6: TcxLabel;
    cxLabel7: TcxLabel;
    cxDBImageComboBox1: TcxDBImageComboBox;
    ACBrEnterTab1: TACBrEnterTab;
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
  private
    v_tabela,
    v_esquema : string;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormParametro: TFormParametro;

implementation

uses prog0001, prog0003, rotinas;

{$R *.dfm}

procedure TFormParametro.btnFecharClick(Sender: TObject);
begin
  close;
end;

procedure TFormParametro.btnGravarClick(Sender: TObject);
var
  v_status : boolean;
begin
  if qutable.State in [dsInsert] then
    v_status:= true
  else
  if qutable.State in [dsEdit] then
    v_status:= false;

  qutable.FieldByName(v_tabela+'_empr').AsInteger:= formprincipal.puempresa;
  qutable.FieldByName(v_tabela+'_loca').AsInteger:= formprincipal.pulocal;
  qutable.FieldByName(v_tabela+'_codi').Asfloat  := strtofloatdef(edcodi.Text,0);
  qutable.Post;
  qutable.ApplyUpdates();

  //grava log
  if v_status then
    begin
      formprincipal.controle.Log('Inseriu o registro: '+qutable.fieldbyname(v_tabela+'_codi').AsString+' - '+
                                                        '',
                                                        Caption,1);
    end else
     begin
       formprincipal.controle.Log('Editou o registro: '+qutable.fieldbyname(v_tabela+'_codi').AsString+' - '+
                                                        '',
                                                        caption,2);
     end;
  FormPrincipal.FormShow(sender);
end;

procedure TFormParametro.edCodiExit(Sender: TObject);
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
    end else
     begin
       qutable.Edit;
     end;
end;

procedure TFormParametro.edCodiPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  edcodi.Text:= consulta('cons_parametro');
  edCodiExit(self);
end;

procedure TFormParametro.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action:= cafree;
  FormParametro:= nil;
end;

procedure TFormParametro.FormShow(Sender: TObject);
begin
  // carrega os dados do form
  lbTitu.Caption                := 'Parametros';
  Caption                       := '..::PROG0036::..';
  v_tabela                      := 'para';
  v_esquema                     := 'cadastro';
  sb.Panels[0].Text             := 'Navegando...';
  controle.GroupName            := caption+' - '+lbtitu.Caption;
  cxPageControl2.ActivePageIndex:= 0;
end;

procedure TFormParametro.quTableAfterCancel(DataSet: TDataSet);
begin
  sb.Panels[0].text:= 'Navegando...';
end;

procedure TFormParametro.quTableAfterPost(DataSet: TDataSet);
begin
  sb.Panels[0].text:= 'Navegando...';
end;

procedure TFormParametro.quTableBeforeEdit(DataSet: TDataSet);
begin
  sb.Panels[0].text:= 'Editando registro...';
end;

procedure TFormParametro.quTableBeforeInsert(DataSet: TDataSet);
begin
  sb.Panels[0].text:= 'Inserindo Registro...';
end;

end.
