       IDENTIFICATION DIVISION.
       environment division.
       file-control.
       select mfhelp-file assign to dynamic mfhelp-filename
        organization is line sequential
        status is ws-file-status.
       DATA DIVISION.
       fd mfhelp-file.
       01 mfhelp-line       pic x(76).

       WORKING-STORAGE SECTION.
       copy "common_ws.cpy".

       01 mfhelp-title PIC X(77).
       01 mfhelp-text  pic x(76) occurs 17.
       01 mfhelp-counter binary-long.

       01 func         pic x(4) comp-5.
       01 param-block.
                05 sz           pic x(4) comp-5.
                05 flags        pic x(4) comp-5.
                05 handle       pointer.
                05 prog-id      pointer.
                05 attributes   pic x(4) comp-5.
       01 name-buf     pic x(30).
       01 name-len     pic x(4) comp-5.
       01 status-code  pic x(2) comp-5.
       local-storage section.
       linkage section.
       01 lnk-activeprog      pic x(30).
       SCREEN SECTION.
       COPY "MFHELP.ss".
       copy "common_ss.cpy".
       procedure division using lnk-activeprog.
           perform clr-screen
           move spaces to mfhelp-title
           move spaces to mfhelp-filename

           perform varying mfhelp-counter from 1 by 1
              until mfhelp-counter equals 18
              move spaces to mfhelp-text(mfhelp-counter)
           end-perform
           move lnk-activeprog to name-buf

           string "$MFOCALDIR/" delimited by size
                  name-buf delimited by space
                  ".htxt" delimited by size
                  into mfhelp-filename
           end-string

           open input mfhelp-file
           if ws-file-status not equal "00"
              *> attempt two.. use MFOCALHDIR
              string "$MFOCALHDIR/" delimited by size
                     name-buf delimited by space
                     ".htxt" delimited by size
                     into mfhelp-filename
              end-string
              open input mfhelp-file
           end-if

           if ws-file-status not equal "00"
             move "Sorry no help is available" to mfhelp-title
             string
                "Missing txt file : " delimited by size
                mfhelp-filename delimited by space
                into mfhelp-text(1)
           else
              read mfhelp-file into mfhelp-title
              move 1 to mfhelp-counter
              perform until ws-file-status not equals "00"
                  read mfhelp-file into mfhelp-text(mfhelp-counter)
                  add 1 to mfhelp-counter
              end-perform
            end-if
            close mfhelp-file
            DISPLAY G-MFHELP
            perform press-any-key
            goback returning 0.
           .


           copy "common.cpy".

       *>show-help.
      *>     move 0 to func attributes
      *>     move 2 to flags
      *>     set handle to null
      *>     set prog-id to null
      *>     move length of param-block to sz
      *>     move length of name-buf to name-len
      *>     call "CBL_GET_PROGRAM_INFO" using
      *>          by value func
      *>          by reference param-block
      *>          by reference name-buf
      *>          by reference name-len
      *>          returning       status-code
      *>     end-call
      *>     call "mfocalhelp" using
      *>          by reference name-buf
      *>     end-call