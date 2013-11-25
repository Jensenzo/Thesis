bibSrc = 'bibTest.bib';

fid = fopen(bibSrc);

tline = fgets(fid);
while ischar(tline)
    tline = strtrim(tline);
    C = strsplit(tline,' ');
    disp(tline)
    
    tline = fgets(fid);
end

fclose(fid);