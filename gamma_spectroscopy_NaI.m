% gamma spectroscopy NaI detector
fname = 'C:\von_Server\ETH\BSc Physics\5\Praktikum 3\Gamma_spectroscopy\plots';

% dose as function of distance
distance = [0, 1, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 100] * 10^-2; % m
dose = [2.07, 3.30, 4.08, 2.07, 0.95, 0.62, 0.35, 0.28, 0.18, 0.11, 0.08, 0.15, 0.14]; %mu Sv / hr
xinterval = [0:0.01:0.45];
y = polyfit(distance(1:11), dose(1:11), 2);
z = polyval(y, xinterval);
   
figure
plot(distance(:), dose(:), 'bo')
grid on
hold on
plot(xinterval, z, 'c-')
title('\gamma dose rate as a function of the distance')
legend('data', 'quadratic fit');
xlabel('distance [m]')
ylabel('dose rate [\mu Sv / h]')
saveas(gcf, fullfile(fname, 'gammadoserate.eps'), 'epsc'); 
%}

% 2.5: relative energy resolution
    % [Cs, Eu, Eu, Eu, Eu, Eu, Co, Co, Na, Bi, Bi, Bi]
    range_min = [1362, 729, 1634, 2001, 2222, 2703, 2390, 2629, 2553, 1214, 2136, 3347];
    range_max = [1655, 956, 1866, 2223, 3528, 3068, 2628, 2947, 2786, 1459, 2450, 3544];
    CP_kev = [663.638, 342.387, 784.840, 973.893, 1112.815, 1419.140, 1186.297, 1343.503, 1285.880, 574.533, 1047.210, 1768.803];
    err_CP_kev = [0.12, 0.059, 0.51, 0.62, 0.46, 0.34, 0.53, 0.38, 1, 0.097, 0.2, 1.8];
    CP_channel = [1507.658, 830.044, 1746.776, 2102.318, 2353.196, 2879.755, 2487.529, 2761.069, 2667.456, 1324.899, 2290.723, 3443.365];
    err_CP_channel = [0.24, 0.13, 0.99, 1.1, 0.81, 0.57, 0.94, 0.66, 1.7, 0.2, 0.36, 2.8];
    FWHM_kev = [46.160, 30.696, 49.105, 52.126, 73.058, 66.015, 57.423, 63.616, 47.817, 43.025, 60.202, 66.806];
    err_FWHM_kev = [0.24, 0.15, 1.6, 1.9, 1.4, 0.76, 1.5, 0.92, 2.5, 0.25, 0.45, 6.3];
    FWHM_channel = [94.047, 68.798, 94.753, 95.680, 129.751, 109.997, 101.416, 109.106, 81.697, 89.503, 108.468, 102.519];
    err_FWHM_channel = [0.48, 0.33, 3, 3.6, 2.4, 1.3 2.6, 1.6, 4.3, 0.52, 0.82, 9.6];
    area_ct = [33251, 113224, 13360, 9675, 21573, 10368, 9013, 8271, 818, 78365, 24554, 950];
    err_area_ct = [199, 593, 565, 504, 558, 133, 343, 136, 49, 522, 202, 131];
    Area_ct_s = [86.8243, 26.4973, 3.11389, 2.26411, 5.04873, 2.42642, 4.82649, 4.42012, 0.349448, 66.8081, 20.933, 0.809796];
    err_Area_ct_s = [0.60, 0.52, 4.24, 5.21, 2.59, 1.28, 3.81, 1.64, 5.97, 0.67, 0.82, 13.79];
    rel_resolution = zeros(1,12);
    err_rel_resolution = zeros(1,12);
    for i = 1:12
        rel_resolution(i) = FWHM_kev(i) / CP_kev(i);
        err_rel_resolution(i) = sqrt((err_FWHM_kev(i) / CP_kev(i))^2 + (FWHM_kev(i) * err_CP_kev(i) / (CP_kev(i))^2)^2);
    end
    XXX = linspace(200, 1800);
    
    % linearity 
    figure
    errorbar(CP_channel(2:6), CP_kev(2:6), err_CP_kev(2:6)/2, err_CP_kev(2:6)/2, err_CP_channel(2:6)/2, err_CP_channel(2:6)/2, 'b*')
    hold on
    errorbar(CP_channel(1), CP_kev(1), err_CP_kev(1)/2, err_CP_kev(1)/2, err_CP_channel(1)/2, err_CP_channel(1)/2, 'g*')
    hold on
    errorbar(CP_channel(7:8), CP_kev(7:8), err_CP_kev(7:8)/2, err_CP_kev(7:8)/2, err_CP_channel(7:8)/2, err_CP_channel(7:8)/2, 'm*')
    hold on
    errorbar(CP_channel(9), CP_kev(9), err_CP_kev(9)/2, err_CP_kev(9)/2, err_CP_channel(9)/2, err_CP_channel(9)/2, 'r*')
    hold on
    errorbar(CP_channel(10:12), CP_kev(10:12), err_CP_kev(10:12)/2, err_CP_kev(10:12)/2, err_CP_channel(10:12)/2, err_CP_channel(10:12)/2, 'c*')
    hold on
    xrange = linspace(0, 4000);
    AB = polyfit (CP_channel(:), CP_kev(:), 1);
    AC = polyval(AB, xrange);
    grid on;
    plot(xrange, AC, 'k-');
    ylabel('E_{\gamma}')
    xlabel('controid position [channels]')
    title('linearity')
    legend('Eu-152', 'Cs-137', 'Co-60', 'Na-22', 'Bi-207', 'linear fit', 'Location', 'Best');
    saveas(gcf, fullfile(fname, 'linearity_NaI.eps'), 'epsc');
    
    
    figure
    errorbar(CP_kev(1), rel_resolution(1), err_rel_resolution(1)/2, err_rel_resolution(1)/2, err_CP_kev(1)/2, err_CP_kev(1)/2, 'r*');
    hold on
    errorbar(CP_kev(2:6), rel_resolution(2:6), err_rel_resolution(2:6)/2, err_rel_resolution(2:6)/2, err_CP_kev(2:6)/2, err_CP_kev(2:6)/2, 'b*');
    hold on
    errorbar(CP_kev(7:8), rel_resolution(7:8), err_rel_resolution(7:8)/2, err_rel_resolution(7:8)/2, err_CP_kev(7:8)/2, err_CP_kev(7:8)/2, 'm*');
    hold on
    errorbar(CP_kev(9), rel_resolution(9), err_rel_resolution(9)/2, err_rel_resolution(9)/2, err_CP_kev(9)/2, err_CP_kev(9)/2, 'g*');
    hold on
    errorbar(CP_kev(10:12), rel_resolution(10:12), err_rel_resolution(10:12)/2, err_rel_resolution(10:12)/2, err_CP_kev(10:12)/2, err_CP_kev(10:12)/2, 'c*');
    AA = polyfit(CP_kev, rel_resolution, 2);
    BB = polyval(AA, XXX);
    hold on
    plot(XXX, BB, 'k-')
    grid on
    xlabel('E_{\gamma} [keV]')
    ylabel('\Delta E / E_{\gamma} [keV]')
    legend('Cs-137', 'Eu-152', 'Co-60', 'Na-22', 'Bi-207', 'fit line');
    title('relative energy resolution')
    saveas(gcf, fullfile(fname, 'relative_energy_resolution.eps'), 'epsc');
