       select consultants-file assign "$MFOCALDIR/consultants.dat"
       organization is indexed
       access is dynamic
       record key is cf-Consultant-Id
        alternate key is cf-Initials with duplicates
        status is ws-file-status
        .
