function [fitresult, gof] = createFit(turns, counts_sec)
%CREATEFIT(TURNS,COUNTS_SEC)
%  Create a fit.
%
%  Data for 'erf' fit:
%      X Input : turns
%      Y Output: counts_sec
%  Output:
%      fitresult : a fit object representing the fit.
%      gof : structure with goodness-of fit info.
%
%  See also FIT, CFIT, SFIT.

%  Auto-generated by MATLAB on 05-Nov-2018 12:11:40


%% Fit: 'erf'.
[xData, yData] = prepareCurveData( turns, counts_sec );

% Set up fittype and options.
ft = fittype( 'a*erf(b*x + c)+d', 'independent', 'x', 'dependent', 'y' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.StartPoint = [-20 1.2 -3.5 20];

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );

% Plot fit with data.
figure( 'Name', 'erf' );
h = plot( fitresult, xData, yData );
legend( h, 'counts_sec vs. turns', 'erf', 'Location', 'NorthEast' );
% Label axes
xlabel turns
ylabel counts_sec
grid on

