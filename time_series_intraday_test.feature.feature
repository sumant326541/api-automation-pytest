Feature: TIME_SERIES_INTRADAY Stock Data APIs test

    Feature Description: Test Time Series TIME_SERIES_INTRADAY Stock Data API response 

Scenario: Retrieve the most recent 100 (default outputsize=compact for 100 ) intraday OHLCV bars data with a 5-minute interval.
    Parameters: function=TIME_SERIES_INTRADAY, symbol=IBM, interval=5min, apikey=demo
    Expected Result: JSON response with 100 most recent 5-minute interval data points.

Scenario: Retrieve the full 30 days of the most recent intraday data.
    Parameters: function=TIME_SERIES_INTRADAY, symbol=IBM, interval=5min, outputsize=full, apikey=demo
    Expected Result: JSON response with 30 days of intraday data with 5-minute intervals.

Scenario: Retrieve intraday data for a specific historical month (e.g., January 2009).
    Parameters: function=TIME_SERIES_INTRADAY, symbol=IBM, interval=5min, month=2009-01, outputsize=full, apikey=demo
    Expected Result: JSON response with intraday data for January 2009 with 5-minute intervals.

Scenario: Retrieve intraday data with different intervals (1min, 15min, 30min, 60min).
    Parameters: function=TIME_SERIES_INTRADAY, symbol=IBM, interval=1min, apikey=demo
    Expected Result: JSON response with 1-minute interval data.
    Repeat for intervals 15min, 30min, 60min.

Scenario: Retrieve adjusted intraday data (default behavior adjusted = true).
    Parameters: function=TIME_SERIES_INTRADAY, symbol=IBM, interval=5min, apikey=demo
    Expected Result: JSON response with adjusted intraday data.

Scenario: Retrieve raw intraday data (non-adjusted).    
    Parameters: function=TIME_SERIES_INTRADAY, symbol=IBM, interval=5min, adjusted=false, apikey=demo
    Expected Result: JSON response with raw intraday data.

Scenario: Retrieve intraday data including extended trading hours (default behavior extended_hours = true).
    Parameters: function=TIME_SERIES_INTRADAY, symbol=IBM, interval=5min, apikey=demo
    Expected Result: JSON response with data including regular and extended trading hours.

Scenario: Retrieve intraday data only for regular trading hours.
    Parameters: function=TIME_SERIES_INTRADAY, symbol=IBM, interval=5min, extended_hours=false, apikey=demo
    Expected Result: JSON response with data only for regular trading hours.

Scenario: Retrieve data in JSON format (default behavior datatype=json).
    Parameters: function=function=TIME_SERIES_INTRADAY, symbol=IBM, interval=5min, apikey=demo, datatype=json.
    Expected Result: JSON response.

Scenario: Retrieve data in CSV format.
    Parameters: function=TIME_SERIES_INTRADAY, symbol=IBM, interval=5min, apikey=demo, datatype=csv
    Expected Result: CSV file download.

#error condition

Scenario: Missing required parameters (e.g., no symbol provided).
    Parameters: function=TIME_SERIES_INTRADAY, interval=5min, apikey=demo
    Expected Result: Error message indicating the missing required parameter.
    Repeat for (required parameters: function,symbol,interval,apikey)

Scenario: Invalid required parameters (e.g., invalid API key provided)
    Parameters: function=TIME_SERIES_INTRADAY, symbol=IBM, interval=5min, apikey=invalid_key
    Expected Result: Error message indicating the invalid API key.
    Repeat for (invalid required parameters: function,symbol,interval,apikey)

Scenario: Invalid optional parameters (e.g., invalid outputsize provided)
    Parameters: function=TIME_SERIES_INTRADAY, interval=5min, outputsize=invalid_size, apikey=demo, 
    Expected Result: Error message indicating the invalid outputsize.
    Repeat for (optional parameters: adjusted,extended_hours,month,outputsize,datatype,)
    

#Observation/Defect:
Defect: Some time data is missing in the intraday time series, interval=5 min
    observed: 2024-05-31 19:55:00,2024-05-31 19:50:00,2024-05-31 19:25:00
    expected: 2024-05-31 19:55:00,2024-05-31 19:50:00,2024-05-31 19:45:00









