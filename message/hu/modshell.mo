��    [      �     �      �  6   �  ;      :   <  7   w  >   �      �  9   	     I	     W	     e	     s	     �	     �	     �	     �	  X   �	  0   
  8   B
  0   {
  ,   �
  8   �
  2     7   E  9   }  =   �     �  &     "   9  $   \     �  "   �     �      �     �  %     (   >     g     �  0   �     �  7   �  7        N     h     �     �     �  &   �  '   �       l   ,     �     �     �  !   �  #     !   /     Q     p     �  +   �  *   �     �       !        A     V  $  Z  v     �   �     �     �     �  <   �  C   �     9     H  �   a     &     @  
   Z  �   e  |     E   �     �     �  J    f   Z     �  �   �  �   [  =   I  J   �  -   �  M      ?   N  &   �  <   �  
   �     �               *     >     L     [  Y   o  5   �  E   �  5   E  &   {  <   �  E   �  C   %  ?   i  C   �  #   �  9     1   K  3   }  (   �  2   �  0      (   >   +   g   .   �   4   �   +   �   *   #!  7   N!     �!  @   �!  B   �!  )   "  ,   E"     r"  %   �"     �"  /   �"  1   �"     0#  {   E#     �#  /   �#  +   $  &   ;$  '   b$  &   �$  #   �$  +   �$  (   %  ;   *%  &   f%  !   �%     �%  E   �%     &     *&  a  .&  �   �'  �   (     �(     �(  "   �(  H   �(  I   :)     �)  "   �)  �   �)  #   �*  #   �*     �*  �   �*  �   �+  K   ,,  #   x,  #   �,  Y  �,  u   .     �.  �   �.                               D       [   /          5   )   @      Y   !   R   C   J   B                 3               8   O   S           K   P   U      <   6           T      A   M       W   E             '                  I   &                 L      ,   4      #       =          H          9      ;   F      Q           2           ?                      "   >       X   V   
       +   :      *   N       G      .       7   -      $   (   0   %   	           1      Z           convert value between different numeral systems        copy one or more remote reg. between two connections        export command line history to make a script easily        list all variable with value or define a new one        set foreground and background color in full screen mode        show system date and time        show version and build information of this program  IP address:   baudrate:     device UID:   device:       is not set.  port:         protocol:     settings:    <F1> help  <F2> savecfg  <F3> loadcfg  <F4> savereg  <F5> loadreg <F8> clear  <F10> exit ALT-E  export value of the one or more registers ALT-G  show device, protocol, connection or project name ALT-I  import value of the one or more registers ALT-L  set value of a variable or a register ALT-P  print message, value of the variable and register ALT-R  read one or more remote registers to buffer ALT-S  set device, protocol, connection or project name ALT-T  reset device, protocol, connection or project name ALT-W  write data from buffer to one or more remote registers Cannot define more variable! Cannot export command line history to  Cannot export register content to  Cannot import register content from  Cannot initialize serial port! Cannot load register content from  Cannot load settings from  Cannot save register content to  Cannot save settings to  Command line history has exported to  Command-driven scriptable Modbus utility Connection number must be 0-7! Device number must be 0-7! F1     show description or usage of the commands F10    exit F2     save settings of device, protocol and connection F3     load settings of device, protocol and connection F4     save all registers F5     load all registers F8     clear screen File exist, overwrite? (y/n) IP address is not valid! Illegal character in the project name! Illegal character in the variable name! No such command! Note:\015
  - register: local buffer register\015
  - remote register: register of the connected device\015
 Parameter(s) required! Press a key to continue...  Protocol number must be 0-7! Register content has exported to  Register content has imported from  Register content has loaded from  Register content has saved to  Settings has loaded from  Settings has saved to  Sorry, this feature is not yet implemented. There is already a variable with that name UID must be 1-247! Usage this command: Use 'help COMMAND' to show usage. Useable file types:  cls color FOREGROUND BACKGROUND\015
  colors:\015
      0: black  4: red         8: darkgray    12: lightred\015
      1: blue   5: magenta:    9: lightblue   13: lightmagenta\015
      2: green  6: brown      10: lightgreen  14: yellow\015
      3: cyan   7: lightgray  11: lightcyan   15: white conv bin|dec|hex|oct bin|dec|hex|oct [$]VALUE\015
Notes:\015
  - The '$' sign indicates a variable not a direct value. copy con? dinp|coil con? coil [$]ADDRESS [[$]COUNT]\015
Notes:\015
  - The '$' sign indicates a variable not a direct value.\015
  - The '?' value can be 0-7. date exit exphis PATH_AND_FILENAME expreg PATH_AND_FILENAME dinp|coil|ireg|hreg ADDRESS [COUNT] get dev?|pro?|con?|prj\015
Notes:\015
  - The '?' value can be 0-7. help [COMMAND] impreg PATH_AND_FILENAME let dinp|coil|ireg|hreg [$]ADDRESS [$]VALUE\015
  let $VARIABLE [$]VALUE\015
  let $VARIABLE dinp|coil|ireg|hreg [$]ADDRESS\015
Notes:\015
  - The '$' sign indicates a variable not a direct value. loadcfg PATH_AND_FILENAME loadreg PATH_AND_FILENAME parameter: print dinp|coil|ireg|hreg [$]ADDRESS [[$]COUNT]\015
  print $VARIABLE\015
  print "single\ line\ message"\015
Notes:\015
  - The '$' sign indicates a variable not a direct value. read con? dinp|coil|ireg|hreg [$]ADDRESS [[$]COUNT]\015
Notes:\015
  - The '$' sign indicates a variable not a direct value. reset dev?|pro?|con?|prj\015
Notes:\015
  - The '?' value can be 0-7. savecfg PATH_AND_FILENAME savereg PATH_AND_FILENAME set dev? net [$]DEVICE [$]PORT\015
  set dev? ser [$]DEVICE [$]BAUDRATE [$]DATABIT [$]PARITY [$]STOPBIT\015
  set pro? ascii|rtu [$]UID\015
  set pro? tcp [$]IP_ADDRESS\015
  set con? dev? pro?\015
  set prj [$]PROJECT_NAME\015
Notes:\015
  - The '$' sign indicates a variable not a direct value.\015
  - The '?' value can be 0-7. var\015
  var NAME [[$]VALUE]\015
Notes:\015
  - The '$' sign indicates a variable not a direct value. ver write con? coil|hreg [$]ADDRESS [[$]COUNT]\015
Notes:\015
  - The '$' sign indicates a variable not a direct value.\015
  - The '?' value can be 0-7. Project-Id-Version: 
PO-Revision-Date: 
Last-Translator: Pozsár Zsolt <pozsarzs@gmail.com>
Language-Team: 
Language: hu
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Generator: Poedit 3.2.2
        konvertálás a különböző számrendszerek között        egy vagy több távoli regiszter másolása két kapcsolat között        parancssori előzmények exportálása        az összes változó kiírása az értékükkel vagy új létrehozása        előtér- és a háttérszín beállítása (fullscreen)        dátum és idő megjelenítése        változat és fordítási információk a programról  IP-cím:   sebesség:     eszköz UID:   eszköz:       nincs beállítva.  port:         protokoll:     beállítások:    <F1> help  <F2> savecfg  <F3> loadcfg  <F4> savereg  <F5> loadreg  <F8> clear  <F10> exit ALT-E  egy vagy több regisztertartalom exportálása Alt-G  eszköz, protokoll, kapcsolat vagy projektnév megjelenítése ALT-I  egy vagy több regisztertartalom importálása Alt-L  regisztertartalom beállítása ALT-P  üzenet, a változó vagy regisztertartalom kiírása Alt-R  adat olvasása egy vagy több távoli regiszterből a pufferbe Alt-S  eszköz, protokoll, kapcsolat vagy projektnév beállítása ALT-T  eszköz, protokoll, kapcsolat vagy projektnév törlése Alt-W  adat írása egy vagy több pufferből a távoli regiszterbe Nem lehet létrehozni a változót! Nem lehet exportálni a parancssori előzményeket ebbe:  Nem lehet exportálni a regisztertartalmat ebbe:  Nem lehet importálni a regisztertartalmat ebből:  Nem lehet inicializálni a soros portot! Nem lehet betölteni a regisztertartalmat ebből:  Nem lehet betölteni a beállításokat ebből:  Nem mentheti a regisztertartalmat ebbe:  Nem lehet menteni a beállításokat ebbe:  A parancssori előzmények exportáltak ebbe:  Parancsvezérelt szkriptelhető Modbus segédprogram A kapcsolat számának 0-7-nek kell lennie! Az eszköz számának 0-7-nek kell lennie! F1     parancs leírás vagy használat megjelenítése F10    kilépés F2     Eszköz-, protokoll- és kapcsolatbeállítások mentése F3    eszköz-, protokoll- és kapcsolatbeállítások betöltése F5     összes regisztertartalom mentése F5     összes regisztertartalom betöltése F8     képernyőtörlés Létezik a fájl, felülírjam? (y/n) Az IP -cím nem érvényes! Nem engedélyezett karakter a projekt nevében! Nem engedélyezett karakter a változó nevében! Nincs ilyen parancs! Megjegyzés:\015
  - regiszter: helyi puffer regiszter\015
  - távoli regiszter: a csatlakoztatott eszköz regisztere\015
 Paraméterek szükséges(ek)! Nyomjon meg egy billentyűt a folytatáshoz…  A protokoll számának 0-7-nek kell lennie! A regisztertartalom exportálva ebbe:  A regisztertartalom importált ebből:  A regisztertartalom betöltve ebből:  A regisztertartalom elmentve ebbe:  A beállítások be lettek töltve ebből:  A beállítások el lettek mentve ebbe:  Sajnálom, hogy ez a szolgáltatás még nem valósult meg. Van már egy változó ezzel a névvel Az UID-nek 1-247-nek kell lennie! A parancs használata: Használja a „help PARANCS”-ot a használata megjelenítéséhez. Használható fájltípusok:  cls color ELŐTÉRSZÍN HÁTTÉRSZÍN\015

  Színek: \ 015
      0: fekete  4: vörös           8: sötétszürke  12: világosvörös\015
      1: kék     5: magenta:        9: világoskék   13: világosmagenta\015
      2: zöld    6: barna          10: világoszöld  14: sárga\015
      3: cián    7: világosszürke  11: világoscián  15: fehér conv bin|dec|hex|oct bin|dec|hex|oct [$]VALUE\015
Megjegyzés:\015
  - A '$' jel jelzi, hogy ez változó és nem közvetlen érték. copy con? dinp|coil con? coil [$]ADDRESS [[$]COUNT]\015
Megjegyzés:\015
  - A '$' jel jelzi, hogy ez változó és nem közvetlen érték.\015
  - A '?' értéke 0-7 lehet. date exit exphis ELÉRÉSI_ÚT_ÉS_FÁJLNÉV expreg ELÉRÉSI_ÚT_ÉS_FÁJLNÉV dinp|coil|ireg|hreg CÍM [MENNYISÉG] get dev?|pro?|con?|prj\015
Megjegyzés:\015
  - A '?' értéke 0-7 lehet. help [PARANCS] impreg ELÉRÉSI_ÚT_ÉS_FÁJLNÉV let dinp|coil|ireg|hreg [$]ADDRESS [$]VALUE\015
  let $VARIABLE [$]VALUE\015
  let $VARIABLE dinp|coil|ireg|hreg [$]ADDRESS\015
Megjegyzés:\015
  - A '$' jel jelzi, hogy ez változó és nem közvetlen érték. loadcfg ELÉRÉSI_ÚT_ÉS_FÁJLNÉV loadreg ELÉRÉSI_ÚT_ÉS_FÁJLNÉV paraméter: print dinp|coil|ireg|hreg [$]ADDRESS [[$]COUNT]\015
  print $VARIABLE\015
  print "single\ line\ message"\015
Megjegyzés:\015
  - A '$' jel jelzi, hogy ez változó és nem közvetlen érték. read con? dinp|coil|ireg|hreg [$]ADDRESS [[$]COUNT]\015
Megjegyzés:\015
  - A '$' jel jelzi, hogy ez változó és nem közvetlen érték. reset dev?|pro?|con?|prj\015
Megjegyzés:\015
  - A '?' értéke 0-7 lehet. savecfg ELÉRÉSI_ÚT_ÉS_FÁJLNÉV savereg ELÉRÉSI_ÚT_ÉS_FÁJLNÉV set dev? net [$]DEVICE [$]PORT\015
  set dev? ser [$]DEVICE [$]BAUDRATE [$]DATABIT [$]PARITY [$]STOPBIT\015
  set pro? ascii|rtu [$]UID\015
  set pro? tcp [$]IP_ADDRESS\015
  set con? dev? pro?\015
  set prj [$]PROJECT_NAME\015
Megjegyzés:\015
  - A '$' jel jelzi, hogy ez változó és nem közvetlen érték.\015
  - A '?' értéke 0-7 lehet. var\015
  var NAME [[$]VALUE]\015
Megjegyzés:\015
  - A '$' jel jelzi, hogy ez változó és nem közvetlen érték. ver write con? coil|hreg [$]ADDRESS [[$]COUNT]\015
Megjegyzés:\015
  - A '$' jel jelzi, hogy ez változó és nem közvetlen érték.\015
  - A '?' értéke 0-7 lehet. 