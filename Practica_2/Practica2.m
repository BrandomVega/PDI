clc
clear all
close all
warning off all

%procesando imagenes con su histograma


a=imread('beach.jpg');


imshow(a)
figure(4)
[m,n,color]=impixel(a)


% introduciendo las clases
c1=[color(1:5,1)' ; color(1:5,2)' ; color(1:5,3)'];
c2=[color(5:10,1)';color(5:10,2)';color(5:10,3)'];
c3=[color(10:15,1)';color(10:15,2)';color(10:15,3)'];



average_c1=mean(c1')
average_c1=average_c1'

average_c2=mean(c2')
average_c2=average_c2'

average_c3=mean(c3')
average_c3=average_c3'




continueHandler = "Y";


while continueHandler == "Y"
    [x,y,unknown]=impixel(a);
    


    % Graficando los datos de las clases
    plot3(c1(1,:),c1(2,:),c1(3,:),'ro','MarkerSize',10,'MarkerFaceColor','r')
    grid on
    hold on
    plot3(c2(1,:),c2(2,:),c2(3,:),'bo','MarkerSize',10,'MarkerFaceColor','b')
    plot3(c3(1,:),c3(2,:),c3(3,:),'yo','MarkerSize',10,'MarkerFaceColor','y')
    
    legend('sky', 'rock', 'water','unknow')
    desconocido=[ unknown(:,1)'; unknown(:,2)'; unknown(:,3)'] 
    plot3(desconocido(1,:),desconocido(2,:),desconocido(3,:),'ko','MarkerSize',10,'MarkerFaceColor','k')

    distance_c1 = ((average_c1(1,:)- desconocido(1,:))^2 + (average_c1(2,:)- desconocido(2,:))^2 + (average_c1(3,:)- desconocido(3,:))^2)^(1/2);
    distance_c2 = ((average_c2(1,:)- desconocido(1,:))^2 + (average_c2(2,:)- desconocido(2,:))^2 + (average_c2(3,:)- desconocido(3,:))^2)^(1/2);
    distance_c3 = ((average_c3(1,:)- desconocido(1,:))^2 + (average_c3(2,:)- desconocido(2,:))^2 + (average_c3(3,:)- desconocido(3,:))^2)^(1/2);
    disp("The unknown point, points at: ")
    if distance_c1 < distance_c2 & distance_c1 < distance_c3
        disp("Sky")
    elseif distance_c2 < distance_c1 & distance_c2 < distance_c3
        disp("Rock")
    else
        disp("Water")
    end
    
    continueHandler = input("Do you want to continue? [Y/N]","s")
    grid off
    hold off
end


disp('fin de PROCESO.....')