{ +--------------------------------------------------------------------------+ }
{ | ModShell v0.1 * Command-driven scriptable Modbus utility                 | }
{ | Copyright (C) 2023-2025 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | mbutil.pas                                                               | }
{ | Modbus utilities                                                         | }
{ +--------------------------------------------------------------------------+ }
{ 
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}

// DECODE TELEGRAM
function mbdecodetelegram(protocol, filter, telegram: string): string;
var
  cs: word;
  cs_ok: boolean = false;
  data: string = '';
  fc: string;
  i: integer;
  id: string;
  s: string;
  show_cscheck: boolean = false;
begin
  if protocol = PROT_TYPE[0] then
  begin
    // ASCII
    if telegram[1] = #58 then
      if telegram[length(telegram) - 1] + telegram[length(telegram)] = EOL then
      begin
        id := inttostr(strtoint('$' + telegram[2] + telegram[3]));
        if (filter = '0') or (filter = id) then
        begin
          fc := telegram[4] + telegram[5];
          for i := 6 to length(telegram) - 4 do data := data + telegram[i];
          cs := strtoint('$' + telegram[length(telegram) - 3] +
                telegram[length(telegram) - 2]);
          // checksum test
          cs_ok := checklrc(telegram[2] + telegram[3] + telegram[4] +
                   telegram[5] + data, cs);
          show_cscheck := true;
        end else data := '[...]';
      end;
  end else
  begin
    // RTU
    id := inttostr(ord(telegram[1]));
    if (filter = '0') or (filter = id) then
    begin
      fc := addsomezero(2, deztohex(inttostr(ord(telegram[2]))));
      for i := 3 to length(telegram) - 2 do
        data := data + addsomezero(2, deztohex(inttostr(ord(telegram[i]))));
      cs := ord(telegram[length(telegram) - 1]) +
            ord(telegram[length(telegram)]) * 256;
      // checksum test
      s := telegram;
      delete(s, length(telegram) - 1, 2);
      cs_ok := checkcrc16(s, cs);
      show_cscheck := true;
    end else data := '[...]';
  end;
  // split data to bytes
  b := 1;
  s := '';
  repeat
    s := s + data[b] + data[b + 1] + #32;
    b := b + 2;
  until b >= length(data) + 1;
  data := s;
  result:= addsomezero(3, id) + '  ' + fc + '  ' + data;
  // show result of the checksum check
  if show_cscheck then
    if cs_ok then result := MSG17 + result else result := MSG18 + result;
end;
