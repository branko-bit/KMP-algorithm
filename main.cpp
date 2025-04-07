#include <string>
#include <sstream>
#include <fstream>
#include <iostream>
#include <vector>
using namespace std;

ofstream out;

string inputText(const string& pot) {
	ifstream input(pot);
	stringstream sstream;

	if (!input.is_open()) {
		return string();
	}

	sstream << input.rdbuf();
	return sstream.str();
}

void izpis_KMPnext(const int* polje, int len) {
	for (int i = 0; i < len; ++i) {
		out << polje[i] << ' ';
	}
	out << endl;
}

string prePostFix(int index_start, int index_end, const string& vzorec) {
	string string;
	while (index_start <= index_end) {
		string += vzorec[index_start];
		index_start++;
	}

	return string;
}

void KMP(const string& text, const string& vzorec) {
	//priprava kmpNext
	int dolzina_kmp = vzorec.length();
	int* kmpNext = new int[dolzina_kmp];

	kmpNext[0] = -1;
	kmpNext[1] = 0;
	for(int i = 2; i < dolzina_kmp; i++) {
		kmpNext[i] = 0;
	}
	int dolzina_primerjalnega_niza = 0;
	//test

    for (int i = 2; i < dolzina_kmp; i++) {
		dolzina_primerjalnega_niza = i - 1;

		while(dolzina_primerjalnega_niza >= 1){
			string prefix = prePostFix(0, dolzina_primerjalnega_niza - 1, vzorec);
			string postfix = prePostFix(i - dolzina_primerjalnega_niza, i - 1, vzorec);

			if(prefix == postfix) {
				kmpNext[i]  = kmpNext[i] + dolzina_primerjalnega_niza;
			}

			dolzina_primerjalnega_niza--;
		}
    }
	//testno izpise kmpNext
	//izpis_KMPnext(kmpNext, dolzina_kmp);

	//kmp algoritem
	for(int i = 0; i < text.length(); i++) {
		for(int j = 0; j < dolzina_kmp; j++) {
			if(vzorec[j] != text[i + j]){
				i = i + j - kmpNext[j];
				if (kmpNext[j] < 0) i++;
				j = 0;
			}
			if(j == dolzina_kmp - 1) {
				j = 0;
				i = i + dolzina_kmp;
				//cout<<i  - dolzina_kmp<<endl;
				out << i - dolzina_kmp << " ";
			}
			if(i > text.length()) {
				break;
			}
		}
	}

	delete[] kmpNext;
}

void Sunday(const string& text, const string& vzorec) {
	//Bch tabela
	vector<int> bch(256, vzorec.length() + 1);
	for (int i = 0; i < vzorec.length(); ++i) {
		bch[vzorec[i]] = vzorec.length() - i;
	}

	for(int i = 0; i < text.length(); i++) {
		for(int j = 0; j < vzorec.length(); j++) {
			if(vzorec[j] != text[i + j]){
				j = 0;
				i = i + bch[text[i+ vzorec.length()] - j];
			}
			if(j == vzorec.length() - 1) {
				j = 0;
				i = i + vzorec.length();
				out << i - vzorec.length() << " ";
			}
			if(i > text.length()) {
				break;
			}
		}
	}
}

int main(int argc, const char* const argv[]) {
	if (argc != 4) {
		return -1;
	}

	string text = inputText(argv[3]);
	string vzorec = argv[2];
	out.open("out.txt");

	if (!out) {
		return -2;
	}

	if (argv[1][0] == '0') {
		KMP(text, vzorec);
	}
	else {
		Sunday(text, vzorec);
	}


	return 0;
}