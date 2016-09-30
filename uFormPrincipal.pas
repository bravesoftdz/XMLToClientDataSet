unit uFormPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, DB, DBClient, MSXML, IBODataset;

type
  TFormPrincipal = class(TForm)
    Memo1: TMemo;
    CDS1: TClientDataSet;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    btnFromNodes: TButton;
    btnAttributes: TButton;
    procedure btnAttributesClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnFromNodesClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

    XMLDoc : IXMLDOMDocument;

    procedure PrepareCDS;

    procedure LoadFromAttributes;

    procedure LoadFromNodes;

  end;

var
  FormPrincipal: TFormPrincipal;

implementation

{$R *.dfm}

const
  scXML =
     '<data a1="a" a2="b" a3="c">'#13#10 +
     '  <r1>11111</r1>'#13#10 +
     '  <r2>22222</r2>'#13#10 +
     '</data>';

   scRootNodeName = 'data';

procedure TFormPrincipal.btnAttributesClick(Sender: TObject);
begin
  LoadFromAttributes;
end;

procedure TFormPrincipal.btnFromNodesClick(Sender: TObject);
begin
  LoadFromNodes;
end;

procedure TFormPrincipal.FormCreate(Sender: TObject);
begin
  XmlDoc := CoDOMDocument.Create;
  XmlDoc.Async := False;
  XMLDoc.loadXML(scXML);
  Memo1.Lines.Text := scXML;
end;

procedure TFormPrincipal.LoadFromAttributes;
var
  sPathQuery : String;
  NodeList   : IXMLDOMNodeList;
  Node,
  AttrNode   : IXMLDOMNode;
  Attributes : IXMLDOMNamedNodeMap;
  Field      : TField;
  i          : Integer;
begin
  PrepareCDS;

  sPathQuery := scRootNodeName;
  NodeList := XMLDoc.SelectNodes(sPathQuery);
  Assert(NodeList.Length > 0);
  Node := NodeList.item[0];
  Attributes := Node.attributes;
  
  for i := 0 to Attributes.Length - 1 do
  begin
    AttrNode := Attributes.item[i];
    Field := TStringField.Create(Self);
    Field.Size := 80;
    Field.FieldName := AttrNode.nodeName;
    Field.DataSet := CDS1;
  end;

  CDS1.CreateDataSet;

  CDS1.Insert;
  for i := 0 to Attributes.Length - 1 do
  begin
    AttrNode := Attributes.item[i];
    CDS1.Fields[i].Value := AttrNode.nodeValue;
  end;
  CDS1.Post;
end;

procedure TFormPrincipal.LoadFromNodes;
var
  sPathQuery : String;
  NodeList   : IXmlDOMNodeList;
  Node,
  AttrNode   : IXMLDOMNode;
  Field      : TField;
  i          : Integer;
begin
  PrepareCDS;

  sPathQuery := scRootNodeName + '/*';
  NodeList := XMLDoc.SelectNodes(sPathQuery);
  Assert(NodeList.Length > 0);

  for i := 0 to NodeList.Length - 1 do
  begin
    Node := NodeList.item[i];
    Field := TStringField.Create(Self);
    Field.Size := 80;
    Field.FieldName := Node.nodeName;
    Field.DataSet := CDS1;
  end;

  CDS1.CreateDataSet;

  CDS1.Insert;
  
  for i := 0 to NodeList.Length - 1 do
  begin
    Node := NodeList.item[i];
    CDS1.Fields[i].Value := Node.Text;
  end;
  CDS1.Post;
end;

procedure TFormPrincipal.PrepareCDS;
begin
  if CDS1.Active then
    CDS1.Close;
    
  CDS1.FieldDefs.Clear;
  CDS1.Fields.Clear;
end;

end.
