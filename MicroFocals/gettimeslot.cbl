        01 time-ws pic 9(08) value zeroes.
        01 filler redefines time-ws.
            03 ws-hours-mins.
                 05 ws-hours    pic 99.
                 05 ws-minutes  pic 99.
            03 ws-hours-mins99 pic 9999 redefines ws-hours-mins.

            03 ws-seconds pic 99.
            03 ws-hundredths pic 99.

        copy "common_ws.cpy".


        01 sl-counter binary-long.
        01 sl-lower pic 9999 occurs MAX-APPS-PER-DAY
                value
                  0900, 0930, 1000, 1030, 1100, 1130,
                  1200, 1230, 1300, 1330, 1400, 1430,
                  1500, 1530, 1600, 1630, 1700, 1730
                  .

        01 sl-upper pic 9999 occurs MAX-APPS-PER-DAY
                value
                  0930, 1000, 1030, 1100, 1130, 1200,
                  1230, 1300, 1330, 1400, 1430, 1500,
                  1530, 1600, 1630, 1700, 1730, 1800.

        linkage section.
        copy "gettimeslot.cpy" replacing  ==:Prefix-:== by ==lnk-==.
        procedure division using lnk-current-timeslot.

            *> Get the time slot given the current time
            *>  - if value is zero then it is outside of normal
            *>    working hours
            *>
            *> Range is 0 - MAX-APPS-PER-DAY
            accept time-ws from time
            *> move 0910 to ws-hours-mins

            move 0 to lnk-time-slot
            perform varying sl-counter from 1 by 1 until
                sl-counter greater than MAX-APPS-PER-DAY

                if ws-hours-mins >= sl-lower(sl-counter)
                  and ws-hours-mins < sl-upper(sl-counter)
                    move sl-counter to lnk-time-slot
                end-if
            end-perform

            if lnk-time-slot not equal 0
             compute lnk-time-left-in-mins = APP-TIME-SLOT-IN-MINS -
                (ws-hours-mins99 - sl-lower(lnk-time-slot))

                move bt-label(lnk-time-slot) to lnk-time-slot-msg
            else
                move 0 to lnk-time-slot lnk-time-left-in-mins
                move "Out of hours" to lnk-time-slot-msg
            end-if
          goback.

