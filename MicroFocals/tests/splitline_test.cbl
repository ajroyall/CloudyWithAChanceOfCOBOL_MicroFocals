      $set nsymbol"national"
       program-id. splitline_test.

       environment division.
       configuration section.

       data division.
       working-storage section.
       01 csv-line      pic n(256) national.
       01 csv-line-len       binary-long.

       01 csv-locs     occurs 256 times.
           03 csv-start    binary-long.
           03 csv-len      binary-long.

       01 param-count   binary-long.
       01 csv-counter   binary-long.
       procedure division.
           move n'GB,BT33,Newcastle,Northern Ireland,' &
                n'NIR,,,,,54.218,-5.8898,4'
                      to csv-line

            display csv-line
            move 256 to csv-line-len
            perform do-it


            move n"FR,24110,Saint-Léon-sur-l'Isle,Aquitaine," &
                n"97,Dordogne,24,Arrondissement de Périgueux," &
                n"243,45.1149,0.5044,5"
                      to csv-line
            display csv-line
            move 256 to csv-line-len
            perform do-it

            move n"FR,64470,Alþay-AlþabÚhÚty-Sunharette," &
                n"Aquitaine," &
                n"97,PyrÚnÚes-Atlantiques,64,Arrondissement " &
                n"d'Oloron-Sainte-Marie,642,43.0947,-" &
                n"0.9095,5" to csv-line

            display csv-line
            move 256 to csv-line-len
            perform do-it

            goback.

        do-it.
            call "splitline" using
                    by reference csv-line
                    by value csv-line-len
                    by reference csv-locs(1)
                    returning param-count
           end-call

           perform varying csv-counter from 1 by 1
                        until csv-counter = param-count


                display csv-counter "=> " csv-start(csv-counter) " : "
                              csv-len(csv-counter) " ["
                csv-line(
                            csv-start(csv-counter):csv-len(csv-counter))
                "]"
           end-perform
           .

       end program splitline_test.