clear all
close all;
clc


%%% Create Dictionary
dictionary = cell(2,80);
dict_ind = 0;
for word = 1:16
    for varianta = 1:5
        [s,fs] = wavread(strcat('./Sounds/povel_', num2str(word), '_', num2str(varianta), '.wav'));
        s = remove_offset(s);
        [~,~,cut] = get_word(s, fs);
        dict_ind = (word-1)*5+varianta;
        dictionary{1,dict_ind} = get_word_param_vector(cut, fs);
        switch word
            case 1
                dictionary{2,dict_ind} = 'polozit';
            case 2
                dictionary{2,dict_ind} = 'pouzit';
            case 3
                dictionary{2,dict_ind} = 'sebrat';
            case 4
                dictionary{2,dict_ind} = 'rozbit';
            case 5
                dictionary{2,dict_ind} = 'inventar';
            case 6
                dictionary{2,dict_ind} = 'kamera';
            case 7
                dictionary{2,dict_ind} = 'prikazy';
            case 8
                dictionary{2,dict_ind} = 'krumpac';
            case 9
                dictionary{2,dict_ind} = 'sekera';
            case 10
                dictionary{2,dict_ind} = 'lopata';
            case 11
                dictionary{2,dict_ind} = 'mec';
            case 12
                dictionary{2,dict_ind} = 'kladivo';
            case 13
                dictionary{2,dict_ind} = 'rano';
            case 14
                dictionary{2,dict_ind} = 'odpoledne';
            case 15
                dictionary{2,dict_ind} = 'vecer';
            case 16
                dictionary{2,dict_ind} = 'pulnoc';
        end
    end
end



% %%% Recognition
% 
% input = cell(1,3);
% input{1} = 3;
% input{2} = 'B';
% input{3} = 'SS';  
% 
% [s,fs] = wavread(strcat('./Sounds/',num2str(input{1}),input{2},'-',input{3},'.wav'));
% n = 1:size(s);
% %plot(n, s);
% s = remove_offset(s);
% %figure;
% %plot(n, s);
% [num,result] = match_word(dictionary,s,fs);
% 
% disp(strcat({'Rozpoznané slovo: '},num2str(num - 1),{' - '},result));
% 
% 
% sound(s,fs);
disp('Start speaking.');

buff_len = 48000;
buffer = zeros(buff_len,1);
recObj = audiorecorder(16000,16,1,0);
record(recObj);
count = 0;
while count < 100
    pause(1);
    pause(recObj);
    s = getaudiodata(recObj);
    resume(recObj);
    if(length(s) < buff_len)
        buffer((buff_len-length(s)+1):end) = s;
    else
        buffer = s((end-buff_len-1):end);
    end
    buffer = remove_offset(buffer);
    [start,staahp,cut] = get_word(buffer, 16000);
    if (start > 4000) && (staahp < (length(buffer) - 4000)) && (start < staahp)
%         figure;
%         subplot(2,1,1);
%         plot(buffer);
%         subplot(2,1,2);
%         plot(cut);
        [num,result] = match_word(dictionary,cut,fs);
        disp(strcat({'Rozpoznané slovo: '},num2str(num - 1),{' - '},result));
        fileID = fopen('word.txt','w');
        fprintf(fileID,'%s\n',result);
        fclose(fileID);
        stop(recObj);
        buffer = zeros(buff_len,1);
        record(recObj);

    end 
    %s = getaudiodata(recObj);
    %buffer = [buffer((length(s)+1):end) s];
    count = count + 1;
end  
stop(recObj);




%soundsc(buffer,16000);
%plot(buffer);

% % % recObj = audiorecorder(16000,16,1,0);
% % % 
% % % for indx = 1:1
% % % 
% % %     disp('Start speaking.');
% % %     recordblocking(recObj, 2);
% % %     disp('End of Recording.');
% % %     y = getaudiodata(recObj);
% % %     wavwrite(y,16000,strcat('povel_16_', num2str(indx), '.wav'));
% % %     
% % % end
    
%soundsc(cut);
%[num,result] = match_word(dictionary,s,fs);
%disp(strcat({'Rozpoznané slovo: '},num2str(num - 1),{' - '},result));






%new = change_ref_length([1 2 5 6 5 7 4 3 1;1 2 3 4 5 6 7 8 9], 8)