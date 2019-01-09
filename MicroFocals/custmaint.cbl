      $set remove"address"
      $set remove"title"
       program-id. custmaint.
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
      $if use-sql defined
       EXEC SQL INCLUDE SQLCA END-EXEC.
      $end
       
       01 CustomerInformation.
       COPY "customerinfo.cpy" replacing ==:Prefix-:== by == ==.
       COPY "common_ws.cpy".

       01 date-today-temp                        pic x(8).
       01 date-today redefines date-today-temp.
         03 dt-yyyy      pic xxxx.
         03 dt-mm        pic xx.
         03 dt-dd        pic xx.

       01 field-valid    pic x.
       01 invalid-mess   pic x(40).
       01 split-area-for-fullname pic x(60) occurs 10.
       linkage section.
       copy "common_lnk.cpy".
       01 lnk-operation		pic x.
       88 is-add                value "a", "A".
       88 is-edit               value "e", "E".
       88 is-delete             value "r", "R".
       SCREEN SECTION.
       COPY "CUSTADD.ss".

       copy "common_ss.cpy".
       PROCEDURE DIVISION using lnk-Store-info, lnk-operation
                                , dataflow-info.
          accept date-today-temp from date YYYYMMDD
          move dt-yyyy to cs-yyyy
          move dt-mm to cs-mm
          move dt-dd to cs-dd
          move 01 to dob-dd dob-mm
          move 1960 to dob-yyyy
          move lnk-name-of-store to Store-Name
          move "Customer Maintenance" to Menu-Name
          
          

          if is-add
            move "CM_A01" to Menu-Id
            call "gencustid" using f-Customer-Id
            move "n" to glaucoma cataracts
                        Diabetic-retinopathy Colour-blindness

            move spaces to home-tel
            move lnk-id to Preferred-Store-Id
            move home-tel to work-tel
          end-if

          if is-edit
            move "CM_E01" to Menu-Id
          end-if

          if is-delete
            move "CM_D01" to Menu-Id
          end-if
          
           string lnk-text '-' Menu-Id delimited by spaces
                  into lnk-text
           end-string.
           
           multiply 3 by row-number giving lnk-num.
      $if use-sql defined
           EXEC SQL
               insert into DataFlow
               (Number,Text) values (:lnk-num,:lnk-text)
           END-EXEC
           EXEC SQL commit END-EXEC
      $end

          perform clr-screen
          display g-menuheader

          if not is-add
           call "custpopup" using CustomerInformation
           call "custdelete" using CustomerInformation
           if return-code equals CUSTMAINT-FAILED
           	goback
           end-if
          end-if

          if is-delete
              display g-custadd
              move "Are you sure you want to delete this customer?"
                  to popup-l-message
              move "[Y]es or [N]o" to popup-l-button
              perform display-lower-popup
              if scr-af-key-code-1x equals "y"
               or scr-af-key-code-1x equals "Y"
                perform delete-customer
              end-if
              goback
          end-if

          perform until field-valid equals "y"
              perform clr-screen
              display g-menuheader
              display g-custadd
              accept g-custadd
              perform f1-or-quit

              unstring FullName
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

              move split-area-for-fullname(1) to Initials(1:1)
              move split-area-for-fullname(2) to Initials(2:1)
              move split-area-for-fullname(3) to Initials(3:1)
              move split-area-for-fullname(4) to Initials(4:1)
              move split-area-for-fullname(5) to Initials(5:1)
              move split-area-for-fullname(6) to Initials(6:1)
              move split-area-for-fullname(7) to Initials(7:1)
              move split-area-for-fullname(8) to Initials(8:1)
             display g-initials

             move "n" to field-valid
             perform ac-gender until field-valid equals "y"
             perform update-invalid-message

             move "n" to field-valid
             perform ac-title until field-valid equals "y"
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

             move "Are you sure you want to add this customer?"
                  to popup-l-message
             move "[Y]es or [N]o or [E]dit" to popup-l-button
             perform display-lower-popup
              if scr-af-key-code-1x equals "e"
               or scr-af-key-code-1x equals "E"
               move "n" to field-valid
              else if scr-af-key-code-1x equals "n"
               or scr-af-key-code-1x equals "N"
               or scr-af-key-code-1x equals "Y"
               or scr-af-key-code-1x equals "y"
                move "y" to field-valid
              end-if
             end-perform

          if scr-af-key-code-1x equals "n"
               or scr-af-key-code-1x equals "N"
               goback returning CUSTMAINT-OK
          end-if


          open i-o cust-file
          if ws-file-status not equals "00"
            close cust-file
            open output cust-file
           perform check-file-status
          end-if
          move CustomerInformation to f-CustomerInformation
          *> ensure we have the lc fullname for case insentive comparisions
          move function lower-case(f-fullname) to f-lc-fullname

          write f-CustomerInformation
          if fs-key-already-exists
           rewrite f-CustomerInformation
          end-if
          perform check-file-status
          close cust-file
          perform check-file-status
          goback returning CUSTMAINT-OK.


        delete-customer.
         open i-o cust-file
          if ws-file-status not equals "00"
            close cust-file
            open output cust-file
           perform check-file-status
          end-if
          move CustomerInformation to f-CustomerInformation
          delete cust-file
          perform check-file-status
          close cust-file
          perform check-file-status
          .

        ac-gender.
           if Valid-Gender
                move "y" to field-valid
           else
                move "Gender is invalid, use M/F" to invalid-mess
                perform update-invalid-message
                accept g-gender
                perform f1-or-quit
           end-if
           .

        ac-title.
           inspect Title converting
                'ABCDEFGHIJKLMNOPQRSTUVWXYZ' TO
                'abcdefghijklmnopqrstuvwxyz'
           inspect Title(1:1) converting
                'abcdefghijklmnopqrstuvwxyz' TO
                'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
           display g-title
           if valid-title
                move "y" to field-valid
           else
                move "Title is invalid" to invalid-mess
                perform update-invalid-message
                accept g-title
                perform f1-or-quit
           end-if
           .

        ac-glaucoma.
           if Valid-Glaucoma
                move "y" to field-valid
           else
                move "glaucoma is invalid, y/n" to invalid-mess
                perform update-invalid-message
                accept g-glaucoma
                perform f1-or-quit
           end-if
           .

        ac-cataracts.
           if Valid-Cataracts
                move "y" to field-valid
           else
                move "cataracts is invalid, y/n" to invalid-mess
                perform update-invalid-message
                accept g-cataracts
                perform f1-or-quit
           end-if
           .

        ac-diabetic.
           if Valid-Diabetic-retinopathy
                move "y" to field-valid
           else
                move "diabetic is invalid, y/n" to invalid-mess
                perform update-invalid-message
                accept g-diabetic
                perform f1-or-quit
           end-if
           .


        ac-colour-blindness.
           if Valid-Colour-Blindness
                move "y" to field-valid
           else
                move "colour blindness is invalid, y/n" to invalid-mess
                perform update-invalid-message
                accept g-colour-blindness
                perform f1-or-quit
           end-if
           .

        update-invalid-message.
           if field-valid equals "y"
              move spaces to invalid-mess
              display invalid-mess at 2320 with background-color 3
           else
                move "Field validation error" to popup-title
                move spaces to popup-message-1
                move invalid-mess to popup-message-2
                move "Okay" to popup-button-1
                call "errpopup" using popup-title,
                        popup-message-1,
                        popup-message-2
                        popup-button-1
                end-call

               display invalid-mess at 2320 with reverse-video
           end-if
           .

       copy "common.cpy".

       end program custmaint.
