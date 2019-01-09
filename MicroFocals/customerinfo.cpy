        *>01 :Prefix-:CustomerInformation.
         03 :Prefix-:Customer-Id      pic 9(9).
         03 :Prefix-:Title          pic x(8).
          88 :Prefix-:Valid-Title value
                "Mr", "Master", "Ms", "Miss", "Mrs",
                "Sir", "Madam", "Lord", "Lady",
                "Dr", "Prof",
                "Br", "Sr", "Fr", "Rev", "Pr",
                "Adv", "Mx"
          .
         03 :Prefix-:Initials       pic x(10).
         03 :Prefix-:Gender         pic x.
           88 :Prefix-:Valid-Gender value "m", "M", "f", "F".
         03 :Prefix-:Deceased       pic x.
         03 :Prefix-:FullName       pic x(60).
         03 :Prefix-:lc-FullName    pic x(60).  *> lowercase name
         03 :Prefix-:Address        pic x(70) occurs 4.
         03 :Prefix-:PostCode       pic x(9).
         03 :Prefix-:Country        pic x(40).
         03 :Prefix-:Dob.
           05 :Prefix-:Dob-dd       pic 99.
          *> 05 filler                pic x value "/".
           05 :PreFix-:Dob-mm       pic 99.
           88 :Prefix-:Valid-Dob-mm value 01 thru 12.
           *>05 filler                pic x value "/".
           05 :Prefix-:Dob-yyyy     pic 9999.
            88 :Prefix-:Valid-Dob-yyyy  VALUE 1960 THRU 2012.
         03 :Prefix-:Customer-Since.
           05 :Prefix-:cs-dd        pic 99.
          *> 05 filler                pic x value "/".
           05 :Prefix-:cs-mm        pic 99.
          *> 05 filler                pic x value "/".
           05 :Prefix-:cs-yyyy      pic 9999.
         03 :Prefix-:alert          pic x.
         03 :Prefix-:Home-Email     pic x(40).
         03 :Prefix-:Home-Tel       pic x(20).
         03 :Prefix-:Work-Email     pic x(40).
         03 :Prefix-:Work-Tel       pic x(20).
         03 :Prefix-:gp-name        pic x(60).
         03 :Prefix-:occupation     pic x(40).
         03 :Prefix-:Preferred-Store-Id  pic 9(5).
       03 :Prefix-:Diabetic-retinopathy  pic x.
         88 :Prefix-:Valid-Diabetic-retinopathy value
          "y", "Y", "n", "N".
       03 :Prefix-:Glaucoma              pic x.
         88 :Prefix-:Valid-Glaucoma value
          "y", "Y", "n", "N".
       03 :Prefix-:Cataracts             pic x.
         88 :Prefix-:Valid-Cataracts value
          "y", "Y", "n", "N".
       03 :Prefix-:Colour-blindness      pic x.
         88 :Prefix-:Valid-Colour-blindness value
          "y", "Y", "n", "N".
