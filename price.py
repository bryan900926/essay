import yfinance as yf


def getPrice(ticker: str, startDate: str, endDate: str) -> None:
    data = yf.download(tickers=ticker, start=startDate, end=endDate)
    if not data.empty:
        path = "C:/Users/bryan/essay/Vp/files/" + startDate + "_" + endDate + ".csv"
        flat_df = data.stack(level=1)
        # Reset the index to turn 'Date' and the new 'Ticker' index into columns.
        flat_df = flat_df.reset_index()

        flat_df = flat_df.rename(columns={"level_1": "Ticker"})
        flat_df.columns.name = None
        print(flat_df)
        # flat_df = flat_df.drop(columns=["Price"])
        # flat_df.to_csv(path)
    else:
        print("Data not found")


getPrice("^IRX", "2023-08-31", "2023-09-01")
