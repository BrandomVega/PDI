%% PRACTICA 2 
%  CLASES DE UN PUNTO(PX)

clc %limpia pantalla
clear  % limpia todo 
warning off all 
    a=imread('C:\Users\nogue\OneDrive\Escritorio\IPNSOF\4S IA\PDI\playa.jpg');
    imshow(a)
    [m,n]=size(a);
    %b=rgb2gray(a);
    %imshow(b) 

    %Usuario selecciona el punto a calcular 
    desconocido=impixel(a);
    disp("desconocido=")
    disp(desconocido(1,:))

    % introduciendo las clases RGB
    c1=[15 44 55 85 193;45 99 110 149 222;115 164 175 195 238]%cielo
    c2=[65 153 45 94 130; 139 224 113 164 201; 168 220 162 189 207]%mar
    c3=[ 246 239 241 228 245; 239 227 235 215 236; 210 189 203 173 203]%arena
    %desconocido=[ 203; 221; 231;] 
    
    % introduciendo las clases GRIS
    %c1=[42 86 93 187 215;42 86 93 187 215;42 86 93 187 215]%cielo
    %c2=[146 92 152 145 184; 146 92 152 145 184; 146 92 152 145 184]%mar
    %c3=[ 229 229 241 234 237; 229 229 241 234 237; 229 229 241 234 237]%arena
    %desconocido=[ 125; 125; 125;] 
    
    
    %Media de cada clase segun el RGB
    media_sky=mean(c1)
    media_water=mean(c2)
    media_sand=mean(c3)
    
    %Usuario digita el punto a calcular 
    %disp('.....DIGITE SU PUNTO....')
    %prompt = "Escriba el R de su punto:";
    %x = input(prompt);
    %prompt = "Escriba el G de su punto:";
    %y = input(prompt);
    %prompt = "Escriba el B de su punto:";
    %z = input(prompt);
    
    %desconocido=[ x; y; z;] 
     
    %Calcula la distancia entre el punto desconcido y los puntos de la clase
    dp1=sqrt((desconocido(1,1)-media_sky(1,1)).^2 + (desconocido(1,2)-media_sky(1,2)).^2 + (desconocido(1,3)-media_sky(1,3)).^2)
    dp2=sqrt((desconocido(1,1)-media_water(1,1)).^2 + (desconocido(1,2)-media_water(1,2)).^2 + (desconocido(1,3)-media_water(1,3)).^2)
    dp3=sqrt((desconocido(1,1)-media_sand(1,1)).^2 + (desconocido(1,2)-media_sand(1,2)).^2 + (desconocido(1,3)-media_sand(1,3)).^2)
    
    %Los pone en un arreglo y calcula el MIN 
    A=[dp1 dp2 dp3]
    M=min(A)
    
    %Muestra con el MIN a que clase depende el punto desconocido
    if  M == dp1
        disp('El punto pertenece a la clase CIELO') 
    elseif M == dp2
        disp('El punto pertenece a la clase AGUA')
    elseif M == dp3
        disp( 'El punto pertenece a la clase ARENA')
    end

     % Graficando los datos de las clases
    plot3(c1(1,:),c1(2,:),c1(3,:),'ro','MarkerSize',10,'MarkerFaceColor','r')
    grid on
    hold on
    plot3(c2(1,:),c2(2,:),c2(3,:),'bo','MarkerSize',10,'MarkerFaceColor','b')
    plot3(c3(1,:),c3(2,:),c3(3,:),'yo','MarkerSize',10,'MarkerFaceColor','y')
    plot3(desconocido(1,1),desconocido(1,2),desconocido(1,3),'ko','MarkerSize',10,'MarkerFaceColor','k')
    legend('sky', 'water', 'sand','unknow')
    
    
    prompt = "¿Quieres escojer otro punto? Y/N [ANS]: ";
    txt = input(prompt,"s");
    while(txt ~= 'N')
        if isempty(txt) || txt == 'Y'
            
            desconocido=impixel(a);
            disp("desconocido=")
            disp(desconocido(1,:))
    
            
    %         desconocido=[ x; y; z;] 
            
            
            %Calcula la distancia entre el punto desconcido y los puntos de la clase
            dp1=sqrt((desconocido(1,1)-media_sky(1,1)).^2 + (desconocido(1,2)-media_sky(1,2)).^2 + (desconocido(1,3)-media_sky(1,3)).^2)
            dp2=sqrt((desconocido(1,1)-media_water(1,1)).^2 + (desconocido(1,2)-media_water(1,2)).^2 + (desconocido(1,3)-media_water(1,3)).^2)
            dp3=sqrt((desconocido(1,1)-media_sand(1,1)).^2 + (desconocido(1,2)-media_sand(1,2)).^2 + (desconocido(1,3)-media_sand(1,3)).^2)
        
            %Los pone en un arreglo y calcula el MIN 
            dist_tot=[dp1 dp2 dp3]
            Minimo=min(min(dist));
            
            valor = find(minimo==dist_tot)
            printf("el vector desconocido pertenece a la clase\n",valor)

            %if(M == find )
        
            if  M == dp1
                disp('El punto pertenece a la clase CIELO') 
            elseif M == dp2
                disp('El punto pertenece a la clase AGUA')
            elseif M == dp3
                disp( 'El punto pertenece a la clase ARENA')
            end 
    
             % Graficando los datos de las clases
            plot3(c1(1,:),c1(2,:),c1(3,:),'ro','MarkerSize',10,'MarkerFaceColor','r')
            grid on
            hold on
            plot3(c2(1,:),c2(2,:),c2(3,:),'bo','MarkerSize',10,'MarkerFaceColor','b')
            plot3(c3(1,:),c3(2,:),c3(3,:),'yo','MarkerSize',10,'MarkerFaceColor','y')
            plot3(desconocido(1,1),desconocido(1,2),desconocido(1,3),'ko','MarkerSize',10,'MarkerFaceColor','k')
            legend('sky', 'water', 'sand','unknow')
     
        end      
    end 
    if txt == 'N'
            disp("Fin del Programa...Uwu")
    end