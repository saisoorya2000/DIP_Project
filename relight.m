
function relight(img, pt, imgRefA, ptRefA)
    % morphing the reference images
    scaleA = max(size(img,1)/size(imgRefA,1),size(img,2)/size(imgRefA,2));
    imgRefA = imresize(imgRefA, scaleA);    
    ptRefA = ptRefA*scaleA;
    try
        imgRefA = rgb2gray(imgRefA);
    catch
    end
    imgRefA = morphing(imgRefA, ptRefA, pt); 
    imgRefA = imgRefA(1:size(img,1), 1:size(img,2));
    
    % create the mask of convex hull of pt
    [X,Y] = meshgrid(1:size(img, 2), 1:size(img, 1));
    ch = convhulln(pt);
    mask = inpolygon(X,Y,pt(ch(:,1),1),pt(ch(:,1),2));
    margin = 5;
    xpro = sum(mask, 1); ypro = sum(mask, 2);
    left = max(find(xpro>0, 1 )-margin, 0); right = min(find(xpro>0, 1, 'last' )+margin, size(mask, 2));
    up = max(find(ypro>0, 1 )-margin, 0); down = min(find(ypro>0, 1, 'last' )+margin, size(mask, 1));
    rect = [left, up, right-left+1, down-up+1];
    
    mask = imcrop(mask, rect);
    
    imgRefA = imcrop(imgRefA, rect).*mask; 
    hsv_image = rgb2hsv(imcrop(img, rect));
    hsv_image(:,:,1) = hsv_image(:,:,1).*mask;
    hsv_image(:,:,2) = hsv_image(:,:,2).*mask;
    hsv_image(:,:,3) = hsv_image(:,:,3).*mask;
    img_crop = hsv2rgb(hsv_image);
%     figure(2);
%     imshow(img_crop(:,:,1:2));title('Value Layer');
   
    pt(:,1)=pt(:,1)-left;
    pt(:,2)=pt(:,2)-up;
    
    light_maskA = wls_filter(imgRefA,pt);
    light_mask = wls_filter(img_crop(:,:,3),pt);
end