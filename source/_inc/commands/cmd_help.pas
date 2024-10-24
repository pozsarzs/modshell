{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | cmd_help.pas                                                             | }
{ | command 'help'                                                           | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}
{
  p0   p1
  -----------------
  help [[$]COMMAND]
}

// COMMAND 'HELP'
function cmd_help(p1: string): byte;
var
  b, bb: byte;
  buffer: array[0..COMMARRSIZE + 5] of string;
  {$IFNDEF X} line: byte; {$ENDIF}
  s1: string; // parameters in other type
  valid: boolean;

  // SHORTING CONTENT OF BUFFER
  procedure shorting;
  var
   i, j: byte;
   s: string;
  begin
    for i := 0 to COMMARRSIZE + 4 do
     for j := i + 1 to COMMARRSIZE + 5 do
       if buffer[i] < buffer[j] then
       begin
         s := buffer[i];
         buffer[i] := buffer[j];
         buffer[j] := s;
       end;
  end;

begin
  result := 0;
  for b := 0 to COMMARRSIZE + 5 do buffer[b] := '';
  if length(p1) = 0 then
  begin
    // How to use help with command list.
    {$IFNDEF X} writeln(MSG03); {$ELSE} Form1.Memo1.Lines.Add(MSG03); {$ENDIF}
    for b := 0 to COMMARRSIZE - 2 do
    begin
      buffer[b] := '  ' + COMMANDS[b];
      for bb := 0 to 6 - length(COMMANDS[b]) + 2 do
        buffer[b] := buffer[b] + ' ';
      case b of
         0: buffer[b] := buffer[b] + DES00;
         1: buffer[b] := buffer[b] + DES01;
         2: buffer[b] := buffer[b] + DES02;
         3: buffer[b] := buffer[b] + DES03;
         4: buffer[b] := buffer[b] + DES04;
         5: buffer[b] := buffer[b] + DES05;
         6: buffer[b] := buffer[b] + DES06;
         7: buffer[b] := buffer[b] + DES07;
         8: buffer[b] := buffer[b] + DES08;
         9: buffer[b] := buffer[b] + DES09;
        10: buffer[b] := buffer[b] + DES10;
        11: buffer[b] := buffer[b] + DES11;
        12: buffer[b] := buffer[b] + DES12;
        13: buffer[b] := buffer[b] + DES13;
        14: buffer[b] := buffer[b] + DES14;
        15: buffer[b] := buffer[b] + DES15;
        16: buffer[b] := buffer[b] + DES16;
        17: buffer[b] := buffer[b] + DES17;
        18: buffer[b] := buffer[b] + DES18;
        19: buffer[b] := buffer[b] + DES19;
        20: buffer[b] := buffer[b] + DES20;
        21: buffer[b] := buffer[b] + DES21;
        22: buffer[b] := buffer[b] + DES22;
        23: buffer[b] := buffer[b] + DES23;
        24: buffer[b] := buffer[b] + DES24;
        25: buffer[b] := buffer[b] + DES25;
        26: buffer[b] := buffer[b] + DES26;
        27: buffer[b] := buffer[b] + DES27;
        28: buffer[b] := buffer[b] + DES28;
        29: buffer[b] := buffer[b] + DES29;
        30: buffer[b] := buffer[b] + DES30;
        31: buffer[b] := buffer[b] + DES31;
        32: buffer[b] := buffer[b] + DES32;
        33: buffer[b] := buffer[b] + DES33;
        34: buffer[b] := buffer[b] + DES34;
        35: buffer[b] := buffer[b] + DES35;
        36: buffer[b] := buffer[b] + DES36;
        37: buffer[b] := buffer[b] + DES37;
        38: buffer[b] := buffer[b] + DES38;
        39: buffer[b] := buffer[b] + DES39;
        40: buffer[b] := buffer[b] + DES40;
        41: buffer[b] := buffer[b] + DES41;
        42: buffer[b] := buffer[b] + DES42;
        43: buffer[b] := buffer[b] + DES43;
        44: buffer[b] := buffer[b] + DES44;
        45: buffer[b] := buffer[b] + DES45;
        46: buffer[b] := buffer[b] + DES46;
        47: buffer[b] := buffer[b] + DES47;
        48: buffer[b] := buffer[b] + DES48;
        49: buffer[b] := buffer[b] + DES49;
        50: buffer[b] := buffer[b] + DES50;
        51: buffer[b] := buffer[b] + DES51;
        52: buffer[b] := buffer[b] + DES52;
        53: buffer[b] := buffer[b] + DES53;
        54: buffer[b] := buffer[b] + DES54;
        55: buffer[b] := buffer[b] + DES55;
        56: buffer[b] := buffer[b] + DES56;
        57: buffer[b] := buffer[b] + DES57;
        58: buffer[b] := buffer[b] + DES58;
        59: buffer[b] := buffer[b] + DES59;
        60: buffer[b] := buffer[b] + DES60;
        61: buffer[b] := buffer[b] + DES61;
        62: buffer[b] := buffer[b] + DES62;
        63: buffer[b] := buffer[b] + DES63;
        64: buffer[b] := buffer[b] + DES64;
        65: buffer[b] := buffer[b] + DES65;
        66: buffer[b] := buffer[b] + DES66;
        67: buffer[b] := buffer[b] + DES67;
        68: buffer[b] := buffer[b] + DES68;
        69: buffer[b] := buffer[b] + DES69;
        70: buffer[b] := buffer[b] + DES70;
        71: buffer[b] := buffer[b] + DES71;
        72: buffer[b] := buffer[b] + DES72;
        73: buffer[b] := buffer[b] + DES73;
        74: buffer[b] := buffer[b] + DES74;
        75: buffer[b] := buffer[b] + DES75;
        76: buffer[b] := buffer[b] + DES76;
        77: buffer[b] := buffer[b] + DES77;
        78: buffer[b] := buffer[b] + DES78;
        79: buffer[b] := buffer[b] + DES79;
        80: buffer[b] := buffer[b] + DES80;
        81: buffer[b] := buffer[b] + DES81;
        82: buffer[b] := buffer[b] + DES82;
        83: buffer[b] := buffer[b] + DES83;
        84: buffer[b] := buffer[b] + DES84;
        85: buffer[b] := buffer[b] + DES85;
        86: buffer[b] := buffer[b] + DES86;
        87: buffer[b] := buffer[b] + DES87;
        88: buffer[b] := buffer[b] + DES88;
        89: buffer[b] := buffer[b] + DES89;
        90: buffer[b] := buffer[b] + DES90;
        91: buffer[b] := buffer[b] + DES91;
        92: buffer[b] := buffer[b] + DES92;
        93: buffer[b] := buffer[b] + DES93;
        94: buffer[b] := buffer[b] + DES94;
        95: buffer[b] := buffer[b] + DES95;
        96: buffer[b] := buffer[b] + DES96;
        97: buffer[b] := buffer[b] + DES97;
        98: buffer[b] := buffer[b] + DES98;
        99: buffer[b] := buffer[b] + DES99;
       100: buffer[b] := buffer[b] + DES100;
       101: buffer[b] := buffer[b] + DES101;
       102: buffer[b] := buffer[b] + DES102;
       103: buffer[b] := buffer[b] + DES103;
       104: buffer[b] := buffer[b] + DES104;
       105: buffer[b] := buffer[b] + DES105;
       106: buffer[b] := buffer[b] + DES106;
       107: buffer[b] := buffer[b] + DES107;
       108: buffer[b] := buffer[b] + DES108;
       109: buffer[b] := buffer[b] + DES109;
       110: buffer[b] := buffer[b] + DES110;
      end;
    end;
    shorting;
    buffer[COMMARRSIZE] := MSG24;
    {$IFNDEF X}
      line := 0;
    {$ENDIF}
    for b := COMMARRSIZE - 1 downto 0 do
    begin
      {$IFNDEF X}
        writeln(buffer[b]);
        inc(line);
        if line >= (termheight - 6) then
        begin
          write(MSG23); readkey;
          write(#13); clreol;
          line := 0;
        end;
      {$ELSE}
        Form1.Memo1.Lines.Add(buffer[b]);
      {$ENDIF}
    end;
  end else
  begin
    // CHECK P1 PARAMETER
    s1 := isitvariable(p1);
    if length(s1) = 0 then s1 := p1;
    valid := false;
    for b := 0 to COMMARRSIZE - 2 do
      if s1 = COMMANDS[b] then
      begin
        valid := true;
        break;
      end;
    if not valid then
    begin
      // No such command!
      {$IFNDEF X} writeln(ERR00); {$ELSE} Form1.Memo1.Lines.Add(ERR00); {$ENDIF}
      result := 1;
    end else
    begin
      // PRIMARY MISSION
      {$IFNDEF X}
        writeln(MSG04);
        gotoxy(3, wherey);
        case b of
           0: writeln(USG00);
           1: writeln(USG01);
           2: writeln(USG02);
           3: writeln(USG03);
           4: writeln(USG04);
           5: writeln(USG05);
           6: writeln(USG06);
           7: writeln(USG07);
           8: writeln(USG08);
           9: writeln(USG09);
          10: writeln(USG10);
          11: writeln(USG11);
          12: writeln(USG12);
          13: writeln(USG13);
          14: writeln(USG14);
          15: writeln(USG15);
          16: writeln(USG16);
          17: writeln(USG17);
          18: writeln(USG18);
          19: writeln(USG19);
          20: writeln(USG20);
          21: writeln(USG21);
          22: writeln(USG22);
          23: writeln(USG23);
          24: writeln(USG24);
          25: writeln(USG25);
          26: writeln(USG26);
          27: writeln(USG27);
          28: writeln(USG28);
          29: writeln(USG29);
          30: writeln(USG30);
          31: writeln(USG31);
          32: writeln(USG32);
          33: writeln(USG33);
          34: writeln(USG34);
          35: writeln(USG35);
          36: writeln(USG36);
          37: writeln(USG37);
          38: writeln(USG38);
          39: writeln(USG39);
          40: writeln(USG40);
          41: writeln(USG41);
          42: writeln(USG42);
          43: writeln(USG43);
          44: writeln(USG44);
          45: writeln(USG45);
          46: writeln(USG46);
          47: writeln(USG47);
          48: writeln(USG48);
          49: writeln(USG49);
          50: writeln(USG50);
          51: writeln(USG51);
          52: writeln(USG52);
          53: writeln(USG53);
          54: writeln(USG54);
          55: writeln(USG55);
          56: writeln(USG56);
          57: writeln(USG57);
          58: writeln(USG58);
          59: writeln(USG59);
          60: writeln(USG60);
          61: writeln(USG61);
          62: writeln(USG62);
          63: writeln(USG63);
          64: writeln(USG64);
          65: writeln(USG65);
          66: writeln(USG66);
          67: writeln(USG67);
          68: writeln(USG68);
          69: writeln(USG69);
          70: writeln(USG70);
          71: writeln(USG71);
          72: writeln(USG72);
          73: writeln(USG73);
          74: writeln(USG74);
          75: writeln(USG75);
          76: writeln(USG76);
          77: writeln(USG77);
          78: writeln(USG78);
          79: writeln(USG79);
          80: writeln(USG80);
          81: writeln(USG81);
          82: writeln(USG82);
          83: writeln(USG83);
          84: writeln(USG84);
          85: writeln(USG85);
          86: writeln(USG86);
          87: writeln(USG87);
          88: writeln(USG88);
          89: writeln(USG89);
          90: writeln(USG90);
          91: writeln(USG91);
          92: writeln(USG92);
          93: writeln(USG93);
          94: writeln(USG94);
          95: writeln(USG95);
          96: writeln(USG96);
          97: writeln(USG97);
          98: writeln(USG98);
          99: writeln(USG99);
         100: writeln(USG100);
         101: writeln(USG101);
         102: writeln(USG102);
         103: writeln(USG103);
         104: writeln(USG104);
         105: writeln(USG105);
         106: writeln(USG106);
         107: writeln(USG107);
         108: writeln(USG108);
         109: writeln(USG109);
         110: writeln(USG110);
        end;
      {$ELSE}
        with Form1 do
        begin
          Memo1.Lines.Add(MSG04);
          case b of
           0: Memo1.Lines.Add('   ' + USG00);
           1: Memo1.Lines.Add('   ' + USG01);
           2: Memo1.Lines.Add('   ' + USG02);
           3: Memo1.Lines.Add('   ' + USG03);
           4: Memo1.Lines.Add('   ' + USG04);
           5: Memo1.Lines.Add('   ' + USG05);
           6: Memo1.Lines.Add('   ' + USG06);
           7: Memo1.Lines.Add('   ' + USG07);
           8: Memo1.Lines.Add('   ' + USG08);
           9: Memo1.Lines.Add('   ' + USG09);
          10: Memo1.Lines.Add('   ' + USG10);
          11: Memo1.Lines.Add('   ' + USG11);
          12: Memo1.Lines.Add('   ' + USG12);
          13: Memo1.Lines.Add('   ' + USG13);
          14: Memo1.Lines.Add('   ' + USG14);
          15: Memo1.Lines.Add('   ' + USG15);
          16: Memo1.Lines.Add('   ' + USG16);
          17: Memo1.Lines.Add('   ' + USG17);
          18: Memo1.Lines.Add('   ' + USG18);
          19: Memo1.Lines.Add('   ' + USG19);
          20: Memo1.Lines.Add('   ' + USG20);
          21: Memo1.Lines.Add('   ' + USG21);
          22: Memo1.Lines.Add('   ' + USG22);
          23: Memo1.Lines.Add('   ' + USG23);
          24: Memo1.Lines.Add('   ' + USG24);
          25: Memo1.Lines.Add('   ' + USG25);
          26: Memo1.Lines.Add('   ' + USG26);
          27: Memo1.Lines.Add('   ' + USG27);
          28: Memo1.Lines.Add('   ' + USG28);
          29: Memo1.Lines.Add('   ' + USG29);
          30: Memo1.Lines.Add('   ' + USG30);
          31: Memo1.Lines.Add('   ' + USG31);
          32: Memo1.Lines.Add('   ' + USG32);
          33: Memo1.Lines.Add('   ' + USG33);
          34: Memo1.Lines.Add('   ' + USG34);
          35: Memo1.Lines.Add('   ' + USG35);
          36: Memo1.Lines.Add('   ' + USG36);
          37: Memo1.Lines.Add('   ' + USG37);
          38: Memo1.Lines.Add('   ' + USG38);
          39: Memo1.Lines.Add('   ' + USG39);
          40: Memo1.Lines.Add('   ' + USG40);
          41: Memo1.Lines.Add('   ' + USG41);
          42: Memo1.Lines.Add('   ' + USG42);
          43: Memo1.Lines.Add('   ' + USG43);
          44: Memo1.Lines.Add('   ' + USG44);
          45: Memo1.Lines.Add('   ' + USG45);
          46: Memo1.Lines.Add('   ' + USG46);
          47: Memo1.Lines.Add('   ' + USG47);
          48: Memo1.Lines.Add('   ' + USG48);
          49: Memo1.Lines.Add('   ' + USG49);
          50: Memo1.Lines.Add('   ' + USG50);
          51: Memo1.Lines.Add('   ' + USG51);
          52: Memo1.Lines.Add('   ' + USG52);
          53: Memo1.Lines.Add('   ' + USG53);
          54: Memo1.Lines.Add('   ' + USG54);
          55: Memo1.Lines.Add('   ' + USG55);
          56: Memo1.Lines.Add('   ' + USG56);
          57: Memo1.Lines.Add('   ' + USG57);
          58: Memo1.Lines.Add('   ' + USG58);
          59: Memo1.Lines.Add('   ' + USG59);
          60: Memo1.Lines.Add('   ' + USG60);
          61: Memo1.Lines.Add('   ' + USG61);
          62: Memo1.Lines.Add('   ' + USG62);
          63: Memo1.Lines.Add('   ' + USG63);
          64: Memo1.Lines.Add('   ' + USG64);
          65: Memo1.Lines.Add('   ' + USG65);
          66: Memo1.Lines.Add('   ' + USG66);
          67: Memo1.Lines.Add('   ' + USG67);
          68: Memo1.Lines.Add('   ' + USG68);
          69: Memo1.Lines.Add('   ' + USG69);
          70: Memo1.Lines.Add('   ' + USG70);
          71: Memo1.Lines.Add('   ' + USG71);
          72: Memo1.Lines.Add('   ' + USG72);
          73: Memo1.Lines.Add('   ' + USG73);
          74: Memo1.Lines.Add('   ' + USG74);
          75: Memo1.Lines.Add('   ' + USG75);
          76: Memo1.Lines.Add('   ' + USG76);
          77: Memo1.Lines.Add('   ' + USG77);
          78: Memo1.Lines.Add('   ' + USG78);
          79: Memo1.Lines.Add('   ' + USG79);
          80: Memo1.Lines.Add('   ' + USG80);
          81: Memo1.Lines.Add('   ' + USG81);
          82: Memo1.Lines.Add('   ' + USG82);
          83: Memo1.Lines.Add('   ' + USG83);
          84: Memo1.Lines.Add('   ' + USG84);
          85: Memo1.Lines.Add('   ' + USG85);
          86: Memo1.Lines.Add('   ' + USG86);
          87: Memo1.Lines.Add('   ' + USG87);
          88: Memo1.Lines.Add('   ' + USG88);
          89: Memo1.Lines.Add('   ' + USG89);
          90: Memo1.Lines.Add('   ' + USG90);
          91: Memo1.Lines.Add('   ' + USG91);
          92: Memo1.Lines.Add('   ' + USG92);
          93: Memo1.Lines.Add('   ' + USG93);
          94: Memo1.Lines.Add('   ' + USG94);
          95: Memo1.Lines.Add('   ' + USG95);
          96: Memo1.Lines.Add('   ' + USG96);
          97: Memo1.Lines.Add('   ' + USG97);
          98: Memo1.Lines.Add('   ' + USG98);
          99: Memo1.Lines.Add('   ' + USG99);
         100: Memo1.Lines.Add('   ' + USG100);
         101: Memo1.Lines.Add('   ' + USG101);
         102: Memo1.Lines.Add('   ' + USG102);
         103: Memo1.Lines.Add('   ' + USG103);
         104: Memo1.Lines.Add('   ' + USG104);
         105: Memo1.Lines.Add('   ' + USG105);
         106: Memo1.Lines.Add('   ' + USG106);
         107: Memo1.Lines.Add('   ' + USG107);
         108: Memo1.Lines.Add('   ' + USG108);
         109: Memo1.Lines.Add('   ' + USG109);
         110: Memo1.Lines.Add('   ' + USG110);
        end;
      end;
     {$ENDIF}
    end;
  end;
end;
