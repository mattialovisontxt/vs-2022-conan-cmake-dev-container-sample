#include <iostream>
#include "main.hpp"

int main()
{
    boost::atomic_bool my_var = true;
    std::cout << "My_var is " << (my_var ? "True" : "False") << std::endl;
}