       fd appointment-file.
       copy "common_78.cpy".
       01 appointment.
         03 appointment-key.
           05 app-store-id      pic 9(5).
           05 app-year          pic 9999.
           05 app-week          pic 99.
           05 app-consultant-id pic 9(9).
         03 app-consultant-name pic x(60).
         03 app-week-of-appointments.
           05 app-days        occurs 7.
            07 app-cust-id      pic 9(9) occurs MAX-APPS-PER-DAY.
            07 app-attended     pic x occurs MAX-APPS-PER-DAY.

