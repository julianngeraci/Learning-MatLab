P0=2;
k=50;
r = 0.6;
logistic = @(t,P) r*P*(1-P/k);
[P,t] = RK2(logistic,0,60,P0,0.001); 

plot(t,P);
