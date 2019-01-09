       environment division.
       special-names.
         crt status is key-status.
       file-control.
       *> appointments record file
       copy "app-fc.cpy".

       *> customer record file
       copy "customer-fc.cpy".
       select daily-report assign to dynamic pdr-filename
        organization is line sequential.
       data division.
       copy "app-fd.cpy".
       copy "customer-fd.cpy".
       fd daily-report.
       01 report-line         pic x(80).

       working-storage section.
       copy "common_ws.cpy".
       01 ws-Consultant.
       copy "consultants.cpy" replacing ==:Prefix-:== by ==ws-==.

       01 sa-date.
          03 sa-dd    pic 99.
          03 filler   pic x.
          03 sa-mm    pic 99.
          03 filler   pic x.
          03 sa-yyyy  pic 9999.

       01 date-today-temp.
         03 yyyy      pic xxxx.
         03 mm        pic xx.
         03 dd        pic xx.
       01 sg-date.
         03 dd        pic xx.
         03 filler    pic x value "/".
         03 mm        pic xx.
         03 filler    pic x value "/".
         03 yyyy      pic xxxx.


       01 sf-date     pic 99999999.
       01 redefines sf-date.
         03 sf-yyyy   pic 9999.
         03 sf-mm     pic 99.
         03 sf-dd     pic 99.

       01 booking-times-locations.
          03 grid-cols pic 99 occurs MAX-APPS-PER-DAY
              values
                13, 16,
                19, 22,
                25, 28,
                31, 34,
                37, 40,
                43, 46,
                49, 52,
                55, 58,
                61, 64
             .
           01 grid-lines pic 99 occurs 7
            values
            10, 12, 14, 16, 18, 20, 22.

       01 sg-custname                  pic x(60)
                                          occurs MAX-APPS-PER-DAY.
       01 sg-attended                  pic x
                                          occurs MAX-APPS-PER-DAY.
       01 sg-consultant-name 	       pic x(60).
       01 is-valid		               pic x.
       01 eof        		           pic x.
       01 day-counter 		           binary-long.
       01 counter                      binary-long.
       01 ws-app-cust-id   	           binary-long.

       *> Print Daily Appointments related
       01 pdr-include-cust-details     pic x value "y".
       88 pdr-include-cust-details-valid values "y" "Y" "n" "N".

       01 pdr-send-to-printer          pic x value "n".
       88 send-to-printer              values "y", "Y".
       88 pdr-send-to-printer-valid    values "y" "Y" "n" "N".

       01 pdr-filename                 pic x(20).
       01 pdr-return-code              pic 9999.

       01 report-line-1.
        03 filler                      pic x(14)
            value "Consultant : ".
        03 report-consultant-name	   pic x(60).

       01 report-line-2.
        03 filler                      pic xx.
        03 report-booking-time	       pic x(13).
        03 filler                      pic xx.
        03 report-cust-name	           pic x(60).

       01 report-line-3.
        03 filler                      pic x.
        03 report-booking-fullname	   pic x(20).

       01 report-line-4.
        03 filler                      pic xxx.
        03 report-cust-info            pic x(60).

       01 printer-filename.
        03 printer-filename-len	       pic x(2) comp-5.
        03 printer-filename-body       pic x(128).

       01 printer-title.
        03 printer-title-len	       pic x(2) comp-5.
        03 printer-title-body          pic x(128).

       01 printer-flags		           pic x(4) comp-5.
       01 printer-window-handle	       pic x(4) comp-5.

       01 printer-font.
        03 printer-font-len            pic x(4) comp-5.
        03 printer-font-body           pic x(128).

       01 printer-font-size            pic x(4) comp-5.
       01 printer-font-style           pic x(4) comp-5.

       copy "dateinfo.cpy" replacing  ==:Prefix-:== by ==di-==.
       copy "gettimeslot.cpy" replacing  ==:Prefix-:== by ==ap-==.

       78 first-consultant-row         value 6. *> -1
       78 cur-1-consultant-col-ind     value 14.
       78 cur-2-consultant-col-ind     value 16.
       01 app-time-row                 binary-long.
       linkage section.
       copy "common_lnk.cpy".
       01 lnk-option                   pic x.
       88 review-all-consultants       value "a", "A".
       88 review-one-consultsnt        value "c", "C".
       88 review-grid-for-consultant   value "g", "G".
       88 review-print                 value "p", "P".

       screen section.
       copy "common_ss.cpy".
       copy "reviewsched.ss".
       copy "schedgrid.ss".
       copy "schedprtpopup.ss".
       procedure division using lnk-store-info lnk-option.
           move lnk-name-of-store to Store-Name
           move "Schedule Review" to Menu-Name
           move "SR_A01" to Menu-Id
           move "dailyreport.txt" to pdr-filename

           *> get the current time-slot, so we can highlight current
           call "gettimeslot" using
                  by reference ap-current-timeslot
           end-call
           compute app-time-row = first-consultant-row + ap-time-slot

           *> get date and reformat into dd/mm/yyyy
           accept date-today-temp from date YYYYMMDD
           move corresponding date-today-temp
            to sg-date
           move sg-date to sa-date

           move sa-yyyy to sf-yyyy
           move sa-mm to sf-mm
           move sa-dd to sf-dd
           call "dateinfo" using sf-date, di-date-info

          *> build up a key
           move lnk-id to app-store-id
           move sa-yyyy to app-year
           move di-week-num to app-week
           move 0 to app-consultant-id

           *> display appointment-key
           open input appointment-file
           move "appointment-file" to fs-current-file
           perform check-file-status
           if not fs-okay
             goback returning 1
           end-if

           *> start at the first consultant..
           if review-print or review-all-consultants
               start appointment-file
                   key > appointment-key
               end-start
           end-if

           if review-one-consultsnt or review-grid-for-consultant
               call "consultpopup" using lnk-store-info, ws-consultant

               *> drop out
               if return-code equals -1
                goback returning -1
               end-if

               move ws-consultant-id to app-consultant-id
               start appointment-file
                    key = appointment-key
               end-start
           end-if

           if fs-no-record
             close appointment-file
             perform check-file-status

             move "Appointments Management" to popup-title
             move spaces to popup-message-1
             move "No appointment records found, option aborted"
                to popup-message-2
             move "Okay" to popup-button-1
             call "errpopup" using popup-title,
                  popup-message-1,
                  popup-message-2
                  popup-button-1
             end-call
             goback
           end-if

           if review-all-consultants
             move "n" to eof
             perform until eof equals "y"
               perform clear-record
                 read appointment-file next record
                     at end move "y" to eof
                 end-read

               if fs-no-record
                  move "y" to eof
               end-if

               if eof not equal "y"
                  perform display-record
               end-if
             end-perform
           end-if

           if review-one-consultsnt
                perform clear-record
                 read appointment-file next record
                           at end move "y" to eof
                 end-read

                 if eof not equal "y" and
                        app-consultant-id >= 1
                    perform display-record
                 end-if

                 perform check-file-status
           end-if

           if review-grid-for-consultant
                 perform clear-record
                 read appointment-file next record
                     at end move "y" to eof
                 end-read

                 if eof not equal "y" and
                        app-consultant-id >= 1
                     perform display-week-grid
                     perform press-any-key
                 end-if
            end-if

            if review-print
                 move "n" to is-valid
                 move "Field validation error" to popup-title
                 move spaces to popup-message-1
                 move "Okay" to popup-button-1
                perform until is-valid equals "y"
                display g-schedprtpopup
                accept g-schedprtpopup

                *> Validate the fields
                if not pdr-send-to-printer-valid
                move "send to printer should be y/n"
                            to popup-message-2
                call "errpopup" using popup-title,
                                popup-message-1,
                                popup-message-2
                                popup-button-1
                end-call
            end-if

            if not pdr-include-cust-details-valid
               move "inlude customer details should be y/n"
                        to popup-message-2
               call "errpopup" using popup-title,
                            popup-message-1,
                            popup-message-2
                            popup-button-1
               end-call
            end-if

            if pdr-send-to-printer-valid and
                    pdr-include-cust-details-valid
               move "y" to is-valid
            end-if
        end-perform

             perform generate-report-file

             if send-to-printer
                perform print-file
             end-if
       end-if

           close appointment-file
           perform check-file-status
           goback.


        generate-report-file.
           open output daily-report
           *> move app-week to report-week-num

           move "n" to eof
           perform until eof equals "y"
             perform clear-record
             read appointment-file next record
                at end move "y" to eof
             end-read

             if fs-no-record
                move "y" to eof
             end-if

             if eof not equal "y"
                perform print-customer-record
             end-if
           end-perform
           close daily-report
           .

        print-file.
           move "Courier New" to printer-font-body
           move 11 to printer-font-len

           move 12 to printer-font-size
           move 0 to printer-font-style
           call "PC_PRINTER_DEFAULT_FONT" using
                by reference printer-font
                by value printer-font-size
                by value printer-font-style
           end-call

           move pdr-filename to printer-filename-body
           move 0 to printer-filename-len
           inspect pdr-filename
            tallying printer-filename-len
            for characters

           move "daily" to printer-title-body
           move 5 to printer-title-len

           move 0 to printer-flags
           move 0 to printer-window-handle
           call "PC_PRINT_FILE" using
                by reference printer-filename
                by reference printer-title
                by value printer-flags
                by value printer-window-handle
           end-call
           if return-code not equal 0
             move return-code to pdr-return-code
             move "Failed to print file" to popup-title

             string "Print status code is "
                pdr-return-code
                into popup-message-1

         move spaces to popup-message-2
         move "Okay" to popup-button-1
             call "errpopup" using popup-title,
                  popup-message-1,
                  popup-message-2
                  popup-button-1
             end-call
           end-if
           .

        clear-record.
           perform varying day-counter from 1 by 1 until
                day-counter equals 8

                perform varying counter from 1 by 1
                    until counter > MAX-APPS-PER-DAY

                    move invalid-custid to
                       app-cust-id of app-days(day-counter counter)

                    move APP-STATUS-UNATTENDED to
                        app-attended of app-days(day-counter counter)
              end-perform
            end-perform
           .

        display-week-grid.
            move app-consultant-name to sg-consultant-name
            display g-schedgrid
            perform varying day-counter from 1 by 1 until
                day-counter equals 8
              perform varying counter from 1 by 1
               until counter > MAX-APPS-PER-DAY
                if app-cust-id of app-days(day-counter counter)
                  equals 0
                     display "  " at line grid-lines(day-counter)
                       column grid-cols(counter)
                        with background-colour
                            mf-app-available-colour
                   else
                    display "  " at line grid-lines(day-counter)
                           column grid-cols(counter)
                           with background-colour mf-app-booked-colour
                   end-if
              end-perform
            end-perform
       .


        display-record.
            perform clr-screen-with-header
            display g-reviewsched
            move app-consultant-name to sg-consultant-name

       *> display day-of-week-name(sf-day-of-week) " -> " app-year
       *> 	", week number "  app-week
       *> display " "

            perform varying counter from 1 by 1
                until counter > MAX-APPS-PER-DAY

              move all " " to sg-custname(counter)
              move "?" to sg-attended(counter)

              if counter <= ap-time-slot
                evaluate app-attended
                    of app-days(di-day-of-week-num counter)
                   when "y"
                   when "Y"
                move "A" to sg-attended(counter)
                   when "n"
                   when "N"
                move "M" to sg-attended(counter)
                   when other
                move "?" to sg-attended(counter)
                end-evaluate
              else
                 move "F" to sg-attended(counter)
              end-if

              initialize f-CustomerInformation
              if app-cust-id of app-days(di-day-of-week-num counter)
                    not equals 0
                open input cust-file
                perform check-file-status

                move app-cust-id of
                    app-days(di-day-of-week-num counter)
                          to f-customer-id

                read cust-file

                if not fs-no-record
                    perform check-file-status
                    move app-cust-id of
                        app-days(di-day-of-week-num counter)
                             to ws-app-cust-id
                    move f-fullname to sg-custname(counter)
                end-if
              close cust-file
              end-if
           end-perform

           display g-reviewsched

           *> display a time indicator
           if ap-time-slot not equal 0
            display ">" at line app-time-row
                          column cur-1-consultant-col-ind
            display "<" at line app-time-row
                          column cur-2-consultant-col-ind
           end-if
           perform press-any-key
        .

        print-customer-record.
           move app-consultant-name to report-consultant-name

           write report-line from report-line-1

           perform varying day-counter from 1 by 1 until
                day-counter equals 8

              move day-of-week-fullname(day-counter) to
                      report-booking-fullname

              write report-line from report-line-3

              perform varying counter from 1 by 1
                   until counter > MAX-APPS-PER-DAY

               move bt-label(counter) to
                        report-booking-time

               initialize f-CustomerInformation

               if app-cust-id of app-days(day-counter counter)
                  not equal 0
                    move "Busy" to report-cust-name
                    open input cust-file
                        perform check-file-status
                    move app-cust-id of
                        app-days(day-counter counter)
                               to f-customer-id
                    read cust-file
                    if not fs-no-record
                      perform check-file-status
                      move app-cust-id of
                            app-days(di-day-of-week-num counter)
                        to ws-app-cust-id

                      string f-title delimited by space
                         " " delimited by size
                         f-fullname delimited by "     "
                         " (" delimited by size
                         f-initials delimited by spaces
                         ")" delimited by size
                         into report-cust-name
                          *> move f-fullname to report-cust-name
                    end-if
                    close cust-file
                else
                    move "Available" to report-cust-name
                end-if

                write report-line from report-line-2

                if f-home-tel not equal spaces
                 move f-home-tel to report-cust-info
                 write report-line from report-line-4
                end-if

                if f-work-tel not equal spaces
                 move f-work-tel to report-cust-info
                 write report-line from report-line-4
                end-if

                if f-home-email not equal spaces
                 move f-home-email to report-cust-info
                 write report-line from report-line-4
                end-if

                if f-work-email not equal spaces
                 move f-work-email to report-cust-info
                 write report-line from report-line-4
                end-if
              end-perform
           end-perform

            move spaces to report-line
            write report-line after advancing page
        .

        clr-screen-with-header.
           perform clr-screen
           display g-menuheader
        .

        copy "common.cpy".
