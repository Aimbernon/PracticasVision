%escalar = 0.2;

disp '1. Cargando imágenes'
tic
buildingDir = fullfile('iar');
buildingScene = imageSet(buildingDir);
toc

disp '2. Mostrando collage'
%tic
%montage(buildingScene.ImageLocation)
%toc

disp '3. Preparando primera imagen y bucle'
tic
I = read(buildingScene, 1);
%I = imresize(I,escalar);

grayImage = rgb2gray(I);
points = detectSURFFeatures(grayImage);
[features, points] = extractFeatures(grayImage, points);

% Initialize all the transforms to the identity matrix. Note that the
% projective transform is used here because the building images are fairly
% close to the camera. Had the scene been captured from a further distance,
% an affine transform would suffice.
tforms(buildingScene.Count) = projective2d(eye(3));
toc

disp '4. Calculando transformaciones'
tic
% Iterate over remaining image pairs
for n = 2:buildingScene.Count
    t = [int2str(((n-1)/(buildingScene.Count))*100) '%'];
    disp(t);
    
    % Store points and features for I(n-1).
    pointsPrevious = points;
    featuresPrevious = features;

    % Read I(n).
    I = read(buildingScene, n);
    %I = imresize(I,escalar);

    % Detect and extract SURF features for I(n).
    grayImage = rgb2gray(I);
    points = detectSURFFeatures(grayImage);
    [features, points] = extractFeatures(grayImage, points);

    % Find correspondences between I(n) and I(n-1).
    indexPairs = matchFeatures(features, featuresPrevious, 'Unique', true);

    matchedPoints = points(indexPairs(:,1), :);
    matchedPointsPrev = pointsPrevious(indexPairs(:,2), :);

    % Estimate the transformation between I(n) and I(n-1).
    tforms(n) = estimateGeometricTransform(matchedPoints, matchedPointsPrev,...
        'projective', 'Confidence', 99.9, 'MaxNumTrials', 2000);

    % Compute T(1) * ... * T(n-1) * T(n)
    tforms(n).T = tforms(n-1).T * tforms(n).T;
end
toc

disp '5. Quitando los limites externos a las transformaciones'
tic
imageSize = size(I);  % all the images are the same size
% Compute the output limits  for each transform
for i = 1:numel(tforms)
    t = [int2str(((i-1)/numel(tforms))*100) '%'];
    disp(t);
    [xlim(i,:), ylim(i,:)] = outputLimits(tforms(i), [1 imageSize(2)], [1 imageSize(1)]);
end
toc

disp '6. Calculando media de los limites en X para encontrar imagen central'
tic
avgXLim = mean(xlim, 2);
[~, idx] = sort(avgXLim);
centerIdx = floor((numel(tforms)+1)/2);
centerImageIdx = idx(centerIdx);
toc

disp '7. Aplicando transformada inversa de la imagen central a todas las imagenes'
tic
    Tinv = invert(tforms(centerImageIdx));
    for i = 1:numel(tforms)
        tforms(i).T = Tinv.T * tforms(i).T;
    end
toc

disp '8. Inicializando imagen panorámica'
tic
    for i = 1:numel(tforms)
        [xlim(i,:), ylim(i,:)] = outputLimits(tforms(i), [1 imageSize(2)], [1 imageSize(1)]);
    end

    % Find the minimum and maximum output limits
    xMin = min([1; xlim(:)]);
    xMax = max([imageSize(2); xlim(:)]);

    yMin = min([1; ylim(:)]);
    yMax = max([imageSize(1); ylim(:)]);

    % Width and height of panorama.
    width  = round(xMax - xMin);
    height = round(yMax - yMin);

    % Initialize the "empty" panorama.
    panorama = zeros([height width 3], 'like', I);
toc

disp '9. Creando imagen panorámica'
tic
    blender = vision.AlphaBlender('Operation', 'Binary mask', ...
    'MaskSource', 'Input port');

% Create a 2-D spatial reference object defining the size of the panorama.
xLimits = [xMin xMax];
yLimits = [yMin yMax];
panoramaView = imref2d([height width], xLimits, yLimits);

% Create the panorama.
for i = 1:buildingScene.Count
    t = [int2str(((i-1)/buildingScene.Count)*100) '%'];
    disp(t);
    
    I = read(buildingScene, i);
    %I = imresize(I,escalar);

    % Transform I into the panorama.
    warpedImage = imwarp(I, tforms(i), 'OutputView', panoramaView);

    % Create an mask for the overlay operation.
    warpedMask = imwarp(ones(size(I(:,:,1))), tforms(i), 'OutputView', panoramaView);

    % Clean up edge artifacts in the mask and convert to a binary image.
    warpedMask = warpedMask >= 1;

    % Overlay the warpedImage onto the panorama.
    panorama = step(blender, panorama, warpedImage, warpedMask);
end
toc

disp '10. Mostrando panoramica'
tic
figure
imshow(panorama)
toc