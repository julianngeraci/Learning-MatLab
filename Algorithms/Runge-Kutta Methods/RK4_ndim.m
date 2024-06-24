function[x,t]  = RK4_ndim(f,t0,tf,y0,h)
t = t0:h:tf;
N = length(t);
dim = length(y0);
x = zeros(dim,N);
x(:,1) = y0;

for n = 1:N-1
 K1 = f(t(n),x(:,n));
 K2 = f(t(n)+(h/2),x(:,n)+(h/2)*K1);
 K3 = f(t(n)+(h/2),x(:,n)+(h/2)*K2);
 K4 = f(t(n)+h,x(:,n)+h*K3);
 x(:,n+1)= x(:,n)+(h/6)*(K1+2*K2+2*K3+K4);
end

end