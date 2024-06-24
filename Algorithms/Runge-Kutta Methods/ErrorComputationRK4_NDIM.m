close all; clear all;
f= @(t,x) -t*x^2;
y0=1;
h=0.001;
t0=0;
tf=5;

h_vals=logspace(-3,0,10);

error = zeros(length(h_vals));

i=1; 
for h = h_vals
    [x,t]  = RK4_ndim(f,t0,tf,y0,h);
    y_exact = 2./(2+t.^2);
    error(i) = norm(x-y_exact);
    i=i+1;
end

loglog(h_vals,error,'-o')
% hold on;
% plot(t,y_exact,'o');