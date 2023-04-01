%% PRACTICA 4 
% A QUE CLASE PERTENECE UN PUNTO GENERADO X NÚMERO DE PUNTOS ALEATORIOS  

clc %limpia pantalla
clear  % limpia todo 
close all
warning off all  

%Lectura de la imagen
 h=imread('C:\Users\nogue\OneDrive\Escritorio\IPNSOF\4S IA\PDI\playa.jpg');

 figure(1)
 [m,n]=size(h);
 imshow(h)

 figure(2)
 %Cuadricula la imagen a un plano cartesiano 
 dato=imref2d(size(h));
 imshow(h,dato)

 %Usuario digita los puntos que contendra cada clase  
  disp('.....¿Cuantos puntos identificadores quiere por clase?....')
  NUM=input('ANS:');

 %Genera las clases con los números aleatorios

  c1x=randi([1,1200],1,NUM);
  c1y=randi([1,410],1,NUM);
 
  c2x=randi([1,1200],1,NUM);
  c2y=randi([415,520],1,NUM);
 
  c3x=randi([1,1200],1,NUM);
  c3y=randi([522,750],1,NUM); 
  
  %Usuario digita el punto a calcular 
  disp('.....DIGITE LAS COORDENADAS DEL PUNTO  A CLASIFICAR....')
  px=input('Coordenada en X:');
  py=input('Coordenada en Y:');
  desconocido=[px py]


 %Guarda los RGB de los puntos identificadoresy los muestra sobre la imagen
 %con el plano 
 z1=impixel(h,c1x(1,:),c1y(1,:));
 z2=impixel(h,c2x(1,:),c2y(1,:));
 z3=impixel(h,c3x(1,:),c3y(1,:));
 z4=impixel(h,desconocido(1,1),desconocido(1,2));
 
 %Grafica  sobre la imagen:
 hold on
 grid on
 plot(c1x(1,:),c1y(1,:),'ob','Markersize',5,'MarkerFaceColor','b')
 plot(c2x(1,:),c2y(1,:),'or','Markersize',5,'MarkerFaceColor','r')
 plot(c3x(1,:),c3y(1,:),'oy','Markersize',5,'MarkerFaceColor','y')
 plot(desconocido(1,1),desconocido(1,2),'og','Markersize',5,'MarkerFaceColor','g')
 legend('sky', 'water', 'sand','unknow')

%Media de cada clase segun el RGB
media_sky=mean(z1);
media_water=mean(z2);
media_sand=mean(z3);


%Calcula la distancia entre el punto desconcido y los puntos de la clase
dp1=sqrt((z4(1,1)-media_sky(1,1)).^2 + (z4(1,2)-media_sky(1,2)).^2 + (z4(1,3)-media_sky(1,3)).^2)
dp2=sqrt((z4(1,1)-media_water(1,1)).^2 + (z4(1,2)-media_water(1,2)).^2 + (z4(1,3)-media_water(1,3)).^2)
dp3=sqrt((z4(1,1)-media_sand(1,1)).^2 + (z4(1,2)-media_sand(1,2)).^2 + (z4(1,3)-media_sand(1,3)).^2)

%Los pone en un arreglo y calcula el MIN 
A=[dp1 dp2 dp3]
M=min(A)

%Muestra con el MIN a que clase pertenece  dependiendo del punto desconocido
if  M == dp1
    disp('El punto pertenece a la clase CIELO') 
elseif M == dp2
    disp('El punto pertenece a la clase AGUA')
elseif M == dp3
    disp( 'El punto pertenece a la clase ARENA')
end

 disp("Fin del Programa...Uwu")
