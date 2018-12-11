% gamma_spectroscopy Ge detector
fname = 'C:\von_Server\ETH\BSc Physics\5\Praktikum 3\Gamma_spectroscopy\plots';

    
% 2.5: relative energy resolution
    % [Cs, Eu, Eu, Eu, Eu, Eu, Eu, Eu, Eu, Eu, Co, Co, Na, Bi, Bi, Bi]
    GE_range_min = [2994, 1544, 3528, 4375, 5043, 3936, 6400, 2002, 528, 1094, 5328, 6053, 5796, 2570, 4823, 8053];
    GE_range_max = [3019, 1570, 3564, 4405, 5087, 3959, 6433, 2023, 554, 1111, 5361, 6089, 5820, 2600, 4859, 8088];
    GE_CP_kev = [662.204, 342.775, 779.825, 965.995, 1114.837, 868.835, 1412.524, 443.022, 118.867, 242.639, 1176.288, 1336.477, 1278.181, 570.144, 1063.371, 1770.450];
    GE_err_CP_kev = [0.0044, 0.0028, 0.0093, 0.011, 0.013, 0.027, 0.012, 0.014, 0.014, 0.005, 0.012, 0.013, 0.066, 0.0018, 0.0036, 0.02];
    GE_CP_channel = [3007.043, 1557.361, 3543.048, 4388.890, 5065.137, 3947.454, 6417.646, 2012.823, 540.060, 1102.405, 5344.335, 6072.134, 5807.276, 2586.405, 4842.548, 8069.217];
    GE_err_CP_channel = [0.02, 0.013, 0.042, 0.051, 0.061, 0.12, 0.056, 0.065, 0.064, 0.023, 0.052, 0.058, 0.3, 0.0081, 0.016, 0.09];
    GE_FWHM_kev = [1.401, 1.127, 1.505, 1.657, 1.777, 1.562, 1.977, 1.273, 0.925, 1.038, 1.772, 1.895, 1.700, 1.339, 1.744, 2.254];
    GE_err_FWHM_kev = [0.008, 0.0053, 0.019, 0.023, 0.026, 0.067, 0.023, 0.032, 0.026, 0.011, 0.022, 0.023, 0.15, 0.0033, 0.0065, 0.038];
    GE_FWHM_channel = [6.403, 5.121, 6.840, 7.528, 8.076, 7.095, 8.982, 5.784, 4.204, 4.714, 8.050, 8.610, 7.724, 6.115, 7.984, 10.231];
    GE_err_FWHM_channel = [0.037, 0.024, 0.086, 0.1, 0.12, 0.31, 0.1, 0.15, 0.012, 0.049, 0.1, 0.1, 0.69, 0.015, 0.03, 0.17];
    GE_area_ct = [19098, 31394, 5986, 4875, 3948, 1307, 4864, 2416, 87041, 10939, 4704, 4201, 164, 110499, 45083, 2569];
    GE_err_area_ct = [140, 183, 85, 77, 67, 60, 71, 66, 305, 125, 71, 66, 16, 340, 216, 53];
    %GE_Area_ct_s = [];
    GE_err_Area_ct_s = [2.467, 1.060, 0.621, 1.971, 1.288, 1.341, 1.254, 1.320, 2.777, 1.314, 1.430, 1.093, 0.070, 10.886, 5.473, 0.909];
    GE_rel_resolution = zeros(1,16);
    GE_err_rel_resolution = zeros(1,16);
    for i = 1:16
        GE_rel_resolution(i) = GE_FWHM_kev(i) / GE_CP_kev(i);
        GE_err_rel_resolution(i) = sqrt((GE_err_FWHM_kev(i) / GE_CP_kev(i))^2 + (GE_FWHM_kev(i) * GE_err_CP_kev(i) / (GE_CP_kev(i))^2)^2);
    end
   %{ 
    % linearity 
    figure
    errorbar(GE_CP_channel(2:10), GE_CP_kev(2:10), GE_err_CP_kev(2:10)/2, GE_err_CP_kev(2:10)/2, GE_err_CP_channel(2:10)/2, GE_err_CP_channel(2:10)/2, 'b*')
    hold on
    errorbar(GE_CP_channel(1), GE_CP_kev(1), GE_err_CP_kev(1)/2, GE_err_CP_kev(1)/2, GE_err_CP_channel(1)/2, GE_err_CP_channel(1)/2, 'g*')
    hold on
    errorbar(GE_CP_channel(11:12), GE_CP_kev(11:12), GE_err_CP_kev(11:12)/2, GE_err_CP_kev(11:12)/2, GE_err_CP_channel(11:12)/2, GE_err_CP_channel(11:12)/2, 'm*')
    hold on
    errorbar(GE_CP_channel(13), GE_CP_kev(13), GE_err_CP_kev(13)/2, GE_err_CP_kev(13)/2, GE_err_CP_channel(13)/2, GE_err_CP_channel(13)/2, 'r*')
    hold on
    errorbar(GE_CP_channel(14:16), GE_CP_kev(14:16), GE_err_CP_kev(14:16)/2, GE_err_CP_kev(14:16)/2, GE_err_CP_channel(14:16)/2, GE_err_CP_channel(14:16)/2, 'c*')
    xrange = linspace(0, 8200);
    AD = polyfit (GE_CP_channel(:), GE_CP_kev(:), 1);
    AH = polyval(AD, xrange);
    plot(xrange, AH, 'k-');
    grid on
    ylabel('E_{\gamma}')
    xlabel('controid position [channels]')
    title('linearity')
    legend('Eu-152', 'Cs-137', 'Co-60', 'Na-22', 'Bi-207', 'linear fit', 'Location', 'Best');
    saveas(gcf, fullfile(fname, 'linearity_GE.eps'), 'epsc');
    
    figure
    errorbar(GE_CP_kev(1), GE_rel_resolution(1), GE_err_rel_resolution(1)/2, GE_err_rel_resolution(1)/2, GE_err_CP_kev(1)/2, GE_err_CP_kev(1)/2, 'r*')
    hold on
    errorbar(GE_CP_kev(2:10), GE_rel_resolution(2:10), GE_err_rel_resolution(2:10)/2, GE_err_rel_resolution(2:10)/2, GE_err_CP_kev(2:10)/2, GE_err_CP_kev(2:10)/2, 'b*')
    hold on
    errorbar(GE_CP_kev(11:12), GE_rel_resolution(11:12), GE_err_rel_resolution(11:12)/2, GE_err_rel_resolution(11:12)/2, GE_err_CP_kev(11:12)/2, GE_err_CP_kev(11:12)/2, 'g*')
    hold on
    errorbar(GE_CP_kev(13), GE_rel_resolution(13), GE_err_rel_resolution(13)/2, GE_err_rel_resolution(13)/2, GE_err_CP_kev(13)/2, GE_err_CP_kev(13)/2, 'b*')
    hold on
    errorbar(GE_CP_kev(14:16), GE_rel_resolution(14:16), GE_err_rel_resolution(14:16)/2, GE_err_rel_resolution(14:16)/2, GE_err_CP_kev(14:16)/2, GE_err_CP_kev(14:16)/2, 'c*')
    hold on
    XXXx = linspace(0, 1800);
    NAN = polyfit(GE_CP_kev, GE_rel_resolution, 2);
    NBN = polyval(NAN, XXXx);
    hold on
    plot(XXXx, NBN, 'k-')
    grid on
    xlabel('E_{\gamma} [keV]')
    ylabel('\Delta E / E_{\gamma} [keV]')
    legend('Cs-137', 'Eu-152', 'Co-60', 'Na-22', 'Bi-207', 'fit line', 'Location', 'Best')
    title('relative energy resolution, Ge-detector')
    saveas(gcf, fullfile(fname, 'relative_energy_resolution_GE.eps'), 'epsc');
 %}

    
     % GERMANIUM DETEKTOR
    keV_HPGe = [0.000000, 661.620000, 1332.510000, 1173.230000, 1408.080000, 1112.070000, 1085.800000, 964.000000, 867.390000, 778.900000, 444.000000, 411.090000, 344.300000, 244.670000, 121.780000, 1770.220000];
    ch_HPGe = [0.00, 3006.00, 6073.00, 5345.00, 6418.00, 5065.00, 4943.00, 4389.00, 3948.00, 3541.00, 2012.00, 1860.00, 1557.00, 1102.00, 540.00, 8069.00];
    
    [XData, YData] = prepareCurveData( ch_HPGe, keV_HPGe );
    Ft = fittype( 'poly1' );
    [Fitresult, Gof] = fit( XData, YData, Ft );
    Coeff = coeffvalues(Fitresult);
        % stimmen nicht: Bi, cs, 
    channel_array = linspace(0, 8191, 8192);
    kev = Coeff(1) * channel_array(:) + Coeff(2);
        
