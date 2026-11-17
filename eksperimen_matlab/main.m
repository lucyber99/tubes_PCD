mkdir out_gray; mkdir out_bw;
files = [dir('data/*.jpg'); dir('data/*.jpeg'); dir('data/*.png')];
fprintf('Ditemukan %d gambar\n', numel(files));

for k = 1:numel(files)
    name = files(k).name;
    try
        [~, noise] = parseName(name);
        [~, base] = fileparts(name);

        if strcmp(noise,'perspective')
            img = imread(fullfile('persp_fixed', [base '.png']));
        else
            img = imread(fullfile('data', name));
        end

        imwrite(preprocess(img, noise, false), fullfile('out_gray', [base '.png']));
        imwrite(preprocess(img, noise, true),  fullfile('out_bw',   [base '.png']));
        fprintf('%2d/%d OK   %s\n', k, numel(files), name);
    catch e
        fprintf('%2d/%d GAGAL %s: %s\n', k, numel(files), name, e.message);
    end
end