      $set sourceformat"free"
       identification division.
       program-id. valdate.
       working-storage section.
       01 date-yyyymmdd.
         05 ws-yyyy Pic 9(04).
         05 ws-MM Pic 9(02).
           88 1-to-12 Value 1 thru 12.
           88 31-Days Value 1 3 5 7 8 10 12.
           88 30-Days Value 4 6 9 11.
           88 Feb Value 2.
         05 ws-DD Pic 9(02).
           88  1-to-31 Value 1 thru 31.
           88  1-to-30 Value 1 thru 30.
           88  1-to-29 Value 1 thru 29.
           88  1-to-28 Value 1 thru 28.
       linkage section.
       01 lnk-format  pic x(10).

       01 lnk-date    pic 9(10).

      01 lnk-date-f0.
        03 lnk-f0-yyyy  pic 9999.
        03 lnk-f0-mm    pic 99.
        03 lnk-f0-dd    pic 99.
      01 lnk-date-f1.
        03 lnk-f1-dd    pic 99.
        03 lnk-f1-mm    pic 99.
        03 lnk-f1-yyyy  pic 9999.
      01 lnk-date-f2.
        03 lnk-f2-dd    pic 99.
        03 filler       pic x.
        03 lnk-f2-mm    pic 99.
        03 filler       pic x.
        03 lnk-f2-yyyy  pic 9999.
      01 lnk-date-f3.
        03 lnk-f3-yyyy  pic 9999.
        03 filler       pic x.
        03 lnk-f3-mm    pic 99.
        03 filler       pic x.
        03 lnk-f3-dd    pic 99.

       copy "common_78.cpy".

       
       procedure division using lnk-format lnk-date.
         inspect lnk-format converting
                'abcdefghijklmnopqrstuvwxyz' TO
                'ABCDEFGHIJKLMNOPQRSTUVWXYZ'

         *> flip around the formats...
         if lnk-format equals "yyyymmdd"
            set address of lnk-date-f0 to address of lnk-date
            move lnk-f0-dd to ws-dd
            move lnk-f0-mm to ws-mm
            move lnk-f0-yyyy to ws-yyyy
         else if lnk-format equals "ddmmyyyy"
            set address of lnk-date-f1 to address of lnk-date
            move lnk-f1-dd to ws-dd
            move lnk-f1-mm to ws-mm
            move lnk-f1-yyyy to ws-yyyy
         else if lnk-format equals "dd/mm/yyyy"
            set address of lnk-date-f2 to address of lnk-date
            move lnk-f2-dd to ws-dd
            move lnk-f2-mm to ws-mm
            move lnk-f2-yyyy to ws-yyyy
         else if lnk-format equals "yyyy/mm/dd"
            set address of lnk-date-f3 to address of lnk-date
            move lnk-f3-dd to ws-dd
            move lnk-f3-mm to ws-mm
            move lnk-f3-yyyy to ws-yyyy
         else
          exit program returning VALDATE-FAILED
         end-if.

         If date-yyyymmdd Not Numeric
          exit program returning VALDATE-FAILED
         end-if

         If ws-YYYY < 1601 then *> any larger year less than 9999 is valid
          exit program returning VALDATE-FAILED
         end-if

         *> validate month field
         If not 1-to-12 then
          exit program returning VALDATE-FAILED
         end-if

         If not 1-to-12 then
          exit program returning VALDATE-FAILED
         end-if

         If 31-Days and not 1-to-31 then
          exit program returning VALDATE-FAILED
         end-if

         If 30-Days And not 1-to-30 then
          exit program returning VALDATE-FAILED
         end-if

         If Feb and not 1-to-29 then
          exit program returning VALDATE-FAILED
         end-if

         if not Feb
          exit program returning VALDATE-OK
         end-if

         *> Check-Leap-Year
         If Function Mod (ws-YYYY 400) = 0
         then
          exit program returning VALDATE-OK
         end-if

        If (function Mod (ws-yyyy 4) = 0) And (Function Mod (ws-YYYY 100) NOT = 0) then
             Continue
           Else
             If 1-to-28
             then
               Continue
             Else
                exit program returning VALDATE-FAILED
             End-If
        End-If
       exit program returning VALDATE-OK
