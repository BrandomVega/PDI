
clc
close all

a = imread('img2.jpg');

%Muestra la imagen e histogramas originales
b = rgb2gray(a);
subplot(1,2,1)
imshow(b)
subplot(1,2,2)
[freq, gris] = imhist(b);
bar(gris, freq, "black")
title('Histograma IMG original')
table = [gris freq];
disp(table)


%recorre el arreglo y sumando los niveles de grises para obtener el divisor
%de la probabilidad
divisor = 0;
for i=1:size(freq)
    divisor = freq(i,1) + divisor;
end
disp("divisor: " + divisor);


%Realiza la formula
%F(g) = [gmax-gmin]*ProbAcum+Gmin
[gmin,gmax] = bounds(b,"all");
c=b;
[n,m] = size(c);

for i=1:n
    for j=1:m
        %Retorna la probabilidad acumulada para el valor de la matriz
        probabilidad = probAcumulada(freq, divisor,c(i,j)+1); 
        c(i,j) = ceil(((gmax-gmin)*probabilidad)+gmin);
    end
end

%Muestra la ecualizacion
figure(2)
subplot(1,2,1)
imshow(c)
subplot(1,2,2)
[freq, gris] = imhist(c);
bar(gris, freq, "green")
title('Histograma IMG-Eq')