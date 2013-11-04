function y = resize(u,a,b,c)
%RESIZE Resize a matrix and fill new cells
%
%   resize(u,a,b,c)
%
%   u : Matrix that you want to resize
%   a : New number of rows
%   b : New number of colums
%   c : Fill new cells with c
%


if nargin<4, c = 0; end
if nargin<3, b = size(u,2); end
if nargin<2, a = size(u,1); end
if nargin<1, error('You need at least some kind of input you idiot!!!!'); end


y = blkdiag(u(1:min(size(u,1),a),1:min(size(u,2),b)),zeros(a-size(u,1),b-size(u,2)));
%yu(find(~yu)) = yu(find(~yu))+c;
%y = yu;