       program-id. getdefstore_test.

       environment division.
       configuration section.

       data division.
       working-storage section.
       01 ws-store-info.
       COPY "stores.cpy" replacing ==:Prefix-:== by ==ws-==.

       01 ls-counter binary-long.

       procedure division.
           call "autosetup"
           call "getdefstore" using ws-store-info
           if return-code not equal 0
               display "FAIL - getdefstore " return-code
               goback returning return-code
           end-if

           perform display-record

           goback.

       display-record.
           display "Id : " ws-id
           display "Name of store : " ws-name-of-store
           display "Post code     : " ws-postcode
           display "Email         : " ws-email
           display "County        : " ws-county
           display "latitude      : " ws-latitude
           display "longitude     : " ws-longitude
           display "Tel           : " ws-tel
           display "GeoHash       : " ws-geohash
           perform varying ls-counter from 1 by 1
               until ls-counter > MAX-CONSULTANTS-PER-STORE
                display ls-counter " => [" ws-consultants-id(ls-counter)
                            "]"
           end-perform
           display " "
           .
       end program getdefstore_test.