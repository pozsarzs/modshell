��    y      �  �   �      8
     9
     W
     u
     �
  &   �
     �
     �
  6   
  ;   A  &   }  :   �  7   �  ,     >   D      �  9   �  *   �     	          %     3     A     N     \     j  ]   x  0   �  8     0   @  ,   q  8   �  2   �  7   
  9   B  =   |     �     �  &   �  "     $   4     Y  "   x     �     �      �     �  %   	  (   /     X     w  0   �     �  7   �  7        ?     Y  A   s     �     �     �  &   �  '   &  4   N     �     �     �  l   �     *     A     ]  !   z  #   �  !   �     �               /     I  +   `     �  *   �     �     �  !   �          .     N     n  *  r  v   �  �        �     �  '   �             E   !  C   g     �     �  �   �     �     �     �     �       
   ,  �   7  |   �  E   g     �     �  J  �     2     R     r  f   �     �  �   �     �  �   �     �      �      �      �   '   !     :!     S!  =   m!  J   �!  #   �!  -   "  M   H"  $   �"  ?   �"  &   �"  <   "#  $   _#  
   �#     �#     �#     �#     �#     �#     �#     �#  ]   $  5   _$  E   �$  5   �$  &   %  <   8%  E   u%  C   �%  ?   �%  C   ?&     �&  #   �&  9   �&  1   �&  3   &'  (   Z'  2   �'  )   �'  0   �'  (   (  +   :(  .   f(  4   �(  +   �(  *   �(  7   !)     Y)  @   j)  B   �)  )   �)  ,   *  J   E*     �*  %   �*     �*  /   �*  1   +  7   N+     �+     �+     �+  {   �+     J,  /   h,  +   �,  &   �,  '   �,  &   -  #   :-     ^-     x-  +   �-  (   �-  ;   �-     '.  &   =.  !   d.     �.  E   �.     �.  !   /  !   #/     E/  g  I/  �   �0  �   71     �1  !   �1  $   2     12  %   62  Q   \2  I   �2     �2  %   
3  �   03  &   4  &   +4  !   R4     t4      �4     �4  �   �4  �   x5  K   6  &   P6  &   w6  Y  �6  !   �7  !   8  !   <8  u   ^8     �8  �   �8  !   }9     %   j   H   h   #   W   K   Z   r   P   2      ^   u       +             R          9   S       v           U                   -       C   ]   /      g   (   =   &   d           :              a   .   X   G          A   L   ;       b   
   Q   6              ,   l             "   e   !                 8   `         ?   >   D       3   0   *   i   \       J       p       <           c       $   V   Y   B      	   f       '   x          @       k            7   I   F       E   y   o   1      N   q   )                     n           M           5   s   T          _       4   w       t   m   [              O               AND logical operations        NOT logical operations        OR logical operations        XOR logical operations        addition mathematical operation        bit shift to left        bit shift to right        convert value between different numeral systems        copy one or more remote reg. between two connections        division mathematical operation        export command line history to make a script easily        list all variable with value or define a new one        multiplication mathematical operation        set foreground and background color in full screen mode        show system date and time        show version and build information of this program        substraction mathematical operation  IP address:   baudrate:     device UID:   device:       is not set.  port:         protocol:     settings:    <F1> help <F2> savecfg <F3> loadcfg <F4> savereg <F5> loadreg <F6> dump <F8> clear <F10> exit ALT-E  export value of the one or more registers ALT-G  show device, protocol, connection or project name ALT-I  import value of the one or more registers ALT-L  set value of a variable or a register ALT-P  print message, value of the variable and register ALT-R  read one or more remote registers to buffer ALT-S  set device, protocol, connection or project name ALT-T  reset device, protocol, connection or project name ALT-W  write data from buffer to one or more remote registers Calculating error! Cannot define more variable! Cannot export command line history to  Cannot export register content to  Cannot import register content from  Cannot initialize serial port! Cannot load register content from  Cannot load script from  Cannot load settings from  Cannot save register content to  Cannot save settings to  Command line history has exported to  Command-driven scriptable Modbus utility Connection number must be 0-7! Device number must be 0-7! F1     show description or usage of the commands F10    exit F2     save settings of device, protocol and connection F3     load settings of device, protocol and connection F4     save all registers F5     load all registers F6     dump all registers in binary/hexadecimal format to a table F8     clear screen File exist, overwrite? (y/n) IP address is not valid! Illegal character in the project name! Illegal character in the variable name! Local register type (dinp/coil/ireg/hreg: 1/2/3/4):  No such command! No such script file:  No such variable:  Note:\015
  - register: local buffer register\015
  - remote register: register of the connected device\015
 Parameter(s) required! Press a key to continue...  Protocol number must be 0-7! Register content has exported to  Register content has imported from  Register content has loaded from  Register content has saved to  Script buffer is full! Select register type:  Settings has loaded from  Settings has saved to  Sorry, this feature is not yet implemented. Start address (0-9990):  There is already a variable with that name UID must be 1-247! Usage this command: Use 'help COMMAND' to show usage. Useable file types:  add $TARGET [$]VALUE1 [$]VALUE2 and $TARGET [$]VALUE1 [$]VALUE2 cls color [$]FOREGROUND [$]BACKGROUND\015
  colors:\015
      0: black  4: red         8: darkgray    12: lightred\015
      1: blue   5: magenta:    9: lightblue   13: lightmagenta\015
      2: green  6: brown      10: lightgreen  14: yellow\015
      3: cyan   7: lightgray  11: lightcyan   15: white conv bin|dec|hex|oct bin|dec|hex|oct [$]VALUE\015
