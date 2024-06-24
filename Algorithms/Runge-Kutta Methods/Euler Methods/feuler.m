function[y,t]  = feuler(f,t0,tf,y0,h)
t = t0:h:tf;
N = length(t);
y = zeros(1,N);
y(1) = y0;

for n = 2:N
 y(n) = y(n-1)+ h*f(t(n-1),y(n-1));   
end

end