       identification division.
       environment division.
       special-names.
         crt status is key-status.
       file-control.
       *> appointments record file
       copy "app-fc.cpy".

       data division.
       copy "app-fd.cpy".

       working-storage section.
       copy "common_ws.cpy".

       01 Conf-Store-Information.
       copy "stores.cpy" replacing ==:Prefix-:== by ==Conf-==.

       copy "getconsults.cpy" replacing ==:Prefix-:== by ==cp-==.

       copy "gettimeslot.cpy" replacing  ==:Prefix-:== by ==ap-==.

       copy "dateinfo.cpy" replacing  ==:Prefix-:== by ==di-==.

       01 free-slots  pic 99 occurs MAX-APPS-PER-DAY.
       01 busy-slots  pic 99 occurs MAX-APPS-PER-DAY.

       01 consult-free-slots  pic 99
                blank when zero occurs MAX-APPS-PER-DAY.
       01 consult-freep-slots pic 999.99
                blank when zero occurs MAX-APPS-PER-DAY.
       01 consult-busy-slots  pic 99
                blank when zero occurs MAX-APPS-PER-DAY.

       01 cont-counter binary-long.

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

       01 sa-date.
          03 sa-dd    pic 99.
          03 filler   pic x.
          03 sa-mm    pic 99.
          03 filler   pic x.
          03 sa-yyyy  pic 9999.

       01 sf-date     pic 99999999.
       01 redefines sf-date.
         03 sf-yyyy   pic 9999.
         03 sf-mm     pic 99.
         03 sf-dd     pic 99.
       local-storage section.
       01 counter    binary-long.
       01 ls-counter binary-long.
       01 ls-eof     pic x.
       linkage section.
       copy "common_lnk.cpy".

       SCREEN SECTION.
       copy "common_ss.cpy".
       COPY "SUMMARYPOPUP.ss".


       PROCEDURE DIVISION using lnk-store-info.
           *>  setup fields to initial values
           perform init-fields

           *> prepare header screen with name etc..
           move lnk-name-of-store to Store-Name
           move "Consultant Availability" to Menu-Name
           move "CA_M01" to Menu-Id
           perform clr-screen
           display g-menuheader

           *> get the current time-slot, so we can highlight current
           call "gettimeslot" using
                  by reference ap-current-timeslot
           end-call

           *> get date and reformat into dd/mm/yyyy
           accept date-today-temp from date YYYYMMDD
           move corresponding date-today-temp to sg-date
           move sg-date to sa-date

           move sa-yyyy to sf-yyyy
           move sa-mm to sf-mm
           move sa-dd to sf-dd
           call "dateinfo" using sf-date, di-date-info

           *> set address of lnk-store-info to
           *> 	address of Conf-Store-Information
           *> call "getdefstore" using lnk-store-info
           call "getconsults" using lnk-store-info, cp-consultants
            returning cont-counter
           end-call

           *> If we do not have a timeslot
           if ap-time-slot equals 0
            perform varying ls-counter from 1 by 1
               until ls-counter > cont-counter

              move 0 to busy-slots(ls-counter)
              move 0 to free-slots(ls-counter)

              move 0 to consult-busy-slots(ls-counter)
              move 0 to consult-free-slots(ls-counter)
              move 0 to consult-freep-slots(ls-counter)
            end-perform
            perform display-summmary

            *> leave
            goback returning CONSULTSUM-OK
           end-if

          *> build up a key
           move lnk-id to app-store-id
           move sa-yyyy to app-year
           move di-week-num to app-week
           move 0 to app-consultant-id

           move "appointment-file" to fs-current-file
           open input appointment-file
           
           if not fs-okay
              perform check-file-status
              goback returning CONSULTSUM-FAILED
           end-if

           perform varying ls-counter from 1 by 1
               until ls-counter > cont-counter

               *> Build up a key to locate todays
               *> appointments..
                move 0 to consult-busy-slots(ls-counter)
                compute consult-free-slots(ls-counter)
                     = 1 + (MAX-APPS-PER-DAY - ap-time-slot)

                move cp-consultant-id(ls-counter) to app-consultant-id

                *> position ourselves..
                start appointment-file
                   key = appointment-key
                end-start

                if not fs-no-record
                    read appointment-file next record
                         at end move "y" to ls-eof
                    end-read
                    if ls-eof not equal "y" and
                       app-consultant-id > 1
                      perform process-record
                    end-if
                else
                    compute consult-free-slots(ls-counter)
                        = 1 + (MAX-APPS-PER-DAY - ap-time-slot)
                    compute free-slots(ls-counter)
                       = 1 + (MAX-APPS-PER-DAY - ap-time-slot)
                end-if

                compute consult-freep-slots(ls-counter) =
                  (free-slots(ls-counter) /
                    (busy-slots(ls-counter) +
                     free-slots(ls-counter))
                    * 100)

           end-perform

           perform display-summmary
           close appointment-file
           goback returning CONSULTSUM-OK
        .

       display-summmary.
            display g-SUMMARYPOPUP
            perform press-any-key
          .

       init-fields.
            perform varying ls-counter from 1 by 1
              until ls-counter > MAX-CONSULTANTS-PER-STORE
                move 0 to busy-slots(ls-counter)
                move 0 to free-slots(ls-counter)
                move 0 to consult-busy-slots(ls-counter)
                move 0 to consult-free-slots(ls-counter)
                move 0 to consult-freep-slots(ls-counter)
                move spaces to cp-fullname(ls-counter)
            end-perform
         .

       process-record.
            move 0 to consult-free-slots(ls-counter)
            move 0 to free-slots(ls-counter)

            perform varying counter from ap-time-slot by 1
              until counter > MAX-APPS-PER-DAY

               if app-cust-id of
                app-days(di-day-of-week-num counter)
                  not equal 0
                    add 1 to busy-slots(ls-counter)
                    move busy-slots(ls-counter) to
                        consult-busy-slots(ls-counter)
               else
                  add 1 to free-slots(ls-counter)
                  move free-slots(ls-counter) to
                    consult-free-slots(ls-counter)
               end-if

             end-perform
        .

        copy "common.cpy".