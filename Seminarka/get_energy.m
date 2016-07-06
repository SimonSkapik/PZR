function [ energy ] = get_energy( signal )
energy = log(sum(signal));
end

