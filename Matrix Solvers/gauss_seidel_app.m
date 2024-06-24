clear vars
close all;

maxIters=50;

fh = figure;
set(fh,'units', 'normalized', 'position', [0,0,1,1]);%full screen
k=1;

for N = 10:10:90
    subplot(3,3,k);
    A=randn(N)+ N*eye(N);% NxN diagonally dominant matrix

    x_init=randn(N,1);
    x_exact=randn(N,1);
    b=A*x_exact;
    [errorGS, x] = gauss_seidel(A,b,x_init,maxIters,1e-16);
    [errorJ, x] = jacobi_iteration(A,b,x_init,maxIters,1e-16);
    semilogy(errorGS,'-o','LineWidth',2);
    hold on;
    semilogy(errorJ,'LineWidth',1);
    
    legend('GS','J');
   
    title(sprintf('N=%d', N));%string print format    
    k = k + 1;
end