Notes:\015
  - The '$' sign indicates a variable not a direct value. copy con? dinp|coil con? coil [$]ADDRESS [[$]COUNT]\015
Notes:\015
  - The '$' sign indicates a variable not a direct value.\015
  - The '?' value can be 0-7. date div $TARGET [$]VALUE1 [$]VALUE2 dump [[dinp|coil|ireg|hreg] [$]ADDRESS] exit exphis [$]PATH_AND_FILENAME expreg [$]PATH_AND_FILENAME dinp|coil|ireg|hreg [$]ADDRESS [[$]COUNT] get dev?|pro?|con?|prj\015
Notes:\015
  - The '?' value can be 0-7. help [[$]COMMAND] impreg [$]PATH_AND_FILENAME let dinp|coil|ireg|hreg [$]ADDRESS [$]VALUE\015
  let $VARIABLE [$]VALUE\015
  let $VARIABLE dinp|coil|ireg|hreg [$]ADDRESS\015
Notes:\015
  - The '$' sign indicates a variable not a direct value. loadcfg [$]PATH_AND_FILENAME loadreg [$]PATH_AND_FILENAME mul $TARGET [$]VALUE1 [$]VALUE2 not $TARGET [$]VALUE or $TARGET [$]VALUE1 [$]VALUE2 parameter: print dinp|coil|ireg|hreg [$]ADDRESS [[$]COUNT]\015
  print $VARIABLE\015
  print "single\ line\ message"\015
Notes:\015
  - The '$' sign indicates a variable not a direct value. read con? dinp|coil|ireg|hreg [$]ADDRESS [[$]COUNT]\015
Notes:\015
  - The '$' sign indicates a variable not a direct value. reset dev?|pro?|con?|prj\015
Notes:\015
  - The '?' value can be 0-7. savecfg [$]PATH_AND_FILENAME savereg [$]PATH_AND_FILENAME set dev? net [$]DEVICE [$]PORT\015
  set dev? ser [$]DEVICE [$]BAUDRATE [$]DATABIT [$]PARITY [$]STOPBIT\015
  set pro? ascii|rtu [$]UID\015
  set pro? tcp [$]IP_ADDRESS\015
  set con? dev? pro?\015
  set prj [$]PROJECT_NAME\015
Notes:\015
  - The '$' sign indicates a variable not a direct value.\015
  - The '?' value can be 0-7. shl $TARGET [$]VALUE1 [$]VALUE2 shr $TARGET [$]VALUE1 [$]VALUE2 sub $TARGET [$]VALUE1 [$]VALUE2 var\015
  var NAME [[$]VALUE]\015
Notes:\015
  - The '$' sign indicates a variable not a direct value. ver write con? coil|hreg [$]ADDRESS [[$]COUNT]\015
Notes:\015
  - The '$' sign indicates a variable not a direct value.\015
  - The '?' value can be 0-7. xor $TARGET [$]VALUE1 [$]VALUE2 Project-Id-Version: 
