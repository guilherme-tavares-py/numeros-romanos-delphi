program RomanNumerals;

{$APPTYPE CONSOLE}

uses
  SysUtils;

type
  ToRomanNumber = class
  private
    inputUser: Integer;
    romanNumber: string;
    preRomanNumber: string;
    check: array[0..2] of Integer;
  public
    constructor Create(input: Integer);
    function Convert: string;
  end;
  ToArabicNumber = class
    private
      inputUser: string;
      sum: Integer;
    public
      constructor Create(InputNumber: string);
      function Convert : integer;
  end;


// Conversor de arábico para romano
constructor ToRomanNumber.Create(input: Integer);
begin
  inputUser := input;
  romanNumber := '';
  preRomanNumber := '';
  check[0] := 0;
  check[1] := 0;
  check[2] := 0;
end;

function ToRomanNumber.Convert: string;
begin
  while (inputUser >= 1) do
  begin
    if (inputUser >= 1) and (inputUser < 5) then
    begin
      if (check[0] = 0) then
        preRomanNumber := romanNumber;
      romanNumber := romanNumber + 'I';
      if (check[0] = 3) then
      begin
        preRomanNumber := preRomanNumber + 'IV';
        romanNumber := preRomanNumber;
      end;
      inputUser := inputUser - 1;
      check[0] := check[0] + 1;
    end;

    if (inputUser >= 5) and (inputUser < 10) then
    begin
      if (inputUser = 9) then
      begin
        romanNumber := romanNumber + 'IX';
        inputUser := inputUser - 9;
      end
      else
      begin
        inputUser := inputUser - 5;
        romanNumber := romanNumber + 'V';
      end;
    end;

    if (inputUser >= 10) and (inputUser < 50) then
    begin
      if (check[1] = 0) then
        preRomanNumber := romanNumber;
      romanNumber := romanNumber + 'X';
      if (check[1] = 3) then
      begin
        preRomanNumber := preRomanNumber + 'XL';
        romanNumber := preRomanNumber;
      end;
      check[1] := check[1] + 1;
      inputUser := inputUser - 10;
    end;

    if (inputUser >= 50) and (inputUser < 100) then
    begin
     if (inputUser <= 99) and (inputUser >= 90) then
      begin
        romanNumber := romanNumber + 'XC';
        inputUser := inputUser - 90;
      end
      else
      begin
        inputUser := inputUser - 50;
        romanNumber := romanNumber + 'L';
      end;
    end;

    if (inputUser >= 100) and (inputUser < 500) then
    begin
      if (check[2] = 0) then
        preRomanNumber := romanNumber;
      romanNumber := romanNumber + 'C';
      if (check[2] = 3) then
      begin
        preRomanNumber := preRomanNumber + 'CD';
        romanNumber := preRomanNumber;
      end;
      check[2] := check[2] + 1;
      inputUser := inputUser - 100;
    end;

    if (inputUser >= 500) and (inputUser < 1000) then
    begin
      if (inputUser >= 900) then
      begin
        romanNumber := romanNumber + 'CM';
        inputUser := inputUser - 900;
      end
      else
      begin
        romanNumber := romanNumber + 'D';
        inputUser := inputUser - 500;
      end;
    end;
  end;
  if (inputUser >= 1000) then
  begin
    romanNumber := romanNumber + 'M';
    inputUser := inputUser - 1000;
  end;
  Result := romanNumber;
end;

// Conversor de romano para arábico
constructor ToArabicNumber.Create(InputNumber: string);
begin
  inputUser := InputNumber;
  sum := 0;
end;

function ToArabicNumber.Convert : integer;
var
  i: Integer;
