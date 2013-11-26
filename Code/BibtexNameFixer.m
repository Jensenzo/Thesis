gitDir = 'E:\GitHub\Thesis\References\';

bibSrc = 'E:\Dropbox\My Dropbox\KeystrokeRemovalShare\papers\bibGoogle.bib';
bibSrcOut = [gitDir 'bibGoogle.bib'];

% bibSrc = 'E:\Repos\References\bib.bib';
% bibSrcOut = [gitDir 'references_FirstYear.bib'];
% bibSrc = 'bibTest.bib';
% bibSrcOut = 'bibTestOut.bib';


fid = fopen(bibSrc);
fidOut = fopen(bibSrcOut,'w');
clc
tline = fgets(fid);
while ischar(tline)
    tlinen = strtrim(tline);
    C = strsplit(tlinen,' ');
    %keyboard
    if strcmpi(C(1),'author')
        newNameStr = '  author = {'; %new string beginning
        
        %compile lines
        patternFullLine = '.*\},';
        while ~length(regexpi(tlinen,patternFullLine,'match')) %in this case line didn't end
            indx = find(tlinen==char(13) | tlinen==char(10));
            tlinen(indx) = [];
            tlinen = [tlinen ' ' fgets(fid)];
        end
        
        %Split names
        names = regexpi(tlinen,'\{.*\}','match');
        names = names{1}(2:end-1);
        names = strrep(names,char(9),' ');
        names = strsplit(names,' and ');
        Nnames = numel(names);
        if strcmp(names{1},'ITU-R') || strcmp(names{1},'ITU-T') || strcmp(names{1},'ING, Ros, Kiri')
            fwrite(fidOut,tline);
            tline = fgets(fid);
            continue
        else
            for n = 1:Nnames
                postfix = '';
                %test for comma
                names{n} = strrep(names{n},char(9),' ');
                commaPlace = strfind(names{n},',');
                if commaPlace %if the name already has a comma
                    if length(commaPlace) > 2
                        error(['Something went wrong with the name: ' names{n}])
                    elseif length(commaPlace) > 1
                        warning(['Double comma in: ' names{n}])
                        postfix = [', ' strtrim(names{n}(commaPlace(2)+1:end))];
                        names{n}(commaPlace(2):end) = [];
                        commaPlace(2) = [];
                    end
                    sirname = names{n}(1:commaPlace-1);
                    restname = names{n}(commaPlace+1:end);
                else
                    spacePlace = strfind(names{n},' ');
                    if spacePlace
                        sirname = names{n}(spacePlace(end)+1:end);
                    else
                        error(['No spaces found in name: ' names{n}])
                    end
                    restname = names{n}(1:spacePlace(end)-1);
                end
                
                newNameStr = [newNameStr, sirname, ','];
                
                %now the author is divided into sirname and restname
                %handle restname
                
                fornames = strsplit(restname,' ');
                newNameStr = addName( newNameStr,fornames);
                newNameStr = [newNameStr, postfix];
                
                if n < Nnames%if not at end
                    newNameStr = [newNameStr, ' and '];
                end
            end
            newNameStr = [newNameStr, '},' char(13)];
        end
    else %
        fwrite(fidOut,tline);
        tline = fgets(fid);
        continue
    end
    
%     indx = find(tline==char(13) | tline==char(10));
%     tline(indx) = [];
%     sprintf(newNameStr)
    fwrite(fidOut,[newNameStr]);
    
    tline = fgets(fid);
end

fclose(fid);
fclose(fidOut);