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
./program 0 "Lorem ipsum" "primer_besedilo.txt"
if [ $? -ne 0 ]; then
  echo "Test 1 (KMP) ni uspel!"
  cat out.txt
  exit 1
fi

# Primerjaj izhod z pravilnim izhodom
diff out.txt primer_izhoda.txt
if [ $? -ne 0 ]; then
  echo "Test 1 (KMP) ni uspel! Izhod se ne ujema s pravilnim izhodom."
  cat out.txt
  exit 1
fi

# Test 2: Sunday algoritem
./program 1 "Lorem ipsum" "primer_besedilo.txt"
if [ $? -ne 0 ]; then
  echo "Test 2 (Sunday) ni uspel!"
  exit 1
fi

# Primerjaj izhod z pravilnim izhodom
diff out.txt primer_izhoda.txt
if [ $? -ne 0 ]; then
  echo "Test 2 (Sunday) ni uspel! Izhod se ne ujema s pravilnim izhodom."
  exit 1
fi

echo "Vsi testi so uspeli!"

# Počisti
make clean