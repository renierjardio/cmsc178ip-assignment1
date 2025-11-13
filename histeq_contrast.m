% HISTEQ_CONTRAST - histogram equalisation for contrast enhancement
%
% Usage:
%         eq_img = histeq_contrast(img)
%
%  input image data is assumed to be in range 0..1

function eq_img = histeq_contrast(img)

% ----- INSERT YOUR CODE BELOW -----

% Ensure image is double and within [0,1]
I = double(img);
I(I < 0) = 0;
I(I > 1) = 1;

% Define number of histogram bins
L = 256;

% Convert pixel values to integer levels (0..255)
indices = floor(I * (L - 1));

% Compute histogram H
H = zeros(L,1);
for k = 0:(L - 1)
    H(k+1) = sum(indices(:) == k);
end

% Find first non-zero entry in histogram
first_nonzero = find(H > 0, 1, 'first');
Ho = H(first_nonzero);

% Compute cumulative histogram
cumH = cumsum(H);

% Initialise mapping m(k)
m = zeros(L,1);
for k = 1:L
    if k <= first_nonzero
        % Below first non-zero entry: map to 0
        m(k) = 0;
    else
        % Apply the formula from the assignment notes
        numerator   = (cumH(k) - Ho);
        denominator = (cumH(end) - Ho);
        m(k) = (L - 1) * (numerator / denominator);
    end
end

% Clamp mapping values to [0, L-1]
m = round(m);
m(m < 0)   = 0;
m(m > 255) = 255;

% Apply mapping using lookup table
eq_indices = m(indices + 1);

% Convert back to 0..1 double range
eq_img = double(eq_indices) / (L - 1);

% ----- INSERT YOUR CODE ABOVE -----
return
end
