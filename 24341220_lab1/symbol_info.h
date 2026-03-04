#include<bits/stdc++.h>
using namespace std;

class symbol_info 
{
private:
    string sym_name;
    string sym_type;
    string text;          

public:

    symbol_info(string name, string type) 
    {
        sym_name = name;
        sym_type = type;
        text = name;      
    }

    string getname() 
    { 
        return sym_name; 
    }

    string gettype() 
    { 
        return sym_type; 
    }
    string gettext() 
    { 
        return text; 
    }      
    void settext(string t) 
    { 
        text = t; 
    }  
};