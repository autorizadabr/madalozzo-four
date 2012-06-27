unit prog0030;

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
  cxMaskEdit, cxButtonEdit, ACBrBase, ACBrEnterTab, cxMemo, cxGroupBox,
  cxDropDownEdit, cxImageComboBox;

type
  TFormContingencia = class(TForm)
    cxTabControl1: TcxTabControl;
    btnFechar: TcxButton;
    btnEntra: TcxButton;
    btnsair: TcxButton;
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
    cxLabel2: TcxLabel;
    cxDBTextEdit1: TcxDBTextEdit;
    cxDBTextEdit2: TcxDBTextEdit;
    cxLabel3: TcxLabel;
    cxDBImageComboBox3: TcxDBImageComboBox;
    cxLabel22: TcxLabel;
    cxGroupBox1: TcxGroupBox;
    cxDBMemo1: TcxDBMemo;
    btnConfirma: TcxButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnFecharClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnEntraClick(Sender: TObject);
    procedure btnsairClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
  private
    v_tabela,
    v_esquema : string;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormContingencia: TFormContingencia;

implementation

uses prog0001, prog0003, rotinas;

{$R *.dfm}

procedure TFormContingencia.btnConfirmaClick(Sender: TObject);
begin
  if quTable.FieldByName('cont_just').AsString = '' then
   begin
     ShowMessage('Favor indicar a justificativa');
     Exit;
   end;

  if quTable.FieldByName('cont_ambi').AsInteger = 0 then
   begin
     ShowMessage('Favor indicar o ambiente');
     Exit;
   end;

  quTable.Post;
  quTable.ApplyUpdates();
end;

procedure TFormContingencia.btnEntraClick(Sender: TObject);
begin
  if MessageDlg('Confirma entrada em Contingência ???',  mtConfirmation, [mbYes, mbNo], 0) = mrYes then
   begin
     quTable.Append;
     quTable.FieldByName('cont_empr').AsInteger  := FormPrincipal.puempresa;
     quTable.FieldByName('cont_loca').AsInteger  := FormPrincipal.pulocal;
     quTable.FieldByName('cont_entr').AsDateTime := Now;

     formprincipal.controle.Log('Entrou em Contigência:'+qutable.fieldbyname(v_tabela+'_id').AsString+' - '+
                                                         qutable.FieldByName(v_tabela+'_entr').AsString,
                                                         Caption,1);
   end;
  if (quTable.FieldByName('cont_said').IsNull) and
     (not quTable.FieldByName('cont_entr').IsNull) then
    begin
      btnsair.Enabled:= true;
      btnEntra.Enabled:= false;
    end
  else
    begin
      btnsair.Enabled:= false;
      btnEntra.Enabled:= true;
    end;
end;

procedure TFormContingencia.btnFecharClick(Sender: TObject);
begin
  close;
end;

procedure TFormContingencia.btnsairClick(Sender: TObject);
begin
  if MessageDlg('Confirma saída em Contingência ???',  mtConfirmation, [mbYes, mbNo], 0) = mrYes then
   begin
     quTable.edit;
     quTable.FieldByName('cont_said').AsDateTime := Now;

     formprincipal.controle.Log('Saiu da Contigência:'+qutable.fieldbyname(v_tabela+'_id').AsString+' - '+
                                                       qutable.FieldByName(v_tabela+'_said').AsString,
                                                       Caption,1);
   end;
  if (quTable.FieldByName('cont_said').IsNull) and
     (not quTable.FieldByName('cont_entr').IsNull) then
    begin
      btnsair.Enabled:= true;
      btnEntra.Enabled:= false;
    end
  else
    begin
      btnsair.Enabled:= false;
      btnEntra.Enabled:= true;
    end;
end;

procedure TFormContingencia.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action:= cafree;
  FormContingencia:= nil;
end;

procedure TFormContingencia.FormShow(Sender: TObject);
begin
  // carrega os dados do form
  lbTitu.Caption               := 'Contingência';
  Caption                      := '..::PROG0030::..';
  v_tabela                     := 'cont';
  v_esquema                    := 'movimento';
  sb.Panels[0].Text            := 'Navegando...';
  controle.GroupName           := caption+' - '+lbtitu.Caption;

  quTable.Close;
  quTable.SQL.Text:= 'select * from movimento.cont where cont_empr = :empr and cont_loca = :loca';
  qutable.ParamByName('empr').AsInteger:= FormPrincipal.puempresa;
  quTable.ParamByName('loca').AsInteger:= FormPrincipal.pulocal;
  quTable.Open;
  quTable.Last;

  if (quTable.FieldByName('cont_said').IsNull) and
     (not quTable.FieldByName('cont_entr').IsNull) then
    begin
      btnsair.Enabled:= true;
      btnEntra.Enabled:= false;
    end
  else
    begin
      btnsair.Enabled:= false;
      btnEntra.Enabled:= true;
    end;
end;

end.
