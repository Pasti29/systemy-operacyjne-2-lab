#!/usr/bin/env bash
#
# Systemy operacyjne 2 – laboratorium nr 5
#
# Celem zajęć jest nabranie doświadczenia w pracy z mechanizmem łącz
# nienazwanych, wykorzystując przy tym szereg podstawowych narzędzi
# do przetwarzania danych tekstowych.
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
# Zadanie 8.
# W ilu plikach źródłowych pakietu coreutils występuje linia, której jedyną
# zawartością jest `#include <stdio.h>` (i nic poza tym w ramach tej linii).
# Jako wynik proszę zwrócić tylko i wyłącznie liczbę odpowiednich plików.
# Źródła znajdują się w katalogu `coreutils-8.32`.
#


# find coreutils-8.32/ -type f \( -name '*.c' -or -name '*.h' \) -exec grep -o '#include <stdio.h>' {} \; | wc -l
# fileCount=0

# while IFS= read -r file; do
#     countLines=$(grep -o '#include <stdio.h>' "$file" | wc -l)
#     if [ "$countLines" -gt 0 ]; then
#         fileCount=$((fileCount+1))
#         echo "$fileCount : $countLines + $file"
#     fi
#     # fileCount=$((fileCount+countLines))
# done <<<"$(find coreutils-8.32/ -type f )"
# echo "$fileCount"

grep -r -x '#include <stdio.h>' coreutils-8.32/* | sort | uniq | wc -l 