       01 G-CONSULTANTSADD.
         02 LINE 4 COL 2 VALUE "зддддддддддддддддддддддддддддддддддддддд
      -"ддддддддддддддддддддддддддддддддддддд©".
         02 LINE 5 COL 2 VALUE "Ё ".
         02 COL 4 HIGHLIGHT VALUE "Title".
         02 COL 79 VALUE "Ё".
         02 LINE 6 COL 2 VALUE "Ё ".
         02 COL 4 HIGHLIGHT VALUE "Name".
         02 COL 79 VALUE "Ё".
         02 LINE 7 COL 2 VALUE "Ё ".
         02 COL 4 HIGHLIGHT VALUE "Gender".
         02 COL 35 VALUE "Initials               Id                   Ё"
       .
         02 LINE 8 COL 2 VALUE "цддддддддддддддддддддддддддддддддддддддд
      -"ддддддддддддддддддддддддддддддддддддд╢".
         02 LINE 9 COL 2 VALUE "Ё ".
         02 COL 4 HIGHLIGHT VALUE "Consultant".
         02 COL 15 HIGHLIGHT VALUE "Specialisations".
         02 COL 79 VALUE "Ё".
         02 LINE 10 COL 2 VALUE "Ё  Glaucoma      Cataracts      Diabeti
      -"c Retinopathy      Colour-blindness   Ё".
         02 LINE 11 COL 2 VALUE "цдддддддддддддддддддддддддддддддддддддд
      -"дддддддддддддддддддддддддддддддддддддд╢".
         02 LINE 12 COL 2 VALUE "Ё
      -"                                      Ё".
         02 LINE 13 COL 2 VALUE "Ё
      -"                                      Ё".
         02 LINE 14 COL 2 VALUE "Ё
      -"                                      Ё".
         02 LINE 15 COL 2 VALUE "Ё
      -"                                      Ё".
         02 LINE 16 COL 2 VALUE "Ё
      -"                                      Ё".
         02 LINE 17 COL 2 VALUE "Ё
      -"                                      Ё".
         02 LINE 18 COL 2 VALUE "Ё
      -"                                      Ё".
         02 LINE 19 COL 2 VALUE "Ё
      -"                                      Ё".
         02 LINE 20 COL 2 VALUE "юдддддддддддддддддддддддддддддддддддддд
      -"дддддддддддддддддддддддддддддддддддддды".
         02 g-title LINE 5 COL 15 PIC X(9) USING mfc-title AUTO REQUIRED
       .
         02 LINE 6 COL 15 PIC X(61) USING mfc-fullname AUTO REQUIRED.
         02 g-gender LINE 7 COL 15 PIC X USING mfc-gender AUTO FULL
       REQUIRED.
         02 g-glaucoma LINE 10 COL 14 PIC X USING mfc-Glaucoma AUTO FULL
       .
         02 g-initials LINE 7 COL 44 PIC X(11) FROM mfc-initials.
         02 LINE 7 COL 61 PIC 9(9) FROM mfc-Consultant-Id.
         02 g-cataracts LINE 10 COL 29 PIC X USING mfc-Cataracts AUTO
       FULL.
         02 g-diabetic-retinopathy LINE 10 COL 55 PIC X USING
       mfc-Diabetic-retinopathy AUTO FULL REQUIRED.
         02 g-colour-blindness LINE 10 COL 77 PIC X USING
       mfc-Colour-blindness AUTO FULL REQUIRED.
