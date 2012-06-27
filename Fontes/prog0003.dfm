object dmDados: TdmDados
  OldCreateOrder = False
  Left = 439
  Top = 251
  Height = 196
  Width = 321
  object database: TUniConnection
    ProviderName = 'PostgreSQL'
    Port = 5432
    Database = 'banco'
    Username = 'postgres'
    Password = '@spartacus201@'
    Server = 'localhost'
    Connected = True
    LoginPrompt = False
    Left = 56
    Top = 24
  end
  object provider: TPostgreSQLUniProvider
    Left = 56
    Top = 72
  end
  object nfe: TACBrNFe
    Configuracoes.Geral.PathSalvar = 'C:\Program Files (x86)\Embarcadero\RAD Studio\8.0\bin\'
    Configuracoes.WebServices.Visualizar = True
    Configuracoes.WebServices.UF = 'SP'
    Configuracoes.WebServices.AguardarConsultaRet = 0
    Configuracoes.WebServices.IntervaloTentativas = 0
    Configuracoes.WebServices.AjustaAguardaConsultaRet = False
    Configuracoes.Arquivos.PastaMensal = True
    OnStatusChange = nfeStatusChange
    DANFE = danfe
    Left = 104
    Top = 24
  end
  object danfe: TACBrNFeDANFeRL
    ACBrNFe = nfe
    Sistema = 'www.wmfsistemas.com'
    PathPDF = 'C:\Program Files (x86)\Embarcadero\RAD Studio\8.0\bin\'
    MostrarPreview = True
    MostrarStatus = True
    TipoDANFE = tiRetrato
    NumCopias = 1
    ImprimirDescPorc = False
    ImprimirTotalLiquido = False
    MargemInferior = 0.700000000000000000
    MargemSuperior = 0.700000000000000000
    MargemEsquerda = 0.700000000000000000
    MargemDireita = 0.700000000000000000
    CasasDecimais._qCom = 4
    CasasDecimais._vUnCom = 4
    ExibirResumoCanhoto = False
    FormularioContinuo = False
    TamanhoFonte_DemaisCampos = 10
    ProdutosPorPagina = 0
    ImprimirDetalhamentoEspecifico = True
    NFeCancelada = False
    LarguraCodProd = 54
    TamanhoFonte_RazaoSocial = 8
    ExibirEAN = False
    Left = 104
    Top = 72
  end
  object sqlaux: TUniQuery
    Connection = database
    CachedUpdates = True
    Left = 152
    Top = 24
  end
  object tbEmpr: TUniQuery
    Connection = database
    SQL.Strings = (
      'select *,'
      
        '      (select cida_desc from cadastro.cida where cida_codi = emp' +
        'r_cida) as "cida_desc",'
      
        '      (select cida_sigl from cadastro.cida where cida_codi = emp' +
        'r_cida) as "cida_sigl",'
      
        '      (select pais_desc from cadastro.pais where pais_codi = emp' +
        'r_pais) as "pais_desc",'
      
        '      (select pais_nume from cadastro.pais where pais_codi = emp' +
        'r_pais) as "pais_nume"'
      'from cadastro.empr where empr_codi = :codi')
    CachedUpdates = True
    Left = 150
    Top = 74
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'codi'
      end>
  end
  object quPara: TUniQuery
    Connection = database
    SQL.Strings = (
      
        'select * from cadastro.para where para_empr = :empr and para_loc' +
        'a = :loca')
    Left = 200
    Top = 24
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'empr'
      end
      item
        DataType = ftUnknown
        Name = 'loca'
      end>
  end
end
