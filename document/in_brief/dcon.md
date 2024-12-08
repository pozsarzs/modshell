## DCON syntax

### Abbreviations

|abbr.|meaning of the abbreviation        |
|:---:|-----------------------------------|
|DC   |Delimiter Character ($, #, % and @)|
|AD   |Address                            |
|CMD  |Command                            |
|CS   |Checksum                           |

### Message

Message = DC + AD + CMD + data (+ CS)

|part     |size      |
|:-------:|----------|
|DC       |1  char   |
|AD       |2  chars  |
|CMD      |1+ chars  |
|data     |0+ chars  |
|CS       |(2  chars)|
|0x0D     |2  chars  |
|**total**|5+ chars  |

### Checksum

The checksum equals to the result after performing modulus-256 of all
the ASCII values' sum preceding the checksum.  

Example:  
  ```
  Command: $07RH25(cr)
    DC:          $
    AD:         07
    CMD + data: RH
    CS:         25

    CS   = (DC   + AD   + CMD + data        ) mod 0x100
    0x25 = (0x24 + 0x30 + 0x37 + 0x52 + 0x48) mod 0x100
  ```
All commands should be issued in uppercase characters!  
