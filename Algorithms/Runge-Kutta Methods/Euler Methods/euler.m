function[y,t]  = feuler(f,t0,tf,y0,h)
t = t0:h:tf;
N = length(f);
y = zeros(1,N);
y(1) = y0;

for n = 1 : N
 y(n+1) = y(n)+ h*f(tf,y(n));   
end

end