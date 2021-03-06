%Simulation of baseball trajectory including drag, and Magnus forces. Home
%plate is 60ft from pitchers mound. 

%Intended to be run from MatLab; requires input from MatLab console. 

%Uses Runge-Kutta 2nd Order approximation method for the ODE. More info at http://en.wikipedia.org/wiki/Runge?Kutta_methods

%By: Russell J Phelan, 1/15/2015

clear all; close all;  

%prompting for user to input initial conditions
vx0f = input('Please enter initial x velocity in mph: ');
vy0f = input('Please enter initial y velocity in mph: ');
vz0f = input('Please enter initial z velocity in mph: ');
wHat = input('Please enter a unit vector in the direction of the axis of rotation using [x y z] notation: ');
freq = input('Please enter frequency of rotation in Hz: ');

dt = .0001;                % time step for Runge-Kutta algorithm
g  = 9.8;                  % acceleration due to gravity in m/s^2
m  = 0.145;                % baseball mass in kg
Cd = 0.29;                 % drag coefficient Cd
rho= .9846;                % density of air in kg/m^3
D  = 7.45/100.0;           % baseball diameter in m
R  = D/2;                  % baseball radius in m
A  = pi*(R^2);             % baseball cross-sectional area in m^2
Dm = .00065;               % coefficient for Magnus force 
t  = 0:dt:5;               % vector of times
N  = length(t);            % number of time steps

x0 = 0;   y0 = -.6;  z0 = 2.1336;                  % set initial position at origin in feet
vx0 = vx0f*.447; vy0 = vy0f*.447; vz0 = vz0f*.447; % set initial velocity in m/s
r = [x0 y0 z0];                                    % make position vector
v = [vx0 vy0 vz0];                                 % make velocity vector 
wMag = freq*2*pi;
w = wMag*wHat;                                     % make ang velocity vector from magnitude and unit vector

rkeep = zeros(N,3);        % store baseball positions in this Nx3 array
                           % where first column has x position vs. time
                           % second column has y position vs. time
                           % third colum has z pos vs. time
%Runge-Kutta loop
for i=1:N
   
   a = accel(v,Cd,rho,A,m,g,Dm,w);  % find acceleration from current pos, vel
   
   vmid = v + a*dt/2;            % find velocity at midpoint
   amid = accel(vmid,Cd,rho,A,m,g,Dm,w); % accel at midpoint depends on vmid
   
   r = r + vmid*dt;
   v = v + amid*dt;
   
   rkeep(i,:)=r;    % now store the position vector for plotting   
end

%converting from meters to feet
rkeep = rkeep*3.2808;

%creating stem plot to visualize trajectory
stem3(rkeep(1:200:end,1),rkeep(1:200:end,2),rkeep(1:200:end,3),'LineWidth',.1);
axis([0 60 -5 5 0 8]);
view(120,20);
xlabel('Distance from Plate (ft)');
zlabel('Height of Pitcher (ft)');
ylabel('Width (ft)');