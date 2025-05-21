#include <iostream>
using namespace std;

// Funcao que verifica se o numero eh primo
int numeroPrimo(int n) {
    if (n <= 1)
        return 0; // Nao eh primo

    for (int i = 2; i * i <= n; i++) {
        if (n % i == 0)
            return 0; // Encontrou divisor, nao eh primo
    }

    return 1; // Numero eh primo
}

// Funcao que imprime os 10 primeiros primos depois de 100
void imprimir10Primos() {
    int contador = 0;
    int numero = 100;
    
    while (contador < 10) {
        if (numeroPrimo(numero)) {
            cout << numero << endl;
            contador++;
        }
        numero++;
    }
}

int main() {
    cout << "\nOs 10 primeiros primos a partir de 100 sao:\n";
    imprimir10Primos();
    return 0;
}