% IMPORT AND PLOTS OF SPECTRA OF SOURCES: NA22, CO60, CS137, EU152, BI207, GEMISCH A, GEMISCH B:

% IMPORT: BI - 207    
%{
filename = 'C:\von_Server\ETH\BSc Physics\5\Praktikum 3\Gamma_spectroscopy\data\Ge_Detector\bi207_ged_1cm.txt';
delimiter = '\t';
formatSpec = '%f%f%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string', 'EmptyValue', NaN,  'ReturnOnError', false);
fclose(fileID);
GE_Bi207x_1 = dataArray{:, 1};
GE_Bi207y_1 = dataArray{:, 2};
GE_Bi207_seconds_1 = 317.933 ; % s
GE_err_Bi207x_1 = ones(size(GE_Bi207x_1));
GE_err_Bi207y_1 = sqrt(GE_Bi207x_1(:) / GE_Bi207_seconds_1(:)); % counting errors
clearvars filename delimiter formatSpec fileID dataArray ans;

filename = 'C:\von_Server\ETH\BSc Physics\5\Praktikum 3\Gamma_spectroscopy\data\Ge_Detector\bi207_ged_4cm.txt';
delimiter = '\t';
formatSpec = '%f%f%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string', 'EmptyValue', NaN,  'ReturnOnError', false);
fclose(fileID);
GE_Bi207x_4 = dataArray{:, 1};
GE_Bi207y_4 = dataArray{:, 2};
GE_Bi207_seconds_4 = 126.598; % s
GE_err_Bi207x_4 = ones(size(GE_Bi207x_4));
GE_err_Bi207y_4 = sqrt(GE_Bi207x_4(:) / GE_Bi207_seconds_4(:)); % counting errors
clearvars filename delimiter formatSpec fileID dataArray ans;

