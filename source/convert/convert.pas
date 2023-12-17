{************************************************}
{                                                }
{   UNIT CONVERT   Zahlensystem-Konvertierung    }
{   Copyright (c) 1993 by Tom Wellige            }
{   Freigegeben als PUBLIC DOMAIN                }
{                                                }
{   ab Turbo Pascal Version 3.0 !                }
{                                                }
{   P.O.Box 7062, DW-6110 Dieburg 2, GERMANY     }
{   CIS: 100041,2071                             }
{************************************************}

unit CONVERT;

{ Diese Unit enthält einfache functionen zur Umwandlung von Zahlen         }
{ aus einem der vier Zahlensysteme BINÄR, OKTAL, DEZIMAL und HEXA-         }
{ DEZIMAL in ein anderes der Zahlensysteme. Alle Zahlen werden grund-      }
{ sätzlich als STRINGS behandelt. Um den Programmieraufwand zur ver-       }
{ einfachen, werden alle Systeme aus dem Binärsystem heraus berechnet.     }
{ Es stehen also Funktionen zur Umwandlung in das Binärsystem und aus      }
{ dem Binärsystem zur Verfügung. Ebenso gibt es Funktionen zur be-         }
{ beliebigen Konvertierung zwischen den Zahlensystemen, die dann aber      }
{ den eben beschriebenen Weg gehen.                                        }
{ Alle Funktionen berücksichtigen mindestens 30 Nachkommastellen.          }

{ Diese Unit dient als Demo, und es steht dem Anwender frei, sie nach      }
{ eingenen Bedürfnissen umzuändern und zu erweitern. Anregegungen und      }
{ Verbesserungsvorschläge dürfen gerne an den Autor weitergeleitet         }
{ werden.                                                                  }

{ Wichtiger Hinweis: die einzelnen Funktionen besitzen KEINE Gültig-       }
{ keitsüberprüfung der Zahlen. Fehler, aufgrund falscher Parameter-        }
{ übergabe, werden also nicht aufgefangen.                                 }


interface

{ Umwandlungsfunktionen }

function  BinToDez(bin: string): string;
          { Wandelt Binär- in Dezimalzahl um.       }
function  BinToOkt(bin: string): string;
          { Wandelt Binär- in Oktalzahl um.         }
function  BinToHex(bin: string): string;
          { Wandelt Binär- in Hexadezimalzahl um.   }

function  OktToBin(okt: string): string;
          { Wandelt Oktal- in Binärzahl um.         }
function  OktToDez(okt: string): string;
          { Wandelt Oktal- in Dezimalzahl um.       }
function  OktToHex(okt: string): string;
          { Wandelt Oktal- in Hexadezimalzahl um.   }

function  DezToBin(dez: string): string;
          { Wandelt Dezimal- in Binärzahl um.       }
function  DezToOkt(dez: string): string;
          { Wandelt Dezimal- in Oktalzahl um.       }
function  DezToHex(dez: string): string;
          { Wandelt Dezimal- in Hexadezimalzahl um. }

function  HexToBin(hex: string): string;
          { Wandelt Hexadezimal- in Binärzhl um.    }
function  HexToOkt(hex: string): string;
          { Wandelt Hexadezimal- in Oktalzahl um.   }
function  HexToDez(hex: string): string;
          { Wandelt Hexadezimal- in Dezimalzahl um. }


{ ------------------------------------------------------------------------ }

implementation


function  CalcBin(d: string): string;
          { Wandelt eine max. 4 stellige Binärzahl d in eine Hexadezimal-  }
          { zahl um. Das Ergebins wird als STRING zurück gegeben.          }
var s: string;
    i, Num: integer;
begin
    Num:= 0;
    i:= length(d);
    if i<=4 then
    begin                               { Berechnung des Wertes in INTEGER }
      if i>=1 then if copy(d,i,1)='1' then Num:=Num+1;
      if i>=2 then if copy(d,i-1,1)='1' then Num:=Num+2;
      if i>=3 then if copy(d,i-2,1)='1' then Num:=Num+4;
      if i=4 then if copy(d,i-3,1)='1' then Num:=Num+8;
    end;
    if Num<=9 then str(Num,s) else
       case Num of              { Umwandlung der Werte größer 9 in Zeichen }
         10: s:='A';
         11: s:='B';
         12: s:='C';
         13: s:='D';
         14: s:='E';
         15: s:='F';
       end;
    CalcBin:= s;
