       program-id. getonestore_test.
       environment division.
       input-output section.
       file-control.
       copy "stores-fc.cpy".
       copy "storeconf-fc.cpy".

       copy "stores-fd.cpy".
       copy "storeconf-fd.cpy".

       working-storage section.
       01 ws-Store-Information.
       COPY "stores.cpy" replacing ==:Prefix-:== by ==ws-==.

       01 cmd-line      pic x(132).

       copy "common_ws.cpy".
       procedure division.
           perform get-storeconf

           accept cmd-line from command-line
           call "getonestore" using
                    by reference cmd-line
                    by reference ws-Store-Information
           end-call
           if return-code not equal 1
                display "FAIL - Not found"
                display return-code " - found"
                stop run
           end-if

           perform display-one-record
           move ws-id to conf-current-id
           perform save-storeconf

           goback.

        display-one-record.
           display "Id : " ws-id
           display "Name of store : " ws-name-of-store
           display "Province      : " ws-province
           display "County        : " ws-county
           display "Post code     : " ws-postcode
           display "Email         : " ws-email
           display "latitude      : " ws-latitude
           display "longitude     : " ws-longitude
           display "Tel           : " ws-tel
           display "GeoHash       : " ws-geohash
           display " "
           .

       copy "storeconf_common.cpy".

       end program getonestore_test.
