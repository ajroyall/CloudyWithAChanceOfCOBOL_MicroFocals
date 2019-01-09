       01 G-STOREDETAILS.
         02 LINE 4 COL 2 VALUE "ÚÄÄStore DetailsÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
      -"ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ     ÄÄ¿".
         02 LINE 5 COL 2 VALUE "³
      -"                                     ³".
         02 LINE 6 COL 2 VALUE "³
      -"                                     ³".
         02 LINE 7 COL 2 VALUE "³
      -"                                     ³".
         02 LINE 8 COL 2 VALUE "³ Unique store id
      -"                                     ³".
         02 LINE 9 COL 2 VALUE "³
      -"                                     ³".
         02 LINE 10 COL 2 VALUE "³ Name of store
      -"                                      ³".
         02 LINE 11 COL 2 VALUE "³
      -"                                      ³".
         02 LINE 12 COL 2 VALUE "³ Latitude/Longitude
      -"   /                                  ³".
         02 LINE 13 COL 2 VALUE "³
      -"                                      ³".
         02 LINE 14 COL 2 VALUE "³ Province
      -"                                      ³".
         02 LINE 15 COL 2 VALUE "³
      -"                                      ³".
         02 LINE 16 COL 2 VALUE "³ County
      -"                                      ³".
         02 LINE 17 COL 2 VALUE "³
      -"                                      ³".
         02 LINE 18 COL 2 VALUE "³ Postal code
      -"                                      ³".
         02 LINE 19 COL 2 VALUE "³
      -"                                      ³".
         02 LINE 20 COL 2 VALUE "³ Email
      -"                                      ³".
         02 LINE 21 COL 2 VALUE "³
      -"                                      ³".
         02 LINE 22 COL 2 VALUE "³ Telephone number
      -"                                      ³".
         02 LINE 23 COL 2 VALUE "³
      -"                                      ³".
         02 LINE 24 COL 2 VALUE "³ GeoHash
      -"                                      ³".
         02 LINE 25 COL 2 VALUE "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
      -"ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ".
         02 LINE 10 COL 33 PIC X(21) USING sf-name-of-store AUTO.
         02 LINE 12 COL 33 PIC +999.9(5) USING sf-latitude AUTO.
         02 LINE 12 COL 46 PIC +999.9(5) USING sf-longitude AUTO.
         02 LINE 4 COL 72 PIC X(5) FROM store-record-number.
         02 LINE 6 COL 4 PIC X(71) FROM store-record-edit-message.
         02 LINE 8 COL 33 PIC X(6) FROM sf-id.
         02 LINE 14 COL 33 PIC X(40) USING sf-province.
         02 LINE 16 COL 33 PIC X(40) USING sf-county.
         02 LINE 18 COL 33 PIC X(20) USING sf-postcode.
         02 LINE 20 COL 18 PIC X(60) USING sf-email.
         02 LINE 22 COL 33 PIC X(20) USING sf-tel.
         02 LINE 24 COL 33 PIC X(12) FROM sf-geohash.
