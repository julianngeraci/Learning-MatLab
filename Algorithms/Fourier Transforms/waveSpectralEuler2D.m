function [u,t] = waveSpectralEuler2D
close all;
%clear all;
t0 = 0; % initial time
tf = 100; % final time
Nx = 2^7; % Space resolution (number of grid points in x)
Ny = Nx;
x_min = -pi; %periodic boundary conditions
x_max = pi;
y_min = -pi;
y_max = pi;
Lx= x_max-x_min; % length of domain
Ly= y_max-y_min;
dx = Lx/Nx;
c = 1;
x = x_min + (0:(Nx-1))*dx;
dy= Ly/Ny;
y = y_min + (0:(Ny-1))*dy;
CFL = 0.1; %CFL constant
dt = CFL*dx/c; %time step
num_times = length(t0:dt:tf);
t= t0;

u = zeros(Nx,Ny);%initialize u
v = zeros(Nx,Ny);%initialize v
for i = 1:Nx
    for j = 1:Ny
        u(i,j) = 3*sin(x(i))*cos(2*y(j))+sin(2*(x(i)+y(j))); % initial data
        v(i,j) = 0;
    end
end
u_max = max(u(:));
u_min = min(u(:));

u_hat = fftn(u);
v_hat = fftn(v);

%setting up picture
    pu= pcolor(x,y,ifftn(u_hat, 'symmetric'));
    shading interp;
    colorbar;
    colormap jet;
    axis('tight');
    axis('square');
    xlabel('x');
    ylabel('y');
    drawnow;


kx_sq = [0:(Nx/2),(-Nx/2+1):(-1)].^2;
ky_sq = [0:(Ny/2),(-Ny/2+1):(-1)].^2;

ksq=zeros(Nx,Ny);%initialize k^2

for i = 1:Nx  % computing k^2
    for j = 1:Ny
        normksq = kx_sq(i) + ky_sq(j);
        ksq(i,j) = normksq;
    end
end


for ti = 0:num_times
    if(mod(ti,5)==0)
        set(pu,'cdata',ifftn(u_hat,'symmetric'));
        clim([u_min,u_max]);
        drawnow;
    end

    u_hat = u_hat + dt*v_hat; %update u_hat
    v_hat = v_hat -  dt*c^2*ksq.*u_hat;%updat v_hat

    t= t+dt; %update time
end




