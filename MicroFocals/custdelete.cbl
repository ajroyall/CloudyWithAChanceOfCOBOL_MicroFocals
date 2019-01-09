       identification division.
       program-id. custdelete.

       environment division.
       file-control.
        copy "customer-fc.cpy".
       configuration section.

       data division.
       working-storage section.
       01 CustomerInformation.
       COPY "customerinfo.cpy" replacing ==:Prefix-:== by == ==.
       COPY "common_ws.cpy".

       procedure division using CustomerInformation.
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
           goback.
       
       end program custdelete.