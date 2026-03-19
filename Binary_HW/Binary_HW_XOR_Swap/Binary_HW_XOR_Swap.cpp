#include <iostream>
#include <bitset>
using namespace std;

int main()
{
    uint8_t a = 0b00001000;
    uint8_t b = 0b00000100;
    
    cout << "START::::::::::::::::::::\n\n";
    cout << "a = " << int(a) << " OR " << bitset<8>(a) << '\n';
    cout << "b = " << int(b) << " OR " << bitset<8>(b) << "\n\n";

    void(*lazy_developer)(const char* ,const uint8_t &, const uint8_t &) = [](const char* str , const uint8_t& a , const uint8_t& b)
        {
            cout << str << bitset<8>(a xor b) << " = " << bitset<8>(a) << " XOR " << bitset<8>(b) << '\n';
        };
    
    lazy_developer("a = ", a, b);
    a = a xor b;
    
    lazy_developer("b = ", a, b);
    b = a xor b;

    lazy_developer("a = ", a, b);
    a = a xor b;

    cout << "\n\nRESULT::::::::::::::::::::\n\n";
    cout << "a = " << int(a) << " OR " << bitset<8>(a) << '\n';
    cout << "b = " << int(b) << " OR " << bitset<8>(b) << '\n';

    system("pause");

    return 0;
}