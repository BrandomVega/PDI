clc
clear 
close all
warning off all 



a=imread('img2.jpg');
tamIMG=size(a);


% figure(1)
% b=rgb2gray(a);
% [veces,pixeles]=imhist(b);
% bar(pixeles,veces, 'red')
% title('Histograma original')


%Obtenemos los grises de la img
figure(2)
red=a;
red(:,:,2:3)=0;
subplot(2,3,1) 
imshow(red(:,:,1))
title('Red')

green=a;
green(:,:,1:2:3)=0;
subplot(2,3,2)
imshow(green(:,:,2))
title('Green')

blue=a;
blue(:,:,1:2)=0;
subplot(2,3,3)
imshow(blue(:,:,3))
title('Blue')

%Ploteamos los resultados
[vecesR,pixelesR]=imhist(red);
histRed = [vecesR pixelesR]; %usado al final
subplot(2,3,4)
bar(pixelesR,vecesR)
title('Hist.RedGray')

[vecesG,pixelesG]=imhist(green);
histGreen = [vecesG pixelesG ];
subplot(2,3,5)
bar(pixelesG,vecesG)
title('Hist.GreenGray')

[vecesB,pixelesB]=imhist(blue);
histBlue = [vecesB pixelesB];
subplot(2,3,6)
bar(pixelesB,vecesB)
title('Hist.BlueGray')


txt = "Y";
while(txt == 'Y')
disp('Ingrese el minimo y maximo ')
min=input('MIN:');
max=input('MAX:');

[minR,maxR] = bounds(red, "all");
[minG,maxG] = bounds(green, "all");
[minB,maxB] = bounds(blue, "all");

resultado=a;
for i=1:tamIMG(1,1)
   for j=1:tamIMG(1,2)
      resultado(i,j,1)=((resultado(i,j,1)-minR)/(maxR-minR))*(max-min)+min;
      resultado(i,j,2)=((resultado(i,j,2)-minG)/(maxG-minG))*(max-min)+min;
      resultado(i,j,3)=((resultado(i,j,3)-minB)/(maxB-minB))*(max-min)+min; 
   end
end
%Muestra los grises obtenidos
figure(4);
subplot(1,3,1) 
imshow(resultado(:,:,1));
title('Red en gris com/exp')
subplot(1,3,2) 
imshow(resultado(:,:,2));
title('Green en gris com/exp')
subplot(1,3,3) 
imshow(resultado(:,:,3));
title('Blue en gris com/exp')
%Muestra el resultado a color y el original
figure(5);
subplot(1,2,2)
imshow(resultado);
title('Imagen Com/Exp')
subplot(1,2,1)
imshow(a);
title('Original')





%Toma el histograma y lo reduce a los maximos y minimos para mostrarlo
figure(6)
%ROJO
limitesRojo= find(histRed(:,2)>=min & histRed(:,2)<=max);
subplot(1,3,1)
bar(pixelesR(limitesRojo),vecesR(limitesRojo))
title('Hist. Rojo')
%VERDE
limitesVerde = find(histGreen(:,2)>=min & histGreen(:,2)<=max);
subplot(1,3,2)
bar(pixelesG(limitesVerde),vecesG(limitesVerde))
title('Hist. Verde')
%AZUL
limitesAzul= find(histBlue(:,2)>=min & histBlue(:,2)<=max);
subplot(1,3,3)
bar(pixelesB(limitesAzul),vecesB(limitesAzul))
title('Hist. Azul')







txt = input("Probar con otra configuración? Y/N: ", "s");
end
disp("Fin del Programa...")
   













































%NOTAS:
%LOS ULTIMOS HISTOGRAMAS ESTAN BASADOS EN LA IMAGEN ORIGINAL REALMENTE

%LOS HISTOGRAMAS REALES NO PASAN DE DOS VALORES DIFERNTES, PUES LA IMAGEN
%SI SE OBSERVA DE CERCA SOLO HAY DOS TONOS (BLANCO Y NEGRO POR EJEMPLO) 
% DESPUES DE LA COMPRESION