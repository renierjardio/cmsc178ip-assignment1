% SMART_BLUR - blur image to remove noise, but attempt to preserve
%  edge details where possible
%
% USAGE:
%   image_out = smart_blut( image_in , N , tolderance )
%
%    N         - size of NxN blur to apply to data (def. 5).
%    tolerance - estimate of gradient based on noise alone. Used to
%                contol weighting between oriignal and smoothed data
%                returned by function (def. 0.015)
%
% NOTE: all image data is converted to greyscale, with values in range 
%      0.0..1.0 before filtering is applied.

function B = smart_blur(I,N,tolerance)

% convert to greyscale 0.0..1.0
I =im2double(I);
if (size(I,3)==3)
  I=rgb2gray(I);
end

% handle missing input parameters
if (nargin<2)
  N=5;
  if (nargin<3)
    tolerance=0.015; % about 4 greylevels for 8bit data
  end
  if (nargin<1)
    error('This function requires an image as input');
  end
end

% ------ INSERT YOUR CODE BELOW ------

h = ones(N,N) / (N*N);
B_blur = conv2(I, h, 'same');

sobel_x = [ 2  1  0 -1 -2;
            3  2  0 -2 -3;
            4  3  0 -3 -4;
            3  2  0 -2 -3;
            2  1  0 -1 -2 ] / 60;
sobel_y = sobel_x';

Ix = conv2(I, sobel_x, 'same');
Iy = conv2(I, sobel_y, 'same');

G = sqrt(Ix.^2 + Iy.^2);

W = ones(size(G));
mask = G > tolerance;
W(mask) = tolerance ./ G(mask);
W = min(W, 1);

B = W .* B_blur + (1 - W) .* I;

% ------ INSERT YOUR CODE ABOVE ------

return
end

