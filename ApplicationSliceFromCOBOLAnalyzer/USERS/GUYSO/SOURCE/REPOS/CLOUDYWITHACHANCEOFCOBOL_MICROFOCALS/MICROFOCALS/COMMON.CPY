       $if verbose set
           $if console-mode defined
            $display INFO: mfocal - compiled for use as a Console
           $end

           $if rest-mode defined
             $display INFO: mfocal - compiled for use in a REST service
           $end
       $end

       screen-io section.
       clr-screen.
           display spaces upon crt with
            foreground-color mf-app-foreground-colour
            background-color mf-app-background-colour.


            *> move 32 to scr-char
            *> move h"1f" to scr-attribute
            *> call "CBL_CLEAR_SCR" using scr-char, scr-attribute

            *> move 7 to scr-af-function-code
            *> call x"a7" using scr-af-function-code
            *> 	scr-attribute

            *> move 16 to scr-af-function-code
            *> move 0 to  scr-parameter
            *> call x"a7" using scr-af-function-code, scr-parameter

       *> use ADIS to disable the 117 available keys
           MOVE 0   TO User-Key-Setting
           MOVE 0   TO First-User-Key
           MOVE 117 TO Number-Of-Keys
           CALL 78-Adis USING Set-Bit-Pairs
                              User-Key-Control

      *> use ADIS to enable Escape, F1..F10
           MOVE 1   TO User-Key-Setting
           MOVE 0   TO First-User-Key
           MOVE 11  TO Number-Of-Keys
           CALL 78-Adis USING Set-Bit-Pairs
                              User-Key-Control
         .

       save-screen.
          move 0 to scr-flags
          move 1 to scr-top-line
          move 25 to scr-bot-line
          call "CBL_SCR_SAVE" using
             by value scr-flags
             by value scr-top-line
             by value scr-bot-line
             returning scr-handle
          end-call
        .
       save-f1-screen.
          move 0 to scr-flags
          move 1 to scr-top-line
          move 25 to scr-bot-line
          call "CBL_SCR_SAVE" using
             by value scr-flags
             by value scr-top-line
             by value scr-bot-line
             returning scr-f1-handle
          end-call
        .

       restore-screen.
      *> recover the original screen *
          call "CBL_SCR_RESTORE" using
             by value scr-flags,
             by value scr-handle
          end-call
        .

       restore-f1-screen.
      *> recover the original screen *
          call "CBL_SCR_RESTORE" using
             by value scr-flags,
             by value scr-f1-handle
          end-call
        .

       move-cursor-off-screen.
          call "CBL_SET_CSR_POS" using cursor-off-screen.


       check-file-status.
          move spaces to popup-title
          move "okay" to popup-button-1

          evaluate status-key-1
             when "0"
                next sentence
             when "1"
                move "File Error - End of file reached" to popup-title
                perform check-eof-status
             when "2"
                move "File Error - Invalid key" to popup-title
                perform check-inv-key-status
             when "3"
                move "File Error - permanent error" to popup-title
                perform check-perm-err-status
             when "4"
                move "File Error - logic error" to popup-title
                perform check-logic-err-status
             when "9"
                move "File Error - run-time-system error" to popup-title
                perform check-mf-error-message
          end-evaluate.

          if popup-title not equal spaces
                if status-key-1 not equal "9"
                    string "File status "
                         status-key-1
                        "/"
                        status-key-2
                        into popup-message-2

                    end-string
                else
                    move binary-status to binary-status-display
                    string "File status "
                         status-key-1
                        "/"
                        binary-status-display
                        into popup-message-2

                end-if

                *> has the filename been given?
                if fs-current-file not equal spaces
                    string
                        "Current file being used : " delimited by size
                         fs-current-file delimited by space
                            into popup-message-3
                end-if

                call "ferrpopup" using popup-title,
                        popup-message-1,
                        popup-message-2
                        popup-message-3
                        popup-button-1
                    on exception
                        *> if errpopup .int/.gnt is used.. we need this..
                        set load-pointer to entry "errpopup"
                        call "ferrpopup" using popup-title,
                             popup-message-1,
                             popup-message-2
                             popup-message-3
                             popup-button-1
                        end-call
                end-call
                move spaces to fs-current-file
          end-if
          .

       check-logic-err-status.
          evaluate status-key-2
             when "1"
               move "File already open" to popup-message-1
             when "2"
               move "File not open during close" to popup-message-1
             when "3"
               move "Last statement should have been a READ"
                        to popup-message-1
             when "4"
               move "Boundary violiation " to popup-message-1
             when "6"
               move "Seq read before valid start" to popup-message-1
             when "7"
               move "A READ/Start before open file" to popup-message-1
             when "8"
               move "A Write before open file" to popup-message-1
          end-evaluate.

       check-eof-status.
          if status-key-2 = "0"
                 move "no next logical record" to popup-message-1
          end-if
          .

       check-inv-key-status.
          evaluate status-key-2
             when "2"
                move "attempt to write dup key" to popup-message-1
             when "3"
               move "no record found" to popup-message-1
          end-evaluate
        .

       check-perm-err-status.
          if status-key-2 = "5"
                move "file not found" to popup-message-1
          end-if
        .

        check-mf-error-message.
          evaluate binary-status
             when 002 move "file not open" to popup-message-1
             when 004 move "read or write on index failed.. check key"
                             to popup-message-1
             when 005 move
                      "referenced optional file is not present on open"
                             to popup-message-1
             when 007 move "disk space exhausted" to popup-message-1
             when 010 move "no next logical record exists, eof reached"
                             to popup-message-1
             when 013 move "file not found" to popup-message-1
             when 021 move "sequence error on sequential access file"
                             to popup-message-1
             when 023 move "no record found"
                             to popup-message-1
             when 024 move "disk error/boundary violation"
                            to popup-message-1
             when 030 move
                      "boundary violation on relative or index file"
                             to popup-message-1
             when 034 move
                 "i/o fail due to boundary violation on sequential file"
                             to popup-message-1

             when 035 move
     - "an OPEN operation with due to missing non-OPTIONAL file."
     - to popup-message-1
             when 037 move "bad open mode" to popup-message-1

             when 038 move
     - "open failed due to file being closed with lock"
     - to popup-message-1

             when 039 move
     - "conflict between fixed file attributes and program"
     - to popup-message-1
             when 041 move "open failed because file is already open"
                            to popup-message-1
             when 042 move
                      "close failed because file is already closed"
                            to popup-message-1
             when 043 move
     - "file in access mode when delete or rewrite requested"
     - to popup-message-1
             when 044 move "file boundary violation" to popup-message-1
             when 046 move
     - "read file failed due to no valid next record"
                            to popup-message-1
             when 047 move "read or start operation tried before open"
                            to popup-message-1
             when 048 move
     - "write operation on file not opened for write"
                            to popup-message-1
             when 049 move
     - "a delete or rewrite tried on file not opened for i-o"
                            to popup-message-1
             when 065 move "file locked      " to popup-message-1
             when 068 move "record locked    " to popup-message-1
             when 039 move "record inconsistent" to popup-message-1
             when 146 move "no current record  " to popup-message-1
             when 180 move "file malformed     " to popup-message-1
             when 208 move "network error      " to popup-message-1
             when 213 move "too many locks     " to popup-message-1
             when other
                move status-key-2 to status-key-2a
                move ws-unknown-status to popup-message-1
          end-evaluate.

        display-lower-popup.
          set scr-tmp-handle to scr-handle
          perform save-screen

          call "centertext" using
                        by reference popup-l-message
                        by value length of popup-l-message
          end-call

          call "centertext" using
                         by reference popup-l-button
                         by value length of popup-l-button
          end-call

      $if console-mode defined
          display g-lowerpopup
          perform press-any-key
          perform restore-screen
          set scr-handle to scr-tmp-handle
      $end
        .

        press-any-key.
          move 26 to scr-af-function-code
          call x"af" using scr-af-function-code, scr-af-key-status
          .

      $if console-mode defined
        f1-or-quit.
              *> move key-code-1 to key-code-1-display
              if key-type equals adis-term-prog
                evaluate key-code-1
                   when kc-escape
                      goback returning -1
                   when kc-f1-key
                      perform show-f1-help
                end-evaluate
              end-if
            .

        show-f1-help.
           perform save-f1-screen
           move spaces to f1-name-buf
           move 0 to f1-func f1-attributes
           move 2 to f1-flags
           set f1-handle to null
           set f1-prog-id to null
           move length of f1-param-block to f1-sz
           move length of f1-name-buf to f1-name-len
           call "CBL_GET_PROGRAM_INFO" using
                by value f1-func
                by reference f1-param-block
                by reference f1-name-buf
                by reference f1-name-len
                returning f1-status-code
           end-call
           call "mfocalhelp" using
                by reference f1-name-buf
           end-call
           perform restore-f1-screen
           .
      $end

      $if rest-mode defined
        f1-or-quit.
           if not service-flags-valid
           *> do nothing...
               continue
           end-if
           .
      $end

        init-env.
      $if console-mode defined
           if not service-flags-valid
            call "setadismode"
           end-if
      $end

            display "MFOCALDIR" upon environment-name
            accept ws-mfocaldir from environment-value
            if ws-mfocaldir equals spaces
              call "autosetup"
              if return-code not equal 0
                display "info: unable to setup env automatically"
                display "MFOCALDIR not set or is invalid"
                stop run
              end-if
            end-if

            *> call to autosetup will set this
            accept ws-mfocaldir from environment-value
            if ws-mfocaldir equals spaces
              display "MFOCALDIR not set"
              stop run
            end-if
            .