%}   
    
% efficency of cs-137 source
ad = 25.4*10^-3; %m
r0 = 10*10^-3; %m
a0 = 35*10^-3; %m
rd = 31.75/2*10^-3; %m
mu_NAI = 0.4*10^2; % from figure A3
mu_Pb = 1.5*10^2; % from figure A4

s0 = @(r) ad ./sqrt(((1/ a0) * r).^2 +1);
s1 = @(r) (((1/a0) * r).*(rd-r)) ./ sqrt(((1/ a0) * r).^2 +1);
s2 = @(r) (((1/a0) * r).*(r-r0)) ./ sqrt(((1/ a0) * r).^2 +1);

epsilon_NAI = @(r) (1-exp(-mu_NAI .* s0(r)));
epsilon_Pb = @(r) (1-exp(-mu_Pb .* s1(r)));
a = @(r) (exp(-mu_Pb .* s2(r))); % from appendix A.3 Berechnung der Raumwinkelkorrektur
absorption = 0.35; % from figure A1

f1 = @(r) (r .* epsilon_NAI(r));
f2= @(r) (r .* a(r) .* epsilon_Pb(r));
F2 = @(r) (absorption * r.* epsilon_Pb(r));

Omegaepsilon_NAI = (2*pi / a0^2) * integral(f1, 0, r0); % = 0.1617
Omegaepsilon_Pb = (2*pi / a0^2) * integral(f2, r0, rd); % =0.0424 for a(r) and =0.0167 for A
%}