PO-Revision-Date: 
Last-Translator: Pozsár Zsolt <pozsarzs@gmail.com>
Language-Team: 
Language: hu
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Generator: Poedit 3.2.2
        ÉS logikai művelet        NOT logikai művelet        VAGY logikai művelet        XOR logikai művelet        összeadás matematikai művelet        biteltolás balra        biteltolás jobbra        konvertálás a különböző számrendszerek között        egy vagy több távoli regiszter másolása két kapcsolat között        osztás matematikai művelet        parancssori előzmények exportálása        az összes változó kiírása az értékükkel vagy új létrehozása        szorzás matematikai művelet        előtér- és a háttérszín beállítása (fullscreen)        dátum és idő megjelenítése        változat és fordítási információk a programról        kivonás matematikai művelet  IP-cím:   sebesség:     eszköz UID:   eszköz:       nincs beállítva.  port:         protokoll:     beállítások:    <F1> help <F2> savecfg <F3> loadcfg <F4> savereg <F5> loadreg <F6> dump <F8> clear <F10> exit ALT-E  egy vagy több regisztertartalom exportálása Alt-G  eszköz, protokoll, kapcsolat vagy projektnév megjelenítése ALT-I  egy vagy több regisztertartalom importálása Alt-L  regisztertartalom beállítása ALT-P  üzenet, a változó vagy regisztertartalom kiírása Alt-R  adat olvasása egy vagy több távoli regiszterből a pufferbe Alt-S  eszköz, protokoll, kapcsolat vagy projektnév beállítása ALT-T  eszköz, protokoll, kapcsolat vagy projektnév törlése Alt-W  adat írása egy vagy több pufferből a távoli regiszterbe Számítási hiba! Nem lehet létrehozni a változót! Nem lehet exportálni a parancssori előzményeket ebbe:  Nem lehet exportálni a regisztertartalmat ebbe:  Nem lehet importálni a regisztertartalmat ebből:  Nem lehet inicializálni a soros portot! Nem lehet betölteni a regisztertartalmat ebből:  Nem lehet betölteni a szkriptet ebből:  Nem lehet betölteni a beállításokat ebből:  Nem mentheti a regisztertartalmat ebbe:  Nem lehet menteni a beállításokat ebbe:  A parancssori előzmények exportáltak ebbe:  Parancsvezérelt szkriptelhető Modbus segédprogram A kapcsolat számának 0-7-nek kell lennie! Az eszköz számának 0-7-nek kell lennie! F1     parancs leírás vagy használat megjelenítése F10    kilépés F2     Eszköz-, protokoll- és kapcsolatbeállítások mentése F3    eszköz-, protokoll- és kapcsolatbeállítások betöltése F5     összes regisztertartalom mentése F5     összes regisztertartalom betöltése F6     táblázatos regiszterkiírás bináris/hexadecimális formátumban F8     képernyőtörlés Létezik a fájl, felülírjam? (y/n) Az IP -cím nem érvényes! Nem engedélyezett karakter a projekt nevében! Nem engedélyezett karakter a változó nevében! Helyi regiszter típus (dinp/coil/ireg/hreg: 1/2/3/4):  Nincs ilyen parancs! Nincs ilyen szkriptfájl:  Nincs ilyen változó:  Megjegyzés:\015
  - regiszter: helyi puffer regiszter\015
  - távoli regiszter: a csatlakoztatott eszköz regisztere\015
 Paraméterek szükséges(ek)! Nyomjon meg egy billentyűt a folytatáshoz…  A protokoll számának 0-7-nek kell lennie! A regisztertartalom exportálva ebbe:  A regisztertartalom importált ebből:  A regisztertartalom betöltve ebből:  A regisztertartalom elmentve ebbe:  A szkript puffer megtelt! Válasszon regisztertípust:  A beállítások be lettek töltve ebből:  A beállítások el lettek mentve ebbe:  Sajnálom, hogy ez a szolgáltatás még nem valósult meg. Kezdőcím (0-9990):  Van már egy változó ezzel a névvel Az UID-nek 1-247-nek kell lennie! A parancs használata: Használja a „help PARANCS”-ot a használata megjelenítéséhez. Használható fájltípusok:  add $CÉL [$]ÉRTÉK1 [$]ÉRTÉK2 and $CÉL [$]ÉRTÉK1 [$]ÉRTÉK2 cls color [$]ELŐTÉRSZÍN [$]HÁTTÉRSZÍN\015

  Színek: \ 015
      0: fekete  4: vörös           8: sötétszürke  12: világosvörös\015
      1: kék     5: magenta:        9: világoskék   13: világosmagenta\015
      2: zöld    6: barna          10: világoszöld  14: sárga\015
      3: cián    7: világosszürke  11: világoscián  15: fehér conv bin|dec|hex|oct bin|dec|hex|oct [$]VALUE\015
