function [x,minf]=SimpleMthd(A,c,b,baseVector)  %%单纯形求解线性规划
%约束矩阵：A;
%目标函数系数向量：c;
%约束右端向量：b;
%初始基向量：baseVector
%目标函数取最小值时的自变量值：x;
%目标函数的最小值：minf

sz=size(A);%约束矩阵行数、列数
nVia=sz(2);
n=sz(1);
xx=1:nVia;
nobase=zeros(1,1);
m=1;

if c>=0
    vr=find(c~=0,1,'last');
    rgv=inv(A(:,(nVia-n+1):nVia)*b;
    if rgv>=0
        x=zeros(1,vr);
        minf=0;
    else
        disp('不存在最优解');
        x=NaN;
        minf=NaN;
        return;
    end
end

for i=1:nVia
    if (isempty(find(baseVector==xx(i),1)))%获取非基变量下标
        nobase(m)=i;
        m=m+1;
    end
end
bCon=1;
M=0;

while bCon==1
    nB=A(:,nobase);%非基变量矩阵
    ncb=c(nobase);%非基变量系数
    B=A(:,baseVector);%基变量矩阵
    cb=c(baseVector);%基变量系数
    xb=inv(B)*b; %迭代后的基变量矩阵
    f=cb*xb;%迭代后的目标函数值
    w=cb*inv(B);%单纯性乘子
    
    for i=1:length(nobase)  % 判别
        sigma(i)=w*nB(:,i)-ncb(i);
    end
    [maxs,ind]=max(sigma); %判别系数的最大值，ind为进基变量下标
    if maxs<=0    %最大值小于0，输出最优解
        minf=cb*xb;
        vr=find(c~=0,1,'last');
        for l=1:vr
            ele=find(baseVector==l,1);
            if(isempty(ele))
                x(l)=0;
            else
                x(l)=xb(ele);%得到最优解
            end
        end
        bCon=0;
    else
        y=inv(B)*A(:,nobase(ind));
        if y<=0
            disp('不存在最优解');
            x=NaN;
            minf=NaN;
            return;
        else    %寻找出基变量
            minb=inf;
            chagB=0;
            for j=1:length(y)
                if y(j)>0
                    bz=xb(j)/y(j);
                    if bz<minb
                        minb=bz;
                        chagB=j;
                    end
                end
            end %chagB为出基变量下标
            tmp=baseVector(chagB);%更新基矩阵和非基矩阵
            baseVector(chagB)=nobase(ind);
            nobase(ind)=tmp;
        end
    end
    M=M+1;
    if (M==1000000)
        disp('找不到最优解！');
        x=NaN;
        minf=NaN;
        return;
    end
end



        
