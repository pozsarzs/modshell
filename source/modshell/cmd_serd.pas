{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023 Pozsar Zsolt <pozsarzs@gmail.com>                     | }
{ | cmd_serd.pas                                                             | }
{ | command 'serread'                                                        | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}
{
  p0      p1   p2
  -----------------------
  serread dev? [$TARGET]
}

// COMMAND 'SERREAD'
procedure cmd_serread(p1, p2: string);
var
  b: byte;
  i1: integer;             // parameters other type
  s: string;
  s1: string;              // parameters in other type
  valid: boolean = false;

begin
  // CHECK LENGTH OF PARAMETER
  if (length(p1) = 0) then
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
  // CHECK P2 PARAMETER
  if length(p2) > 0 then
  begin
    if not boolisitvariable(p2) then
    begin
      writeln(ERR19 + p2);
      exit;
    end;
  end;
  // PRIMARY MISSION
  with dev[i1] do
    if ser_open(device, speed, databit, parity, stopbit) then  
    begin
      if ser_canread then
      begin
        s := ser_recvstring;
        case echo of
          1: writeln(s);
          2: begin
               for b := 1 to length(s) do
                 write(addsomezero(2, deztohex(inttostr(ord(s[b])))) + ' ');
               writeln;
             end;
        end;
        if (echo = 0) and (length(p2) = 0) then writeln(s);
        if length(p2) > 0 then vars[intisitvariable(p1)].vvalue := s;
      end else writeln(ERR26);
      ser_close;
    end else writeln(ERR18, dev[i1].device);
end;