Megjegyzés:\015
  - A '$' jel jelzi, hogy ez változó és nem közvetlen érték. copy con? dinp|coil con? coil [$]ADDRESS [[$]COUNT]\015
Megjegyzés:\015
  - A '$' jel jelzi, hogy ez változó és nem közvetlen érték.\015
  - A '?' értéke 0-7 lehet. date div $CÉL [$]ÉRTÉK1 [$]ÉRTÉK2 dump [[dinp|coil|ireg|hreg] [$]CÍM] exit exphis [$]ELÉRÉSI_ÚT_ÉS_FÁJLNÉV expreg [$]ELÉRÉSI_ÚT_ÉS_FÁJLNÉV dinp|coil|ireg|hreg [$]CÍM [[$]MENNYISÉG] get dev?|pro?|con?|prj\015
Megjegyzés:\015
  - A '?' értéke 0-7 lehet. help [[$]PARANCS] impreg [$]ELÉRÉSI_ÚT_ÉS_FÁJLNÉV let dinp|coil|ireg|hreg [$]ADDRESS [$]VALUE\015
  let $VARIABLE [$]VALUE\015
  let $VARIABLE dinp|coil|ireg|hreg [$]ADDRESS\015
Megjegyzés:\015
  - A '$' jel jelzi, hogy ez változó és nem közvetlen érték. loadcfg [$]ELÉRÉSI_ÚT_ÉS_FÁJLNÉV loadreg [$]ELÉRÉSI_ÚT_ÉS_FÁJLNÉV mul $CÉL [$]ÉRTÉK1 [$]ÉRTÉK2 not $CÉL [$]ÉRTÉK or $CÉL [$]ÉRTÉK1 [$]ÉRTÉK2 paraméter: print dinp|coil|ireg|hreg [$]ADDRESS [[$]COUNT]\015
  print $VARIABLE\015
  print "single\ line\ message"\015
Megjegyzés:\015
  - A '$' jel jelzi, hogy ez változó és nem közvetlen érték. read con? dinp|coil|ireg|hreg [$]ADDRESS [[$]COUNT]\015
Megjegyzés:\015
  - A '$' jel jelzi, hogy ez változó és nem közvetlen érték. reset dev?|pro?|con?|prj\015
Megjegyzés:\015
  - A '?' értéke 0-7 lehet. savecfg [$]ELÉRÉSI_ÚT_ÉS_FÁJLNÉV savereg [$]ELÉRÉSI_ÚT_ÉS_FÁJLNÉV set dev? net [$]DEVICE [$]PORT\015
  set dev? ser [$]DEVICE [$]BAUDRATE [$]DATABIT [$]PARITY [$]STOPBIT\015
  set pro? ascii|rtu [$]UID\015
  set pro? tcp [$]IP_ADDRESS\015
  set con? dev? pro?\015
  set prj [$]PROJECT_NAME\015
Megjegyzés:\015
  - A '$' jel jelzi, hogy ez változó és nem közvetlen érték.\015
  - A '?' értéke 0-7 lehet. shl $CÉL [$]ÉRTÉK1 [$]ÉRTÉK2 shr $CÉL [$]ÉRTÉK1 [$]ÉRTÉK2 sub $CÉL [$]ÉRTÉK1 [$]ÉRTÉK2 var\015
  var NAME [[$]VALUE]\015
Megjegyzés:\015
  - A '$' jel jelzi, hogy ez változó és nem közvetlen érték. ver write con? coil|hreg [$]ADDRESS [[$]COUNT]\015
Megjegyzés:\015
  - A '$' jel jelzi, hogy ez változó és nem közvetlen érték.\015
  - A '?' értéke 0-7 lehet. xor $CÉL [$]ÉRTÉK1 [$]ÉRTÉK2 