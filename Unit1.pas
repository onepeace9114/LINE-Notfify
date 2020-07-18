unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IPPeerClient, REST.Client, REST.Types,
  Data.Bind.Components, Data.Bind.ObjectScope, Vcl.StdCtrls, REST.Json;

type
  TForm1 = class(TForm)
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    btn1: TButton;
    mmo1: TMemo;
    lbl1: TLabel;
    edt1: TEdit;
    edt2: TEdit;
    btn2: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edtToken: TEdit;
    procedure btn1Click(Sender: TObject);
    procedure RESTRequest1AfterExecute(Sender: TCustomRESTRequest);
    procedure RESTRequest1HTTPProtocolError(Sender: TCustomRESTRequest);
    procedure btn2Click(Sender: TObject);
    procedure edtTokenChange(Sender: TObject);
  private
    function FilePathToURL(const FilePath: string): string;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses System.JSON, ComObj, WinInet, ShLwApi;

{$R *.dfm}

procedure TForm1.btn1Click(Sender: TObject);
var
  ARestParam: TRESTRequestParameter;
begin
  RESTClient1.BaseURL := 'https://notify-api.line.me/api/notify';
  RESTClient1.ContentType := 'application/x-www-form-urlencoded';
  RESTRequest1.Method := rmPOST;

  RESTClient1.Params.Clear;

  ARestParam :=  RESTClient1.Params.AddItem;
  ARestParam.name := 'Authorization';
  ARestParam.Kind := pkHTTPHEADER;
  ARestParam.Options := [poDoNotEncode];

  ARestParam.Value := 'Bearer ' + edtToken.Text;

  ARestParam :=  RESTClient1.Params.AddItem;
  ARestParam.name := 'message';
  ARestParam.Kind := pkGETorPOST;
  ARestParam.Options := [];

  ARestParam.Value := edt1.Text;

  RESTRequest1.Execute;
end;

procedure TForm1.btn2Click(Sender: TObject);
var
  ARestParam: TRESTRequestParameter;
  imgFile: string;
begin
  RESTClient1.BaseURL := 'https://notify-api.line.me/api/notify';
  RESTClient1.ContentType := 'application/x-www-form-urlencoded';
  RESTRequest1.Method := rmPOST;

  RESTClient1.Params.Clear;

  ARestParam :=  RESTClient1.Params.AddItem;
  ARestParam.name := 'Authorization';
  ARestParam.Kind := pkHTTPHEADER;
  ARestParam.Options := [poDoNotEncode];

  ARestParam.Value := 'Bearer ' + edtToken.Text;

  imgFile := FilePathToURL(edt2.Text);

  ARestParam :=  RESTClient1.Params.AddItem;
  ARestParam.name := 'message';
  ARestParam.Kind := pkGETorPOST;
  ARestParam.Options := [];
  ARestParam.Value := edt1.Text;

  ARestParam :=  RESTClient1.Params.AddItem;
  ARestParam.name := 'imageFile';
  ARestParam.Kind := pkFILE;
  ARestParam.Options := [];
  ARestParam.Value := imgFile;

  RESTRequest1.Execute;
end;

procedure TForm1.edtTokenChange(Sender: TObject);
begin
  btn1.Enabled := (edtToken.Text <> '') and (edt1.Text <> '');
  btn2.Enabled := (edtToken.Text <> '') and (edt1.Text <> '') and (edt2.Text <> '');
end;

function TForm1.FilePathToURL(const FilePath: string): string;
var
  BufferLen: DWORD;
begin
  BufferLen := INTERNET_MAX_URL_LENGTH;
  SetLength(Result, BufferLen);
  OleCheck(UrlCreateFromPath(PChar(FilePath), PChar(Result), @BufferLen, 0));
  SetLength(Result, BufferLen);
  Delete(Result, 1, 8);  // cut "file:///"
end;

procedure TForm1.RESTRequest1AfterExecute(Sender: TCustomRESTRequest);
begin
  mmo1.Lines.Clear;
  lbl1.Caption := 'URI: ' + Sender.GetFullRequestURL + ' Execution time: ' +
    IntToStr(Sender.ExecutionPerformance.TotalExecutionTime) + 'ms';

  if assigned(RESTResponse1.JSONValue) then
  begin
    mmo1.Lines.Text := TJson.Format(RESTResponse1.JSONValue)
  end
  else
  begin
    mmo1.Lines.Add(RESTResponse1.Content);
  end;
end;

procedure TForm1.RESTRequest1HTTPProtocolError(Sender: TCustomRESTRequest);
begin
  mmo1.Lines.Add(Sender.Response.StatusText);
  mmo1.Lines.Add(Sender.Response.Content);
end;

end.