end;


function  CalcNumToBin(d: string; oktal: boolean): string;
          { Wandelt eine 1 stellige Zahl d in eine Binärzahl um. Ist oktal }
          { = TRUE werden drei digits zurück gebenen (z.B. 101). Ist oktal }
          { = FALSE werden vier digits zurück gegeben (z.B. 1011). Das     }
          { Ergenis ist vom Typ STRING.                                    }
begin
  if d='0' then if oktal then CalcNumToBin:='000'
                         else CalcNumToBin:='0000';
  if d='1' then if oktal then CalcNumToBin:='001'
                         else CalcNumToBin:='0001';
  if d='2' then if oktal then CalcNumToBin:='010'
                         else CalcNumToBin:='0010';
  if d='3' then if oktal then CalcNumToBin:='011'
                         else CalcNumToBin:='0011';
  if d='4' then if oktal then CalcNumToBin:='100'
                         else CalcNumToBin:='0100';
  if d='5' then if oktal then CalcNumToBin:='101'
                         else CalcNumToBin:='0101';
  if d='6' then if oktal then CalcNumToBin:='110'
                         else CalcNumToBin:='0110';
  if d='7' then if oktal then CalcNumToBin:='111'
                         else CalcNumToBin:='0111';
  if d='8' then CalcNumToBin:='1000';
  if d='9' then CalcNumToBin:='1001';
  if (d='A') or (d='a') then CalcNumToBin:='1010';
  if (d='B') or (d='b') then CalcNumToBin:='1011';
  if (d='C') or (d='c') then CalcNumToBin:='1100';
  if (d='D') or (d='d') then CalcNumToBin:='1101';
  if (d='E') or (d='e') then CalcNumToBin:='1110';
  if (d='F') or (d='f') then CalcNumToBin:='1111';
end;


function  GetNachkomma(n: string): string;
          { Gibt von einer beliebigen Zeichenkette n alle Zeichen vor dem  }
          { ersten Komma zurück. Das Ergebnis ist vom Typ STRING.          }
var s: string;
    i: integer;
begin
  i:=1;
  s:='0';
  while (n[i]<>',') and (n[i]<>'.') and (i<length(n)) do inc(i);
  if i<length(n) then
  begin
    inc(i);
    s:= copy(n, i, length(n)-i+1);
  end;
  GetNachKomma:= s;
end;


function  GetVorKomma(n:string): string;
          { Gibt von einer beliebigen Zeichenkette n alle Zeichen nach dem }
          { ersten Komma zurück. Das Ergebnis ist vom Typ STRING.          }
var s: string;
    i: integer;
begin
  i:= 1;
  s:='';
  while (n[i]<>',') and (n[i]<>'.') and (i<=length(n)) do
  begin
    s:= s + n[i];
    inc(i);
  end;
  GetVorKomma:= s;
end;



{ --------- Umwandlungsfunktionen ---------- }

function BinToOkt(bin: string): string;
var s, sn, vk, nk: string;
    i: integer;
begin
  vk:= GetVorKomma(bin);              {Trennung von Vor- und Nachkommazahl }
  nk:= GetNachKomma(bin);
  s:='';
  sn:='';
  if length(vk)>3 then
  begin
    while length(vk)>3 do
    begin
      s:= CalcBin(copy(vk, length(vk)-2,3)) + s;
                             { Hex-Wert der letzten drei Stellen ermitteln }
      vk:= copy(vk,1,length(vk)-3);
                                    { Abschneiden der letzten drei Stellen }
    end;
    if length(vk)<=3 then s:= CalcBin(vk) + s;
  end
  else s:= CalcBin(vk);
  if nk<>'0' then
  begin
    while length(nk) mod 3 <> 0 do nk:=nk+'0';
    s:=s+'.';
    if length(nk)>3 then
    begin
      while length(nk)>3 do
      begin
        sn:= sn + CalcBin(copy(nk, 1,3));
                              { Hex-Wert der ersten drei Stellen ermitteln }
        nk:=copy(nk,4,length(nk));
                                     { Abschneiden der ersten drei Stellen }
      end;
      if length(nk)<=3 then sn:= sn + CalcBin(nk);
    end
    else sn:= sn + CalcBin(nk);
  end;
  BinToOkt:= s + sn;
