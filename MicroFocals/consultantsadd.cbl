       identification division.
       environment division.
       special-names.
         crt status is key-status.
       input-output section.
       file-control.
       copy "stores-fc.cpy".

       select consult-id-file assign "$MFOCALDIR/consultid.dat"
       organization is sequential
       status is ws-file-status.

       copy "consultants-fc.cpy".

       copy "stores-fd.cpy".

       fd consultants-file.
       01 cf-consultant.
       copy "consultants.cpy" replacing ==:Prefix-:== by ==cf-==.

       fd consult-id-file.
       01 ConsultantIdInformation.
         03 Highest-Consultant-Id      pic 9(9).


       WORKING-STORAGE SECTION.
       copy "common_ws.cpy".
       01 mfs-stores       occurs MAX-STORES times.
       copy "stores.cpy" replacing ==:Prefix-:== by ==mfs-==.

       01 mfc-consultant.
       copy "consultants.cpy" replacing ==:Prefix-:== by ==mfc-==.

       01 ws-c-Store-Information.
          COPY "stores.cpy" replacing ==:Prefix-:== by ==ws-c-==.

       01 ws-next-free             binary-long.
       01 invalid-mess             pic x(40).
       01 field-valid              pic x.
       01 split-area-for-fullname  pic x(60) occurs 10.
       local-storage section.
       01 ls-counter               binary-long.
       linkage section.
       copy "common_lnk.cpy".
       01 lnk-consultant-menu-option pic x.
       SCREEN SECTION.
       copy "common_ss.cpy".
       COPY "CONSULTANTSADD.ss".
       PROCEDURE DIVISION using lnk-store-info,
                                lnk-consultant-menu-option.
      $if console-mode defined
           perform init-section
           perform setup-section

           move lnk-name-of-store to Store-Name
           move "Consultant Maintenance" to Menu-Name
           evaluate lnk-consultant-menu-option
            when 'a'
            when 'A'
                   perform clr-screen
               move "CT_A01" to Menu-Id
                   display g-menuheader
                   perform add-consultant
                   perform setup-section
                   display g-consultantsadd
            when 'e'
            when 'E'
               perform clr-screen
               move "CT_E01" to Menu-Id
                   display g-menuheader
                   call "consultpopup" using lnk-store-info,
                                             mfc-consultant
                   perform setup-section
                   display g-consultantsadd
                   perform add-consultant

            when 'r'
            when 'R'
                   perform clr-screen
               move "CT_R01" to Menu-Id
                   display g-menuheader
                   call "consultpopup" using lnk-store-info,
                                             mfc-consultant
                   perform setup-section
                   display g-consultantsadd
               move "Are you sure you want to remove this consultant?"
                      to popup-l-message
               move "[Y]es or [N]o" to popup-l-button
               perform display-lower-popup
                   if scr-af-key-code-1x equals "Y"
                   or scr-af-key-code-1x equals "y"
                      perform delete-consultant-record
                   end-if
                   goback
           end-evaluate
      $end
       goback.


       save-storeinfo.
          open i-o store-file with lock
          perform check-file-status

          move lnk-store-info to sf-store-information
          write sf-store-information
          if fs-key-already-exists
                rewrite sf-store-information
          end-if

          perform check-file-status

          close store-file
          perform check-file-status
        .

      $if console-mode defined
       add-consultant section.
           display g-consultantsadd
           accept g-consultantsadd

           move key-code-1 to key-code-1-display
           if key-type equals adis-term-prog
              and key-code-1 equals kc-escape
                    goback returning -1
           end-if

           display g-consultantsadd

           unstring mfc-FullName
                delimited by spaces into
                        split-area-for-fullname(1)
                        split-area-for-fullname(2)
                        split-area-for-fullname(3)
                        split-area-for-fullname(4)
                        split-area-for-fullname(5)
                        split-area-for-fullname(6)
                        split-area-for-fullname(7)
                        split-area-for-fullname(8)
                        split-area-for-fullname(9)
                        split-area-for-fullname(10)
           end-unstring

           move split-area-for-fullname(1) to mfc-Initials(1:1)
           move split-area-for-fullname(2) to mfc-Initials(2:1)
           move split-area-for-fullname(3) to mfc-Initials(3:1)
           move split-area-for-fullname(4) to mfc-Initials(4:1)
           move split-area-for-fullname(5) to mfc-Initials(5:1)
           move split-area-for-fullname(6) to mfc-Initials(6:1)
           move split-area-for-fullname(7) to mfc-Initials(7:1)
           move split-area-for-fullname(8) to mfc-Initials(8:1)
            inspect mfc-Initials converting
                'abcdefghijklmnopqrstuvwxyz' TO
                'ABCDEFGHIJKLMNOPQRSTUVWXYZ'

           display g-initials
           move "n" to field-valid
           perform ac-title until field-valid equals "y"
           perform update-invalid-message

           move "n" to field-valid
           perform ac-gender until field-valid equals "y"
           perform update-invalid-message

           move "n" to field-valid
           perform ac-glaucoma until field-valid equals "y"
           perform update-invalid-message

           move "n" to field-valid
           perform ac-cataracts until field-valid equals "y"
           perform update-invalid-message

           move "n" to field-valid
           perform ac-diabetic until field-valid equals "y"
           perform update-invalid-message

           move "n" to field-valid
           perform ac-colour-blindness until field-valid equals "y"
           perform update-invalid-message

           move "Are you sure want to add this consultant?"
                  to popup-l-message
           move "[Y]es or [N]o" to popup-l-button
           perform display-lower-popup
           if scr-af-key-code-1x equals "Y"
               or scr-af-key-code-1x equals "y"
                perform save-consultant-id-file
                perform save-consultant-file
                move mfc-Consultant-Id to
                    lnk-consultants-id(ws-next-free)
                perform save-storeinfo
           end-if
           .
      $end
       
       init-section section.
           *> perform varying ls-counter from 1 by 1
           *>     until ls-counter > MAX-CONSULTANTS-PER-STORE
           *>      move 0 to mfc-stores-id(ls-counter)
           *> end-perform
           *> move 0 to Highest-Consultant-Id
           move 0 to mfc-Consultant-Id
           perform load-Consultant-id-file
           .

       load-Consultant-id-file section.
            open input consult-id-file
            if ws-file-status not equals "00"
               open output consult-id-file
               perform check-file-status
               move 1 to Highest-Consultant-Id
               close consult-id-file
            else
               read consult-id-file
               perform check-file-status
               add 1 to Highest-Consultant-Id
               close consult-id-file
               perform check-file-status
            end-if

            move Highest-Consultant-Id to mfc-Consultant-Id

           .

        save-consultant-id-file section.
           open output consult-id-file
           perform check-file-status

           write ConsultantIdInformation
           perform check-file-status

           close consult-id-file
           perform check-file-status
           .

         delete-consultant-record section.
           open i-o consultants-file
           perform check-file-status

           move mfc-consultant to cf-consultant
           delete consultants-file
           perform check-file-status

           close consultants-file
           perform check-file-status
            .

         save-consultant-file section.
          open i-o consultants-file
          perform check-file-status

          move mfc-consultant to cf-consultant
          write cf-consultant
          if fs-key-already-exists
             rewrite cf-consultant
          end-if
          perform check-file-status

          close consultants-file
          perform check-file-status
            .

       setup-section section.
           move 0 to ws-next-free
           perform varying ls-counter from 1 by 1
               until ls-counter > MAX-CONSULTANTS-PER-STORE

                if lnk-consultants-id(ls-counter) equals 0
                   if ws-next-free equals 0
                      move ls-counter to ws-next-free
                   end-if
                end-if
           end-perform
              .


        ac-gender section.
           if mfc-Valid-Gender
                move "y" to field-valid
           else
                move "Gender is invalid, use M/F" to invalid-mess
                perform update-invalid-message
                accept g-gender
           end-if
           .

        ac-title section.
           inspect mfc-title converting
                'ABCDEFGHIJKLMNOPQRSTUVWXYZ' TO
                'abcdefghijklmnopqrstuvwxyz'
           inspect mfc-title(1:1) converting
                'abcdefghijklmnopqrstuvwxyz' TO
                'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
           display g-title
           if mfc-valid-title
                move "y" to field-valid
           else
                move "Title is invalid" to invalid-mess
                perform update-invalid-message
                accept g-title
           end-if
           .

        ac-glaucoma section.
           if mfc-Valid-Glaucoma
                move "y" to field-valid
           else
                move "glaucoma is invalid, y/n" to invalid-mess
                perform update-invalid-message
                accept g-glaucoma
           end-if
           .

        ac-cataracts section.
           if mfc-Valid-Cataracts
                move "y" to field-valid
           else
                move "cataracts is invalid, y/n" to invalid-mess
                perform update-invalid-message
                accept g-cataracts
           end-if
           .

        ac-diabetic section.
           if mfc-Valid-Diabetic-retinopathy
                move "y" to field-valid
           else
                move "diabetic is invalid, y/n" to invalid-mess
                perform update-invalid-message
                accept g-diabetic-retinopathy
           end-if
           .


        ac-colour-blindness section.
           if mfc-Valid-Colour-Blindness
                move "y" to field-valid
           else
                move "colour blindness is invalid, y/n" to invalid-mess
                perform update-invalid-message
                accept g-colour-blindness
           end-if
           .

        update-invalid-message section.
           if field-valid equals "n"
                move "Field validation error" to popup-title
                move spaces to popup-message-1
                move invalid-mess to popup-message-2
                move "Okay" to popup-button-1
                call "errpopup" using popup-title,
                        popup-message-1,
                        popup-message-2
                        popup-button-1
                end-call
           end-if
           .


           copy "common.cpy".
