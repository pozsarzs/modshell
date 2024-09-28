{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | cmd_get.pas                                                              | }
{ | command 'get'                                                            | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}
{
  p0  p1
  ------------------------------
  get dev?|pro?|con?|prj|timeout
}

// COMMAND 'GET'
function cmd_get(p1: string): byte;
var
  i: integer;
  pr: byte;
  s1: string; // parameter in other type
  valid: boolean;

  // SHOW SETTINGS
  procedure showsettings(pr, n: byte);
  begin
    case pr of
      0: if dev[n].valid
         then
           with dev[n] do
             if devtype = 0 then
             begin
               {$IFNDEF X}
                 writeln(PREFIX[pr], n, ':');
                 writeln(MSG07 + device);
                 writeln(MSG08, port);
               {$ELSE}
                 Form1.Memo1.Lines.Add(PREFIX[pr] + inttostr(n) + ':');
                 Form1.Memo1.Lines.Add(MSG07 + device);
                 Form1.Memo1.Lines.Add(MSG08 + inttostr(port));
               {$ENDIF}
             end else
             begin
               {$IFNDEF X}
                 writeln(PREFIX[pr], n, ':');
                 writeln(MSG07 + device);
                 writeln(MSG09, DEV_SPEED[speed]);
                 writeln(MSG10, databit, upcase(DEV_PARITY[parity]), stopbit);
               {$ELSE}
                 Form1.Memo1.Lines.Add(PREFIX[pr] + inttostr(n) + ':');
                 Form1.Memo1.Lines.Add(MSG07 + device);
                 Form1.Memo1.Lines.Add(MSG09 + DEV_SPEED[speed]);
                 Form1.Memo1.Lines.Add(MSG10 + inttostr(databit) + upcase(DEV_PARITY[parity]) + inttostr(stopbit));
               {$ENDIF}
             end
         else
           {$IFNDEF X}
             writeln(PREFIX[pr], n, MSG06);
           {$ELSE}
             Form1.Memo1.Lines.Add(PREFIX[pr] + inttostr(n) + MSG06);
           {$ENDIF}
      1: if prot[n].valid
         then
           with prot[n] do
             if prottype < 2 then
             begin
               {$IFNDEF X}
                 writeln(PREFIX[pr], n, ':');
                 writeln(MSG11 + PROT_TYPE[prottype]);
                 writeln(MSG13, uid);
               {$ELSE}
                 Form1.Memo1.Lines.Add(PREFIX[pr] + inttostr(n) + ':');
                 Form1.Memo1.Lines.Add(MSG11 + PROT_TYPE[prottype]);
                 Form1.Memo1.Lines.Add(MSG13 + inttostr(uid));
               {$ENDIF}
             end else
             begin
               {$IFNDEF X}
                 writeln(PREFIX[pr], n, ':');
                 writeln(MSG11 + PROT_TYPE[prottype]);
                 writeln(MSG12, ipaddress);
               {$ELSE}
                 Form1.Memo1.Lines.Add(PREFIX[pr] + inttostr(n) + ':');
                 Form1.Memo1.Lines.Add(MSG11 + PROT_TYPE[prottype]);
                 Form1.Memo1.Lines.Add(MSG12 + ipaddress);
               {$ENDIF}
             end
         else
           {$IFNDEF X}
             writeln(PREFIX[pr], n, MSG06);
           {$ELSE}
             Form1.Memo1.Lines.Add(PREFIX[pr] + inttostr(n) + MSG06);
           {$ENDIF}
      2: if conn[n].valid
         then
           with conn[n] do
           begin
           {$IFNDEF X}
             writeln(PREFIX[pr], n, ':');
             writeln(MSG07, PREFIX[0], dev);
             writeln(MSG11, PREFIX[1], prot);
           {$ELSE}
             Form1.Memo1.Lines.Add(PREFIX[pr] + inttostr(n) + ':');
             Form1.Memo1.Lines.Add(MSG07 + PREFIX[0] + inttostr(dev));
             Form1.Memo1.Lines.Add(MSG11 + PREFIX[1] + inttostr(prot));
           {$ENDIF}
           end
       else
           {$IFNDEF X}
             writeln(PREFIX[pr], n, MSG06);
           {$ELSE}
             Form1.Memo1.Lines.Add(PREFIX[pr] + inttostr(n) + MSG06);
           {$ENDIF}
    end;
  end;

  // SHOW VALID 1ST PARAMETERS
  procedure showvalid1stparameters;
  var
    b: byte;
    s: string = '';
  begin
    // What is the 1st parameter?
    s := NUM1 + MSG05;
    for b := 0 to 2 do  s := s + ' ' + PREFIX[b] + '[0-7]';
    s := s + ' ' + PREFIX[3];
    {$IFNDEF X} writeln(s); {$ELSE} Form1.Memo1.Lines.Add(s); {$ENDIF}
  end;

begin
  result := 0;
  // CHECK LENGTH OF PARAMETERS
  if (length(p1) = 0) then
  begin
    // Parameter(s) required!
    {$IFNDEF X} writeln(ERR05); {$ELSE} Form1.Memo1.Lines.Add(ERR05); {$ENDIF}
    result := 1;
    exit;
  end;
  // CHECK P1 PARAMETERS
  if p1 = PREFIX[3] then
  begin
    {$IFNDEF X} writeln(proj); {$ELSE} Form1.Memo1.Lines.Add(proj); {$ENDIF}
    result := 0;
    exit;
  end;
  if p1 = PREFIX[4] then
  begin
    {$IFNDEF X} writeln(timeout); {$ELSE} Form1.Memo1.Lines.Add(inttostr(timeout)); {$ENDIF}
    result := 0;
    exit;
  end;
  s1 := p1;
  delete(s1, length(s1), 1);
  for pr := 0 to 2 do
    if PREFIX[pr] = s1 then
    begin
      valid := true;
      break;
    end;
  if not valid then
  begin
    showvalid1stparameters;
    result := 1;
    exit;
  end;
  // PRIMARY MISSION
  if length(p1) >= 4 then
  begin
    i := strtointdef(p1[4], -1);
    if (i >= 0) and (i < 8)
    then
      showsettings(pr,i)
    else
      case pr of
        {$IFNDEF X}
          0: writeln(ERR01); // Device number must be 0-7!
          1: writeln(ERR02); // Protocol number must be 0-7!
          2: writeln(ERR03); // Connection number must be 0-7!
        {$ELSE}
          0: Form1.Memo1.Lines.Add(ERR01);
          1: Form1.Memo1.Lines.Add(ERR02);
          2: Form1.Memo1.Lines.Add(ERR03);
        {$ENDIF}
      end;
  end else
  begin
    showvalid1stparameters;
    result := 1;
  end;
end;
