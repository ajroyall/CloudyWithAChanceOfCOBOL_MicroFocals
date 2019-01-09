       program-id. getonestore_test.
       environment division.
       configuration section.

       data division.
       working-storage section.
       01 ws-Store-Information.
       COPY "stores.cpy" replacing ==:Prefix-:== by ==ws-==.

       01 cmd-line      pic x(132).
       procedure division.
           move "Newcastle" to cmd-line
           call "getonestore" using
                    by reference cmd-line
                    by reference ws-Store-Information
           end-call
           if return-code equal 0
                display "FAIL - Not found"
           end-if

           perform display-one-record
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


       end program getonestore_test.