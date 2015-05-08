

function out  = Homography_Ransac( im1, im2 )

    points1 = detectSURFFeatures(im1(:,:,1));
    points2 = detectSURFFeatures(im2(:,:,1));

    [f1, vpts1] = extractFeatures(im1(:,:,1), points1);
    [f2, vpts2] = extractFeatures(im2(:,:,1), points2);

    indexPairs = matchFeatures(f1, f2) ;
    matchedPoints1 = vpts1(indexPairs(:, 1));
    matchedPoints2 = vpts2(indexPairs(:, 2));
    out = estimateGeometricTransform(matchedPoints1, matchedPoints2,...
        'projective', 'Confidence', 99.9, 'MaxNumTrials', 2000);
        
    out = double(out.T');

end