filename = 'C:\von_Server\ETH\BSc Physics\5\Praktikum 3\Gamma_spectroscopy\data\Ge_Detector\bi207_ged_8cm.txt';
delimiter = '\t';
formatSpec = '%f%f%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string', 'EmptyValue', NaN,  'ReturnOnError', false);
fclose(fileID);
GE_Bi207x_8 = dataArray{:, 1};
GE_Bi207y_8 = dataArray{:, 2};
GE_Bi207_seconds_8 = 120.417; % s
GE_err_Bi207x_8 = ones(size(GE_Bi207x_8));
GE_err_Bi207y_8 = sqrt(GE_Bi207x_8(:) / GE_Bi207_seconds_8(:)); % counting errors
clearvars filename delimiter formatSpec fileID dataArray ans;
     
    figure
    %plot(GE_Bi207x_1(:), GE_Bi207y_1(:), 'b.', GE_Bi207x_4(:), GE_Bi207y_4(:), 'g.', GE_Bi207x_8(:), GE_Bi207y_8(:), 'r.')
    plot(kev(:), GE_Bi207y_1(:), 'b.', kev(:), GE_Bi207y_4(:), 'g.', kev(:), GE_Bi207y_8(:), 'r.')
    l = legend('1cm', '4cm', '8cm', 'Location', 'Best');
    xlabel('E [keV]')
    ylabel('counts')
    title('\gamma spectrum of Bi-207, Ge-detector')
    saveas(gcf, fullfile(fname, 'Bi207_GE.eps'), 'epsc')

    figure
    %semilogy(GE_Bi207x_1(:), GE_Bi207y_1(:), 'b.', GE_Bi207x_4(:), GE_Bi207y_4(:), 'g.', GE_Bi207x_8(:), GE_Bi207y_8(:), 'r.')
    semilogy(kev(:), GE_Bi207y_1(:), 'b.', kev(:), GE_Bi207y_4(:), 'g.', kev(:), GE_Bi207y_8(:), 'r.')
    AT = [74, 569, 1063, 1430];
    BT = [3.99*10^4, 1609, 5296, 173];
    Str1 = {'X-ray peak', '\leftarrow photopeak', '\leftarrow photopeak', 'photopeak \rightarrow'};
    text(AT, BT, Str1);
    l = legend('1cm', '4cm', '8cm', 'Location', 'Best');
    xlabel('E [keV]')
    ylabel('counts')
    title('\gamma spectrum of Bi-207, logarithmic y-axis, Ge-detector')
    saveas(gcf, fullfile(fname, 'Bi207_logy_GE.eps'), 'epsc')
%}
    
% IMPORT: CO - 60
%{
filename = 'C:\von_Server\ETH\BSc Physics\5\Praktikum 3\Gamma_spectroscopy\data\Ge_Detector\co60_ged_1cm.txt';
delimiter = '\t';
formatSpec = '%f%f%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string', 'EmptyValue', NaN,  'ReturnOnError', false);
fclose(fileID);
GE_Co60x_1 = dataArray{:, 1};
GE_Co60y_1 = dataArray{:, 2};
GE_Co60_seconds_1 = 122.184; % s
GE_err_Co60x_1 = ones(size(GE_Co60x_1));
GE_err_Co60y_1 = sqrt(GE_Co60x_1(:) / GE_Co60_seconds_1(:)); % counting errors
clearvars filename delimiter formatSpec fileID dataArray ans;

