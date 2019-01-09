       IDENTIFICATION DIVISION.
       environment division.
       special-names.
         crt status is key-status.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       COPY "common_ws.cpy".
       01 consultant-menu-option   pic x.
       linkage section.
       copy "common_lnk.cpy".
       SCREEN SECTION.
       COPY "constmenu.ss".

       copy "common_ss.cpy".
       PROCEDURE DIVISION using lnk-store-info.
           move lnk-name-of-store to Store-Name
           move "Consultant Maintenance" to Menu-Name
           move "CT_M01" to Menu-Id

           move spaces to consultant-menu-option
           perform until consultant-menu-option equals "q"
             perform clr-screen
             display g-constmenu
             display g-menuheader
             accept g-constmenu
             perform f1-or-quit
             evaluate consultant-menu-option
                when 'a'
                when 'A'
                when 'r'
                when 'R'
                when 'e'
                when 'E'
                 call "consultantsadd" using 
                                 lnk-store-info,
                 			     consultant-menu-option
                 cancel "consultantsadd"
                 cancel "consultpopup"
             end-evaluate
            end-perform
           goback.

       copy "common.cpy".

