unit prog0154;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, dxSkinsCore, dxSkinsDefaultPainters, Menus,
  StdCtrls, cxButtons, cxTextEdit, ExtCtrls, ActnList, ImgList, cxMaskEdit,
  cxDropDownEdit, cxCalendar, UniScript, ELibFnc, dxSkinBlack, dxSkinBlue,
  dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy,
  dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, 
  dxSkinPumpkin, dxSkinSeven,
  dxSkinSharp, dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinValentine, dxSkinXmas2008Blue, DB, MemDS,
  DBAccess, Uni, dxSkinOffice2010Black, dxSkinOffice2010Blue,
  dxSkinOffice2010Silver;

type
  TFormAtualizaBanco = class(TForm)
    ActionList1: TActionList;
    actAtualizar: TAction;
    actFechar: TAction;
    Panel1: TPanel;
    cxButton1: TcxButton;
    cxButton2: TcxButton;
    Imagens: TImageList;
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    cxTextEditAtual: TcxTextEdit;
    cxTextEditInstalada: TcxTextEdit;
    Label3: TLabel;
    PopupMenu: TPopupMenu;
    Atualizar1: TMenuItem;
    N1: TMenuItem;
    Fechar1: TMenuItem;
    Label4: TLabel;
    Label5: TLabel;
    cxDateEditInstalada: TcxDateEdit;
    Label6: TLabel;
    cxDateEditAtual: TcxDateEdit;
    ActionDebug: TAction;
    LabelDebug: TLabel;
    ut: TUniTransaction;
    procedure FormDestroy(Sender: TObject);
    procedure actFecharExecute(Sender: TObject);
    procedure actAtualizarExecute(Sender: TObject);
    procedure verifica_atualizacao;
    procedure ActionDebugExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    v_debug : boolean;
  public              
  end;

var
  FormAtualizaBanco: TFormAtualizaBanco;

implementation

uses DMScript, prog0003;

{$R *.dfm}

procedure TFormAtualizaBanco.FormDestroy(Sender: TObject);
begin
   DMScriptAtualizacao.UniQueryVersaoInstalada.Close;
end;

procedure TFormAtualizaBanco.actFecharExecute(Sender: TObject);
begin
   Close;
end;

procedure TFormAtualizaBanco.actAtualizarExecute(Sender: TObject);
var i, versao_comp : integer;
begin
  for i:= 0 to DMScriptAtualizacao.ComponentCount - 1 do
  begin
     if DMScriptAtualizacao.Components[i] is TUniScript then
     begin
        versao_comp := StrToIntDef(Copy((DMScriptAtualizacao.Components[I] as TUniScript).Name,17,4),0);
        if versao_comp > DMScriptAtualizacao.UniQueryVersaoInstaladaversao.AsInteger then
        begin
           try
              ut.starttransaction;
              (DMScriptAtualizacao.Components[I] as TUniScript).Debug := v_debug;
              //atualização da versão após rodar o script
              (DMScriptAtualizacao.Components[I] as TUniScript).SQL.Add('insert into versao (versao) values ('+IntToStr(versao_comp)+');');
              (DMScriptAtualizacao.Components[I] as TUniScript).Execute;
              (DMScriptAtualizacao.Components[I] as TUniScript).Debug := false;
              ut.Commit;
           except
              ut.Rollback;
           end;
        end;
     end;
  end;
  verifica_atualizacao;
end;

procedure TFormAtualizaBanco.verifica_atualizacao;
begin
   with DMScriptAtualizacao.UniQueryVersaoInstalada do
   begin
      Close;
      Open;
      if not IsEmpty then
      begin
         cxTextEditInstalada.Text := FieldByName('versao').AsString;
         cxDateEditInstalada.Date := FieldByName('data').AsDateTime;
      end;
   end;
   actAtualizar.Enabled := (cxTextEditAtual.Text <> cxTextEditInstalada.Text);   
end;

procedure TFormAtualizaBanco.ActionDebugExecute(Sender: TObject);
begin
   v_debug := (not v_debug);
   LabelDebug.Visible := v_debug;
end;

procedure TFormAtualizaBanco.FormCreate(Sender: TObject);
var i, versao_comp, versao : integer;
    dia, mes, ano : Word;
    tag : string;
begin
   versao := 0;
   for i:= 0 to DMScriptAtualizacao.ComponentCount - 1 do
   begin
      if DMScriptAtualizacao.Components[i] is TUniScript then
      begin
         versao_comp := StrToIntDef(Copy((DMScriptAtualizacao.Components[I] as TUniScript).Name,17,4),0);
         if versao_comp > versao then
         begin
            versao := versao_comp;
            cxTextEditAtual.Text := IntToStr(versao);
            tag := StrRPad(IntToStr((DMScriptAtualizacao.Components[I] as TUniScript).Tag),8,'0');
            dia := StrToIntDef(Copy(tag,1,2),1);
            mes := StrToIntDef(Copy(tag,3,2),1);
            ano := StrToIntDef(Copy(tag,5,4),2010);
            cxDateEditAtual.Date := EncodeDate(ano,mes,dia);
         end;
      end;
   end;
   //verifica se já tem a estrutura de versão em BD, se não tiver criar primeiramente
   with DMScriptAtualizacao do
     try
        UniQueryVersaoInstalada.Open;
     except
        UniScriptInicializacao.Execute;
     end;
   verifica_atualizacao;
   if (cxTextEditAtual.Text = cxTextEditInstalada.Text) then
      cxbutton2.Click;
end;

end.
