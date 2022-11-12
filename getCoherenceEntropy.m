function H_x = getCoherenceEntropy(img)
    %% 初始化
    bin = 256;                      %量化级数
    coherentPrec = 1;               %聚合像素阈值 
    
%     img = imread('suipian2_1.jpg'); % 读取图像
    
    %% 颜色聚合向量
    CCV = getCCV(img,coherentPrec,bin);
    
    %% 计算两幅图像的距离
    % D=0;  %两幅图像的距离
    % for i=1:bin
    %     m=abs(CCV1(1,i)-CCV2(1,i));
    %     N=abs(CCV1(2,i)-CCV2(2,i));
    %     d=m+N;
    %     D=D+d;
    % end

    %% 打印CCV
    % bar(CCV1','stacked');
    % figure;
    % bar(CCV2','stacked');

    %% 聚合信息熵
    H_x(1,1) = getEntropyFromDistribution(CCV(1,:));
    H_x(1,2) = getEntropyFromDistribution(CCV(2,:));

end


