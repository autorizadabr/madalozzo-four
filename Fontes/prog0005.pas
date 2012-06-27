unit prog0005;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinXmas2008Blue, dxSkinscxPCPainter, Menus, ComCtrls, StdCtrls, cxButtons,
  cxPC, ExtCtrls, cxContainer, cxEdit, OleCtrls, SHDocVw, dxGDIPlusClasses,
  cxLabel;

type
  TFormAtendimento = class(TForm)
    cxTabControl1: TcxTabControl;
    btnFechar: TcxButton;
    sb: TStatusBar;
    lbTitu: TcxLabel;
    Image1: TImage;
    web: TWebBrowser;
    procedure btnFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormAtendimento: TFormAtendimento;

implementation

{$R *.dfm}

procedure TFormAtendimento.btnFecharClick(Sender: TObject);
begin
  close;
end;

procedure TFormAtendimento.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action:= cafree;
  formatendimento:= nil;
end;

procedure TFormAtendimento.FormShow(Sender: TObject);
begin
  web.Navigate('http://www.madalozzoitsolution.com/atendimento/chat.php');
end;

end.
