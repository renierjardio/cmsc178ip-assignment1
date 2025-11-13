% GET_CHART_VALUES(chart_image) - extract the 6x4 color values from the
% supplied colour chart image.
%
% Usage:
%         RGB_list = get_chart_values(chart_image)
%
% chart_image - NxMx3 array of uint8
% RGB_list    - 24x3 element list of RGB values

function RGB_list = get_chart_values(chart_image)
% chart_image is assumed to be an RGB (0..255) image of the color test
% chart. The chart should consist of 4 rows of 6 color patches equally
% spaced. This function obtains an RGB value for each patch and stores it
% in a 24x3 table.

% ---- FUNCTION BEGINS ----

% Convert to double for calculations
I = double(chart_image);

% Get image size
[rows, cols, ~] = size(I);

% Define number of patches
nRows = 4;
nCols = 6;

% Determine patch dimensions
patch_h = floor(rows / nRows);
patch_w = floor(cols / nCols);

% Initialize output list
RGB_list = zeros(nRows * nCols, 3);

index = 1;
for r = 1:nRows
    for c = 1:nCols
        % Calculate approximate patch boundaries
        row_start = (r - 1) * patch_h + 1;
        row_end   = min(r * patch_h, rows);
        col_start = (c - 1) * patch_w + 1;
        col_end   = min(c * patch_w, cols);

        % Take only the central region (avoid edges)
        row_margin = round(0.25 * patch_h);
        col_margin = round(0.25 * patch_w);

        row_start = row_start + row_margin;
        row_end   = row_end   - row_margin;
        col_start = col_start + col_margin;
        col_end   = col_end   - col_margin;

        % Ensure valid indices
        row_start = max(row_start, 1);
        row_end   = min(row_end, rows);
        col_start = max(col_start, 1);
        col_end   = min(col_end, cols);

        % Extract the patch and compute mean RGB
        patch = I(row_start:row_end, col_start:col_end, :);
        RGB_mean = squeeze(mean(mean(patch, 1), 2));

        % Store mean color
        RGB_list(index, :) = RGB_mean';
        index = index + 1;
    end
end

% Round to nearest integer (0–255)
RGB_list = round(RGB_list);

% ---- FUNCTION ENDS ----
return
end
