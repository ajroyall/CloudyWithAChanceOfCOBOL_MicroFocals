       program-id. geohashenc.

       environment division.
       configuration section.

       data division.
       working-storage section.
       copy "common_78.cpy".
       
       *> 10km x 10kx square
       01 ws-hash.
        03 ws-lat-z     pic +999.9.
        03 ws-long-z    pic +999.9.

       local-storage section.
       linkage section.
       01 lat           comp-2.
       01 long          comp-2.
       01 len           binary-long.
       01 hash          pic x(32).
       procedure division using by reference lat,
                                by reference long,
                                by reference len,
                                by reference hash.

            if len < 12
                exit program returning GEOHASH-BAD-LEN
            end-if

            move spaces to hash(1:len)
            if not (lat >= -90 and lat <= 90)
                exit program returning GEOHASH-BAD-LAT
            end-if

            if not (long >= -180 and long <= 180)
                exit program returning GEOHASH-BAD-LONG
            end-if

            move lat to ws-lat-z
            move long to ws-long-z

            string ws-lat-z ws-long-z
                   into hash(1:len)
            goback returning GEOHASH-OK.
       end program geohashenc.

