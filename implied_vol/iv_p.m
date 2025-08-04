function implied_vol = iv_p(df, exdate, date, rf_df, S)
    % Filter by expiration
    df = df(df.exdate == exdate & df.strike_price >= S * 1000 & df.cp_flag == "P", :);

    if height(df) < 2
        warning("Not enough data points.");
        implied_vol = 0;
        return;
    end

    % Remove duplicate moneyness
    [unique_moneyness, ia] = unique(df.moneyness);
    unique_iv = df.impl_volatility(ia);

    if numel(unique_moneyness) < 2
        warning("Not enough unique moneyness points.");
        implied_vol = 0;
        return;
    end

    % Time to maturity
    T = df.timeToMaturity(1) / 365;

    % Step 1: Interpolate implied volatility over moneyness
    try
        xx = linspace(min(df.moneyness), max(df.moneyness), 100); % moneyness = S / K
        sigma = spline(unique_moneyness, unique_iv, xx);
    catch ME
        warning("Spline interpolation failed: %s");
        implied_vol = 0;
        return;
    end

    % Step 2: Interpolate risk-free rate
    rf = riskFree(rf_df, date, df.timeToMaturity(1)) / 100;

    % Step 3: Compute strike prices from moneyness
    K = S * xx;

    % Step 4: Compute Black-Scholes put prices
    d1 = (log(S ./ K) + (rf + 0.5 .* sigma .^ 2) .* T) ./ (sigma .* sqrt(T));
    d2 = d1 - sigma .* sqrt(T);
    prices = K .* exp(-rf .* T) .* normcdf(-d2) - S .* normcdf(-d1);
    % Step 5: Compute the function for integration
    funct_p = 2 * (1 + log(S ./ K)) ./ (K .^ 2) .* prices;
    % Step 6: Integrate to get implied volatility
    implied_vol = trapz(K, funct_p);
end
