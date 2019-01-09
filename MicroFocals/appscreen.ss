       01 G-APPSCREEN.
         02 LINE 4 COL 56 VALUE "ษออออออออออออออออออออออป".
         02 LINE 5 COL 2 VALUE "ษอออออออออออออออออออออออออออออออออออออออ
      -"ออออออออออออออน Time :               บ".
         02 LINE 6 COL 2 VALUE "บ
      -"              บ Remaining time  :    บ".
         02 LINE 7 COL 2 VALUE "บ
      -"              ศออออออออออออออออออออออน".
         02 LINE 8 COL 2 VALUE "บ
      -"                                     บ".
         02 LINE 9 COL 2 VALUE "บ            ".
         02 COL 15 FOREGROUND-COLOR 6 HIGHLIGHT VALUE "S".
         02 COL 16 VALUE "chedule Appointment/Book in customer.......
      -"".
         02 COL 62 FOREGROUND-COLOR 6 HIGHLIGHT VALUE "S".
         02 COL 79 VALUE "บ".
         02 LINE 10 COL 2 VALUE "บ
      -"                                      บ".
         02 LINE 11 COL 2 VALUE "บ            ".
         02 COL 15 FOREGROUND-COLOR 6 HIGHLIGHT VALUE "R".
         02 COL 16 VALUE "eview Appointments..........................
      -"".
         02 COL 62 FOREGROUND-COLOR 6 HIGHLIGHT VALUE "R".
         02 COL 79 VALUE "บ".
         02 LINE 12 COL 2 VALUE "บ
      -"                                      บ".
         02 LINE 13 COL 2 VALUE "บ            Consultant ".
         02 COL 26 FOREGROUND-COLOR 6 HIGHLIGHT VALUE "A".
         02 COL 27 VALUE "vailability......................  ".
         02 COL 62 FOREGROUND-COLOR 6 HIGHLIGHT VALUE "A".
         02 COL 79 VALUE "บ".
         02 LINE 14 COL 2 VALUE "บ
      -"                                      บ".
         02 LINE 15 COL 2 VALUE "ฬออออออออออออออออออออออออออออออออออออออ
      -"ออออออออออออออออออออออออออออออออออออออน".
         02 LINE 16 COL 2 VALUE "บ
      -"                                      บ".
         02 LINE 17 COL 2 VALUE "บ            Customer, Store and Consul
      -"tant ".
         02 COL 46 FOREGROUND-COLOR 6 HIGHLIGHT VALUE "M".
         02 COL 47 VALUE "aintenance...  ".
         02 COL 62 FOREGROUND-COLOR 6 HIGHLIGHT VALUE "M".
         02 COL 79 VALUE "บ".
         02 LINE 18 COL 2 VALUE "บ
      -"                                      บ".
         02 LINE 19 COL 2 VALUE "ศออออออออออออออออออออออออออออออออออออออ
      -"ออออออออออออออออออออออออออออออออออออออผ".
         02 LINE 21 COL 15 VALUE "Menu Option :".
         02 LINE 5 COL 65.
         02 app-time-slot.
          004 PIC X(13) FROM ap-time-slot-msg.
           04 LINE + 1 COL - 1 PIC XX FROM ap-time-left-in-mins.
         02 LINE 21 COL 29 PIC X TO menu-option AUTO.
