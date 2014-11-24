% function to compute acceleration given velocity

function a = myaccel(v,Cd,rho,A,m,g)

vtemp = [v(1) v(2)];
vmag  = norm(vtemp);

Ftemp = [-0.5*Cd*rho*A*vmag*v(1), -0.5*Cd*rho*A*vmag*v(2) - m*g];
a = Ftemp/m;

return