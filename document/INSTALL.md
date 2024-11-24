## Installation from source package

Lazarus LCL units are required to compile XModShell and FreePascal compiler is
required to compile both of them programs.  

> [!NOTE]
> On DOS and Windows operating systems, FreePascal's BIN directory contains the
> compiler and additional necessary utilities (make, rstconv), so this directory
> must be included in the PATH.

### 1. On Unix-like systems
  
  Build:      `$ ./configure [cui=no] [gui=no] [stagedir=...]`  
              `$ make`  
  Install:    `# sudo make install`  
  Remove:     `# make uninstall`  

### 2. On Windows
  
  Build:      `> cd source`  
              `> buildw??.bat [/nocui] [/nogui]`  

### 3. On DOS
  
  Build:      `> cd source`  
              `> builddos.bat`  
