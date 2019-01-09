       IDENTIFICATION DIVISION.
       environment division.
       special-names.
         crt status is key-status.
       data division.
       working-storage section.
       COPY "common_ws.cpy".
       01 customer-menu-option 	pic x.
       linkage section.
       copy "common_lnk.cpy".
       screen section.
       copy "custmenu.ss".

       copy "common_ss.cpy".
       procedure division using lnk-store-info dataflow-info.
           move lnk-name-of-store to Store-Name
           move "Customer Maintenance" to Menu-Name
           move "CM_M01" to Menu-Id
           
           string lnk-text '-' Menu-Id delimited by spaces
                  into lnk-text
           end-string.
           
           multiply 2 by row-number giving lnk-num.
               
       
           move spaces to customer-menu-option
           perform until customer-menu-option equals "q"
             perform clr-screen
             DISPLAY g-custmenu
             display g-menuheader
             accept g-custmenu
             perform f1-or-quit
             evaluate customer-menu-option
                when "r"
                when "R"
                when 'a'
                when 'A'
                when 'e'
                when 'E'
                 call "custmaint" using lnk-store-info,
                        customer-menu-option, dataflow-info
                 cancel "custmaint"
             end-evaluate
            end-perform
           goback returning CUSTMENU-OK.

       copy "common.cpy".

