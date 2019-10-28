
function relight(img, pt, imgRefA, ptRefA)
    % morphing the reference images
    scaleA = max(size(img,1)/size(imgRefA,1),size(img,2)/size(imgRefA,2));
    imgRefA = imresize(imgRefA, scaleA);    ptRefA = ptRefA*scaleA;
    try
        imgRefA = rgb2gray(imgRefA);
    catch
    end
%     imgRefA = morph(imgRefA, ptRefA, pt); 
%     imgRefA = imgRefA(1:size(img,1), 1:size(img,2)); 
end