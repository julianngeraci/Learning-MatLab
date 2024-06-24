function [rel_error,x]=steepestDescent(A,b,x0,tol)
%test the error of the steepest descent
x=x0;
r = b - A*x; % residual 

norm_b=norm(b);

rel_error=inf;
%iter=1;

while rel_error > tol
    p = A*r;
    alpha = ((r'*r)/(p'*r));
    %x_old = x;
    x = x + alpha*r;
    r = r - alpha*A*r;
    rel_error = (abs(alpha)*norm(r))/norm_b;
end

end
