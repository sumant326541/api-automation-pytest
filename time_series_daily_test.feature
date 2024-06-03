Feature: TIME_SERIES_DAILY Stock Data APIs test

    Feature Description: Test Time Series TIME_SERIES_DAILY Stock Data API response 

Scenario: Retrieve the most recent 100 daily OHLCV data points for a US-traded stock.
    Parameters: function=TIME_SERIES_DAILY, symbol=IBM, apikey=demo
    Expected Result: JSON response with the most recent 100 daily OHLCV data points.


Scenario: Retrieve the full-length daily time series for a US-traded stock, covering 20+ years.
    Parameters: function=TIME_SERIES_DAILY, symbol=IBM, outputsize=full, apikey=demo
    Expected Result: JSON response with 20+ years of daily OHLCV data.


Scenario: Retrieve daily data in JSON format (default behavior datatype=json).
    Parameters: function=TIME_SERIES_DAILY, symbol=IBM, apikey=demo, datatype=json,
    Expected Result: JSON response

Scenario: Retrieve daily data in CSV format.
    Parameters: function=TIME_SERIES_DAILY, symbol=IBM, apikey=demo, datatype=csv
    Expected Result: CSV file download.

Scenario: Retrieve daily data for a UK-traded stock (London Stock Exchange).
    Parameters: function=TIME_SERIES_DAILY, symbol=TSCO.LON, apikey=demo
    Expected Result: JSON response with daily OHLCV data for the UK stock.

Scenario: Retrieve daily data for a Canada-traded stock (Toronto Stock Exchange).
    Parameters: function=TIME_SERIES_DAILY, symbol=SHOP.TRT, apikey=demo
    Expected Result: JSON response with daily OHLCV data for the Canadian stock.

Scenario: Retrieve daily data for a stock traded on the Toronto Venture Exchange.
    Parameters: function=TIME_SERIES_DAILY, symbol=GPV.TRV, apikey=demo
    Expected Result: JSON response with daily OHLCV data for the stock on the Toronto Venture Exchange.

Scenario: Retrieve daily data for a Germany-traded stock (XETRA).
    Parameters: function=TIME_SERIES_DAILY, symbol=MBG.DEX, apikey=demo
    Expected Result: JSON response with daily OHLCV data for the German stock.

Scenario: Retrieve daily data for an India-traded stock (BSE).
    Parameters: function=TIME_SERIES_DAILY, symbol=RELIANCE.BSE, apikey=demo
    Expected Result: JSON response with daily OHLCV data for the Indian stock.

Scenario: Retrieve daily data for a stock traded on the Shanghai Stock Exchange.
    Parameters: function=TIME_SERIES_DAILY, symbol=600104.SHH, apikey=demo
    Expected Result: JSON response with daily OHLCV data for the Shanghai stock.

Scenario: Retrieve daily data for a stock traded on the Shenzhen Stock Exchange.
    Parameters: function=TIME_SERIES_DAILY, symbol=000002.SHZ, apikey=demo
    Expected Result: JSON response with daily OHLCV data for the Shenzhen stock.

Scenario: Retrieve compact data for a US-traded stock.
    Parameters: function=TIME_SERIES_DAILY, symbol=IBM, outputsize=compact, apikey=demo
    Expected Result: JSON response with the most recent 100 daily OHLCV data points.

Scenario: Retrieve daily data in JSON format for a non-US stock.
    Parameters: function=TIME_SERIES_DAILY, symbol=TSCO.LON, datatype=json, apikey=demo
    Expected Result: JSON response.

Scenario: Retrieve daily data in CSV format for a non-US stock.
    Parameters: function=TIME_SERIES_DAILY, symbol=TSCO.LON, datatype=csv, apikey=demo
    Expected Result: CSV file download.

#error condition
Scenario: Missing required parameters (e.g., no symbol provided).
    Parameters: function=TIME_SERIES_DAILY, apikey=demo
    Expected Result: Error message indicating the missing required parameter.
    Repeat for (required parameters: function,symbol,apikey)

Scenario: Invalid required parameters (e.g., invalid API key provided)
    Parameters: function=TIME_SERIES_DAILY, symbol=IBM, apikey=invalid_key
    Expected Result: Error message indicating the invalid API key.
     Repeat for (invalid required parameters: function,symbol,apikey)

Scenario: Invalid optional parameters (e.g., invalid outputsize provided)
    Parameters: function=TIME_SERIES_INTRADAY, interval=5min, outputsize=invalid_size, apikey=demo, 
    Expected Result: Error message indicating the invalid outputsize.
    Repeat for (optional parameters: outputsize,datatype,)


#Observation/Defect:
Defect: Some day data is missing in the daily time series 
    observed: 2024-05-31,2024-05-30,2024-05-29,2024-05-28,2024-05-24 
    expected: 2024-05-31,2024-05-30,2024-05-29,2024-05-28,2024-05-27,2024-05-26,2024-05-25,2024-05-24  
    
