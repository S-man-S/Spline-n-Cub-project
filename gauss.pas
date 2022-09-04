unit Gauss;

{$mode objfpc}{$H+}

interface

uses
  global;

procedure GaussJ(var A, Arr: MATR; H,X: integer);
procedure SearchMaxElement(var A: MATR; var maxj, maxi, H, k: integer);
procedure ChangeMaxAndCurElements(var A: MATR; var ArrA: array of real; maxi, maxj, k, X: integer);
procedure SolutingSystemLinearEquations(var A: MATR; k, H: integer);
procedure RewritingSolutions(var A, Arr: MATR; var ArrA: array of real; X:integer);

implementation

procedure SearchMaxElement(var A: MATR; var maxj, maxi, H, k: integer);
var
  i,j:integer;
  max: real;
Begin
  max:=0;
  maxi:=k;
  maxj:=k;
  for i:=k to 4*H-1 do
    for j:=k to 4*H-1 do
      if A[i,j]>max then Begin
        maxi:=i;
        maxj:=j;
        max:=A[i,j];
      end;
end;

procedure ChangeMaxAndCurElements(var A: MATR; var ArrA: array of real; maxi, maxj, k, X: integer);
var
  l: integer;
  t: real;
Begin
  t:=ArrA[maxj];
  ArrA[maxj]:=ArrA[k];
  ArrA[k]:=t;

  for l:=0 to 4*H-1+X do Begin
    t:=A[maxi,l];
    A[maxi,l]:=A[k,l];
    A[k,l]:=t;
  end;

  for l:=0 to 4*H-1 do Begin
    t:=A[l,maxj];
    A[l,maxj]:=A[l,k];
    A[l,k]:=t;
  end;
end;

procedure SolutingSystemLinearEquations(var A: MATR; k, H: integer);
var
  l, d: integer;
Begin
  for l:= 4*H+1 downto k do
    A[k,l]:=A[k,l]/A[k,k];

  for l:=4*H-1 downto 0 do
    if l<>k then Begin
      A[l,4*H]:=A[l,4*H]-A[k,4*H]*A[l,k];
      A[l,4*H+1]:=A[l,4*H+1]-A[k,4*H+1]*A[l,k];
      for d:=4*H-1 downto k do
        A[l,d]:=A[l,d]-A[k,d]*A[l,k];
    end;
end;

procedure RewritingSolutions(var A, Arr: MATR; var ArrA: array of real; X:integer);
var
  i, j, k: integer;
Begin
    for i:=0 to 4*H-1 do
      for j:=0 to 4*H-1 do
        if ArrA[i] = j then Begin
          for k:= 0 to X-1 do Begin
          Arr[j, k]:= A[i, 4*H+k];
          end;
        end;
end;

procedure GaussJ(var A, Arr: MATR; H, X: integer);
var k, k2, maxi, maxj: integer;
  ArrA: array of real;
Begin
  SetLength(ArrA, 4*H);
  for k:=0 to 4*H-1 do
    ArrA[k]:=k;

  for k:=0 to 4*H-1 do Begin
  //for k:=0 to 1 do Begin
    k2:=k;
    //Нахождение максимального по модулю элемента
    SearchMaxElement(A, maxj, maxi, H, k2);
    //Перестановка строк и столбцов большего и текушего элемета местами
    ChangeMaxAndCurElements(A, ArrA, maxi, maxj, k2, X);
    //Решение СЛАУ
    SolutingSystemLinearEquations(A, k, H);
  end;

  //Переписывание ответов в массив ответов
  RewritingSolutions(A, Arr, ArrA, X);
end;

end.