filename = 'C:\von_Server\ETH\BSc Physics\5\Praktikum 3\Gamma_spectroscopy\data\Ge_Detector\co60_ged_4cm.txt';
delimiter = '\t';
formatSpec = '%f%f%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string', 'EmptyValue', NaN,  'ReturnOnError', false);
fclose(fileID);
GE_Co60x_4 = dataArray{:, 1};
GE_Co60y_4 = dataArray{:, 2};
GE_Co60_seconds_4 = 116.386 ; % s
GE_err_Co60x_4 = ones(size(GE_Co60x_4));
GE_err_Co60y_4 = sqrt(GE_Co60x_4(:) / GE_Co60_seconds_4(:)); % counting errors
clearvars filename delimiter formatSpec fileID dataArray ans;

filename = 'C:\von_Server\ETH\BSc Physics\5\Praktikum 3\Gamma_spectroscopy\data\Ge_Detector\co60_ged_8cm.txt';
delimiter = '\t';
formatSpec = '%f%f%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string', 'EmptyValue', NaN,  'ReturnOnError', false);
fclose(fileID);
GE_Co60x_8 = dataArray{:, 1};
GE_Co60y_8 = dataArray{:, 2};
GE_Co60_seconds_8 = 131.628 ; % s
GE_err_Co60x_8 = ones(size(GE_Co60x_8));
GE_err_Co60y_8 = sqrt(GE_Co60x_8(:) / GE_Co60_seconds_8(:)); % counting errors
clearvars filename delimiter formatSpec fileID dataArray ans;
    figure
    plot(GE_Co60x_1(:), GE_Co60y_1(:), 'b.', GE_Co60x_4(:), GE_Co60y_4(:), 'g.', GE_Co60x_8(:), GE_Co60y_8(:), 'r.')
    l = legend('1cm', '4cm', '8cm', 'Location', 'Best');
    xlabel('E [keV]')
    ylabel('counts')
    title('\gamma spectrum of Co-60, Ge-detector')
    saveas(gcf, fullfile(fname, 'Co60_GE.eps'), 'epsc')

    figure
    semilogy(GE_Co60x_1(:), GE_Co60y_1(:), 'b.', GE_Co60x_4(:), GE_Co60y_4(:), 'g.', GE_Co60x_8(:), GE_Co60y_8(:), 'r.')
    ET = [219 419 948 1176 1336];
    FT = [29 15 26 180 62];
    Str3 = {'\leftarrow backscattering peak', '\leftarrow Compton continuum', '\leftarrow Compton edge', '\leftarrow photopeak', '\leftarrow photopeak'};
    text(ET, FT, Str3)
    l = legend('1cm', '4cm', '8cm', 'Location', 'Best');
    xlabel('E [keV]')
    ylabel('counts')
    title('\gamma spectrum of Co-60, logarithmic y-axix, Ge-detector')
    saveas(gcf, fullfile(fname, 'Co60_logy_GE.eps'), 'epsc')
 %}  
   
% IMPORT: NA - 22
%{
filename = 'C:\von_Server\ETH\BSc Physics\5\Praktikum 3\Gamma_spectroscopy\data\Ge_Detector\na22_ged_1cm.txt';
delimiter = '\t';
formatSpec = '%f%f%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string', 'EmptyValue', NaN,  'ReturnOnError', false);
fclose(fileID);
GE_Na22x_1 = dataArray{:, 1};
GE_Na22y_1 = dataArray{:, 2};
GE_Na22_seconds_1 =  70.107; % s
GE_err_Na22x_1 = ones(size(GE_Na22x_1));
GE_err_Na22y_1 = sqrt(GE_Na22x_1(:) / GE_Na22_seconds_1(:)); % counting errors
clearvars filename delimiter formatSpec fileID dataArray ans;

filename = 'C:\von_Server\ETH\BSc Physics\5\Praktikum 3\Gamma_spectroscopy\data\Ge_Detector\na22_ged_4cm.txt';
delimiter = '\t';
formatSpec = '%f%f%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string', 'EmptyValue', NaN,  'ReturnOnError', false);
fclose(fileID);
GE_Na22x_4 = dataArray{:, 1};
GE_Na22y_4 = dataArray{:, 2};
GE_Na22_seconds_4 = 68.946; % s
GE_err_Na22x_4 = ones(size(GE_Na22x_4));
GE_err_Na22y_4 = sqrt(GE_Na22x_4(:) / GE_Na22_seconds_4(:)); % counting errors
clearvars filename delimiter formatSpec fileID dataArray ans;

