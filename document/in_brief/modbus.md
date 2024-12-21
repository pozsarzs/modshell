## Modbus telegrams

### Abbreviations

|abbr.|meaning of the abbrevation                                        |
|:---:|------------------------------------------------------------------|
|ADU  |Application Data Unit (Mosbus frame)                              |
|CRC  |Cyclic Redundancy Check (CRC-16-ANSI also known as CRC-16-IBM)    |
|FC   |Function Code (1-127: REQUEST  and Response, 128-255 Exception FC)|
|LF   |Length Field                                                      |
|L    |Length (count of the following bytesfields: UI + PDU)             |
|LRC  |Longitudinal Redundancy Check                                     |
|MBAP |Modbus Application Protocol header                                |
|PDU  |Protocol Data Unit                                                |
|PI   |Protocol Identifier                                               |
|SA   |Slave Address (1-254)                                             |
|TI   |Transaction Identifier                                            |
|UI   |Unit Identifier (1-254)                                           |

### Registers

|data address|offset|reg. number|reg. type |table name                     |
|:----------:|:----:|:---------:|:--------:|:------------------------------|
|0000-9998   |00001 |00001-09999|read/write|discrete output coils          |
|0000-9998   |10001 |10001-19999|read only |discrete input contacts        |
|0000-9998   |30001 |30001-39999|read only |analog input registers         |
|0000-9998   |40001 |40001-49999|read/write|analog output holding registers|

The data addresses are used in the messages.

### Modbus/ASCII

PDU = FC + data  
ADU = SA + PDU + LRC(SA + PDU)  
telegram = 0x3A + ADU + 0x0D + 0x0A  

**PDU:**
|part     |size       |
|:-------:|----------:|
|FC       |2 chars    |
|data     |0-504 chars|
|**total**|2-506 chars|

**ADU:**
|part     |size       |
|:-------:|----------:|
|SA       |2 chars    |
|PDU      |2-506 chars|
|LRC      |2 chars    |
|**total**|8-510 chars|

**Telegram:**
|part     |size       |
|:-------:|----------:|
|_0x3A_   |2 chars    |
|ADU      |8-510 chars|
|_0x0D_   |2 chars    |
|_0x0A_   |2 chars    |
|**total**|4-516 chars|

### Modbus/RTU

PDU = FC + data  
ADU = SA + PDU + CRC(SA + PDU)  
telegram = ADU  

**PDU:**
|part     |size      |
|:-------:|---------:|
|FC       |1 byte    |
|data     |0-252 byte|
|**total**|1-253 byte|

**ADU:**
|part     |size      |
|:-------:|---------:|
|SA       |1 byte    |
|PDU      |1-253 byte|
|CRC      |2 byte    |
|**total**|4-256 byte|

**Telegram:**
|part     |size      |
|:-------:|---------:|
|ADU      |4-256 byte|
|**total**|4-256 byte|

### Modbus/TCP

PDU = FC + data  
MBAP = TI + PI + L + UI  
telegram = MBAP + PDU  

**PDU:**
|part     |size       |
|:-------:|----------:|
|FC       |1 byte     |
|data     |0-252 byte |
|**total**|1-253 byte |

**MBAP:**
|part     |size  |
|:-------:|-----:|
|TI       |2 byte|
|PI       |2 byte|
|L        |2 byte|
|UI       |1 byte|
|**total**|7 byte|

**Telegram:**
|part     |size       |
|:-------:|----------:|
|MBAP     |7 byte     |
|ADU      |4-256 byte |
|**total**|11-513 byte|

### Functions

In these examples:  
  - ID: 8  
  - ADDRESS: 255 
  - COUNT: 1  

**Read coils (FC = 0x01):**  
  ```
  REQUEST |     --ID--  --FC--  ---ADDRESS----  ----COUNT-----  -?RC--
  --------|-------------------------------------------------------------------
  ASCII   |  :   0   8   0   1   0   0   F   F   0   0   0   1   X   X  LF  CR
  RTU     |         08      01      00      FF      00      01  XX  XX

  RESPONSE|     --ID--   --FC--  BYTES-  ----DATA------  -?RC--
  --------|-----------------------------------------------------------
  ASCII   |  :   0   8   0   1   0   2   0   0   0   0   X   X  LF  CR
  RTU     |         08      01      02              00  XX  XX
  ```

