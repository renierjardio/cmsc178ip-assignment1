% APPLY_RGB_MAP - replace R,G and B values in an image based
% on the supplied lookup table
%
% Usage:
%          adjusted_image = apply_rgb_map(img,map)
%
% img -  NxMx3 uint8 image
% map -  256x3 lookup table for R,G,B values in range 0..255
%
% note R,G and B values are mapped independently. The RGB triples
% do not represent actual colours in the image (this is not a colormap).

function adjusted_image = apply_rgb_map(RGB_image, RGB_map)
% remap each RGB value in the current image onto a new image.
% Remember: entry 1 corresponds to value 0, entry 256 corresponds to 255.

% ----- ADD YOUR CODE BELOW -----

% Ensure image is uint8 (0..255)
if ~isa(RGB_image,'uint8')
    RGB_image = uint8(RGB_image);
end

% Preallocate output
[h, w, ~] = size(RGB_image);
adjusted_image = zeros(h, w, 3, 'uint8');

% Process each channel independently
for c = 1:3
    % Extract the channel
    channel = RGB_image(:,:,c);

    % Convert pixel values to 1-based indices
    idx = double(channel) + 1;

    % Lookup corresponding corrected values
    new_channel = RGB_map(idx, c);

    % Reshape to original image size
    adjusted_image(:,:,c) = reshape(new_channel, h, w);
end

% Clamp (safety) and ensure uint8 output
adjusted_image = uint8(adjusted_image);

% ----- ADD YOUR CODE ABOVE -----
return
end
