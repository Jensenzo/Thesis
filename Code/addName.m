function [ newNameStr ] = addName(newNameStr, input_args )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

input_args = testForEmpty(input_args);
Nfor = numel(input_args);
for nf = 1:Nfor
    fullstops = strsplit(input_args{nf},'.');
    fullstops = testForEmpty(fullstops);
    NforFS = numel(fullstops);
    for nffs = 1:NforFS
        %test for initials without full stops between them
        if length(fullstops{nffs}) > 1 && length(fullstops{nffs}) < 4 && strcmp(fullstops{nffs},upper(fullstops{nffs}))
            warning(['Assuming that: ' fullstops{nffs} ' , are initials'])
            if strcmp(fullstops{nffs}(1),'-')
                newNameStr = [newNameStr, fullstops{nffs}, '.'];
            else
                for l = 1:length(fullstops{nffs})
                    newNameStr = [newNameStr, ' ' (fullstops{nffs}(l)), '.'];
                end
            end
        else
            newNameStr = [newNameStr, ' ' upper(fullstops{nffs}(1)), '.'];
        end
    end
end

end

