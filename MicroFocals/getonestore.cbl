       program-id. getonestore.

       environment division.
       input-output section.
       file-control.
       copy "stores-fc.cpy".
       copy "storeconf-fc.cpy".

       copy "stores-fd.cpy".
       copy "storeconf-fd.cpy".

       working-storage section.
       01 sp-len           binary-long.
       01 prev-storename   pic x(40).
       01 counter          binary-long value 0.


       copy "common_ws.cpy".

       linkage section.
       01 cmd-line         pic x(40).
       01 sf1-Store-Information.
       COPY "stores.cpy"   replacing ==:Prefix-:== by ==sf1-==.
       screen section.
       copy "common_ss.cpy".
       procedure division using cmd-line, sf1-Store-Information.

           move 0 to sp-len
           inspect function reverse(cmd-line)
               tallying sp-len for leading spaces
           compute sp-len = length of cmd-line - sp-len
           if sp-len equal 0
                goback returning GETONESTORE-NO-STORE
           end-if

           perform init-env

           if cmd-line not equal spaces
               move 1 to sf-id
               open input store-file
               perform check-file-status

               move cmd-line to sf-name-of-store
               start store-file
                 key >= sf-name-of-store
                   invalid key
                     goback returning GETONESTORE-INVALID-ID
               end-start
            else
               move 1 to sf-id
               open input store-file
               perform check-file-status

               start store-file
                 key >= sf-Id
                   invalid key
                     goback returning GETONESTORE-INVALID-ID
               end-start
            end-if

           read store-file next record
           perform check-file-status

           move sf-Store-Information to sf1-Store-Information
           move sf-name-of-store to prev-storename
           perform with test after
                until sf-name-of-store(1:sp-len)
                 not equal cmd-line(1:sp-len)
              add 1 to counter
              move sf-name-of-store to prev-storename
              read store-file next record
           end-perform

           close store-file
           perform check-file-status
           goback returning counter
           .

           copy "common.cpy".


       end program getonestore.

