% 聚合信息熵
clc,clear,close all

% 从properties.txt读取参数
properties = importdata('properties.txt');
filePath = cell2mat(properties.textdata);
high = properties.data(1);
width = properties.data(2);
category_num = properties.data(3);

imgList = dir([filePath '*.jpg']);
num = length(imgList); 
H = zeros(num,2);
imgs = zeros(high,width,3,num);
% nums = [100	213	467	1000 2137 4677 10000];
%       1   2   3   4   5    6      7
% mean_time = zeros(7,0);
%% 
% for j = 1:1
%     num = min(nums(j),93);
    for k = 1:num
        imgs(:,:,:,k) = imread([imgList(k).folder '\' imgList(k).name]);
    end

    tic;
    for k = 1:num
        img = imgs(:,:,:,k);
        H(k,:) = getCoherenceEntropy(uint8(img(:,:,:)));
    %     CCV = getCCV(img,1,256);
    %     ICCV = getICCV(img,1,256);
    end
%     time(j) = toc;
% end

% sound(sin(2*pi*20*(1:4000)/100));
% mean_time = mean(time);

cluster = category_num;
opts = statset('Display','final');
[idx,C] = kmeans(H,cluster,'Distance','cityblock','Replicates',5,'Options',opts);

a = 1:1:num;
output = [a' idx];

columns = {'shardIndex','shardResult'};% 指定各列的列名
data = table(a', idx, 'VariableNames', columns); % 基于这些单独的变量创建一个table类型变量data

writetable(data,'output.csv')