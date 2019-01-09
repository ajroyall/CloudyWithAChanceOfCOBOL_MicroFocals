       fd store-file.
       copy "common_78.cpy".
       01 sf-Store-Information.
       COPY "stores.cpy" replacing ==:Prefix-:== by ==sf-==.
