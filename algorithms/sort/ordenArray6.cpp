/******************************************************************************
                              Online C++ Compiler.
               Code, Compile, Run and Debug C++ program online.
Write your code in this editor and press "Run" button to compile and execute it.
*******************************************************************************/

#include <iostream>

using namespace std;
//
int vector[]    = {2,3,1};
int dimension = 0;
int* vec_temp= new int[dimension];
int vec_orden[] = {0,0,0};
int var = 0;
int i = 0;
int mayor = 0;
int idx_mayor = 0;
//
void imprime_vector(int v[])
{
    cout << endl;
    for(i=0; i<=2; i++){
        cout << v[i] << ",";
    }
    cout << endl;
}
//
void buscar_mayor_vector_ini(){
    dimension = 2;
    do{
        i=2;
        mayor = 0;
        do{
            if(vec_temp[i]>= mayor){
                mayor = vec_temp[i];
                idx_mayor = i;
            }
        i--;
        }while(i>=0);
        // para no volver a tomar ese valor
        vec_temp[idx_mayor] = 0;
        for(i=0;i<=2;i++){
            if(vec_orden[i]==0){
                vec_orden[i] = mayor;
                break;
            }
        }
        dimension --;
    }while(dimension>=0);
}


int main()
{
    //
    cout << "vector inicial: ";
    imprime_vector(vector);
    //
    cout << "vector temporal : " << endl;
    dimension = 2;
    for(i=0;i<=dimension;i++){
        vec_temp[i] = vector[i];
        cout << vec_temp[i] << ",";
    }
    cout << endl;
    //
    buscar_mayor_vector_ini();
    cout << "vector ordenado : ";
    imprime_vector(vec_orden);
    return 0;
}
