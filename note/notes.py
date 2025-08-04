# definiation for variance premium

"""
Implied Volatility (IV) reflects what humans with risk aversion are willing to pay. It's derived from the actual prices of options, which are high because fearful investors (who are risk-averse) are buying them as "insurance." The risk-neutral part is just the name of the mathematical tool used to get the number.

Realized Volatility (RV) doesn't measure a "willingness to pay" at all. It's a historical measurement of what actually happened. It’s the final report of how much the market actually moved, without any emotion or risk premium attached.

"""

# definiation for bad and good variance premium

"""
Bad Variance Premium
This component is isolated by looking at out-of-the-money put options.

What it is: A put option is a bet that the market will fall. The "bad" VRP is the premium that investors are willing to pay for these protective puts over and above the subsequent realized downside volatility.

Why it's "bad": It specifically measures the price of fear related to market crashes. Because investors are highly risk-averse to losing money, this premium is typically large and positive. It's a pure measure of the market's demand for crash insurance.

Good Variance Premium
This component is isolated by looking at out-of-the-money call options.

What it is: A call option is a bet that the market will rise. The "good" VRP is the premium embedded in these calls compared to the subsequent realized upside volatility.

Why it's "good": It measures the premium associated with the hope for or uncertainty about positive outcomes. This premium is often very small and can sometimes even be negative, suggesting investors might underprice the possibility of extreme positive events because they are so focused on avoiding the downside.

"""

# possible extension

"""
1. y = vrp and see what x can significant affect vrp ?\

2.


"""
