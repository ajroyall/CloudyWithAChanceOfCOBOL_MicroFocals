       program-id. centertext.
       working-storage section.
       copy "common_78.cpy".
       01 counter              binary-long.

       01 text-length          binary-long.
       01 trailing-spaces      binary-long.

       01 spaces-before-len    binary-long.

       01 tmp-area-spaces      pic x(1024).
       01 tmp-area             pic x(1024).
       linkage section.
       01 lnk-length           binary-long.
       01 lnk-text             pic x(128).
       procedure division using
              by reference lnk-text
              by value lnk-length.

           *> avoid a corruption if the length is too big
           if lnk-length > length of tmp-area
                goback returning CENTERTEXT-FAILED
           end-if

           move 1 to counter
           perform until counter equals lnk-length
             or lnk-text(counter:1) not equals space
              add 1 to counter
           end-perform

           *> does the text include spaces?
           if counter not equal 1
              *> leave without doing anything.
              goback returning CENTERTEXT-NO-ACTION
           end-if

           *> count the number of spaces at the end of the
           *> string, so we can determine how to center it
           move lnk-length to counter
           perform until counter equals 1
             or lnk-text(counter:1) not equals space
              subtract 1 from counter
           end-perform
           compute trailing-spaces = lnk-length - counter
           move counter to text-length

           compute spaces-before-len = trailing-spaces / 2

           move spaces to tmp-area
           move spaces to tmp-area-spaces
           string
            tmp-area-spaces(1:spaces-before-len) delimited by size
            lnk-text(1:text-length) delimited by size
             into tmp-area
           end-string

           move tmp-area(1:lnk-length) to lnk-text(1:lnk-length)

           goback returning counter.

       end program centertext.
