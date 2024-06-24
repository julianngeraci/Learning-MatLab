clear vars
close all;

maxIters=50;

fh = figure;
set(fh,'units', 'normalized', 'position', [0,0,1,1]);%full screen
k=1;

for N = 10:10:90
    subplot(3,3,k);
    A=randn(N)+ N^2*eye(N);% NxN diagonally dominant matrix

    x_init=randn(N,1);
    x_exact=randn(N,1);
    b=A*x_exact;
    [error, x] = jacobi_iteration(A,b,x_init,maxIters,1e-16);

    semilogy(1:maxIters,error,LineWidth=2);
    legend('J')

    title(sprintf('N=%d', N));%string print format    
    k = k + 1;
end