unit prog0026;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Menus,
  StdCtrls, cxButtons, ExtCtrls, EPanel, cxControls, cxContainer, cxEdit,
  dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue,
  dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven, dxSkinSharp,
  dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinXmas2008Blue, cxTextEdit,
  cxMaskEdit, cxSpinEdit, Buttons, RLPreview, ELibFnc, ImgList, ComCtrls,
  ToolWin,
  RLConsts, RLMetaFile, RLFilters, RLUtils, RLPrintDialog,
  RLSaveDialog, RLPrinters, RLTypes, RLFindDialog, RLPreviewForm, RLDraftFilter,
  RLRichFilter, RLXLSFilter, RLHTMLFilter, RLPDFFilter, cxLabel, cxPC,
  dxGDIPlusClasses;

type
  TFormRelatorio = class(TForm)
    preview: TRLPreview;
    Image1: TImage;
    cxTabControl1: TcxTabControl;
    cxTabControl2: TcxTabControl;
    btnSalvar: TcxButton;
    btnPrimPage: TcxButton;
    btnUltiPage: TcxButton;
    cxButton1: TcxButton;
    cxButton2: TcxButton;
    RLDraftFilter1: TRLDraftFilter;
    edCopi: TcxSpinEdit;
    cxLabel1: TcxLabel;
    btnFechar: TcxButton;
    cxButton3: TcxButton;
    cxButton4: TcxButton;
    RLPDFFilter1: TRLPDFFilter;
    RLHTMLFilter1: TRLHTMLFilter;
    RLRichFilter1: TRLRichFilter;
    RLXLSFilter1: TRLXLSFilter;
    RLPreviewSetup1: TRLPreviewSetup;
    procedure OnFindHandler(Sender: TObject; const Text: string; Options: TRLFindOptions; var Found: Boolean);
    procedure btnFecharClick(Sender: TObject);
    procedure btnPrimPageClick(Sender: TObject);
    procedure btnUltiPageClick(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxButton3Click(Sender: TObject);
    procedure cxButton4Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FPreviewIndex: Integer;
    FEditingZoom: Boolean;
    FEditingPageNo: Boolean;
    FFindDialog: TfrmRLFindDialog;
    function FileNameFromText(const Text: string): string;
    procedure ShowFindDialog;
  public
    { Public declarations }
  end;

var
  FormRelatorio: TFormRelatorio;

implementation

uses prog0001;

{$R *.dfm}

var
  SetupInstance: TRLPreviewSetup = nil;

const
  key_escape = vk_escape;
  key_home = vk_home;
  key_prior = vk_prior;
  key_next = vk_next;
  key_end = vk_end;
  key_up = vk_up;
  key_down = vk_down;
  key_left = vk_left;
  key_right = vk_right;
  key_f3 = vk_f3;


procedure TFormRelatorio.OnFindHandler(Sender: TObject; const Text: string; Options: TRLFindOptions; var Found: Boolean);
begin
  Found := Preview.FindText(Text, foWholeWords in Options, foMatchCase in Options, foFindBackward in Options);
end;

procedure TFormRelatorio.ShowFindDialog;
begin
  if not Assigned(FFindDialog) then
  begin
    FFindDialog := TfrmRLFindDialog.CreateNew(nil);
    FFindDialog.OnFind := OnFindHandler;
  end;
  FFindDialog.ActiveControl := FFindDialog.EditTextToFind;
  FFindDialog.Show;
end;


function TFormRelatorio.FileNameFromText(const Text: string): string;
var
  I: Integer;
begin
  Result := Trim(Text);
  for I := Length(Result) downto 1 do
    if CharInSet(Result[I], [#0..#31, #127, '?', '*', ':', '/', '\', '>', '<', '|', '"', '.']) then
      Delete(Result, I, 1);
end;

procedure TFormRelatorio.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action:= cafree;
  formrelatorio:= nil;
end;

procedure TFormRelatorio.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    KEY_ESCAPE: btnFechar.Click;
    KEY_HOME: if ssCtrl in Shift then
                  Preview.FirstPage
                else
                  Preview.PageLeft;
    KEY_PRIOR: if ssCtrl in Shift then
                  Preview.PageTop
                else
                  Preview.PriorPage;
    KEY_NEXT: if ssCtrl in Shift then
                  Preview.PageBottom
                else
                  Preview.NextPage;
    KEY_END: if ssCtrl in Shift then
                  Preview.LastPage
                else
                  Preview.PageRight;
    KEY_UP: if ssCtrl in Shift then
                  Preview.HalfPageUp
                else
                  Preview.ScrollUp;
    KEY_DOWN: if ssCtrl in Shift then
                  Preview.HalfPageDown
                else
                  Preview.ScrollDown;
    KEY_LEFT: if ssCtrl in Shift then
                  Preview.HalfPageLeft
                else
                  Preview.ScrollLeft;
    KEY_RIGHT: if ssCtrl in Shift then
                  Preview.HalfPageRight
                else
                  Preview.ScrollRight;
    Ord('F'),
    KEY_F3: if ssCtrl in Shift then
                  ShowFindDialog
                else
                  Exit;
  else
    Exit;
  end;
  Key := 0;

end;

procedure TFormRelatorio.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFormRelatorio.btnPrimPageClick(Sender: TObject);
begin
  preview.FirstPage;
end;

procedure TFormRelatorio.btnSalvarClick(Sender: TObject);
var
  priorfocus: TWinControl;
  filt: TRLCustomSaveFilter;
  fname: string;
  fext: string;
  firstpg: Integer;
  lastpg: Integer;
begin
  if Assigned(SetupInstance) and Assigned(SetupInstance.BeforeSave) then
    SetupInstance.BeforeSave(Self);
  priorfocus := Screen.ActiveControl;
  try
    with TRLSaveDialog.CreateNew(nil) do
      try
        MaxPage := Preview.Pages.PageCount;
        if Self.Preview.Pages.Title <> '' then
          FileName := ExpandFileName(FileNameFromText(Self.Preview.Pages.Title))
        else if (SelectedFilter <> nil) and (SelectedFilter is TRLCustomSaveFilter) then
          FileName := TRLCustomSaveFilter(SelectedFilter).FileName
        else
          FileName := '';
        if not Execute then
          Exit;
        firstpg := FromPage;
        lastpg := ToPage;
        fname := FileName;
        fext := ExtractFileExt(fname);
        if fext = '' then
          ApplyExt(fname);
        filt := SaveFilterByFileName(fname);
        if filt <> nil then
        begin
          filt.FileName := fname;
          filt.FilterPages(Preview.Pages, firstpg, lastpg, '', PrintOddAndEvenPages);
        end
        else
          Preview.Pages.SaveToFile(fname);
      finally
        Free;
      end;
  finally

  end;
  if Assigned(SetupInstance) and Assigned(SetupInstance.AfterSave) then
    SetupInstance.AfterSave(Self);
end;

procedure TFormRelatorio.btnUltiPageClick(Sender: TObject);
begin
  preview.LastPage;
end;

procedure TFormRelatorio.cxButton1Click(Sender: TObject);
var
  priorfocus: TWinControl;
  firstpg: Integer;
  lastpg: Integer;
  selection: string;
  dialog: TRLPrintDialog;
  oddp: Integer;
begin
  if Assigned(SetupInstance) and Assigned(SetupInstance.BeforePrint) then
    SetupInstance.BeforePrint(Self);
  RLPrinter.OddEven := odAllPages;
  RLPrinter.Copies := StrToIntDef(edCopi.Text,1);
  priorfocus := Screen.ActiveControl;
  try
    dialog := TRLPrintDialog.CreateNew(nil);
    try
      dialog.MaxPage := Preview.Pages.PageCount;
      dialog.Copies := StrToIntDef(edCopi.Text,1);
      if Preview.Pages.Orientation = MetaOrientationLandscape then
        dialog.Orientation := poLandscape
      else
        dialog.Orientation := poPortrait;
      if not dialog.Execute then
        Exit;
      firstpg := dialog.FromPage;
      lastpg := dialog.ToPage;
      selection := dialog.PageRanges;
    finally
      dialog.Free;
    end;
    case RLPrinter.OddEven of
      odOddPagesOnly: oddp := PrintOddPagesOnly;
      odEvenPagesOnly: oddp := PrintEvenPagesOnly;
    else
      oddp := PrintOddAndEvenPages;
    end;
    FilterPages(Preview.Pages, nil, firstpg, lastpg, selection, oddp);
    SentToPrinter := True;
  finally
  end;
  if Assigned(SetupInstance) and Assigned(SetupInstance.AfterPrint) then
    SetupInstance.AfterPrint(Self);
end;

procedure TFormRelatorio.cxButton2Click(Sender: TObject);
begin
  ShowFindDialog;
end;

procedure TFormRelatorio.cxButton3Click(Sender: TObject);
begin
  preview.PriorPage;
end;

procedure TFormRelatorio.cxButton4Click(Sender: TObject);
begin
  preview.NextPage;
end;

end.
