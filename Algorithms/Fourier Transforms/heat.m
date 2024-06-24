function [u,t] = heat

t0 = 0; % initial time
tf = 5; % final time
N = 2^10; % Space resolution (no of grid points in x)
nu = 0.02; % diffusion coefficient
%h = (1.9/pi^2)*dx^2/nu; % time step
%nTsteps = ceil((tf-t0)/h);
left_endpoint = -pi;
right_endpoint = pi;
L = right_endpoint-left_endpoint; % length of domain

dx = L/N;
h = (1.9/pi^2)*dx^2/nu; % time step
nTsteps = ceil((tf-t0)/h);
x = left_endpoint + (0:(N-1))*dx;

u = sin(x) + cos(2*x) + 0.1*cos(33*x); % initial data

u_hat = fft(u);

m_nu_ksq = -nu*[0:(N/2),(-N/2+1):(-1)].^2; % minus nu times k^2

t = t0;
for n = 1:(nTsteps-1) % Time stepping
    k1 = rhs(t, u_hat, m_nu_ksq);
    k2 = rhs(t + (h/2), u_hat + (h/2)*k1, m_nu_ksq);
    k3 = rhs(t + (h/2), u_hat + (h/2)*k2, m_nu_ksq);
    k4 = rhs(t + h, u_hat + h*k3, m_nu_ksq);
    u_hat = u_hat + (h/6)*(k1 + 2*k2 + 2*k3 + k4);
    t = t + h;
    u = ifft(u_hat,'symmetric'); % inverse fourier transform, the symmetric tag is because we expect things to be real
    plot(x,u);
    axis([-pi,pi,-2,2]);
    drawnow;
end 
end % end of function heat

function z = rhs(t, u_hat, m_nu_ksq) % rhs = right hand side
   z = m_nu_ksq.*u_hat;
end
