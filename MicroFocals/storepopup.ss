       01 G-STOREPOPUP.
         02 LINE 4 COL 2 VALUE "ษอStore Locatorอออออออออออออออออออออออออ
      -"อออออออออออออออออออออออออออออออออออออป".
         02 LINE 5 COL 2 VALUE "บ Name/Postcode
      -"                                     บ".
         02 LINE 6 COL 2 VALUE "ฬอออออออออออออออออออออออออออออออออออออออ
      -"อออหอออออออออออออออออออออออหอออออออออน".
         02 LINE 7 COL 2 VALUE "บ
      -"   บ                       บ         บ".
         02 LINE 8 COL 2 VALUE "บ
      -"   บ                       บ         บ".
         02 LINE 9 COL 2 VALUE "บ
      -"   บ                       บ         บ".
         02 LINE 10 COL 2 VALUE "บ
      -"    บ                       บ         บ".
         02 LINE 11 COL 2 VALUE "บ
      -"    บ                       บ         บ".
         02 LINE 12 COL 2 VALUE "บ
      -"    บ                       บ         บ".
         02 LINE 13 COL 2 VALUE "บ
      -"    บ                       บ         บ".
         02 LINE 14 COL 2 VALUE "บ
      -"    บ                       บ         บ".
         02 LINE 15 COL 2 VALUE "บ
      -"    บ                       บ         บ".
         02 LINE 16 COL 2 VALUE "บ
      -"    บ                       บ         บ".
         02 LINE 17 COL 2 VALUE "บ
      -"    บ                       บ         บ".
         02 LINE 18 COL 2 VALUE "บ
      -"    บ                       บ         บ".
         02 LINE 19 COL 2 VALUE "บ
      -"    บ                       บ         บ".
         02 LINE 20 COL 2 VALUE "บ
      -"    บ                       บ         บ".
         02 LINE 21 COL 2 VALUE "บ
      -"    บ                       บ         บ".
         02 LINE 22 COL 2 VALUE "ศออออออออออออออออออออออออออออออออออออออ
      -"ออออสอออออออออออออออออออออออสอออออออออผ".
         02 LINE 5 COL 18 BACKGROUND-COLOR 3 FOREGROUND-COLOR 0
       PIC X(60) USING sp-query.
         02 LINE 7 COL 4 PIC X(40) FROM sp-name-of-store(1).
         02 LINE 7 COL 47 PIC X(21) USING sp-postcode(1).
         02 LINE 7 COL 72 PIC 9(5) USING sp-id(1) BLANK ZERO.
         02 LINE 8 COL 4 PIC X(40) FROM sp-name-of-store(2).
         02 LINE 8 COL 47 PIC X(21) USING sp-postcode(2).
         02 LINE 8 COL 72 PIC 9(5) USING sp-id(2) BLANK ZERO.
         02 LINE 9 COL 4 PIC X(40) FROM sp-name-of-store(3).
         02 LINE 9 COL 47 PIC X(21) USING sp-postcode(3).
         02 LINE 9 COL 72 PIC 9(5) USING sp-id(3) BLANK ZERO.
         02 LINE 10 COL 4 PIC X(40) FROM sp-name-of-store(4).
         02 LINE 10 COL 47 PIC X(21) USING sp-postcode(4).
         02 LINE 10 COL 72 PIC 9(5) USING sp-id(4) BLANK ZERO.
         02 LINE 11 COL 4 PIC X(40) FROM sp-name-of-store(5).
         02 LINE 11 COL 47 PIC X(21) USING sp-postcode(5).
         02 LINE 11 COL 72 PIC 9(5) USING sp-id(5) BLANK ZERO.
         02 LINE 12 COL 4 PIC X(40) FROM sp-name-of-store(6).
         02 LINE 12 COL 47 PIC X(21) USING sp-postcode(6).
         02 LINE 12 COL 72 PIC 9(5) USING sp-id(6) BLANK ZERO.
         02 LINE 13 COL 4 PIC X(40) FROM sp-name-of-store(7).
         02 LINE 13 COL 47 PIC X(21) USING sp-postcode(7).
         02 LINE 13 COL 72 PIC 9(5) USING sp-id(7) BLANK ZERO.
         02 LINE 14 COL 4 PIC X(40) FROM sp-name-of-store(8).
         02 LINE 14 COL 47 PIC X(21) USING sp-postcode(8).
         02 LINE 14 COL 72 PIC 9(5) USING sp-id(8) BLANK ZERO.
         02 LINE 15 COL 4 PIC X(40) FROM sp-name-of-store(9).
         02 LINE 15 COL 47 PIC X(21) USING sp-postcode(9).
         02 LINE 15 COL 72 PIC 9(5) USING sp-id(9) BLANK ZERO.
         02 LINE 16 COL 4 PIC X(40) FROM sp-name-of-store(10).
         02 LINE 16 COL 47 PIC X(21) USING sp-postcode(10).
         02 LINE 16 COL 72 PIC 9(5) USING sp-id(10) BLANK ZERO.
         02 LINE 17 COL 4 PIC X(40) FROM sp-name-of-store(11).
         02 LINE 17 COL 47 PIC X(21) USING sp-postcode(11).
         02 LINE 17 COL 72 PIC 9(5) USING sp-id(11) BLANK ZERO.
         02 LINE 18 COL 4 PIC X(40) FROM sp-name-of-store(12).
         02 LINE 18 COL 47 PIC X(21) USING sp-postcode(12).
         02 LINE 18 COL 72 PIC 9(5) USING sp-id(12) BLANK ZERO.
         02 LINE 19 COL 4 PIC X(40) FROM sp-name-of-store(13).
         02 LINE 19 COL 47 PIC X(21) USING sp-postcode(13).
         02 LINE 19 COL 72 PIC 9(5) USING sp-id(13) BLANK ZERO.
         02 LINE 20 COL 4 PIC X(40) FROM sp-name-of-store(14).
         02 LINE 20 COL 47 PIC X(21) USING sp-postcode(14).
         02 LINE 20 COL 72 PIC 9(5) USING sp-id(14) BLANK ZERO.
         02 LINE 21 COL 4 PIC X(40) FROM sp-name-of-store(15).
         02 LINE 21 COL 47 PIC X(21) USING sp-postcode(15).
         02 LINE 21 COL 72 PIC 9(5) USING sp-id(15) BLANK ZERO.
