       01 G-SCHEDAPP.
         02 LINE 4 COL 2 VALUE "����������������������������������������
      -"������������������������������������Ŀ".
         02 LINE 5 COL 2 VALUE "� Customer
      -"                                     �".
         02 LINE 6 COL 2 VALUE "�
      -"                                     �".
         02 LINE 7 COL 2 VALUE "� Consultant.....
      -"                                     �".
         02 LINE 8 COL 2 VALUE "�
      -"                                     �".
         02 LINE 9 COL 2 VALUE "� Date Required..
      -"              Key: ".
         02 COL 61 FOREGROUND-COLOR 6 HIGHLIGHT VALUE "A".
         02 COL 62 VALUE "=toogle ".
         02 COL 70 FOREGROUND-COLOR 6 HIGHLIGHT VALUE "A".
         02 COL 71 VALUE "ttended �".
         02 LINE 10 COL 2 VALUE "�
      -"                    ".
         02 COL 61 FOREGROUND-COLOR 6 HIGHLIGHT VALUE "B".
         02 COL 62 VALUE "=toogle ".
         02 COL 70 FOREGROUND-COLOR 6 HIGHLIGHT VALUE "B".
         02 COL 71 VALUE "ooking  �".
         02 LINE 11 COL 2 VALUE "���������������������������������������
      -"�������������������������������������Ĵ".
         02 LINE 12 COL 2 VALUE "�Morning:                             �
      -"Afternoon:                            �".
         02 LINE 13 COL 2 VALUE "�                                     �
      -"                                      �".
         02 LINE 14 COL 2 VALUE "�                                     �
      -"                                      �".
         02 LINE 15 COL 2 VALUE "�                                     �
      -"                                      �".
         02 LINE 16 COL 2 VALUE "�                                     �
      -"                                      �".
         02 LINE 17 COL 2 VALUE "�                                     �
      -"                                      �".
         02 LINE 18 COL 2 VALUE "�                                     �
      -"                                      �".
         02 LINE 19 COL 2 VALUE "�                                     �
      -"                                      �".
         02 LINE 20 COL 2 VALUE "�                                     �
      -"                                      �".
         02 LINE 21 COL 2 VALUE "�                                     �
      -"                                      �".
         02 LINE 22 COL 2 VALUE "�                                     �
      -"                                      �".
         02 LINE 23 COL 2 VALUE "�                                     �
      -"                                      �".
         02 LINE 24 COL 2 VALUE "�                                     �
      -"                                      �".
         02 LINE 25 COL 2 VALUE "���������������������������������������
      -"���������������������������������������".
         02 LINE 5 COL 19 BACKGROUND-COLOR 3 FOREGROUND-COLOR 0
       PIC X(60) FROM sa-cust-fullname.
         02 LINE 7 COL 19 BACKGROUND-COLOR 3 FOREGROUND-COLOR 0
       PIC X(60) FROM sa-con-fullname.
         02 LINE 9 COL 19 BACKGROUND-COLOR 3 FOREGROUND-COLOR 0
       PIC 99/99/9(4) USING sa-date FULL REQUIRED.
