       program-id. geohashenc_test.

       data division.
       working-storage section.
       01 test-data.
        03 ws-test-lat   comp-2.
        03 ws-test-long  comp-2.
        03 ws-test-len   binary-long.
        03 ws-test-res   pic x(32).
       procedure division.
           move 51.401409000000000000 to ws-test-lat
           move -1.323113899999953000 to ws-test-long
           move all "*" to ws-test-res

           move length of ws-test-res to ws-test-len
           call "geohashenc" using
                by reference ws-test-lat
                by reference ws-test-long
                by reference ws-test-len
                by reference ws-test-res
            end-call

            display ws-test-res
            display return-code

           goback.
       end program geohashenc_test.
