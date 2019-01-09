        Identification division.
        Program-id. gencustid.
        environment division.
        input-output section.
        file-control.

        select cust-id-file assign "$MFOCALDIR/custid.dat"
        organization is sequential
        status is ws-file-status.

        file section.
        fd cust-id-file.
        01 CustomerIdInformation.
         03 Highest-Customer-Id    pic 9(9).
        Working-storage section.
        copy "common_ws.cpy".

        linkage section.
        01 lnk-custid              pic 9(9).

        screen section.
        copy "common_ss.cpy".

        procedure division using by reference lnk-custid.

            open input cust-id-file
            move 0 to Highest-Customer-Id
            read cust-id-file
            close cust-id-file

            add 1 to Highest-Customer-Id

            open output cust-id-file
            write CustomerIdInformation
            perform check-file-status
            close cust-id-file

            move Highest-Customer-Id to lnk-custid
            goback returning CENCUSTID-OK
          .

          copy "common.cpy".