       identification division.
       program-id. storepopup is initial.
       environment division.
        special-names.
         crt status is key-status.
       file-control.
       copy "stores-fc.cpy".
       copy "storeconf-fc.cpy".

       copy "stores-fd.cpy".
       copy "storeconf-fd.cpy".

       WORKING-STORAGE SECTION.
       copy "common_ws.cpy".
       01 sp-query         pic x(60).

       01 time-to-leave    pic x.
       01 tmp-id           binary-long.

       01 eof              pic x.
       01 counter          binary-long.
       78 MAX-CUSTINFO     value 15.
       01 sp-stores        occurs MAX-CUSTINFO.
       COPY "stores.cpy" replacing ==:Prefix-:== by ==sp-==.

       01 ws-start-row    pic 99 value 7.
       01 ws-max-row      pic 99 value 21.
       01 ws-cur-row      pic 99 value 7.
       01 sp-len          binary-long.
       01 sp-pc-search    pic x.

       linkage section.
       01 lnk-store.
       copy "stores.cpy" replacing ==:Prefix-:== by ==lnk-==.
       SCREEN SECTION.
       copy "common_ss.cpy".
       copy "storepopup.ss".

       procedure division using lnk-store.
           perform init-env

           perform varying counter from 1 by 1
            until counter greater than MAX-CUSTINFO
            initialize sp-stores(counter)
           end-perform
           move 0 to counter
           move 1 to sf-id
           open input store-file
           perform check-file-status
           perform read-first-set-of-block

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
                  end-evaluate
                when kc-adis-fn-key
                  evaluate key-code-1
                    when adis-term-cr
                    when adis-term-accept
                      compute tmp-id = 1 + (ws-cur-row - ws-start-row)
                      move "y" to time-to-leave
                      move sp-stores(tmp-id)
                        to lnk-store
                    when adis-up-key
                      if ws-cur-row equals ws-start-row
                        if sp-query equals spaces
                          perform move-to-default
                          perform read-next-block
                          display g-storepopup
                       else
                          perform move-to-first-fullname
                          perform read-next-block
                          display g-storepopup
 	               end-if
 	              end-if
                      perform display-row
                      subtract 1 from ws-cur-row
                      perform display-row-highite
                    when adis-down-key
                      if ws-cur-row equal  ws-max-row
                        perform read-next-block
                        display g-storepopup
                      end-if

                      perform display-row
                      add 1 to ws-cur-row
                      perform display-row-highite
                  end-evaluate
             end-evaluate
            end-perform

            *> accept the date again?
            if time-to-leave equals "r"
              move "n" to time-to-leave
              perform read-first-set-of-block
            end-if

           end-perform
           close store-file
           perform check-file-status
           goback returning STORE-OK.


        read-first-set-of-block section.
            perform until counter not equal 0
             DISPLAY G-storepopup
             accept g-storepopup
             perform f1-or-quit

             move "n" to eof

             move 0 to sp-len
             inspect function reverse(sp-query)
               tallying sp-len for leading spaces
             compute sp-len = length of sp-query - sp-len
             move "n" to sp-pc-search

             if sp-query equals spaces
                perform move-to-default
                perform read-next-block
                display g-storepopup
             else
                perform move-to-first-fullname
                perform read-next-block
                display g-storepopup
             end-if
            end-perform
        .


        read-next-block section.
         move 0 to counter
         move "n" to eof
         if fs-no-record or fs-no-next-logical-record
           move "y" to eof
         end-if

         perform until eof equals "y"
          read store-file next record
              at end
                move "y" to eof
          end-read

          *> only show the names that are simular
          if sp-pc-search equals "n" and
            sf-name-of-store(1:sp-len) not equal
            sp-query(1:sp-len)
            move "y" to eof
          end-if

          *> end of record or end of chain of records?
          if fs-no-record or fs-no-next-logical-record
           move "y" to eof
          else
           perform check-file-status
          end-if

          if eof not equal "y"
           add 1 to counter
           move sf-store-information to
                sp-stores(counter)
           if counter equals MAX-CUSTINFO
             move "y" to eof
          end-if
         end-perform
         .

        ensure-pos-valid section.
           if ws-cur-row < ws-start-row
            move ws-start-row to ws-cur-row
           end-if

           if ws-cur-row > ws-max-row
            move ws-max-row to ws-cur-row
           end-if
           .

        display-row-highite section.
           perform ensure-pos-valid
           compute tmp-id = 1 + (ws-cur-row - ws-start-row)
           display sp-name-of-store(tmp-id) at line ws-cur-row
                column 4
                with background-color mf-app-revbg-colour
           display sp-postcode(tmp-id) at line ws-cur-row
                column 47
                with background-color mf-app-revbg-colour
        .

        display-row section.
           perform ensure-pos-valid
           compute tmp-id = 1 + (ws-cur-row - ws-start-row)
           display sp-name-of-store(tmp-id) at line ws-cur-row
                column 4
                with background-color mf-app-background-colour
           display sp-postcode(tmp-id) at line ws-cur-row
                column 47
                with background-color mf-app-background-colour
        .


        move-to-default section.
            perform get-storeconf
            move conf-current-id to sf-id
            start store-file
             key = sf-id
             invalid key
              move "y" to eof
           end-start
           perform check-file-status
            .

        move-to-first-fullname section.
           initialize sf-Store-Information
           move sp-query to sf-name-of-store
           start store-file
             key >= sf-name-of-store
             invalid key
              move "y" to eof
           end-start

           *> Okay, we don't have a customer with this
           if fs-no-record
             initialize sf-Store-Information
             move sp-query to sf-postcode
             move "n" to eof
             move "y" to sp-pc-search
             start store-file
               key = sf-postcode invalid key
                move "y" to eof
              end-start
             perform check-file-status
            else
                perform check-file-status
           end-if

           if fs-no-record
             move "No customer found" to popup-l-message
             move "Okay" to popup-l-button
             perform display-lower-popup
             move "y" to eof
           end-if

        .
        copy "common.cpy".
        copy "storeconf_common.cpy".