filename = 'C:\von_Server\ETH\BSc Physics\5\Praktikum 3\Gamma_spectroscopy\data\Ge_Detector\na22_ged_8cm.txt';
delimiter = '\t';
formatSpec = '%f%f%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string', 'EmptyValue', NaN,  'ReturnOnError', false);
fclose(fileID);
GE_Na22x_8 = dataArray{:, 1};
GE_Na22y_8 = dataArray{:, 2};
GE_Na22_seconds_8 = 103.393; % s
GE_err_Na22x_8 = ones(size(GE_Na22x_8));
GE_err_Na22y_8 = sqrt(GE_Na22x_8(:) / GE_Na22_seconds_8(:)); % counting errors
clearvars filename delimiter formatSpec fileID dataArray ans;
    figure
    plot(GE_Na22x_1(:), GE_Na22y_1(:), 'b.', GE_Na22x_4(:), GE_Na22y_4(:), 'g.', GE_Na22x_8(:), GE_Na22y_8(:), 'r.')
    l = legend('1cm', '4cm', '8cm', 'Location', 'Best');
    xlabel('E [keV]')
    ylabel('counts')
    title('\gamma spectrum of Na-22, Ge-detector')
    saveas(gcf, fullfile(fname, 'Na22_GE.eps'), 'epsc')

    figure
    semilogy(GE_Na22x_1(:), GE_Na22y_1(:), 'b.', GE_Na22x_4(:), GE_Na22y_4(:), 'g.', GE_Na22x_8(:), GE_Na22y_8(:), 'r.')
    CT = [1278 511 333];
    DT = [24 50 6];
    Str2 = {'\leftarrow photopeak', '\leftarrow annihilation peak', '\leftarrow Compton edge'};
    text(CT, DT, Str2);
    l = legend('1cm', '4cm', '8cm', 'Location', 'Best');
    xlabel('E [keV]')
    ylabel('counts')
    title('\gamma spectrum of Na-22, logarithmic y-axis Ge-detector')
    saveas(gcf, fullfile(fname, 'Na22_logy_GE.eps'), 'epsc')
  %}  
    
% IMPORT: CS - 137
%{
filename = 'C:\von_Server\ETH\BSc Physics\5\Praktikum 3\Gamma_spectroscopy\data\Ge_Detector\cs137_ged_1cm.txt';
delimiter = '\t';
formatSpec = '%f%f%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string', 'EmptyValue', NaN,  'ReturnOnError', false);
fclose(fileID);
GE_Cs137x_1 = dataArray{:, 1};
GE_Cs137y_1 = dataArray{:, 2};
GE_Cs137_seconds_1 = 47.645; % s
GE_err_Cs137x_1 = ones(size(GE_Cs137x_1));
GE_err_Cs137y_1 = sqrt(GE_Cs137x_1(:) / GE_Cs137_seconds_1(:)); % counting errors
clearvars filename delimiter formatSpec fileID dataArray ans;

filename = 'C:\von_Server\ETH\BSc Physics\5\Praktikum 3\Gamma_spectroscopy\data\Ge_Detector\cs137_ged_4cm.txt';
delimiter = '\t';
formatSpec = '%f%f%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string', 'EmptyValue', NaN,  'ReturnOnError', false);
fclose(fileID);
GE_Cs137x_4 = dataArray{:, 1};
GE_Cs137y_4 = dataArray{:, 2};
GE_Cs137_seconds_4 = 101.131; % s
GE_err_Cs137x_4 = ones(size(GE_Cs137x_4));
GE_err_Cs137y_4 = sqrt(GE_Cs137x_4(:) / GE_Cs137_seconds_4(:)); % counting errors
clearvars filename delimiter formatSpec fileID dataArray ans;

