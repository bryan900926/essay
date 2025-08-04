function implied_vol = iv_c(df, exdate, date, rf_df, S)
    % Filter by expiration
    df = df(df.exdate == exdate & df.strike_price <= S * 1000 & df.cp_flag == "C", :);

    if height(df) < 2
        warning("Not enough data points.");
        implied_vol = NaN;
        return;
    end

    % Remove duplicate moneyness
    [unique_moneyness, ia] = unique(df.moneyness);
    unique_iv = df.impl_volatility(ia);

    if numel(unique_moneyness) < 2
        warning("Not enough unique moneyness points.");
        implied_vol = NaN;
        return;
    end

    % Time to maturity
    T = df.timeToMaturity(1) / 365;

    % Step 1: Interpolate implied volatility over moneyness
    try
        xx = linspace(min(df.moneyness), max(df.moneyness), 350); % moneyness = S / K
        sigma = spline(unique_moneyness, unique_iv, xx);
    catch ME
        warning("Spline interpolation failed: %s");
        implied_vol = NaN;
        return;
    end

    % Step 2: Interpolate r from zero-coupon yield curve
    rf = riskFree(rf_df, date, df.timeToMaturity(1)) / 100;
    K = S * xx;
    d1 = (log(S ./ K) + (rf + 0.5 .* sigma .^ 2) .* T) ./ (sigma .* sqrt(T));
    d2 = d1 - sigma .* sqrt(T);
    % Step 4: Compute BS prices (vectorized)
    prices = S * normcdf(d1) - K * exp(-rf * T) .* normcdf(d2);
    funct_c = 2 * (1 + log(S ./ K)) ./ (K .^ 2) .* prices;
    implied_vol = trapz(K, funct_c);
end
