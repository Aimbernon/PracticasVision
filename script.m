files = dir('input');

matrix = zeros(240,320,150);


for idx = 3:153
    color = imread(strcat('input/',files(idx).name));
    grey = rgb2gray(color);
    matrix(:,:,idx-2) = grey;
end

out = mean(matrix,3);
figure(1);
imshow(out,[]);