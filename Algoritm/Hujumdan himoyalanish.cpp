/**
	Boshlangan vaqt: 17/11/19 19:00
	
	Maqsad: Mashinadan uzatilayotgan ma'lumotlarni shifrlash uchun dastur tuzishni boshladim
	
	Shifr nimalar yordamida tuziladi: Shifrlash uchun vaqtdan foydalanaman va ma'lumot uzunligidan foydalanaman
	
	Kiber hujum sodir bo'lsa: Tizim ish faoliyatni vaqtincha amalga oshirmaydi ogohlantiriladi yoki ish faoliyatini to'xtatishi shart!

	'0'+random (0,102) + data.length();
	48+102+20
*/
#include <iostream>
using namespace std;
int main(){
	
	string text = "1Q2WyE3A4T5Y607I8O9";
	//string text = "KJ2lj2g43te1sL2L";
	//string text = "JUh86g76QP4O3PsnM";
	//string text = "upPklmqye291wQMr";
	//string text = "1qpIwYhtwMm9QIVc2";
	//string text = "StmL9kT2IJoHU9aRq";
	//string text = "At9qe1FsrJwXmQl";
	//string text = "PsjT6aL9kqidRlMQt";
	//string text = "e4ATrsC5oqVSnE8hwKlt";
	cout<<int('z');
	for(int i=0;i<130;i++){
		string text1 = text;
		for(int j=0;j<text.length();j++){
			text1[j] = char(int(text[j])+i);
			if(text1[j] == '&'){
				cout<<"No"<<endl;
					
			}
		}		
		cout<<i<<"->"<<text1<<"&"<<endl;
	}
	
	
	
	cout<<int('*');
	return 0;
}
