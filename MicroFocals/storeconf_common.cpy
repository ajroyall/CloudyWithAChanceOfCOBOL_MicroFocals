
        get-storeconf.
            move 0 to conf-current-id
            move 0 to conf-max-id
            open input storeconf-file
            if ws-file-status equals "35"
                open output storeconf-file

                write Conf-Store-Information
                close storeconf-file
            else
                read storeconf-file
                close storeconf-file
            end-if
            .

        increment-store-id.
            perform get-storeconf
            add 1 to conf-max-id
            open output storeconf-file
            write Conf-Store-Information
            close storeconf-file
            .

        save-storeconf.
            open output storeconf-file
            write Conf-Store-Information
            close storeconf-file
            .


