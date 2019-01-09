       copy "common_78.cpy".
       01 :Prefix-:current-timeslot.
          03 :Prefix-:time-slot         pic 99.
          03 :Prefix-:time-left-in-mins pic 99. 
          03 :Prefix-:time-slot-msg     pic x(APP-TIME-SLOT-LEN).