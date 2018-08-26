clc;
clear;
close all;
 
%% Ҫ���������
% X1 =[5.1,3.5,1.4,0.2;
% 4.9,3.0,1.4,0.2;
% 4.7,3.2,1.3,0.2;
% 4.6,3.1,1.5,0.2;
% 5.1,3.7,1.5,0.4;
% 4.6,3.6,1.0,0.2;
% 5.1,3.3,1.7,0.5;
% 5.0,3.6,1.4,0.2;
% 5.4,3.9,1.7,0.4;
% 4.6,3.4,1.4,0.3;
% 5.0,3.4,1.5,0.2;
% 4.4,2.9,1.4,0.2;
% 4.9,3.1,1.5,0.1;
% 5.4,3.7,1.5,0.2;
% 4.8,3.4,1.6,0.2;
% 4.8,3.0,1.4,0.1;
% 4.3,3.0,1.1,0.1;
% 5.8,4.0,1.2,0.2;
% 5.7,4.4,1.5,0.4;
% 5.4,3.9,1.3,0.4;
% 5.1,3.5,1.4,0.3;
% 5.7,3.8,1.7,0.3;
% 5.1,3.8,1.5,0.3;
% 5.4,3.4,1.7,0.2;
% 6.4,3.2,4.5,1.5;
% 6.9,3.1,4.9,1.5;
% 5.5,2.3,4.0,1.3;
% 6.5,2.8,4.6,1.5;
% 5.7,2.8,4.5,1.3;
% 6.3,3.3,4.7,1.6;
% 4.9,2.4,3.3,1.0;
% 4.9,2.4,3.3,1.0;
% 6.6,2.9,4.6,1.3;
% 5.2,2.7,3.9,1.4;
% 5.0,2.0,3.5,1.0;
% 5.9,3.0,4.2,1.5;
% 6.0,2.2,4.0,1.0];

%test Sample data
% X1 =[0,0,1,2;
%     0,0,2,3;
%     0,0,6,8;
%     0,0,8,9
%     0,0,15,15];
%
% X=X1(:,3:4);

data = load('E:\0\lw\workplace1\dataset\Aggregation.mat');
%data = load('E:\0\lw\workplace1\dataset\Spiral.mat');
%data = load('E:\0\lw\workplace1\dataset\D31.mat');
 X = data.A;
%data = load('mydata.mat');
%X = data.X;

 
%%KNN k distance graph, to determine the epsilon
A=X;
numData=size(A,1);
Kdist=zeros(numData,1);
%���������������ҳ������һ�����������k�����Լ���������IDX
[IDX,Dist]=knnsearch(A(2:numData,:),A(1,:));
Kdist(1)=Dist;
%�������ÿ���������������������k�����Լ���������IDX
for i=2:size(A,1)
    [IDX,Dist] = knnsearch(A([1:i-1,i+1:numData],:),A(i,:));
    Kdist(i)=Dist;
end
%������������򲢻�ͼ���ҳ����ұ仯�ĵ����������ΪDBSCAN�е�һ������
[sortKdist,sortKdistIdx]=sort(Kdist,'descend');
distX=[1:numData]';
plot(distX,sortKdist,'r+-','LineWidth',2);
set(gcf,'position',[1000 340 350 350]);
grid on;
 
%% ����DBSCAN�����㷨
%Aggregation
epsilon= 1.7;
MinPts=  7;
%Spiral
% epsilon= 1.8;
% MinPts=  2;
%mydata
% epsilon= 0.8;
% MinPts=  10;
%D31
% epsilon= 1.5;
% MinPts=  10;
IDX1=DBSCAN(X,epsilon,MinPts);
%% ����������
figure;
PlotClusterinResult(X, IDX1);
title(['DBSCAN Clustering (\epsilon = ' num2str(epsilon) ', MinPts = ' num2str(MinPts) ')']);
set(gcf,'position',[30 -10 500 500]); 

