function [rel_error,x]=gauss_seidel(A,b,x0,maxIters, tol)
%test the error of the jacobi iteration
d=diag(A);
%D=diag(d);
x=x0;
N=length(b);
norm_b=norm(b);

rel_error=inf;
iter=1;
while rel_error > tol
    x_old=x;
    for i= 1:N
        x(i)=(b(i) - A(i,[1:(i-1),(i+1):N])*x([1:(i-1),(i+1):N]))/A(i,i);
    end     
    %x=(b-(A-D)*x)./d;
    rel_error(iter)=norm(x-x_old)/norm_b;
    if iter > maxIters
        break
    end
    iter=iter+1;
end

end