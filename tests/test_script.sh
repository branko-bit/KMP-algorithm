#!/bin/bash

# Kompiliraj program
make

# Preveri, ali je kompilacija uspela
if [ ! -f program ]; then
  echo "Kompilacija ni uspela!"
  exit 1
fi

# Izvedi teste
echo "Izvajanje testov..."

cat primer_izhoda.txt

# Test 1: KMP algoritem
./program 0 "Lorem ipsum" primer_besedilo.txt
if [ $? -ne 0 ]; then
  echo "Test 1 (KMP) ni uspel!"
  cat out.txt
  exit 1
fi

ensure_newline_at_end out.txt
ensure_newline_at_end primer_izhoda.txt

# Primerjaj izhod z pravilnim izhodom
cmp --silent out.txt primer_izhoda.txt || {
  echo "Test 1 (KMP) ni uspel! Izhod se ne ujema s pravilnim izhodom."
  echo "Razlike:"
  diff out.txt primer_izhoda.txt
  exit 1
}

# Test 2: Sunday algoritem
./program 1 "Lorem ipsum" primer_besedilo.txt
if [ $? -ne 0 ]; then
  echo "Test 2 (Sunday) ni uspel!"
  exit 1
fi

ensure_newline_at_end out.txt
ensure_newline_at_end primer_izhoda.txt

# Primerjaj izhod z pravilnim izhodom
cmp --silent out.txt primer_izhoda.txt || {
  echo "Test 2 (Sunday) ni uspel! Izhod se ne ujema s pravilnim izhodom."
  echo "Razlike:"
  diff out.txt primer_izhoda.txt
  exit 1
}

echo "Vsi testi so uspeli!"

# Počisti
make clean