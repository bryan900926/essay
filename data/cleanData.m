function filteredDf = cleanData(optionDf, S)
    optionDf = optionDf(optionDf.volume > 0 & startsWith(optionDf.symbol, 'SPXW') & ~isnan(optionDf.impl_volatility), :);
    optionDf.moneyness = optionDf.strike_price / (1000 * S);
    optionDf = optionDf(0.85 <= optionDf.moneyness & optionDf.moneyness <= 1.15, :);
    optionDf.midQuote = (optionDf.best_bid + optionDf.best_offer) / 2;
    optionDf = optionDf(optionDf.midQuote >= 3/8, :);
    optionDf = sortrows(optionDf, 'moneyness');
    optionDf.exdate = datetime(optionDf.exdate);
    optionDf.date = datetime(optionDf.date);
    optionDf.timeToMaturity = days(optionDf.exdate - optionDf.date);
    filteredDf = optionDf;
end
