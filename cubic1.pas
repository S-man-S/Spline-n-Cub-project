unit Cubic1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, ComCtrls, ColorBox, Menus, Grids, global, BuildingSLAU, Gauss, DrawInterpolatedLine, Draw, Work;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button10: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    ColorListBox1: TColorListBox;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    GroupBox6: TGroupBox;
    GroupBox7: TGroupBox;
    GroupBox8: TGroupBox;
    GroupBox9: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    LabeledEdit4: TLabeledEdit;
    LabeledEdit5: TLabeledEdit;
    LabeledEdit6: TLabeledEdit;
    LabeledEdit7: TLabeledEdit;
    LabeledEdit8: TLabeledEdit;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    PaintBox1: TPaintBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    RadioButton5: TRadioButton;
    RadioButton6: TRadioButton;
    StringGrid1: TStringGrid;
    Timer1: TTimer;
    TrackBar1: TTrackBar;
    UpDown1: TUpDown;
    UpDown2: TUpDown;
    UpDown3: TUpDown;
    UpDown4: TUpDown;
    UpDown5: TUpDown;
    UpDown6: TUpDown;
    UpDown7: TUpDown;
    UpDown8: TUpDown;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure CheckBox1Change(Sender: TObject);
    procedure CheckBox2Change(Sender: TObject);
    procedure CheckBox3Change(Sender: TObject);
    procedure CheckBox4Change(Sender: TObject);
    procedure ColorListBox1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure LabeledEdit1Change(Sender: TObject);
    procedure LabeledEdit2Change(Sender: TObject);
    procedure LabeledEdit3Change(Sender: TObject);
    procedure LabeledEdit4Change(Sender: TObject);
    procedure LabeledEdit5Change(Sender: TObject);
    procedure LabeledEdit6Change(Sender: TObject);
    procedure LabeledEdit7Change(Sender: TObject);
    procedure LabeledEdit8Change(Sender: TObject);
    procedure PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PaintBox1Paint(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if CanPaint = True then begin
  (*Проверка на возможность рисования(запрещается при построении кривой)*)
    Button2.Enabled:= true;
    (*Увеличение количества точек и отрезков*)
    ChangeN_H(N, H, 1);

    stringgrid1.RowCount:=N+1;
    stringgrid1.Cells[0,N]:=IntToStr(N);
    stringgrid1.Cells[1,N]:=IntToStr(X);
    stringgrid1.Cells[2,N]:=IntToStr(Y);

    PaintBox1.Canvas.Pen.Color:=0;
    (*Построение точки в виде овала*)
    PaintBox1.Canvas.Ellipse(X-3,Y-3,X+3,Y+3);

    (*Если точек больше одной*)
    if (N > 2) then
      Button1.Enabled:= true;
  end;
end;

procedure TForm1.PaintBox1Paint(Sender: TObject);
var
  i: integer;
begin
  PaintBox1.Canvas.Pen.Color:=0;
  (*Построение точек и линий*)

  PaintBox1.Canvas.Pen.Width:=UpDown3.Position;
  if N > 0 then
    PaintBox1.Canvas.Ellipse(StrToInt(stringgrid1.Cells[1,1])-3, StrToInt(stringgrid1.Cells[2,1])-3, StrToInt(stringgrid1.Cells[1,1])+3, StrToInt(stringgrid1.Cells[2,1])+3);

  for i:=2 to N do Begin
    PaintBox1.Canvas.Pen.Color:=0;
    PaintBox1.Canvas.Ellipse(StrToInt(stringgrid1.Cells[1,i])-3, StrToInt(stringgrid1.Cells[2,i])-3, StrToInt(stringgrid1.Cells[1,i])+3, StrToInt(stringgrid1.Cells[2,i])+3);
  end;

  PaintBox1.Canvas.Pen.Width:=UpDown7.Position;

(*Построение кривой, если она уже была создана*)
  if CanPaint = False then
    Button1Click(Self);   
  //buildFigure();
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  step: integer;
  Cursn, Curcs: double;
begin
  step := UpDown8.Position;
  Timer1.Interval:=Tint;
  if checkBox1.Checked then
    UpDown1.Position:= UpDown1.Position+UpDown4.Position;
  if checkBox2.Checked then begin
    cs := cos(UpDown5.Position*PI/180); 
    sn := sin(UpDown5.Position*PI/180);
    UpDown8.Position := UpDown5.Position;
    if radioButton1.Checked then
      Button5Click(Button5)
    else
      Button5Click(Button6);
  end;
  if checkBox3.Checked then begin
    cs := cos(UpDown6.Position*PI/180);
    sn := sin(UpDown6.Position*PI/180); 
    UpDown8.Position := UpDown6.Position;
    if radioButton3.Checked then
      Button5Click(Button7)
    else
      Button5Click(Button8);
  end;
  if checkBox4.Checked then begin
    cs := cos(UpDown7.Position*PI/180);
    sn := sin(UpDown7.Position*PI/180);  
    UpDown8.Position := UpDown7.Position;
    if radioButton5.Checked then
      Button5Click(Button9)
    else
      Button5Click(Button10);
  end;
        
  UpDown8.Position := step;
  cs:= cos(UpDown2.Position*PI/180);
  sn:= sin(UpDown2.Position*PI/180);
end;

procedure TForm1.TrackBar1Change(Sender: TObject);
begin
  Tint := TrackBar1.Position;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Button1.Enabled:= false;
  Button2.Enabled:= false;   
  Button3.Enabled:= false;
  Button4.Enabled:= false;
  Button5.Enabled:= false;
  Button6.Enabled:= false;
  Button7.Enabled:= false;
  Button8.Enabled:= false;
  Button9.Enabled:= false;
  Button10.Enabled:= false;
  ColorListBox1.Enabled:= false;

  CheckBox1.Enabled:= false;
  CheckBox1.Checked:= false;
  CheckBox2.Enabled:= false; 
  CheckBox2.Checked:= false;
  CheckBox3.Enabled:= false;
  CheckBox3.Checked:= false;
  CheckBox4.Enabled:= false; 
  CheckBox4.Checked:= false;

  Edit1.Enabled:= false;    
  Edit2.Enabled:= false;
  Edit3.Enabled:= false;

  RadioButton1.Enabled:= false;
  RadioButton2.Enabled:= false;
  RadioButton3.Enabled:= false;
  RadioButton4.Enabled:= false;
  RadioButton5.Enabled:= false;
  RadioButton6.Enabled:= false;

  TrackBar1.Enabled:= false;
  Timer1.Enabled:= false;
  CanPaint:= true;

  UpDown1.Enabled:= False;
  LabeledEdit1.Enabled:= False;
  UpDown2.Enabled:= False;
  LabeledEdit2.Enabled:= False;
  UpDown3.Enabled:= False;
  LabeledEdit3.Enabled:= False;  
  UpDown4.Enabled:= False;
  LabeledEdit4.Enabled:= False;
  UpDown5.Enabled:= False;
  LabeledEdit5.Enabled:= False;
  UpDown6.Enabled:= False;
  LabeledEdit6.Enabled:= False;
  UpDown7.Enabled:= False;
  LabeledEdit7.Enabled:= False;   
  UpDown8.Enabled:= False;
  LabeledEdit8.Enabled:= False;

  radioButton1.Checked:=true;  
  radioButton3.Checked:=true;
  radioButton5.Checked:=true;

  Tint:= TrackBar1.Position;

  Rechanges();

  sn := sin(StrToFloat(labeledEdit8.Text)*Pi/180);
  cs := cos(StrToFloat(labeledEdit8.Text)*Pi/180);

  currentXS:= 0;
  currentYS:= 0;

  (*Задание таблицы с точками*)

  UpDown1.Position:=0;
  UpDown2.Position:=20;
  UpDown3.Position:=1;
  UpDown4.Position:=0;
  Updown5.Position:=0;
  UpDown6.Position:=0;
  UpDown7.Position:=0;
  UpDown8.Position:=0;

  Edit1.Text:= IntToStr(0); 
  Edit2.Text:= IntToStr(0);
  Edit3.Text:= IntToStr(0);

  (*Приравнивание количества точек и отрезков к нулю*)
  N:=0;
  H:=-1;

  //RadioButton1.Checked:= True;

  Stringgrid1.RowCount:=1;
  Stringgrid1.ColCount:=3;
  Stringgrid1.Cells[0,0]:='N';
  Stringgrid1.Cells[1,0]:='X';
  Stringgrid1.Cells[2,0]:='Y';
end;

procedure TForm1.LabeledEdit1Change(Sender: TObject);
begin
  if UpDown1.Position > N*10 - 1 then
    UpDown1.Position := UpDown1.Position mod N*10;
  if UpDown1.Position < 0 then
    UpDown1.Position := N*10-UpDown1.Position mod N*10;
  PaintBox1.Invalidate;
end;

procedure TForm1.LabeledEdit2Change(Sender: TObject);
begin
    PaintBox1.Invalidate;
end;

procedure TForm1.LabeledEdit3Change(Sender: TObject);
begin
    PaintBox1.Invalidate;
end;

procedure TForm1.LabeledEdit4Change(Sender: TObject);
begin
  if UpDown4.Position > 10 then
    Updown4.Position := UpDown5.Position mod 10;
  if Updown4.Position < 0 then
    Updown4.Position := 10+Updown5.Position mod 10;
end;

procedure TForm1.LabeledEdit5Change(Sender: TObject);
begin
  if UpDown5.Position > 359 then
    Updown5.Position := UpDown5.Position mod 360;
  if Updown5.Position < 0 then
    Updown5.Position := 360+Updown5.Position mod 360;
end;

procedure TForm1.LabeledEdit6Change(Sender: TObject);
begin
  if UpDown5.Position > 359 then
    Updown5.Position := UpDown5.Position mod 360;
  if Updown5.Position < 0 then
    Updown5.Position := 360+Updown5.Position mod 360;
end;

procedure TForm1.LabeledEdit7Change(Sender: TObject);
begin
  if UpDown5.Position > 359 then
    Updown5.Position := UpDown5.Position mod 360;
  if Updown5.Position < 0 then
    Updown5.Position := 360+Updown5.Position mod 360;
end;

procedure TForm1.LabeledEdit8Change(Sender: TObject);
begin
  cs:= cos(UpDown2.Position*PI/180);
  sn:= sin(UpDown2.Position*PI/180);
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  x1, y1, x2, y2,  i, j, CurX, CurY:integer;
  s: real;
begin

  Button3.Enabled:= true;
  Button4.Enabled:= true;
  Button5.Enabled:= true;
  Button6.Enabled:= true;
  Button7.Enabled:= true;
  Button8.Enabled:= true;
  Button9.Enabled:= true;
  Button10.Enabled:= true;

  CheckBox1.Enabled:= true;
  CheckBox2.Enabled:= true;
  CheckBox3.Enabled:= true;
  CheckBox4.Enabled:= true;

  Edit1.Enabled:= true;
  Edit2.Enabled:= true;
  Edit3.Enabled:= true;

  TrackBar1.Enabled:= true;
  CanPaint:= false;

  UpDown1.Enabled:= true;
  LabeledEdit1.Enabled:= true;
  UpDown2.Enabled:= true;
  LabeledEdit2.Enabled:= true;
  UpDown3.Enabled:= true;
  LabeledEdit3.Enabled:= true;
                      
  ColorListBox1.Enabled:= true;

  ChangeN_H(N, H, 1);
  Setlength(A, 4*H, 4*H+2);
  SetLength(Arr, 4*H, 4*H);

  for i:= 0 to 4*H-1 do
    for j:= 0 to 4*H+1 do
      A[i,j]:=0;

  Build3rdVariant(A, H, N, StrToInt(stringgrid1.Cells[1,1]), StrToInt(stringgrid1.Cells[2,1]));

  for j:=1 to H-1 do Begin
    CurX:=StrToInt(stringgrid1.Cells[1,j+1]);
    CurY:=StrToInt(stringgrid1.Cells[2,j+1]);
    BuildMain(A, H, CurX, CurY, j);
  end;

  GaussJ(A, Arr, H, 2);

  PaintBox1.Canvas.Pen.Color:=ColorListBox1.Selected;
  PaintBox1.Canvas.Pen.Width:=UpDown3.Position;

  s:= 1;
  while s <= N do Begin
    DrawLine(Arr, N, x1, y1, x2, y2, s);
    if s <> 1 then
      //Прорисовка линии, части кривой
      PaintBox1.Canvas.Line(x1, y1, x2, y2);
    s:=s+0.01;
  end;
  UpDown1.Max:= N*10;
  ChangeN_H(N, H, -1);
  BuildFigure();
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  FormCreate(Self);
  PaintBox1.Invalidate;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  Timer1.Enabled:= true;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  Timer1.Enabled:= false;
end;

procedure TForm1.Button5Click(Sender: TObject);
var
  key: integer;
begin
  key := (Sender as TButton).tag;
  case key of
    1: begin
      edit1.Text:=intToStr(StrToINt(edit1.Text)+UpDown8.Position);
      ChangeOX(-1);
    end;
    2: begin
      edit2.Text:=intToStr(StrToINt(edit2.Text)+UpDown8.Position);
      ChangeOY(-1);
    end;
    3: begin
      edit3.Text:=intToStr(StrToINt(edit3.Text)+UpDown8.Position);
      ChangeOZ(1);
    end;
    4: begin
      edit1.Text:=intToStr(StrToINt(edit1.Text)-UpDown8.Position);
      ChangeOX(1);
    end;
    5: begin
      edit2.Text:=intToStr(StrToINt(edit2.Text)-UpDown8.Position);
      ChangeOY(1);
    end;
    6: begin
      edit3.Text:=intToStr(StrToINt(edit3.Text)-UpDown8.Position);
      ChangeOZ(-1);
    end;
  end;
  paintBox1.invalidate;
end;

procedure TForm1.CheckBox1Change(Sender: TObject);
begin
  if CheckBox1.Checked then begin
    LabeledEdit4.Enabled:= true;
    Updown4.Enabled:= true;
  end
  else begin
    LabeledEdit4.Enabled:= false;
    Updown4.Enabled:= false;
  end;
end;

procedure TForm1.CheckBox2Change(Sender: TObject);
begin
  if CheckBox2.Checked then begin
    LabeledEdit5.Enabled:= true;
    Updown5.Enabled:= true;
    RadioButton1.Enabled:= true;
    RadioButton2.Enabled:= true;
  end
  else begin
    LabeledEdit5.Enabled:= false;
    Updown5.Enabled:= false;
    RadioButton1.Enabled:= false;
    RadioButton2.Enabled:= false;
  end;
end;

procedure TForm1.CheckBox3Change(Sender: TObject);
begin
  if CheckBox3.Checked then begin
    LabeledEdit6.Enabled:= true;
    Updown6.Enabled:= true;
    RadioButton3.Enabled:= true;
    RadioButton4.Enabled:= true;
  end
  else begin
    LabeledEdit6.Enabled:= false;
    Updown6.Enabled:= false;
    RadioButton3.Enabled:= false;
    RadioButton4.Enabled:= false;
  end;
end;

procedure TForm1.CheckBox4Change(Sender: TObject);
begin
  if CheckBox4.Checked then begin
    LabeledEdit7.Enabled:= true;
    Updown7.Enabled:= true;
    RadioButton5.Enabled:= true;
    RadioButton6.Enabled:= true;
  end
  else begin
    LabeledEdit7.Enabled:= false;
    Updown7.Enabled:= false;
    RadioButton5.Enabled:= false;
    RadioButton6.Enabled:= false;
  end;
end;

procedure TForm1.ColorListBox1Click(Sender: TObject);
begin
  PaintBox1.Invalidate;
end;

end.

