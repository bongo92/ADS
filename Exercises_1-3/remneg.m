function [N] = remneg(M)
% This function should replace negative values of a matrix with zeros
% This function should get the Matrix M as an input and return the Matrix N as a result
% Do NOT use loops or if/else/switch commands! 
% Solve by logical matrix indexing
    M(M<0) = 0;
    N=M;
end

