#include<bits/stdc++.h>
using namespace std;

class symbol_info
{
private:
    string name;
    string type;

    // Write necessary attributes to store what type of symbol it is (variable/array/function)
    // Write necessary attributes to store the type/return type of the symbol (int/float/void/...)
    // Write necessary attributes to store the parameters of a function
    // Write necessary attributes to store the array size if the symbol is an array
    string data_type;  
    string var_type; 
    
    int array_size;
    vector<string> param_types;
    vector<string> param_names;


public:
    symbol_info(string name, string type)
    {
        this->name = name;
        this->type = type;

        this->data_type = "";    
        this->var_type = "";      
        this->array_size = -1; 
    }
    string getname()
    {
        return name;
    }
    string get_type()
    {
        return type;
    }
    void set_name(string name)
    {
        this->name = name;
    }
    void set_type(string type)
    {
        this->type = type;
    }
    // Write necessary functions to set and get the attributes
    void set_data_type(string dt) { 
        data_type = dt; 
    }
    
    string get_data_type() { 
        return data_type; 
    }
    
    void set_var_type(string vt) { 
        var_type = vt; 
    }
    
    string get_var_type() { 
        return var_type; 
    }

     void set_array_size(int size) { 
        array_size = size; 
    }
    
    int get_array_size() { 
        return array_size; 
    }



     string get_return_type() { 
        return var_type; 
    }
    
    void set_return_type(string rt) { 
        var_type = rt; 
    }







    void set_param_types(vector<string> list) {
        this->param_types = list;
    }
    
    void set_param_names(vector<string> list) {
        this->param_names = list;
    }
    
    vector<string> get_param_types() { 
        return param_types; 
    }
    
    vector<string> get_param_names() { 
        return param_names; 
    }
    
    int get_param_count() { 
        return param_types.size(); 
    }


    string get_param_details() {
        string details = "";
        
        for (int i = 0; i < param_types.size(); i++) {
            details += param_types[i] + " " + param_names[i];
            
            if (i < param_types.size() - 1) {
                details += ", ";
            }
        }
        
        return details;
    }

    ~symbol_info()
    {
        // Write necessary code to deallocate memory, if necessary
    }
};