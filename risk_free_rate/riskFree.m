function rf = riskFree(rf_df, date, daysToMaturity)
    rf_df = rf_df(rf_df.date == date, :);
    rf = interp1(rf_df.days, rf_df.rate, daysToMaturity, "linear");

end
