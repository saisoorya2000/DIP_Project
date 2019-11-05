function light_mask=wls_filter(img,pt)
%   Given an input image "img", we seek a new image "light mask", which, on the one hand,
%   is as close as possible to "img", and, at the same time, is as smooth as
%   possible everywhere, except across significant gradients in L.

% create the mask of convex hull of pt
[X,Y] = meshgrid(1:size(img, 2), 1:size(img, 1));
ch = convhulln(pt);
mask = inpolygon(X,Y,pt(ch(:,1),1),pt(ch(:,1),2));

% check for light component
if(size(img,3)==3)
    Ihsv = rgb2hsv(img);
    Il = Ihsv(:,:,3);
else
    Il = img;
end

% reduce small edges using a gaussian filter
Il = imfilter(Il,fspecial('gaussian',11),'symmetric');

% % lambda          
% Balances between the data term and the smoothness
% term. Increasing lambda will produce smoother images.
lamda = mask.*(mask + imdilate(3*edge(Il),strel('disk',1)));

% log(I)(old) or I(new)
L = log(Il+1);%Il;

[Lx,Ly]=gradient(L);

[h,w]=size(L);
[Gx,Gy]=getGMat(h,w);

%   %  alpha           
%   Gives a degree of control over the affinities by non-
%   lineary scaling the gradients. Increasing alpha will
%   result in sharper preserved edges. Default value: 1.2
alpha = 1.2;
Wx = mask.*lamda./((abs(Lx)).^alpha+0.0001);
Wy = mask.*lamda./((abs(Ly)).^alpha+0.0001);

%
weight_s=0.1;
Wx_mat = weight_s*sparse(1:h*w,1:h*w,Wx(:));
Wy_mat = weight_s*sparse(1:h*w,1:h*w,Wy(:));

A = speye(h*w);
A = [A;Wx_mat*Gx;Wy_mat*Gy];    

mask_l = mask.*Il;
B = [mask_l(:);zeros(2*h*w,1)];

% Solving the equation large-scale(Is)*Detail_layer(B) = Lightness-Layer(A) 
Is = A\B;

% figure(2);    
% imshow(reshape(A,h,w));title('Lightness Layer of Source');

light_mask = reshape(Is,h,w);
% figure(2);
% subplot(231);imshow(mask);title('mask');
% subplot(232);imshow(lamda,[]);title('lamda');
% subplot(233);imshow(L.*mask,[]);title('L');
% 
% subplot(234);imshow(Il,[]);title('l');
% subplot(235);imshow(abs(Lx) + abs(Ly),[]);title('|Lx| + |Ly|');



