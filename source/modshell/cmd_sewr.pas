{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | cmd_sewr.pas                                                             | }
{ | command 'serwrite'                                                       | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}
{
  p0       p1   p2
  -----------------------
  serwrite dev? "MESSAGE"
  serwrite dev? $MESSAGE
}

// COMMAND 'SERWRITE'
procedure cmd_serwrite(p1, p2: string);
var
  b: byte;
  i1: integer;             // parameters other type
  s1, s2: string;          // parameters in other type
  valid: boolean = false;

begin
  // CHECK LENGTH OF PARAMETER
  if (length(p1) = 0) or (length(p2) = 0) then
  begin
    writeln(ERR05); // Parameters required!
    exit;
  end;
  // CHECK P1 PARAMETER
  s1 := p1;
  delete(s1, length(s1), 1);
  if PREFIX[0]  = s1 then valid := true;
  if valid then
    if length(p1) >= 4 then
    begin
       i1 := strtointdef(p1[4],-1);
       if (i1 >= 0) and (i1 < 8) then valid := true;
    end;
  if not valid then
  begin
    write('1st ' + MSG05); // What is the 1st parameter?
    writeln(' ' + PREFIX[0] + '[0-7]');
    exit;
  end;
  if not dev[i1].valid then
  begin
    writeln(PREFIX[0], i1, MSG06);
    exit;
  end;
  if not (dev[i1].devtype = 1) then
  begin
    writeln(MSG24);
    exit;
  end;
  // CHECK P2 PARAMETER: IS IT A MESSAGE?
  s2 := isitmessage(p2);
  if length(s2) = 0 then
  begin
    // CHECK P2 PARAMETER
    s2 := isitvariable(p2);
    if length(s2) = 0 then
    begin
      writeln(ERR19);
      exit;
    end;
  end;
  // PRIMARY MISSION
  with dev[i1] do
    if ser_open(device, speed, databit, parity, stopbit) then
    begin
      if ser_canwrite then
      begin
        ser_sendstring(s2);
        textcolor(uconfig.colors[3]);
        case uconfig.echo of
          1: writeln(s2);
          2: begin
               for b := 1 to length(s2) do
                 write(addsomezero(2, deztohex(inttostr(ord(s2[b])))) + ' ');
               writeln;
             end;
        end;
        textcolor(uconfig.colors[0]);
        if (uconfig.echo = 1) and (b = 13) then write(#10);
      end else writeln(ERR27);
      ser_close;
    end else writeln(ERR18, dev[i1].device);
end;
