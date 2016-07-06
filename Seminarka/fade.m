function [ s ] = fade( s )
	fade_in = (transpose(sin(([-100:2:99].*pi)./200))+1) ./ 2;
    fade_out = (transpose(cos(([1:2:200].*pi)./200))+1) ./ 2;

    s(1:100) = s(1:100) .* fade_in;
    s((length(s)-99):length(s)) = s((length(s)-99):length(s)) .* fade_out;
end