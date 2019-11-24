%  Digital Image Processing - (2019)

% "Face illumination transfer through edge-preserving filters" Computer Vision and Pattern Recognition (CVPR), 2011

close all;

% Input 
source_name = {'ss1','ss2','ss3'};
ref_name = {'ref1','ref2','ref3','ref4'};

for i=1:3
    for j=1:4
        % Reading Images and respective Facial Landmark data
        img = im2double(imread(char(strcat('data/',source_name(i),'.PNG'))));
        shape_pt = load(char(strcat('data/',source_name(i),'.mat')));
        shape_pt = double(shape_pt.shape);

        imgA = im2double(imread(char(strcat('data/',ref_name(j),'.PNG'))));
        shape = load(char(strcat('data/',ref_name(j),'.mat')));
        shape = double(shape.shape);

        % Light Transfer 
        results=relight( ...
                img, ...
                shape_pt, ...
                imgA, ...
                shape ...
                );

%         Display Results
%         figure(4*(i-1)+j);
%         subplot(131);imshow(img);title('Source');
%         subplot(132);imshow(imgA);title('Reference');
%         subplot(133);imshow(results);title('Output');

        % Saving Result
        imwrite(results,char(strcat('results/',source_name(i),'_',ref_name(j),'_ours.png')));
    end
end
