#include <iostream>
#include <string>

int verificaCpf(int cpf[]) {
    int resultado = 0;
    int j = 10;
    int multiplicacao = 0;
    for (int i = 0; i < 9; i++) {
        multiplicacao = cpf[i] * j;
        resultado = resultado + multiplicacao;
        j--; 
    }
    
    resultado = resultado * 10;
    resultado = resultado % 11;

    if(resultado != cpf[9])
        return 0;

    resultado = 0;
    j = 11;
    multiplicacao = 0;
    for (int i = 0; i < 10; i++) {
        multiplicacao = cpf[i] * j;
        resultado = resultado + multiplicacao;
        j--; 
    }

    resultado = resultado * 10;
    resultado = resultado % 11;

    std::cout << resultado;

    if (resultado != cpf[10])
        return 0;
    
    return 1;
}

int verificaCnpj(int cnpj[]) {
    // primeiro digito
    int numerosMagicos[] = {6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2};
    int multiplicacao = 0;
    int resultado = 0;
    int countNumMagic = 1;

    for (int i = 0; i < 12; i++) {
        multiplicacao = cnpj[i] * numerosMagicos[countNumMagic];
        resultado = resultado + multiplicacao;
        countNumMagic = countNumMagic + 1;
    }
    
    resultado = resultado % 11;

    if(resultado < 2) {
        if(cnpj[12] != 0)
            return 0;
    } else {
        resultado = 11 - resultado;
        if(cnpj[12] != resultado)
            return 0;
    }

    // segundo digito
    multiplicacao = 0;
    resultado = 0;

    for (int i = 0; i < 13; i++) {
        multiplicacao = cnpj[i] * numerosMagicos[i];
        resultado = resultado + multiplicacao;
    }

    resultado = resultado % 11;

    if(resultado < 2) {
        if(cnpj[13] != 0)
            return 0;
    } else {
        resultado = 11 - resultado;
        if(cnpj[13] != resultado)
            return 0;
    }

    return 1;
}

int verificaCadastro(int cadastro[], int isCnpj) {
    if (isCnpj)
        return verificaCnpj(cadastro);
    else
        return verificaCpf(cadastro);
}

int main() {
    int cpf[] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11};
    int cnpj[] = {1, 1, 2, 2, 2, 3, 3, 3, 0, 0, 0, 1, 8, 1};

    if (verificaCadastro(cpf, 0))
        std::cout << "cpf conservado" << std::endl;
    else
        std::cout << "cpf falso" << std::endl;
    
    if (verificaCadastro(cnpj, 1))
        std::cout << "cnpj verdadeiro" << std::endl;
    else
        std::cout << "cnpj falso" << std::endl;

    return 0;
}