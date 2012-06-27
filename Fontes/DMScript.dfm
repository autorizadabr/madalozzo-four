object DMScriptAtualizacao: TDMScriptAtualizacao
  OldCreateOrder = False
  Left = 477
  Top = 319
  Height = 324
  Width = 889
  object UniQueryVersaoInstalada: TUniQuery
    Connection = dmDados.database
    SQL.Strings = (
      'select versao, data'
      '  from versao'
      ' where versao = (select max(versao)'
      '                   from versao)')
    Left = 63600
    Top = 8
    object UniQueryVersaoInstaladaversao: TIntegerField
      FieldName = 'versao'
      Required = True
    end
    object UniQueryVersaoInstaladadata: TDateTimeField
      FieldName = 'data'
      Required = True
    end
  end
  object UniScriptInicializacao: TUniScript
    SQL.Strings = (
      'create table versao ('
      '    versao integer not null,'
      '    data timestamp not null default current_timestamp,'
      '    constraint pk_versao primary key(versao)        '
      ');'
      ''
      'insert into versao (versao) values (0);')
    OnError = UniScriptInicializacaoError
    Connection = dmDados.database
    Left = 63728
    Top = 7
  end
  object EvCompCollector1: TEvCompCollector
    Left = 64
    Top = 7
  end
  object UniScriptVersao0001: TUniScript
    Tag = 5042012
    SQL.Strings = (
      'create LANGUAGE '#39'plpgsql'#39';')
    OnError = UniScriptInicializacaoError
    Connection = dmDados.database
    Left = 64
    Top = 72
  end
  object UniScriptVersao0002: TUniScript
    Tag = 7042012
    SQL.Strings = (
      'alter table cadastro.para add para_auto_cep boolean;'
      'alter table cadastro.para add para_auto_enti boolean;'
      'alter table cadastro.para add para_rela_zebr boolean;')
    OnError = UniScriptInicializacaoError
    Connection = dmDados.database
    Left = 174
    Top = 71
  end
  object UniScriptVersao0003: TUniScript
    Tag = 7042012
    SQL.Strings = (
      'alter table cadastro.para add para_codi integer;')
    OnError = UniScriptInicializacaoError
    Connection = dmDados.database
    Left = 285
    Top = 67
  end
  object UniScriptVersao0004: TUniScript
    Tag = 7042012
    SQL.Strings = (
      'alter table cadastro.para add para_prox varchar(100);'
      'alter table cadastro.para add para_port integer;'
      'alter table cadastro.para add para_usua varchar(100);'
      'alter table cadastro.para add para_senh varchar(30);'
      'alter table cadastro.para add para_link varchar(100);'
      'alter table cadastro.para add para_form_donw integer;')
    OnError = UniScriptInicializacaoError
    Connection = dmDados.database
    Left = 392
    Top = 68
  end
  object UniScriptVersao0005: TUniScript
    Tag = 12042012
    SQL.Strings = (
      
        'CREATE OR REPLACE FUNCTION "movimento"."fnc_saldo_estoque"(v_emp' +
        'resa INTEGER, v_local integer, v_produto float8, v_data_final da' +
        'te)'
      '  RETURNS "pg_catalog"."float8" AS $BODY$'
      'declare rec record;'
      '        invent record;'
      '        v_saldo double precision;'
      'begin'
      ' v_saldo = 0;'
      ''
      ' for rec in'
      '        select * from movimento.vw_extr_movi '
      '         where data  <= v_data_final'
      '          and empresa = v_empresa'
      '          and local   = v_local '
      '          and prod_codi = v_produto'
      ''
      #9#9'loop'
      '       if rec.tipo = '#39'E'#39' then'
      '          v_saldo  = v_saldo + coalesce(rec.quan_entr,0);'
      '          --RAISE EXCEPTION '#39'Saldo %.'#39',v_saldo;'
      '       elsif rec.tipo = '#39'S'#39' then'
      
        '          v_saldo     = v_saldo - coalesce(abs(rec.quan_said),0)' +
        ';'
      '       end if;'
      '    end loop;'
      '    return v_saldo;'
      'end;'
      '$BODY$'
      '  LANGUAGE '#39'plpgsql'#39' VOLATILE COST 100'
      ';'
      ''
      ''
      ''
      
        'CREATE OR REPLACE FUNCTION fnc_extratro_movimento(p_empresa inte' +
        'ger, p_local integer, p_produto numeric, p_data_fina date)'
      ' RETURNS SETOF record AS $$'
      'DECLARE'
      '   rec record;'
      '   v_saldo_anterior numeric;'
      '   v_produto numeric;'
      'BEGIN'
      '   v_saldo_anterior = 0;'
      ''
      '   '
      '   -- com produto/ com local'
      '   if (p_produto > 0) and (p_local > 0) then '
      '   for rec in '
      '      select empresa,'
      '             local,'
      '             titulo,'
      '             data,'
      '             cast(serie as varchar) as "serie",'
      '             cast(prod_codi as numeric) as "prod_codi",'
      '             prod_desc,'
      '             cast(quan_entr as numeric) as "quan_entr",'
      '             cast(quan_said as numeric) as "quan_said",'
      #9#9#9'       cast(tipo as varchar) as "tipo",'
      '             cast(valor as numeric) as "valor",'
      '             cast(0 as numeric(20,2)) as "saldo_anterior",'
      '             cast(0 as numeric(20,2)) as "saldo_atual"'
      '       from movimento.vw_extr_movi'
      '   '#9'   WHERE empresa   = p_empresa'
      #9'       and local     = p_local'
      #9'       and prod_codi = p_produto'
      #9'       and data <= p_data_fina'
      '       order by empresa, local, data, prod_codi'
      ''
      '    loop'
      '     if v_produto <> rec.prod_codi then '
      
        '        v_saldo_anterior = (select movimento.fnc_saldo_estoque(r' +
        'ec.empresa, rec.local, rec.prod_codi, p_data_inic)); '
      '        v_produto = rec.prod_codi;'
      '     end if;'
      #9
      '    rec.saldo_anterior = v_saldo_anterior;'
      '--        RAISE EXCEPTION '#39'Saldo %.'#39',rec.saldo_anterior;'
      '      if rec.tipo = '#39'E'#39' then '
      '        rec.saldo_atual = v_saldo_anterior + rec.quan_entr;'
      
        '--        RAISE EXCEPTION '#39'Saldo anterior %.'#39',rec.saldo_anterior' +
        ';'
      '        v_saldo_anterior = v_saldo_anterior + rec.quan_entr;'
      
        '--        RAISE EXCEPTION '#39'v_Saldo anterior %.'#39',v_saldo_anterior' +
        ';'
      '      return next rec;'
      '      else'
      '        rec.saldo_atual = v_saldo_anterior - rec.quan_said; '
      '--        RAISE EXCEPTION '#39'Saldo atual %.'#39',rec.saldo_atual;'
      '        v_saldo_anterior = v_saldo_anterior - rec.quan_said;'
      
        '--        RAISE EXCEPTION '#39'v_Saldo anterior %.'#39',v_saldo_anterior' +
        ';'
      '      return next rec;'
      '      end if;'
      '    end loop;'
      ''
      '   elseif (p_produto = 0) and (p_local = 0) then '
      '   for rec in '
      '      select empresa,'
      '             local,'
      '             titulo,'
      '             data,'
      '             cast(serie as varchar) as "serie",'
      '             cast(prod_codi as numeric) as "prod_codi",'
      '             prod_desc,'
      '             cast(quan_entr as numeric) as "quan_entr",'
      '             cast(quan_said as numeric) as "quan_said",'
      #9#9#9'       cast(tipo as varchar) as "tipo",'
      '             cast(valor as numeric) as "valor",'
      '             cast(0 as numeric(20,2)) as "saldo_anterior",'
      '             cast(0 as numeric(20,2)) as "saldo_atual"'
      '       from movimento.vw_extr_movi'
      '   '#9'   WHERE empresa   = p_empresa'
      #9'       and data <= p_data_fina'
      '       order by empresa, local, data, prod_codi'
      ''
      '    loop'
      '     if v_produto <> rec.prod_codi then '
      
        '        v_saldo_anterior = (select movimento.fnc_saldo_estoque(r' +
        'ec.empresa, rec.local, rec.prod_codi, p_data_inic)); '
      '        v_produto = rec.prod_codi;'
      '     end if;'
      #9
      '    rec.saldo_anterior = v_saldo_anterior;'
      '--        RAISE EXCEPTION '#39'Saldo %.'#39',rec.saldo_anterior;'
      '      if rec.tipo = '#39'E'#39' then '
      '        rec.saldo_atual = v_saldo_anterior + rec.quan_entr;'
      
        '--        RAISE EXCEPTION '#39'Saldo anterior %.'#39',rec.saldo_anterior' +
        ';'
      '        v_saldo_anterior = v_saldo_anterior + rec.quan_entr;'
      
        '--        RAISE EXCEPTION '#39'v_Saldo anterior %.'#39',v_saldo_anterior' +
        ';'
      '      return next rec;'
      '      else'
      '        rec.saldo_atual = v_saldo_anterior - rec.quan_said; '
      '--        RAISE EXCEPTION '#39'Saldo atual %.'#39',rec.saldo_atual;'
      '        v_saldo_anterior = v_saldo_anterior - rec.quan_said;'
      
        '--        RAISE EXCEPTION '#39'v_Saldo anterior %.'#39',v_saldo_anterior' +
        ';'
      '      return next rec;'
      '      end if;'
      '    end loop;'
      ''
      '   elseif (p_produto > 0) and (p_local = 0) then '
      '   for rec in '
      '      select empresa,'
      '             local,'
      '             titulo,'
      '             data,'
      '             cast(serie as varchar) as "serie",'
      '             cast(prod_codi as numeric) as "prod_codi",'
      '             prod_desc,'
      '             cast(quan_entr as numeric) as "quan_entr",'
      '             cast(quan_said as numeric) as "quan_said",'
      #9#9#9'       cast(tipo as varchar) as "tipo",'
      '             cast(valor as numeric) as "valor",'
      '             cast(0 as numeric(20,2)) as "saldo_anterior",'
      '             cast(0 as numeric(20,2)) as "saldo_atual"'
      '       from movimento.vw_extr_movi'
      '   '#9'   WHERE empresa = p_empresa'
      '         and prod_codi = p_produto'
      #9'       and data <= p_data_fina'
      '       order by empresa, local, data, prod_codi'
      ''
      '    loop'
      '     if v_produto <> rec.prod_codi then '
      
        '        v_saldo_anterior = (select movimento.fnc_saldo_estoque(r' +
        'ec.empresa, rec.local, rec.prod_codi, p_data_inic)); '
      '        v_produto = rec.prod_codi;'
      '     end if;'
      #9
      '    rec.saldo_anterior = v_saldo_anterior;'
      '--        RAISE EXCEPTION '#39'Saldo %.'#39',rec.saldo_anterior;'
      '      if rec.tipo = '#39'E'#39' then '
      '        rec.saldo_atual = v_saldo_anterior + rec.quan_entr;'
      
        '--        RAISE EXCEPTION '#39'Saldo anterior %.'#39',rec.saldo_anterior' +
        ';'
      '        v_saldo_anterior = v_saldo_anterior + rec.quan_entr;'
      
        '--        RAISE EXCEPTION '#39'v_Saldo anterior %.'#39',v_saldo_anterior' +
        ';'
      '      return next rec;'
      '      else'
      '        rec.saldo_atual = v_saldo_anterior - rec.quan_said; '
      '--        RAISE EXCEPTION '#39'Saldo atual %.'#39',rec.saldo_atual;'
      '        v_saldo_anterior = v_saldo_anterior - rec.quan_said;'
      
        '--        RAISE EXCEPTION '#39'v_Saldo anterior %.'#39',v_saldo_anterior' +
        ';'
      '      return next rec;'
      '      end if;'
      '    end loop;'
      ''
      '   elseif (p_produto = 0) and (p_local > 0) then '
      '   for rec in '
      '      select empresa,'
      '             local,'
      '             titulo,'
      '             data,'
      '             cast(serie as varchar) as "serie",'
      '             cast(prod_codi as numeric) as "prod_codi",'
      '             prod_desc,'
      '             cast(quan_entr as numeric) as "quan_entr",'
      '             cast(quan_said as numeric) as "quan_said",'
      #9#9#9'       cast(tipo as varchar) as "tipo",'
      '             cast(valor as numeric) as "valor",'
      '             cast(0 as numeric(20,2)) as "saldo_anterior",'
      '             cast(0 as numeric(20,2)) as "saldo_atual"'
      '       from movimento.vw_extr_movi'
      '   '#9'   WHERE empresa = p_empresa'
      '         and local = p_local'
      #9'       and data <= p_data_fina'
      '       order by empresa, local, data, prod_codi'
      ''
      '    loop'
      '     if v_produto <> rec.prod_codi then '
      
        '        v_saldo_anterior = (select movimento.fnc_saldo_estoque(r' +
        'ec.empresa, rec.local, rec.prod_codi, p_data_inic)); '
      '        v_produto = rec.prod_codi;'
      '     end if;'
      #9
      '    rec.saldo_anterior = v_saldo_anterior;'
      '--        RAISE EXCEPTION '#39'Saldo %.'#39',rec.saldo_anterior;'
      '      if rec.tipo = '#39'E'#39' then '
      '        rec.saldo_atual = v_saldo_anterior + rec.quan_entr;'
      
        '--        RAISE EXCEPTION '#39'Saldo anterior %.'#39',rec.saldo_anterior' +
        ';'
      '        v_saldo_anterior = v_saldo_anterior + rec.quan_entr;'
      
        '--        RAISE EXCEPTION '#39'v_Saldo anterior %.'#39',v_saldo_anterior' +
        ';'
      '      return next rec;'
      '      else'
      '        rec.saldo_atual = v_saldo_anterior - rec.quan_said; '
      '--        RAISE EXCEPTION '#39'Saldo atual %.'#39',rec.saldo_atual;'
      '        v_saldo_anterior = v_saldo_anterior - rec.quan_said;'
      
        '--        RAISE EXCEPTION '#39'v_Saldo anterior %.'#39',v_saldo_anterior' +
        ';'
      '      return next rec;'
      '      end if;'
      '    end loop;'
      '   end if;'
      '   '
      'END;'
      '$$'
      '  LANGUAGE '#39'plpgsql'#39' VOLATILE COST 100'
      ' ROWS 1000;')
    OnError = UniScriptInicializacaoError
    Connection = dmDados.database
    Left = 512
    Top = 67
  end
end
