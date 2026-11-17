function [docId, noise] = parseName(name)
tok = regexp(name, '^(HW\d+)_(.+)\.(jpg|jpeg|png)$', 'tokens', 'once', 'ignorecase');
if isempty(tok), error('Nama file tidak sesuai pola: %s', name); end
docId = upper(tok{1});
label = upper(strtrim(tok{2}));
switch label
    case 'NORMAL',            noise = 'normal';
    case 'BURAM',             noise = 'blur';
    case 'GELAP',             noise = 'lowlight';
    case 'KONTRAS RENDAH',    noise = 'lowcontrast';
    case 'PERSPEKTIF MIRING', noise = 'perspective';
    otherwise, error('Label tidak dikenal: %s', label);
end
end