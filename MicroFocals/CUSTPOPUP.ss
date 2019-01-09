       01 G-CUSTPOPUP.
         02 LINE 4 COL 2 VALUE "ษออCustomer look-upอออออออออออออออออออออ
      -"อออออออออออออออออออออออออออออออออออออป".
         02 LINE 5 COL 2 VALUE "บ Name :
      -"                                     บ".
         02 LINE 6 COL 2 VALUE "บ Initials :
      -"                                     บ".
         02 LINE 7 COL 2 VALUE "ฬอออออออออออออออออออออออออออออออออออออออ
      -"อออออออออออออออออออออออหอออออออออออออน".
         02 LINE 8 COL 2 VALUE "บ
      -"                       บ             บ".
         02 LINE 9 COL 2 VALUE "บ
      -"                       บ             บ".
         02 LINE 10 COL 2 VALUE "บ
      -"                        บ             บ".
         02 LINE 11 COL 2 VALUE "บ
      -"                        บ             บ".
         02 LINE 12 COL 2 VALUE "บ
      -"                        บ             บ".
         02 LINE 13 COL 2 VALUE "บ
      -"                        บ             บ".
         02 LINE 14 COL 2 VALUE "บ
      -"                        บ             บ".
         02 LINE 15 COL 2 VALUE "บ
      -"                        บ             บ".
         02 LINE 16 COL 2 VALUE "บ
      -"                        บ             บ".
         02 LINE 17 COL 2 VALUE "บ
      -"                        บ             บ".
         02 LINE 18 COL 2 VALUE "บ
      -"                        บ             บ".
         02 LINE 19 COL 2 VALUE "บ
      -"                        บ             บ".
         02 LINE 20 COL 2 VALUE "บ
      -"                        บ             บ".
         02 LINE 21 COL 2 VALUE "บ
      -"                        บ             บ".
         02 LINE 22 COL 2 VALUE "บ
      -"                        บ             บ".
         02 LINE 23 COL 2 VALUE "ศออออออออออออออออออออออออออออออออออออออ
      -"ออออออออออออออออออออออออสอออออออออออออผ".
         02 LINE 5 COL 16 BACKGROUND-COLOR 3 FOREGROUND-COLOR 0
       PIC X(60) USING cpc-query.
         02 LINE 6 COL 16 BACKGROUND-COLOR 3 FOREGROUND-COLOR 0
       PIC X(10) USING cpc-query-initials.
         02 LINE 8 COL 4 PIC X(60) FROM cp-fullname(1).
         02 LINE 8 COL 67 PIC X(11) FROM cp-initials(1).
         02 LINE 9 COL 4 PIC X(60) FROM cp-fullname(2).
         02 LINE 9 COL 67 PIC X(11) FROM cp-initials(2).
         02 LINE 10 COL 4 PIC X(60) FROM cp-fullname(3).
         02 LINE 10 COL 67 PIC X(11) FROM cp-initials(3).
         02 LINE 11 COL 4 PIC X(60) FROM cp-fullname(4).
         02 LINE 11 COL 67 PIC X(11) FROM cp-initials(4).
         02 LINE 12 COL 4 PIC X(60) FROM cp-fullname(5).
         02 LINE 12 COL 67 PIC X(11) FROM cp-initials(5).
         02 LINE 13 COL 4 PIC X(60) FROM cp-fullname(6).
         02 LINE 13 COL 67 PIC X(11) FROM cp-initials(6).
         02 LINE 14 COL 4 PIC X(60) FROM cp-fullname(7).
         02 LINE 14 COL 67 PIC X(11) FROM cp-initials(7).
         02 LINE 15 COL 4 PIC X(60) FROM cp-fullname(8).
         02 LINE 15 COL 67 PIC X(11) FROM cp-initials(8).
         02 LINE 16 COL 4 PIC X(60) FROM cp-fullname(9).
         02 LINE 16 COL 67 PIC X(11) FROM cp-initials(9).
         02 LINE 17 COL 4 PIC X(60) FROM cp-fullname(10).
         02 LINE 17 COL 67 PIC X(11) FROM cp-initials(10).
         02 LINE 18 COL 4 PIC X(60) FROM cp-fullname(11).
         02 LINE 18 COL 67 PIC X(11) FROM cp-initials(11).
         02 LINE 19 COL 4 PIC X(60) FROM cp-fullname(12).
         02 LINE 19 COL 67 PIC X(11) FROM cp-initials(12).
         02 LINE 20 COL 4 PIC X(60) FROM cp-fullname(13).
         02 LINE 20 COL 67 PIC X(11) FROM cp-initials(13).
         02 LINE 21 COL 4 PIC X(60) FROM cp-fullname(14).
         02 LINE 21 COL 67 PIC X(11) FROM cp-initials(14).
         02 LINE 22 COL 4 PIC X(60) FROM cp-fullname(15).
         02 LINE 22 COL 67 PIC X(11) FROM cp-initials(15).
