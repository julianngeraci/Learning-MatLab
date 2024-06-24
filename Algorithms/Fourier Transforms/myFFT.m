function f = myFFT(f)

% Test with:
% N= 2^16; f=randn(N,1); tic; f_test=myFFT(f); toc;
% tic; f_matlab=fft(f); toc; norm(f_test-f_matlab)

N = length(f);

if N==1
    return; %just keep the value of f as is 
end


f_even = myFFT(f(1:2:N));
f_odd = myFFT(f(2:2:N));

%Compute Coefs Alphas and Betas (???)

for j = 1 :(N/2)%reconstruct the polynomial
    E = exp(-2*1i*(j-1)/N);
    f = [f_even + E.*f_odd, f_even - E.*f_odd]; % it think that this is right for what we want according to Wikipedia bc i didnt take good notes : ( 
end

