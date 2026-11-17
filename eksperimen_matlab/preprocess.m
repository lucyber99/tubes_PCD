function out = preprocess(img, noiseType, doBinarize)
if nargin < 3, doBinarize = true; end
if size(img,3)==3, g = rgb2gray(img); else, g = img; end
if ~strcmp(noiseType,'perspective')   % perspective sudah dirapikan oleh pickCorners
    g = cropPaper(g);
end

sigma = 1; sens = 0.5;          % default binarisasi
switch noiseType
    case 'normal'
    case 'perspective'
    case 'blur'
        g = deconvlucy(g, fspecial('gaussian', 9, 2), 10);   % lebih kuat
        sigma = 0; sens = 0.35;                       % tanpa blur tambahan, lebih ketat
    case 'lowcontrast'
        g = imadjust(g, [], [], 2.0);
        g = imadjust(g, stretchlim(g, [0.01 0.99]));
        g = adapthisteq(g, 'ClipLimit', 0.01);
    case 'lowlight'
        g = medfilt2(g, [5 5]);
        g = imflatfield(g, 50);
        g = imadjust(g, stretchlim(g, [0.01 0.99]));
        g = adapthisteq(g, 'ClipLimit', 0.01);
end

if doBinarize, out = binarize(g, sigma, sens); else, out = g; end
end

function bw = binarize(g, sigma, sens)
if sigma > 0, g = imgaussfilt(g, sigma); end
T  = adaptthresh(g, sens, 'ForegroundPolarity','dark', ...
    'NeighborhoodSize', 2*floor(size(g)/16)+1);
bw = imbinarize(g, T);
bw = ~bwareaopen(~bw, 15);
end