      *$set dialect(mf)
       identification division.
       environment division.
       special-names.
         crt status is key-status.
       input-output section.
       file-control.
       copy "stores-fc.cpy".
       copy "storeconf-fc.cpy".

       copy "stores-fd.cpy".
       copy "storeconf-fd.cpy".
       working-storage section.
       01 k                pic x.
      $if use-sql defined
       EXEC SQL INCLUDE SQLCA END-EXEC.

       EXEC SQL BEGIN DECLARE SECTION END-EXEC
           01 connectionstring pic x(300) value spaces.
           01 message1         pic x(100) value spaces.
           01 max-id           pic 9999 value 0.
       EXEC SQL END DECLARE SECTION END-EXEC
      $end
       

       01 ws-store-info.
       COPY "stores.cpy" replacing ==:Prefix-:== by ==ws-==.
       
       01 dataflow-info.
       copy "dataflow.cpy" replacing ==:Prefix-:== by ==ws-==.

       copy "common_78.cpy".
       copy "gettimeslot.cpy" replacing  ==:Prefix-:== by ==ap-==.

       01 ra-menu-option   pic x.
       01 cmd-line         pic x(128).

       copy "common_ws.cpy".

       local-storage section.
       01 ls-eof           pic x.
       01 ls-key-invalid   pic x.

       01 ls-gcd-flags     cblt-os-flags.
       01 ls-gcd-len       cblt-os-size.
       01 ls-gcd-dir-name  pic x(1024).
       SCREEN SECTION.
       copy "welcome.ss".
       copy "appscreen.ss".
       copy "reviewmenu.ss".
       copy "maintscreen.ss".
       copy "common_ss.cpy".
       procedure division.
      $if use-sql defined
      * NOTE: If you want to run this application and use the SQL part 
      *  as well, you'll need to have MSSQL installed with a database 
      *  named SampleDB1 and these 2 tables:
      *
      * THIS IS _NOT_ MANDATORY FOR THE COBOL ANALYZER TUTORIALS
      *
      *    CREATE TABLE [dbo].[DataFlow](
      *    [Number] [int] NULL,
      *    [Text] [text] NULL,
      *    [TimeStamp] [timestamp] NULL
      *    ) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
      *
      *    CREATE TABLE [dbo].[SystemMessages](
      *    [Message] [text] NULL,
      *    [ID] [int] IDENTITY(1,1) NOT NULL
      *    ) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

      *    
           MOVE "Driver={SQL Server Native Client 11.0};"
           & "Server=tcp:localhost;Database=SampleDB1;"
           & "Trusted_Connection=Yes;MARS_Connection=Yes;"
           TO connectionstring.      
           exec sql
               connect using :connectionstring
           end-exec
           exec sql
               select max(ID) into :max-id
               from SystemMessages
           end-exec
           EXEC SQL
                SELECT Message INTO :message1
                FROM SystemMessages
                where ID = :max-id
           END-EXEC
      $end
            initialize ap-time-left-in-mins
            initialize menu-option

            *> enable adis mode
            call "setadismode"

            *> setup the environment
            perform init-env

            *> application configuration
            perform setup-section


            *> Display the initial screen and wait for
            *> five seconds and then continue
            perform clr-screen
            display g-welcome
            accept g-welcome *> timeout after 5

           *> show the main menu and then accept a key
           *> and perform the right menu action
           perform until menu-option equals "0"
             move "Appointments Menu" TO Menu-Name
             move "M001" to Menu-Id
             perform clr-screen
             display g-menuheader
             display g-appscreen

             move space to menu-option
             perform with test after until menu-option not equal space
               move "n" to ls-key-invalid
               call "gettimeslot" using
                    by reference ap-current-timeslot
               end-call
               if ap-time-left-in-mins < 5
               *> Log time slots with less than 5 minutes left
      $if use-sql defined
               EXEC SQL
                   insert into DataFlow
                   (Number,Text) 
                   values (:ap-time-left-in-mins,:ap-time-slot-msg)
               END-EXEC
               EXEC SQL commit END-EXEC
      $end
               end-if
               display app-time-slot
               accept g-appscreen timeout after 1
               move key-code-1 to key-code-1-display
               if key-type equals adis-term-prog
                evaluate key-code-1
                   when kc-escape
                        move "0" to menu-option
                   when kc-f1-key
                      perform show-f1-help
                      *> display g-apphelp
                      *> accept k at 2379
                   when other
                         move "y" to ls-key-invalid
                 end-evaluate
                end-if
             end-perform

             *> What shall we do with the menu option?
             evaluate menu-option
                when 'a'
                when 'A'
                        call "consultsum" using ws-store-info
                        cancel "consultsum"
                when 's'
                when 'S'
                        perform clr-screen
                        call "scheduleapp" using ws-store-info
                        cancel "scheduleapp"
                        perform clr-screen
                when 'r'
                when 'R'
                        perform review-menu
                when 'm'
                when 'M'
                        perform maint-menu
                when 'q'
                when 'Q'
                        move "0" to menu-option
             end-evaluate

             *> Ensure all the popup's are in the correct state
             cancel "consultpopup"
             cancel "storepopup"
             cancel "custpopup"

            end-perform

           perform clr-screen
      $if use-sql defined
           exec sql disconnect DEFAULT end-exec
           display sqlcode
           display sqlerrmc
      $end
           display "Thank you."
           stop run.

        setup-section.
            perform clr-screen

            move spaces to cmd-line store-name
            accept cmd-line from command-line
            display cmd-line
            move "n" to ls-eof

            if cmd-line not equal spaces
                call "getonestore" using
                    by reference cmd-line
                    by reference ws-store-info
                end-call

                if return-code > 1
                    display "Sorry store name is not unique"
                    stop run
                end-if

                if return-code less than or equal 0
                    display "Store not found (" return-code ")"
                    stop run
                end-if

                move ws-name-of-store to store-name
            end-if

            *> do we have a default store?
            perform get-storeconf
            if conf-current-id equal 0
                move 0 to ls-gcd-flags
                move length of ls-gcd-dir-name to ls-gcd-len
                call "CBL_GET_CURRENT_DIR" using
                   by value ls-gcd-flags
                   by value ls-gcd-len
                   by reference ls-gcd-dir-name
                end-call

                perform show-no-config-popup

                perform clr-screen
                display g-menuheader
                move 0 to ws-id
                call "storemaintenance" using ws-store-info
                stop run
            end-if

            if cmd-line equal spaces
                *> get the default store
                call "getdefstore" using ws-store-info
                if return-code not equal 0
                   move spaces to store-name
                else
                   move ws-name-of-store to store-name
                end-if
            end-if

            if store-name equal spaces
                perform show-no-config-popup
                perform maint-menu
                stop run
            end-if
            .

        show-no-config-popup.
               move "Configuration error" to popup-title
                move "No default store configured" to popup-message-1
                move spaces to popup-message-2
                move "OK" to popup-button-1

                perform clr-screen
                call "errpopup" using popup-title,
                        popup-message-1,
                        popup-message-2
                        popup-button-1
                end-call
            .


        maint-menu.
            perform clr-screen
            move "General Maintenance Menu" TO Menu-Name
            display g-menuheader

            move "maint-menu" to f1-name-buf
            display g-maintscreen
            accept g-maintscreen

            evaluate menu-option
                when 'c'
                when 'C'
                 perform clr-screen
                 move 'MFOCAL' to ws-text
                 call "custmenu" using ws-store-info ws-dataflow-demo
                 cancel "custmenu"
                 perform clr-screen

                 *> reload record app config
                 perform setup-section

                when 't'
                when 'T'
                 perform clr-screen
                 call "constmenu" using ws-store-info
                 cancel "constmenu"
                 perform clr-screen

                when 'm'
                when 'M'
                 call "storemaintenance" using ws-store-info
                 cancel "storemaintenance"
                 perform clr-screen

                 *> reload record app config
                 perform setup-section
                when 'w'
                when 'W'
                 call "ABC4400"
                 cancel "ABC4400"
                 perform clr-screen

                 *> reload record app config
                 perform setup-section
                when other
                   perform help-required
            end-evaluate
        .

        review-menu.
            perform clr-screen
            move "Review Appointments Menu" TO Menu-Name
            move "RA001" to Menu-Id
            move "review-menu" to f1-name-buf
            display g-menuheader
            display g-reviewmenu
            accept g-reviewmenu

            evaluate ra-menu-option
                when 'A'
                when 'a'
                when 'C'
                when 'c'
                when 'g'
                when 'G'
                when 'p'
                when 'P'
                   call "schedread" using
                       by reference ws-store-info
                       by reference ra-menu-option
                   end-call
                   cancel "schedread"
                when other
                   perform help-required
            end-evaluate
            perform clr-screen
        .


        help-required.
              *> move key-code-1 to key-code-1-display
              if key-type equals adis-term-prog
                evaluate key-code-1
                   when kc-escape
                      goback returning -1

                   when kc-f1-key
                      perform save-f1-screen
                      call "mfocalhelp" using
                         by reference f1-name-buf
                       end-call
                      perform restore-f1-screen
                end-evaluate
              end-if
              .

        copy "common.cpy".
        copy "storeconf_common.cpy".
