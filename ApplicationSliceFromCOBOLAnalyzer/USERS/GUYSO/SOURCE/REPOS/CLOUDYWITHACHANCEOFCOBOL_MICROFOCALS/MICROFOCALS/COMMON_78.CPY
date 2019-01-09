      $if MAX-STORES not defined
       78 STORE-OK                 value 0.

       78 GEOHASH-OK               value 0.
       78 GEOHASH-BAD-LAT          value 1.
       78 GEOHASH-BAD-LONG         value 2.
       78 GEOHASH-BAD-LEN          value 3.

       78 CONSULTPOPUP-OK          value 0.
       78 CONSULTPOPUP-FAILED      value -1.

       78 REQAPPOINT-OK            value 0.

       78 GETSTORENEAR-INV-PARAM   value -1.
       78 GETSTORENEAR-NOT-FOUND   value -2.

       78 GETSTORE-OK              value 0.
       78 GETSTORE-NOT-FOUND       value 3.
       78 GETSTORE-CLOSE-FAILED    value 2.

       78 GETONESTORE-NO-STORE     value -1.
       78 GETONESTORE-INVALID-ID   value -2.

       78 GETDEFSTORE-OK           value 0.
       78 GETDEFSTORE-NO-RECORD    value 1.
       78 GETDEFSTORE-ID-EQUAL0    value 2.
       78 GETDEFSTORE-BAD-ID       value 3.
       78 GETDEFSTORE-BAD-OPEN     value 4.

       78 CENCUSTID-OK             value 0.

       78 ERRPOPUP-OK              value 0.

       78 DATEINFO-OK              value 0.

       78 CUSTPOPUP-OK             value 0.

       78 CUSTMENU-OK              value 0.

       78 CUSTMAINT-OK             value 0.
       78 CUSTMAINT-FAILED         value -1.

       78 CONSULTSUM-OK            value 0.
       78 CONSULTSUM-FAILED        value 0.

       78 AUTOSETUP-OK             value 0.
       78 AUTOSETUP-FAILED         value 1.

       78 CENTERTEXT-FAILED        value -1.
       78 CENTERTEXT-NO-ACTION     value 0.

       78 VALDATE-OK               value 0.
       78 VALDATE-FAILED           value 1.

       78 MAX-STORES               value 26.
       78 MAX-CONSULTANTS-PER-STORE value 16.
       78 MAX-APPS-PER-DAY         value 18.
       78 APP-TIME-SLOT-IN-MINS    value 30.
       78 APP-TIME-SLOT-LEN        value 11.

       78 APP-STATUS-ATTENDED	   value "Y".
       78 APP-STATUS-UNATTENDED	   value "N".

       78 invalid-custid           value 0.
       78 ignore-custid            value 999999999.

       $if GREEN-SCREEN defined
       78 mf-app-background-colour value 0.
       78 mf-app-foreground-colour value 2.
       78 mf-app-revbg-colour      value 10.
       $else
       78 mf-app-background-colour value 1.
       78 mf-app-foreground-colour value 7.
       78 mf-app-revbg-colour      value 9.
       $end

       78 colour-black		       value 0.
       78 colour-blue	           value 1.
       78 colour-green		       value 2.
       78 colour-cyan		       value 3.
       78 colour-red		       value 4.
       78 colour-magenta	       value 5.
       78 colour-brown		       value 6.
       78 colour-white		       value 7.
       78 colour-grey		       value 8.
       78 colour-light-blue	       value 9.
       78 colour-light-green	   value 10.
       78 colour-light-cyan	       value 11.
       78 colour-light-red         value 12.
       78 colour-light-magenta	   value 13.
       78 colour-yellow		       value 14.
       78 colour-high-white 	   value 15.

       78 mf-app-booked-colour	   value colour-red.
       78 mf-app-available-colour  value colour-green.

       78 kc-normal                value "0".
       78 kc-user-fn-key           value "1".
       78 kc-adis-fn-key           value "2".
       78 kc-8bit-key              value "3".
       78 kc-16bit-key             value "4".
       78 kc-shift-key             value "5".
       78 kc-lock-key              value "6".
       78 kc-error                 value "9".

       78 kc-escape                value 0.
       78 kc-f1-key                value 1.
       78 kc-f2-key                value 2.
       78 kc-f3-key                value 3.
       78 kc-f4-key                value 4.
       78 kc-f5-key                value 5.
       78 kc-f6-key                value 6.
       78 kc-f7-key                value 7.
       78 kc-f8-key                value 8.
       78 kc-f9-key                value 9.

       78 adis-term-accept         value 0.
       78 adis-term-prog           value 1.
       78 adis-term-cr             value 2.
       78 adis-left-key		       value 3.
       78 adis-right-key	       value 4.
       78 adis-up-key		       value 5.
       78 adis-down-key		       value 6.
       78 adis-home                value 7.
       78 adis-tab                 value 8.
       78 adis-backtab             value 9.


       78 78-Adis                  value X"AF".
      $end