function [u,t] = waveSpectralEuler2D2
Nx = 512;
Ny  = 512;
Lx  = 1e2;
Ly  = 1e2;
dx=Lx/Nx;
dy=Ly/Ny;
x=dx*(1:Nx)';
y=dy*(1:Ny)';
[xx,yy]=meshgrid(x,y);
dk = 2*pi/Lx;
dl = 2*pi/Ly;
k = [0:Nx/2 -Nx/2+1:-1]'*dk;
l = [0:Ny/2 -Ny/2+1:-1]'*dl;
[kk,ll]=meshgrid(k,l);
kksh=fftshift(kk);
llsh=fftshift(ll);
kmag=sqrt(kk.^2+ll.^2);
myfilt=exp(-(kmag/3).^2);
kmag=sqrt(kk.^2+ll.^2);
kmagv=kmag(:);
rr=sqrt((xx-0.5*Lx).^2+(yy-0.5*Ly).^2);
myf=exp(-(rr/(0.2*Lx)).^2).*sin(2*pi*xx/(0.1*Lx)).*sin(2*pi*yy/(0.05*Ly))+randn(size(xx))*0.0001;
myspec=abs(fft2(myf));
myspecsh=fftshift(myspec);
myspecv=myspec(:);
figure(1)
clf
pcolor(xx,yy,myf)
shading interp,colorbar
title('function')
