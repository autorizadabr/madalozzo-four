unit prog0029;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, Menus, cxPC, ImgList, UCBase, DB, DBAccess, Uni, MemDS,
  ACBrBase, ACBrEnterTab, ComCtrls, StdCtrls, cxButtons, dxGDIPlusClasses,
  ExtCtrls, cxLabel, cxMemo, cxGroupBox, cxTextEdit;

type
  TFormCartaCorrecao = class(TForm)
    lbTitu: TcxLabel;
    Image1: TImage;
    cxTabControl1: TcxTabControl;
    btnFechar: TcxButton;
    btnEmitir: TcxButton;
    sb: TStatusBar;
    ACBrEnterTab1: TACBrEnterTab;
    controle: TUCControls;
    cxPageControl1: TcxPageControl;
    cxLabel1: TcxLabel;
    edChav: TcxTextEdit;
    cxGroupBox1: TcxGroupBox;
    edCorr: TcxMemo;
    edSeri: TcxTextEdit;
    cxLabel3: TcxLabel;
    procedure btnFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnEmitirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormCartaCorrecao: TFormCartaCorrecao;

implementation

uses prog0003, prog0001;

{$R *.dfm}

procedure TFormCartaCorrecao.btnFecharClick(Sender: TObject);
begin
  close;
end;

procedure TFormCartaCorrecao.btnEmitirClick(Sender: TObject);
var
 Chave, idLote, codOrgao, CNPJ, nSeqEvento, Correcao : string;
begin
  Chave := Trim(edChav.Text);
  with dmdados do
   begin
     sqlaux.Close;
     sqlaux.SQL.Text:= 'select max(seri_sequ) as "sequencia" from cadastro where seri_empr = :empr '+
                       'and seri_loca = :loca and seri_seri = :seri';
     sqlaux.ParamByName('empr').AsInteger:= formprincipal.puempresa;
     sqlaux.ParamByName('empr').AsInteger:= formprincipal.pulocal;
     sqlaux.ParamByName('seri').Asstring := edseri.Text;
     sqlaux.Open;
     if sqlaux.IsEmpty then
      begin
        ShowMessage('Série não encontrada, favor verificar');
        Exit;
      end;

     idLote     := IntToStr(tbempr.FieldByName('empr_lote_cart_corr').AsInteger + 1);
     codOrgao   := copy(Chave,1,2);
     CNPJ       := copy(Chave,7,14);
     nSeqEvento := IntToStr(sqlaux.FieldByName('sequencia').AsInteger + 1);
     Correcao   := edCorr.Text;
     NFe.CartaCorrecao.CCe.Evento.Clear;
      NFe.CartaCorrecao.CCe.idLote := StrToInt(idLote) ;
     with NFe.CartaCorrecao.CCe.Evento.Add do
      begin
        infEvento.chNFe := Chave;
        infEvento.cOrgao := StrToInt(codOrgao);
        infEvento.CNPJ   := CNPJ;
        infEvento.dhEvento := now;
        infEvento.tpEvento := 110110;
        infEvento.nSeqEvento := StrToInt(nSeqEvento);
        infEvento.versaoEvento := '1.00';
        infEvento.detEvento.descEvento := 'Carta de Correção';
        infEvento.detEvento.xCorrecao := Correcao;
        infEvento.detEvento.xCondUso := ''; //Texto fixo conforme NT 2011.003 -  http://www.nfe.fazenda.gov.br/portal/exibirArquivo.aspx?conteudo=tsiloeZ6vBw=
      end;
     NFe.EnviarCartaCorrecao(StrToInt(idLote));
   end;
end;

procedure TFormCartaCorrecao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action:= caFree;
  FormCartaCorrecao:= nil;
end;

end.
