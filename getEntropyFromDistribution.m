function H_x = getEntropyFromDistribution(nk)
    length = size(nk, 2);
    Ps = zeros(length);
    H_x = 0;

    if sum(nk) == 0 %序列为零，返回不存在的熵值
        H_x = log2(length) + 1;
        return
    end

    for k = 1:length  %循环
        Ps(k) = nk(k) / sum(nk); %计算每一个像素点的概率
        if Ps(k) ~= 0 %如果像素点的概率不为零
            H_x = -Ps(k) * log2(Ps(k)) + H_x; %求熵值的公式
        end
    end
end