function [u,t] = heat2D
close all;
t0 = 0; % initial time
tf = 5; % final time
Nx = 2^7; % Space resolution (no of grid points in x)
Ny = Nx;
nu = 0.02; % diffusion coefficient
h = 0.001; % time step
nTsteps = ceil((tf-t0)/h);
x_min = -pi;
x_max = pi;
y_min = -pi;
y_max = pi;
Lx= x_max-x_min; % length of domain
Ly= y_max-y_min;
dx = Lx/Nx;
%h = (1.9/pi^2)*dx^2/nu; % time step
%nTsteps = ceil((tf-t0)/h);
x = x_min + (0:(Nx-1))*dx;
dy= Ly/Ny;
y = y_min + (0:(Ny-1))*dy;
u = zeros(Nx,Ny);

for i = 1:Nx
    for j = 1:Ny     
        u(i,j) = sin(y(j)*x(i)) + cos(2*x(i)) + 1*cos(33*y(j))+randn; % initial data
    end
end

u_hat = fftn(u);

kx_sq = [0:(Nx/2),(-Nx/2+1):(-1)].^2;
ky_sq = [0:(Ny/2),(-Ny/2+1):(-1)].^2;

m_nu_ksq=zeros(Nx,Ny);

for i = 1:Nx
    for j = 1:Ny     
        normksq = kx_sq(i) + ky_sq(j);
        m_nu_ksq(i,j) = -nu*normksq; % minus nu times k^2
    end
end

t = t0;
for n = 1:(nTsteps-1) % Time stepping
    k1 = rhs(t, u_hat, m_nu_ksq);
    k2 = rhs(t + (h/2), u_hat + (h/2)*k1, m_nu_ksq);
    k3 = rhs(t + (h/2), u_hat + (h/2)*k2, m_nu_ksq);
    k4 = rhs(t + h, u_hat + h*k3, m_nu_ksq);
    u_hat = u_hat + (h/6)*(k1 + 2*k2 + 2*k3 + k4);
    t = t + h;
    if mod(n,30) == 1
        u = ifftn(u_hat,'symmetric'); % inverse fourier transform, the symmetric tag is because we expect things to be real
        pcolor(x,y,u);
        shading interp;
        axis([-pi,pi,-pi,pi]);
        drawnow;
    end
end 
end % end of function heat

function z = rhs(t, u_hat, m_nu_ksq) % rhs = right hand side
   z = m_nu_ksq.*u_hat;
end
