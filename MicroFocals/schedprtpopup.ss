       01 G-SCHEDPRTPOPUP.
         02 LINE 5 COL 10 BACKGROUND-COLOR 3 BLINK FOREGROUND-COLOR 0
       VALUE "��Print Daily Appointments��������������������������Ŀ".
         02 LINE 6 COL 10 BACKGROUND-COLOR 3 BLINK FOREGROUND-COLOR 0
       VALUE "�                                                    �".
         02 LINE 7 COL 10 BACKGROUND-COLOR 3 BLINK FOREGROUND-COLOR 0
       VALUE "�  On disk report file        : ".
         02 COL 61 BACKGROUND-COLOR 3 BLINK FOREGROUND-COLOR 0 VALUE
       "  �".
         02 LINE 8 COL 10 BACKGROUND-COLOR 3 BLINK FOREGROUND-COLOR 0
       VALUE "�                                                    �".
         02 LINE 9 COL 10 BACKGROUND-COLOR 3 BLINK FOREGROUND-COLOR 0
       VALUE "�  Include customer details?  : ".
         02 COL 43 BACKGROUND-COLOR 3 BLINK FOREGROUND-COLOR 0 VALUE
       "                    �".
         02 LINE 10 COL 10 BACKGROUND-COLOR 3 BLINK FOREGROUND-COLOR 0
       VALUE "�                                                    �".
         02 LINE 11 COL 10 BACKGROUND-COLOR 3 BLINK FOREGROUND-COLOR 0
       VALUE "�  Send report to printer     : ".
         02 COL 43 BACKGROUND-COLOR 3 BLINK FOREGROUND-COLOR 0 VALUE
       "                    �".
         02 LINE 12 COL 10 BACKGROUND-COLOR 3 BLINK FOREGROUND-COLOR 0
       VALUE "�                                                    �".
         02 LINE 13 COL 10 BACKGROUND-COLOR 3 BLINK FOREGROUND-COLOR 0
       VALUE "������������������������������������������������������".
         02 LINE 7 COL 42 BACKGROUND-COLOR 3 BLINK FOREGROUND-COLOR 0
       PIC X(19) USING pdr-filename AUTO.
         02 LINE 9 COL 42 BACKGROUND-COLOR 3 BLINK FOREGROUND-COLOR 0
       PIC X USING pdr-include-cust-details AUTO.
         02 LINE 11 COL 42 BACKGROUND-COLOR 3 BLINK FOREGROUND-COLOR 0
       PIC X USING pdr-send-to-printer AUTO.
