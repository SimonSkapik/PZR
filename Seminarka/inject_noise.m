function [ signal ] = inject_noise( signal )

    for indx = 1:size(signal,1)
        signal(indx,1) = (signal(indx,1) + ((rand*0.000001+0.0000001)*sign(rand-0.5)))+0.0000001;
    end

end