begin
  for i := 1 to Length(inputUser) do
  begin
    if (inputUser[i] = 'i') or (inputUser[i] = 'I') then
    begin
      if (i < Length(inputUser)) and (((inputUser[i + 1] = 'v') or (inputUser[i + 1] = 'V')) or ((inputUser[i + 1] = 'x') or (inputUser[i + 1] = 'X'))) then
        sum := sum - 1
      else
        sum := sum + 1;
    end
    else if (inputUser[i] = 'v') or (inputUser[i] = 'V') then
      sum := sum + 5
    else if (inputUser[i] = 'x') or (inputUser[i] = 'X') then
    begin
      if (i < Length(inputUser)) and (((inputUser[i + 1] = 'l') or (inputUser[i + 1] = 'L')) or ((inputUser[i + 1] = 'c') or (inputUser[i + 1] = 'C'))) then
        sum := sum - 10
      else
        sum := sum + 10;
    end
    else if (inputUser[i] = 'l') or (inputUser[i] = 'L') then
      sum := sum + 50
    else if (inputUser[i] = 'c') or (inputUser[i] = 'C') then
    begin
      if (i < Length(inputUser)) and (((inputUser[i + 1] = 'd') or (inputUser[i + 1] = 'D')) or ((inputUser[i + 1] = 'm') or (inputUser[i+1] = 'M'))) then
        sum := sum - 100
      else
        sum := sum + 100;
    end
    else if (inputUser[i] = 'd') or (inputUser[i] = 'D') then
      sum := sum + 500
    else if (inputUser[i] = 'm') or (inputUser[i] = 'M') then
      sum := sum + 1000;
  end;
  Result := sum;
end;


// checa se é número
function TryDecimalStrToInt( const S: string; out Value: Integer): Boolean;
begin
  result := (pos('$',S)=0) and ((pos('x',S)=0)) and TryStrToInt(S,Value);
end;

var
  inputArabic: Integer;
  inputArabicTest: String;
  inputRoman : String;

  escolha: Integer;

  romanNumeral: ToRomanNumber;
  arabicNumeral: ToArabicNumber;

  result: Integer;

  validRomanNumbers: Array[0..6] of String;
  isRomanNumberValid: Integer;

  i: Integer;
  j: Integer;


begin
  validRomanNumbers[0] := 'iI';
  validRomanNumbers[1] := 'vV';
  validRomanNumbers[2] := 'xX';
  validRomanNumbers[3] := 'lL';
  validRomanNumbers[4] := 'cC';
  validRomanNumbers[5] := 'dD';
  validRomanNumbers[6] := 'mM';
  isRomanNumberValid := 0;

  Write('Voce deseja converter para números romanos (1) ou para arábicos(2)? ');
  Readln(escolha);

  if(escolha = 1) then
  begin
    WriteLn('Conversor de numeros arabicos para romanos!');
    Write('Digite um número inteiro: ');
    Readln(inputArabicTest);
    if TryDecimalStrToInt(inputArabicTest, inputArabic) then
    begin

      inputArabic := StrToInt(inputArabicTest);
      if (inputArabic < 1) or (inputArabic > 1000) then
        Writeln('O numero deve ser maior que 1 e menor que 1000')
      else
      begin
        romanNumeral := ToRomanNumber.Create(inputArabic);
        Writeln('',inputArabic,' para numeros romanos é ', romanNumeral.Convert);
      end;
    end
    else
      Writeln('Voce deve inserir apenas numeros inteiros!');
  end

  else if(escolha = 2) then
  begin
    WriteLn('Conversor de numeros romanos para arábicos!');
    Write('Digite um número romano: ');
    Readln(inputRoman);


    for  i := 0 to Length(inputRoman) do
    begin
      for j := 0 to 6 do
      begin
        if(inputRoman[i] = validRomanNumbers[j][1]) or (inputRoman[i] = validRomanNumbers[j][2]) then
          isRomanNumberValid := isRomanNumberValid + 1;
      end;
    end;

    if (isRomanNumberValid = Length(inputRoman)) then
    begin
      arabicNumeral := ToArabicNumber.Create(inputRoman);
      result := arabicNumeral.Convert;
    end;


    if (result = 0) then
      WriteLn('Insira um número romano valido!')
    else if(result < 1) or (result > 1000) then
      WriteLn('O número deve ser maior que 1 e menor que 1000')
    else
      WriteLn('',inputRoman,' para numeros arábicos é ',result);
  end;

  Readln;
end.