**Read discrete inputs (FC = 0x02):**  
  ```
  REQUEST |     --ID--  --FC--  ---ADDRESS----  ----COUNT-----  -?RC--
  --------|-------------------------------------------------------------------
  ASCII   |  :   0   8   0   2   0   0   F   F   0   0   0   1   X   X  LF  CR
  RTU     |         08      02      00      FF      00      01  XX  XX

  RESPONSE|     --ID--  --FC--  BYTES-  ----DATA------  -?RC--
  --------|-----------------------------------------------------------
  ASCII   |  :   0   8   0   2   0   2   0   0   0   0   X   X  LF  CR
  RTU     |         08      02      02              00  XX  XX
  ```

**Read holding registers (FC = 0x03):**  
  ```
  REQUEST |     --ID--  --FC--  ---ADDRESS----  ----COUNT-----  -?RC--
  --------|-------------------------------------------------------------------
  ASCII   |  :   0   8   0   3   0   0   F   F   0   0   0   1   X   X  LF  CR
  RTU     |         08      03      00      FF      00      01  XX  XX

  RESPONSE|     --ID--  --FC--  BYTES-  ----DATA------  -?RC--
  --------|-----------------------------------------------------------
  ASCII   |  :   0   8   0   3   0   2   0   0   0   0   X   X  LF  CR
  RTU     |         08      03      02      00      00  XX  XX
  ```

**Read input registers (FC = 0x04):**  
  ```
  REQUEST |     --ID--  --FC--  ---ADDRESS----  ----COUNT-----  -?RC--
  --------|-------------------------------------------------------------------
  ASCII   |  :   0   8   0   4   0   0   F   F   0   0   0   1   X   X  LF  CR
  RTU     |         08      04      00      FF      00      01  XX  XX

  RESPONSE|     --ID--  --FC--  BYTES-  ----DATA------  -?RC--
  --------|-----------------------------------------------------------
  ASCII   |  :   0   8   0   4   0   2   0   0   0   0   X   X  LF  CR
  RTU     |         08      04      02      00      00  XX  XX
  ```

**Write multiple coils (FC = 0x0F):**  
  ```
  REQUEST |     --ID--  --FC--  ---ADDRESS----  ----COUNT-----  BYTES-  -----DATA-----  -?RC--
  --------|-------------------------------------------------------------------------------------------
  ASCII   |  :   0   8   0   F   0   0   F   F   0   0   1   0   0   2   0   0   0   0   X   X  LF  CR
  RTU     |         08      0F      00      FF      00      10      02      00      00  XX  XX

  RESPONSE|     --ID--  --FC--  ---ADDRESS----  ----COUNT-----   -?RC--
  --------|--------------------------------------------------------------------
  ASCII   |  :   0   8   0   F   0   0   F   F   0   0   1   0    X   X  LF  CR
  RTU     |         08      0F      00      FF      00      10   XX  XX
  ```

**Write multiple holding registers (FC = 0x10):**  
  ```
  REQUEST |     --ID--  --FC--  ---ADDRESS----  ----COUNT-----  BYTES-  -----DATA-----  -?RC--
  --------|-------------------------------------------------------------------------------------------
  ASCII   |  :   0   8   1   0   0   0   F   F   0   0   0   1   0   2  00  00  00  00   X   X  LF  CR
  RTU     |         08      10      00      FF      00      01      02      00      00  XX  XX

  RESPONSE|     --ID--  --FC--  ---ADDRESS----  ----COUNT-----   -?RC--
  --------|--------------------------------------------------------------------
  ASCII   |  :   0   8   1   0   0   0   F   F   0   0   0   1    X   X  LF  CR
  RTU     |         08      10      00      FF      00      01   XX  XX
  ```

### Error codes in the response

If FC+0x80 is present in place of FC, the following error codes may appear
in place of the number of bytes:
 - 0x01: Illegal function.
 - 0x02: Illegal data address.
 - 0x03: Illegal data value.
 - 0x04: Slave device failure.
