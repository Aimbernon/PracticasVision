%%%%%%%IGNORAR

disp '1. Leyendo imagen'
tic
uno = imread('iiia/00036.jpg');
dos = imread('iiia/00035.jpg');
toc

%imshow(uno);
%imshow(dos);

original = rgb2gray(uno);
distorted = rgb2gray(dos);

%Se sacan los puntos
disp '2. Obteniendo puntos'
tic
ptsOriginal  = detectSURFFeatures(original);
ptsDistorted = detectSURFFeatures(distorted);
[featuresOriginal,validPtsOriginal] = extractFeatures(original, ptsOriginal);
[featuresDistorted,validPtsDistorted] = extractFeatures(distorted,ptsDistorted);
toc

%Se comparan los puntos
disp '3. Comparando puntos (esto puede llevar un rato)'
tic
index_pairs = matchFeatures(featuresOriginal,featuresDistorted);
matchedPtsOriginal  = validPtsOriginal(index_pairs(:,1));
matchedPtsDistorted = validPtsDistorted(index_pairs(:,2));
toc

figure; showMatchedFeatures(original,distorted,matchedPtsOriginal,matchedPtsDistorted);
title('Matched SURF points,including outliers');

%Se extraen los bordes y se estima una transformación
disp '4. Estimando una transformación'
tic
[tform,inlierPtsDistorted,inlierPtsOriginal] = estimateGeometricTransform(matchedPtsDistorted,matchedPtsOriginal,'similarity');
figure; showMatchedFeatures(original,distorted,inlierPtsOriginal,inlierPtsDistorted);
title('Matched inlier points');
toc

outputView = imref2d(size(original));
Ir = imwarp(distorted,tform,'OutputView',outputView);
figure; imshow(Ir);
title('Recovered image');

[tform,inlierPtsOriginal,inlierPtsDistorted] = estimateGeometricTransform(matchedPtsOriginal,matchedPtsDistorted,'similarity');
outputView = imref2d(size(original));
Zr = imwarp(original,tform,'OutputView',outputView);
figure; imshow(Ir);
title('Recovered image');

It = Zr + Ir;
figure; imshow(It);
title('Recovered image');