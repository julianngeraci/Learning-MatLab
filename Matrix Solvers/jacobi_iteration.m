function [rel_error,x]=jacobi_iteration(A,b,x0,maxIters, tol)
%test the error of the jacobi iteration
d=diag(A);
D=diag(d);
x=x0;

norm_b=norm(b);

rel_error=inf;
iter=1;
while rel_error > tol
    x_old=x;
    x=(b-(A-D)*x)./d;
    rel_error(iter)=norm(x-x_old)/norm_b;
    if iter > maxIters
        break
    end
    iter=iter+1;
end

end
