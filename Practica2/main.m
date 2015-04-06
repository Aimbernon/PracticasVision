%Practica 2 Prokudin-Gorskii

%main: funcion principal
	% name : nombre del archivo sin extension. Ej. '0102'
	% option: metodo de prepocesamiento, 1- media, 2- repeticiones
function main(name,option)

	%Lectura de imagen
	name_in = strcat('input2/',name,'.jpg');;
	name_out = strcat('output/',name,'_color','.jpg');
	im_in = imread(name_in);
	%---------------------------------------------------------------
	%Recorte de imagen
	im = Rec(im_in,option);
	%---------------------------------------------------------------
	%Registering
	tic();
	out =Corr_Spacial(im); 
	tiempos(1)=toc();
	tic();
	out =Corr_Fourier(im);
	tiempos(2)=toc();
	tic();
	out =Corr_Fourier_Fase(im);
	tiempos(3)=toc();
	tic();
	im_in = Corr_Norm(im); 
	tiempos(4)=toc();
	%---------------------------------------------------------------
	%Mostrar tiempos
	disp ('Tiempos:')
	disp (strcat('Corr Spacial:', int2str(tiempos(1)),' s'));
	disp (strcat('Corr Fourier:', num2str(tiempos(2)),' s'));
	disp (strcat('Corr Fourier Fase:', num2str(tiempos(3)),' s'));
	disp (strcat('Corr Norm:', int2str(tiempos(4)),' s'));
	figure;
	plot ([1:4],tiempos);
	set(gca, 'xtick', [1:1:4],'XTickLabel',{'Spacial' 'Fourier' 'Fourier Fase' 'Norm'});
	xlabel('Modo de registrar','FontSize',12,'FontWeight','bold','Color','blue');
    ylabel('Tiempo (s)','FontSize',12,'FontWeight','bold','Color','blue');
	%---------------------------------------------------------------
	%Postprocesado
	out_e = Equalization(out);
	out_gwa = GWA (out);
	%---------------------------------------------------------------
	% Guardar imagen final
	imwrite(out_gwa,name_out);
end



