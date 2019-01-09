       copy "cblproto".
       

       program-id. autosetup.

       environment division.
       configuration section.
       repository.

       data division.
       working-storage section.
       copy "common_78.cpy".
      
      * Copy the missing copybook from the root folder to fix this error
       copy missingcopyexample.cpy.
       01 File-Details         usage cblt-fileexist-buf.

       01 status-code          usage cblt-rtncode.

       01 poss-dir-count       binary-long value 0.
       01 poss-dirs            pic x(64) occurs 5.

       01 tmp-num-d            pic 999 display.
       01 tmp-count            binary-long.
       01 tmp-lang             pic xx. *> size of 2 on purpose...

       01 file-status          pic xx comp-x.
       01 redefines file-status.
            03 fs-byte-1  pic x.
            03 fs-byte-2  cblt-x1-compx.

       01 mfocaldir-env       pic x(255).
       01 mfocalhdir-env      pic x(255).

       procedure division.
           display "MFOCALDIR" upon environment-name
           accept mfocaldir-env from environment-value
           if mfocaldir-env not equal spaces
             call "CBL_CHECK_FILE_EXIST" using
                    by reference mfocaldir-env
                    by reference File-Details
             end-call
             move return-code to file-status

             *> is it a directory? ie: 9/21
             if fs-byte-1 equals 9 and fs-byte-2 equals 21
                 goback returning AUTOSETUP-OK
             end-if
           end-if

           *> use
           perform guess-dirs

           *> fallback is uk...
           add 1 to poss-dir-count
           move "gb" to poss-dirs(poss-dir-count)

           perform varying tmp-count from 1 by 1
                   until tmp-count > poss-dir-count

                call "CBL_CHECK_FILE_EXIST" using
                    by reference poss-dirs(tmp-count)
                    by reference File-Details
                end-call
                move return-code to file-status
                *> is it a directory? ie: 9/21
                if fs-byte-1 equals 9 and fs-byte-2 equals 21
                 display "MFOCALDIR" upon environment-name
                 display poss-dirs(tmp-count) upon environment-value
                 display "MFOCALCP" upon environment-name
                 display poss-dirs(tmp-count) upon environment-value

                 display "MFOCALHDIR" upon environment-name
                 string
                     poss-dirs(tmp-count) delimited by space
                     "/../docs" delimited by size
                     into mfocalhdir-env
                 end-string
                 display mfocalhdir-env upon environment-value
                 goback returning AUTOSETUP-OK
                end-if
           end-perform
           goback returning AUTOSETUP-FAILED.

       guess-dirs.
           move 0 to poss-dir-count
           move 28 to cblte-osi-length of GetOS-block

           call CBL-GET-OS-INFO   using     GetOS-block
                                  returning status-code
           end-call

           if status-code not = 0
              goback returning AUTOSETUP-FAILED
           end-if

      *
      *        131 for Windows systems, 128 for COBOL system on UNIX
      *
           evaluate cblte-osi-os-type of GetOS-block
              when 131
                 perform use-countrycode-win
              when 128
                 move spaces to tmp-lang
                 display "LC_MESSAGES" upon environment-name
                 accept tmp-lang from environment-value
                 if tmp-lang not equal spaces
                  add 1 to poss-dir-count
                  move tmp-lang to poss-dirs(poss-dir-count)
                 end-if
              when other
                 *> display "Unknown OS!"
                 goback returning AUTOSETUP-FAILED
           end-evaluate
           .


       use-countrycode-win.
           evaluate cblte-osi-country-id of GetOS-block
                when 1
                    add 1 to poss-dir-count
                    move "us" to poss-dirs(poss-dir-count)
                when 27
                    add 1 to poss-dir-count
                    move "nz" to poss-dirs(poss-dir-count)
                when 31
                    add 1 to poss-dir-count
                    move "nl" to poss-dirs(poss-dir-count)
                when 33
                    add 1 to poss-dir-count
                    move "fr" to poss-dirs(poss-dir-count)
                when 34
                    add 1 to poss-dir-count
                    move "es" to poss-dirs(poss-dir-count)
                when 39
                    add 1 to poss-dir-count
                    move "it" to poss-dirs(poss-dir-count)
                when 43
                    add 1 to poss-dir-count
                    move "at" to poss-dirs(poss-dir-count)
                when 44
                    add 1 to poss-dir-count
                    move "gb" to poss-dirs(poss-dir-count)
                when 45
                    add 1 to poss-dir-count
                    move "dk" to poss-dirs(poss-dir-count)
                when 46
                    add 1 to poss-dir-count
                    move "se" to poss-dirs(poss-dir-count)
                when 47
                    add 1 to poss-dir-count
                    move "no" to poss-dirs(poss-dir-count)
                when 49
                    add 1 to poss-dir-count
                    move "de" to poss-dirs(poss-dir-count)
                when 52
                    add 1 to poss-dir-count
                    move "mx" to poss-dirs(poss-dir-count)
                when 55
                    add 1 to poss-dir-count
                    move "br" to poss-dirs(poss-dir-count)
                when 61
                    add 1 to poss-dir-count
                    move "au" to poss-dirs(poss-dir-count)
                when 64
                    add 1 to poss-dir-count
                    move "nz" to poss-dirs(poss-dir-count)
                when 81
                    add 1 to poss-dir-count
                    move "jp" to poss-dirs(poss-dir-count)
                when 82
                    add 1 to poss-dir-count
                    move "kp" to poss-dirs(poss-dir-count)
                when 86
                    add 1 to poss-dir-count
                    move "rc" to poss-dirs(poss-dir-count)
                when 91
                    add 1 to poss-dir-count
                    move "in" to poss-dirs(poss-dir-count)
                when 351
                    add 1 to poss-dir-count
                    move "pt" to poss-dirs(poss-dir-count)
                when 351
                    add 1 to poss-dir-count
                    move "fi" to poss-dirs(poss-dir-count)
                when 351
                    add 1 to poss-dir-count
                    move "tw" to poss-dirs(poss-dir-count)
                when other
                    display "INFO: unknown "
                       cblte-osi-country-id of GetOS-block
           end-evaluate

           *> display "INFO: "
           *>             cblte-osi-country-id of GetOS-block
           add 1 to poss-dir-count
           move cblte-osi-country-id of GetOS-block to
            tmp-num-d

           move tmp-num-d to poss-dirs(poss-dir-count)

           .


