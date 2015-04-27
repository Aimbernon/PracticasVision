function ims = Unir (image1,image2,H)

    T=maketform('projective',H');
    [im2t,xdataim2t,ydataim2t]=imtransform(image1,T);
    
    % Calculem els limits
    xdataout=[min(1,xdataim2t(1)) max(max(size(image2,2),xdataim2t(2)),size(image1,2))];
    ydataout=[min(1,ydataim2t(1)) max(max(size(image2,1),ydataim2t(2)),size(image1,2))];
    % Transformem les dos imatges per obtenir amb una mateixa localització
    im2t=imtransform(image1,T,'XData',xdataout,'YData',ydataout);
    im1t=imtransform(image2,maketform('projective',eye(3)),'XData',xdataout,'YData',ydataout);
    %Blending
    ims=max(im1t,im2t);
    %ims = im1t+im2t / 2;
    
end