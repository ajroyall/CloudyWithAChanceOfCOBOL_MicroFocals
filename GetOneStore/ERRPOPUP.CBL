       identification division.
       data division.
       working-storage section.
      $if rest-mode defined
      $if ilgen set 
       01 msg           string.
       01 ex            type System.Exception.
      $end  
      $end

       01 type-of-error  pic x.
       88 is-file-error     value "f" , "F".
       88 is-general-error  value "g" , "G".

       copy "common_ws.cpy".
       linkage section.
       01 lnk-popup-title      PIC X(76).
       01 lnk-popup-message-1  PIC X(76).
       01 lnk-popup-message-2  PIC X(76).
       01 lnk-popup-message-3  PIC X(76).
       01 lnk-popup-button-1   PIC X(7).
      $if console-mode defined
       SCREEN SECTION.
       copy "common_ss.cpy".
       COPY "ERRPOPUP.ss".
      $end
       PROCEDURE DIVISION using
                 lnk-popup-title
                 lnk-popup-message-1
                 lnk-popup-message-2
                 lnk-popup-button-1.

           move "g" to type-of-error
           move spaces to popup-message-3
           perform action-error-popup
           goback returning ERRPOPUP-OK.

        entry "ferrpopup" using
                 lnk-popup-title
                 lnk-popup-message-1
                 lnk-popup-message-2
                 lnk-popup-message-3
                 lnk-popup-button-1.

           move "f" to type-of-error
           move lnk-popup-message-3 to popup-message-3
           perform action-error-popup
           goback returning ERRPOPUP-OK.

       action-error-popup section.

      $if rest-mode defined
      $if ilgen set
           set msg to  lnk-popup-message-1
           if is-file-error
               set ex to type System.IO.IOException::New(msg)
           else
               set ex to type System.Exception::New(msg)
           end-if
           raise ex.
      $else
           display lnk-popup-title upon syserr
           display popup-message-1 upon syserr
           display popup-message-2 upon syserr
           stop run returning 1.
      $end

      $if console-mode defined
           perform save-screen
           move lnk-popup-title to popup-title
           move lnk-popup-message-1 to popup-message-1
           move lnk-popup-message-2 to popup-message-2
           move lnk-popup-button-1 to popup-button-1
      $if anim set
           move "(d for debug)" to popup-message-3(64:)
      $end      
           DISPLAY popup.
           perform press-any-key
      $if anim set
           if scr-af-key-code-1x equals "d"
                call "CBL_DEBUGBREAK"
           end-if
      $end    
           perform restore-screen
           goback.

      $end


        copy "common.cpy".


