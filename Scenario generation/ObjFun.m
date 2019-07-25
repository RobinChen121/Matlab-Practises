function obj = ObjFun(x)

mean = 467.25;
variance = 99.42;
skew = 1.06;
kurt = 4.35;

T = length(x)/2;
d = x(1:T);
p = x(T+1 : 2*T);
meanE = Mean(d, p);
varianceE = Variance(d, p);
skewE = Skew(d, p);
kurtE = Kurt(d, p);

obj = 0.01*(meanE - mean)^2 + 0.8*(varianceE - variance)^2 + 0.8*(skewE - skew)^2 ...
        + 50*(kurtE - kurt)^2;


end
