#include <bits/stdc++.h>
using namespace std;

class symbol_info {
    string name;
    string type;
    string txt;

public:
    symbol_info(string n, string t) : name(n), type(t), txt(n) {}

    string getname() { return name; }
    string gettype() { return type; }
    string gettext() { return txt; }
    void settext(string s) { txt = s; }
};