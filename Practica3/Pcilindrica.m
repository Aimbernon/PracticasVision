function out  = Pcilindrica( im, factor )

    % definir focal lenght
    s=factor;
    % Obtener puntos clave de la transformacion 
    cx= size(im,2)/2;
    cy= size(im,1)/2;
    lim=[-cx,1,cx,-cx,-cx,1,cx,cx;cy,cy,cy,1,-cy,-cy,-cy,1];
    plim=[s*atan((lim(1,:))/s);  s*(lim(2,:))./sqrt(lim(1,:).^2 + s^2)];
    xplim=[floor(min(plim(1,:))), ceil(max(plim(1,:)))];
    yplim=[floor(min(plim(2,:))), ceil(max(plim(2,:)))];
    out=uint8(zeros(yplim(2)-yplim(1)+1,xplim(2)-xplim(1)+1,3));

    % % cambio a proyeccion cilindrica
    for i=1:size(out,1)
        for j=1:size(out,2)
            xp=j+xplim(1)+1;
            yp=i+yplim(1)+1;
            x=round(s*tan(xp/s))+cx;
            y=round(yp*sec(xp/s))+cy;
            if(x > 0 && x <= size(im,2) && y > 0 && y <= size(im,1))
                out(i,j,:)=im(y,x,:);
            end
        end
    end
	% [x y]=meshgrid(1:size(im,2),1:size(im,1)); % x-> j, y->i
	% xp=s*atan(y/s);
	% yp=s*x./sqrt(y.^2 + s^2);
	% xplim=[floor(min(xp(:))), ceil(max(xp(:)))];
	% yplim=[floor(min(yp(:))), ceil(max(yp(:)))];
	% out=uint8(zeros(yplim(2)-yplim(1)+1,xplim(2)-xplim(1)+1,3));
	% out((sub2ind(size(out),round(xp-xplim(1)+1))),:) = im(sub2ind(size(im),y,x,:));
end