filename = 'C:\von_Server\ETH\BSc Physics\5\Praktikum 3\Gamma_spectroscopy\data\Ge_Detector\cs137_ged_8cm.txt';
delimiter = '\t';
formatSpec = '%f%f%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string', 'EmptyValue', NaN,  'ReturnOnError', false);
fclose(fileID);
GE_Cs137x_8 = dataArray{:, 1};
GE_Cs137y_8 = dataArray{:, 2};
GE_Cs137_seconds_8 = 82.189; % s
GE_err_Cs137x_8 = ones(size(GE_Cs137x_8));
GE_err_Cs137y_8 = sqrt(GE_Cs137x_8(:) / GE_Cs137_seconds_8(:)); % counting errors
clearvars filename delimiter formatSpec fileID dataArray ans;
    figure
    plot(GE_Cs137x_1(:), GE_Cs137y_1(:), 'b.', GE_Cs137x_4(:), GE_Cs137y_4(:), 'g.', GE_Cs137x_8(:), GE_Cs137y_8(:), 'r.')
    l = legend('1cm', '4cm', '8cm', 'Location', 'Best');
    xlabel('E [keV]')
    ylabel('counts')
    title('\gamma spectrum of Cs-137, Ge-detector')
    saveas(gcf, fullfile(fname, 'Cs137_GE.eps'), 'epsc')
    
    figure
    semilogy(kev(:), GE_Cs137y_1(:), 'b.', GE_Cs137x_4(:), GE_Cs137y_4(:), 'g.', GE_Cs137x_8(:), GE_Cs137y_8(:), 'r.')
    xlim([0 2000]); % data points up to x = 18000
    OT = [662 28 499 322];
    PT = [498 1357 17 26];
    Str1 = {'\leftarrow photopeak', '\leftarrow X-ray peak', '\leftarrow Compton edge', '\leftarrow Compton continuum'};
    text(OT, PT, Str1);
    l = legend('1cm', '4cm', '8cm', 'Location', 'Best');
    xlabel('E [keV]')
    ylabel('counts')
    title('\gamma spectrum of Cs-137,logarithmic y-axis, Ge-detector')
    saveas(gcf, fullfile(fname, 'Cs137_logy_GE.eps'), 'epsc')
  %}
   
% IMPORT: EU - 152

filename = 'C:\von_Server\ETH\BSc Physics\5\Praktikum 3\Gamma_spectroscopy\data\Ge_Detector\eu152_ged_1cm.txt';
delimiter = '\t';
formatSpec = '%f%f%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string', 'EmptyValue', NaN,  'ReturnOnError', false);
fclose(fileID);
GE_Eu152x_1 = dataArray{:, 1};
GE_Eu152y_1 = dataArray{:, 2};
GE_Eu152_seconds_1 = 82.189; % s
GE_err_Eu152x_1 = ones(size(GE_Eu152x_1));
GE_err_Eu152y_1 = sqrt(GE_Eu152x_1(:) / GE_Eu152_seconds_1(:)); % counting errors
clearvars filename delimiter formatSpec fileID dataArray ans;

filename = 'C:\von_Server\ETH\BSc Physics\5\Praktikum 3\Gamma_spectroscopy\data\Ge_Detector\eu152_ged_4cm.txt';
delimiter = '\t';
formatSpec = '%f%f%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string', 'EmptyValue', NaN,  'ReturnOnError', false);
fclose(fileID);
GE_Eu152x_4 = dataArray{:, 1};
GE_Eu152y_4 = dataArray{:, 2};
GE_Eu152_seconds_4 = 82.189; % s
GE_err_Eu152x_4 = ones(size(GE_Eu152x_4));
GE_err_Eu152y_4 = sqrt(GE_Eu152x_4(:) / GE_Eu152_seconds_4(:)); % counting errors
clearvars filename delimiter formatSpec fileID dataArray ans;

filename = 'C:\von_Server\ETH\BSc Physics\5\Praktikum 3\Gamma_spectroscopy\data\Ge_Detector\eu152_ged_8cm.txt';
delimiter = '\t';
formatSpec = '%f%f%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string', 'EmptyValue', NaN,  'ReturnOnError', false);
fclose(fileID);
GE_Eu152x_8 = dataArray{:, 1};
GE_Eu152y_8 = dataArray{:, 2};
GE_Eu152_seconds_8 = 82.189; % s
GE_err_Eu152x_8 = ones(size(GE_Eu152x_8));
GE_err_Eu152y_8 = sqrt(GE_Eu152x_8(:) / GE_Eu152_seconds_8(:)); % counting errors
clearvars filename delimiter formatSpec fileID dataArray ans;
    figure
    plot(GE_Eu152x_1(:), GE_Eu152y_1(:), 'b.', GE_Eu152x_4(:), GE_Eu152y_4(:), 'g.', GE_Eu152x_8(:), GE_Eu152y_8(:), 'r.')
    l = legend('1cm', '4cm', '8cm', 'Location', 'Best');
    xlabel('E [keV]')
    ylabel('counts')
    title('\gamma spectrum of Eu-152, Ge-detector')
    saveas(gcf, fullfile(fname, 'Eu152_GE.eps'), 'epsc')
    
    figure
    semilogy(GE_Eu152x_1(:), GE_Eu152y_1(:), 'b.', GE_Eu152x_4(:), GE_Eu152y_4(:), 'g.', GE_Eu152x_8(:), GE_Eu152y_8(:), 'r.')
    MT = [36 119 243 343 410 443 780 869 969 1115 1089 1413 1303];
    NT = [3.81*10^4 1.987*10^4 2134 5577 168 359 796 142 591 342 78 552 51];
    Str5 = {'\leftarrow X-ray peak', '\leftarrow photopeak', '\leftarrow photopeak', '\leftarrow photopeak', '\leftarrow photopeak',...
        '\leftarrow photopeak', '\leftarrow photopeak', '\leftarrow photopeak', '\leftarrow photopeak', '\leftarrow photopeak',...
        '\leftarrow photopeak', '\leftarrow photopeak', '\leftarrow photopeak'};
    text(MT, NT, Str5);
    l = legend('1cm', '4cm', '8cm', 'Location', 'Best');
    xlabel('E [keV]')
    ylabel('counts')
    title('\gamma spectrum of E-152, logarithmic y-axis, Ge-detector')
    saveas(gcf, fullfile(fname, 'Eu152_logy_GE.eps'), 'epsc')
  %} 
    