% Activity of cs-137 source (known)
halflifecs = 30.1; % y
lambda = log(2) / halflifecs;
A0cs = 42.8*10^3; % Bq
t = 18.6; % y; time between production of source and measurement
err_t = 0.2;
r_detector = 2.3*10^-2;
Omega_detector = (r_detector)^2 * pi / 1^2; %=0.0018
Acs = 0.27 * 4 * pi /Omega_detector;
% activity calculation of Cs-137 source using equation 13 instruction
% manual:
gamma = 0.3; % ratio peak/total; from figure A2
    emission_possibility = [84.62, 27, 12.99, 14.58, 13.58, 21.21, 99.86, 99.98, 99.944, 98, 77, 7]*10^-2; %value in [0,1]
    emission_possibility_cs137 = 84.62*10^-2;
    Omega = pi * r_detector^2 / (ad + a0)^2; 
    Omegaepsilon = Omegaepsilon_NAI + Omegaepsilon_Pb; 
cs_counts = 33251; %160606; % ct; 
    err_cs_counts = sqrt(cs_counts); % ct
    cs_runtime = 382.524; % s
    err_cs_runtime = 0.002; % s
    cs_counts_sec = cs_counts / cs_runtime; %=86.9253 ct/s (or 419.8586 ct/s for 160606 ct)
    err_cs_counts_sec = sqrt((err_cs_counts / cs_runtime)^2 + (cs_counts / cs_runtime^2 * err_cs_runtime)^2); %=0.4767 (or 1.0477 ct/sec for 160606 ct)
     
Acs_theoretical = A0cs * exp(-lambda *t); %= 2.7889e+04 Bq / s
    err_Acs_theoretical = sqrt((Acs_theoretical * (-lambda) * err_t)^2); %=128.4441 Bq / s  
    N_theor = Acs_theoretical * Omega / (4* pi) * gamma * emission_possibility_cs137; %= 256.6500 ct/s
    err_N_theor = sqrt((Omegaepsilon / (4*pi) * emission_possibility_cs137 * gamma * err_Acs_theoretical)^2);  %=0.5296 ct/s
    activity_cs_unknown_theor = N_theor / ((Omegaepsilon / (4*pi)) * gamma * emission_possibility_cs137); %=6.2249e+04 Bq
    err_activity_cs_unknown_theor = sqrt((1/ ((Omegaepsilon / (4*pi)) * gamma * emission_possibility_cs137) * err_N_theor)^2); %=128.4441Bq
   
