currentScriptPath = fileparts(mfilename('fullpath'));
addpath(fullfile(currentScriptPath, 'data'));
addpath(fullfile(currentScriptPath, 'risk_free_rate'));
addpath(fullfile(currentScriptPath, 'implied_vol'));

spot = readtable("C:\Users\bryan\essay\Vp\files\2023-08-31_2023-09-01.csv");

option = readtable("C:\Users\bryan\essay\Vp\files\hm00lmnxqhnyyqbi.csv");

rf_df = readtable("C:\Users\bryan\essay\Vp\files\zerocouponrate.csv");
filteredDf = cleanData(option, spot.Close);
% Get unique expiration dates
% dates = unique(filteredDf.exdate);

iv(filteredDf, spot.Close, rf_df, "2023-08-31");

% iv(filteredDf, fi);


% Combine into a new summary table
% scatter(filteredDf.moneyness, filteredDf.impl_volatility, 'filled');
% xlabel('Moneyness');
% ylabel('Iv');
% title('Dot Plot of Close Prices');
