function [ param_vector ] = get_word_param_vector( signal, fs )

    frame_size = fs/20;
    subframe_size = frame_size/2;
    subframes_count = idivide(int32(size(signal,1)), int32(subframe_size));
    frames_count = subframes_count - 1;
    
    signal = (signal.*(2^15));
    signal_energy = signal.*signal;
    
    param_vector = zeros(2,frames_count);
    
    for indx = 0:(frames_count-1)
        from = ((indx*subframe_size)+1);
        to = from + frame_size - 1;
        param_vector(1,(indx+1)) = get_energy(signal_energy(from:to))*2;
        param_vector(2,(indx+1)) = get_zero_crosses(signal(from:to));
    end
    
end

