      $set remove"address"
      $set remove"title"
       program-id. custread.
       environment division.
       special-names.
         crt status is key-status.
       file-control.
        select cust-file assign "$MFOCALDIR/customers.dat"
        organization is indexed
        access is dynamic
        record key is f-Customer-Id of f-CustomerInformation
         alternate key is f-initials with duplicates
         alternate key is f-fullname with duplicates
         alternate key is f-home-email with duplicates
         alternate key is f-work-email with duplicates
         alternate key is f-home-tel with duplicates
         alternate key is f-work-tel with duplicates
         alternate key is f-postcode with duplicates
        status is ws-file-status.

       data division.
       fd cust-file.
       01 f-CustomerInformation.
       copy "customerinfo.cpy" replacing ==:Prefix-:== by ==f-==.

       WORKING-STORAGE SECTION.
       01 CustomerInformation.
       COPY "customerinfo.cpy" replacing ==:Prefix-:== by == ==.
       COPY "common_ws.cpy".


       01 date-today-temp                        pic x(8).
       01 date-today redefines date-today-temp.
         03 dt-yyyy      pic xxxx.
         03 dt-mm        pic xx.
         03 dt-dd        pic xx.

        01 gender-prompt  pic x value "M".
       01 spaces10       pic x(10) value spaces.
       01 x79            pic x(79) value all "-".
       01 xline          pic x(79).
       01 eof            pic x.
       01 invalid-mess   pic x(40).
       01 GetOS-block          usage cblt-os-info-params.
       01 status-code          usage cblt-rtncode.
       01 counter        binary-long.
       linkage section.
       copy "common_lnk.cpy".
       SCREEN SECTION.
       COPY "CUSTADD.ss".
       copy "common_ss.cpy".
       PROCEDURE DIVISION.
          open i-o cust-file with lock
          perform check-file-status
          move "n" to eof
          move 1 to counter
          move 0 to f-Customer-Id
          start cust-file
            key > f-Customer-Id
             invalid key
              move "y" to eof
          end-start
          perform until eof equals "y"
            move all spaces to f-CustomerInformation
            read cust-file next record
              at end
                move "y" to eof
            end-read
            if eof equals "n"
              display f-Customer-Id
              move all spaces to xline
              string f-title delimited by "   "
                     " " delimited by size
                     f-FullName delimited by "   "
                     " ("
                      f-initials delimited by "  "
                      ")"
                into xline
              display xline
              display spaces10 "Deceased : " f-deceased
              display spaces10 "Gender   : " f-gender
              display spaces10 "Address  : " f-address(1)
              display spaces10 "         : " f-address(2)
              display spaces10 "         : " f-address(3)
              display spaces10 "         : " f-address(4)
              display spaces10 "Postcode : " f-postcode
              display spaces10 "Country  : " f-country
              display spaces10 "DOB      : " f-dob
              display spaces10 "CustSince: " f-customer-since
              display spaces10 "H-Email  : " f-home-email
              display spaces10 "H-Tel    : " f-home-tel
              display spaces10 "W-Email  : " f-work-email
              display spaces10 "W-Tel    : " f-work-tel
              display spaces10 "GP Name  : " f-gp-name
              display spaces10 "Store Id : " f-Preferred-Store-Id
              display spaces10 "Occupation: " f-occupation

              display x79
              add 1 to counter
            end-if
          end-perform
          close cust-file

          GOBACK.

       copy "common.cpy".

       end program CustRead.
