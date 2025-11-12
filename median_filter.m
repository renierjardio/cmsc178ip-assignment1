% MEDIAN_FILTER
%
% Usage:
%         med_img = median_filter(img,M,N)
%
% M,N size of MxN median filter to employ. 

function med_img = median_filter(img,M,N)

% ensure img is 0..1 and greyscale
img = im2double(img);
if (size(img,3)==3)
  img=rgb2gray(img);
end

% ----- INSERT YOUR OWN CODE BELOW -----

[rows, cols] = size(img);
med_img = img;

half_M = floor(M/2);
half_N = floor(N/2);

for i = 1+half_M : rows-half_M
    for j = 1+half_N : cols-half_N
        window = img(i-half_M:i+half_M, j-half_N:j+half_N);
        
        sorted_vals = sort(window(:));
        len = numel(sorted_vals);
        
        if mod(len, 2) == 1
            med_val = sorted_vals((len+1)/2);
        else
            med_val = (sorted_vals(len/2) + sorted_vals(len/2 + 1)) / 2;
        end
        
        med_img(i, j) = med_val;
    end
end


% Hint: the simplest solution is to use for loops and the sort() function
% to solve this. Consider also how you plan to deal with values near the
% boundary.


% ----- INSERT YOUR OWN CODE ABOVE -----

return
end




