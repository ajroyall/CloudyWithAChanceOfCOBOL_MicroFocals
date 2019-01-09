       copy "common_78.cpy".
       *> 01 :Prefix-:Consultant.
       03 :Prefix-:Consultant-Id  pic 9(9).
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
       03 :Prefix-:FullName       pic x(60).
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
