{ +--------------------------------------------------------------------------+ }
{ | ModShell v0.1 * Command-driven scriptable Modbus utility                 | }
{ | Copyright (C) 2023-2025 Pozsar Zsolt <pozsarzs@gmail.com>                | }
{ | serport.pas                                                              | }
{ | serial port handler procedures and functions                             | }
{ +--------------------------------------------------------------------------+ }
{ 
  This program is free software: you can redistribute it and/or modify it
  under the terms of the European Union Public License 1.2 version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.
}

// TRUE IF THERE IS RECEIVED DATA
function ser_canread: boolean;
begin
  {$IFDEF GO32V2}
    result := canread;
  {$ELSE}
    result := ser.CanRead(0);
  {$ENDIF}
end;

// TRUE, ALL DATA HAS BEEN SENT
function ser_canwrite: boolean;
begin
  {$IFDEF GO32V2}
    result := canwrite;
  {$ELSE}
    result := ser.CanWrite(0);
  {$ENDIF}
end;

// READ CHAR FROM SERIAL PORT
function ser_recvbyte: byte;
begin
  {$IFDEF GO32V2}
    result := recvbyte;
  {$ELSE}
    result := ser.Recvbyte(0);
  {$ENDIF}
end;

// READ STRING FROM SERIAL PORT
function ser_recvstring: string;
begin
  {$IFDEF GO32V2}
    result := recvstring;
  {$ELSE}
    result := ser.RecvString(0);
  {$ENDIF}
end;

// WRITE CHAR TO SERIAL PORT
procedure ser_sendbyte(b: byte);
begin
  {$IFDEF GO32V2}
    sendbyte(b);
  {$ELSE}
    ser.SendByte(b);
  {$ENDIF}
end;

// WRITE STRING TO SERIAL PORT
procedure ser_sendstring(s: string);
begin
  {$IFDEF GO32V2}
    sendstring(s);
  {$ELSE}
    ser.SendString(s);
  {$ENDIF}
end;

// OPEN SERIAL PORT
function ser_open(device: string; speed: byte; databit: byte; parity: byte;
         stopbit: byte): boolean;
begin
  result := true;
  {$IFDEF GO32V2}
    connect(device);
    config(speed, databit, parity, stopbit);
  {$ELSE}
    ser := TBlockSerial.Create;
    try
      ser.Connect(device);
      ser.Config(strtoint(DEV_SPEED[speed]), databit, DEV_PARITY[parity],
                 stopbit, False, False);
    except
      result := false;
    end;
  {$ENDIF}
end;

// CLOSE SERIAL PORT
procedure ser_close;
begin
  {$IFDEF GO32V2}
    disconnect;
  {$ELSE}
    ser.Free;
  {$ENDIF}
end;
