unit rotinas;

interface

uses Menus, ExtCtrls, Classes, WinProcs, Forms, Dialogs,
  StdCtrls, Graphics, Buttons,
  DB, Controls, DBClient, ComCtrls, DBCtrls,
  ComObj, OleServer, Activex, Mask, SysUtils, uni,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, cxTextEdit, UrlMon, ACBrECF,
  ACBrRFD, ACBrBase, ACBrDevice, ACBrECFClass, ACBrConsts, pcnConversao,
  IdMessage, StrUtils, Types, cxCurrencyEdit, Messages,RLConsts, RLMetaFile, RLUtils, RLPrintDialog,
  RLSaveDialog, RLPrinters, RLTypes, RLFindDialog, RLReport,
  IdSMTP,
  WinInet,
  IdBaseComponent,
  IdComponent,
  IdIOHandler,
  IdIOHandlerSocket,
  IdSSLOpenSSL,
  IdAttachmentFile,
  IdIOHandlerStack,
  IdSSL,
  IdTCPConnection,
  IdTCPClient,
  IdExplicitTLSClientServerBase,
  IdMessageClient,
  IdSMTPBase,
  ComServ,
  Windows,
  Variants;

function consulta(tabela : string ; codigo : Integer = 0):string;
procedure CriaForm(FormClass: TFormClass; var Reference);
function ConfigNFe : Boolean;
function RetiraTraco(Texto: String): String;
function Imprimir(relatorio : TRLReport; banda : TRLBand; zebrar : Boolean = true) : Boolean;




implementation

uses prog0003, prog0001, prog0004, prog0026;


function Imprimir(relatorio : TRLReport; banda : TRLBand; zebrar : Boolean = true) : Boolean;
begin
  if zebrar then
   begin
      banda.GreenBarPrint:= dmdados.quPara.FieldByName('para_rela_zebr').AsBoolean;
   end else
    begin
      banda.GreenBarPrint:= zebrar;
    end;
  relatorio.Prepare;
  application.CreateForm(TFormRelatorio, FormRelatorio);
  FormRelatorio.preview.Pages:= relatorio.Pages;
  FormRelatorio.Show;
end;

function RetiraTraco(Texto: String): String;
var
  novotexto : String;
  i         : Integer;
  Caracter  : Char;
begin
  novotexto := '';
  For i := 1 to Length(Texto) do
  Begin
     Caracter := Texto[i];
     Case Caracter of
        '-' : novotexto := novotexto+'';
        '/' : novotexto := novotexto+'';
        ':' : novotexto := novotexto+'';
        '.' : novotexto := novotexto+'';
     Else
        novotexto := novotexto+Copy(Texto,i,1);
     End;
  End;
  Result := novotexto;
end;

