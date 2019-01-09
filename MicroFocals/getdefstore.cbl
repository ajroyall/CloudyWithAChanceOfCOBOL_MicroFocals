       identification division.
       environment division.
       special-names.
         crt status is key-status.
       input-output section.
       file-control.
       copy "stores-fc.cpy".
       copy "storeconf-fc.cpy".

       copy "stores-fd.cpy".
       copy "storeconf-fd.cpy".

       working-storage section.
       copy "common_78.cpy".
       copy "gettimeslot.cpy" replacing  ==:Prefix-:== by ==ap-==.
       copy "common_ws.cpy".
       linkage section.
       01 lnk-store-info.
       COPY "stores.cpy" replacing ==:Prefix-:== by ==lnk-==.

       SCREEN SECTION.
       copy "common_ss.cpy".
       procedure division using lnk-store-info.
            perform init-env
            perform get-storeconf

            if conf-current-id equal 0
              goback returning GETDEFSTORE-ID-EQUAL0
            end-if

            initialize sf-Store-Information
            move conf-current-id to sf-id
            move "store-file" to fs-current-file
            open input store-file
            perform check-file-status
            if not fs-okay
                goback returning GETDEFSTORE-BAD-OPEN
            end-if

            start store-file
             key = sf-Id
               invalid key
                 goback returning GETDEFSTORE-BAD-ID
            end-start
            perform check-file-status

            if fs-okay
                read store-file next record
                if fs-no-record
                    close store-file
                    goback returning GETDEFSTORE-NO-RECORD
                else
                    perform check-file-status
                end-if
            end-if

            close store-file
            move sf-Store-Information to lnk-store-info
            move sf-name-of-store to Store-Name
            goback returning GETDEFSTORE-OK
            .

          copy "common.cpy".
          copy "storeconf_common.cpy".