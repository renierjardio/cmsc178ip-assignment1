% CHART_CORRECTION - calculate RGB mappings to correct for color imbalance 
%                    between values measured from reference and test charts 
% Usage:
%         RGB_map = chart_correction(RGB_reference,RGB_measured)
%
% RGB_reference - Mx3 list of reference RGB samples 
% RGB_measured  - Mx3 list of actual RGB samples 
%
% RGB_map - 256x3 lookup table of R,G and B colour corrections
%

function RGB_map = chart_correction(RGB_reference, RGB_measured)
% RGB_reference : 24x3 ideal chart RGB values
% RGB_measured  : 24x3 captured chart RGB values
% Returns:
%   RGB_map     : 256x3 table mapping input 0..255 -> corrected value 0..255

% ---- INSERT YOUR CODE BELOW -----

% Ensure data are double for calculations
good = double(RGB_reference);
bad  = double(RGB_measured);

% Initialize output table
RGB_map = zeros(256, 3);

% Polynomial degree (try 2 for smooth nonlinear mapping)
polyDegree = 2;

for c = 1:3
    x = bad(:, c);   % measured values (input)
    y = good(:, c);  % reference values (target)

    % Handle duplicates: average y for identical x values
    [ux, ~, ic] = unique(round(x));
    meanY = zeros(size(ux));
    for k = 1:numel(ux)
        meanY(k) = mean(y(ic == k));
    end

    % Fit polynomial mapping from bad -> good
    if numel(ux) <= polyDegree
        % Not enough unique points for chosen degree, fallback to linear
        p = polyfit(x, y, 1);
    else
        p = polyfit(ux, meanY, polyDegree);
    end

    % Evaluate mapping for all input values 0..255
    vals = (0:255)';
    mapped = polyval(p, vals);

    % Clamp values into [0,255] and round
    mapped = round(mapped);
    mapped(mapped < 0)   = 0;
    mapped(mapped > 255) = 255;

    % Store in mapping table
    RGB_map(:, c) = mapped;
end

% Convert to uint8 for lookup convenience
RGB_map = uint8(RGB_map);

% ---- INSERT YOUR CODE ABOVE -----
return
end