% IMPORT: GEMISCH A
%{
filename = 'C:\von_Server\ETH\BSc Physics\5\Praktikum 3\Gamma_spectroscopy\data\Ge_Detector\gemischA_ged_1cm.txt';
delimiter = '\t';
formatSpec = '%f%f%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string', 'EmptyValue', NaN,  'ReturnOnError', false);
fclose(fileID);
GE_GemischAx_1 = dataArray{:, 1};
GE_GemischAy_1 = dataArray{:, 2};
GE_GemischA_seconds_1 = 224.426; % s
GE_err_GemischAx_1 = ones(size(GE_GemischAx_1));
GE_err_GemischAy_1 = sqrt(GE_GemischAx_1(:) / GE_GemischA_seconds_1(:)); % counting errors
clearvars filename delimiter formatSpec fileID dataArray ans;

filename = 'C:\von_Server\ETH\BSc Physics\5\Praktikum 3\Gamma_spectroscopy\data\Ge_Detector\gemischA_ged_4cm.txt';
delimiter = '\t';
formatSpec = '%f%f%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string', 'EmptyValue', NaN,  'ReturnOnError', false);
fclose(fileID);
GE_GemischAx_4 = dataArray{:, 1};
GE_GemischAy_4 = dataArray{:, 2};
GE_GemischA_seconds_4 = 246.029; % s
GE_err_GemischAx_4 = ones(size(GE_GemischAx_4));
GE_err_GemischAy_4 = sqrt(GE_GemischAx_4(:) / GE_GemischA_seconds_4(:)); % counting errors
clearvars filename delimiter formatSpec fileID dataArray ans;

filename = 'C:\von_Server\ETH\BSc Physics\5\Praktikum 3\Gamma_spectroscopy\data\Ge_Detector\gemischA_ged_8cm.txt';
delimiter = '\t';
formatSpec = '%f%f%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string', 'EmptyValue', NaN,  'ReturnOnError', false);
fclose(fileID);
GE_GemischAx_8 = dataArray{:, 1};
GE_GemischAy_8 = dataArray{:, 2};
GE_GemischA_seconds_8 = 376.421; % s
GE_err_GemischAx_8 = ones(size(GE_GemischAx_8));
GE_err_GemischAy_8 = sqrt(GE_GemischAx_8(:) / GE_GemischA_seconds_8(:)); % counting errors
clearvars filename delimiter formatSpec fileID dataArray ans;
    figure
    plot(GE_GemischAx_1(:), GE_GemischAy_1(:), 'b.', GE_GemischAx_4(:), GE_GemischAy_4(:), 'g.', GE_GemischAx_8(:), GE_GemischAy_8(:), 'r.')
    l = legend('1cm', '4cm', '8cm', 'Location', 'Best');
    xlabel('E [keV]')
    ylabel('counts')
    title('\gamma spectrum of Gemisch A, Ge-detector')
    saveas(gcf, fullfile(fname, 'GemischA_GE.eps'), 'epsc')
    
    figure
    semilogy(GE_GemischAx_1(:), GE_GemischAy_1(:), 'b.', GE_GemischAx_4(:), GE_GemischAy_4(:), 'g.', GE_GemischAx_8(:), GE_GemischAy_8(:), 'r.')
    GT = [663 1177 1337 188 378 476];
    HT = [5414 41 12 990 142 557];
    Str4 = {'\leftarrow Cs-137 photopeak', '\leftarrow Co-60 photopeak', '\leftarrow Co-60 photopeak', '\leftarrow backscattering peak', '\leftarrow Compton continuum', '\leftarrow Compton edge'};
    text(GT, HT, Str4);
    l = legend('1cm', '4cm', '8cm', 'Location', 'Best');
    xlabel('E [keV]')
    ylabel('counts')
    title('\gamma spectrum of Gemisch A, logarithmic y-axis, Ge-detector')
    saveas(gcf, fullfile(fname, 'GemischA_logy_GE.eps'), 'epsc')
