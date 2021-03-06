%Trajectory Plotter
%by Russell J Phelan, Physics 281 Fall 2014
%This program plots the trajectory of a cannonball (particle) 

clear all %clears all previous variables 
close all %closes all open figures

%global variables
g = 9.8; %in m/s^2
v_0 = 20; %in m/s
t_0 = 0; %starting time in seconds
y_0 = 0; %initial y position of particle
x_0 = 0; %initial x position of particle

dt = .1; %time increment in s (must be small enough for good plot resolution)

%calculate total time (t_f) necessary for trajectories to complete, using v_0.
%Assumes particle is shot straight up.
t_f = 0; %initial value
yAt90 = [-4.9 v_0 0];
rootsAt90 = roots(yAt90);
j = 1;
while (j <= 2)
    if (rootsAt90(j) > t_f)
        t_f = rootsAt90(j);
    else
        j = j + 1;
    end
end

%draw axes and target. Labels target
axis([0 50 0 50]);
xlabel('Distance (m)');
ylabel('Height (m)');
title('Cannonball Trajectory');

line([24 29],[1.5 1.5],'Color','red','LineWidth',1); %creating target
line([20 25],[3.2 3.2],'Color','red','LineWidth',1); %creating target

%tell user particle will be launched at v_0
%disp('Particle will be launched at 50m/s')
formatspec = 'Particle will be launched at %um/s\n';
fprintf(formatspec,v_0)

%main game loop
for i=0:5
    %ask user the launch angle, in degrees
    thetaDeg = input('enter launch angle in degrees above the horizontal (greater than 0): \n angle = ');
    thetaRad = degtorad(thetaDeg); %converting to radians

    %fnd initial velocity components by trig 
    v_0x = v_0 * cos(thetaRad);
    v_0y = v_0 * sin(thetaRad);


    %creating uniform time vector
    t = t_0:dt:t_f;

    %creating position vectors based on kinematic equations
    xPos = x_0 + v_0x*t; %no acceleration, ignoring air resistance
    yPos = y_0 + v_0y*t + (1/2)*(-g)*t.^2;

    %finding where particle will land (naive root finder) 
    root1 = (-v_0y + sqrt(v_0y^2 + 2*g*y_0))/(-g);%Together, these are the quadratic formula
    root2 = (-v_0y - sqrt(v_0y^2 + 2*g*y_0))/(-g);% 
    if (root1 > root2) %determines which root is greater; this is time when cannonball lands
        greaterRoot = root1;
    else
        greaterRoot = root2;
    end
    xHit = x_0 + v_0x*greaterRoot; %finds x position where cannonball hits ground

    %plotting trajectory
    hold on; %adds new trajectories to old plot
    plot(xPos,yPos)

    %check/tell user whether cannonball hit target
    if (xHit >= 140 && xHit <= 150)
        disp('You hit the target')
    else
        disp('You missed the target')
    end
end
