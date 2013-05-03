unit MainU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Label1: TLabel;
    Button1: TButton;
    SaveDialog1: TSaveDialog;
    Edit1: TEdit;
    Label2: TLabel;
    Button2: TButton;
    Edit2: TEdit;
    UpDown1: TUpDown;
    Button3: TButton;
    OpenDialog1: TOpenDialog;
    Button4: TButton;
    Label3: TLabel;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Label4: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  SaveDialog1.Title:='Задайте имя файла'; // Изменение заголовка окна диалога
  if SaveDialog1.Execute then
  Edit1.Text:=SaveDialog1.FileName;
end;
//-------------------------------------------------------

procedure TForm1.Button2Click(Sender: TObject);
var f: file of real; n,i: integer; r: real;
begin
  n:=UpDown1.Position;
  AssignFile(f, Edit1.Text);
  try
    Rewrite(f);
    for i:=1 to n do
    begin
      r:= (-(199+99+1)+Random(599+99+1))/10;
      write(f, r);
    end;
    CloseFile(f);
  except
    ShowMessage('Не удалось создать файл '+ Edit1.Text);
  end;
end;
//--------------------------------------

procedure TForm1.Button3Click(Sender: TObject);
var
  ftext: TextFile;
  ftyp: file of real;
  r: real;
begin
 if OpenDialog1.Execute then
 begin
  AssignFile(ftext, OpenDialog1.FileName);
  AssignFile(ftyp, Edit1.Text);
  try
    Reset(ftext);
    try
      try
        Rewrite(ftyp);
        try
          while not seekeof(ftext) do
          begin
            readln(ftext, r);
            write(ftyp,r);
          end;
        finally
          CloseFile(ftyp);
        end;
      except
        ShowMessage('Не удалось создать типизированный файл '+ Edit1.Text);
      end;
    finally
      CloseFile(ftext);
    end;
  except
    ShowMessage('Не удалось открыть текстовый файл '+ OpenDialog1.FileName);

  end;
 end
 else
  ShowMessage('Текстовый файл не задан!');
  
end;

//--------------------------------------------------------------------

procedure TForm1.Button5Click(Sender: TObject);

var
  f: file of real;
  min,rn: real;
  n: word;
begin
  AssignFile(f, Edit1.Text);
  try
    Reset(f);
      try
        n:=FileSize(f);
        seek(f, n-1);
        read(f, min);
        seek(f, 5 );//perehod k 6
        read(f, rn);
        seek(f, n-1);
        write(f, rn );
        seek(f,5);
        write(f, min);

        ShowMessage('Числа переставлены!');
      finally
        CloseFile(f);
      end;
  except
    ShowMessage('Не удалось открыть типизированный файл '+ Edit1.Text);
  end;
end;

//-----------------------------------------------------

procedure TForm1.Button6Click(Sender: TObject);
begin
Form1.Close;
end;
//--------------------------------------------------
//что в файле

procedure TForm1.Button7Click(Sender: TObject);

var
  f: file of real;
  r: real;
begin
  AssignFile(f, Edit1.Text);
  try
    Reset(f);
      try
        Memo1.Clear;
        while not eof(f) do
        begin
         read(f, r);
         Memo1.Lines.Add(FloatToStrF(r, ffFixed, 5,1));
        end;
      finally
        CloseFile(f);
      end;
  except
    ShowMessage('Не удалось открыть типизированный файл '+ Edit1.Text);
  end;
end;
//---------------------------------------------------------


procedure TForm1.Button4Click(Sender: TObject);

var  f: file of real; r,min:real;
  n,c,k,i:integer;
begin
AssignFile(f, Edit1.Text);
  try
    Reset(f);
      try
        if eof(f)  then ShowMessage('Файл пуст') else
          begin  read(f,min);n:=1;
         while not eof(f)  do
         begin
          read(f,r);
         if (r<=min) then
         begin min:=r; n:=FilePos(f); end;
         end;
       Label4.Caption:=Inttostr(n);
         end;
          finally
        CloseFile(f);
      end;
  except
    ShowMessage('Не удалось открыть типизированный файл '+ Edit1.Text);
  end;
end;



end.











