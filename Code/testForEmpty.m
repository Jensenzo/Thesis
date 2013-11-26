function [ output_args ] = testForEmpty( input_args )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
if ischar(input_args)
    input_args = {input_args};
end

    output_args = [];
    for c = 1:numel(input_args)
        if ~isempty(input_args{c}) || strcmpi(input_args{c},' ')
            if isempty(output_args)
                output_args = {input_args{c}};
            else
                output_args{numel(output_args) + 1} = input_args{c};
            end
        end
    end

if ischar(output_args)
    output_args = {output_args};
end
