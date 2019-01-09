       01 G-GENCUSTOMERS.
         02 LINE 1 COL 2 VALUE "旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
      -"컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커".
         02 LINE 2 COL 2 VALUE "�             Micro Focal Random Custome
      -"r Data File Generator                �".
         02 LINE 3 COL 2 VALUE "읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴
      -"컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸".
         02 LINE 4 COL 41 FOREGROUND-COLOR 4 HIGHLIGHT VALUE "WARNING:".
         02 COL 50 FOREGROUND-COLOR 4 HIGHLIGHT VALUE "No".
         02 COL 53 FOREGROUND-COLOR 4 HIGHLIGHT VALUE "validation".
         02 COL 64 FOREGROUND-COLOR 4 HIGHLIGHT VALUE "is".
         02 COL 67 FOREGROUND-COLOR 4 HIGHLIGHT VALUE "done...".
         02 LINE 6 COL 4 VALUE "Country Name            :".
         02 LINE 7 COL 4 VALUE "Home Telephone Prefix   :".
         02 LINE 8 COL 4 VALUE "Work Telephone Prefix   :".
         02 LINE 9 COL 4 VALUE "Home Email domain       :".
         02 LINE 10 COL 4 VALUE "Work Email domain       :".
         02 LINE 11 COL 4 VALUE "Gender                  :".
         02 LINE 13 COL 4 VALUE "How many records to generate?  :".
         02 LINE 6 COL 30 PIC X(49) FROM ws-country.
         02 LINE 7 COL 30 PIC X(7) FROM ws-htel-prefix.
         02 LINE 8 COL 30 PIC X(7) FROM ws-wtel-prefix.
         02 LINE 9 COL 30 PIC X(25) USING ws-homeemail-dom.
         02 LINE 10 COL 30 PIC X(25) USING ws-workemail-dom.
         02 LINE 11 COL 30 PIC X USING ws-gender.
         02 LINE 13 COL 37 PIC 9(7) USING ws-to-generate-count.
