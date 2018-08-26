function [ Rand ] = CalculateRand(ind1,ind2)
    %����ÿһ�����ݵ�
    n = size(ind2,1);
    SS = zeros(n,1);
    SD = zeros(n,1);
    DS = zeros(n,1);
    DD = zeros(n,1);
    %���ݾ���������
    [~,datanum] = sort(zeros(n,1),1);
    num1 = [ind1 datanum];
    num2 = [ind2 datanum];
    for i=1:n-1
        S = findSamaeCluater(ind1,i,num1); %i���ݵ�֮������������ͬһ��ĵ�
        Si = findSamaeCluater(ind2,i,num2); %ʵ�ʾ�����i���ݵ�֮������������ͬһ��ĵ�
        D = findDefCluater(ind1,i,num1);
        Di = findDefCluater(ind2,i,num2);
        %����S��Si�е���ͬ�����
        sam = intersect(S,Si);
        def = intersect(D,Di);
        SS(i,1) = size(sam,1);
        SD(i,1) = size(Si,1)-size(sam,1);
        DS(i,1) = size(S,1) - size(sam,1);
        DD(i,1) = size(def,1);
    end
    %Ѱ������i��n-i����������ͬһ���
    function resultInd =findSamaeCluater(ind,i,num)
        inum = num(i+1:n,:);
        cind = find(inum(:,1)==ind(i));
        %i�����i�����ݵ���ͬһ�����е������������ֵiInd
        iInd = cind;
        for k = 1:size(iInd,1)
            iInd(k) = inum(cind(k),2);
        end
        resultInd = iInd;
    end
    %Ѱ������i��n-i�����в�����ͬһ���
    function resultInd =findDefCluater(ind,i,num)
        inum = num(i+1:n,:);
        cind = find(inum(:,1)~=ind(i));
        %i�����i�����ݵ���ͬһ�����е������������ֵiInd
        iInd = cind;
        for k = 1:size(iInd,1)
            iInd(k) = inum(cind(k),2);
        end
        resultInd = iInd;
    end
    Rand = (sum(SS)+sum(DD))/(sum(SS)+sum(DD)+sum(SD)+sum(DS));
end

