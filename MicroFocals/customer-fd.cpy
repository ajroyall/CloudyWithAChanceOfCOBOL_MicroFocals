        fd cust-file.
        01 f-CustomerInformation.
        copy "customerinfo.cpy" replacing ==:Prefix-:== by ==f-==.
