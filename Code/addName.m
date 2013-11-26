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
        newNameStr = [newNameStr, ' ' upper(fullstops{nffs}(1)), '.'];
    end
end

end