function ConfigNFe : Boolean;
begin
  with dmDados.sqlaux do
   begin
     Close;
     SQL.Clear;
     SQL.Text:= 'select *, '+
                '(select cida_sigl from cadastro.cida where cida_codi = empr_cida) as "cida_sigl" '+
                'from cadastro.empr where empr_codi = :codi';
     ParamByName('codi').AsInteger:= FormPrincipal.puempresa;
     Open;
   end;

  if not directoryexists(ExtractFilePath(application.exename)+'PathCan\'+FormatDateTime('MMYYYY', Date)) then
    ForceDirectories(ExtractFilePath(application.exename)+'PathCan\'+FormatDateTime('MMYYYY', Date));
  if not directoryexists(ExtractFilePath(application.exename)+'PathDPEC\'+FormatDateTime('MMYYYY', Date)) then
    ForceDirectories(ExtractFilePath(application.exename)+'PathDPEC\'+FormatDateTime('MMYYYY', Date));
  if not directoryexists(ExtractFilePath(application.exename)+'Pathinu\'+FormatDateTime('MMYYYY', Date)) then
    ForceDirectories(ExtractFilePath(application.exename)+'Pathinu\'+FormatDateTime('MMYYYY', Date));
  if not directoryexists(ExtractFilePath(application.exename)+'PathNfe') then
    ForceDirectories(ExtractFilePath(application.exename)+'PathNfe');
  if not directoryexists(ExtractFilePath(application.exename)+'PDFNFe\'+FormatDateTime('MMYYYY', Date)) then
    ForceDirectories(ExtractFilePath(application.exename)+'PDFNFe\'+FormatDateTime('MMYYYY', Date));

  with dmDados do
   begin
     nfe.Configuracoes.Arquivos.PathNFe := ExtractFilePath(application.exename)+'PathNfe';
     nfe.Configuracoes.Arquivos.PathCan := ExtractFilePath(application.exename)+'PathCan\'+FormatDateTime('MMYYYY', Date);
     nfe.Configuracoes.Arquivos.PathInu := ExtractFilePath(application.exename)+'Pathinu\'+FormatDateTime('MMYYYY', Date);
     nfe.Configuracoes.Arquivos.PathDPEC:= ExtractFilePath(application.exename)+'PathDPEC\'+FormatDateTime('MMYYYY', Date);
     danfe.PathPDF                      := ExtractFilePath(application.exename)+'PDFNFe\'+FormatDateTime('MMYYYY', Date);
     if dmdados.sqlaux.FieldByName('empr_logo').AsString <> '' then
        danfe.Logo := dmdados.sqlaux.FieldByName('empr_logo').AsString ;

     danfe.Usuario:= FormPrincipal.controle.CurrentUser.UserName;
     FormPrincipal.puNomeUsuario := FormPrincipal.controle.CurrentUser.UserName;

     FormPrincipal.puLogiUsuario := FormPrincipal.controle.CurrentUser.UserLogin;
     FormPrincipal.sb.Panels[1].Text := 'Usu�rio Conectado: '+formprincipal.puNomeUsuario;

     case sqlaux.fieldbyname('empr_ambi').asinteger of
       1 : nfe.Configuracoes.WebServices.Ambiente := taHomologacao;
       2 : nfe.Configuracoes.WebServices.Ambiente := taProducao;
     end;

     nfe.Configuracoes.WebServices.UF        := sqlaux.fieldbyname('cida_sigl').asstring;
     nfe.Configuracoes.WebServices.ProxyHost := sqlaux.fieldbyname('empr_host').asstring;
     nfe.Configuracoes.WebServices.ProxyPass := sqlaux.fieldbyname('empr_senh_host').asstring;
     nfe.Configuracoes.WebServices.ProxyPort := sqlaux.fieldbyname('empr_port').asstring;
     nfe.Configuracoes.WebServices.ProxyUser := sqlaux.fieldbyname('empr_usua_host').asstring;

     case sqlaux.fieldbyname('empr_form_emis').asinteger of
       0 : nfe.Configuracoes.Geral.FormaEmissao:= teNormal;
       1 : nfe.Configuracoes.Geral.FormaEmissao:= teContingencia;
       2 : nfe.Configuracoes.Geral.FormaEmissao:= teSCAN;
       3 : nfe.Configuracoes.Geral.FormaEmissao:= teDPEC;
     end;
     nfe.Configuracoes.Geral.PathSalvar  := ExtractFilePath(application.exename);
     nfe.Configuracoes.Geral.PathSchemas := ExtractFilePath(application.exename)+'Schemas';
     nfe.Configuracoes.Certificados.NumeroSerie := sqlaux.fieldbyname('empr_cert').asstring;
     nfe.Configuracoes.Certificados.Senha       := sqlaux.fieldbyname('empr_senh').asstring;
   end;
end;

procedure CriaForm(FormClass: TFormClass; var Reference);
begin
  if TForm(Reference) = nil then
  Begin
    Application.CreateForm(FormClass, TForm(Reference));
    TForm(Reference).top := 0;
  End
  else
  begin
    if TForm(Reference).WindowState = wsMinimized then
      TForm(Reference).WindowState := wsNormal;
    TForm(Reference).BringToFront;
  end;
end;

function consulta(tabela : string ; codigo : Integer = 0):string;
var
  retorno : string;
begin
  Application.CreateForm(TFormConsulta, FormConsulta);
  formconsulta.qConsulta.Close;
  if tabela = 'cons_empresa' then
    begin
      FormConsulta.qConsulta.SQL.Text:= 'select empr_codi as "C�digo", '+
                                        'cast(empr_raza as varchar(80)) as "Raz�o Social", '+
                                        'cast(empr_cnpj as varchar(20)) as "CNPJ", '+
                                        'cast(empr_fone as varchar(20))as "Telefone" '+
                                        'from cadastro.empr ';
      FormConsulta.titulo.Caption:= 'Consulta Empresa';
      retorno:= 'C�digo';
      formconsulta.qconsulta.sql.Add('order by empr_codi');
      FormConsulta.qConsulta.Open;
      FormConsulta.ShowModal;
    end else
  if tabela = 'cons_veiculo' then
    begin
      FormConsulta.qConsulta.SQL.Text:= 'select veic_codi as "C�digo", '+
                                        'cast(veic_desc as varchar(80)) as "Descri��o", '+
                                        'cast(veic_plac as varchar(20)) as "Placa", '+
                                        'cast(veic_plac_rebo_1 as varchar(20))as "Placa Reboque 1", '+
                                        'cast(veic_plac_rebo_2 as varchar(20))as "Placa Reboque 2" '+
                                        'from cadastro.veic ';
      FormConsulta.titulo.Caption:= 'Consulta Ve�culos';
      retorno:= 'C�digo';
      formconsulta.qconsulta.sql.Add('order by veic_codi');
      FormConsulta.qConsulta.Open;
      FormConsulta.ShowModal;
    end else
  if tabela = 'cons_serie' then
    begin
      FormConsulta.qConsulta.SQL.Text:= 'select seri_codi as "C�digo", '+
                                        'cast(seri_desc as varchar(80)) as "Descri��o", '+
                                        'cast(seri_seri as varchar(20)) as "S�rie", '+
                                        'cast(seri_sequ as varchar(20))as "Sequ�ncia" '+
                                        'from cadastro.seri ';
      FormConsulta.titulo.Caption:= 'Consulta S�rie de Documentos';
      retorno:= 'C�digo';
      formconsulta.qconsulta.sql.Add('order by seri_codi');
      FormConsulta.qConsulta.Open;
      FormConsulta.ShowModal;
    end else
  if tabela = 'cons_formapagamento' then
    begin
      FormConsulta.qConsulta.SQL.Text:= 'select fopa_codi as "C�digo", cast(fopa_desc as varchar(80)) as "Descri��o", '+
                                        'cast(fopa_nume_parc as varchar(20)) as "N�mero de Parcelas", '+
                                        'cast(fopa_prim_dia as varchar(30)) as "Dias para Primeira Parcela", '+
                                        'cast(fopa_dias_entr as varchar(20)) as "Dias entre Parcelas" '+
                                        'from cadastro.fopa ';
      FormConsulta.titulo.Caption:= 'Consulta Formas de Pagamento';
      formconsulta.qconsulta.sql.Add('order by fopa_codi');
      retorno:= 'C�digo';
      FormConsulta.qConsulta.Open;
      FormConsulta.ShowModal;
    end else
  if tabela = 'cons_movimento' then
    begin
      FormConsulta.qConsulta.SQL.Text:= 'select movi_codi as "C�digo", movi_nume_nfe as "Nota", '+
                                        'movi_emis as "Emiss�o", movi_enti as "Entidade", '+
                                        'cast((select enti_desc from cadastro.enti where enti_codi = movi_enti) as varchar(80)) as "Nome Entidade", '+
                                        'cast((case when movi_tipo_movi = 1 then ''Entrada'' else ''Sa�da'' end) as varchar(30)) as "Tipo de Movimento", '+
                                        'cast((case when movi_form_emis = 1 then ''Or�amento'' '+
                                        '          when movi_form_emis = 2 then ''Pedido'' '+
                                        '          when movi_form_emis = 3 then ''Nota'' '+
                                        'end) as varchar(30)) as "Forma de Emiss�o" '+
                                        'from movimento.movi ';
      FormConsulta.titulo.Caption:= 'Consulta Movimento';
      retorno:= 'C�digo';
      formconsulta.qconsulta.sql.Add('order by movi_codi');
      FormConsulta.qConsulta.Open;
      FormConsulta.ShowModal;
    end else
  if tabela = 'cons_mensagem' then
    begin
      FormConsulta.qConsulta.SQL.Text:= 'select mens_codi as "C�digo", mens_desc as "Descri��o" '+
                                        'from cadastro.mens ';
      FormConsulta.titulo.Caption:= 'Consulta Mensagens Fiscais';
      retorno:= 'C�digo';
      formconsulta.qconsulta.sql.Add('order by mens_codi');
      FormConsulta.qConsulta.Open;
      FormConsulta.ShowModal;
    end else
  if tabela = 'cons_cfop' then
    begin
      FormConsulta.qConsulta.SQL.Text:= 'select natu_codi as "C�digo", '+
                                        'cast(natu_desc as varchar(80)) as "Descri��o", '+
                                        'natu_cfop as "CFOP" '+
                                        'from cadastro.natu ';
      FormConsulta.titulo.Caption:= 'Consulta Natureza de Opera��o';
      retorno:= 'C�digo';
      formconsulta.qconsulta.sql.Add('order by natu_codi');
      FormConsulta.qConsulta.Open;
      FormConsulta.ShowModal;
    end else
  if tabela = 'cons_tipoentidade' then
    begin
      FormConsulta.qConsulta.SQL.Text:= 'select tien_codi as "C�digo", tien_desc as "Descri��o" '+
                                        'from cadastro.tien where tien_empr = :empr and tien_loca = :loca ';
      FormConsulta.qConsulta.ParamByName('empr').AsInteger:= formprincipal.puempresa;
      FormConsulta.qConsulta.ParamByName('loca').AsInteger:= formprincipal.pulocal;
      FormConsulta.titulo.Caption:= 'Consulta Tipos de Entidade';
      retorno:= 'C�digo';
      formconsulta.qconsulta.sql.Add('order by tien_codi');
      FormConsulta.qConsulta.Open;
      FormConsulta.ShowModal;
    end else
  if tabela = 'cons_produto' then
    begin
      FormConsulta.qConsulta.SQL.Text:= 'select prod_codi as "C�digo", '+
                                        'cast(prod_desc as varchar(80)) as "Descri��o", '+
                                        '(select saldo from movimento.vw_esto w where w.prod_codi = p.prod_codi) as "Saldo" '+
                                        'from cadastro.prod p where prod_empr = :empr and prod_loca = :loca';
      FormConsulta.qConsulta.ParamByName('empr').AsInteger:= formprincipal.puempresa;
      FormConsulta.qConsulta.ParamByName('loca').AsInteger:= formprincipal.pulocal;
      FormConsulta.titulo.Caption:= 'Consulta Produtos';
      retorno:= 'C�digo';
      formconsulta.qconsulta.sql.Add('order by prod_codi');
      FormConsulta.qConsulta.Open;
      FormConsulta.ShowModal;
    end else
  if tabela = 'cons_requisicao' then
    begin
      FormConsulta.qConsulta.SQL.Text:= 'select requ_codi as "C�digo", requ_tipo as "Tipo", '+
                                        'requ_quan as "Quantidade", requ_unit as "Unit�rio", '+
                                        'requ_tota as "Total" '+
                                        'from movimento.requ where requ_empr = :empr and requ_loca = :loca';
      FormConsulta.qConsulta.ParamByName('empr').AsInteger:= formprincipal.puempresa;
      FormConsulta.qConsulta.ParamByName('loca').AsInteger:= formprincipal.pulocal;
      FormConsulta.titulo.Caption:= 'Consulta Requisi��es';
      retorno:= 'C�digo';
      formconsulta.qconsulta.sql.Add('order by requ_codi');
      FormConsulta.qConsulta.Open;
      FormConsulta.ShowModal;
    end else
  if tabela = 'cons_centro' then
    begin
      FormConsulta.qConsulta.SQL.Text:= 'select cecu_codi as "C�digo", cecu_desc as "Descri��o" '+
                                        'from cadastro.cecu where cecu_empr = :empr and cecu_loca = :loca';
      FormConsulta.qConsulta.ParamByName('empr').AsInteger:= formprincipal.puempresa;
      FormConsulta.qConsulta.ParamByName('loca').AsInteger:= formprincipal.pulocal;
      FormConsulta.titulo.Caption:= 'Consulta Centro de Custos';
      retorno:= 'C�digo';
      formconsulta.qconsulta.sql.Add('order by cecu_codi');
      FormConsulta.qConsulta.Open;
      FormConsulta.ShowModal;
    end else
  if tabela = 'cons_empresa' then
    begin
      FormConsulta.qConsulta.SQL.Text:= 'select empr_codi as "C�digo", cast(empr_raza as varchar(80)) as "Descri��o", '+
                                        'cast(empr_cnpj as varchar(20)) as "CNPJ", '+
                                        'cast(empr_fone as varchar(15)) as "Telefone" '+
                                        'from cadastro.empr ';
      FormConsulta.titulo.Caption:= 'Consulta Empresa';
      retorno:= 'C�digo';
      formconsulta.qconsulta.sql.Add('order by empr_codi');
      FormConsulta.qConsulta.Open;
      FormConsulta.ShowModal;
    end else
  if tabela = 'cons_entidade' then
    begin
      FormConsulta.qConsulta.SQL.Text:= 'select enti_codi as "C�digo", cast(enti_desc as varchar(80)) as "Descri��o", '+
                                        'cast(enti_fone as varchar(15)) as "Telefone" '+
                                        'from cadastro.enti where enti_empr = :empr and enti_loca = :loca ';
      FormConsulta.qConsulta.ParamByName('empr').AsInteger:= formprincipal.puempresa;
      FormConsulta.qConsulta.ParamByName('loca').AsInteger:= formprincipal.pulocal;
      FormConsulta.titulo.Caption:= 'Consulta Entidades';
      retorno:= 'C�digo';
      formconsulta.qconsulta.sql.Add('order by enti_codi');
      FormConsulta.qConsulta.Open;
      FormConsulta.ShowModal;
    end else
  if tabela = 'cons_cidade' then
    begin
      FormConsulta.qConsulta.SQL.Text:= 'select cida_codi as "C�digo", cida_desc as "Descri��o", cast(cida_sigl as varchar(10)) as "Estado" '+
                                        'from cadastro.cida ';
      FormConsulta.titulo.Caption:= 'Consulta Cidades';
      retorno:= 'C�digo';
      formconsulta.qconsulta.sql.Add('order by cida_codi');
      FormConsulta.qConsulta.Open;
      FormConsulta.ShowModal;
    end else
  if tabela = 'cons_unidade' then
    begin
      FormConsulta.qConsulta.SQL.Text:= 'select unid_codi as "C�digo", unid_desc as "Descri��o", cast(unid_unid as varchar(10)) as "Unidade" '+
                                        'from cadastro.unid '+
                                        'where unid_empr = :empr and unid_loca = :loca';
      FormConsulta.titulo.Caption:= 'Consulta de Unidade de Medida';
      retorno:= 'C�digo';
      formconsulta.qconsulta.sql.Add('order by unid_codi');
      FormConsulta.qConsulta.ParamByName('empr').AsInteger:= formprincipal.puempresa;
      FormConsulta.qConsulta.ParamByName('loca').AsInteger:= formprincipal.pulocal;
      FormConsulta.qConsulta.Open;
      FormConsulta.ShowModal;
    end else
  if tabela = 'cons_pais' then
    begin
      FormConsulta.qConsulta.SQL.Text:= 'select pais_codi as "C�digo", pais_desc as "Descri��o", '+
                                        'cast(pais_nume as varchar(20)) as "C�digo Pa�s" '+
                                        'from cadastro.pais ';
      FormConsulta.titulo.Caption:= 'Consulta Pa�ses';
      retorno:= 'C�digo';
      formconsulta.qconsulta.sql.Add('order by pais_codi');
      FormConsulta.qConsulta.Open;
      FormConsulta.ShowModal;
    end else
  if tabela = 'cons_parametro' then
    begin
      FormConsulta.qConsulta.SQL.Text:= 'select para_codi as "C�digo", para_empr as "Empresa", '+
                                        'para_loca as "Local" '+
                                        'from cadastro.para ';
      FormConsulta.titulo.Caption:= 'Consulta Parametros';
      retorno:= 'C�digo';
      formconsulta.qconsulta.sql.Add('order by para_codi');
      FormConsulta.qConsulta.Open;
      FormConsulta.ShowModal;
    end else
  if tabela = 'cons_genero' then
    begin
      FormConsulta.qConsulta.SQL.Text:= 'select gene_codi as "C�digo", cast(upper(gene_desc) as varchar(90)) as "Descri��o" '+
                                        'from cadastro.gene ';
      FormConsulta.titulo.Caption:= 'Consulta Genero de Produtos';
      retorno:= 'C�digo';
      formconsulta.qconsulta.sql.Add('order by gene_codi');
      FormConsulta.qConsulta.Open;
      FormConsulta.ShowModal;
    end else
  if tabela = 'cons_requisicao' then
    begin
      FormConsulta.qConsulta.SQL.Text:= 'select requ_codi as "C�digo", '+
                                        'cast((select prod_desc from cadastro.prod where prod_codi = requ_prod) as varchar(80)) as "Produto", '+
                                        'cast(requ_tipo as varchar(20)) as "Tipo de Requisi��o" '+
                                        'from movimento.requ r '+
                                        'where requ_empr = :empr and requ_loca = :loca';
      FormConsulta.titulo.Caption:= 'Consulta Requisi��es';
      retorno:= 'C�digo';
      formconsulta.qconsulta.sql.Add('order by requ_codi');
      FormConsulta.qConsulta.ParamByName('empr').AsInteger:= formprincipal.puempresa;
      FormConsulta.qConsulta.ParamByName('loca').AsInteger:= formprincipal.pulocal;
      FormConsulta.qConsulta.Open;
      FormConsulta.ShowModal;
    end else
  if tabela = 'cons_produto' then
    begin
      FormConsulta.qConsulta.SQL.Text:= 'select prod_codi as "C�digo", prod_desc as "Descri��o" from cadastro.prod '+
                                        'where prod_empr = :empr and prod_loca = :loca';
      FormConsulta.titulo.Caption:= 'Consulta Produtos';
      retorno:= 'C�digo';
      formconsulta.qconsulta.sql.Add('order by prod_codi');
      FormConsulta.qConsulta.ParamByName('empr').AsInteger:= formprincipal.puempresa;
      FormConsulta.qConsulta.ParamByName('loca').AsInteger:= formprincipal.pulocal;
      FormConsulta.qConsulta.Open;
      FormConsulta.ShowModal;
    end else
  if tabela = 'cons_grupo' then
    begin
      FormConsulta.qConsulta.SQL.Text:= 'select grup_codi as "C�digo", grup_desc as "Descri��o" from cadastro.grup '+
                                        'where grup_empr = :empr and grup_loca = :loca';
      FormConsulta.titulo.Caption:= 'Consulta Grupos';
      retorno:= 'C�digo';
      formconsulta.qconsulta.sql.Add('order by grup_codi');
      FormConsulta.qConsulta.ParamByName('empr').AsInteger:= formprincipal.puempresa;
      FormConsulta.qConsulta.ParamByName('loca').AsInteger:= formprincipal.pulocal;
      FormConsulta.qConsulta.Open;
      FormConsulta.ShowModal;
    end else
  if tabela = 'cons_subgrupo' then
    begin
      FormConsulta.qConsulta.SQL.Text:= 'select sugr_codi as "C�digo", sugr_desc as "Descri��o" from cadastro.sugr '+
                                        'where sugr_empr = :empr and sugr_loca = :loca';
      FormConsulta.titulo.Caption:= 'Consulta Sub. Grupos';
      retorno:= 'C�digo';
      formconsulta.qconsulta.sql.Add('order by sugr_codi');
      FormConsulta.qConsulta.ParamByName('empr').AsInteger:= formprincipal.puempresa;
      FormConsulta.qConsulta.ParamByName('loca').AsInteger:= formprincipal.pulocal;
      FormConsulta.qConsulta.Open;
      FormConsulta.ShowModal;
    end;

  if retorno <> '' then
   begin
     result:= formconsulta.qConsulta.FieldByName(retorno).AsString;
   end;
  FormConsulta.Free;
end;
end.
