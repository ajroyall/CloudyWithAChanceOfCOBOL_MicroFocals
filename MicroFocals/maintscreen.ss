       01 G-MAINTSCREEN.
         02 LINE 5 COL 3 VALUE "зддддддддддддддддддддддддддддддддддддддд
      -"ддддддддддддддддддддддддддддддддддд©".
         02 LINE 6 COL 3 VALUE "Ё
      -"                                   Ё".
         02 LINE 7 COL 3 VALUE "Ё           ".
         02 COL 15 FOREGROUND-COLOR 6 HIGHLIGHT VALUE "C".
         02 COL 16 VALUE "ustomer records management..................
      -"".
         02 COL 62 FOREGROUND-COLOR 6 HIGHLIGHT VALUE "C".
         02 COL 78 VALUE "Ё".
         02 LINE 8 COL 3 VALUE "Ё
      -"                                   Ё".
         02 LINE 9 COL 3 VALUE "Ё           Store records ".
         02 COL 29 FOREGROUND-COLOR 6 HIGHLIGHT VALUE "M".
         02 COL 30 VALUE "aintenance....................   ".
         02 COL 62 FOREGROUND-COLOR 6 HIGHLIGHT VALUE "M".
         02 COL 78 VALUE "Ё".
         02 LINE 10 COL 3 VALUE "Ё
      -"                                    Ё".
         02 LINE 11 COL 3 VALUE "Ё           Consul".
         02 COL 21 FOREGROUND-COLOR 6 HIGHLIGHT VALUE "t".
         02 COL 22 VALUE "ant Maintenance.......................  ".
         02 COL 62 FOREGROUND-COLOR 6 HIGHLIGHT VALUE "T".
         02 COL 78 VALUE "Ё".
         02 LINE 12 COL 3 VALUE "Ё
      -"                                    Ё".
      $if use-sql defined
         02 LINE 13 COL 3 VALUE "Ё           Set ".
         02 COL 19 FOREGROUND-COLOR 6 HIGHLIGHT VALUE "W".
         02 COL 20 VALUE "elcome Message..........................  ".
         02 COL 62 FOREGROUND-COLOR 6 HIGHLIGHT VALUE "W".
         02 COL 78 VALUE "Ё".
         02 LINE 14 COL 3 VALUE "Ё
      -"                                    Ё".
       02 LINE 15
      $else
       02 LINE 13
      $end       
                    COL 3 VALUE "юдддддддддддддддддддддддддддддддддддддд
      -"дддддддддддддддддддддддддддддддддддды".
         02 LINE 17 COL 15 VALUE "Menu Option :".
         02 LINE 17 COL 29 PIC X TO menu-option AUTO.
