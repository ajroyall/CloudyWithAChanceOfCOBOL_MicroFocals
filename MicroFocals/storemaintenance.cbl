       identification division.
       program-id. storemaintenance is initial.
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
       01 Action        pic x.
         88 Action-New         value "a", "A".
         88 Action-Edit        value "e", "E".
         88 Action-Delete      value "d", "D".
         88 Action-ChangeStore value "c", "C".
         88 Action-Quit        value "q", "Q".

        copy "common_ws.cpy".

       *> Screen related fields
       01 store-record-number.
           03                  value "1-".
           03 max-records      pic 99 value 99.


       01 which-store-message       pic x(36).
       01 store-record-edit-message pic x(60).
       01 size-of-hash              binary-long.

       local-storage section.
       linkage section.
       copy "common_lnk.cpy".
       SCREEN SECTION.
       copy "STOREACTION.ss".
       copy "STOREDETAILS.ss".

       copy "common_ss.cpy".

       procedure division using lnk-store-info.
           move lnk-name-of-store to Store-Name
           if lnk-id equal 0
            perform change-store
            goback
           end-if

           perform until Action-Quit
               perform clr-screen
               display g-menuheader
               display g-storeaction
               accept  g-storeaction
               perform f1-or-quit

               if Action-Delete
                perform delete-store
               else if Action-Edit
                perform edit-store
               else if Action-New
                perform new-store
               else if Action-ChangeStore
                perform change-store
               end-if
            end-perform
            goback
            .

        delete-store.
            move "Operation -> Delete" to which-store-message
            call "storepopup" using sf-Store-Information
            if return-code equal 0
             move "Operation -> Delete"
                        to store-record-edit-message
            display g-storedetails
            move "Delete Store?" to popup-l-message
            move "[Y]es or [N]o" to popup-l-button

            perform display-lower-popup
            if scr-af-key-code-1x equals "y"
             or scr-af-key-code-1x equals "Y"
               perform delete-record
            end-if
        .

        edit-store.
            move "Operation -> Edit" to which-store-message
            call "storepopup" using sf-Store-Information
            if return-code equal 0
              move "Operation -> Edit" to
                     store-record-edit-message
               move spaces to popup-title
               display g-storedetails
               accept g-storedetails
            perform until popup-title equal spaces
                 accept g-storedetails
                 display g-storedetails
            end-perform
            move "Save Changes?" to popup-l-message
            move "[Y]es or [N]o" to popup-l-button

            perform display-lower-popup
            if scr-af-key-code-1x equals "y"
              or scr-af-key-code-1x equals "Y"
                perform save-record
            end-if
           .

        new-store.
            initialize sf-Store-Information
            perform generate-store-id
            move "Operation -> New" to store-record-edit-message
            display g-storedetails
            accept g-storedetails
            perform save-record
            .

        change-store.
            move "Operation -> Change Store" to
                    which-store-message
            call "storepopup" using sf-Store-Information
            if return-code equal 0
                move "Operation -> Change Store" to
                    store-record-edit-message
                display g-storedetails
                move "Changes store?" to popup-l-message
                move "[Y]es or [N]o" to popup-l-button

                perform display-lower-popup
                if scr-af-key-code-1x equals "y"
                    or scr-af-key-code-1x equals "Y"
                    perform get-storeconf
                    move sf-id to conf-current-id
                    perform save-storeconf
                end-if
            end-if
           .

        generate-store-id.
          perform get-storeconf
          perform increment-store-id
          move conf-max-id to sf-id
            .

        delete-record.
            open i-o store-file with lock
            perform check-file-status
            delete store-file
            perform check-file-status
            close store-file
            .

        save-record.
            move length of sf-geohash to size-of-hash
            call "geohashenc" using
                by reference sf-latitude
                by reference sf-longitude
                by reference size-of-hash
                by reference sf-geohash
            end-call

            open i-o store-file with lock
            perform check-file-status

            write sf-store-information
            if fs-key-already-exists
                rewrite sf-store-information
            end-if

            perform check-file-status

            close store-file
            perform check-file-status
            .


            copy "common.cpy".
            copy "storeconf_common.cpy".
