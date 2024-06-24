function[y,t]  = RK2(f,t0,tf,y0,h)
t = t0:h:tf;
N = length(t);
y = zeros(1,N);
y(1) = y0;

for n = 1:N-1
 K1 = f(t(n),y(n));
 K2 = f(t(n+1),y(n)+h*K1);
 y(n+1)= y(n)+(h/2)*(K1+K2);
end

end