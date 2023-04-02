%% PR 6
% A) DADA LA PRACTICA 5 APLICAR LA ECUALIZACIÓN 
% B) A 2 IMG DIFERENTES APLICAR EL HISTOGRAMA DE CORRESPONDENCIA
clc
clear 
%close all 
warning off all 

% -------------------------------------A-----------------------------------
%lee IMG y te deja seleccionarla 
figure(1)
a=imread('C:\Users\nogue\OneDrive\Escritorio\IPNSOF\4S IA\PDI\med.jpeg');
tamIMG=size(a);

%Muestra el HISTOGRAMA con bar
figure(1)
 b=rgb2gray(a);
 [veces,pixeles]=imhist(b);
 PXORG=[veces pixeles];
 %subplot(1,2,2)
 bar(pixeles,veces)
 title('Histograma Imagen Original')
%  xlabel('Pixeles')
%  ylabel('Veces que aparece')

figure(2)
%RGB GRISES 
roja=a;
roja(:,:,2:3)=0;
%figure(2)
subplot(1,3,1) 
imshow(roja(:,:,1))
title('R GRIS')

verde=a;
verde(:,:,1:2:3)=0;
%figure(3)
subplot(1,3,2)
imshow(verde(:,:,2))
title('G GRIS')

azul=a;
azul(:,:,1:2)=0;
subplot(1,3,3)
imshow(azul(:,:,3))
title('B GRIS')

%HISTOGRAMAS DE RGB GRISES usando bar 
figure(3)
[vecesr,pixelesr]=imhist(roja);
PXROJA = [vecesr pixelesr];
subplot(3,1,1)
bar(pixelesr,vecesr)
title('Histograma RGris')
xlabel('Pixeles')
ylabel('Veces')
%figure(5)
[vecesv,pixelesv]=imhist(verde);
PXVERDE = [vecesv pixelesv];
subplot(3,1,2)
bar(pixelesv,vecesv)
title('Histograma GGris')
xlabel('Pixeles')
ylabel('Veces')
%figure(6)
[vecesa,pixelesa]=imhist(azul);
PXAZUL = [vecesa pixelesa];
subplot(3,1,3)
bar(pixelesa,vecesa)
title('Histo BGris')
xlabel('Pixeles')
ylabel('Veces') 

disp('.....DIGITE el MAXIMO Y EL MINIMO PARA CALCULAR EL NUEVO HISTOGRAMA ....')
min=input('MIN:');
max=input('MAX:');
valoresUsuario = [min max]

%Muestra la IMAGEN COMPRIMIDA O EXPANDIDA 
minR=0;
maxR=255;
minV=0;
maxV=255;
minA=0;
maxA=255;

for i=1:tamIMG(1,1)
    for j=1:tamIMG(1,2)
        if a(i,j,1)< minR
            minR = a(i,j,1);
        end

        if a(i,j,2)< minV
            minV = a(i,j,2);
        end

        if a(i,j,3)< minA
            minA = a(i,j,3);
        end

        if a(i,j,1)> maxR
            maxR = a(i,j,1);
        end

        if a(i,j,2)> maxV
            maxV = a(i,j,2);
        end

        if a(i,j,3)> maxA
            maxA = a(i,j,3);
        end

    end
end

imgComExp=a;
for i=1:tamIMG(1,1)
   for j=1:tamIMG(1,2)
      imgComExp(i,j,1)=((imgComExp(i,j,1)-minR)/(maxR-minR))*(max-min)+min;
      imgComExp(i,j,2)=((imgComExp(i,j,2)-minV)/(maxR-minV))*(max-min)+min;
      imgComExp(i,j,3)=((imgComExp(i,j,3)-minA)/(maxR-minA))*(max-min)+min; 
   end
end

figure(4);
subplot(1,3,1) 
imshow(imgComExp(:,:,1));
title('RGris Com/Exp')
%figure(2);
subplot(1,3,2) 
imshow(imgComExp(:,:,2));
title('GGris Com/Exp')
%figure(3);
subplot(1,3,3) 
imshow(imgComExp(:,:,3));
title('BGris Com/Exp')

figure(5);
subplot(1,2,2)
imshow(imgComExp);
tamIMGCOM = size(imgComExp);
title('Imagen Com/Exp')
subplot(1,2,1)
imshow(a);
title('Original')

figure(6)
%ROJO
LimUR= find(PXROJA(:,2)>=min & PXROJA(:,2)<=max);
PuntosUR=[vecesr(LimUR) pixelesr(LimUR)];
subplot(1,3,1)
bar(pixelesr(LimUR),vecesr(LimUR))
title('H.IMG NUEVA RGris')
xlabel('Pixeles')
ylabel('Veces')
%VERDE
LimUG= find(PXVERDE(:,2)>=min & PXVERDE(:,2)<=max);
PuntosUG=[vecesv(LimUG) pixelesv(LimUG)];
subplot(1,3,2)
bar(pixelesv(LimUG),vecesv(LimUG))
title('H.IMG NUEVA GGris')
xlabel('Pixeles')
ylabel('Veces')
%AZUL
LimUB= find(PXAZUL(:,2)>=min & PXAZUL(:,2)<=max);
PuntosUB=[vecesa(LimUB) pixelesa(LimUB)];
subplot(1,3,3)
bar(pixelesa(LimUB),vecesa(LimUB))
title('H.IMG NUEVA BGris')
xlabel('Pixeles')
ylabel('Veces')

c=rgb2gray(imgComExp);
[vecesE,pixelesE]=imhist(c);
PXCE=[vecesE pixelesE];
HE= find(PXCE(:,1)>0);
PuntosEC=[vecesE(HE) pixelesE(HE)];
tamarray=size(PuntosEC);
S=sum(PuntosEC);

ecualizacion = zeros(8,3);
 for i=1:tamarray(1,1)
     in = i;
     index= PuntosEC(i,2);
     Pacum = PuntosEC(i,1)/S(1,1);
     F = ((max-min)*Pacum)+min;
     ecualizacion=[index Pacum F]
 end
w= 256:-4:4;
IEcu = histeq(c,w);
IEcuOR =histeq(imgComExp,w); 
IEcuR =histeq(imgComExp(:,:,1),w);
IEcuG =histeq(imgComExp(:,:,2),w);
IEcuB =histeq(imgComExp(:,:,3),w);

figure(7)
subplot(1,2,1)
imshow(imgComExp);
title('Imagen Com/Exp')
subplot(1,2,2)
imshow(IEcuOR);
title('Imagen Ecualizada')

figure(8)
[ve,pxe]=imhist(IEcu);
bar(pxe,ve)
title('Histograma Ecualizado')

figure(9)
subplot(2,3,1)
imshow(IEcuR)
title('RGris Ecualizada')
subplot(2,3,4)
[vR,pxR]=imhist(IEcuR);
bar(pxR,vR)
subplot(2,3,2)
imshow(IEcuG)
title('GGris Ecualizada')
subplot(2,3,5)
[vG,pxG]=imhist(IEcuG);
bar(pxG,vG)
subplot(2,3,3)
imshow(IEcuB)
title('BGris Ecualizada')
subplot(2,3,6)
[vB,pxB]=imhist(IEcuB);
bar(pxB,vB)


disp('----------------------------------------')

%-------------------------------------B------------------------------------

disp("Fin del Programa...Uwu")