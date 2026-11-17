mkdir persp_fixed;
status = cell(10,1);
for i = 1:10
    f = dir(sprintf('data/HW%03d_PERSPEKTIF*', i));
    img = imread(fullfile('data', f(1).name));
    pts = findCorners(img);

    if isempty(pts)
        status{i} = 'MANUAL';
        imshow(rgb2gray(img));
        title(sprintf('HW%03d gagal otomatis: klik 4 sudut (kiri-atas, kanan-atas, kanan-bawah, kiri-bawah)', i));
        [x, y] = ginput(4);
        pts = [x y];
    else
        status{i} = 'AUTO';
    end

    w = round(max(norm(pts(1,:)-pts(2,:)), norm(pts(4,:)-pts(3,:))));
    h = round(max(norm(pts(1,:)-pts(4,:)), norm(pts(2,:)-pts(3,:))));
    tform = fitgeotrans(pts, [1 1; w 1; w h; 1 h], 'projective');
    out = imwarp(img, tform, 'OutputView', imref2d([h w]));

    [~, base] = fileparts(f(1).name);
    imwrite(out, fullfile('persp_fixed', [base '.png']));
    fprintf('HW%03d: %s\n', i, status{i});
end
close all