       01 G-CUSTNXKIN.
         02 LINE 4 COL 2 VALUE "����������������������������������������
      -"������������������������������������Ŀ".
         02 LINE 5 COL 2 VALUE "� Customer Id
      -"                                     �".
         02 LINE 6 COL 2 VALUE "� Next Information for:
      -"                                     �".
         02 LINE 7 COL 2 VALUE "�
      -"                                     �".
         02 LINE 8 COL 2 VALUE "����������������������������������������
      -"������������������������������������Ĵ".
         02 LINE 9 COL 2 VALUE "� Relationship to customer
      -"                                     �".
         02 LINE 10 COL 2 VALUE "� Gender     Title             Initials
      -"                                      �".
         02 LINE 11 COL 2 VALUE "� Name
      -"                                      �".
         02 LINE 12 COL 2 VALUE "� Address
      -"                                      �".
         02 LINE 13 COL 2 VALUE "�
      -"                                      �".
         02 LINE 14 COL 2 VALUE "�
      -"                                      �".
         02 LINE 15 COL 2 VALUE "�
      -"                                      �".
         02 LINE 16 COL 2 VALUE "� PostCode
      -"                                      �".
         02 LINE 17 COL 2 VALUE "� Country
      -"                                      �".
         02 LINE 18 COL 2 VALUE "�
      -"                                      �".
         02 LINE 19 COL 2 VALUE "� Home Email
      -"                                      �".
         02 LINE 20 COL 2 VALUE "� Work Email
      -"                                      �".
         02 LINE 21 COL 2 VALUE "� Home Tel                            W
      -"ork Tel                               �".
         02 LINE 22 COL 2 VALUE "���������������������������������������
      -"���������������������������������������".
         02 g-customer-id LINE 5 COL 17 BACKGROUND-COLOR 3
       FOREGROUND-COLOR 0 PIC 9(9) FROM cp-id.
         02 LINE 7 COL 10 PIC X(62) FROM cp-FullName.
         02 LINE 9 COL 30 BACKGROUND-COLOR 3 FOREGROUND-COLOR 0
       PIC X(30) USING nk-relationship.
         02 g-gender LINE 10 COL 11 BACKGROUND-COLOR 3 FOREGROUND-COLOR
       4 HIGHLIGHT PIC X USING nx-Gender AUTO FULL REQUIRED.
         02 g-title LINE 10 COL 21 BACKGROUND-COLOR 3 FOREGROUND-COLOR 0
       PIC X(9) FROM nx-title.
         02 g-initials LINE 10 COL 42 BACKGROUND-COLOR 3
       FOREGROUND-COLOR 0 PIC X(11) FROM nx-Initials.
         02 LINE 11 COL 10 BACKGROUND-COLOR 3 FOREGROUND-COLOR 0
       PIC X(62) USING nk-FullName AUTO REQUIRED.
         02 LINE 12 COL 12 BACKGROUND-COLOR 3 FOREGROUND-COLOR 0
       PIC X(66) USING nk-address(1) AUTO.
         02 LINE 13 COL 12 BACKGROUND-COLOR 3 FOREGROUND-COLOR 0
       PIC X(66) USING nk-address(2) AUTO.
         02 LINE 14 COL 12 BACKGROUND-COLOR 3 FOREGROUND-COLOR 0
       PIC X(66) USING nk-address(3) AUTO.
         02 LINE 15 COL 12 BACKGROUND-COLOR 3 FOREGROUND-COLOR 0
       PIC X(66) USING nk-address(4) AUTO.
         02 LINE 16 COL 15 BACKGROUND-COLOR 3 FOREGROUND-COLOR 0
       PIC X(9) USING nk-PostCode.
         02 LINE 17 COL 15 BACKGROUND-COLOR 3 FOREGROUND-COLOR 0
       PIC X(41) FROM nk-Country.
         02 LINE 19 COL 16 BACKGROUND-COLOR 3 FOREGROUND-COLOR 0
       PIC X(40) USING nk-Home-Email AUTO.
         02 LINE 20 COL 16 BACKGROUND-COLOR 3 FOREGROUND-COLOR 0
       PIC X(40) USING nk-Work-Email.
         02 LINE 21 COL 16 BACKGROUND-COLOR 3 FOREGROUND-COLOR 0
       PIC X(20) USING nk-Home-Tel AUTO REQUIRED.
         02 LINE 21 COL 49 BACKGROUND-COLOR 3 FOREGROUND-COLOR 0
       PIC X(21) USING nk-Work-Tel AUTO.
