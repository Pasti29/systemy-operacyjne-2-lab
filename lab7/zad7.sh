#!/usr/bin/env bash
#
# Systemy operacyjne 2 – laboratorium nr 7
#
# Celem zajęć jest zapoznanie się z wyrażeniami regularnymi, wykorzystując
# przy tym narzędzia awk i grep oraz wszystkie inne, poznane na zajęciach.
#
# Tradycyjnie nie przywiązujemy zbyt dużej wagi do środowiska roboczego.
# Zakładamy, że format i układ danych w podanych plikach nie ulega zmianie,
# ale same wartości, inne niż podane wprost w treści zadań, mogą ulec zmianie,
# a przygotowane zadania wciąż powinny działać poprawnie (robić to, co trzeba).
#
# Wszystkie chwyty dozwolone, ale w wyniku ma powstać tylko to, o czym jest
# mowa w treści zadania – nie generujemy żadnych dodatkowych plików pośrednich.
#

#
# Zadanie 7.
# Przeanalizować zawartość pliku `dodatkowe/kant.txt` i wyodrębnić z niego
# możliwe dane kontaktowe – obecne tam adresy e-mail oraz numery telefonów.
# Numery telefonów mogą być rozdzielone pomocniczymi separatorami, dodanymi
# dla czytelności, a także być poprzedzone kodami kraju – należy je wtedy
# także wyodrębnić.
#


# awk '
#     {
#         for (i = 1; i <= NF; i++) {
#             if ($i ~ /\+?([0-9]{2})? ?([0-9]{4}[ -]?)?[0-9]{3}[ -]?[0-9]{3}[ -]?[0-9]{3}/) {
#                 printf "%s\n", $i;
#             }
#             if ($i ~ /.@./) {
#                 printf "%s\n", $i;
#             }
#         }
#     }
# ' dodatkowe/kant.txt | tr -d '(),'

grep -o -P '\+?([0-9]{2})? ?([0-9]{4}[ -]?)?[0-9]{3}[ -]?[0-9]{3}[ -]?[0-9]{3}|\S+@\S+' dodatkowe/kant.txt | tr -d '(),:' | awk '
    {
        sub(/^ /, "");
        print $0;
    }

'