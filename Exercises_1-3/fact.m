function p = fact(n)
% FACT Returns the faculty of a nonnegative integer value.
% FACT(n) computes the faculty of n, which has to be a nonnegative integer
% value.
% consider the cases: negative integer, scalar and decimals and return a
% warning when the condistion for falculty calculation is violated
if (n<0)
    error('Input is negative');
elseif((mod(0,1)) ~= 0)
        error('Input is negative');
else
    z = 1:1:n;
    p = prod(z);
end