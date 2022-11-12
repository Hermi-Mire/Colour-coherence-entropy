%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function CCV = getCCV(img,coherentPrec, numberOfColors)
%颜色聚合向量
%====================
%颜色聚合向量是一种基于颜色的图像检索
%getCCV function takes an image and return the Color Coherence Vector that describe this Image. You can compare images using this vector.
%
%Input:
%img : The Image (3-channel Image)
%
%Optional Input:
%coherentPrec: 设定一个阈值（一般取为图像总像素的1%）
%numberOfColors:量化，将0～255的区间量化为numberOfColors个颜色小区间 (default = 27 colors). 
%				Note it'll be changed a little bit to ensure the same different values for RGB channel
%
%Output :
%CCV: a (2*numberOfColors) matrix represents your image. This can be used for matching.


%Cite As Tarek Badr (2022). Color Coherence Vector (https://github.com/TarekVito/ColorCoherenceVector), GitHub. Retrieved March 29, 2022.
%https://github.com/TarekVito/ColorCoherenceVector
%https://owlcation.com/stem/Image-Retrieval-Color-Coherence-Vector
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
function CCV = getCCV(img, coherentPrec, numberOfColors)
    if ~exist('coherentPrec','var')
        coherentPrec = 1;
    end
    if ~exist('numberOfColors','var')
        numberOfColors = 27;
    end
    CCV = zeros(2,numberOfColors);
    imgSize = (size(img,1) * size(img,2));
    thresh = int32((coherentPrec / 100) * imgSize);%聚合的阈值

    %% 高斯滤波
    Gaus = fspecial('gaussian',[5 5],2);
    img = imfilter(img,Gaus,'same');

    %% 量化
%     [img, updNumOfPix]= discretizeColors(img,numberOfColors);  
    img= getColorHistogram(img);
    updNumOfPix = numberOfColors;
    histcounts(img,updNumOfPix,'BinLimits',[0,255]);

    %% 遍历离散级数（并行计算）
    for i = 0:updNumOfPix - 1    
        BW = img == i;            % 二值化
        CC = bwconncomp(BW);    %查找二值图像中的连通分量
        compsSize = cellfun(@numel, CC.PixelIdxList);    %各个分量计数
        coherent = sum(compsSize(compsSize >= thresh)); %选择聚合分量（数量大于阈值的分量）
        CCV(:,i+1) = [coherent; sum(compsSize) - coherent];
    end

end