%}
    
% IMPORT: GEMISCH B
%{
filename = 'C:\von_Server\ETH\BSc Physics\5\Praktikum 3\Gamma_spectroscopy\data\Ge_Detector\gemischB_ged_1cm.txt';
delimiter = '\t';
formatSpec = '%f%f%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string', 'EmptyValue', NaN,  'ReturnOnError', false);
fclose(fileID);
GE_GemischBx_1 = dataArray{:, 1};
GE_GemischBy_1 = dataArray{:, 2};
GE_GemischB_seconds_1 = 161.876 ; % s
GE_err_GemischBx_1 = ones(size(GE_GemischBx_1));
GE_err_GemischBy_1 = sqrt(GE_GemischBx_1(:) / GE_GemischB_seconds_1(:)); % counting errors
clearvars filename delimiter formatSpec fileID dataArray ans;

filename = 'C:\von_Server\ETH\BSc Physics\5\Praktikum 3\Gamma_spectroscopy\data\Ge_Detector\gemischB_ged_4cm.txt';
delimiter = '\t';
formatSpec = '%f%f%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string', 'EmptyValue', NaN,  'ReturnOnError', false);
fclose(fileID);
GE_GemischBx_4 = dataArray{:, 1};
GE_GemischBy_4 = dataArray{:, 2};
GE_GemischB_seconds_4 = 349.408 ; % s
GE_err_GemischBx_4 = ones(size(GE_GemischBx_4));
GE_err_GemischBy_4 = sqrt(GE_GemischBx_4(:) / GE_GemischB_seconds_4(:)); % counting errors
clearvars filename delimiter formatSpec fileID dataArray ans;

filename = 'C:\von_Server\ETH\BSc Physics\5\Praktikum 3\Gamma_spectroscopy\data\Ge_Detector\gemischB_ged_8cm.txt';
delimiter = '\t';
formatSpec = '%f%f%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string', 'EmptyValue', NaN,  'ReturnOnError', false);
fclose(fileID);
GE_GemischBx_8 = dataArray{:, 1};
GE_GemischBy_8 = dataArray{:, 2};
GE_GemischB_seconds_8 = 477.786 ; % s
GE_err_GemischBx_8 = ones(size(GE_GemischBx_8));
GE_err_GemischBy_8 = sqrt(GE_GemischBx_8(:) / GE_GemischB_seconds_8(:)); % counting errors
clearvars filename delimiter formatSpec fileID dataArray ans;
    figure
    plot(GE_GemischBx_1(:), GE_GemischBy_1(:), 'b.', GE_GemischBx_4(:), GE_GemischBy_4(:), 'g.', GE_GemischBx_8(:), GE_GemischBy_8(:), 'r.')
    l = legend('1cm', '4cm', '8cm', 'Location', 'Best');
    xlabel('E [keV]')
    ylabel('counts')
    title('\gamma spectrum of Gemisch B, Ge-detector')
    saveas(gcf, fullfile(fname, 'GemischB_GE.eps'), 'epsc')
    
    figure
    semilogy(GE_GemischBx_1(:), GE_GemischBy_1(:), 'b.', GE_GemischBx_4(:), GE_GemischBy_4(:), 'g.', GE_GemischBx_8(:), GE_GemischBy_8(:), 'r.')
    IT = [661 1177 1338 188 378 474];
    JT = [5414 17 7 500 111 296];
    Str6 = {'\leftarrow Cs-137 photopeak', '\leftarrow Co-60 photopeak', '\leftarrow Co-60 photopeak', '\leftarrow backscattering peak', '\leftarrow Compton continuum', '\leftarrow Compton edge'};
    text(IT, JT, Str6);
    l = legend('1cm', '4cm', '8cm', 'Location', 'Best');
    xlabel('E [keV]')
    ylabel('counts')
    title('\gamma spectrum of Gemisch B, logarithmic y-axis, Ge-detector')
    saveas(gcf, fullfile(fname, 'GemischB_logy_GE.eps'), 'epsc')

%}