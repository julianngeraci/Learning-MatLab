% Feb 2

function [error, x] = gaussian_elimination(A,b)

N = length(b);

A_aug = [A,b]; % creates augmented matrix


% goal, get A to be upper triangular then use back substitution

for i = 1:(N-1) %counting the columns
    for j = (i+1):N
        ratio = A_aug(j,i)/A_aug(i,i);
        for k = 1:N+1
            A_aug(j,k) = A_aug(j,k) - ratio*A_aug(i,k);
        end
    end
end

% now A_aug is upper triangular, next is back substitution

x = zeros(N,1);
for i = N:-1:1
    x(i) = (A_aug(i,N+1) - A_aug(i, i+1:N)*x(i+1:N))/A_aug(i,i);
end

% error calculations
v = (b-A*x);
error=norm(v);