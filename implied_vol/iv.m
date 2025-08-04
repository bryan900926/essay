function iv(df, S, rf_df, date)
    % df: table with columns `moneyness`, `impl_volatility`
    % S: spot price
    % T_days: days to maturity
    % yield_maturities: array of maturities in days (e.g. [30, 90, 180, 360])
    % yield_rates: corresponding zero rates in percent (e.g. [5.1, 5.3, ...])
    sortedExdate = sort(unique(df.exdate'));
    ivArray = zeros(1, length(sortedExdate));
    ivGood = zeros(1, length(sortedExdate));
    ivBad = zeros(1, length(sortedExdate));

    for i = 1:length(sortedExdate)
        exDate = sortedExdate(i);
        ivGood(i) = iv_c(df, exDate, date, rf_df, S);
        ivBad(i) = iv_p(df, exDate, date, rf_df, S);
        ivArray(i) = ivGood(i) + ivBad(i);
    end

    % Plot result
    plot(sortedExdate, ivGood, '-o', 'DisplayName', 'ivGood');
    hold on;
    plot(sortedExdate, ivBad, '-x', 'DisplayName', 'ivBad');
    plot(sortedExdate, ivArray, '-s', 'DisplayName', 'ivTotal');
    hold off;

    xlabel('Date');
    ylabel('Implied Volatility');
    title('IV Components by Expiration Date');
    legend('Location', 'best');
    grid on;
end
