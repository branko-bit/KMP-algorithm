all: build

build: main.cpp
	g++ -Wall -std=c++11 -o program main.cpp
clean:
	rm -f program out.txt napaka.txt