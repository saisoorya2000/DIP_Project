
close all;

% Input 
source_name = 'ss2';
ref_name = 'ref1';

% Reading Images and respective Facial Landmark data
img=  im2double(imread(['nimg/' source_name '.PNG']));
shape_pt = load(char(strcat('nimg/',source_name,'.mat')));
shape_pt =double(shape_pt.shape);

imgA=  imresize(im2double(imread(['nimg/' ref_name '.PNG'])), 1);
shape = load(char(strcat('nimg/',ref_name,'.mat')));
shape =double(shape.shape);

figure(1);
subplot(131);imshow(img);title('Source');
subplot(132);imshow(imgA);title('Reference');


