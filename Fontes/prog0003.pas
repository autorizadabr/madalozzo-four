unit prog0003;

interface

uses
  SysUtils, Classes, UniProvider, Forms,
  PostgreSQLUniProvider, DB, DBAccess, Uni, ACBrNFeDANFEClass,
  ACBrNFeDANFeRLClass, ACBrNFe, MemDS, pcnConversao;

type
  TdmDados = class(TDataModule)
    database: TUniConnection;
    provider: TPostgreSQLUniProvider;
    nfe: TACBrNFe;
    danfe: TACBrNFeDANFeRL;
    sqlaux: TUniQuery;
    tbEmpr: TUniQuery;
    quPara: TUniQuery;
    procedure nfeStatusChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmDados: TdmDados;

implementation

uses prog0001, ufrmStatus;

{$R *.dfm}

procedure TdmDados.nfeStatusChange(Sender: TObject);
begin
  case nfe.Status of
    stIdle :
    begin
      if ( frmStatus <> nil ) then
        frmStatus.Hide;
    end;
    stNFeStatusServico :
    begin
      if ( frmStatus = nil ) then
        frmStatus := TfrmStatus.Create(Application);
      frmStatus.lblStatus.Caption := 'Verificando Status do servico...';
      frmStatus.Show;
      frmStatus.BringToFront;
    end;
    stNFeRecepcao :
    begin
      if ( frmStatus = nil ) then
        frmStatus := TfrmStatus.Create(Application);
      frmStatus.lblStatus.Caption := 'Enviando dados da NFe...';
      frmStatus.Show;
      frmStatus.BringToFront;
    end;
    stNfeRetRecepcao :
    begin
      if ( frmStatus = nil ) then
        frmStatus := TfrmStatus.Create(Application);
      frmStatus.lblStatus.Caption := 'Recebendo dados da NFe...';
      frmStatus.Show;
      frmStatus.BringToFront;
    end;
    stNfeConsulta :
    begin
      if ( frmStatus = nil ) then
        frmStatus := TfrmStatus.Create(Application);
      frmStatus.lblStatus.Caption := 'Consultando NFe...';
      frmStatus.Show;
      frmStatus.BringToFront;
    end;
    stNfeCancelamento :
    begin
      if ( frmStatus = nil ) then
        frmStatus := TfrmStatus.Create(Application);
      frmStatus.lblStatus.Caption := 'Enviando cancelamento de NFe...';
      frmStatus.Show;
      frmStatus.BringToFront;
    end;
    stNfeInutilizacao :
    begin
      if ( frmStatus = nil ) then
        frmStatus := TfrmStatus.Create(Application);
      frmStatus.lblStatus.Caption := 'Enviando pedido de Inutilização...';
      frmStatus.Show;
      frmStatus.BringToFront;
    end;
    stNFeRecibo :
    begin
      if ( frmStatus = nil ) then
        frmStatus := TfrmStatus.Create(Application);
      frmStatus.lblStatus.Caption := 'Consultando Recibo de Lote...';
      frmStatus.Show;
      frmStatus.BringToFront;
    end;
    stNFeCadastro :
    begin
      if ( frmStatus = nil ) then
        frmStatus := TfrmStatus.Create(Application);
      frmStatus.lblStatus.Caption := 'Consultando Cadastro...';
      frmStatus.Show;
      frmStatus.BringToFront;
    end;
    stNFeEnvDPEC :
    begin
      if ( frmStatus = nil ) then
        frmStatus := TfrmStatus.Create(Application);
      frmStatus.lblStatus.Caption := 'Enviando DPEC...';
      frmStatus.Show;
      frmStatus.BringToFront;
    end;
    stNFeConsultaDPEC :
    begin
      if ( frmStatus = nil ) then
        frmStatus := TfrmStatus.Create(Application);
      frmStatus.lblStatus.Caption := 'Consultando DPEC...';
      frmStatus.Show;
      frmStatus.BringToFront;
    end;
    stNFeEmail :
    begin
      if ( frmStatus = nil ) then
        frmStatus := TfrmStatus.Create(Application);
      frmStatus.lblStatus.Caption := 'Enviando Email...';
      frmStatus.Show;
      frmStatus.BringToFront;
    end;
    stNFeCCe :
    begin
      if ( frmStatus = nil ) then
        frmStatus := TfrmStatus.Create(Application);
      frmStatus.lblStatus.Caption := 'Enviando Carta de Correção...';
      frmStatus.Show;
      frmStatus.BringToFront;
    end;
  end;
  Application.ProcessMessages;
end;

end.
