      $set intlevel"5"
       program-id. dateinfo.
    
       working-storage section.
       copy "common_78.cpy".
       01 sa-date.
          03 sa-dd    pic 99.
          03 filler   pic x.
          03 sa-mm    pic 99.
          03 filler   pic x.
          03 sa-yyyy  pic 9999.

       01 date-today-temp-formatted.
         03 dd        pic xx.
         03 filler    pic x.
         03 mm        pic xx.
         03 filler    pic x.
         03 yyyy      pic xxxx.

       01 sf-date-num           pic 9(38).

       01 sf-date     pic 99999999.
       01 redefines sf-date.
         03 sf-yyyy   pic 9999.
         03 sf-mm     pic 99.
         03 sf-dd     pic 99.


       01 ys-date-num        pic 9(38).
       01 ys-day-of-week     pic 9.

       01 sf-tmp-date     pic 99999999.
       01 redefines sf-tmp-date.
         03 sf-tmp-yyyy   pic 9999.
         03 sf-tmp-mm     pic 99.
         03 sf-tmp-dd     pic 99.

       01 sf-week-number     pic 99.
       01 ws-day-of-week        pic 9.

       01 day-of-week-names.
       	03 day-of-week-name pic xxx occurs 7
       	  values "Sun" "Mon" "Tue" "Wed" "Thu" "Fri" "Sat".

       *> needed but not used
       01 ws-year-tmp      pic 999.

       local-storage section.
       copy dateinfo.cpy replacing ==:Prefix-:== by ==ls-==.
       
       linkage section.
       copy dateinfo.cpy replacing ==:Prefix-:== by ==lnk-==.

       procedure division using lnk-date-yyyymmdd, lnk-date-info.
           move corresponding lnk-date-yyyymmdd
            to date-today-temp-formatted
           move date-today-temp-formatted to sa-date

           move sa-yyyy to sf-yyyy
           move sa-mm to sf-mm
           move sa-dd to sf-dd
           move function integer-of-date(sf-date) to sf-date-num

           move sa-yyyy to sf-tmp-yyyy
           move 1 to sf-tmp-dd sf-tmp-mm
           move function integer-of-date(sf-tmp-date) to ys-date-num
           divide ys-date-num by 7 giving ws-year-tmp
           	remainder ys-day-of-week

           add 1 to ys-day-of-week 	*> range 1-7
           evaluate ys-day-of-week
           	when 6 add 1 to sf-date-num
           	when 5 add 2 to sf-date-num
           	when 4 add 3 to sf-date-num
           	when 3 add 4 to sf-date-num
           	when 2 add 5 to sf-date-num
           	when 1 add 6 to sf-date-num
           end-evaluate

           subtract ys-date-num from sf-date-num giving sf-date-num

           divide sf-date-num by 7
                giving sf-week-number remainder ws-day-of-week

           add 1 to ws-day-of-week

           add 1 to sf-week-number
           move day-of-week-name(ws-day-of-week) to lnk-day-of-week-name
           move ws-day-of-week to lnk-day-of-week-num 
           move sf-week-number to lnk-week-num
           goback returning DATEINFO-OK
           .
  
       end program dateinfo.

