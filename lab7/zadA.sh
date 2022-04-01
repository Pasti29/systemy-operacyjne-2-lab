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
# Zadanie 10.
# Proszę opracować uproszczony konwerter plików z formatu JSON do formatu XML
# i przetworzyć nim plik `dodatkowe/simple.json`. Zakładamy, że wejście stanowi
# zawsze pojedyncza linia, klucze i wartości to proste łańcuchy znaków, złożone
# z liter lub cyfr, pomiędzy cudzysłowami, które są rozdzielone jednym znakiem
# dwukropka i co najmniej jedną spacją, a całe pary klucz-wartość są oddzielone
# od siebie jednym przecinkiem i co najmniej jedną spacją.
#
# Przykład przetworzenia: {"klucz": "wartość"} -> <klucz>wartość</klucz>.
#
# Proszę obsłużyć tworzenie samodomykającego się znacznika (<klucz />), kiedy
# wartość stanowi pusty łańcuch "", a także proszę obsłużyć zagnieżdżenie
# kolejnego zbioru kluczy i wartości.
#


awk '
    {
        for (i = 1; i <= NF; i++) {
            start = match($i, /"[^"]*klucz[^"]*":/);
            end = match($i, /":/);
            if (end - start > 0) {
                key = substr($i, start, end);
                newKey = substr(key, 2, end - start - 1);
                beginKey = "<" newKey ">";
                sub(key, beginKey, $i);
                endKey = " </" newKey "> ";
                if ($(i + 1) ~ /^{/) {
                    endKey = "}</" newKey ">";
                    sub(/},/, endKey, $0);
                }
                else if ($(i + 1) ~ /}/) {
                    sub(/}/, endKey, $0);
                }
                else {
                    sub(/,/, endKey, $0);
                }
                
            }

            if ($i ~ /"[^"]*"/) {
                value = substr($i, 2, length($i) - 2);
                sub($i, value, $i);
            }
        }
        print $0;
    }
' dodatkowe/simple.json | tr -d '{: ' | awk '
    {
        while (match($0, /<[^\/<>]*><\/[^<>]*>/, tablica) != 0) {
            i++;
            end = match(tablica[i - 1], /><\//);
            key = substr(tablica[i - 1], 2, end - 2);
            key = "<" key " />";
            sub(tablica[i - 1], key, $0)
        }
        print $0;
    }
'
