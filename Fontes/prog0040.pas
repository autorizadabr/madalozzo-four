unit prog0040;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, Menus, StdCtrls, cxButtons, cxTextEdit, ExtCtrls,
  cxGroupBox, cxPC, cefvcl, ceflib, cefgui;

type
  TFuncoesJS = class(TCefv8HandlerOwn)
  protected
    function Execute(const name: ustring; const obj: ICefv8Value;
      const arguments: TCefv8ValueArray; var retval: ICefv8Value;
      var exception: ustring): Boolean; override;
    procedure CaptchaToImage(AAltura, ALargura : Integer;
    APixels,AForm,AImgCaptcha : string);
  end;

type
  TFormCaptcha = class(TForm)
    capcha: TcxTabControl;
    cxGroupBox3: TcxGroupBox;
    edCaptcha: TcxTextEdit;
    cxTabControl3: TcxTabControl;
    cxButton1: TcxButton;
    cxButton2: TcxButton;
    wbChromium: TChromium;
    imgCaptcha: TImage;
    cxButton4: TcxButton;
    procedure cxButton1Click(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure wbChromiumLoadEnd(Sender: TObject; const browser: ICefBrowser;
      const frame: ICefFrame; httpStatusCode: Integer; out Result: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxButton4Click(Sender: TObject);
  private
    { Private declarations }
    procedure RegisterExtension;
  public
    { Public declarations }
    cnpj : string;
    class function jQuery:string;
    class function Javascript:string;
  end;

  const
  cUrlComprovante = 'http://www.receita.fazenda.gov.br/PessoaJuridica/CNPJ/cnpjreva/Cnpjreva_Comprovante.asp';
  cUrlPesquisa = 'http://www.receita.fazenda.gov.br/PessoaJuridica/CNPJ/cnpjreva/cnpjreva_solicitacao2.asp';
  cUrlJQuery = 'https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js';

var
  FormCaptcha: TFormCaptcha;

implementation

uses prog0022, superobject, rotinas;

{$R *.dfm}


class function TFormCaptcha.Javascript: string;
begin

  Result :=
    'var Cadastro;'+
    'if (!Cadastro){'+
    '  Cadastro = {}'+
    '}'+

    'Cadastro.CNPJ = $(''table'').eq(4).find(''td'').find(''b'').eq(0).text();'+
    'Cadastro.NomeEmpresarial = $(''table'').eq(5).find(''td'').find(''b'').eq(0).text().trim();'+
    'Cadastro.DataAbertura= $(''table'').eq(4).find(''td'').find(''b'').eq(3).text().trim();'+
    'Cadastro.NomeFantasia= $(''table'').eq(6).find(''td'').find(''b'').eq(0).text().trim();'+
    'Cadastro.Logradouro = $(''table'').eq(10).find(''td'').find(''b'').eq(0).text().trim();'+
    'Cadastro.Numero = $(''table'').eq(10).find(''td'').find(''b'').eq(1).text().trim();'+
    'Cadastro.Complemento = $(''table'').eq(10).find(''td'').find(''b'').eq(2).text().trim();'+
    'Cadastro.CEP = $(''table'').eq(11).find(''td'').find(''b'').eq(0).text().trim();'+
    'Cadastro.Bairro = $(''table'').eq(11).find(''td'').find(''b'').eq(1).text().trim();'+
    'Cadastro.Municipio = $(''table'').eq(11).find(''td'').find(''b'').eq(2).text().trim();'+
    'Cadastro.UF = $(''table'').eq(11).find(''td'').find(''b'').eq(3).text().trim();'+
    'Cadastro.SituacaoCadastral = $(''table'').eq(12).find(''td'').find(''b'').eq(0).text().trim();'+
    'Cadastro.DataSituacaoCadastral = $(''table'').eq(12).find(''td'').find(''b'').eq(1).text().trim();'+
    'DUG.Funcoes.EnviaObjetoDelphi(JSON.stringify(Cadastro));';
end;

class function TFormCaptcha.jQuery: string;
var
  lista : TStringList;
begin
  lista := TStringList.Create;
  try
    lista.LoadFromFile(ExtractFilePath(Application.ExeName)+'jquery-min.js');
    Result := lista.text;
  finally
    FreeAndNil(lista);
  end;
end;

procedure TFormCaptcha.RegisterExtension;
var
  Code:string;
begin
  Code :=
   'var DUG;'+
   'if (!DUG)'+
   '  DUG = {};'+
   'if (!DUG.Funcoes)'+
   '  DUG.Funcoes = {};'+
   '(function() {'+
   '  DUG.Funcoes.EnviaImagemDelphi = function(Altura, Largura, Pixels, ANomeForm, ANomeTImage) {'+
   '    native function EnviaImagemDelphi();'+
   '    return EnviaImagemDelphi(Altura, Largura, Pixels, ANomeForm, ANomeTImage);'+
   '  };'+
   '  DUG.Funcoes.EnviaObjetoDelphi = function(AObj) {'+
   '    native function EnviaObjetoDelphi();'+
   '    return EnviaObjetoDelphi(AObj);'+
   '  };'+
   '  DUG.Funcoes.PegarCaptcha =function (AImgElement, ANomeForm, ANomeTImage){'+
   '    try{'+
   '      var canvas = document.createElement("canvas");'+
   '      canvas.width = AImgElement.width;'+
   '      canvas.height = AImgElement.height;'+
   '      var ctx = canvas.getContext(''2d'');'+
   '      ctx.drawImage(AImgElement, 0, 0);'+
   '      var imageData = ctx.getImageData(0,0, AImgElement.width, AImgElement.height);'+
   '      var Altura = imageData.height;'+
   '      var Largura = imageData.width;'+
   '      var Pixels = '''';'+
   '      for (i=0;i<=imageData.data.length - 1;i++){'+
   '        Pixels = Pixels + imageData.data[i]+'';'';'+
   '      }'+
   '      DUG.Funcoes.EnviaImagemDelphi(Altura, Largura, Pixels, ANomeForm, ANomeTImage);'+
   '    } catch(e) {'+
   '      console.log(''***Error in getCaptcha: ''+ e);'+
   '    };'+
   '  };'+
   '})();';


  CefRegisterExtension('DUGRS/v8', Code, TFuncoesJS.Create as ICefv8Handler);
end;

procedure TFormCaptcha.wbChromiumLoadEnd(Sender: TObject;
  const browser: ICefBrowser; const frame: ICefFrame; httpStatusCode: Integer;
  out Result: Boolean);
begin
  frame.ExecuteJavaScript(TFormCaptcha.jQuery,'about:blank', 0);

  if frame.Url = cUrlPesquisa then
  begin
    frame.ExecuteJavaScript('DUG.Funcoes.PegarCaptcha($(''img'').eq(1)[0],''FormCaptcha'',''imgCaptcha'');', 'about:blank', 0);
  end
  else if frame.Url = cUrlComprovante then
  begin
    frame.ExecuteJavaScript(TFormCaptcha.Javascript,'about:blank', 0);
  end;
  Result := true;
end;

function TFuncoesJS.Execute(const name: ustring; const obj: ICefv8Value;
  const arguments: TCefv8ValueArray; var retval: ICefv8Value;
  var exception: ustring): Boolean;
var
  vJSON : ISuperObject;
begin
  if name = 'EnviaImagemDelphi' then
  begin
     if Length(arguments) = 5 then
     begin
       Self.CaptchaToImage(arguments[0].GetIntValue,
                           arguments[1].GetIntValue,
                           arguments[2].GetStringValue,
                           arguments[3].GetStringValue,
                           arguments[4].GetStringValue);
       Result := True;
       retval := TCefv8ValueRef.CreateBool(True);
     end;
  end;
  if name = 'EnviaObjetoDelphi' then
  begin
    if Length(arguments) = 1 then
    begin
      vJSON := TSuperObject.ParseString(PChar(arguments[0].GetStringValue),false);
      FormCadEntidade.qutable.fieldbyname('enti_cnpj').asstring := vJSON.S['CNPJ'];
      FormCadEntidade.qutable.fieldbyname('enti_desc').asstring := vJSON.S['NomeEmpresarial'];
//      Form1.edtConsultaDataAbertura.Text := vJSON.S['DataAbertura'];
      FormCadEntidade.qutable.fieldbyname('enti_fant').asstring := vJSON.S['NomeFantasia'];
      FormCadEntidade.qutable.fieldbyname('enti_ende').asstring := vJSON.S['Logradouro'];
      FormCadEntidade.qutable.fieldbyname('enti_nume').asstring := vJSON.S['Numero'];
      FormCadEntidade.qutable.fieldbyname('enti_comp').asstring := vJSON.S['Complemento'];
      FormCadEntidade.qutable.fieldbyname('enti_cep').asstring := vJSON.S['CEP'];
      FormCadEntidade.qutable.fieldbyname('enti_bair').asstring := vJSON.S['Bairro'];
      FormCadEntidade.edNomeCida.Text := vJSON.S['Municipio'];
//      FormCadEntidade.qutable.fieldbyname('enti_esta').asstring := vJSON.S['UF'];
//      Form1.edtConsultaSitCadastral.Text := vJSON.S['SituacaoCadastral'];
//      Form1.edtConsultaDataSitCad.Text := vJSON.S['DataSituacaoCadastral'];
    end;
  end;
end;

procedure TFuncoesJS.CaptchaToImage(AAltura, ALargura: Integer; APixels, AForm,
  AImgCaptcha: string);
var
  vInd, vLinha, vColuna : Integer;
  vR,vG,vB{,vA} : Byte; //Alpha layer is not used at this time
  vListaPixels : TStringList;
  vCaptcha : TImage;
  vForm : TForm;
begin
  vForm := nil;
  vCaptcha := nil;
  for vInd := 0 to Screen.FormCount - 1 do
  begin
    if Screen.Forms[vInd].Name = AForm then
    begin
      vForm := Screen.Forms[vInd];
      break;
    end;
  end;
  if vForm <> nil then
    vCaptcha := (vForm.FindComponent(AImgCaptcha) as TImage);
  if vCaptcha <> nil then
  begin
    vCaptcha.Height := AAltura;
    vCaptcha.Width := ALargura;
    vListaPixels := TStringList.Create;
    try
      vListaPixels.Delimiter := ';';
      vListaPixels.DelimitedText := APixels;
      vInd := 0;
      for vColuna := 0 to AAltura - 1 do
      begin
        for vLinha := 0 to ALargura - 1 do
        begin
          vR := StrToInt(vListaPixels[vInd]);
          Inc(vInd);
          vG := StrToInt(vListaPixels[vInd]);
          Inc(vInd);
          vB := StrToInt(vListaPixels[vInd]);
          Inc(vInd);
          {vA := StrToInt(vListaPixels[vInd]);}
          Inc(vInd);
          vCaptcha.Canvas.Pixels[vLinha,vColuna] := RGB(vR,vG,vB);
        end;
      end;
    finally
      FreeAndNil(vListaPixels);
    end;
  end;
end;

procedure TFormCaptcha.cxButton1Click(Sender: TObject);
begin
  if wbChromium.Browser.MainFrame.Url = cUrlPesquisa then
    wbChromium.Browser.MainFrame.ExecuteJavaScript('$(''input'').eq(1).val('+QuotedStr(RetiraTraco(cnpj))+');'+
                                                   '$(''input'').eq(2).val('+QuotedStr(edCaptcha.Text)+');'+
                                                   '$(''input'').eq(4).click();', 'about:blank',0);
end;
procedure TFormCaptcha.cxButton2Click(Sender: TObject);
begin
  wbChromium.Load(cUrlPesquisa);
end;

procedure TFormCaptcha.cxButton4Click(Sender: TObject);
begin
 close;
end;

procedure TFormCaptcha.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action:= caFree;
end;

procedure TFormCaptcha.FormCreate(Sender: TObject);
begin
  RegisterExtension;
end;

procedure TFormCaptcha.FormShow(Sender: TObject);
begin
  wbChromium.Load(cUrlPesquisa);
end;

end.
