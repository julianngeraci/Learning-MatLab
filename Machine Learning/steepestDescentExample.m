% Gradient Descent 
 
n = 2; %size of matrix
 
%A = randn(n); 
%b = randn(n,1); 
%x0 = randn(n,1); 
 
% Temporarily hardcode values 
dumb = [1 2; 3 4];
A = dumb'*dumb; 
b = [2;1]; 
x0 = [1;1]; 
 
answer = inv(A)*b; 
 
eps = 0.0000000000000001; 
maxIters = 100; 
%a = zeros(1,maxIters);
%x_store = zeros(n,maxIters); 
%x(1,:) = x0; 
 
r = b - A*x0; 
x=x0; 
 
x_store = zeros(n,maxIters); 
r_store = zeros(n,maxIters); 
rel_error_store = zeros(1,maxIters); 
 
 
for k=1:maxIters
    
    x_store(:,k) = x; 
    r_store(:,k) = r; 
    
    x_old = x; 
    r_old = r; 
    Ar = A*r; 
    
    a = (r'*r)/(Ar'*r); 
    
    x = x + a*r; 
    r = r - a*Ar; 
    
    rel_error = norm(x - x_old)/norm(b); 
    rel_error_store(1,k) = rel_error; 
    
    if rel_error < eps
        break
    end 
end 
 
semilogy(1:maxIters,rel_error_store)