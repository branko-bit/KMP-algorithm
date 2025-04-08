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

# Test 1: KMP algoritem
./program 0 "niz" "primer_besedilo.txt"
if [ $? -ne 0 ]; then
  echo "Test 1 (KMP) ni uspel!"
  exit 1
fi

# Test 2: Sunday algoritem
./program 1 "niz" "primer_besedilo.txt"
if [ $? -ne 0 ]; then
  echo "Test 2 (Sunday) ni uspel!"
  exit 1
fi

echo "Vsi testi so uspeli!"

# Počisti
make clean