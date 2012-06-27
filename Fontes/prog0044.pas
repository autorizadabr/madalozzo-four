unit prog0044;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, Menus,
  StdCtrls, cxButtons, cxPC, ComCtrls, dxGDIPlusClasses, ExtCtrls, cxContainer,
  cxEdit, cxLabel, ImgList, UCBase, DB, MemDS, DBAccess, Uni, ACBrBase,
  ACBrEnterTab, ELibFnc, ECmpCol, cxTextEdit, cxMaskEdit, cxButtonEdit,
  cxDropDownEdit, cxCalendar, RLReport;

type
  TFormLivroEntrada = class(TForm)
    Image1: TImage;
    sb: TStatusBar;
    cxTabControl1: TcxTabControl;
    btnFechar: TcxButton;
    btnImprimir: TcxButton;
    cxTabControl2: TcxTabControl;
    EvCompCollector1: TEvCompCollector;
    EvLibFunctions1: TEvLibFunctions;
    ACBrEnterTab1: TACBrEnterTab;
    sqlaux: TUniQuery;
    controle: TUCControls;
    imagem: TImageList;
    lbTitu: TcxLabel;
    edCfop: TcxButtonEdit;
    cxLabel18: TcxLabel;
    edNomeCfop: TcxTextEdit;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    inic: TcxDateEdit;
    fina: TcxDateEdit;
    RLReport3: TRLReport;
    RLGroup1: TRLGroup;
    RLBand11: TRLBand;
    RLLabel50: TRLLabel;
    RLDBText37: TRLDBText;
    RLDBText38: TRLDBText;
    RLDBText39: TRLDBText;
    lblFolha: TRLLabel;
    lblPeriodo: TRLLabel;
    RLSystemInfo2: TRLSystemInfo;
    RLBand12: TRLBand;
    RLDraw19: TRLDraw;
    RLDraw8: TRLDraw;
    RLDraw7: TRLDraw;
    RLDraw3: TRLDraw;
    RLLabel51: TRLLabel;
    RLDraw4: TRLDraw;
    RLLabel52: TRLLabel;
    RLDraw5: TRLDraw;
    RLLabel53: TRLLabel;
    RLDraw6: TRLDraw;
    RLLabel54: TRLLabel;
    RLLabel55: TRLLabel;
    RLLabel68: TRLLabel;
    RLDraw9: TRLDraw;
    RLLabel69: TRLLabel;
    RLLabel70: TRLLabel;
    RLDraw10: TRLDraw;
    RLLabel71: TRLLabel;
    RLDraw11: TRLDraw;
    RLLabel72: TRLLabel;
    RLDraw12: TRLDraw;
    RLLabel73: TRLLabel;
    RLDraw13: TRLDraw;
    RLLabel74: TRLLabel;
    RLDraw14: TRLDraw;
    RLLabel75: TRLLabel;
    RLDraw15: TRLDraw;
    RLLabel76: TRLLabel;
    RLDraw16: TRLDraw;
    RLLabel77: TRLLabel;
    RLDraw17: TRLDraw;
    RLLabel78: TRLLabel;
    RLDraw18: TRLDraw;
    RLLabel79: TRLLabel;
    RLLabel80: TRLLabel;
    RLDraw20: TRLDraw;
    RLLabel81: TRLLabel;
    RLDraw21: TRLDraw;
    RLLabel82: TRLLabel;
    RLBand13: TRLBand;
    RLDBText40: TRLDBText;
    RLDraw22: TRLDraw;
    RLDBText41: TRLDBText;
    RLDraw23: TRLDraw;
    RLDBText42: TRLDBText;
    RLDraw24: TRLDraw;
    RLDBText43: TRLDBText;
    RLDraw25: TRLDraw;
    RLDraw26: TRLDraw;
    RLDBText44: TRLDBText;
    RLDraw27: TRLDraw;
    RLDBText45: TRLDBText;
    RLDraw28: TRLDraw;
    RLDBText46: TRLDBText;
    RLDBText47: TRLDBText;
    RLDraw29: TRLDraw;
    RLDBText48: TRLDBText;
    RLDraw30: TRLDraw;
    RLDBText49: TRLDBText;
    RLDraw31: TRLDraw;
    RLDBText50: TRLDBText;
    RLDraw32: TRLDraw;
    RLDBText51: TRLDBText;
    RLDraw33: TRLDraw;
    RLDBText52: TRLDBText;
    RLDraw34: TRLDraw;
    RLDBText53: TRLDBText;
    RLBand15: TRLBand;
    RLDraw35: TRLDraw;
    RLDBResult19: TRLDBResult;
    RLDraw36: TRLDraw;
    RLDraw37: TRLDraw;
    RLDraw38: TRLDraw;
    RLDBResult20: TRLDBResult;
    RLDraw39: TRLDraw;
    RLDraw40: TRLDraw;
    RLDBResult21: TRLDBResult;
    RLDraw41: TRLDraw;
    RLDBResult22: TRLDBResult;
    RLDraw42: TRLDraw;
    RLDBResult23: TRLDBResult;
    RLBand14: TRLBand;
    SiteEmpresa: TRLLabel;
    Licenca: TRLLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnFecharClick(Sender: TObject);

    procedure edCfopExit(Sender: TObject);
    procedure edCfopPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormLivroEntrada: TFormLivroEntrada;

implementation

uses prog0001, rotinas;

{$R *.dfm}

procedure TFormLivroEntrada.btnFecharClick(Sender: TObject);
begin
  close;
end;

procedure TFormLivroEntrada.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action:= cafree;
  FormLivroEntrada:= nil;
end;

procedure TFormLivroEntrada.edCfopExit(Sender: TObject);
begin
  edNomeCfop.Clear;
  if StrToIntDef(edCfop.Text,0) > 0 then
    begin
      sqlaux.Close;
      sqlaux.SQL.Text:= 'select natu_desc, natu_perc_redu_st, natu_mva_icms_st, natu_aliq_ipi from cadastro.natu where natu_codi = :codi '+
                        'and natu_empr = :empr and natu_loca = :loca';
      sqlaux.ParamByName('empr').AsInteger:= FormPrincipal.puempresa;
      sqlaux.ParamByName('loca').AsInteger:= FormPrincipal.pulocal;
      sqlaux.ParamByName('codi').AsInteger:= StrToIntDef(edCfop.Text,0);
      sqlaux.Open;
      if sqlaux.IsEmpty then
        begin
          ShowMessage('CFOP não encontrado');
          Exit;
        end;
      edNomeCfop.Text:= sqlaux.FieldByName('natu_desc').AsString;
    end;
end;

procedure TFormLivroEntrada.edCfopPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  edCfop.Text:= consulta('cons_cfop');
  edcfopexit(Self);
end;

end.