Acs_experiment = cs_counts_sec / ((Omegaepsilon / (4*pi)) * emission_possibility_cs137 * gamma); %= 2.1083e+04
    err_Acs_experiment = err_cs_counts_sec / ((Omegaepsilon / (4*pi)) * emission_possibility_cs137 * gamma); %= 115.6214
    N_exp = Acs_experiment * Omegaepsilon / (4*pi) * emission_possibility_cs137 * gamma ; %= 86.9253
    err_N_exp = sqrt((Omegaepsilon / (4*pi) * emission_possibility_cs137 * gamma * err_Acs_experiment)^2); %= 0.4767
    activity_cs_unknown_exp = N_exp / ((Omegaepsilon / (4*pi)) * gamma * emission_possibility_cs137); %= 2.1083e+04 ??
    err_activity_cs_unknown_exp = sqrt((1/ ((Omegaepsilon / (4*pi)) * gamma * emission_possibility_cs137) * err_N_exp)^2);  %= 115.6214
%}    
   
% 2.6: measurement of the spectra and analysis:
%{ 
% SCINTILLATOR
ch_NaI = [0.00, 1518.00, 2864.00, 1728.00, 2092.00, 827.00, 2341.00, 2756.00, 1311.00, 2276.00, 3444.00, 2671.00];
keV_NaI = [0.000000, 661.620000, 1408.080000, 778.900000, 964.000000, 344.300000, 1112.070000, 1332.510000, 569.670000, 1063.620000, 1770.220000, 1274.530000];

    [xData, yData] = prepareCurveData( ch_NaI, keV_NaI );
    ft = fittype( 'poly1' );
    [fitresult, gof] = fit( xData, yData, ft );
    coeff = coeffvalues(fitresult);
    channel_array = linspace(0, 8191, 8192);
    kev_nai = coeff(1)*channel_array(:) + coeff(2);
    
% 1) measurement of spectra of Na-22, Co-60, Cs-137, Eu-152, Bi-207 and
% Gemische
% NOTE: plot without error, because undistinguishable if plotted too
    % import: Na-22,  Bi-207,  Co-60, Cs-137,  Eu-152,  Gemisch B,  Gemisch A
% IMPORT: NA-22
%{
filename = 'C:\von_Server\ETH\BSc Physics\5\Praktikum 3\Gamma_spectroscopy\data\na22.txt';
delimiter = '\t';
formatSpec = '%f%f%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string', 'EmptyValue', NaN,  'ReturnOnError', false);
fclose(fileID);
Na22x = dataArray{:, 1};
Na22y = dataArray{:, 2};
Na22_seconds = 2340.789; % s
err_Na22x = ones(size(Na22x));
err_Na22y = sqrt(Na22y(:) / Na22_seconds(:)); % counting errors
clearvars filename delimiter formatSpec fileID dataArray ans;
    figure
    plot(Na22x(:), Na22y(:), 'b.')
    at = [77.06 272.2 526.4 1288];
    bt = [113 50 82 12];
    str1 = {'\leftarrow Pb X-ray peak', '\leftarrow Compton continuum', '\leftarrow annihilation peak' , '\leftarrow Na-22 Photopeak'};
    text(at, bt, str1);
    xlabel('E [keV]')
    ylabel('counts')
    title('\gamma spectrum of Na-22')
    saveas(gcf, fullfile(fname, 'Na22.eps'), 'epsc');
    
    figure
    semilogy(Na22x(:), Na22y(:), 'b.')
    At = [77.88 218.5 526.4 1279];
    Bt = [113 50 82 16];
    Str1 = {'\leftarrow Pb X-ray peak', '\leftarrow Compton continuum', '\leftarrow annihilation peak' , '\leftarrow Na-22 Photopeak'};
    text(At, Bt, Str1);
    xlabel('E [keV]')
    ylabel('counts')
    title('\gamma spectrum of Na-22, logarithmic y-axis')
    saveas(gcf, fullfile(fname, 'Na22_logy.eps'), 'epsc');
  %}
