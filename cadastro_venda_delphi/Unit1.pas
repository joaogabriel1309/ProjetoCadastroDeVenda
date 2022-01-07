unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.Grids, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    page: TPageControl;
    cadastro: TTabSheet;
    EDT_CODIGO: TEdit;
    EDT_NOME: TEdit;
    EDT_DATA: TEdit;
    EDT_VALOR: TEdit;
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    StringGrid1: TStringGrid;
    EDT_QUANTIDADE: TEdit;
    EDT_VALOR_UNITARIO: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    EDT_PRODUTO: TEdit;
    Button3: TButton;
    Label8: TLabel;
    BitBtn1: TBitBtn;
    Timer1: TTimer;
    compra: TTabSheet;
    StringGrid2: TStringGrid;
    BitBtn2: TBitBtn;
    Button2: TButton;
    Button4: TButton;
    procedure Button1Click(Sender: TObject);
    function SoLetras(Nome: string): string;
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure StringGrid1DblClick(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    function verificaproduto(produto: string): Integer;
    procedure Button2Click(Sender: TObject);
    procedure StringGrid2DblClick(Sender: TObject);
    function somar(VALOR: Integer):Integer;
    procedure Button4Click(Sender: TObject);

  private
    procedure LimparCampos;
    procedure Adicionar(index: Integer);
    procedure LimpaStringrid;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  FarraMult_Itens_da_Venda: array[1..100,1..5]of string;
  FarraMult_Informacao_da_compra: array[1..10,1..4]of string;
  FCODIGO: Integer;
  Data: string;
const
   CNT_PRODUTO = 0;
   CNT_QUANTIDADE = 1;
   CNT_VALORUNITARIO = 2;
   CNT_VALORTOTAL = 3;
   CNT_VALOR = 1;
   CNT_NULO = '';
implementation

{$R *.dfm}
//click do botão finilizar
procedure TForm1.BitBtn2Click(Sender: TObject);
var
  I,J,K: Integer;
  VALOR_TOTAL: Currency;
begin
   k:=0;
   VALOR_TOTAL:= 0;
   if ((EDT_NOME.Text) = '') then
   begin
      MessageDlg('Por favor, Insira o nome do cliente',mtError,[mbOK],0);
      exit;
   end;
   for J := 1 to High(FarraMult_Itens_da_Venda) do
   begin
      if (FarraMult_Itens_da_Venda[J,1] = '') then
      begin
         for I := J to (Pred(StringGrid1.RowCount)+J)-1 do
         begin
            inc(K);
            FarraMult_Itens_da_Venda[I,2]:= StringGrid1.Cells[CNT_PRODUTO, k];
            FarraMult_Itens_da_Venda[I,3]:= StringGrid1.Cells[CNT_QUANTIDADE, k];
            FarraMult_Itens_da_Venda[I,4]:= StringGrid1.Cells[CNT_VALORUNITARIO, k];
            FarraMult_Itens_da_Venda[I,5]:= StringGrid1.Cells[CNT_VALORTOTAL, k];
            VALOR_TOTAL:= VALOR_TOTAL + StrToCurr(FarraMult_Itens_da_Venda[I,5]);
            FarraMult_Itens_da_Venda[I,1]:= IntToStr(FCODIGO);
         end;
         break;
      end;
   end;
   if (StringGrid2.Cells[0, StringGrid2.RowCount-1] <> '') then
      StringGrid2.RowCount :=  StringGrid2.RowCount + 1;
   StringGrid2.Cells[0, FCODIGO]:= IntToStr(FCODIGO);
   StringGrid2.Cells[1, FCODIGO]:= EDT_NOME.Text;
   StringGrid2.Cells[2, FCODIGO]:= Data;
   StringGrid2.Cells[3, FCODIGO]:= CurrToStr(VALOR_TOTAL);
   FarraMult_Informacao_da_compra[FCODIGO,1]:= StringGrid2.Cells[0, FCODIGO];
   FarraMult_Informacao_da_compra[FCODIGO,2]:= StringGrid2.Cells[1, FCODIGO];
   FarraMult_Informacao_da_compra[FCODIGO,3]:= StringGrid2.Cells[2, FCODIGO];
   FarraMult_Informacao_da_compra[FCODIGO,4]:= StringGrid2.Cells[3, FCODIGO];
   MessageDlg('Compra Finalizada com sucesso!',mtConfirmation,[mbOK],0);
   LimpaStringrid;
   StringGrid1.RowCount := 2;
   EDT_NOME.Clear;
   LimparCampos;
   EDT_NOME.SetFocus;
   inc(FCODIGO)
end;

//click do botão adicionar
procedure TForm1.Button1Click(Sender: TObject);
var CAL_VALOR_TOTAL: Currency;
   index: Integer;
begin
   if (trim(EDT_PRODUTO.Text) = '') or (trim(EDT_QUANTIDADE.Text) = '') or (trim(EDT_VALOR_UNITARIO.Text) = '')then
   begin
      MessageDlg('Por favor, Insira todos os valores',mtError,[mbOK],0);
      exit;
   end;
   if (StringGrid1.Cells[CNT_PRODUTO, StringGrid1.RowCount-1] <> '') then
   begin
      StringGrid1.RowCount :=  StringGrid1.RowCount + 1;
      index:= StringGrid1.RowCount - 1;
   end
   else
      index := 1;
   CAL_VALOR_TOTAL:= StrToCurr(EDT_QUANTIDADE.Text) * StrToCurr(EDT_VALOR_UNITARIO.Text);
   StringGrid1.Cells[CNT_PRODUTO, index] := EDT_PRODUTO.Text;
   Adicionar(index);
   LimparCampos;
end;
//alterar produtos
procedure TForm1.Button2Click(Sender: TObject);
var RCB_INDEX_EXISTENTE: Integer;
begin

   RCB_INDEX_EXISTENTE:= verificaproduto(EDT_PRODUTO.Text);
   if (RCB_INDEX_EXISTENTE = -1) then
      MessageDlg('Produto não encontrado',mtError,[mbOK],0);
   Adicionar(RCB_INDEX_EXISTENTE);
   EDT_PRODUTO.Enabled:=true;
   LimparCampos;
   Button1.Enabled := true;
   Button2.Enabled := false;
end;

procedure TForm1.LimparCampos;
begin
   EDT_PRODUTO.Clear;
   EDT_QUANTIDADE.Clear;
   EDT_VALOR_UNITARIO.Clear;
   EDT_PRODUTO.SetFocus;
end;

procedure TForm1.Adicionar(index: integer);
begin
  StringGrid1.Cells[CNT_QUANTIDADE, index] := EDT_QUANTIDADE.Text;
  StringGrid1.Cells[CNT_VALORUNITARIO, index] := EDT_VALOR_UNITARIO.Text;
  StringGrid1.Cells[CNT_VALORTOTAL, index] := CurrToStr(StrToCurr(StringGrid1.Cells[CNT_QUANTIDADE, index]) * StrToCurr(StringGrid1.Cells[CNT_VALORUNITARIO, index]));
end;

procedure TForm1.LimpaStringrid;
var
  O: Integer;
begin
  with StringGrid1 do
    for o := 1 to RowCount - 1 do
      Rows[o].Clear;
end;

//ordenação de stringrid
procedure TForm1.Button3Click(Sender: TObject);
var
  J,I,U: Integer;
  auxiliar: string;
begin
   for I := 1 to 9 do
   begin
      for j := i + 1 to 10 do
      begin
         if (FarraMult_Itens_da_Venda[J,1] <> '') then
         begin
            if (FarraMult_Itens_da_Venda[i, 1]) > (FarraMult_Itens_da_Venda[j, 1]) then
            begin
               FarraMult_Itens_da_Venda[I,1] := FarraMult_Itens_da_Venda[j, 1];
               FarraMult_Itens_da_Venda[j, 1] := FarraMult_Itens_da_Venda[i, 1];
               FarraMult_Itens_da_Venda[i, 1] := auxiliar;
               auxiliar := FarraMult_Itens_da_Venda[j, 2];
               FarraMult_Itens_da_Venda[j, 2] := FarraMult_Itens_da_Venda[i, 2];
               FarraMult_Itens_da_Venda[i, 2] := auxiliar;
               auxiliar := FarraMult_Itens_da_Venda[j, 3];
               FarraMult_Itens_da_Venda[j, 3] := FarraMult_Itens_da_Venda[i, 3];
               FarraMult_Itens_da_Venda[i, 3] := auxiliar;
            end;
         end;
      end;
      for u := 1 to 10 do
      begin
         StringGrid1.Cells[0, u] := FarraMult_Itens_da_Venda[u, 1];
         StringGrid1.Cells[1, u] := FarraMult_Itens_da_Venda[u, 2];
         StringGrid1.Cells[2, u] := FarraMult_Itens_da_Venda[u, 3];
      end;
   end;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
   EDT_NOME.Clear;
   EDT_CODIGO.Clear;
   EDT_DATA.Clear;
   EDT_VALOR.Clear;
   LimpaStringrid;
   EDT_PRODUTO.Enabled:= true;
   LimparCampos;
   Button1.Enabled:= true;
   Button2.Enabled:= true;
   BitBtn2.Enabled:= true;
   EDT_PRODUTO.Enabled := true;
   EDT_QUANTIDADE.Enabled := true;
   EDT_VALOR_UNITARIO.Enabled := true;
   EDT_NOME.Enabled:= true;
   Button4.Enabled:= false;
   EDT_NOME.SetFocus;
   StringGrid1.RowCount := 2;
end;

//instancia valores na criação do formulario
procedure TForm1.FormCreate(Sender: TObject);
begin
   FCODIGO:= 1;
   Button4.Enabled:= false;
   Button2.Enabled:= false;
   StringGrid1.Cells[CNT_PRODUTO, 0] := 'Produto';
   StringGrid1.Cells[CNT_QUANTIDADE, 0] := 'Quantidade';
   StringGrid1.Cells[CNT_VALORUNITARIO, 0] := 'Valor Unitario';
   StringGrid1.Cells[CNT_VALORTOTAL, 0] := 'Valor Total';
   StringGrid1.ColWidths[CNT_PRODUTO] := 200;
   StringGrid1.ColWidths[CNT_QUANTIDADE] := 70;
   StringGrid1.ColWidths[CNT_VALORUNITARIO] := 150;
   StringGrid1.ColWidths[CNT_VALORTOTAL] := 150;

   StringGrid2.Cells[0, 0] := 'Codigo';
   StringGrid2.Cells[1, 0] := 'Nome do cliente';
   StringGrid2.Cells[2, 0] := 'Data e hora';
   StringGrid2.Cells[3, 0] := 'Valor total';
   StringGrid2.ColWidths[0] := 50;
   StringGrid2.ColWidths[1] := 300;
   StringGrid2.ColWidths[2] := 200;
   StringGrid2.ColWidths[3] := 140;
end;

//função para tirar espacoes em branco
function TForm1.SoLetras(Nome: string): string;
const
   vazio = '';
   espaco = ' ';
begin
   Result:= StringReplace(Nome,espaco,vazio,[rfReplaceAll]);
end;

//dois click para abri produtos na stringrid
procedure TForm1.StringGrid1DblClick(Sender: TObject);
begin
   Button1.Enabled:= false;
   EDT_PRODUTO.Enabled:= false;
   Button2.Enabled:= true;
   if (StringGrid1.Row <> 0) then
   begin
      EDT_PRODUTO.Text:= StringGrid1.Cells[CNT_PRODUTO,StringGrid1.Row];
   end;
   if (StringGrid1.Row <> 0) then
   begin
      EDT_QUANTIDADE.Text:= StringGrid1.Cells[CNT_QUANTIDADE,StringGrid1.Row];
   end;
   if (StringGrid1.Row <> 0) then
   begin
      EDT_VALOR_UNITARIO.Text:= StringGrid1.Cells[CNT_VALORUNITARIO,StringGrid1.Row];
   end;
end;

procedure TForm1.StringGrid2DblClick(Sender: TObject);
var
  I,J: Integer;
begin
   Button4.Enabled:= true;
   page.TabIndex := 0;
   LimpaStringrid;
   J:= 1;
   Button1.Enabled:= false;
   Button2.Enabled:= false;
   BitBtn2.Enabled:= false;
   EDT_PRODUTO.Enabled := False;
   EDT_QUANTIDADE.Enabled := False;
   EDT_VALOR_UNITARIO.Enabled := False;
   EDT_NOME.Enabled:= False;
   EDT_CODIGO.Text := FarraMult_Informacao_da_compra[StringGrid2.Row,1];
   EDT_NOME.Text := FarraMult_Informacao_da_compra[StringGrid2.Row,2];
   EDT_DATA.Text := FarraMult_Informacao_da_compra[StringGrid2.Row,3];
   EDT_VALOR.Text := FarraMult_Informacao_da_compra[StringGrid2.Row,4];
   for I := 1 to High(FarraMult_Itens_da_Venda) do
   begin
      if (FarraMult_Informacao_da_compra[StringGrid2.Row,1] = FarraMult_Itens_da_Venda[I,1]) then
      begin
         if (StringGrid1.Cells[0, StringGrid1.RowCount-1] <> '') then
            StringGrid1.RowCount :=  StringGrid1.RowCount + 1;
         StringGrid1.Cells[CNT_PRODUTO, J]:= FarraMult_Itens_da_Venda[I,2];
         StringGrid1.Cells[CNT_QUANTIDADE, J] := FarraMult_Itens_da_Venda[I,3];
         StringGrid1.Cells[CNT_VALORUNITARIO, J] := FarraMult_Itens_da_Venda[I,4];
         StringGrid1.Cells[CNT_VALORTOTAL, J] := FarraMult_Itens_da_Venda[I,5];
         inc(J);
      end;
   end;
end;

//data e hora atualizada
procedure TForm1.Timer1Timer(Sender: TObject);
begin
  Data := DateTimeToStr(now);
end;

//função para retornar se existe produtos
function TForm1.verificaproduto(produto: string): Integer;
var I: integer;
begin
   Result:= -1;
   produto:= SoLetras(Produto);
   for I := 1 to 10 do
   begin
      if (UpperCase(produto)) = UpperCase(StringGrid1.Cells[CNT_PRODUTO, i]) then
      begin
         Result:=(i);
         break;
      end;
   end;
end;

function TForm1.somar(VALOR: Integer): Integer;
begin
   Result:= Valor + 1;
end;
end.
