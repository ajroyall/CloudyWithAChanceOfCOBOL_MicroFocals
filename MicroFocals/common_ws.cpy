       copy "cbltypes".
       copy "common_78.cpy".

       copy "common_ex.cpy".

       01 Store-name 	pic x(15) value "?".
       01 Menu-Name 	pic x(25) value "Stores Maintenance".
       01 Menu-Id 	    pic x(9)  value "SM0001".
      $if console-mode defined
       01 Menu-Option PIC X.
      $end

       01 User-Key-Control.
         03 User-Key-Setting   PIC 9(2) COMP-X.
         03                    PIC X           VALUE "1".
         03 First-User-Key     PIC 9(2) COMP-X.
         03 Number-Of-Keys     PIC 9(2) COMP-X.

       01 key-status.
         05 key-type                pic x.
         05 key-code-1              pic 9(2) comp-x.
         05 key-code-1x             pic x redefines key-code-1.
         05 filler                  pic x.

      $if console-mode defined
       01 key-code-1-display        pic z9.
       01 get-single-char-func      pic 9(2) comp-x value 26.
       01 screen-buffer             pic x(2000).
       01 screen-attrs              pic x(2000).
       01 screen-string-length      pic 9(4) comp-x value 2000.
       01 reverse-vid               pic x(15) value all x"70".
      $end

       01 load-pointer              procedure-pointer.

       01 screen-origin             cblt-screen-position.

       01 cursor-off-screen.
         05 row-number            pic 99 comp-x  value 255.
         05 col-number            pic 99 comp-x  value 255.



       01 scr-flags                 pic x(4) comp-5.
       01 scr-top-line              pic x(4) comp-5.
       01 scr-bot-line              pic x(4) comp-5.
      $if ilgen set
       $if p64 set
       01 scr-handle                pic x(4) comp-5.
       01 scr-f1-handle             pic x(4) comp-5.
       01 scr-tmp-handle            pic x(4) comp-5.
       $else
       01 scr-handle                pic x(4) comp-5.
       01 scr-f1-handle             pic x(4) comp-5.
       01 scr-tmp-handle            pic x(4) comp-5.
       $end

      $else
       01 scr-handle                pointer.
       01 scr-f1-handle             pointer.
       01 scr-tmp-handle            pointer.
      $end

       01 day-of-week-names.
       	03 day-of-week-name pic xxx occurs 7
       	  values "Sun" "Mon" "Tue" "Wed" "Thu" "Fri" "Sat".
       	03 day-of-week-fullname pic x(10) occurs 9
       	  values "Sunday" "Monday" "Tuesday" "Wednesday" "Thursday"
       	   	 "Friday" "Saturday".
       	03 bt-label pic x(APP-TIME-SLOT-LEN) occurs MAX-APPS-PER-DAY
            values
            "09:00-09:30",
            "09:30-10:00",
            "10:00-10:30",
            "10:30-11:00",
            "11:00-11:30",
            "11:30-12:00",
            "12:00-12:30",
            "12:30-13:00",
            "13:00-13:30",
            "13:30-14:00",
            "14:00-14:30",
            "14:30-15:00",
            "15:00-15:30",
            "15:30-16:00",
            "16:00-16:30",
            "16:30-17:00",
            "17:00-17:30",
            "17:30-18:00".

       01 available-msg    pic x(10) value "Available".
       01 booked-msg       pic x(10) value "Booked".
       01 reserved-msg     pic x(10) value "Reserved".


       01 popup-title               PIC X(76).
       01 popup-message-1           PIC X(76).
       01 popup-message-2           PIC X(76).
       01 popup-message-3           PIC X(76).
       01 popup-button-1            PIC X(7).

       01 scr-char                  pic x comp-x.
       01 scr-attribute             pic x comp-x.
       01 scr-parameter             pic x comp-x.
       01 scr-af-function-code      pic x comp-x.
       01 scr-af-key-status.
        03 scr-af-key-type            pic x.
        03 scr-af-key-code-1          pic x comp-x.
        03 scr-af-key-code-1x         pic x redefines scr-af-key-code-1.
        03 scr-af-key-code-2          pic x comp-x.
        03 scr-af-key-code-2x         pic x redefines scr-af-key-code-2.

       01 set-bit-pairs             pic 9(2) comp-x value 1.

       01 popup-l-message           pic x(70).
       01 popup-l-button            pic x(40).

       01 ws-file-status.
        88 fs-okay                    value "00".
        88 fs-key-already-exists      value "22".
        88 fs-no-record               value "23".
        88 fs-no-next-logical-record  value "10".
        05 status-key-1               pic x.
        05 status-key-2               pic x.
         05 binary-status redefines status-key-2  pic 99 comp-x.
       01 binary-status-display pic 999.
       01 fs-current-file           pic x(80).
       01 ws-unknown-status.
        03 filler                   pic x(16)
                              value "Runtime Error : ".
        03 status-key-2a            pic 999.

       01 ws-mfocaldir              pic x(255).

       01 f1-func         pic x(4) comp-5.
       01 f1-param-block.
          05 f1-sz           pic x(4) comp-5.
          05 f1-flags        pic x(4) comp-5.
          05 f1-handle       pointer.
          05 f1-prog-id      pointer.
          05 f1-attributes   pic x(4) comp-5.
       01 f1-name-buf     pic x(30).
       01 f1-name-len     pic x(4) comp-5.
       01 f1-status-code  pic x(2) comp-5.