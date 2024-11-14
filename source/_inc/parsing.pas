{ +--------------------------------------------------------------------------+ }
{ | ModShell 0.1 * Command-driven scriptable Modbus utility                  | }
{ | Copyright (C) 2023-2024 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | parsingcommands.pas                                                      | }
{ | parsing commands                                                         | }
{ +--------------------------------------------------------------------------+ }
{
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}

// PARSING COMMANDS
procedure parsingcommands(command: string);
var
 a, b: byte;
 s: string;
 o: boolean;
 {$IFDEF X} f3active: boolean; {$ENDIF}
begin
  {$IFDEF X} f3active := Form3.Active; {$ENDIF}
  if (length(command) > 0) then
    if (command[1] <> #58) and (command[1] <> #64) then
    begin
      // remove space and tab from start of line
      while (command[1] = #32) or (command[1] = #9) do
        delete(command, 1, 1);
      // remove space and tab from end of line
      while (command[length(command)] = #32) or (command[length(command)] = #9) do
        delete(command, length(command), 1);
      // remove extra space and tab from line
      for b := 1 to 255 do
      begin
        if b = length(command) then break;
        if command[b] <> #32 then o := false;
        if (command[b] = #32) and o then command[b] :='@';
        if command[b] = #32 then o := true;
      end;
      s := '';
      for b := 1 to length(command) do
        if command[b] <> '@' then s := s + command[b];
      command := s;
      // split command to 8 slices
      for b := 0 to 7 do
        splitted[b] := '';
      for a := 1 to length(command) do
        if (command[a] = #32) and (command[a - 1] <> #92)
          then break
          else splitted[0] := splitted[0] + command[a];
      for b:= 1 to 7 do
        for a := a + 1 to length(command) do
          if (command[a] = #32) and (command[a - 1] <> #92)
            then break
            else splitted[b] := splitted[b] + command[a];
      // parse command
      o := false;
      if splitted[0][1] <> COMMENT then
      begin
        for b := 0 to COMMARRSIZE - 1 do
          if splitted[0] = COMMANDS[b] then
          begin
            o := true;
            break;
          end;
        if o then
        begin
          {$IFDEF X} Form1.ComboBox1.Enabled := false; {$ENDIF}
          case b of
             0: exitcode := cmd_copyreg(splitted[1], splitted[2], splitted[3], splitted[4], splitted[5], splitted[6]);
             2: exitcode := cmd_get(splitted[1]);
             3: exitcode := cmd_help(splitted[1]);
             4: exitcode := cmd_let(splitted[1], splitted[2], splitted[3]);
             5: exitcode := cmd_print(splitted[1], splitted[2], splitted[3], splitted[4]);
             6: exitcode := cmd_readreg(splitted[1], splitted[2], splitted[3], splitted[4]);
             7: exitcode := cmd_reset(splitted[1]);
             8: exitcode := cmd_set(splitted[1], splitted[2], splitted[3], splitted[4], splitted[5], splitted[6], splitted[7]);
             9: exitcode := cmd_date(splitted[1]);
            10: begin version(false); exitcode := 0; end;
            11: exitcode := cmd_writereg(splitted[1], splitted[2], splitted[3], splitted[4]);
            12: begin
                  {$IFNDEF X}
                    clrscr;
                  {$ELSE}
                    if Form1.Active then Form1.Memo1.Lines.Clear;
                    if f3active then Form3.Memo1.Lines.Clear;
                  {$ENDIF}
                  exitcode := 0;
                end;
            13: exitcode := cmd_savecfg(splitted[1]);
            14: exitcode := cmd_loadcfg(splitted[1]);
            15: exitcode := cmd_expreg(splitted[1], splitted[2], splitted[3], splitted[4]);
            16: exitcode := cmd_exphis(splitted[1]);
            17: exitcode := cmd_conv(splitted[1], splitted[2], splitted[3], splitted[4]);
            18: exitcode := cmd_savereg(splitted[1]);
            19: exitcode := cmd_loadreg(splitted[1]);
            20: exitcode := cmd_var(splitted[1], splitted[2]);
            21: exitcode := cmd_printcolor(splitted[1], splitted[2]);
            22: exitcode := cmd_impreg(splitted[1]);
            33: exitcode := cmd_dump(splitted[1], splitted[2]);
            34: exitcode := cmd_pause(splitted[1]);
            35: exitcode := cmd_sercons(splitted[1]);
            36: exitcode := cmd_serread(splitted[1], splitted[2]);
            37: exitcode := cmd_serwrite(splitted[1], splitted[2]);
            38: exitcode := cmd_echo(splitted[1]);
            39: exitcode := cmd_loadscr(splitted[1]);
            40: exitcode := cmd_run(splitted[1], splitted[2]);
            41: exitcode := cmd_list;
            66: exitcode := cmd_const(splitted[1], splitted[2]);
            69: exitcode := cmd_goto(splitted[1]);
            70: exitcode := cmd_if(splitted[1], splitted[2], splitted[3], splitted[4], command);
            71: exitcode := cmd_for(splitted[1], splitted[2], splitted[3], splitted[4], splitted[5], command);
            72: exitcode := cmd_label(splitted[1]);
            73: exitcode := cmd_mbsrv(splitted[1]);
            74: exitcode := cmd_mbgw(splitted[1], splitted[2]);
            79: exitcode := cmd_ascii(splitted[1]);
            80: begin sysutils.beep; exitcode := 0; end;
            81: exitcode := cmd_avg(splitted[1], splitted[2], splitted[3], splitted[4], splitted[5], splitted[6]);
            82: exitcode := cmd_prop(splitted[1], splitted[2], splitted[3], splitted[4], splitted[5], splitted[6]);
            88: exitcode := cmd_varmon(splitted[1], splitted[2]);
            89: exitcode := cmd_applog(splitted[1], splitted[2], splitted[3], splitted[4], splitted[5], splitted[6], splitted[7]);
            90: exitcode := cmd_cron(splitted[1], splitted[2], splitted[3]);
            91: exitcode := cmd_edit(splitted[1]);
            92: exitcode := cmd_erasescr;
            93: exitcode := cmd_savescr(splitted[1]);
            105: exitcode := cmd_carr(splitted[1], splitted[2]);
            106: exitcode := cmd_varr(splitted[1], splitted[2]);
            111: exitcode := cmd_dcon(splitted[1], splitted[2], splitted[3]);
            COMMARRSIZE - 1: exitcode := cmd_whatever(splitted[1], splitted[2], splitted[3], splitted[4], splitted[5], splitted[6]);
          else
          begin
            // logical functions
            if (b >= 23) and (b <= 28) then exitcode := cmd_logic(b, splitted[1], splitted[2], splitted[3]);
            if (b >= 58) and (b <= 59) then exitcode := cmd_logic(b, splitted[1], splitted[2], splitted[3]);
            if b = 67 then cmd_logic(b, splitted[1], splitted[2], splitted[3]);
            // arithmetical functions
            if (b >= 29) and (b <= 32) then exitcode := cmd_math(b, splitted[1], splitted[2], splitted[3], splitted[4]);
            if (b >= 42) and (b <= 57) then exitcode := cmd_math(b, splitted[1], splitted[2], splitted[3], splitted[4]);
            if b = 68 then exitcode := cmd_math(b, splitted[1], splitted[2], splitted[3], splitted[4]);
            if b = 75 then exitcode := cmd_math(b, splitted[1], splitted[2], splitted[3], splitted[4]);
            // string handler functions
            if (b >= 60) and (b <= 65) then exitcode := cmd_string(b, splitted[1], splitted[2], splitted[3]);
            if (b >= 76) and (b <= 77) then exitcode := cmd_string(b, splitted[1], splitted[2], splitted[3]);
            if (b >= 83) and (b <= 87) then exitcode := cmd_string(b, splitted[1], splitted[2], splitted[3]);
            // directory and file handler functions
            if (b >= 94) and (b <= 102) then exitcode := cmd_sys(b, splitted[1], splitted[2]);
            // lock file handler functions
            if (b >= 103) and (b <= 104) then exitcode := cmd_devlock(b, splitted[1]);
            // array handler functions
            if (b >= 107) and (b <= 110) then exitcode := cmd_arr(b, splitted[1], splitted[2]);
           end;
        end;
        vars[0].vvalue := inttostr(exitcode);
        {$IFDEF X}
          Form1.ComboBox1.Enabled := true;
          if f3active then Form3.Memo1.SetFocus; // else Form1.ComboBox1.SetFocus;
        {$ENDIF}
      end else {$IFNDEF X} writeln(ERR00); {$ELSE} Form1.Memo1.Lines.Add(ERR00 + command); {$ENDIF}
    end;
  end;
end;
