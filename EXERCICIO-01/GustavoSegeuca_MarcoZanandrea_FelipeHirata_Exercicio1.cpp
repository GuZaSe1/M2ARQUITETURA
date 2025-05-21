#include <iostream>

using namespace std;

// Funcao que verifica se o numero eh primo
int numeroPrimo(int n) {
    if (n <= 1)
        return 0; // Nao eh primo

    for (int i = 2; i * i <= n; i++) {
        if (n % i == 0)
            return 0; // Encontrou divisor, não eh primo
    }

    return 1; // Número é primo
}

int main() {
    int valor;

    cout << "Informe um valor: ";
    cin >> valor;

    int resultado = numeroPrimo(valor);

    cout << "\nNumero Primo? (1=sim, 0=nao): " << resultado << endl;

    return 0;
}
