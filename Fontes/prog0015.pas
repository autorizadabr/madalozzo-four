unit prog0015;

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
  cxMaskEdit, cxButtonEdit, ACBrBase, ACBrEnterTab, cxMemo;

type
  TFormMensagem = class(TForm)
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
    edAtiv: TcxDBCheckBox;
    ACBrEnterTab1: TACBrEnterTab;
    cxLabel3: TcxLabel;
    cxDBMemo1: TcxDBMemo;
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
  private
    v_tabela,
    v_esquema : string;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormMensagem: TFormMensagem;

implementation

uses prog0001, prog0003, rotinas;

{$R *.dfm}

procedure TFormMensagem.brnExcluirClick(Sender: TObject);
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
   end;
end;

procedure TFormMensagem.btnFecharClick(Sender: TObject);
begin
  close;
end;

procedure TFormMensagem.btnGravarClick(Sender: TObject);
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

procedure TFormMensagem.edCodiExit(Sender: TObject);
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

procedure TFormMensagem.edCodiPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  edcodi.Text:= consulta('cons_mensagem');
  edCodiExit(self);
  eddesc.SetFocus;
end;

procedure TFormMensagem.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action:= cafree;
  FormMensagem:= nil;
end;

procedure TFormMensagem.FormShow(Sender: TObject);
begin
  // carrega os dados do form
  lbTitu.Caption               := 'Mensagens Fiscais';
  Caption                      := '..::PROG0015::..';
  v_tabela                     := 'mens';
  v_esquema                    := 'cadastro';
  sb.Panels[0].Text            := 'Navegando...';
  eddesc.DataBinding.DataField := v_tabela+'_desc';
  edAtiv.DataBinding.DataField := v_tabela+'_ativ';
  controle.GroupName           := caption+' - '+lbtitu.Caption;
end;

procedure TFormMensagem.quTableAfterCancel(DataSet: TDataSet);
begin
  sb.Panels[0].text:= 'Navegando...';
end;

procedure TFormMensagem.quTableAfterPost(DataSet: TDataSet);
begin
  sb.Panels[0].text:= 'Navegando...';
end;

procedure TFormMensagem.quTableBeforeEdit(DataSet: TDataSet);
begin
  sb.Panels[0].text:= 'Editando registro...';
end;

procedure TFormMensagem.quTableBeforeInsert(DataSet: TDataSet);
begin
  sb.Panels[0].text:= 'Inserindo Registro...';
end;

end.
