        select cust-file assign "$MFOCALDIR/customers.dat"
        organization is indexed
        access is dynamic
        record key is f-Customer-Id of f-CustomerInformation
         alternate key is f-initials with duplicates
         alternate key is f-fullname with duplicates
         alternate key is f-lc-fullname with duplicates
         alternate key is f-home-email with duplicates
         alternate key is f-work-email with duplicates
         alternate key is f-home-tel with duplicates
         alternate key is f-work-tel with duplicates
         alternate key is f-postcode with duplicates
        status is ws-file-status.