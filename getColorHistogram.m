%**************************************************************************
%              图像检索——提取颜色特征
%HSV空间颜色直方图(将RGB空间转化为HSV空间并进行非等间隔量化，
%将三个颜色分量表示成一维矢量，再计算其直方图作为颜色特征
%function : Hist = ColorHistogram(Image)
%Image       : 输入图像数据
%L         : 返回颜色直方图特征向量256维
%**************************************************************************
function L = getColorHistogram(Image)
    [M,N,~] = size(Image);
    [h,s,v] = rgb2hsv(Image);
    H = h; S = s; V = v;
    h = h * 360;
    L = zeros(M, N);
    
    %% 将hsv空间非等间隔量化
    %   h量化成16级
    for i = 1:M
        for j = 1:N
             if h(i,j)<=15||h(i,j)>345
                     H(i,j) = 0;
             elseif h(i,j)<=25
                     H(i,j) = 1;
             elseif h(i,j)<=45
                     H(i,j) = 2;
             elseif h(i,j)<=55
                     H(i,j) = 3;
             elseif h(i,j)<=80
                     H(i,j) = 4;
             elseif h(i,j)<=108
                     H(i,j) = 5;
             elseif h(i,j)<=140
                     H(i,j) = 6;
             elseif h(i,j)<=165
                     H(i,j) = 7;
             elseif h(i,j)<=190
                     H(i,j) = 8;
             elseif h(i,j)<=220
                     H(i,j) = 9;
             elseif h(i,j)<=255
                     H(i,j) = 10;
             elseif h(i,j)<=275
                     H(i,j) = 11;
             elseif h(i,j)<=290
                     H(i,j) = 12;
             elseif h(i,j)<=316
                     H(i,j) = 13;
             elseif h(i,j)<=330
                     H(i,j) = 14;
             elseif h(i,j)<=345
                     H(i,j) = 15;
             end
        end
    end
    
    %%   s量化成4级
    for i = 1:M
        for j = 1:N
             if s(i,j)<=0.15&&s(i,j)>0
                     S(i,j) = 0;
             elseif s(i,j)<=0.4
                     S(i,j) = 1;
             elseif s(i,j)<=0.75
                     S(i,j) = 2;
             elseif s(i,j)<=1
                     S(i,j) = 3;
             end
        end
    end
    
    %%   v量化成4级
    for i = 1:M
        for j = 1:N
            if v(i,j)<=0.15&&v(i,j)>0
                    V(i,j) = 0;
            elseif v(i,j)<=0.4
                    V(i,j) = 1;
            elseif v(i,j)<=0.75
                    V(i,j) = 2;
            elseif v(i,j)<=1
                    V(i,j) = 3;
            end
        end
    end
    
    %% 将三个分量合成为一维特征向量：
    % L = H*Qs*Qv+S*Qv+v；Qs,Qv分别是S和V的量化级数, L取值范围[0,255]
    % Qs = 4; Qv = 4
    for i = 1:M
        for j = 1:N
            L(i,j) = H(i,j)*16+S(i,j)*4+V(i,j);
        end
    end
end

