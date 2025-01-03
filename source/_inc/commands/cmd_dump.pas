{ +--------------------------------------------------------------------------+ }
{ | ModShell v0.1 * Command-driven scriptable Modbus utility                 | }
{ | Copyright (C) 2023-2025 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | cmd_dump.pas                                                             | }
{ | command 'dump'                                                           | }
{ +--------------------------------------------------------------------------+ }
{ 
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}
{ 
  p0   p1                            p2
  ----------------------------------------------
  dump [$REGTYPE|dinp|coil|ireg|hreg [$]ADDRESS]

     | var |const|varr |carr |data |keyw.|
  ---+-----+-----+-----+-----+-----+-----+
  p1 |  x  |  x  |  x  |  x  |     |  x  |
  p2 |  x  |  x  |  x  |  x  |  x  |     |
}

// COMMAND 'DUMP'
function cmd_dump(p1, p2: string): byte;
var
  b, line, column: byte;
  {$IFDEF X} bb: byte; {$ENDIF}
  {$IFNDEF X} c: char; {$ENDIF}
  i2: integer = 0;
  s: string;
  {$IFDEF X} ss: string; {$ENDIF}
  s1: string = '';
  s2: string = '';
  rt: byte; // register type
  valid: boolean = false;
begin
  result := 0;
  // CHECK LENGTH OF PARAMETERS
  if (length(p1) = 0) or (length(p2) = 0) then
  begin
    {$IFNDEF X}
      // ASKS FOR REGISTER TYPE
      write(MSG26);
      repeat
        rt := ord(readkey);
        if rt = 27 then  begin writeln; exit; end;
      until (rt > 48) and (rt < 53);
      writeln(chr(rt));
      rt := rt - 49;
      // ASKS FOR START ADDRESS
      write(MSG27);
      repeat
        c := readkey;
        if c = #27 then begin writeln; exit; end;
        if length(s2) > 0 then
          if c = #8 then delete(s2, length(s2), 1);
        if length(s2) < 4 then
          if (c >= #48) and (c <= #57) then s2 := s2 + c;
        if strtointdef(s2, 0) > 9990 then s2 := '9990';
        xywrite(length(MSG27) + 1, wherey, true, s2);
      until (c = #13) and (length(s2) > 0);
      writeln;
      i2 := strtointdef(s2, 0);
    {$ELSE}
      // Parameter(s) required!
      Form1.Memo1.Lines.Add(ERR05);
      result := 1;
      exit;
    {$ENDIF}
  end else
  begin
    // CHECK P1 PARAMETER
    if boolisitconstant(p1) then s1 := isitconstant(p1);
    if boolisitvariable(p1) then s1 := isitvariable(p1);
    // No such array cell!
    if boolisitconstantarray(p1) then
      if boolvalidconstantarraycell(p1)
        then s1 := isitconstantarray(p1)
        else result := 1;
    if boolisitvariablearray(p1) then
      if boolvalidvariablearraycell(p1)
        then s1 := isitvariablearray(p1)
        else result := 1;
    if result = 1 then exit;
    if length(s1) = 0 then s1 := p1;
    for rt := 0 to 3 do
      if REG_TYPE[rt] = s1 then
      begin
        valid := true;
        break;
      end;
    if not valid then
    begin
      // What is the 2nd parameter?
      s := NUM1 + MSG05;
      for rt := 0 to 3 do s := s + ' ' + REG_TYPE[rt];
      {$IFNDEF X}
        if verbosity(2) then writeln(s);
      {$ELSE}
        Form1.Memo1.Lines.Add(s);
      {$ENDIF}
      result := 1;
      exit;
    end;
    // CHECK P2 PARAMETER
    if boolisitconstant(p2) then s2 := isitconstant(p2);
    if boolisitvariable(p2) then s2 := isitvariable(p2);
    // No such array cell!
    if boolisitconstantarray(p2) then
      if boolvalidconstantarraycell(p2)
        then s2 := isitconstantarray(p2)
        else result := 1;
    if boolisitvariablearray(p2) then
      if boolvalidvariablearraycell(p2)
        then s2 := isitvariablearray(p2)
        else result := 1;
    if result = 1 then exit;
    if length(s2) = 0 then s2 := p2;
    i2 := strtointdef(s2, -1);
    if (i2 < 0) or (i2 > 9990) then
    begin
      // What is the 3rd parameter?
      {$IFNDEF X}
        if verbosity(2) then writeln(NUM2 + MSG05 + AVR);
      {$ELSE}
        Form1.Memo1.Lines.Add(NUM2 + MSG05 + AVR);
      {$ENDIF}
      result := 1;
      exit;
    end;
  end;
  // PRIMARY MISSION
  i2 := (i2 div 10) * 10;
  {$IFNDEF X}
    // header
    textcolor(colors[1]); textbackground(colors[0]);
    gotoxy(7, wherey);
    for b := 0 to 48 do write(' ');
    gotoxy(1, wherey);
    for b := 0 to 9 do xywrite((5 * (b + 1)) + 2, wherey, false, inttostr(b)); 
    textcolor(colors[0]); textbackground(colors[1]);
    writeln;
    for line := 0 to termheight - 5 do
    begin
      textcolor(colors[1]); textbackground(colors[0]);
      write(addsomezero(4, inttostr(i2 + (line * 10)))); // address
      textcolor(colors[0]); textbackground(colors[1]);
      // content
      for column := 0 to 9 do
        if ((i2 + column) + line * 10) < 10000 then
        begin
          case rt of
            0: xywrite((5 * (column + 1)) + 2, wherey, false,
                       inttostr(booltoint(dinp[(i2 + column) + line * 10])));
            1: xywrite((5 * (column + 1)) + 2, wherey, false,
                       inttostr(booltoint(coil[(i2 + column) + line * 10])));
            2: xywrite((5 * (column + 1)) + 2, wherey, false,
                       addsomezero(4, deztohex(inttostr(ireg[(i2 + column) +
                                   line * 10]))));
            3: xywrite((5 * (column + 1)) + 2, wherey, false,
                       addsomezero(4, deztohex(inttostr(hreg[(i2 + column) +
                                   line * 10]))));
          end;
        end else
        begin
          result := 1;
          exit;
        end;
      writeln;
    end;
  {$ELSE}
    // header
    for b := 1 to 255 do s := s + #32;
    for b := 0 to 9 do
    begin
      ss := inttostr(b);
      for bb := 1 to length(ss) do
        s[(5 * (b + 1)) + 2 + bb - 1] := ss[bb];
    end;
    for b := 255 downto 1 do
      if s[b] <> #32 then break else delete(s,b,1);
    Form1.Memo1.Lines.Add(s);
    // content
    for line := 0 to 16 do
    begin
      s := addsomezero(4, inttostr(i2 + (line * 10))); // address
      for b := length(s) to 255 do s := s + #32;
      for column := 0 to 9 do
        if ((i2 + column) + line * 10) < 10000 then
        begin
          case rt of
            0: begin
                 ss := inttostr(booltoint(dinp[(i2 + column) + line * 10]));
                 for bb := 1 to length(ss) do
                   s[(5 * (column + 1)) + 2 + bb - 1] := ss[bb];
               end;
            1: begin
                 ss := inttostr(booltoint(coil[(i2 + column) + line * 10]));
                 for bb := 1 to length(ss) do
                   s[(5 * (column + 1)) + 2 + bb - 1] := ss[bb];
               end;
            2: begin
                 ss := addsomezero(4, deztohex(inttostr(ireg[(i2 + column) +
                                   line * 10])));
                 for bb := 1 to length(ss) do
                   s[(5 * (column + 1)) + 2 + bb - 1] := ss[bb];
               end;
            3: begin
                 ss := addsomezero(4, deztohex(inttostr(hreg[(i2 + column) +
                                   line * 10])));
                 for bb := 1 to length(ss) do
                   s[(5 * (column + 1)) + 2 + bb - 1] := ss[bb];
               end;
          end;
        end else
        begin
          result := 1;
          exit;
        end;
        for b := 255 downto 1 do
          if s[b] <> #32 then break else delete(s, b, 1);
        Form1.Memo1.Lines.Add(s);
    end;
  {$ENDIF}
end;
