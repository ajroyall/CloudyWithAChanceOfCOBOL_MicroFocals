        copy "common_78.cpy".
        03 :Prefix-:id                 pic 9(5).
        03 :Prefix-:name-of-store      pic x(40).
        03 :Prefix-:province           pic x(40).
        03 :Prefix-:county             pic x(40).
        03 :Prefix-:postcode           pic x(20).
        03 :Prefix-:email              pic x(60).
       	03 :Prefix-:location.
          05 :Prefix-:latitude           comp-2.
          05 :Prefix-:longitude          comp-2.
        03 :Prefix-:tel               pic x(20).
        03 :Prefix-:geohash           pic x(12).
        03 :Prefix-:consultants-id-grp.
         05 :Prefix-:consultants-id      pic 9(5)
                 occurs MAX-CONSULTANTS-PER-STORE.
                      
