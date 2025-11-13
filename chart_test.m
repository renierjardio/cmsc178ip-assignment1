%
% A simple TEST for colorchart code
%

truecard = imread('color_testchart.jpg');
RGB_truechart = get_chart_values(truecard);

trueimage = imread('color_toys.jpg');   %<-- you can change this if you like

% -------------------------------------------------------------------------
% test example 1 - reduce all red tones by 50% (cyan colored)
badimage = trueimage;
badimage(:,:,1) = 0.5*badimage(:,:,1);
badtestcard = truecard;
badtestcard(:,:,1) = 0.5*badtestcard(:,:,1);

RGB_badchart = get_chart_values(badtestcard);
RGB_map = chart_correction(RGB_truechart,RGB_badchart);
fixedcard = apply_rgb_map(badtestcard,RGB_map);
fixedimage = apply_rgb_map(badimage,RGB_map);

figure
subplot(2,3,1); image(truecard);title('Reference Card');
subplot(2,3,2); image(badtestcard);title('Bad Card');
subplot(2,3,3); image(fixedcard);title('Fixed Card');
subplot(2,3,4); image(trueimage);title('Reference Image');
subplot(2,3,5); image(badimage);title('Bad Image');
subplot(2,3,6); image(fixedimage);title('Fixed Image');

% -------------------------------------------------------------------------
% test example 2 - reduce min max range and skew colors too (coffee
% colored)
badimage = trueimage;
badimage(:,:,1) = 0.5*badimage(:,:,1);
badimage(:,:,3) = 0.7*badimage(:,:,3);
badimage = 0.5*badimage + 32;
badtestcard = truecard;
badtestcard(:,:,1) = 0.5*badtestcard(:,:,1);
badtestcard(:,:,3) = 0.7*badtestcard(:,:,3);
badtestcard = 0.5*badtestcard + 32;

RGB_badchart = get_chart_values(badtestcard);
RGB_map = chart_correction(RGB_truechart,RGB_badchart);
fixedcard = apply_rgb_map(badtestcard,RGB_map);
fixedimage = apply_rgb_map(badimage,RGB_map);

figure
subplot(2,3,1); image(truecard);title('Reference Chart');
subplot(2,3,2); image(badtestcard);title('Bad Chart');
subplot(2,3,3); image(fixedcard);title('Fixed Chart');

subplot(2,3,4); image(trueimage);title('Reference Image');
subplot(2,3,5); image(badimage);title('Bad Image');
subplot(2,3,6); image(fixedimage);title('Fixed Image');

%-----------Quantitative Check---------------------

mae_before = mean(abs(double(truecard(:)) - double(badtestcard(:))));
mae_after  = mean(abs(double(truecard(:)) - double(fixedcard(:))));

fprintf('Mean absolute error before correction: %.2f\n', mae_before);
fprintf('Mean absolute error after correction: %.2f\n', mae_after);
