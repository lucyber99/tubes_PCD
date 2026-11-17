function pts = findCorners(img)
pts = [];
sc = 4;
sm = imgaussfilt(imresize(img, 1/sc), 2);
L  = imsegkmeans(sm, 3);                       % 3 kelompok warna

bestScore = 0; bestBW = [];
for k = 1:3
    bw = imclose(L == k, strel('disk', 5));
    bw = imopen(imfill(bw, 'holes'), strel('disk', 5));
    bw = bwareafilt(bw, 1);
    if ~any(bw(:)), continue; end
    s = regionprops(bw, 'Area', 'Solidity');
    frac = s(1).Area / numel(bw);
    if frac < 0.08 || frac > 0.9, continue; end
    score = s(1).Solidity * sqrt(frac);        % kertas: padat dan cukup besar
    if score > bestScore, bestScore = score; bestBW = bw; end
end
if isempty(bestBW), return; end

B = bwboundaries(bwconvhull(bestBW));
P = B{1}(:, [2 1]);                            % [x y]
Q = [];
for tol = 0.005:0.005:0.15
    R = reducepoly(P, tol);
    if size(R,1) > 1 && isequal(R(1,:), R(end,:)), R(end,:) = []; end
    if size(R,1) == 4, Q = R; break; end
end
if isempty(Q), return; end

% urutkan searah jarum jam
c = mean(Q, 1);
[~, o] = sort(atan2(Q(:,2)-c(2), Q(:,1)-c(1)));
Q = Q(o, :);

% pilih pojok awal: sisi atas harus sisi pendek (kertas portrait),
% dan pilih yang paling mendekati horizontal
best = inf;
for s = 1:4
    a = Q(s,:); b = Q(mod(s,4)+1,:); d = Q(mod(s+1,4)+1,:);
    if norm(b-a) > norm(d-b), continue; end    % sisi atas harus lebih pendek
    ang = abs(atan2d(b(2)-a(2), b(1)-a(1)));
    if ang < best, best = ang; idx = s; end
end
if isinf(best), return; end
pts = Q(mod((idx-1):(idx+2), 4)+1, :) * sc;    % TL, TR, BR, BL
end