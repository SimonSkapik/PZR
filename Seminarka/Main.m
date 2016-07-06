clear all;
close all;
clc;


%%% Create Dictionary
dictionary = cell(2,10);
for word = 1:10
    [s,fs] = wavread(strcat('./Sounds/',num2str(word-1),'A-SS.wav'));
    s = remove_offset(s);
    [~,~,cut] = get_word(s, fs);
    dictionary{1,word} = get_word_param_vector(cut, fs);
    switch word
        case 1
            dictionary{2,word} = 'Nula';
        case 2
            dictionary{2,word} = 'Jedna';
        case 3
            dictionary{2,word} = 'Dva';
        case 4
            dictionary{2,word} = 'Tri';
        case 5
            dictionary{2,word} = 'Ctyri';
        case 6
            dictionary{2,word} = 'Pet';
        case 7
            dictionary{2,word} = 'Sest';
        case 8
            dictionary{2,word} = 'Sedm';
        case 9
            dictionary{2,word} = 'Osm';
        case 10
            dictionary{2,word} = 'Devet';
    end
end

recObj = audiorecorder;

disp('Start speaking.');
recordblocking(recObj, 2);
disp('End of Recording.');

fs = 8000;
s = getaudiodata(recObj);
n = 1:size(s);
%plot(n, s);
s = remove_offset(s);
%figure;
%plot(n, s);
[num,result] = match_word(dictionary,s,fs);

disp(strcat({'Rozpoznané slovo: '},num2str(num),{' - '},result));


play(recObj);