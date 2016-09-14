unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, process, FileUtil, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, EditBtn,
  Buttons;

type

  { TForm1 }

  TForm1 = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    CheckBox1: TCheckBox;
    DirectoryEdit1: TDirectoryEdit;
    Label2: TLabel;
    Label3: TLabel;
    Memo1: TMemo;
    OpenDialog1: TOpenDialog;
    Panel1: TPanel;
    StatusBar1: TStatusBar;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure DirectoryEdit1Change(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then begin
    Memo1.Lines.Add(OpenDialog1.FileName);
    end;
  end;

procedure TForm1.BitBtn2Click(Sender: TObject);
var i:integer;P1:TProcess;S:String;
begin
for i:=0 to memo1.Lines.Count-1 do begin
 P1:=TProcess.Create(nil);
 P1.Executable:='pdftotext';
 P1.Parameters.Add(Memo1.Lines[i]);
 S:=ChangeFileExt(Memo1.Lines[i],'.txt');
 P1.Parameters.Add(S);
 P1.Options:=P1.Options + [poWaitOnExit];
 P1.Execute;
 P1.Free;
end;
MessageDlg(IntToStr(Memo1.Lines.Count)+' file(s) have been converted!',mtInformation,[mbOK],0);
Memo1.Lines.Clear;
end;

procedure TForm1.BitBtn3Click(Sender: TObject);
begin
Memo1.Lines.Clear;
FindAllFiles(Memo1.Lines,DirectoryEdit1.Directory,'*.pdf',CheckBox1.Checked);
end;

procedure TForm1.BitBtn4Click(Sender: TObject);
begin
Memo1.Lines.Clear;
end;

procedure TForm1.DirectoryEdit1Change(Sender: TObject);
begin
if DirectoryEdit1.Directory='' then begin
 BitBtn3.Enabled:=False;
end else begin
 Memo1.Lines.Clear;
 BitBtn3.Enabled:=True;
 FindAllFiles(Memo1.Lines,DirectoryEdit1.Directory,'*.pdf',CheckBox1.Checked);
 if Memo1.Lines.Count=0 then Memo1.Lines.Add('Nenhum arquivo pdf encontrado.');
end;
end;


end.

