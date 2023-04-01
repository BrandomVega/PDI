clc
clear  
close all
warning off all 

h=imread('imagen.png');


[m,n]=size(h);

dato=imref2d(size(h)); %muestra la imagen con las coordenadas de la img
imshow(h,dato)
%Pausa para apreciar la imagen (^///^)
pause(1); 

%Fronteras de las clases
% 15 numeros aleatorios en todos los x. Para Y va del 1 al 250
c1x=randi([1,1280],1,15);
c1y=randi([1,250],1,15);

c2x=randi([1,1280],1,15);
c2y=randi([250,505],1,15);

c3x=randi([1,1280],1,15);
c3y=randi([510,768],1,15);


%Matriz de puntos aleatorios
negro = [c1x;c1y];
rojo = [c2x;c2y];
amarillo = [c3x;c3y];


disp("Ingrese el punto a clasificar: ");
[x,y,rgb] = impixel(h);
desconocido = [x,y];

%Obtiene los RGB de las coordenadas a partir de h
z1=impixel(h,negro(1,:),negro(2,:));
z2=impixel(h,rojo(1,:),rojo(2,:));
z3=impixel(h,amarillo(1,:),amarillo(2,:));
z4=impixel(h,desconocido(1,1),desconocido(1,2));
 
 
 hold on 
 grid on
 plot(negro(1,:),negro(2,:),'ok','Markersize',5,'MarkerFaceColor','w');
 plot(rojo(1,:),rojo(2,:),'ok','Markersize',5,'MarkerFaceColor','g');
 plot(amarillo(1,:),amarillo(2,:),'ok','Markersize',5,'MarkerFaceColor','m');
 plot(desconocido(1,1),desconocido(1,2),'ok','Markersize',8,'MarkerFaceColor','c');
 legend('NEGRO', 'ROJO', 'AMARILLO','DESCONOCIDO')

%Media de cada clase segun el RGB
media_N=mean(z1);
media_R=mean(z2);
media_A=mean(z3); 


%Distancia entre el punto desconcido y los puntos
dp1=sqrt((z4(1,1)-media_N(1,1)).^2 + (z4(1,2)-media_N(1,2)).^2 + (z4(1,3)-media_N(1,3)).^2);
dp2=sqrt((z4(1,1)-media_R(1,1)).^2 + (z4(1,2)-media_R(1,2)).^2 + (z4(1,3)-media_R(1,3)).^2);
dp3=sqrt((z4(1,1)-media_A(1,1)).^2 + (z4(1,2)-media_A(1,2)).^2 + (z4(1,3)-media_A(1,3)).^2);

A=[dp1 dp2 dp3];
M=min(A);

if  M == dp1
     disp('El punto pertenece a la clase con color negro') 
elseif M == dp2
     disp('El punto pertenece a la clase con color rojo')
elseif M == dp3
     disp( 'El punto pertenece a la clase con color amarillo')
end

 disp("Fin del programa...")