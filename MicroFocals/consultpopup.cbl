       identification division.
       environment division.
       special-names.
         crt status is key-status.
       input-output section.
       file-control.
       copy "consultants-fc.cpy".

       fd consultants-file.
       copy "common_78.cpy".
       01 cf-consultant.
       copy "consultants.cpy" replacing ==:Prefix-:== by ==cf-==.

       WORKING-STORAGE SECTION.
       copy "common_ws.cpy".
       01 cp-Consultants-grp.
        02 cp-Consultant occurs  MAX-CONSULTANTS-PER-STORE.
        copy "consultants.cpy" replacing ==:Prefix-:== by ==cp-==.

       01 ws-start-row    pic 99 value 6.
       01 ws-max-row      pic 99 value 20.
       01 ws-cur-row      pic 99 value 6.

       local-storage section.
       01 tmp-id           binary-long.
       01 time-to-leave    pic x.

       linkage section.
       copy "common_lnk.cpy".
       01 lnk-Consultant.
       copy "consultants.cpy" replacing ==:Prefix-:== by ==lnk-==.

       SCREEN SECTION.
       copy "common_ss.cpy".
       COPY "CONSULTPOPUP.ss".

       PROCEDURE DIVISION using lnk-store-info, lnk-Consultant.
      $if console-mode defined
           initialize cp-Consultants-grp
           perform setup-section

           *> save the screen, so we can restore it later
           perform save-screen

           *> show the actual consultant screen
           display g-consultpopup

           *> highlight the item
           perform display-row-highite
           move "n" to time-to-leave

           perform until time-to-leave equals "y"

            *> get a single key and it's status eg: what type of key it is..
            call x"AF" using
                by reference get-single-char-func
                by reference key-status
            end-call

            evaluate key-type
                when kc-user-fn-key
                  evaluate key-code-1
                    when kc-escape
                        *> restore the screen and leave
                        perform restore-screen
                    	goback returning CONSULTPOPUP-FAILED
                    when kc-f1-key
                      perform show-f1-help
                  end-evaluate
                when kc-adis-fn-key
                  evaluate key-code-1
                    when adis-term-cr
                    when adis-term-accept
                      compute tmp-id = 1 + (ws-cur-row - ws-start-row)
                      move "y" to time-to-leave
                      move cp-Consultant(tmp-id) to lnk-Consultant
                    when adis-up-key
                      perform display-row
                      subtract 1 from ws-cur-row
                      perform display-row-highite
                    when adis-down-key
                      perform display-row
                      add 1 to ws-cur-row
                      perform display-row-highite
                  end-evaluate
            end-evaluate
           end-perform

           *> restore the screen and leave
           perform restore-screen
           goback returning CONSULTPOPUP-OK .


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
           if cp-Consultant-id(tmp-id) not equal 0
            display cp-Consultant-id(tmp-id) at line ws-cur-row
              column 4
              with background-color mf-app-revbg-colour
            display cp-fullname(tmp-id) at line ws-cur-row
              column 16
              with background-color mf-app-revbg-colour
           end-if
           .

        display-row section.
           perform ensure-pos-valid
           compute tmp-id = 1 + (ws-cur-row - ws-start-row)
           if cp-Consultant-id(tmp-id) not equal 0
            display cp-Consultant-id(tmp-id) at line ws-cur-row
              column 4
              with background-color mf-app-background-colour

            display cp-fullname(tmp-id) at line ws-cur-row
              column 16
              with background-color mf-app-background-colour
           end-if
           .


        setup-section section.
           call "getconsults" using
                lnk-store-info
                cp-Consultants-grp
            end-call
        .
      $end
        copy "common.cpy".
