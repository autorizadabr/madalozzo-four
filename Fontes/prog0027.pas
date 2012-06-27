unit prog0027;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, Menus, StdCtrls, cxButtons, cxPC, ComCtrls, cxLabel,
  dxGDIPlusClasses, ExtCtrls, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, DB, cxDBData, cxCheckBox, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridLevel, cxClasses, cxGridCustomView,
  cxGrid, DBAccess, Uni, MemDS, cxRadioGroup, pcnConversao, UCBase, strutils,
  ELibFnc, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, ACBrBase,
  ACBrEnterTab;

type
  TFormEmissaoNFe = class(TForm)
    Image1: TImage;
    lbTitu: TcxLabel;
    sb: TStatusBar;
    cxTabControl1: TcxTabControl;
    btnFechar: TcxButton;
    btnEmitir: TcxButton;
    btnCancelar: TcxButton;
    btnServico: TcxButton;
    btnConsultaNfe: TcxButton;
    btnDanfe: TcxButton;
    cxTabControl2: TcxTabControl;
    cxTabControl3: TcxTabControl;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1Column1: TcxGridDBColumn;
    cxGrid1DBTableView1Column2: TcxGridDBColumn;
    cxGrid1DBTableView1Column3: TcxGridDBColumn;
    cxGrid1DBTableView1Column4: TcxGridDBColumn;
    cxGrid1DBTableView1Column5: TcxGridDBColumn;
    cxGrid1DBTableView1Column6: TcxGridDBColumn;
    cxGrid1DBTableView1Column7: TcxGridDBColumn;
    cxGrid1DBTableView1Column8: TcxGridDBColumn;
    tbNota: TUniQuery;
    dsNota: TUniDataSource;
    btnConsulta: TcxButton;
    edCanc: TcxRadioButton;
    edDene: TcxRadioButton;
    edAuto: TcxRadioButton;
    edtodo: TcxRadioButton;
    edNatr: TcxRadioButton;
    cxButton1: TcxButton;
    sqlaux: TUniQuery;
    controle: TUCControls;
    tbItens: TUniQuery;
    EvLibFunctions1: TEvLibFunctions;
    cxLabel1: TcxLabel;
    edInic: TcxDateEdit;
    edFina: TcxDateEdit;
    cxLabel2: TcxLabel;
    ACBrEnterTab1: TACBrEnterTab;
    cxGrid1DBTableView1Column9: TcxGridDBColumn;
    cxGrid1DBTableView1Column10: TcxGridDBColumn;
    cxGrid1DBTableView1Column11: TcxGridDBColumn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxGrid1DBTableView1CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure FormShow(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure btnConsultaClick(Sender: TObject);
    procedure btnServicoClick(Sender: TObject);
    procedure btnConsultaNfeClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
    procedure btnDanfeClick(Sender: TObject);
    procedure btnEmitirClick(Sender: TObject);
    procedure tbNotaAfterScroll(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormEmissaoNFe: TFormEmissaoNFe;

implementation

uses prog0003, prog0001, rotinas;

{$R *.dfm}

procedure TFormEmissaoNFe.btnCancelarClick(Sender: TObject);
var
  v_just : string;
  xml : tstringlist;
begin
  xml:= tstringlist.Create;
  v_just:= InputBox('Informe a Justificativa', 'Justificativa', '');
  if Length(v_just) < 15 then
   begin
     ShowMessage('A justificativa deve conter no minimo 15 caracteres');
     Exit;
   end;

  try
    with dmdados.nfe do
     begin
       xml.Add(tbnota.FieldByName('movi_xml_emit').AsString);
       xml.SaveToFile('nota.xml');
       NotasFiscais.LoadFromFile('nota.xml');

       WebServices.Cancelamento.NFeChave      := tbNota.FieldByName('movi_id_nfe').AsString;
       WebServices.Cancelamento.Protocolo     := tbNota.FieldByName('movi_nume_prot').AsString;
       WebServices.Cancelamento.Justificativa := v_just;
       WebServices.Cancelamento.Executar;

       NotasFiscais.Items[0].SaveToFile(ExtractFilePath(application.ExeName)+'PathCan\'+tbnota.FieldByName('movi_id_nfe').AsString+'.xml');
       NotasFiscais.Items[0].Imprimir;
       NotasFiscais.Items[0].ImprimirPDF;
     end;

     tbnota.Edit;
     tbnota.FieldByName('movi_prot_canc').AsString     := dmdados.nfe.WebServices.Cancelamento.Protocolo;
     tbnota.FieldByName('movi_xml_canc').AsString      := dmdados.nfe.NotasFiscais.Items[0].XML;
     tbnota.fieldbyname('movi_stat_nfe').AsInteger     := dmdados.nfe.WebServices.Cancelamento.cStat;
     tbnota.fieldbyname('movi_canc').asboolean         := true;
     tbnota.Post;
     tbnota.ApplyUpdates;
  finally
    deletefile(ExtractFilePath(application.ExeName)+'nota.xml');
    xml.Free;
    btnconsulta.Click;
  end;
end;

procedure TFormEmissaoNFe.btnConsultaClick(Sender: TObject);
begin
  tbNota.Close;
  tbNota.SQL.Text:= 'select *, '+
                    '       (select enti_desc from cadastro.enti where enti_codi = movi_enti) as "enti_raza", '+
                    '       (select enti_mail from cadastro.enti where enti_codi = movi_enti) as "enti_mail", '+
                    '       case when (movi_stat_nfe = 100 and movi_tipo_movi = 2) then ''Autorizada'' '+
                    '            when (movi_stat_nfe = 101 and movi_tipo_movi = 2) then ''Cancelada'' '+
                    '            when (movi_stat_nfe = 302 and movi_tipo_movi = 2) then ''Denegada'' '+
                    '            when (movi_stat_nfe = 103 and movi_tipo_movi = 2) then ''Denegada'' '+
                    '            when (coalesce(movi_stat_nfe,0) = 0 and movi_tipo_movi = 2) then ''Não Transmitida'' '+
                    '            when movi_tipo_movi = 1 then ''Nota de Entrada'' '+
                    '       end as "status", '+
                    '       case when movi_tipo_movi = 1 then ''E'' else ''S'' end as "tipo", '+
                    '       false as "seleciona" '+
                    'from movimento.movi '+
                    'where movi_empr = :empr and movi_loca = :loca '+
                    'and movi_emis between :inic and :fina ';
  tbNota.ParamByName('empr').AsInteger:= formprincipal.puempresa;
  tbNota.ParamByName('loca').AsInteger:= FormPrincipal.pulocal;
  tbnota.ParamByName('inic').AsDate:= edInic.Date;
  tbnota.ParamByName('fina').AsDate:= edFina.Date;
  if edCanc.Checked then
    tbNota.SQL.Add('and movi_stat_nfe = 101 ')
  else
  if edDene.Checked then
    tbNota.SQL.Add('and (movi_stat_nfe = 301 or movi_stat_nfe = 302) ')
  else
  if edNatr.Checked then
    tbNota.SQL.Add('and coalesce(movi_stat_nfe,0) = 0 ')
  else
  if edAuto.Checked then
    tbNota.SQL.Add('and movi_stat_nfe = 100 ');

  tbNota.Open;
  tbNota.FieldByName('seleciona').ReadOnly:= False;
end;

procedure TFormEmissaoNFe.btnConsultaNfeClick(Sender: TObject);
begin
  with dmdados.nfe do
   begin
     WebServices.Consulta.NFeChave := tbNota.FieldByName('movi_id_nfe').AsString;
     WebServices.Consulta.Executar;
   end;
end;

procedure TFormEmissaoNFe.btnDanfeClick(Sender: TObject);
var
  xml : TStringList;
begin
  xml:= TStringList.Create;

  if tbNota.FieldByName('movi_stat_nfe').asfloat = 100 then
   begin
     xml.Add(tbNota.FieldByName('movi_xml_emit').AsString);
     xml.SaveToFile('nota.xml');
   end else
  if tbNota.FieldByName('movi_stat_nfe').asfloat = 101 then
   begin
     xml.Add(tbNota.FieldByName('movi_xml_canc').AsString);
     xml.SaveToFile('nota.xml');
   end;

  try
    with dmdados.nfe do
     begin
       NotasFiscais.Clear;
       NotasFiscais.LoadFromFile('nota.xml');
       if NotasFiscais.Items[0].NFe.Ide.tpEmis = teDPEC then
        begin
          WebServices.ConsultaDPEC.NFeChave := NotasFiscais.Items[0].NFe.infNFe.ID;
          WebServices.ConsultaDPEC.Executar;
          DANFE.ProtocoloNFe := WebServices.ConsultaDPEC.nRegDPEC +' '+ DateTimeToStr(WebServices.ConsultaDPEC.dhRegDPEC);
        end;
       NotasFiscais.Imprimir;
     end;
  finally
    DeleteFile('nota.xml');
    xml.free;
  end;
end;

procedure TFormEmissaoNFe.btnEmitirClick(Sender: TObject);
var
  v_seq_item : integer;
  v_dentro_estado : boolean;
  v_estado_emite, v_estado_destinatario : string;
  v_nota_fiscal : integer;
  v_protocolo : string;
begin
  v_nota_fiscal := 0;
  tbnota.first;
  while not tbnota.eof do
   begin
     if not tbnota.FieldByName('seleciona').AsBoolean then
       begin
         tbnota.Next;
         continue;
       end;

     dmDados.nfe.NotasFiscais.Clear;
     with dmdados.nfe.NotasFiscais.Add.NFe do
       begin
          sqlaux.close;
          sqlaux.SQL.Text:= 'select natu_desc from cadastro.natu where natu_codi = :codi and '+
                            'natu_empr = :empr and natu_loca = :loca';
          sqlaux.ParamByName('empr').AsInteger:= FormPrincipal.puempresa;
          sqlaux.ParamByName('loca').AsInteger:= FormPrincipal.pulocal;
          sqlaux.ParamByName('codi').AsInteger:= tbNota.FieldByName('movi_natu').AsInteger;
          sqlaux.Open;
          Ide.natOp     := sqlaux.FieldByName('natu_desc').AsString;

          // indica forma de pagamento
          case tbnota.fieldbyname('movi_tipo_fina').AsInteger of
            0: Ide.indPag:= ipVista;
            1: Ide.indPag:= ipPrazo;
            9: Ide.indPag:= ipOutras;
          end;

          //verifica sequencia da nota
          sqlaux.Close;
          sqlaux.SQL.Text:= 'select max(seri_sequ) as "sequencia" from cadastro.seri where seri_codi = :seri '+
                            'and seri_empr = :empr and seri_loca = :loca';
          sqlaux.ParamByName('empr').AsInteger:= FormPrincipal.puempresa;
          sqlaux.ParamByName('loca').AsInteger:= FormPrincipal.pulocal;
          sqlaux.ParamByName('seri').AsInteger:= tbNota.FieldByName('movi_seri').AsInteger;
          sqlaux.Open;
          sqlaux.Tag:= sqlaux.FieldByName('sequencia').AsInteger + 1;

          sqlaux.Close;
          sqlaux.SQL.Text:= 'select * from cadastro.seri where seri_codi = :seri '+
                            'and seri_empr = :empr and seri_loca = :loca';
          sqlaux.ParamByName('empr').AsInteger:= FormPrincipal.puempresa;
          sqlaux.ParamByName('loca').AsInteger:= FormPrincipal.pulocal;
          sqlaux.ParamByName('seri').AsInteger:= tbNota.FieldByName('movi_seri').AsInteger;
          sqlaux.Open;

          // cabeçalho da nfe
          Ide.modelo    := tbNota.FieldByName('movi_mode').AsInteger;
          Ide.serie     := StrToInt(sqlaux.FieldByName('seri_seri').AsString);
          Ide.nNF       := sqlaux.Tag;
          Ide.cNF       := sqlaux.Tag;
          v_nota_fiscal := sqlaux.Tag;
          Ide.dEmi      := tbNota.FieldByName('movi_emis').AsDateTime;
          Ide.dSaiEnt   := tbnota.FieldByName('movi_ensa').AsDateTime;
          Ide.hSaiEnt   := Now;
          case tbNota.FieldByName('movi_tipo_movi').AsInteger of
            1: Ide.tpNF:= tnEntrada;
            2: Ide.tpNF:= tnSaida;
          end;

          case dmdados.tbEmpr.FieldByName('empr_form_emis').AsInteger of
            1: Ide.tpEmis:= teNormal;
            2: Ide.tpEmis:= teContingencia;
            3: Ide.tpEmis:= teSCAN;
            4: Ide.tpEmis:= teDPEC;
          end;

          sqlaux.Close;
          sqlaux.sql.text:= 'select * from movimento.cont where cont_empr = :empr and cont_loca = :loca ';
          sqlaux.ParamByName('empr').AsInteger:= FormPrincipal.puempresa;
          sqlaux.ParamByName('loca').AsInteger:= FormPrincipal.pulocal;
          sqlaux.Open;
          sqlaux.Last;
          if (not sqlaux.FieldByName('cont_entr').IsNull) and
             (sqlaux.FieldByName('cont_said').IsNull) then
           begin
             case sqlaux.FieldByName('cont_ambi').AsInteger of
               1: Ide.tpEmis:= teContingencia;
               3: Ide.tpEmis:= teSCAN;
               2: Ide.tpEmis:= teDPEC;
             end;
           end;

          // precisa criar modulo de contingencia +
          if Ide.tpEmis <> teNormal then
           begin
             ide.dhCont    := sqlaux.FieldByName('cont_entr').AsDateTime;
             ide.xJust     := sqlaux.fieldbyname('cont_just').asstring;
           end;

          case dmDados.tbEmpr.FieldByName('empr_ambi').AsInteger of
            1:Ide.tpAmb:= taHomologacao;
            2:Ide.tpAmb:= taProducao;
          end;
          Ide.verProc   := '1.0.0.0';

          Ide.cUF       := dmDados.tbEmpr.FieldByName('empr_codi_esta').AsInteger;
          Ide.cMunFG    := dmDados.tbEmpr.FieldByName('empr_ibge').AsInteger;
          Ide.finNFe    := fnNormal;

          // informar os campos abaixos para nota fiscal eletronica referenciada
      {    sqlRefe.close; sqlRefe.SQL.clear;
          sqlRefe.SQL.Add('select * from referenciadacompra where refe_empr = :empr and refe_mode_nota = :mode and '+
          'refe_seri_nota = :seri and refe_nota_nota = :nota and refe_forn = :forn');
          sqlrefe.ParamByName('empr').asinteger := formPrincipal.puEmpresa;
          sqlrefe.ParamByName('mode').asstring  := sqlaux.fieldbyname('comp_mode').asstring;
          sqlrefe.ParamByName('seri').asstring  := sqlaux.fieldbyname('comp_seri').asstring;
          sqlrefe.ParamByName('nota').asinteger := sqlaux.fieldbyname('comp_nota').asinteger;
          sqlrefe.ParamByName('forn').asinteger := sqlaux.fieldbyname('comp_forn').asinteger;
          sqlrefe.Open;
          if sqlrefe.RecordCount > 0 then
          begin
             while not sqlrefe.eof do
             begin
                with Ide.NFref.Add do
                begin
                  if sqlrefe.fieldbyname('refe_id_nfe').asstring <> '' then
                     refNFe    := sqlrefe.fieldbyname('refe_id_nfe').asstring
                  else
                  begin
                     if sqlrefe.fieldbyname('refe_cnpj').asstring <> '' then
                     begin
                        refNf.cUF    := NotaUtil.UFtoCUF(sqlrefe.fieldbyname('refe_uf').asstring);
                        RefNF.AAMM   := sqlrefe.fieldbyname('refe_anme').asstring;
                        RefNF.CNPJ   := sqlrefe.fieldbyname('refe_cnpj').asstring;
                        RefNF.modelo := strtointdef(sqlrefe.fieldbyname('refe_mode').asstring,0);
                        RefNF.serie  := strtointdef(sqlrefe.fieldbyname('refe_seri').asstring,0);
                        RefNF.nNF    := sqlrefe.fieldbyname('refe_nume').asinteger;
                     end
                     else
                     begin
                        RefNFP.cUF     := NotaUtil.UFtoCUF(sqlrefe.fieldbyname('refe_uf').asstring);
                        RefNFP.AAMM    := sqlrefe.fieldbyname('refe_anme').asstring;
                        RefNFP.CNPJCPF := sqlrefe.fieldbyname('refe_cpf').asstring;
                        RefNFP.IE      := sqlrefe.fieldbyname('refe_insc').asstring;
                        RefNFP.modelo  := sqlrefe.fieldbyname('refe_mode').asstring;
                        RefNFP.serie   := strtointdef(sqlrefe.fieldbyname('refe_seri').asstring,0);
                        RefNFP.nNF     := sqlrefe.fieldbyname('refe_nume').asinteger;
                     end;
                     (*
                     RefECF.modelo  := ECFModRef2B; // |
                     RefECF.nECF    := '';          // |- Cupom Fiscal
                     RefECF.nCOO    := '';          // |
                     *)
                   end;
                End;
                sqlrefe.Next;
             end;
          End;
       }
          Emit.CNPJCPF           := RetiraTraco(dmDados.tbEmpr.FieldByName('empr_cnpj').AsString);
          Emit.IE                := RetiraTraco(dmDados.tbEmpr.FieldByName('empr_ie').AsString);
          Emit.xNome             := dmDados.tbEmpr.FieldByName('empr_raza').AsString;
          Emit.xFant             := dmDados.tbEmpr.FieldByName('empr_fant').AsString;
          Emit.EnderEmit.fone    := dmDados.tbEmpr.FieldByName('empr_fone').AsString;
          Emit.EnderEmit.CEP     := strtoint(RetiraTraco(dmDados.tbEmpr.FieldByName('empr_cep').AsString));
          Emit.EnderEmit.xLgr    := dmDados.tbEmpr.FieldByName('empr_ende').AsString;
          Emit.EnderEmit.nro     := dmDados.tbEmpr.FieldByName('empr_nume').AsString;
          Emit.EnderEmit.xCpl    := dmDados.tbEmpr.FieldByName('empr_comp').AsString;
          Emit.EnderEmit.xBairro := dmDados.tbEmpr.FieldByName('empr_bair').AsString;
          Emit.EnderEmit.cMun    := dmDados.tbEmpr.FieldByName('empr_ibge').AsInteger;
          Emit.EnderEmit.xMun    := dmDados.tbEmpr.FieldByName('cida_desc').AsString;
          Emit.EnderEmit.UF      := dmDados.tbEmpr.FieldByName('cida_sigl').AsString;
          Emit.enderEmit.cPais   := dmDados.tbEmpr.FieldByName('pais_nume').AsInteger;
          Emit.enderEmit.xPais   := dmDados.tbEmpr.FieldByName('pais_desc').AsString;

          Emit.IEST              := '';
          Emit.IM                := ''; // Preencher no caso de existir serviços na nota
          Emit.CNAE              := ''; // Verifique na cidade do emissor da NFe se é permitido

          case dmDados.tbEmpr.FieldByName('empr_form_trib').AsInteger of
            1: Emit.CRT := crtSimplesNacional;
            2: Emit.CRT := crtSimplesExcessoReceita;
            3: Emit.CRT := crtRegimeNormal;
          end;

          //carrega os dados do destinatário
          sqlaux.close;
          sqlaux.sql.Text:= 'select *, '+
                            '(select cida_desc from cadastro.cida where cida_codi = enti_cida) as "cida_desc", '+
                            '(select cida_sigl from cadastro.cida where cida_codi = enti_cida) as "cida_sigl", '+
                            '(select pais_desc from cadastro.pais where pais_codi = enti_pais) as "pais_desc", '+
                            '(select pais_nume from cadastro.pais where pais_codi = enti_pais) as "pais_nume" '+
                            'from cadastro.enti where enti_codi = :codi '+
                            'and enti_empr = :empr and enti_loca = :loca';
          sqlaux.ParamByName('empr').AsInteger:= FormPrincipal.puempresa;
          sqlaux.ParamByName('loca').AsInteger:= FormPrincipal.pulocal;
          sqlaux.ParamByName('codi').AsInteger:= tbNota.FieldByName('movi_enti').AsInteger;
          sqlaux.open;
          if sqlaux.IsEmpty then
            begin
              showmessage('Entidade não cadastrada, favor verificar');
              exit;
            end;

          if strtoint(RetiraTraco(sqlaux.FieldByName('enti_cnpj').AsString)) = 0 then
            Dest.CNPJCPF           := RetiraTraco(sqlaux.fieldbyname('enti_cpf').asstring)
          else
            Dest.CNPJCPF           := RetiraTraco(sqlaux.fieldbyname('enti_cnpj').asstring);
          Dest.IE                := RetiraTraco(sqlaux.fieldbyname('enti_ie').asstring);
          Dest.ISUF              := '';
          Dest.xNome             := sqlaux.fieldbyname('enti_desc').asstring;
          Dest.EnderDest.Fone    := sqlaux.fieldbyname('enti_fone').asstring;
          Dest.EnderDest.CEP     := strtoint(RetiraTraco(sqlaux.fieldbyname('enti_cep').asstring));
          Dest.EnderDest.xLgr    := sqlaux.fieldbyname('enti_ende').asstring;
          Dest.EnderDest.nro     := sqlaux.fieldbyname('enti_nume').asstring;
          Dest.EnderDest.xCpl    := sqlaux.fieldbyname('enti_comp').asstring;
          Dest.EnderDest.xBairro := sqlaux.fieldbyname('enti_bair').asstring;
          Dest.EnderDest.cMun    := sqlaux.fieldbyname('enti_cida').asinteger;
          Dest.EnderDest.xMun    := sqlaux.fieldbyname('cida_desc').asstring;
          Dest.EnderDest.UF      := sqlaux.fieldbyname('cida_sigl').asstring;
          Dest.EnderDest.cPais   := sqlaux.fieldbyname('pais_nume').asinteger;
          Dest.EnderDest.xPais   := sqlaux.fieldbyname('pais_desc').asstring;

        //Use os campos abaixo para informar o endereço de retirada quando for diferente do Remetente/Destinatário
        {      Retirada.CNPJCPF := '';
          Retirada.xLgr    := '';
          Retirada.nro     := '';
          Retirada.xCpl    := '';
          Retirada.xBairro := '';
          Retirada.cMun    := 0;
          Retirada.xMun    := '';
          Retirada.UF      := '';}

        //Use os campos abaixo para informar o endereço de entrega quando for diferente do Remetente/Destinatário
        {      Entrega.CNPJCPF := '';
          Entrega.xLgr    := '';
          Entrega.nro     := '';
          Entrega.xCpl    := '';
          Entrega.xBairro := '';
          Entrega.cMun    := 0;
          Entrega.xMun    := '';
          Entrega.UF      := '';}

          //Adicionando Produtos
          v_seq_item:= 1;
          while not tbitens.eof do
          begin
              //carrega tabela de produtos
              sqlaux.Close;
              sqlaux.SQL.Text:= 'select *, '+
                                '       (select unid_unid from cadastro.unid where unid_codi = prod_unid) as "unidade" '+
                                'from cadastro.prod where prod_codi = :prod';
              sqlaux.ParamByName('prod').AsFloat:= tbItens.FieldByName('imov_prod').AsFloat;
              sqlaux.Open;
              with Det.Add do
              begin
                 Prod.nItem    := v_seq_item;
                 Prod.cProd    := tbItens.FieldByName('imov_prod').AsString;
                 Prod.cEAN     := sqlaux.FieldByName('prod_ean').AsString;
                 Prod.xProd    := sqlaux.FieldByName('prod_desc').AsString;
                 Prod.NCM      := sqlaux.FieldByName('prod_ncm').AsString;
                 Prod.CFOP     := tbItens.FieldByName('cfop').AsString;
                 Prod.uCom     := sqlaux.FieldByName('unidade').AsString;
                 Prod.qCom     := tbItens.FieldByName('imov_quan').Asfloat;
                 Prod.vUnCom   := MRound(tbItens.FieldByName('imov_unit').Asfloat,2);
                 Prod.vProd    := MRound(tbItens.FieldByName('imov_tota').Asfloat,2);

                 Prod.cEANTrib  := sqlaux.fieldbyname('prod_ean').AsString;
                 Prod.uTrib     := sqlaux.FieldByName('unidade').AsString;
                 Prod.qTrib     := tbItens.FieldByName('imov_quan').Asfloat;
                 Prod.vUnTrib   := mround(tbItens.FieldByName('imov_unit').Asfloat,2);

                 Prod.vFrete    := MRound(tbItens.FieldByName('imov_valo_fret').Asfloat,2);
                 Prod.vSeg      := MRound(tbItens.FieldByName('imov_valo_segu').Asfloat,2);
                 Prod.vDesc     := MRound(tbItens.FieldByName('imov_valo_desc').Asfloat,2);
                 Prod.vOutro    := MRound(tbItens.FieldByName('imov_valo_desp').Asfloat,2);
                 infAdProd      := '';


                 {  campos populados para importação
                 if sqlinoc.fieldbyname('inoc_impo_dsi').asstring <> '' then
                 begin
                    with Prod.DI.Add do
                    begin
                      nDi         := sqlinoc.fieldbyname('inoc_impo_dsi').asstring;
                      dDi         := sqlinoc.fieldbyname('inoc_impo_data_dsi').asdatetime;
                      xLocDesemb  := sqlinoc.fieldbyname('inoc_impo_loca_dese').asstring;
                      UFDesemb    := sqlinoc.fieldbyname('inoc_impo_uf_dese').asstring;
                      dDesemb     := sqlinoc.fieldbyname('inoc_impo_data_dese').asdatetime;
                      cExportador := sqlinoc.fieldbyname('inoc_impo_codi_expo').asstring;
                      with adi.Add do
                      begin
                         nAdicao     := sqlinoc.fieldbyname('inoc_impo_nume_adic').asinteger;
                         nSeqAdi     := sqlinoc.fieldbyname('inoc_impo_sequ_adic').asinteger;
                         cFabricante := sqlinoc.fieldbyname('inoc_impo_codi_fabr').asstring;
                         vDescDI     := sqlinoc.fieldbyname('inoc_impo_desc_di').asFloat;
                      end;
                    end;
                 End;
                 }

                 sqlaux.Close;
                 sqlaux.SQL.Text:= 'select * from cadastro.natu where natu_empr = :empr and natu_loca = :loca '+
                                   'and natu_codi = :codi';
                 sqlaux.ParamByName('empr').AsInteger:= FormPrincipal.puempresa;
                 sqlaux.ParamByName('loca').AsInteger:= FormPrincipal.pulocal;
                 sqlaux.ParamByName('codi').AsInteger:= tbItens.FieldByName('imov_natu').AsInteger;
                 sqlaux.Open;
                 with Imposto do
                 begin
                    if dmDados.tbempr.FieldByName('empr_form_trib').AsInteger = 3 then
                    begin
                       with ICMS Do
                       Begin
                          CSOSN := csosnVazio;
                          case AnsiIndexStr(sqlaux.fieldbyname('natu_cst_icms').asstring,['0','10','20','30','40','41','50','51','60','70','90']) of
                            0 : CST      := cst00;
                            1 : CST      := cst10;
                            2 : CST      := cst20;
                            3 : CST      := cst30;
                            4 : CST      := cst40;
                            5 : CST      := cst41;
                            6 : CST      := cst50;
                            7 : CST      := cst51;
                            8 : CST      := cst60;
                            9 : CST      := cst70;
                            10: CST      := cst90;
                          end;
                       End;
                    end
                    else
                    begin
                       with ICMS Do
                       Begin
                          CST := cstVazio;
                          case AnsiIndexStr(sqlaux.fieldbyname('natu_cst_icms').asstring,['101','102','103','300','400','201','202','203','500','900']) of
                            0 : CSOSN      := csosn101;
                            1 : CSOSN      := csosn102;
                            2 : CSOSN      := csosn103;
                            3 : CSOSN      := csosn300;
                            4 : CSOSN      := csosn400;
                            5 : CSOSN      := csosn201;
                            6 : CSOSN      := csosn202;
                            7 : CSOSN      := csosn203;
                            8 : CSOSN      := csosn500;
                            9 : CSOSN      := csosn900;
                          end;
                       End;
                    end;
                    if dmdados.tbempr.FieldByName('empr_form_trib').AsInteger = 3 then
                    begin
                       with ICMS do
                       begin
                          case sqlaux.fieldbyname('natu_orig_merc').asinteger of
                            0: ICMS.orig:= oeNacional;
                            1: ICMS.orig:= oeEstrangeiraImportacaoDireta;
                            2: ICMS.orig:= oeEstrangeiraAdquiridaBrasil;
                          end;
                          case sqlaux.FieldByName('natu_moda_icms').AsInteger of
                            0: ICMS.modBC:= dbiMargemValorAgregado;
                            1: ICMS.modBC:= dbiPauta;
                            2: ICMS.modBC:= dbiPrecoTabelado;
                            3: ICMS.modBC:= dbiValorOperacao;
                          end;
                          ICMS.vBC         := MRound(tbItens.FieldByName('imov_base_icms').AsFloat,2);
                          ICMS.pICMS       := MRound(tbItens.FieldByName('imov_aliq_icms').AsFloat,2);
                          ICMS.vICMS       := MRound(tbItens.FieldByName('imov_valo_icms').AsFloat,2);

                          case sqlaux.FieldByName('natu_moda_base_icms_st').AsInteger of
                            0: ICMS.modBCST:= dbisPrecoTabelado;
                            1: ICMS.modBCST:= dbisListaNegativa;
                            2: ICMS.modBCST:= dbisListaPositiva;
                            3: ICMS.modBCST:= dbisListaNeutra;
                            4: ICMS.modBCST:= dbisMargemValorAgregado;
                            5: ICMS.modBCST:= dbisPauta;
                          end;

                          ICMS.pMVAST      := MRound(tbItens.FieldByName('imov_aliq_mva').AsFloat,2);
                          ICMS.pRedBCST    := MRound(tbItens.FieldByName('imov_aliq_st').AsFloat,2);
                          ICMS.vBCST       := MRound(tbItens.FieldByName('imov_base_icms_st').AsFloat,2);
                          ICMS.pICMSST     := MRound(tbItens.FieldByName('imov_aliq_mva').AsFloat,2);
                          ICMS.vICMSST     := MRound(tbItens.FieldByName('imov_valo_icms_st').AsFloat,2);
                          ICMS.pRedBC      := MRound(tbItens.FieldByName('imov_aliq_st').AsFloat,2);
                          ICMS.pCredSN     := 0;
                          ICMS.vCredICMSSN := 0;
                       end;
                    end;
                    with IPI do
                    begin
                       if (sqlaux.fieldbyname('natu_cst_ipi_trib').asinteger = 0) or
                          (sqlaux.fieldbyname('natu_cst_ipi_trib').asinteger = 50) or
                          (sqlaux.fieldbyname('natu_cst_ipi_trib').asinteger = 49) or
                          (sqlaux.fieldbyname('natu_cst_ipi_trib').asinteger = 99) then
                       begin
                          case AnsiIndexStr(sqlaux.fieldbyname('natu_cst_ipi_trib').asstring,['0','50','49','99']) of
                            0 : cst := ipi00;
                            1 : cst := ipi50;
                            2 : cst := ipi49;
                            3 : cst := ipi99;
                          end;
                          {
                          clEnq       := sqlInoc.fieldbyname('inoc_clas_enqu').asstring;
                          CNPJProd    := sqlInoc.fieldbyname('inoc_cnpj_prod').asstring;
                          cSelo       := sqlInoc.fieldbyname('inoc_codi_selo').asstring;
                          qSelo       := sqlInoc.fieldbyname('inoc_quan_selo').asinteger;
                          cEnq        := sqlInoc.fieldbyname('inoc_codi_enqu').asstring;
                          }
                          vBC         := MRound(tbItens.FieldByName('imov_base_ipi').AsFloat,2);
                          qUnid       := 0;
                          vUnid       := 0;
                          pIPI        := MRound(tbItens.FieldByName('imov_aliq_ipi').AsFloat,2);
                          vIPI        := MRound(tbItens.FieldByName('imov_valo_ipi').AsFloat,2);
                       end
                       else
                       begin
                          case AnsiIndexStr(sqlaux.fieldbyname('natu_cst_ipi_trib').asstring,['01','02','03','04','05','51','52','53','54','55']) of
                            0 : cst := ipi01;
                            1 : cst := ipi02;
                            2 : cst := ipi03;
                            3 : cst := ipi04;
                            4 : cst := ipi05;
                            5 : cst := ipi51;
                            6 : cst := ipi52;
                            7 : cst := ipi53;
                            8 : cst := ipi54;
                            9 : cst := ipi55;
                          end;
                       end;
                    End;
                    { carrega os campos para importação
                    if sqlInoc.fieldbyname('inoc_impo_base_ii').asfloat > 0 then
                    begin
                       with II do
                       begin
                          vBc      := sqlInoc.fieldbyname('inoc_impo_base_ii').asfloat;
                          vDespAdu := sqlInoc.fieldbyname('inoc_impo_desp_adua').asfloat;
                          vII      := sqlInoc.fieldbyname('inoc_impo_valo_ii').asfloat;
                          vIOF     := sqlInoc.fieldbyname('inoc_impo_iof').asfloat;
                       end;
                       totalii := totalii + sqlInoc.fieldbyname('inoc_impo_valo_ii').asfloat;
                    end;
                    }
                    with PIS do
                    begin
                       case AnsiIndexStr(sqlaux.fieldbyname('natu_cst_pis').asstring,['01','02','03','04','06','07','08','09','99']) of
                         0 : CST      := pis01;
                         1 : CST      := pis02;
                         2 : CST      := pis03;
                         3 : CST      := pis04;
                         4 : CST      := pis06;
                         5 : CST      := pis07;
                         6 : CST      := pis08;
                         7 : CST      := pis09;
                         8 : CST      := pis99;
                       end;
                       PIS.vBC  := MRound(tbItens.FieldByName('imov_base_pis').asfloat,2);
                       PIS.pPIS := MRound(sqlaux.FieldByName('natu_aliq_pis').AsFloat,2);
                       PIS.vPIS := MRound(tbItens.FieldByName('imov_valo_pis').asfloat,2);
                    end;

                    with PISST do
                    begin
                       vBc       := 0;
                       pPis      := 0;
                       qBCProd   := 0;
                       vAliqProd := 0;
                       vPIS      := 0;
                    end;

                    with COFINS do
                    begin
                       case AnsiIndexStr(sqlaux.fieldbyname('natu_cst_cofi').asstring,['01','02','03','04','06','07','08','09','99']) of
                         0 : CST      := cof01;
                         1 : CST      := cof02;
                         2 : CST      := cof03;
                         3 : CST      := cof04;
                         4 : CST      := cof06;
                         5 : CST      := cof07;
                         6 : CST      := cof08;
                         7 : CST      := cof09;
                         8 : CST      := cof99;
                       end;
                       COFINS.vBC     := MRound(tbItens.FieldByName('imov_base_cofins').asfloat,2);
                       COFINS.pCOFINS := MRound(sqlaux.FieldByName('natu_aliq_cofi').AsFloat,2);
                       COFINS.vCOFINS := MRound(tbItens.FieldByName('imov_valo_cofins').asfloat,2);
                    end;

                    with COFINSST do
                    begin
                       vBC       := 0;
                       pCOFINS   := 0;
                       qBCProd   := 0;
                       vAliqProd := 0;
                       vCOFINS   := 0;
                    end;
                 end;

                 { carregar esses campos em caso de venda de armamento
                 if strtointdef(sqlinoc.fieldbyname('inoc_nume_seri_arma').asstring,0) > 0 then
                 begin
                    with Prod.arma.Add do
                    begin
                      nSerie := sqlinoc.fieldbyname('inoc_nume_seri_arma').asstring;
                      if sqlinoc.fieldbyname('inoc_tipo_arma').asstring = '0' Then
                         tpArma := taUsoPermitido
                      else
                         tpArma := taUsoRestrito;
                      nCano  := sqlinoc.fieldbyname('inoc_nume_seri_cano').asstring;
                      descr  := sqlinoc.fieldbyname('inoc_desc_comp_arma').asstring;
                    end;
                 end;
                 }
              end;
              tbItens.next;
              inc(v_seq_item);
          end;

          Total.ICMSTot.vBC     := MRound(tbnota.FieldByName('movi_base_icms').AsFloat,2);
          Total.ICMSTot.vICMS   := MRound(tbnota.FieldByName('movi_valo_icms').AsFloat,2);
          Total.ICMSTot.vBCST   := MRound(tbnota.FieldByName('movi_base_st').AsFloat,2);
          Total.ICMSTot.vST     := MRound(tbnota.FieldByName('movi_valo_st').AsFloat,2);
          Total.ICMSTot.vProd   := MRound(tbnota.FieldByName('movi_tota_prod').AsFloat,2);
          Total.ICMSTot.vFrete  := MRound(tbnota.FieldByName('movi_valo_fret').AsFloat,2);
          Total.ICMSTot.vSeg    := MRound(tbnota.FieldByName('movi_valo_segu').AsFloat,2);
          Total.ICMSTot.vDesc   := MRound(tbnota.FieldByName('movi_valo_desc').AsFloat,2);
          Total.ICMSTot.vII     := 0;
          Total.ICMSTot.vIPI    := MRound(tbnota.FieldByName('movi_valo_ipi').AsFloat,2);
          Total.ICMSTot.vPIS    := MRound(tbnota.FieldByName('movi_valo_pis').AsFloat,2);
          Total.ICMSTot.vCOFINS := MRound(tbnota.FieldByName('movi_valo_cofins').AsFloat,2);
          Total.ICMSTot.vOutro  := MRound(tbnota.FieldByName('movi_valo_desp').AsFloat,2);
          Total.ICMSTot.vNF     := MRound(tbnota.FieldByName('movi_tota_nota').AsFloat,2);

          Total.ISSQNtot.vServ   := 0;
          Total.ISSQNTot.vBC     := 0;
          Total.ISSQNTot.vISS    := 0;
          Total.ISSQNTot.vPIS    := 0;
          Total.ISSQNTot.vCOFINS := 0;

          Total.retTrib.vRetPIS    := 0;
          Total.retTrib.vRetCOFINS := 0;
          Total.retTrib.vRetCSLL   := 0;
          Total.retTrib.vBCIRRF    := 0;
          Total.retTrib.vIRRF      := 0;
          Total.retTrib.vBCRetPrev := 0;
          Total.retTrib.vRetPrev   := 0;

          case tbnota.fieldbyname('movi_tipo_fret').asinteger of
            0: Transp.modFrete:= mfContaEmitente;
            1: Transp.modFrete:= mfContaDestinatario;
            2: Transp.modFrete:= mfSemFrete;
          end;

          if Transp.modFrete <> mfSemFrete then
          begin
             //carrega dados do transportador
             sqlaux.close;
             sqlaux.sql.Text:= 'select *, '+
                               '       (select cida_sigl from cadastro.cida where cida_codi = enti_cida) as "cida_sigl" '+
                               'from cadastro.enti where enti_codi = :codi '+
                               'and enti_empr = :empr and enti_loca = :loca ';
             sqlaux.ParamByName('empr').AsInteger:= FormPrincipal.puempresa;
             sqlaux.ParamByName('loca').AsInteger:= FormPrincipal.pulocal;
             sqlaux.ParamByName('codi').AsInteger:= tbnota.FieldByName('movi_tran').AsInteger;
             sqlaux.open;
             if sqlaux.IsEmpty then
               begin
                 showmessage('Transportador não encontrado, favor verificar !!!');
                 exit;
               end;

             if strtoint(retiratraco(sqlaux.FieldByName('enti_cnpj').asstring)) = 0 then
               Transp.Transporta.CNPJCPF  := sqlaux.FieldByName('enti_cpf').AsString
             else
               Transp.Transporta.CNPJCPF  := sqlaux.FieldByName('enti_cnpj').AsString;

             Transp.Transporta.xNome    := sqlaux.FieldByName('enti_desc').AsString;
             Transp.Transporta.IE       := sqlaux.FieldByName('enti_ie').AsString;
             Transp.Transporta.xEnder   := sqlaux.FieldByName('enti_ende').AsString;
             Transp.Transporta.xMun     := sqlaux.FieldByName('enti_nume').AsString;
             Transp.Transporta.UF       := sqlaux.FieldByName('cida_sigl').AsString;

             Transp.retTransp.vServ    := 0;
             Transp.retTransp.vBCRet   := 0;
             Transp.retTransp.pICMSRet := 0;
             Transp.retTransp.vICMSRet := 0;
             Transp.retTransp.CFOP     := '';
             Transp.retTransp.cMunFG   := 0;

             sqlaux.close;
             sqlaux.sql.Text:= 'select * from cadastro.veic where veic_codi = :codi '+
                               'and veic_empr = :empr and veic_loca = :loca ';
             sqlaux.ParamByName('empr').AsInteger:= FormPrincipal.puempresa;
             sqlaux.ParamByName('loca').AsInteger:= FormPrincipal.pulocal;
             sqlaux.ParamByName('codi').AsInteger:= tbnota.FieldByName('movi_veic').AsInteger;
             sqlaux.open;

             Transp.veicTransp.placa := RetiraTraco(sqlaux.FieldByName('veic_plac').AsString);
             Transp.veicTransp.UF    := sqlaux.FieldByName('veic_uf').AsString;
             Transp.veicTransp.RNTC  := sqlaux.FieldByName('veic_antt').AsString;
             //Dados do Reboque
             with Transp.Reboque.Add do
             begin
               placa := RetiraTraco(sqlaux.FieldByName('veic_plac_rebo_1').asstring);
               UF    := sqlaux.FieldByName('veic_uf_rebo_1').asstring;
               RNTC  := sqlaux.FieldByName('veic_rntc_rebo_1').asstring;
             end;
             with Transp.Reboque.Add do
             begin
               placa := RetiraTraco(sqlaux.FieldByName('veic_plac_rebo_2').asstring);
               UF    := sqlaux.FieldByName('veic_uf_rebo_2').asstring;
               RNTC  := sqlaux.FieldByName('veic_rntc_rebo_2').asstring;
             end;
          End;

          with Transp.Vol.Add do
           begin
             qVol  := tbnota.FieldByName('movi_volu').Asinteger;
             esp   := tbnota.FieldByName('movi_espe').Asstring;
             marca := tbnota.FieldByName('movi_marc').Asstring;
             nVol  := tbnota.FieldByName('movi_volu').Asstring;
             pesoL := tbnota.FieldByName('movi_pliq').Asfloat;
             pesoB := tbnota.FieldByName('movi_pbru').Asfloat;
           end;

          //carrega dados do financeiro
          sqlaux.Close;
          sqlaux.SQL.Text:= 'select * from movimento.mofi where mofi_titu = :nota and mofi_empr = :empr '+
                            'and mofi_loca = :loca and mofi_enti = :enti';
          sqlaux.ParamByName('empr').AsInteger:= FormPrincipal.puempresa;
          sqlaux.ParamByName('loca').AsInteger:= FormPrincipal.pulocal;
          sqlaux.ParamByName('nota').asfloat  := tbNota.fieldbyname('movi_codi').asfloat;
          sqlaux.ParamByName('enti').AsFloat  := tbnota.FieldByName('movi_enti').AsFloat;
          sqlaux.Open;
          if sqlaux.RecordCount > 0 then
          begin
             Cobr.Fat.nFat  := sqlaux.FieldByName('mofi_titu').Asstring;
             Cobr.Fat.vOrig := MRound(sqlaux.FieldByName('mofi_valo_tota').AsFloat,2);
             Cobr.Fat.vDesc := 0 ;
             Cobr.Fat.vLiq  := MRound(sqlaux.FieldByName('mofi_valo_tota').AsFloat,2);
             while not sqlaux.eof do
             begin
                with Cobr.Dup.Add do
                begin
                   nDup  := sqlaux.FieldByName('mofi_titu').Asstring;
                   dVenc := sqlaux.FieldByName('mofi_venc').Asdatetime;
                   vDup  := MRound(sqlaux.FieldByName('mofi_valo_tota').Asfloat,2);
                end;
                sqlaux.Next;
             end;
          End;

          //carrega mensagem adicional
          sqlaux.Close;
          sqlaux.SQL.Text:= 'select * from cadastro.mens where mens_codi = :codi and mens_empr = :empr '+
                            'and mens_loca = :loca';
          sqlaux.ParamByName('empr').AsInteger:= FormPrincipal.puempresa;
          sqlaux.ParamByName('loca').AsInteger:= FormPrincipal.pulocal;
          sqlaux.ParamByName('codi').AsInteger:= tbnota.FieldByName('movi_mens_fisc').AsInteger;
          sqlaux.Open;
          InfAdic.infCpl     :=  sqlAux.fieldbyname('mens_mens').asstring;
          InfAdic.infAdFisco :=  '';

          compra.xNEmp := '';
          compra.xPed  := '';
          compra.xCont := '';
       end;
       try
         dmdados.nfe.NotasFiscais.Valida;
         dmdados.nfe.NotasFiscais.GerarNFe;
       finally
         sqlaux.Close;
         sqlaux.SQL.Text:= 'select empr_lote_nfe from cadastro.empr where empr_codi = :empr';
         sqlaux.ParamByName('empr').AsInteger:= FormPrincipal.puempresa;
         sqlaux.Open;
         sqlaux.Tag:= sqlaux.FieldByName('empr_lote_nfe').AsInteger + 1;

         try
            dmdados.nfe.NotasFiscais.Assinar;
         except
         on E: Exception do
            begin
               showmessage(E.Message);
            end;
         end;
         try
            try
              dmdados.nfe.Enviar(sqlaux.Tag,false);
            except
            on E: Exception do
               begin
                  showmessage(E.Message);
               end;
            end;
         except
         on E: Exception do
            begin
               showmessage(E.Message);
            end;
         end;

         // atualiza numero do lote dentro da tabela empresa
         sqlaux.close;
         sqlaux.SQL.Text:= 'update cadastro.empr set empr_lote_nfe = :lote';
         sqlaux.ParamByName('lote').AsInteger:= sqlaux.Tag;
         sqlaux.ExecSQL;

         //atualiza tabela de serie
         sqlaux.Close;
         sqlaux.SQL.Text:= 'update cadastro.seri set seri_sequ = :nota where seri_codi = :seri '+
                           'and seri_empr = :empr and seri_loca = :loca ';
         sqlaux.ParamByName('empr').AsInteger:= FormPrincipal.puempresa;
         sqlaux.ParamByName('loca').AsInteger:= FormPrincipal.pulocal;
         sqlaux.ParamByName('nota').asfloat:= v_nota_fiscal;
         sqlaux.ParamByName('seri').Asinteger:= tbNota.FieldByName('movi_seri').Asinteger;
         sqlaux.ExecSQL;

         //atualiza tabela de pedidos
         v_protocolo := dmdados.nfe.WebServices.Retorno.NFeRetorno.ProtNFe.Items[0].nProt;
         sqlaux.close;
         sqlaux.SQL.Text:= 'update movimento.movi set movi_nume_prot = :protocolo, '+
                           '                   movi_id_nfe = :id_nfe, '+
                           '                   movi_stat_nfe = :status_nfe, '+
                           '                   movi_reci_nfe = :recibo_nfe, '+
                           '                   movi_xml_emit = :xml_autorizada, '+
                           '                   movi_nume_nfe = :nota_fiscal, '+
                           '                   movi_lote_nfe = :lote_nfe, '+
                           '                   movi_seri = :serie_nfe '+
                           'where movi_codi = :codi and movi_empr = :empr and movi_loca = :loca';
         sqlaux.ParamByName('empr').AsInteger:= FormPrincipal.puempresa;
         sqlaux.ParamByName('loca').AsInteger:= FormPrincipal.pulocal;
         sqlaux.ParamByName('codi').AsInteger          := tbnota.FieldByName('movi_codi').AsInteger;
         sqlaux.parambyname('protocolo').Asstring      := v_protocolo;
         sqlaux.ParamByName('id_nfe').AsString         := dmdados.nfe.WebServices.Retorno.NFeRetorno.ProtNFe.Items[0].chNFe;
         sqlaux.ParamByName('status_nfe').AsInteger    := dmdados.nfe.WebServices.Retorno.cStat;
         sqlaux.parambyname('recibo_nfe').Asstring     := dmdados.nfe.WebServices.Retorno.NFeRetorno.nRec;
         sqlaux.parambyname('xml_autorizada').AsString := dmdados.nfe.NotasFiscais.Items[0].XML;
         sqlaux.ParamByName('nota_fiscal').AsInteger   := v_nota_fiscal;
         sqlaux.Parambyname('lote_nfe').AsInteger      := sqlaux.Tag;
         sqlaux.ParamByName('serie_nfe').AsString      := tbNota.FieldByName('movi_seri').AsString;
         sqlaux.ExecSQL;

         dmDados.NFe.NotasFiscais.Items[0].ImprimirPDF;
         dmDados.NFe.NotasFiscais.Items[0].Imprimir;
         dmDados.NFe.NotasFiscais.Items[0].SaveToFile;
       end;
       tbnota.next;
   end;
   btnConsultaClick(Self);
end;

procedure TFormEmissaoNFe.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFormEmissaoNFe.btnServicoClick(Sender: TObject);
begin
  dmdados.NFe.WebServices.StatusServico.Executar;
end;

procedure TFormEmissaoNFe.cxButton1Click(Sender: TObject);
var
 Para : String;
 CC: Tstrings;
 xml, mensagem : TStringList;
begin
  xml:= TStringlist.Create;
  mensagem:= TStringlist.Create;
  if tbNota.FieldByName('movi_stat_nfe').AsFloat = 100 then
   begin
     xml.Add(tbNota.FieldByName('movi_xml_emit').asstring);
     xml.SaveToFile('nota.xml');
   end else
  if tbNota.FieldByName('movi_stat_nfe').AsFloat = 101 then
    begin
      xml.Add(tbNota.FieldByName('movi_xml_canc').asstring);
      xml.SaveToFile('nota.xml');
    end;
  if tbNota.FieldByName('enti_mail').AsString = '' then
    para:= InputBox('Informe o E-mail do destinatário','Email','')
  else
    para:= tbNota.FieldByName('enti_mail').AsString;

  mensagem.Add(dmDados.tbempr.fieldbyname('empr_corp_mens').AsString);
  try
    with dmDados.nfe do
     begin
       NotasFiscais.Clear;
       NotasFiscais.LoadFromFile('nota.xml');
       NotasFiscais.Items[0].EnviarEmail(dmDados.tbempr.fieldbyname('empr_smtp').asstring
                                       , dmDados.tbempr.fieldbyname('empr_port_smtp').asstring
                                       , dmDados.tbempr.fieldbyname('empr_usua_smtp').asstring
                                       , dmDados.tbempr.fieldbyname('empr_senh_smtp').asstring
                                       , dmDados.tbempr.fieldbyname('empr_mail').AsString
                                       , Para
                                       , dmDados.tbempr.fieldbyname('empr_corp_mens').AsString
                                       , mensagem
                                       , dmDados.tbempr.fieldbyname('empr_ssl').AsBoolean // SSL - Conexão Segura
                                       , True //Enviar PDF junto
                                       , nil //Lista com emails que serão enviado cópias - TStrings
                                       , nil // Lista de anexos - TStrings
                                       , False  //Pede confirmação de leitura do email
                                       , true  //Aguarda Envio do Email(não usa thread)
                                       , dmDados.tbempr.fieldbyname('empr_raza').AsString // Nome do Rementente
                                       , dmDados.tbempr.fieldbyname('empr_tls').AsBoolean); // Auto TLS
     end;
  finally
    ShowMessage('NF-e enviada com sucesso');
    DeleteFile('nota.xml');
    xml.free;
    mensagem.Free;
  end;
end;

procedure TFormEmissaoNFe.cxGrid1DBTableView1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  If AViewInfo.GridRecord.RecordIndex mod 2 = 0 Then
    ACanvas.Brush.Color := $FFFAFA
  Else
    ACanvas.Brush.Color := $CDC9C9;

  ACanvas.Font.Color := clBlack;
end;

procedure TFormEmissaoNFe.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action:= caFree;
  FormEmissaoNFe:= nil;
end;

procedure TFormEmissaoNFe.FormShow(Sender: TObject);
begin
  edInic.Date:= BeginOfMonth(Date);
  edFina.Date:= EndOfMonth(Date);

  tbNota.Close;
  tbNota.ParamByName('empr').AsInteger:= formprincipal.puempresa;
  tbNota.ParamByName('loca').AsInteger:= FormPrincipal.pulocal;
  tbnota.ParamByName('inic').AsDate:= edInic.Date;
  tbnota.ParamByName('fina').AsDate:= edFina.Date;
  tbNota.Open;
  tbNota.FieldByName('seleciona').ReadOnly:= False;
end;

procedure TFormEmissaoNFe.tbNotaAfterScroll(DataSet: TDataSet);
begin
  tbItens.Close;
  tbItens.ParamByName('empr').AsInteger:= FormPrincipal.puempresa;
  tbItens.ParamByName('loca').AsInteger:= FormPrincipal.pulocal;
  tbItens.ParamByName('codi').AsInteger:= tbNota.FieldByName('movi_codi').AsInteger;
  tbItens.Open;
end;

end.
