function [start,stop,cut_word] = get_word( input_word, fs )
    frame_size = fs/20;
    subframe_size = frame_size/2;
    subframes_count = idivide(int32(size(input_word,1)), int32(subframe_size));
    work_input_word = input_word(1:subframes_count*subframe_size);
    frames_count = subframes_count - 1;
    thold = 70;
    work_input_word = (inject_noise(work_input_word).*(2^15));
    signal_energy = work_input_word.*work_input_word;

    
    [~,mi] = sort(signal_energy);
    low10index = mi(1:frame_size);
    high10index = mi(end-(frame_size-1):end);
    low_e = get_energy(signal_energy(low10index));
    high_e = get_energy(signal_energy(high10index));

    limit_e = low_e + (high_e - low_e)*(thold/100);
    frame_vectors = zeros(1,frames_count);
    frame = zeros(frame_size,1);
    for indx = 0:(frames_count-1)
        from = ((indx*subframe_size)+1);
        to = from + frame_size - 1;
        frame_vectors(1,(indx+1)) = get_energy(signal_energy(from:to));
    end
    start = (find(frame_vectors(1,:) >= limit_e,1,'first')-1)*subframe_size + 1;
    stop = (find(frame_vectors(1,:) >= limit_e,1,'last')-1)*subframe_size + frame_size;
    cut_word = fade(input_word(start:stop));
end

