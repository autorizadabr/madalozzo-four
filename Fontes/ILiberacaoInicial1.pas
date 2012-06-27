// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://localhost/WebLicenca/Licenca.exe/wsdl/ILiberacaoInicial
// Version  : 1.0
// (25/04/2012 22:35:52 - - $Rev: 28374 $)
// ************************************************************************ //

unit ILiberacaoInicial1;

interface

uses InvokeRegistry, SOAPHTTPClient, Types, XSBuiltIns;

type

  // ************************************************************************ //
  // The following types, referred to in the WSDL document are not being represented
  // in this file. They are either aliases[@] of other types represented or were referred
  // to but never[!] declared in the document. The types from the latter category
  // typically map to predefined/known XML or Embarcadero types; however, they could also 
  // indicate incorrect WSDL documents that failed to declare or import a schema type.
  // ************************************************************************ //
  // !:string          - "http://www.w3.org/2001/XMLSchema"[]
  // !:boolean         - "http://www.w3.org/2001/XMLSchema"[]


  // ************************************************************************ //
  // Namespace : urn:LiberacaoInicialIntf-ILiberacaoInicial
  // soapAction: urn:LiberacaoInicialIntf-ILiberacaoInicial#%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : rpc
  // binding   : ILiberacaoInicialbinding
  // service   : ILiberacaoInicialservice
  // port      : ILiberacaoInicialPort
  // URL       : http://localhost/WebLicenca/Licenca.exe/soap/ILiberacaoInicial
  // ************************************************************************ //
  ILiberacaoInicial = interface(IInvokable)
  ['{ED4E4260-4AA1-2921-903F-DB320F5237A2}']
    function  liberacao(const cnpj: string): Boolean; stdcall;
    function  Registrado: string; stdcall;
  end;

function GetILiberacaoInicial(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): ILiberacaoInicial;


implementation
  uses SysUtils;

function GetILiberacaoInicial(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): ILiberacaoInicial;
const
  defWSDL = 'http://localhost/WebLicenca/Licenca.exe/wsdl/ILiberacaoInicial';
  defURL  = 'http://localhost/WebLicenca/Licenca.exe/soap/ILiberacaoInicial';
  defSvc  = 'ILiberacaoInicialservice';
  defPrt  = 'ILiberacaoInicialPort';
var
  RIO: THTTPRIO;
begin
  Result := nil;
  if (Addr = '') then
  begin
    if UseWSDL then
      Addr := defWSDL
    else
      Addr := defURL;
  end;
  if HTTPRIO = nil then
    RIO := THTTPRIO.Create(nil)
  else
    RIO := HTTPRIO;
  try
    Result := (RIO as ILiberacaoInicial);
    if UseWSDL then
    begin
      RIO.WSDLLocation := Addr;
      RIO.Service := defSvc;
      RIO.Port := defPrt;
    end else
      RIO.URL := Addr;
  finally
    if (Result = nil) and (HTTPRIO = nil) then
      RIO.Free;
  end;
end;


initialization
  InvRegistry.RegisterInterface(TypeInfo(ILiberacaoInicial), 'urn:LiberacaoInicialIntf-ILiberacaoInicial', '');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(ILiberacaoInicial), 'urn:LiberacaoInicialIntf-ILiberacaoInicial#%operationName%');

end.