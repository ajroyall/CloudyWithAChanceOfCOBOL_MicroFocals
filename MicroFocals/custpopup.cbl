      $set ilsmartlinkage ilsmartnest ilcutprefix"lnk-"
       identification division.
       environment division.
        special-names.
         crt status is key-status.
       file-control.
        copy "customer-fc.cpy".

       data division.
       fd cust-file.
       01 f-CustomerInformation.
       copy "customerinfo.cpy" replacing ==:Prefix-:== by ==f-==.

       WORKING-STORAGE SECTION.
       copy "common_ws.cpy".
       01 cpc-query        pic x(60).
       01 cpc-query-initials pic x(10).
       01 cpc-query-l      pic x(60).
       01 ws-fullname-len  binary-long.
       01 ws-initials-len  binary-long.
      $if console-mode defined
       01 time-to-leave    pic x.
      $end
       01 tmp-id           binary-long.
       01 eof              pic x.
       01 counter          binary-long.
       78 MAX-CUSTINFO value 15.

       01 cp-CustomerInformation occurs MAX-CUSTINFO.
       COPY "customerinfo.cpy" replacing ==:Prefix-:== by ==cp-==.

       01 ws-start-row     pic 99 value 8.
       01 ws-max-row       pic 99 value 21.
       01 ws-cur-row       pic 99 value 8.

       linkage section.
       01 lnk-Customer.
       copy "customerinfo.cpy" replacing ==:Prefix-:== by ==lnk-==.

       01 lnk-query-name   pic x(60).
       SCREEN SECTION.
       copy "common_ss.cpy".
       copy "custpopup.ss".

       procedure division using lnk-customer.
      $if console-mode defined
           perform init-array-list
           move 0 to counter
           open input cust-file

           perform read-next

           move "n" to time-to-leave
           perform until time-to-leave equals "y"
            perform display-row-highite
            perform until time-to-leave not equals "n"
             call x"af" using    get-single-char-func key-status
             evaluate key-type
                when kc-user-fn-key
                  evaluate key-code-1
                    when kc-escape
                        move 0 to counter
                        move "r" to time-to-leave
                   when kc-f1-key
                      perform show-f1-help
                  end-evaluate
                when kc-adis-fn-key
                  evaluate key-code-1
                    when adis-term-cr
                    when adis-term-accept
                      compute tmp-id = 1 + (ws-cur-row - ws-start-row)
                      move "y" to time-to-leave
                      move cp-customerinformation(tmp-id)
                        to lnk-customer
                    when adis-up-key
                      if ws-cur-row equals ws-start-row
                        if cpc-query not equals spaces
                          perform move-to-first-fullname
                          perform read-next-block
                          display g-custpopup
                        else if cpc-query-initials not equal spaces
                          perform move-to-first-initials
                          perform read-next-block
                          display g-custpopup
 	                    end-if
 	                  end-if
                      perform display-row
                      subtract 1 from ws-cur-row
                      perform display-row-highite
                    when adis-down-key
                      if ws-cur-row equal ws-max-row
                       if counter equals MAX-CUSTINFO
                        perform read-next-block
                        display g-custpopup
                       end-if
                       perform display-row
                       compute ws-cur-row = ws-start-row - 1
                       perform display-row-highite
                      else
                       perform display-row
                       add 1 to ws-cur-row
                       perform display-row-highite
                      end-if
                  end-evaluate
             end-evaluate
            end-perform

            *> accept the date again?
            if time-to-leave equals "r"
              move "n" to time-to-leave
              perform read-next
            end-if

           end-perform
           close cust-file
           perform check-file-status
      $end
           goback returning CUSTPOPUP-OK.

       init-array-list section.
           perform varying counter from 1 by 1
            until counter greater than MAX-CUSTINFO
            initialize cp-customerinformation(counter)
           end-perform
           .

      $if console-mode defined
       read-next section.
            perform until counter not equal 0
             display g-custpopuP
             accept g-custpopup
             perform f1-or-quit

             move "n" to eof

             perform init-array-list
             if cpc-query not equal spaces
                 perform move-to-first-fullname
                 perform read-next-block
                 display g-custpopup
             else
                 perform move-to-first-initials
                 perform read-next-block
                 display g-custpopup
             end-if


            end-perform
        .

       reset-to-start-of-file section.
           move 0 to f-Customer-Id
            start cust-file
             key > f-Customer-Id
             invalid key
              move "y" to eof
            end-start
          .

       read-next-block section.
         *> call "CBL_DEBUGBREAK"
         move 0 to counter
         move "n" to eof
         if fs-no-record or fs-no-next-logical-record
           move "y" to eof
         end-if

         perform until eof equals "y"
          read cust-file next record
              at end
                move "y" to eof
          end-read

          *> end of record or end of chain of records?
          if fs-no-record or fs-no-next-logical-record
           move "y" to eof
          else
           perform check-file-status
          end-if

          *> if query via name, then restrict it to the one that seem reasonable.
          if cpc-query not equal spaces
            if cpc-query-l(1:ws-fullname-len)
                    not equal f-lc-fullname(1:ws-fullname-len)
              move "y" to eof
            end-if
          end-if

          *> if query via initials only, show ones that are reasonable
          if cpc-query-initials not equal spaces
            if cpc-query-initials(1:ws-initials-len)
                    not equal f-initials(1:ws-initials-len)
              move "y" to eof
            end-if
          end-if


          if eof not equal "y"
           add 1 to counter
           move f-CustomerInformation to
                cp-CustomerInformation(counter)
           if counter equals MAX-CUSTINFO
             move "y" to eof
          end-if
         end-perform
         compute ws-max-row = (ws-start-row + counter) - 1
         perform show-message-if-not-found
         .

       display-row-highite section.
           perform ensure-pos-valid
           compute tmp-id = 1 + (ws-cur-row - ws-start-row)
           display cp-fullname(tmp-id) at line ws-cur-row
                column 4
                with background-color mf-app-revbg-colour
           display cp-initials(tmp-id) at line ws-cur-row
                column 67
                with background-color mf-app-revbg-colour
        .

       display-row section.
           perform ensure-pos-valid
           compute tmp-id = 1 + (ws-cur-row - ws-start-row)
           display cp-fullname(tmp-id) at line ws-cur-row
                column 4
                with background-color mf-app-background-colour
           display cp-initials(tmp-id) at line ws-cur-row
                column 67
                with background-color mf-app-background-colour
        .

       move-to-first-initials section.
           move function upper-case(cpc-query-initials)
                    to cpc-query-initials
           move cpc-query-initials to f-initials
           move 0 to ws-initials-len
           inspect function reverse(cpc-query-initials)
               tallying ws-initials-len for leading spaces
           compute ws-initials-len = length of cpc-query-initials -
                                      ws-initials-len
           move "n" to eof
           start cust-file
             key = f-initials
             invalid key
              move "y" to eof
           end-start
           *> perform show-message-if-not-found
           .

       move-to-first-fullname section.
          move function lower-case(cpc-query) to cpc-query-l
          move 0 to ws-fullname-len
          inspect function reverse(cpc-query)
               tallying ws-fullname-len for leading spaces
          compute ws-fullname-len = length of cpc-query -
                                      ws-fullname-len

           move cpc-query to f-fullname
           start cust-file
             key >= f-fullname
             invalid key
              move "y" to eof
           end-start

           if fs-no-record
            move spaces to f-fullname
            move function lower-case(cpc-query) to f-lc-fullname
            start cust-file
             key >= f-lc-fullname
             invalid key
              move "y" to eof
            end-start
           end-if

           perform show-message-if-not-found
           .

       show-message-if-not-found section.
           if fs-no-record or counter equal 0
                move "No customer found"
                        to popup-l-message
                move "Okay" to popup-l-button
                perform display-lower-popup
                move "y" to eof
           end-if
           .

       ensure-pos-valid section.
           if ws-cur-row < ws-start-row
            move ws-start-row to ws-cur-row
           end-if

           if ws-cur-row > ws-max-row
            move ws-max-row to ws-cur-row
           end-if
           .
      $end


       locate-customer section.
           move cpc-query to f-fullname
           start cust-file
             key = f-fullname
             invalid key
              move "y" to eof
           end-start

           *> Okay, we don't have a customer with this
           *> name....
           if fs-no-record
             move spaces to f-fullname
             move cpc-query to f-initials
             start cust-file
               key = f-initials invalid key
                move "y" to eof
              end-start
           else
               perform check-file-status
           end-if

           if fs-no-record
                move "No customer found"
                        to popup-l-message
                move "Okay" to popup-l-button
                perform display-lower-popup
                move "y" to eof
           end-if
           .



       getacustomer section.

        *> find a customer customer and return its
        *> information...
       entry "getacustomer" using
                lnk-query-name
                lnk-customer.

          open input cust-file
          perform check-file-status

          move lnk-query-name to cpc-query
          perform locate-customer

          read cust-file next record
              at end
                move "y" to eof
          end-read

          *> end of record or end of chain of records?
          if fs-no-record or fs-no-next-logical-record
           close cust-file
           exit program returning 1
          else
           perform check-file-status
          end-if

          move f-CustomerInformation to lnk-customer
          close cust-file

          goback returning CUSTPOPUP-OK

          .

        copy "common.cpy".
