function [ crosses ] = get_zero_crosses( signal )
signs = sign(signal);
crosses = (sum(abs(signs(2:end) - signs(1:(end-1)))))/2;
end