%IMPORT: BI-207
%{
filename = 'C:\von_Server\ETH\BSc Physics\5\Praktikum 3\Gamma_spectroscopy\data\bi207.txt';
delimiter = '\t';
formatSpec = '%f%f%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string', 'EmptyValue', NaN,  'ReturnOnError', false);
fclose(fileID);
Bi207x = dataArray{:, 1};
Bi207y = dataArray{:, 2};
Bi207_seconds = 1170.744 ; %s
err_Bi207x = ones(size(Bi207x));
err_Bi207y = sqrt(Bi207y(:) / Bi207_seconds(:)); % counting errors
clearvars filename delimiter formatSpec fileID dataArray ans;
    figure
    plot(Bi207x(:), Bi207y(:), 'b.')
    et = [72 232.2 580 1053];
    ft = [4000 410 889 175];
    str2 = {'\leftarrow Pb X-ray peak', '\leftarrow Compton continuum', '\leftarrow Bi-207 photopeak', '\leftarrow Bi-207 photopeak'};
    text(et, ft, str2)
    xlabel('E [keV]')
    ylabel('counts')
    title('\gamma spectrum of Bi-207')
    saveas(gcf, fullfile(fname, 'Bi-207.eps'), 'epsc');
    
    figure
    semilogy(Bi207x(:), Bi207y(:), 'b.')
    Et = [72 280 587 1093 1763];
    Ft = [5994 355 703 184 13];
    Str2 = {'\leftarrow Pb X-ray peak', '\leftarrow Compton continuum', '\leftarrow Bi-207 photopeak', '\leftarrow Bi-207 photopeak', '\leftarrow Bi-207 photopeak'};
    text(Et, Ft, Str2)
    xlabel('E [keV]')
    ylabel('counts')
    title('\gamma spectrum of Bi-207, logarithmic y-axis')
    saveas(gcf, fullfile(fname, 'Bi-207_logy.eps'), 'epsc');    
  %}
% IMPORT: CO-60
%{
filename = 'C:\von_Server\ETH\BSc Physics\5\Praktikum 3\Gamma_spectroscopy\data\Co60.txt';
delimiter = '\t';
formatSpec = '%f%f%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string', 'EmptyValue', NaN,  'ReturnOnError', false);
fclose(fileID);
Co60x = dataArray{:, 1};
Co60y = dataArray{:, 2};
Co60_seconds = 1870.588; % s
err_Co60x = ones(size(Co60x));
err_Co60y = sqrt(Co60y(:) / Co60_seconds(:)); % counting errors
clearvars filename delimiter formatSpec fileID dataArray ans;
    figure
    plot(Co60x(:), Co60y(:), 'b.')
    gt = [80 219 80 1185 1362 906];
    ht = [180 130 363 120 50 80];
    str3 = {'\leftarrow Pb x-ray peak', '\leftarrow backscattering peak', '\leftarrow Compton continuum', '\leftarrow Co-60 photopeak', '\leftarrow Co-60 photopeak', '\leftarrow Compton edge'};
    text(gt, ht, str3);
    xlabel('E [keV]')
    ylabel('counts')
    title('\gamma spectrum of Co-60')
    saveas(gcf, fullfile(fname, 'Co-60.eps'), 'epsc');
    
    figure
    semilogy(Co60x(:), Co60y(:), 'b.')
    Gt = [75 244 723 1176 1353 917];
    Ht = [271 130 46 110 50 82];
    Str3 = {'\leftarrow Pb x-ray peak', '\leftarrow backscattering peak', '\leftarrow Compton continuum', '\leftarrow Co-60 photopeak', '\leftarrow Co-60 photopeak', '\leftarrow Compton edge'};
    text(Gt, Ht, Str3);
    xlabel('E [keV]')
    ylabel('counts')
    title('\gamma spectrum of Co-60, logarithmic y-axis')
    saveas(gcf, fullfile(fname, 'Co-60_logy.eps'), 'epsc');
  %}  
    
