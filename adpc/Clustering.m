function [CInd] = Clustering(XC,D,P)
    num = size(XC,1);
    x = XC;  
    hold on;
    %���ܶȾ������Խ�������
    [p pind] = sort(P,1,'descend');
    for i=1:num
        %�����ݵ���ܶȴӴ�С���д���
        if x(pind(i),3)==0
            disp(num2str(pind(i)));
            ClusterOthers(D,P,pind(i));
        end
    end
    
    function ClusterOthers(D,P,ind)
        near = ind; %��Ѱ�������ĵĵ�
        while 1
            [n,~] = find(P>P(near));
            if isempty(n)
                [~, di]=sort(D(ind,Cen(:,3)));
                x(ind,3) = Cen(di(1),3);
                break;
            end
            d=[D(n,near) n];
            [~,qSort] = sort(d(:,1),1);
            q=d(qSort(1),2); %ȡ����������ֵ
            % [~,q] =find(Dist(near,:)==min(Dist(near,n)));
            if x(q,3) %���ý��ڵ�Ϊ��������
                x(ind,3) = x(q,3);
                break;
            else
                near = q;
            end
        end
    end
    CInd = x(:,3);
end