end;


function BinToDez(bin: string): string;
var s, sn, vk, nk: string;
    i, x: integer;
    num, num1, num2, y: real;

begin
  vk:= GetVorKomma(bin);              {Trennung von Vor- und Nachkommazahl }
  nk:= GetNachKomma(bin);
  num1:=0;
  sn:='';
  if length(vk)=0 then num1:=0 else
    for i:=1 to length(vk) do
      if copy(vk, length(vk)+1-i, 1)='1' then
                                 { wenn Stelle i = '1' dann Berechnung 2^i }
      begin
        if i = 1 then y:=i else
        begin
          y:=1;
          for x:=1 to i-1 do y:= y * 2;
        end;
        num1:= num1 + y;
      end;

  num2:=0;
  if nk<>'0' then
  begin
    s:=s+',';
    for i:= 1 to length(nk) do
      if copy(nk, i, 1)='1' then
                                { wenn Stelle i = '1' dann Berechnung 2^-i }
      begin
        y:=1;
        for x:=1 to i do y:= y / 2;
        num2:= num2 + y;
      end;
    end;
  num:= num1 + num2;
  str(num:60:30,s);
  while copy(s, 1, 1)=' ' do                         { Leerzeichen löschen }
    s:= copy(s, 2, length(s));
  while copy(s, length(s), 1)='0' do
    s:= copy(s, 1, length(s)-1);
  if nk='0' then s:= copy(s, 1, length(s)-1);
  BinToDez:= s;
end;


function BinToHex(bin: string): string;
var s, sn, vk, nk: string;
    i: integer;
begin
  vk:= GetVorKomma(bin);              {Trennung von Vor- und Nachkommazahl }
  nk:= GetNachKomma(bin);
  s:='';
  sn:='';
  if length(vk)>4 then
  begin
    while length(vk)>4 do
    begin
      s:= CalcBin(copy(vk, length(vk)-3,4)) + s;
                             { Hex-Wert der letzten vier Stellen ermitteln }
      vk:= copy(vk,1,length(vk)-4);
                                    { Abschneiden der letzten vier Stellen }
    end;
    if length(vk)<=4 then s:= CalcBin(vk) + s;
  end
  else s:= CalcBin(vk);
  if nk<>'0' then
  begin
    while length(nk) mod 4 <> 0 do nk:=nk+'0';
    s:=s+'.';
    if length(nk)>4 then
    begin
      while length(nk)>4 do
      begin
        sn:= sn + CalcBin(copy(nk, 1,4));
                              { Hex-Wert der ersten vier Stellen ermitteln }
        nk:=copy(nk,5,length(nk));
                                     { Abschneiden der ersten vier Stellen }
      end;
      if length(nk)<=4 then sn:= sn + CalcBin(nk);
    end
    else sn:= sn + CalcBin(nk);
  end;
  BinToHex:= s + sn;
end;


function OktToBin(okt: string): string;
var s, sn, vk, nk: string;
    i: integer;
begin
  vk:= GetVorKomma(okt);              {Trennung von Vor- und Nachkommazahl }
  nk:= GetNachKomma(okt);
  s:='';
  sn:='';
  for i:= 1 to length(vk) do
    s:= s + CalcNumToBin(copy(vk, i, 1), true);
  if nk<>'0' then
  begin
    s:=s+'.';
    for i:= 1 to length(nk) do
      sn:= sn + CalcNumToBin(copy(nk, i, 1), true);
                            { Stelle i in dreistellige Binärzahl umwandeln }
  end;
  while copy(s, 1, 1)='0' do s:= copy(s, 2, length(s)-1);
  if s='' then s:='0';
  if copy(s,1,1)='.' then s:= '0'+s;
  OktToBin:= s + sn;
