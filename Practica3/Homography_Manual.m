function H = Homography_Manual (im,im2)

    %Obtenim punts
    figure(1),imshow(im)
    [x1 y1] = ginput(4);
    figure(2),imshow(im2)
    [x2 y2] = ginput(4);
    %Configuracio i solucio del sistema
    M=[];
    for i=1:4
    M=[M;
       x1(i) y1(i) 1    0     0   0  -x2(i)*x1(i) -x2(i)*y1(i) -x2(i);
         0     0   0  x1(i) y1(i) 1  -y2(i)*x1(i) -y2(i)*y1(i) -y2(i)];
    end
    [u,s,v] = svd( M );
    H = reshape( v(:,end), 3, 3 )';
    H = H / H(3,3);
    
end