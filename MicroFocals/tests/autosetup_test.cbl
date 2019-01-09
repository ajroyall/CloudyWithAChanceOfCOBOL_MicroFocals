        working-storage section.
        01 ws-MFOCALCP      pic x(40).
        01 ws-MFOCALDIR     pic x(255).

        procedure division.
        call "autosetup"

        display return-code

        display "MFOCALCP" upon environment-name
        accept ws-MFOCALCP from environment-value

        display "MFOCALDIR" upon environment-name
        accept ws-MFOCALDIR from environment-value

        exhibit named ws-MFOCALDIR
        exhibit named ws-MFOCALCP
