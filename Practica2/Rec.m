% Rec: Eliminacion de  bordes y obtencion de los canales
function im = Rec(im_in,option)
	%Recorte de imagen
	% opcion 1
	%Hacemos la media por columnas i filas para detectar canvios a negros o
	%claros (Por desarollar), otra idea puede ser hacer una media de todo el
	%dataset y cortar siempre el mismo valor o un mix de las dos xD
	if option == 1
		t=mean(im_in);
		j=0;
		for i = 1:size(im_in,2)
		    if (t(i)>120) &&  (t(i) < 150)
		        j=j+1;
		        if (j==2)
		            break;
		        end
		    end
		end
		if (i>40)
		    i=20;
		end
		im_in = im_in(:,i:end-i);

		t2 = mean(im_in,2);
		j=0;
		for i = 1:size(im_in,2)
		    if (t2(i) < 200 )
		            break;
		        
		    end
		end
		im_in = im_in(i:end-i,:);
	elseif option == 2
		
		% opcion 2 : determinar si es borde o no por el num de veces que el valor
		% de la columna/ fila esta entre 0:40. En ese caso se elimina la fila/columna

		% contar cuantas veces el valor del pixel esta entre el intervalo
		ccol = sum(histc (im_in,[0:40]));
		crows = sum(histc (im_in',[0:40]));
		% eliminacion de los bordes
		thx=size (im_in,1).*0.8;
		thy=size (im_in,2).*0.8;
		im_in(:,ccol>thx)=[];
		im_in (crows>thy,:)=[];
	else
		disp ('wrong option')
		exit
	end

	figure ('name', 'Eliminacion de los bordes','NumberTitle','off')
	imshow (im_in);
	% Recorte de los 3 canales

	x= size(im_in,1)/3;
	x= uint32(floor(x));
	im(:,:,3) = im_in(1:x,:);
	im(:,:,2) = im_in(x+1:x*2,:);
	im(:,:,1) = im_in((x*2)+1:x*3,:);
end