% IMPORT: CS-137

filename = 'C:\von_Server\ETH\BSc Physics\5\Praktikum 3\Gamma_spectroscopy\data\cs137.txt';
delimiter = '\t';
formatSpec = '%f%f%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string', 'EmptyValue', NaN,  'ReturnOnError', false);
fclose(fileID);
Cs137x = dataArray{:, 1};
Cs137y = dataArray{:, 2};
Cs137_seconds = 382.524 ; %s
err_Cs137x = ones(size(Cs137x));
err_Cs137y = sqrt(Cs137y(:) / Cs137_seconds(:)); % counting errors
clearvars filename delimiter formatSpec fileID dataArray ans;
    figure
    plot(kev_nai(:), Cs137y(:), 'b.')
    it = [-33.5, 323.7, 691.6];
    jt = [623 106 343];
    str4 = {'\leftarrow Pb x-ray peak', '\leftarrow Compton continuum', '\leftarrow Cs-137 photopeak'};
    text(it, jt, str4);
    xlabel('E [keV]')
    ylabel('counts')
    title('\gamma spectrum of Cs-137')
    saveas(gcf, fullfile(fname, 'Cs-137.eps'), 'epsc');
    
    figure
    semilogy(kev_nai(:), Cs137y(:), 'b.')
    It = [-38 318 684 174 459];
    Jt = [820 80 308 145 110];
    Str4 = {'\leftarrow Pb x-ray peak', '\leftarrow Compton continuum', '\leftarrow Cs-137 photopeak', '\leftarrow backscattering peak', '\leftarrow Compton edge'};
    text(It, Jt, Str4);
    xlabel('E [keV]')
    ylabel('counts')
    title('\gamma spectrum of Cs-137, logarithmic y-axis')
    saveas(gcf, fullfile(fname, 'Cs-137_logy.eps'), 'epsc');

 % IMPORT: EU-152
 %{
filename = 'C:\von_Server\ETH\BSc Physics\5\Praktikum 3\Gamma_spectroscopy\data\eu152.txt';
delimiter = '\t';
formatSpec = '%f%f%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string', 'EmptyValue', NaN,  'ReturnOnError', false);
fclose(fileID);
Eu152x = dataArray{:, 1};
Eu152y = dataArray{:, 2};
Eu152_seconds = 4268.331;%s
err_Eu152x = ones(size(Eu152x));
err_Eu152y = sqrt(Eu152y(:)/ Eu152_seconds(:)); % counting errors
clearvars filename delimiter formatSpec fileID dataArray ans;
    figure
    plot(Eu152x(:), Eu152y(:), 'b.')
    kt = [42.61 123 340.6];
    lt = [1.863*10^4 9501 1897];
    str5 = {'\leftarrow Pb x-ray peak', '\leftarrow Eu-152 photopeak', '\leftarrow Eu-152 photopeak'};
    text(kt, lt, str5);
    xlabel('E [keV]')
    ylabel('counts')
    title('\gamma spectrum of Eu-152')
    saveas(gcf, fullfile(fname, 'Eu-152.eps'), 'epsc');

    figure
    semilogy(Eu152x(:), Eu152y(:), 'b.')
    Kt = [40 124 340 249 774 961 1116 1442];
    Lt = [2.718*10^4 8452 1897 1162 320 152 221 63];
    Str5 = {'\leftarrow Pb x-ray peak', '\leftarrow photopeak', '\leftarrow photopeak', '\leftarrow photopeak', '\leftarrow photopeak', '\leftarrow photopeak', '\leftarrow photopeak', '\leftarrow photopeak'};
    text(Kt, Lt, Str5);
    xlabel('E [keV]')
    ylabel('counts')
    title('\gamma spectrum of Eu-152, logarithmic y-axis')
    saveas(gcf, fullfile(fname, 'Eu-152_logy.eps'), 'epsc');
 %}
 
 %IMPORT :  SAMPLE B, A
 %{
filename = 'C:\von_Server\ETH\BSc Physics\5\Praktikum 3\Gamma_spectroscopy\data\gemisch_b.txt';
delimiter = '\t';
formatSpec = '%f%f%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string', 'EmptyValue', NaN,  'ReturnOnError', false);
fclose(fileID);
GemischBx = dataArray{:, 1};
GemischBy = dataArray{:, 2};
GemischB_seconds = 1933.063;%s
err_GemischBx = ones(size(GemischBx));
err_GemischBy = sqrt(GemischBy(:)/ GemischB_seconds(:)); % counting errors
clearvars filename delimiter formatSpec fileID dataArray ans;
    figure
    plot(GemischBx(:), GemischBy(:), 'b.')
    mt = [33 673 280];
    nt = [7513 3997 1242];
    str6 = {'\leftarrow Pb x-ray peak', '\leftarrow Cs-137 photopeak', '\leftarrow Compton continuum'};
    text(mt, nt, str6);
    xlabel('E [keV]')
    ylabel('counts')
    title('\gamma spectrum of Gemisch B')
    saveas(gcf, fullfile(fname, 'GemischB.eps'), 'epsc');

    figure
    semilogy(GemischBx(:), GemischBy(:), 'b.')
    Mt = [30 665 303 486 1193 1358];
    Nt = [1.076*10^4 4089 1073 500 10 4];
    Str6 = {'\leftarrow Pb x-ray peak', '\leftarrow Cs-137 photopeak', '\leftarrow Compton continuum', '\leftarrow Compton edge', '\leftarrow Co-60 photopeak', '\leftarrow Co-60 photopeak'};
    text(Mt, Nt, Str6);
    xlabel('E [keV]')
    ylabel('counts')
    title('\gamma spectrum of Gemisch B, logarithmic y-axis')
    saveas(gcf, fullfile(fname, 'GemischB_logy.eps'), 'epsc');

