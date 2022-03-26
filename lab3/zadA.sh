#!/usr/bin/env bash
#
# Systemy operacyjne 2 – laboratorium nr 3
#
# Celem zajęć jest pogłębienie wiedzy na temat struktury systemu plików,
# poruszania się po katalogach i kontroli uprawnień w skryptach powłoki.
# Proszę unikać wykorzystywania narzędzia `find` w ramach bieżących zajęć.
#
# Nie przywiązujemy wagi do środowiska roboczego – zakładamy, że jego pliki,
# inne niż te podane wprost w treści zadań, mogą ulec zmianie, a przygotowane
# rozwiązania nadal powinny działać poprawnie (robić to, o czym zadanie mówi).
#
# Wszystkie chwyty dozwolone, ale ostatecznie w wyniku ma powstać tylko to,
# o czym mowa w treści zadania – tworzone samodzielnie ewentualne tymczasowe
# pliki pomocnicze należy usunąć.
#

#
# Zadanie 10.
# Proszę określić, ile w katalogu `dane/icao/` jest unikalnych plików,
# rozumianych jako niepowtarzalne zaalokowanie zawartości na dysku twardym
# (to znaczy: kilka dowiązań twardych do tego samego pliku traktujemy jako 1).
# Jako wynik wyświetlić po prostu samą liczbę, nic więcej.
#


touch help_file

while IFS= read -r file1; do
    unique=1
    while read -r file2; do
        if [ "$file1" -ef "$file2" ]; then
            unique=0
        fi
    done < help_file
    if [ "$unique" -eq 1 ]; then
        echo "$file1" >> help_file
    fi
done < <(find dane/icao/ -type f)

count=$(wc -l < help_file)
echo "$count"
rm help_file