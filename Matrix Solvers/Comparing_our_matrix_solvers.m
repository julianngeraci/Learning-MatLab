clear vars
close all

maxIters = 9000000; % how many times we iterate before terminating, in case it never converges
initialSize=100;
step=100;
M=9; %number of steps
sizeVector=linspace(initialSize,(M-1)*step+initialSize,M); %making a vector of our matrix sizes for graphing purposes

jacobiError=zeros(1,M); %initialize a bunch of empty vectors for later use
gsError=zeros(1,M);
geError=zeros(1,M);
MATLABError=zeros(1,M);
sdError=zeros(1,M);
jacobiSpeed=zeros(1,M);
gsSpeed=zeros(1,M);
geSpeed=zeros(1,M);
MATLABSpeed=zeros(1,M);
sdSpeed=zeros(1,M);



for k = 1:M %loop through a bunch of different matrix sizes; M total iterations
    N=initialSize+step*(k-1); %the size N is a linear function of the index k; the minus one is due to indexing starting at 1
    A = randn(N,N); % generate a random square matrix. We then make it positive by taking A^T A
    A = A'*A+100*N*eye(N); %if we add something big to the diagonal, the matrix becomes SDD and our theorem from Jan 26 applies
    x_init = randn(N,1);
    x_exact =  randn(N,1);
    b = A*x_exact; %manufacture an exact solution

    %for each method, we apply the solver inside a tic/toc for timing and store the error and timing in a vector for plotting purposes
    %note that we use relative error, which just means we divide by the
    %length of b

    tic
    xGE=gaussianElimination(A,b);
    geError(k)=norm(xGE-x_exact);
    geSpeed(k)=toc;

    tic
    xMATLAB=linsolve(A,b);
    MATLABError(k)=norm(xMATLAB-x_exact);
    MATLABSpeed(k)=toc;

    tic
    xJ = jacobi_iteration(A,b,x_init, maxIters,MATLABError(k)/norm(b));
    jacobiError(k)=norm(xJ-x_exact);
    jacobiSpeed(k)=toc;

    tic
    xGS=gauss_seidel(A,b,x_init, maxIters,MATLABError(k)/norm(b));
    gsError(k)=norm(xGS-x_exact);
    gsSpeed(k)=toc;

    tic
    xSD=steepestDescent(A,b,x_init,MATLABError(k)/norm(b));
    sdError(k)=norm(xSD-x_exact);
    sdSpeed(k)=toc;
end

%now we plot the error and the timing

figure(1);
plot(sizeVector,jacobiError,sizeVector,gsError,sizeVector,sdError,sizeVector,geError,sizeVector,MATLABError,'linewidth',2)
legend('J','GS', 'SD','GE','M')
title('Error')

figure(2);
plot(sizeVector,jacobiSpeed,sizeVector,gsSpeed,sizeVector,sdError,sizeVector,geSpeed,sizeVector,MATLABSpeed,'linewidth',2)
legend('J','GS', 'SD','GE','M')
title('Timing')

% figure(2);
% plot(sizeVector,jacobiSpeed,sizeVector,gsSpeed,sizeVector,MATLABSpeed,'linewidth',2)
% legend('J','GS','M')
% title('Timing')

% For diagonally dominant matrices up to size ~N=1500, looks like J and GS
% both slightly outperform M.

%for strictly diagonally dominant, symmetric strictly positive definite
%matrices up to about N=1000, it seems steepest deswcent is the fastest, with error similar to
%matlab's built in linsolve.
