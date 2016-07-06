function [ new_signal ] = remove_offset( signal )

    for_signal = zeros(size(signal,1),1);
    for indx = 2:size(signal,1)
        for_signal(indx) = signal(indx) - 0.97*signal(indx-1);
        if signal(indx) > 0
            if signal(indx) < 0.0015
                for_signal(indx) = for_signal(indx) - 0.0005;
            end
        else
            if signal(indx) > -0.0015
                for_signal(indx) = for_signal(indx) + 0.0005;
            end
        end
    end
    %%new_signal = medfilt1(for_signal,3);
    new_signal = for_signal;
end

