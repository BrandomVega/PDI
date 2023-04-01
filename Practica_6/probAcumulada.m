function [probabilidad] = probAcumulada(freq, divisor,indice)
    %probAcumulada: obtiene la probabilidad acumulada de los niveles de grises
    suma = 0;
    for i=1:indice
        suma = freq(i,1) + suma;
    end
    probabilidad = suma/divisor;
end