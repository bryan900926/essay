function prices = iv(df, S, rf_df, date)
    % df: table with columns `moneyness`, `impl_volatility`
    % S: spot price
    % T_days: days to maturity
    % yield_maturities: array of maturities in days (e.g. [30, 90, 180, 360])
    % yield_rates: corresponding zero rates in percent (e.g. [5.1, 5.3, ...])
    sortedExdate = sort(unique(df.exdate));
    for i = 1:length(sortedExdate)
        exDate = sortedExdate(i);
        disp(exDate);
        disp(iv_c(df, exDate, date, rf_df, S))

    end
    % Plot result
    % scatter(xx, prices);
    % xlabel('Moneyness');
    % ylabel('Option Price');
    % title('Black-Scholes Prices');
end
