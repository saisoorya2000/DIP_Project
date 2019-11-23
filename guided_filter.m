function q = guided_filter(I,p,w)
if(nargin<3)
    w=10;
end

[hei, wid] = size(I);
N = boxfilter(ones(hei, wid), w); % the size of each local patch; N=(2r+1)^2 except for boundary pixels.

mean_I = boxfilter(I, w) ./ N;
mean_p = boxfilter(p, w) ./ N;
mean_Ip = boxfilter(I.*p, w) ./ N;
cov_Ip = mean_Ip - mean_I .* mean_p; % this is the covariance of (I, p) in each local patch.

mean_II = boxfilter(I.*I, w) ./ N;
var_I = mean_II - mean_I .* mean_I;

a = cov_Ip ./ (var_I + eps);
b = mean_p - a .* mean_I; 

mean_a = boxfilter(a, w) ./ N;
mean_b = boxfilter(b, w) ./ N;

q = mean_a .* I + mean_b; 
end