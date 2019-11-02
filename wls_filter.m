function wls_filter(img,pt)
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

% reduce small edges
Il = imfilter(Il,fspecial('gaussian',11),'symmetric');


lamda = mask.*(mask + imdilate(3*edge(Il),strel('disk',1)));


% need to confirm whether it is log(I)(old) or just I
L = Il;%log(Il+1);

[Lx,Ly]=gradient(L);


end



