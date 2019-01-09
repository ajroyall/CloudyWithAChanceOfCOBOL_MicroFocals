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

       01 Conf-Store-Information.
       COPY "stores.cpy" replacing ==:Prefix-:== by ==Conf-==.

       local-storage section.
       01 ls-max-id         binary-long.
       01 ls-counter        binary-long.
       01 ls-add-counter    binary-long.
       01 ls-eof            pic x.

       linkage section.
       copy "common_lnk.cpy".

       01 lnk-consultant occurs  MAX-CONSULTANTS-PER-STORE.
       copy "consultants.cpy" replacing ==:Prefix-:== by ==lnk-==.

       SCREEN SECTION.
       copy "common_ss.cpy".

       PROCEDURE DIVISION using lnk-store-info, lnk-consultant.
           move 0 to ls-max-id
           perform varying ls-counter from 1 by 1
               until ls-counter > MAX-CONSULTANTS-PER-STORE
               if lnk-consultants-Id(ls-counter) not equal 0
                add 1 to ls-max-id
               end-if
           end-perform

           if ls-max-id equals MAX-CONSULTANTS-PER-STORE
              move "Consultants file error" to popup-title
                move spaces to popup-message-1
                move "No consultants found" to popup-message-2
                move "Okay" to popup-button-1
                call "errpopup" using popup-title,
                        popup-message-1,
                        popup-message-2
                        popup-button-1
                end-call
                exit program returning -1
           end-if

           move 0 to ls-counter ls-add-counter
           open i-o consultants-file
           perform check-file-status
           move 0 to cf-Consultant-Id
           move "n" to ls-eof

           perform varying ls-counter from 1 by 1
               until ls-counter > MAX-CONSULTANTS-PER-STORE

             move "n" to ls-eof
             move lnk-consultants-id(ls-counter) to cf-consultant-id
             start consultants-file
               key = cf-Consultant-Id
               invalid key
                move "y" to ls-eof
             end-start

             if ls-eof not equal "y"
               perform check-file-status
               move all spaces to cf-consultant
               read consultants-file next record
                at end
                  move "y" to ls-eof
               end-read
             end-if

             if ls-eof not equal "y"
               add 1 to ls-add-counter
               move cf-Consultant-Id to
                      lnk-consultant-id(ls-add-counter)
               move cf-Initials to lnk-Initials(ls-add-counter)
               move cf-title to lnk-title(ls-add-counter)
               move cf-fullname to lnk-fullname(ls-add-counter)
               move cf-gender to lnk-gender(ls-add-counter)
               move cf-Diabetic-retinopathy to
                    	lnk-Diabetic-retinopathy(ls-add-counter)
               move cf-Cataracts to lnk-Cataracts(ls-add-counter)
               move cf-Glaucoma to lnk-Glaucoma(ls-add-counter)
               move cf-Colour-blindness to
                    	lnk-Colour-blindness(ls-add-counter)
               move cf-Glaucoma to lnk-Glaucoma(ls-add-counter)
             end-if
           end-perform

           close consultants-file
           perform check-file-status
           goback returning ls-max-id
        .

        copy "common.cpy".
