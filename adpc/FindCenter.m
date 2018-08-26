function [XC,centers,Count] = FindCenter(dc,X,R,RInd)
    num = size(X,1);
    x = [X zeros(num,1)];
    %ȷ����������,�������Ա��
    %����R������ǰ��仯��С����gama
    Rsort = sort(R,1,'descend');
    gama = zeros(num,1);
    gama(1) = 0;
    for i=1:num-1
        gama(i) = abs(Rsort(i)-Rsort(i+1));
    end
    [G GInd]= sort(gama,1,'descend'); % GIndΪ���ݰ���gama�������к���ֵ
    gmeans = mean(G(2:num));
    gInd  = find(gama>gmeans); %��ȡgamaֵ����ƽ��ֵ�����ݵ���Ϊ���ƾ�������
    k = size(gInd,1);
    GInd = GInd(1:k,:);
    xIndex = RInd(GInd); %�ҵ����ƾ������ĵ�����ֵ
    m=x(xIndex,:); %�洢���ƾ������ĵ�
    %PlotSolution(X, [m(:,1:2) ones(size(m,1),1)],1);
    %�����������֮��ľ��룬ȷ���������
    CenterD = pdist2(m(:,1:2),m(:,1:2));
    cnum = 1;
    count = 0;%��ʼ���������ĸ���
    for i=1:k
        minid = find(CenterD(i,:)<2*dc);
        if ~m(i,3)
            count = count +1;
            if isempty(minid)
                m(i,3) = cnum;
            else
                m(minid,3) = cnum;
            end
            cnum = cnum +1;
        end
    end
    x(xIndex,3) = m(:,3);
    centers = m;
    Count = count;
    XC = x;
end

