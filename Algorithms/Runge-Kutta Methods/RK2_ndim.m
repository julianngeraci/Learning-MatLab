function[x,t]  = RK2_ndim(f,t0,tf,y0,h)
t = t0:h:tf;
N = length(t);
dim = length(y0);
x = zeros(dim,N);
x(:,1) = y0;

for n = 1:N-1
 K1 = f(t(n),x(:,n));
 K2 = f(t(n+1),x(:,n)+h*K1);
 x(:,n+1)= x(:,n)+(h/2)*(K1+K2);
end

end