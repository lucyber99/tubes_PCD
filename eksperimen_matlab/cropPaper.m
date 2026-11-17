function out = cropPaper(g)
sc = 4;
sm = imgaussfilt(imresize(g, 1/sc), 2);
bw = imbinarize(sm, graythresh(sm));
bw = imopen(imfill(bw,'holes'), strel('disk',3));
bw = bwareafilt(bw, 1);
if nnz(bw) < 0.15*numel(bw)
    out = g; return          % kertas tidak ketemu, kembalikan apa adanya
end
s = regionprops(bw, 'BoundingBox');
bb = s(1).BoundingBox * sc;                         % [x y w h]
m = 0.02 * min(bb(3), bb(4));                       % inset kecil buang tepi kertas
bb = [bb(1)+m, bb(2)+m, bb(3)-2*m, bb(4)-2*m];
out = imcrop(g, bb);
end