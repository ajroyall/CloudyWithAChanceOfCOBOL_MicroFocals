       01 G-CUSTADD.
         02 LINE 4 COL 2 VALUE "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
      -"ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄStore Id..     Ä¿".
         02 LINE 5 COL 2 VALUE "³ Customer Id             Gender     Tit
      -"le             Initials             ³".
         02 LINE 6 COL 2 VALUE "³ Name
      -"                                    ³".
         02 LINE 7 COL 2 VALUE "³ Address
      -"                                    ³".
         02 LINE 8 COL 2 VALUE "³
      -"                                    ³".
         02 LINE 9 COL 2 VALUE "³
      -"                                    ³".
         02 LINE 10 COL 2 VALUE "³
      -"                                     ³".
         02 LINE 11 COL 2 VALUE "³ PostCode
      -"                                     ³".
         02 LINE 12 COL 2 VALUE "³ Country
      -"                                     ³".
         02 LINE 13 COL 2 VALUE "³ DOB          /  /     DD/MM/YYYY    C
      -"ustomer Since   /  /                 ³".
         02 LINE 14 COL 2 VALUE "³
      -"                                     ³".
         02 LINE 15 COL 2 VALUE "³ Home Email
      -"                                     ³".
         02 LINE 16 COL 2 VALUE "³ Work Email
      -"                                     ³".
         02 LINE 17 COL 2 VALUE "³ Home Tel                            W
      -"ork Tel                              ³".
         02 LINE 18 COL 2 VALUE "³
      -"                                     ³".
         02 LINE 19 COL 2 VALUE "³ GP Name
      -"                                     ³".
         02 LINE 20 COL 2 VALUE "³ Occupation
      -"                                     ³".
         02 LINE 21 COL 2 VALUE "³ Glaucoma        Cataracts           D
      -"iabetic      Colour blindness        ³".
         02 LINE 22 COL 2 VALUE "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
      -"ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ".
         02 LINE 4 COL 72 PIC X(5) FROM Preferred-Store-Id.
         02 g-customer-id LINE 5 COL 17 BACKGROUND-COLOR 3
       FOREGROUND-COLOR 0 PIC 9(9) FROM Customer-Id.
         02 g-gender LINE 5 COL 35 BACKGROUND-COLOR 3 FOREGROUND-COLOR 4
       HIGHLIGHT PIC X USING Gender AUTO FULL REQUIRED.
         02 g-title LINE 5 COL 45 BACKGROUND-COLOR 3 FOREGROUND-COLOR 0
       PIC X(9) USING Title AUTO.
         02 g-initials LINE 5 COL 66 BACKGROUND-COLOR 3 FOREGROUND-COLOR
       0 PIC X(11) FROM Initials.
         02 LINE 6 COL 10 BACKGROUND-COLOR 3 FOREGROUND-COLOR 0
       PIC X(62) USING FullName AUTO REQUIRED.
         02 LINE 7 COL 12 BACKGROUND-COLOR 3 FOREGROUND-COLOR 0
       PIC X(66) USING address(1) AUTO.
         02 LINE 8 COL 12 BACKGROUND-COLOR 3 FOREGROUND-COLOR 0
       PIC X(66) USING address(2) AUTO.
         02 LINE 9 COL 12 BACKGROUND-COLOR 3 FOREGROUND-COLOR 0
       PIC X(66) USING address(3) AUTO.
         02 LINE 10 COL 12 BACKGROUND-COLOR 3 FOREGROUND-COLOR 0
       PIC X(66) USING address(4) AUTO.
         02 LINE 11 COL 15 BACKGROUND-COLOR 3 FOREGROUND-COLOR 0
       PIC X(9) USING PostCode.
         02 LINE 12 COL 15 BACKGROUND-COLOR 3 FOREGROUND-COLOR 0
       PIC X(41) FROM Country.
         02 LINE 13 COL 15.
         02 g-dob.
          004 BACKGROUND-COLOR 3 FOREGROUND-COLOR 0 PIC 99 USING DOB-dd
       AUTO FULL.
           04 COL + 2 BACKGROUND-COLOR 3 FOREGROUND-COLOR 0 PIC 99 USING
       dob-mm AUTO FULL.
           04 COL + 2 BACKGROUND-COLOR 3 FOREGROUND-COLOR 0 PIC 9(4)
       USING dob-yyyy AUTO FULL.
         02 LINE 13 COL 55.
         02 g-cs.
          004 G-001 BACKGROUND-COLOR 3 FOREGROUND-COLOR 0 PIC 99 USING
       cs-dd AUTO FULL.
           04 COL + 2 BACKGROUND-COLOR 3 FOREGROUND-COLOR 0 PIC 99 USING
       cs-mm AUTO FULL.
           04 COL + 2 BACKGROUND-COLOR 3 FOREGROUND-COLOR 0 PIC 9(4)
       USING cs-yyyy AUTO FULL.
         02 LINE 15 COL 16 BACKGROUND-COLOR 3 FOREGROUND-COLOR 0
       PIC X(40) USING Home-Email AUTO.
         02 LINE 16 COL 16 BACKGROUND-COLOR 3 FOREGROUND-COLOR 0
       PIC X(40) USING Work-Email.
         02 LINE 17 COL 16 BACKGROUND-COLOR 3 FOREGROUND-COLOR 0
       PIC X(20) USING Home-Tel AUTO REQUIRED.
         02 LINE 17 COL 49 BACKGROUND-COLOR 3 FOREGROUND-COLOR 0
       PIC X(21) USING Work-Tel AUTO.
         02 LINE 19 COL 16 BACKGROUND-COLOR 3 FOREGROUND-COLOR 0
       PIC X(60) USING gp-name AUTO.
         02 LINE 20 COL 16 BACKGROUND-COLOR 3 FOREGROUND-COLOR 0
       PIC X(60) USING occupation AUTO.
         02 g-glaucoma LINE 21 COL 16 BACKGROUND-COLOR 3
       FOREGROUND-COLOR 0 PIC X USING glaucoma AUTO FULL REQUIRED.
         02 g-Cataracts LINE 21 COL 30 BACKGROUND-COLOR 3
       FOREGROUND-COLOR 0 PIC X USING cataracts AUTO FULL REQUIRED.
         02 g-Diabetic LINE 21 COL 49 BACKGROUND-COLOR 3
       FOREGROUND-COLOR 0 PIC X USING Diabetic-retinopathy AUTO FULL
       REQUIRED.
         02 g-Colour-blindness LINE 21 COL 71 BACKGROUND-COLOR 3
       FOREGROUND-COLOR 0 PIC X USING Colour-blindness AUTO FULL
       REQUIRED.
