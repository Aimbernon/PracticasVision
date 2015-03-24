
tmp = double(im(:,:,1));
Cxt = conv2(tmp,conj(tmp),'same'); 
for z = 2:3
    Cxt = conv2(tmp,conj(double(im(:,:,z))),'same'); 
    [a b] = max(max(Cxt));
    [c d] = max(Cxt);
    maxx - b
    maxy - d(b)
    im(:,:,z) = imtranslate(im(:,:,z),[maxx-b, maxy-d(b)]);
end
figure,imshow(im,[])




%Trash
for z = 2:3
    c = normxcorr2(im(:,:,1),conj(im(:,:,z)));
    [max_c, imax] = max(abs(c(:)));
    [ypeak, xpeak] = ind2sub(size(c),imax(1));
    corr_offset = [(size(im(:,:,1),2)-xpeak) 
               (size(im(:,:,1),1)-ypeak)];
    %im(:,:,z) = imtranslate(im(:,:,z),corr_offset);
end
%im(:,:,2) = zeros(size(im(:,:,1)));
%im(:,:,3) = zeros(size(im(:,:,1)));
figure,imshow(im);
%hold on
%plot(1:size(im_or, 2), mean(im_or), 'r');
