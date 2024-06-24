%Jacobi iteration 
rng(0);
%======Set up========
maxIters=5000;
N=3;
A=randn(N)+ N^2*eye(N);% NxN matrix
D=zeros(N,N);%initialize

for i=1:N
    d(i)=A(i,i);%vector
    D(i,i)=A(i,i);%creating the matrix of the diagonal entries of A
end

x_exact=randn(N,1);%correct answer
b=A*x_exact;

x=randn(N,1); %initial guesss

%===== Iteration======

for k=1:maxIters
    x = x + (b - A*x)./d; % component wise operatoins use a . before/ update to new x
    error(k)=norm(x-x_exact);
end    
semilogy(1:maxIters, error);
%plot (log(1:maxIters),log(error))