filename = 'C:\von_Server\ETH\BSc Physics\5\Praktikum 3\Gamma_spectroscopy\data\gemisch_a.txt';
delimiter = '\t';
formatSpec = '%f%f%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string', 'EmptyValue', NaN,  'ReturnOnError', false);
fclose(fileID);
GemischAx = dataArray{:, 1};
GemischAy = dataArray{:, 2};
GemischA_seconds = 37640.964;%s
err_GemischAx = ones(size(GemischAx));
err_GemischAy = sqrt(GemischAy(:)/ GemischA_seconds(:)); % counting errors
clearvars filename delimiter formatSpec fileID dataArray ans;
    figure
    plot(GemischAx(:), GemischAy(:), 'b.')
    ot = [28 197 303 655];
    pt = [4958 1313 885 2353];
    str7 = {'\leftarrow Pb x-rax peak', '\leftarrow backscattering peak', '\leftarrow Compton continuum', '\leftarrow Cs-137 photopeak'};
    text(ot, pt, str7);
    xlabel('E [keV]')
    ylabel('counts')
    title('\gamma spectrum of Gemisch A')
    saveas(gcf, fullfile(fname, 'GemischA.eps'), 'epsc');
   
    figure
    semilogy(GemischAx(:), GemischAy(:), 'b.')
    Ot = [28 261 481 669 1186 1325];
    Pt = [6090 890 393 2997 8 4];
    Str7 = {'\leftarrow Pb x-ray peak', '\leftarrow Compton continuum', '\leftarrow Compton edge', '\leftarrow Cs-137 photopeak', '\leftarrow Co-60 photopeak', '\leftarrow Co-60 photopeak'};
    text(Ot, Pt, Str7);
    xlabel('E [keV]')
    ylabel('counts')
    title('\gamma spectrum of Gemisch A, logarithmic y-axis')
    saveas(gcf, fullfile(fname, 'GemischA_logy.eps'), 'epsc');
%}
%}