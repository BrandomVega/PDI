%% PRACTICA 3 
%  CLASES DE UN PUNTO(PX) 15 PUNTOS ALEATORIOS 


clc %limpia pantalla 
clear  % limpia todo 
close all
warning off all 

%Lectura de la imagen
 h=imread('C:\Users\diego\OneDrive\Documentos\MATLAB\playa.jpeg');

 figure(1)
 [m,n]=size(h);
 imshow(h)

 figure(2)
 %Cuadricula la imagen a un plano cartesiano 
 dato=imref2d(size(h));
 imshow(h,dato)

 %Le pedimos al usuario cuántos puntos quiere por cada clase
 numPuntos = input("Número de puntos por clase:");

 %generando las clases con los números aleatorios
  cSandX = randi([1,1200],1,numPuntos);
  cSandY = randi([530,750],1,numPuntos);

  cSkyX = randi([1,1200],1,numPuntos);
  cSkyY = randi([1,415],1,numPuntos);

  cSeaX = randi([1,1200],1,numPuntos);
  cSeaY = randi([420,510],1,numPuntos);

  %c1x=randi([1,1200],1,15);
  %c1y=randi([1,710],1,15);
  %puntos = [cSandX, cSkyX, cSeaX; cSandY, cSkyY, cSeaY]

  %1,400 
 
%    c2x=randi([1,1200],1,15);
%    c2y=randi([420,510],1,15);  
%   
%    c3x=randi([1,1200],1,15);
%    c3y=randi([530,750],1,15);

%   L1X= find
%L1Y= find(puntos(2,:)>0 & puntos(2,:)<=400);
%   L2X= find 
%L2Y= find(puntos(2,:)>420 & puntos(2,:)<=510);
%   L3X= find 
%L3Y= find(puntos(2,:)>510 & puntos(2,:)<=750);
%sk=[cSkyX(1,:);cSkyY(1,:)];
%wa=[cSeaX(1,:);cSeaY(1,:)];
%sa=[cSandX(1,:);cSandY(1,:)];

%   skX(c1x>0 & c1x<=1200)
%   skY(c1y>0 & c1y<=400)
%   waX(c1x>0 & c1x<=1200)
%   waY(c1x>=420 & c1x<=510)
%   saX(c1x>0 & c1x<=1200)
%   saY(c1x>=530 & c1x<=750)
   
  %Usuario digita el punto a calcular 
disp('.....DIGITE LAS COORDENADAS DEL PUNTO  A CLASIFICAR....')
px=input('Coordenada en X:');
py=input('Coordenada en Y:');
desconocido=[px py];


 %Guarda los RGB de los puntos identificadoresy los muestra sobre la imagen
%  %con el plano 
z1=impixel(h,cSkyX(1,:),cSkyY(1,:))
z2=impixel(h,cSeaX(1,:),cSeaY(1,:))
z3=impixel(h,cSandX(1,:),cSandY(1,:))
z4=impixel(h,desconocido(1,1),desconocido(1,2))
%  
%  %graficando sobre la imagen:
 hold on 
 grid on
 plot(cSkyX(1,:),cSkyY(1,:),'ob','Markersize',10,'MarkerFaceColor','b')
 plot(cSeaX(1,:),cSeaY(1,:),'or','Markersize',10,'MarkerFaceColor','r')
 plot(cSandX(1,:),cSandY(1,:),'oy','Markersize',10,'MarkerFaceColor','y')
 plot(desconocido(1,1),desconocido(1,2),'og','Markersize',10,'MarkerFaceColor','g')
 legend('sky', 'water', 'sand','unknow')

%Media de cada clase segun el RGB
media_sky=mean(z1)
media_water=mean(z2);
media_sand=mean(z3); 


%Calcula la distancia entre el punto desconcido y los puntos de la clase
dp1=sqrt((z4(1,1)-media_sky(1,1)).^2 + (z4(1,2)-media_sky(1,2)).^2 + (z4(1,3)-media_sky(1,3)).^2)
dp2=sqrt((z4(1,1)-media_water(1,1)).^2 + (z4(1,2)-media_water(1,2)).^2 + (z4(1,3)-media_water(1,3)).^2);
dp3=sqrt((z4(1,1)-media_sand(1,1)).^2 + (z4(1,2)-media_sand(1,2)).^2 + (z4(1,3)-media_sand(1,3)).^2);

% %Los pone en un arreglo y calcula el MIN 
A=[dp1 dp2 dp3];
M=min(A);

%Muestra con el MIN a que clase depende el punto desconocido
if  M == dp1
     disp('El punto pertenece a la clase CIELO') 
elseif M == dp2
     disp('El punto pertenece a la clase AGUA')
elseif M == dp3
     disp( 'El punto pertenece a la clase ARENA')
end

 disp("Fin del Programa...Uwu")