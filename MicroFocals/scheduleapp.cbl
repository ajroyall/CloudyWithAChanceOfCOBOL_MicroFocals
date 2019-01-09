       IDENTIFICATION DIVISION.
       environment division.
       special-names.
         crt status is key-status.
       file-control.
       *> appointments record file
       copy "app-fc.cpy".
       *> customer record file
       copy "customer-fc.cpy".
       data division.
       copy "app-fd.cpy".
       copy "customer-fd.cpy".
       WORKING-STORAGE SECTION.
       COPY "common_ws.cpy".
       01 customer-menu-option     pic x.
       01 ws-Consultant.
       copy "consultants.cpy" replacing ==:Prefix-:== by ==ws-==.

       01 wsc-Customer.
       copy "customerinfo.cpy" replacing ==:Prefix-:== by ==wsc-==.

       01 sa-cust-fullname         pic x(60).
       01 sa-con-fullname          pic x(60).
       01 sa-date.
          03 sa-dd    pic 99.
          03 filler   pic x value "/".
          03 sa-mm    pic 99.
          03 filler   pic x value "/".
          03 sa-yyyy  pic 9999.
       01 sa-date-initial.
          03 filler   pic 99.
          03 filler   pic x value "/".
          03 filler   pic 99.
          03 filler   pic x value "/".
          03 filler   pic 9999.


       01 sf-date     pic 99999999.
       01 redefines sf-date.
         03 sf-yyyy   pic 9999.
         03 sf-mm     pic 99.
         03 sf-dd     pic 99.

       01 sf-tmp-date          pic 99999999.
       01 redefines sf-tmp-date.
         03 sf-tmp-yyyy   pic 9999.
         03 sf-tmp-mm     pic 99.
         03 sf-tmp-dd     pic 99.

       *> needed but not used
       01 sf-tmp      pic 999.

       01 fields-valid pic x.

       01 date-today-temp.
         03 yyyy      pic xxxx.
         03 mm        pic xx.
         03 dd        pic xx.
       01 date-today-temp-formatted.
         03 dd        pic xx.
         03 filler    pic x value "/".
         03 mm        pic xx.
         03 filler    pic x value "/".
         03 yyyy      pic xxxx.

       01 booking-times-locations.
         03 bt-location pic 9999 occurs MAX-APPS-PER-DAY
            values
                1404,
                1504,
                1604,
                1704,
                1804,
                1904,
                2004,
                2104,
                1442,
                1542,
                1642,
                1742,
                1842,
                1942,
                2042,
                2142,
                2242,
                2342.

        01 selected-item       binary-long.
        01 booked-status       pic x(10) occurs MAX-APPS-PER-DAY.
        01 attended-status     pic x(10) occurs MAX-APPS-PER-DAY.
        01 time-to-leave       pic x.
        01 bt-one-lock.
         03 bt-row              pic 99.
         03 bt-col              pic 99.
        01 week-counter        binary-long.
        01 counter             binary-long.
        01 sa-cust-id-display  pic 9(9) display.

        copy "dateinfo.cpy" replacing  ==:Prefix-:== by ==di-==.
        copy "gettimeslot.cpy" replacing  ==:Prefix-:== by ==ap-==.

        linkage section.
        copy "common_lnk.cpy".
        SCREEN SECTION.
        COPY "CUSTMENU.ss".
        COPY "schedapp.ss".

        copy "common_ss.cpy".
        procedure division using lnk-store-info.
           move "appointment-file" to fs-current-file
           open i-o appointment-file with lock
           perform check-file-status
           if not fs-okay
             goback returning 1
           end-if

           accept date-today-temp from date YYYYMMDD
           move corresponding date-today-temp
            to date-today-temp-formatted
           move date-today-temp-formatted to sa-date sa-date-initial

           move lnk-name-of-store to Store-Name
           move "Schedule Appointment" to Menu-Name
           move "SA_M01" to Menu-Id

           *> get the current time-slot, so we can highlight current
           call "gettimeslot" using
                  by reference ap-current-timeslot
           end-call

           perform clr-screen
           display g-menuheader

           call "custpopup" using wsc-customer
           if return-code equals -1
                close appointment-file
                perform check-file-status
           	goback
           end-if
           move wsc-fullname to sa-cust-fullname

           call "consultpopup" using lnk-store-info, ws-Consultant
           if return-code equals -1
                close appointment-file
                perform check-file-status
           	goback
           end-if
           move ws-fullname to sa-con-fullname

           display g-schedapp

           move "n" to fields-valid
           perform until fields-valid equals "y"
            accept g-schedapp
            perform f1-or-quit

            call "valdated" using
             by reference z"dd/mm/yyyy"
             by reference sa-date
            end-call

            if return-code equals 0
             move "y" to fields-valid
            else
               move "Field validation error" to popup-title
                move spaces to popup-message-1
                move "Invalid date" to popup-message-2
                move "Okay" to popup-button-1
                call "errpopup" using popup-title,
                        popup-message-1,
                        popup-message-2
                        popup-button-1
                end-call
            end-if
           end-perform

           *> do not move the time slot if the date is not today
           if sa-date not equals sa-date-initial
             move 1 to ap-time-slot
           end-if

           move sa-yyyy to sf-yyyy
           move sa-mm to sf-mm
           move sa-dd to sf-dd

           call "dateinfo" using sf-date di-date-info

           *> create a key based on the store id,
           *> customer id, year and week number.
           move lnk-id to app-store-id
           move ws-fullname to app-consultant-name
           move ws-consultant-id to app-consultant-id
           move sa-yyyy to app-year
           move di-week-num to app-week

           perform read-appointment
           perform display-all-appointments

           perform move-to-first-free
           perform display-row-highite
           perform until time-to-leave equals "y"
           call x"AF" using    get-single-char-func key-status
           move key-code-1 to key-code-1-display

           evaluate key-type
                when kc-user-fn-key
                   evaluate key-code-1
                    when kc-escape
                     move "Are you sure you want to quit?" to
                     	popup-l-message
                     move "[Y] or [N]" to popup-l-button
                     perform display-lower-popup
                     if scr-af-key-code-1x equals "y" or
                        scr-af-key-code-1x equals "Y"
                        goback
                      end-if
                   when kc-f1-key
                      perform show-f1-help
                   end-evaluate
                when kc-8bit-key
                  evaluate key-code-1x
                    when "a"
                    when "A"
                     if selected-item <= ap-time-slot
                      perform attended-toogle-selected
                      perform setup-appointments
                      perform display-row-highite
                     end-if
                    when 'b'
                    when 'B'
                     if selected-item >= ap-time-slot
                      perform book-or-unbook-selected
                      perform setup-appointments
                      perform display-row-highite
                     end-if
                  end-evaluate
                when kc-adis-fn-key
                  evaluate key-code-1
                    when adis-term-cr
                    when adis-term-accept
                      move "y" to time-to-leave
                    when adis-up-key
                      perform display-row
                      subtract 1 from selected-item
                      perform display-row-highite
                    when adis-down-key
                      perform display-row
                      add 1 to selected-item
                      perform display-row-highite
                   end-evaluate
            end-evaluate
           end-perform

           perform write-appointment

           close appointment-file
           perform check-file-status
           GOBACK.

        write-appointment.
           write appointment
           if fs-key-already-exists
            rewrite appointment
           end-if
           perform check-file-status
        .


        read-appointment.
           perform clear-app-appointments
           start appointment-file
                key = appointment-key
           end-start
           if fs-no-record
               perform setup-appointments
           else
               read appointment-file
               perform setup-appointments
           end-if
        .

        attended-toogle-selected.
         if app-attended of app-days(di-day-of-week-num selected-item)
            equals "y" or "Y"
               move "N" to app-attended of
                      app-days(di-day-of-week-num selected-item)
         else
               move "Y" to app-attended of
                      app-days(di-day-of-week-num selected-item)
         end-if
        .

        book-or-unbook-selected.
         if app-cust-id of app-days(di-day-of-week-num selected-item)
            equals invalid-custid
               move wsc-customer-id to app-cust-id of
                      app-days(di-day-of-week-num selected-item)
         else if app-cust-id of
         	app-days(di-day-of-week-num selected-item)
            equals wsc-customer-id
               move invalid-custid to app-cust-id of
                      app-days(di-day-of-week-num selected-item)
               move "N" to app-attended of
                      app-days(di-day-of-week-num selected-item)
         end-if
        .

        move-to-first-free.
          move 1 to selected-item
          if sa-date equal sa-date-initial and
            ap-time-slot not equal 0
           perform with test after
                varying counter from MAX-APPS-PER-DAY
          	by -1 until counter = ap-time-slot

               if app-cust-id of app-days(di-day-of-week-num counter)
                 equals invalid-custid
                   or app-cust-id of
                   	app-days(di-day-of-week-num counter)
                      equals wsc-customer-id
                 move counter to selected-item
               end-if
           end-perform
           else
            move 0 to ap-time-slot
          end-if
        .


        clear-app-appointments.
          perform varying week-counter from 1 by 1
           until week-counter > 7
            perform varying counter from 1 by 1
            	until counter > MAX-APPS-PER-DAY
               move invalid-custid to
                  app-cust-id of app-days(week-counter counter)
               move "N" to
                  app-attended of app-days(week-counter counter)
             end-perform
           end-perform
        .

        display-all-appointments.
           perform varying counter from 1 by 1
           	until counter > MAX-APPS-PER-DAY
               move bt-location(counter) to bt-one-lock
               move counter to selected-item
               perform display-row
           end-perform
        .

        setup-appointments.
          perform varying counter from 1 by 1
          	until counter > MAX-APPS-PER-DAY
               if counter <= ap-time-slot
                  evaluate app-attended of
               	    app-days(di-day-of-week-num counter)
               	     when "y"
               	     when "Y"
               		 move "Attended" to attended-status(counter)
               	     when "n"
               	     when "N"
                 	  move spaces to attended-status(counter)
               	     when other
               		move "?" to attended-status(counter)
                  end-evaluate
               else
                   move all " " to attended-status(counter)
               end-if

               evaluate app-cust-id of
               	        app-days(di-day-of-week-num counter)
                  when wsc-customer-id
                   move booked-msg to booked-status(counter)
                  when invalid-custid
                   if counter >= ap-time-slot
                     move available-msg to booked-status(counter)
                   else
                     move spaces to booked-status(counter)
                     move spaces to attended-status(counter)
                   end-if
                  when other
                   move reserved-msg to booked-status(counter)
                   move app-cust-id of
                   	  app-days(di-day-of-week-num counter)
                      to sa-cust-id-display
                   *> move 9999 to sa-cust-id-display
                   *> move sa-cust-id-display
                   *>   to booked-status(counter)
               end-evaluate
           end-perform
        .

        ensure-pos-valid.
            if selected-item < 1
                perform move-to-first-free
            end-if

            if selected-item > MAX-APPS-PER-DAY
                move MAX-APPS-PER-DAY to selected-item
            end-if

        .
        display-row.
            perform ensure-pos-valid
            move bt-location(selected-item) to bt-one-lock
            display bt-label(selected-item)
            	 at line bt-row column bt-col
                 with background-color mf-app-background-colour
            add 13 to bt-col

            evaluate booked-status(selected-item)
                when available-msg
                      display booked-status(selected-item)
                          at line bt-row column bt-col
                          with background-color mf-app-background-colour
                          with foreground-colour mf-app-available-colour
                when booked-msg
                      display booked-status(selected-item)
                          at line bt-row column bt-col
                          with background-color mf-app-background-colour
                          with foreground-colour mf-app-booked-colour
                when other
                      display booked-status(selected-item)
                          at line bt-row column bt-col
                          with background-color mf-app-background-colour
                          with foreground-colour mf-app-booked-colour
            end-evaluate
            add length of booked-status(selected-item) to bt-col
            display attended-status(selected-item)
            	 at line bt-row column bt-col
                 with background-color mf-app-background-colour



        .

        display-row-highite.
            perform ensure-pos-valid
            move bt-location(selected-item) to bt-one-lock
            display bt-label(selected-item) at line bt-row
                 column bt-col
                 with background-color mf-app-revbg-colour
            add 13 to bt-col
            display booked-status(selected-item)
                at line bt-row column bt-col
                with background-color mf-app-revbg-colour

            add length of booked-status(selected-item) to bt-col
            display attended-status(selected-item)
                   at line bt-row column bt-col
                   with background-color mf-app-revbg-colour
        .

       copy "common.cpy".

