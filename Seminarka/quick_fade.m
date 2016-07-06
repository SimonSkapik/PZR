function [ s ] = quick_fade( s )
	fade_in = (transpose(sin(([-10:2:9].*pi)./20))+1) ./ 2;
    fade_out = (transpose(cos(([1:2:20].*pi)./20))+1) ./ 2;

    s(1:10) = s(1:10) .* fade_in;
    s((length(s)-9):length(s)) = s((length(s)-9):length(s)) .* fade_out;
end

