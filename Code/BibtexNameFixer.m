% gitDir = 'E:\GitHub'; %Home PC
% dbDir = 'E:\Dropbox\My Dropbox'; %Home PC

gitDir = 'C:\Users\jenc2\Documents\GitHub'; %Work PC
dbDir = 'D:\Dropbox'; %Work PC
svnDir = 'D:'; %Work PC

% bibSrc = [dbDir '\KeystrokeRemovalShare\papers\bibGoogle.bib'];
% bibSrcOut = [gitDir '\Thesis\References\bibGoogle.bib'];

bibSrc = [svnDir '\Repos\References\bib.bib'];
bibSrcOut = [gitDir '\Thesis\References\references_FirstYear.bib'];

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
                %test if a comma is preceded by "~" (which indicates a
                %double barrel-related hack
                delcP = [];
                for cP = 1:numel(commaPlace)
                    if length(names{n}) > commaPlace(cP) %tests if comma is not the last character in the name
                        if strcmp(names{n}(commaPlace(cP)+1),'~')
                            delcP = cP;
                            break
                        end
                    else
                        error(['Comma as the last character in the name?: ', names{n}])
                    end
                end
                commaPlace(delcP) = [];
                
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