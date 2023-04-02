
%Imagen 1 
A1=imread("tree.JPG");
A=rgb2gray(A1);
[px1,~]=imhist(A);

%Imagen 2
B1=imread("img2.jpg");
B=rgb2gray(B1);
[px2,~]=imhist(B);
 
figure(1)
subplot(2,2,1)
imshow(A)
title('Imagen 1')
subplot(2,2,3)
histogram(A);
xlabel('Pixeles')
ylabel('Veces')
ylim ([0 2000])
title('Histograma Imagen 1')

subplot(2,2,2)
imshow(B)
title('Imagen 2')
subplot(2,2,4)
histogram(B);
xlabel('Pixeles')
ylabel('Veces')
ylim ([0 2000])
title('Histograma Imagen 2')

%Calcula la probabilidad acumulada de la Imagen A y la Imagen B +
%cumsum(A) devuelve la suma acumulativa de A comenzando al principio de la primera dimensión del arreglo en A cuyo tamaño no es igual a 1.
%numel es el numero de elementos
PacumA=cumsum(px1) / numel(A);
PacumB=cumsum(px2) / numel(B);

%Usa la probabilidad para comparar 
HCor1=zeros(256,1,'uint8');
for i = 1:256
    [~,indice] = min(abs(PacumA(i) - PacumB));
    HCor1(i) = indice-1;
end

HCor2=zeros(256,1,'uint8');
for i = 1:256
    [~,indice] = min(abs(PacumB(i) - PacumA));
    HCor2(i) = indice-1;
end

%Realiza la imagen correspondida segun los datos de Pacum 
im1Correspondida = intlut(A,HCor1);
im2Correspondida = intlut(B,HCor2);



%muestra de imagenes
figure(2)
subplot(3,2,1)
imshow(A)
title('Imagen 1')
subplot(3,2,3)
imshow(im1Correspondida)
title('Imagen Correspondida')
subplot(3,2,5)
histogram(im1Correspondida);
xlabel('Pixeles') 
ylabel('Veces')
ylim ([0 2000])
title('Histograma de  Correspondencia Imagen 1')

subplot(3,2,2)
imshow(B)
title('Imagen 2')
subplot(3,2,4)
imshow(im2Correspondida)
title('Imagen Correspondida')
subplot(3,2,6)
histogram(im2Correspondida);
xlabel('Pixeles')
ylabel('Veces')
ylim ([0 2000])
title('Histograma de  Correspondencia Imagen 2')

figure(3)
J = imhistmatch(A1,B1);
K = imhistmatch(B1,A1);
imshow(J)
figure(4)
imshow(K)

disp("Fin del Programa...")


