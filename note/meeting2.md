# Meeting 2

### 1. Filter out the option

- exclude the options with zero trading volume
- keep the options with moneyness between 0.85 ~ 1.15
- keep the options with midquote larger than 3/8
  $$
  mid\_quote = \frac{best\_bid + lowest\_ask}{2}
  $$

### 2. Define model free implied volatility

$$
iv_t = \int_{S_t}^{\infty} \frac{2(1 - \log(K/S_t))}{K^2} C(t, t+1, K) dK + \int_{0}^{S_t} \frac{2(1 + \log(S_t/K))}{K^2} P(t, t+1, K) dK
$$

### 3. Calculate the good implied volatility for call option in same expiration date

#### 3.1 FIilter by expiration

```matlab
df = df(df.exdate == exdate & df.strike_price <= S * 1000 & df.cp_flag == "C", :);
```

#### 3.2 Interpolate Implied Volatility

```matlab
xx = linspace(min(df.moneyness), max(df.moneyness), 350);
sigma = spline(unique_moneyness, unique_iv, xx);
```

#### 3.3 Interpolate Implied Volatility with zero coupon yield

```matlab
rf = riskFree(rf_df, date, df.timeToMaturity(1)) / 100;
```

#### 3.4 Compute Black-Scholes d1 and d2

```matlab
K = S * xx;
T = df.timeToMaturity(1) / 365;
d1 = (log(S ./ K) + (rf + 0.5 .* sigma .^ 2) .* T) ./ (sigma .* sqrt(T));
d2 = d1 - sigma .* sqrt(T);
```

#### 3.5 Compute Call Prices and Final Weighted Volatility

```matlab
prices = S * normcdf(d1) - K * exp(-rf * T) .* normcdf(d2);
funct_c = 2 * (1 + log(S ./ K)) ./ (K .^ 2) .* prices;
implied_vol = trapz(K, funct_c);
```
