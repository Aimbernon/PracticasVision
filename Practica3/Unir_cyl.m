% function out = Unir_cyl (im1,im2)
% 
%     imshow(im1);
%     [x1,y1]= ginput(4);
%     imshow(im2);
%     [x2,y2]= ginput(4);
%     x1= round(mean (x1));
%     x2 = round(mean (x2));
%     sx= x1+size(im2,2)-x2;
%     out = zeros(size(im1,1),sx,3);
%     out(:,1:x1,:)=im1(:,1:x1,:);
%     out(:,x1:end,:)=im2(:,x2:end,:);
%     out = uint8(out);
% 
% end
function out = Unir_cyl (im1,im2,ransac)

    % obtener puntos significativos
    
    if(ransac==0)
        imshow(im1);
        [x1,y1]= ginput(4);
        imshow(im2);
        [x2,y2]= ginput(4);
        x1= round(mean (x1));
        x2 = round(mean (x2));
    else
        points1 = detectSURFFeatures(im1(:,:,1));
        points2 = detectSURFFeatures(im2(:,:,1));

        [f1, vpts1] = extractFeatures(im1(:,:,1), points1);
        [f2, vpts2] = extractFeatures(im2(:,:,1), points2);

        indexPairs = matchFeatures(f1, f2) ;
        matchedPoints1 = vpts1(indexPairs(:, 1));
        matchedPoints2 = vpts2(indexPairs(:, 2));
        
        x1 = round(median (matchedPoints1.Location(:,1)));
        x2 = round(median (matchedPoints2.Location(:,1)));
    end
    
    % Calcular el size del blending
    sble1 = [x1-size(1:x2,2),size(im1,2)];
    sble2 = [1,x2+size(x1:size(im1,2),2)];
    %crear imagen
    sx= x1+size(im2,2)-x2;
    out = zeros(size(im1,1),sx,3);
    out(:,1:sble1(1),:)=im1(:,1:sble1(1),:);
    out(:,sble1(1):sble1(2),:)=max (im1(:,sble1(1):sble1(2),:),im2(:,sble2(1):sble2(2),:));
    size(out(:,sble1(2):end,:))
    size(im2(:,sble2(2):end,:))
    out(:,sble1(2):end-1,:)=im2(:,sble2(2):end,:);
    out = uint8(out);

end