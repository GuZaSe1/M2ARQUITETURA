#include <iostream>
using namespace std;

int main() {

    int vet[5] = {0, 1, 2, 3, 4}, soma = 0;

    for (int i = 0; i < 5; i++) {
        cout << vet[i] << endl;
        soma = soma + vet[i];
    }

    cout << "\nSoma dos valores do vetor: " << soma << "\n";

    return 0;
}