end;


function OktToDez(okt: string): string;
var bin: string;
begin
  bin:= OktToBin(okt);         { Umwandeln der Oktalzahl in eine Binärzahl }
  OktToDez:= BinToDez(bin);  { Umwandeln der Binärzahl in eine Dezimalzahl }
end;


function OktToHex(okt: string): string;
var bin: string;
begin
  bin:= OktToBin(okt);         { Umwandeln der Oktalzahl in eine Binärzahl }
  OktToHex:= BinToHex(bin);     { Umwandeln der Binärzahl in eine Hexazahl }
end;


function DezToBin(dez: string): string;
var s, sn, vk, nk, nn: string;
    i, v: integer;
    n: real;

begin
  vk:= GetVorKomma(dez);              {Trennung von Vor- und Nachkommazahl }
  nk:= GetNachKomma(dez);
  s := '';
  sn:= '';
  v := 0;
  n := 0;
  val(vk, v, i);
  if v < 1 then s:='0' else
    while v >= 1 do      { teile durch 2, wenn Rest dann + '1' sonst + '0' }
    begin
      if v mod 2 <> 0 then s:= '1'+ s  else s:= '0'+ s;
      v:= v div 2;
    end;
  if nk<>'0' then
  begin
    s:= s + '.';
    nk:= '0.' + nk;
    val(nk, n, i);
    i:= 0;
    while (n <> 1) and (n > 0) and (i <= 30) do
                              { Berechnung von maximal 30 Nachkommastellen }
    begin
      i:= i + 1;
      n:= n * 2;
      if n > 1 then
                { multipliziere mal 2, wenn größer 0 dann + '1' sonst +'0' }
      begin
        sn:= sn + '1';
        n:= n - 1;
      end else if n < 1 then sn:= sn + '0';
    end;
    if n = 1 then sn:= sn + '1';                { wenn gleich 1 dann + '1' }
  end;
  DezToBin:= s + sn;
end;


function DezToOkt(dez: string): string;
var bin: string;
begin
  bin:= DezToBin(dez);       { Umwandeln der Dezimalzahl in eine Binärzahl }
  DezToOkt:= BinToOkt(bin);    { Umwandeln der Binärzahl in eine Oktalzahl }
end;


function DezToHex(dez: string): string;
var bin: string;
begin
  bin:= DezToBin(dez);         { Umwandeln der Dezimzahl in eine Binärzahl }
  DezToHex:= BinToHex(bin);      { Umwandeln der Binärzahl in eine Hexzahl }
end;


function HexToBin(hex: string): string;
var s, sn, vk, nk: string;
    i: integer;
begin
  vk:= GetVorKomma(hex);              {Trennung von Vor- und Nachkommazahl }
  nk:= GetNachKomma(hex);
  s:='';
  sn:='';
  for i:= 1 to length(vk) do
    s:= s + CalcNumToBin(copy(vk, i, 1), false);
                       { Stelle i in eine vierstellige Binärzahl umwandeln }
  if nk<>'0' then
  begin
    s:=s+'.';
    for i:= 1 to length(nk) do
      sn:= sn + CalcNumToBin(copy(nk, i, 1), false);
                       { Stelle i in eine vierstellige Binärzahl umwandeln }
  end;
  while copy(s, 1, 1)='0' do s:= copy(s, 2, length(s)-1);
  if s='' then s:='0';
  if copy(s,1,1)='.' then s:= '0'+s;
  HexToBin:= s + sn;
end;


function HexToOkt(hex: string): string;
var bin: string;
begin
  bin:= HexToBin(hex);           { Umwandeln der Hexzahl in eine Binärzahl }
  HexToOkt:= BinToOkt(bin);    { Umwandeln der Binärzahl in eine Oktalzahl }
end;


function HexToDez(hex: string): string;
var bin: string;
begin
  bin:= HexToBin(hex);           { Umwandeln der Hexzahl in eine Binärzahl }
  HexToDez:= BinToDez(bin);   { Umwandeln der Binärzahl in eie Dezimalzahl }
end;

end.