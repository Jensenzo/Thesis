bibSrc = 'bibTest.bib';
bibSrcOut = 'bibTestOut.bib';

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
        patternFullLine = '.*(\}|\},)';
        while ~length(regexpi(tlinen,patternFullLine,'match')) %in this case line didn't end
            indx = find(tlinen==char(13) | tlinen==char(10));
            tlinen(indx) = [];
            tlinen = [tlinen fgets(fid)];
        end

        %Split names
        names = regexpi(tlinen,'\{.*\}','match');
        names = names{1}(2:end-1);
        names = strsplit(names,' and ');
        Nnames = numel(names);
        for n = 1:Nnames
            %test for comma
            names{n} = strrep(names{n},char(9),' ');
            commaPlace = strfind(names{n},',');
            if commaPlace %if the name already has a comma
                if length(commaPlace) > 1
                    error(['Something went wrong with the name: ' names{n}])
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
            newNameStr = addName( newNameStr,fornames );
            
            if n < Nnames%if not at end
                newNameStr = [newNameStr, ' and '];
            end
        end
        newNameStr = [newNameStr, '},' char(13)];
    else %
        fwrite(fidOut,tline);
        tline = fgets(fid);
        continue
    end
    
%     indx = find(tline==char(13) | tline==char(10));
%     tline(indx) = [];
    sprintf(newNameStr)
    fwrite(fidOut,[newNameStr]);
    
    tline = fgets(fid);
end

fclose(fid);
fclose(fidOut);