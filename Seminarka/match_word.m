function [ index, word ] = match_word( dictionary, signal, fs )
    [~,~,cut] = get_word(signal, fs);
    word_params = get_word_param_vector(cut, fs);
    diff = zeros(1,size(dictionary,2));
    for indx = 1:size(dictionary,2);
        dix_word = dictionary{1,indx};
        mod_dix_word = change_ref_length(dix_word,size(word_params,2));
        diff(indx) = sum(sum(abs(mod_dix_word - word_params)));
    end
    [~,order] = sort(diff);
    index = order(1);
    
    n = 1:size(word_params,2);
% % % %	figure;
% % %     plot(n, word_params(1,:));
% % %     hold on
% % %     plot(n, word_params(2,:));
% % %     hold on
    dix_word = dictionary{1,index};
    mod_dix_word = change_ref_length(dix_word,size(word_params,2));
% % %     plot(n, mod_dix_word(1,:), 'r');
% % %     hold on
% % %     plot(n, mod_dix_word(2,:), 'r');    
% % %     hold off
    word = dictionary{2,index};

end

