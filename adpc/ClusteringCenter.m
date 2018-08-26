function [E,z,zSort,zInd Dc ] = ClusteringCenter( s,X,D)
%% ����ÿһ�����ݵ���ܶ��Լ��ϴ��ܶ���С����
    num =size(X,1);    
    %����ضϾ���
    Dnum = round(s*num*(num-1)*0.5);
    dist=[];
    for i=1:num
        dist =[dist;D(i+1:num,i)];
    end
    [d,dinx] = sort(dist);
    DC = [d dinx];
    dc = d(dinx(Dnum));
    dc = 0.8;
    %���ݼ��ܶȾ���
    P = zeros(num,1);
    rho = zeros(num,1);
%     for i=1:num-1
%       for j=i+1:num
%          rho(i)=rho(i)+exp(-(D(i,j)/dc)*(D(i,j)/dc));
%          rho(j)=rho(j)+exp(-(D(i,j)/dc)*(D(i,j)/dc));
%       end
%     end

%     ����ֲ��ܶ�
%     for i=1:num
%         lind = find(D(:,i)<dc);
%         local = D(i,lind);
%         drho = (1/dc)*local;
%         a=0;
%         for j=1:size(lind)
%             a =a+ exp(-drho(j).^2);
%         end
%         rho(i) = a;
%     end
%     P = rho;
%    DMeans =D/max(max(D));
    for i=1:num
        p = 0;
        for j=1:num
            p =p + exp(-((D(i,j)/dc).^2));
        end
        P(i) = p;
    end
    %�ϴ��ܶ���С�������
    MinD = zeros(num,1);
    for i=1:num
        MPInd = find(P>P(i));
        if(size(MPInd)>0)
            MinD(i) = min(D(i,MPInd));
        else
            MinD(i) = max(D(i,:));
        end
    end
    %���ݵ���ܶȺͽϴ��ܶ���С����ĳ˻�
    R = MinD.*P;
    R = R/max(R);
    figure(1);
    plot(1:num,R,'r+-','LineWidth',2);
    [RSort,RInd] = sort(R,1,'descend');
    E = P;
    z = R;
    zSort = RSort;
    zInd = RInd;
    Dc =dc;
    %plot(RInd',RSort,'o','color','red');
end

