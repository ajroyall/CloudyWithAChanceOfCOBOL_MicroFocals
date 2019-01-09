       program-id. dateinfo_test.
       working-storage section.
       01 date-today-temp.
         03 yyyy      pic xxxx.
         03 mm        pic xx.
         03 dd        pic xx.
       local-storage section.
       copy dateinfo.cpy replacing ==:Prefix-:== by ==ls-==.

       procedure division.

           display "TEST"
           move "20140101" to date-today-temp
           perform calc-week-num

           move "20140102" to date-today-temp
           perform calc-week-num

           move "20140103" to date-today-temp
           perform calc-week-num

           move "20140104" to date-today-temp
           perform calc-week-num

           move "20140105" to date-today-temp
           perform calc-week-num

           move "20140106" to date-today-temp
           perform calc-week-num

           move "20140107" to date-today-temp
           perform calc-week-num

           move "20140308" to date-today-temp
           perform calc-week-num

           move "20140309" to date-today-temp
           perform calc-week-num

           accept date-today-temp from date YYYYMMDD
           perform calc-week-num

           goback.

        calc-week-num.
           call "dateinfo" using date-today-temp
                        ls-day-of-week-name
           end-call

           display ls-day-of-week-name
                        "[" ls-day-of-week-num "]"
                        " -> "
                        yyyy of date-today-temp "/"
                                mm of date-today-temp "/"
                                dd of date-today-temp
                                " is " ls-week-num
                .

       end program dateinfo_test.
