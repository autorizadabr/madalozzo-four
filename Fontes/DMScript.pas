(*
   DEUS SEJA LOUVADO, SEMPRE!

   Spartacus Gerente de Custos
   Programa: Scripts para atualizar o banco de dados.

   Autor   : Rinaldo Tavares de Almeida.
*)
unit DMScript;

interface

uses
  SysUtils, Classes, DB, MemDS, DBAccess, Uni, DAScript, UniScript, ECmpCol;

type
  TDMScriptAtualizacao = class(TDataModule)
    UniQueryVersaoInstalada: TUniQuery;
    UniQueryVersaoInstaladaversao: TIntegerField;
    UniQueryVersaoInstaladadata: TDateTimeField;
    UniScriptInicializacao: TUniScript;
    EvCompCollector1: TEvCompCollector;
    UniScriptVersao0001: TUniScript;
    UniScriptVersao0002: TUniScript;
    UniScriptVersao0003: TUniScript;
    UniScriptVersao0004: TUniScript;
    UniScriptVersao0005: TUniScript;
    procedure UniScriptInicializacaoError(Sender: TObject; E: Exception;
      SQL: String; var Action: TErrorAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DMScriptAtualizacao: TDMScriptAtualizacao;

implementation

uses  prog0003;


{$R *.dfm}

procedure TDMScriptAtualizacao.UniScriptInicializacaoError(Sender: TObject;
  E: Exception; SQL: String; var Action: TErrorAction);
begin
   Action := eaContinue;
end;

end.

