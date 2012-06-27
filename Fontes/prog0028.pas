unit prog0028;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, Menus, cxPC, ImgList, UCBase, DB, DBAccess, Uni, MemDS,
  ACBrBase, ACBrEnterTab, ComCtrls, StdCtrls, cxButtons, dxGDIPlusClasses,
  ExtCtrls, cxLabel, cxMemo, cxGroupBox, cxTextEdit;

type
  TFormInutilizar = class(TForm)
    lbTitu: TcxLabel;
    Image1: TImage;
    cxTabControl1: TcxTabControl;
    btnFechar: TcxButton;
    btnInutilizar: TcxButton;
    sb: TStatusBar;
    ACBrEnterTab1: TACBrEnterTab;
    controle: TUCControls;
    cxPageControl1: TcxPageControl;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    cxLabel3: TcxLabel;
    cxLabel4: TcxLabel;
    cxLabel5: TcxLabel;
    edAno: TcxTextEdit;
    edMode: TcxTextEdit;
    edSeri: TcxTextEdit;
    edInic: TcxTextEdit;
    edFina: TcxTextEdit;
    cxGroupBox1: TcxGroupBox;
    edJust: TcxMemo;
    sqlaux: TUniQuery;
    procedure btnFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnInutilizarClick(Sender: TObject);
    procedure edSeriExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormInutilizar: TFormInutilizar;

implementation

uses prog0003, prog0001;

{$R *.dfm}

procedure TFormInutilizar.btnFecharClick(Sender: TObject);
begin
  close;
end;

procedure TFormInutilizar.btnInutilizarClick(Sender: TObject);
begin
  try
    with dmdados.nfe do
     begin
       WebServices.Inutiliza(dmdados.tbEmpr.FieldByName('empr_cnpj').AsString,
                             edJust.Text,
                             StrToInt(edAno.Text),
                             StrToInt(edMode.Text),
                             StrToInt(edSeri.Text),
                             StrToInt(edInic.Text),
                             StrToInt(edFina.Text));
     end;
  finally
    sqlaux.Close;
    sqlaux.SQL.Text:= 'update cadastro.seri set seri_sequ = :sequ where seri_empr = :empr '+
                      'and seri_loca = :loca and seri_seri = :seri';
    sqlaux.ParamByName('empr').AsInteger:= FormPrincipal.puempresa;
    sqlaux.ParamByName('loca').AsInteger:= FormPrincipal.pulocal;
    sqlaux.ParamByName('seri').AsString := FormatFloat('000',StrToFloatDef(edSeri.Text,0));
    sqlaux.ParamByName('sequ').AsFloat  := StrToFloatdef(edFina.Text,0);
    sqlaux.ExecSQL;
    ShowMessage('Inutilização executada com sucesso');
  end;
end;

procedure TFormInutilizar.edSeriExit(Sender: TObject);
begin
  if ActiveControl = btnFechar then Exit;
  sqlaux.Close;
  sqlaux.SQL.Text:= 'select * from cadastro.seri where seri_empr = :empr '+
                    'and seri_loca = :loca and seri_seri = :seri';
  sqlaux.ParamByName('empr').AsInteger:= FormPrincipal.puempresa;
  sqlaux.ParamByName('loca').AsInteger:= FormPrincipal.pulocal;
  sqlaux.ParamByName('seri').AsString := FormatFloat('000',StrToFloatDef(edSeri.Text,0));
  sqlaux.Open;
  if sqlaux.IsEmpty then
   begin
     ShowMessage('Série não cadastrada no sistema');
     Exit;
   end;
end;

procedure TFormInutilizar.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action:= caFree;
  FormInutilizar:= nil;
end;

end.
