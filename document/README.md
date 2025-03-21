## Modshell - Command-driven scriptable Modbus utility

### 1. About software

This is a utility that can be used on several operating systems, which can
communicate with connected equipment using Modbus/ASCII and -/RTU
protocols. The program can - even automatically - read, write or copy data from
one device to another (e.g. transferring settings). The basic communication
protocol of the program is Modbus, but DCON and HART was also implemented due to
communication with other devices.

### 2. How to get installer package for my OS?

**Visit homepage (see later) to download installer packages:**  

|operation system|arch.|package name                  |note  |
|----------------|:---:|------------------------------|------|
|DOS             |i386 |modsh01.exe                   |(SFX) |
|                |i386 |modsh01.zip                   |      |
|FreeDOS         |i386 |modsh01.zip                   |      |
|                |amd64|modshell-0.1-linux-amd64.bin  |(SFX) |
|                |amd64|modshell-0.1-linux-amd64.zip  |      |
|                |armhf|modshell-0.1-linux-armhf.bin  |(SFX) |
|                |armhf|modshell-0.1-linux-armhf.zip  |      |
|Linux           |i386 |modshell-0.1-linux-i386.bin   |(SFX) |
|                |i386 |modshell-0.1-linux-i386.zip   |      |
|                |amd64|modshell_0.1-1_amd64.deb      |      |
|Debian GNU/Linux|i386 |modshell_0.1-1_i386.deb       |      |
|Raspberry Pi OS |armhf|modshell_0.1-1_armhf.deb      |      |
|OpenSuSE        |i386 |modshell-0.1-1.i586.rpm       |      |
|                |amd64|modshell-0.1-1.amd64.rpm      |      |
|Slackware       |i386 |modshell-0.1-i586-1.txz       |      |
|                |amd64|modshell-0.1-amd64-1.txz      |      |
|FreeBSD         |i386 |modshell-0.1-freebsd-i386.bin |(SFX) |
|                |i386 |modshell-0.1-freebsd-i386.zip |      |
|                |amd64|modshell-0.1-freebsd-amd64.bin|(SFX) |
|                |amd64|modshell-0.1-freebsd-amd64.zip|      |
|                |i386 |modshell-0.1.txz              |      |
|                |amd64|modshell-0.1.txz              |      |
|                |i586 |modshell-0.1-win32.exe        |      |
|                |i586 |modshell-0.1-win32.msi        |      |
|Windows         |i586 |modshell-0.1-win32.zip        |      |
|                |amd64|modshell-0.1-win64.exe        |      |
|                |amd64|modshell-0.1-win64.msi        |      |
|                |amd64|modshell-0.1-win64.zip        |      |
|all             |all  |modshell-0.1.tar.gz           |source|

**b. Download from Github**  
  
  ```
  $ git clone https://github.com/pozsarzs/modshell.git
  ```  
  
**c. Download from Debian repository**  
  
  set reporitory:  
  ```
  $ sudo echo "deb http://www.pozsarzs.hu/deb/ ./" >> /etc/apt/sources.list
  $ sudo wget -q -O - http://www.pozsarzs.hu/deb/KEY.gpg | apt-key add -
  $ sudo apt-get update
  ```
  install:  
  ```
  $ sudo apt-get install modshell
  ```  

**_Note:_**  

  How to resolve _Key is stored in legacy trusted.gpg keyring_ warning message:

  List all the GPG keys added to your system:
  ```
  $ sudo apt-key list
  ```
  Search dpkg1@szerafingomba.hu's public key:
  ```
    /etc/apt/trusted.gpg
    --------------------
    pub   rsa4096 2019-12-04 [SCEA]
          0503 875E 0F22 8B99 C057  9E0A 97AB CE11 F36E 9EE8
    uid           [ unknown] dpkg1 <dpkg1@szerafingomba.hu>
  ```  
  Copy dearmored key to the new place:
  ```
  $ sudo apt-key export f36e9ee8 | sudo gpg --dearmour -o /etc/apt/trusted.gpg.d/pozsarzs.gpg
  ```

### 3. Contact

  Homepage: <https://pozsarzs.github.io/modshell> and <http://www.pozsarzs.hu>  
  Author: Pozsár Zsolt <pozsarzs@gmail.com>  
