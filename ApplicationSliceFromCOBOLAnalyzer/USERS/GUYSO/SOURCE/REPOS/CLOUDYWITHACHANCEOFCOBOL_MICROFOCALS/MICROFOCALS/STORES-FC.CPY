       select store-file assign to "$MFOCALDIR/stores.dat"
        organization is indexed
        access is dynamic
        record key is sf-id
        alternate key is sf-name-of-store with duplicates
        alternate key is sf-postcode with duplicates
        alternate key is sf-county with duplicates
        alternate key is sf-geohash with duplicates
        status is ws-file-status.
