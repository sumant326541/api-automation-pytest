import pytest
import datetime

def test_verify_intraday_metadata(fetch_intraday_data, test_config):
    """
        test to verify meta data for intraday time-series
    """
     # to verify intraday data response code is 200
    assert fetch_intraday_data.status_code == 200
    data = fetch_intraday_data.json()
    
    meta_data = data.get("Meta Data")
     #to verify meta data is not none
    assert meta_data is not None, f"Meta Data should not be None but found response {data}"

    expected_meta_data = test_config.META_DATA_FIELDS_INTRADAY

    # to verify each expected field and its value in meta data
    for field, value in expected_meta_data.items():
        assert field in meta_data, f"{field} should be in Meta Data"
        
        if field == test_config.LAST_REFRESHED_KEY:
            last_refreshed_value = meta_data[field]
            # to verify if the last refreshed value is a valid datetime formate
            try:
                datetime.datetime.strptime(last_refreshed_value, test_config.LAST_REFRESHED_INTRADAY_TIME_FORMATE)
            except ValueError:
                pytest.fail(f"{test_config.LAST_REFRESHED_KEY} field is not a valid datetime")
        elif field == test_config.INFORMATION_KEY:
            # to verify if the information field contains value ="intraday"
            assert meta_data[field].lower().__contains__(value)
        else:
             # to verify meta data field value
            assert meta_data[field] == value, f"{field} value should be {value}, but got {meta_data[field]}"

def test_verify_intraday_time_series_fields(fetch_intraday_data,test_config):
    """
        test to verify meta data for intraday time-series data
    """
    # to verify intraday data response code is 200
    assert fetch_intraday_data.status_code == 200
    data = fetch_intraday_data.json()
    meta_data = data.get("Meta Data")
    #to verify meta data is not none
    assert meta_data is not None, f"Meta Data should not be None but found response {data}"

    last_refreshed_field: str = test_config.LAST_REFRESHED_KEY
    last_refreshed_value: str = meta_data[last_refreshed_field]
    time_series = data.get(test_config.TIME_SERIES_KEY.format(test_config.INTERVAL["intraday"]))

    # to verify time_series data is not none and default value returns 100 entry
    assert time_series is not None, f"Time Series (5min) should not be None but found response {data}"
    assert len(time_series) ==100, f"Time Series (5min) should contain 100 entry , but got {len(time_series)} "

    # Verify that the "Time Series (5min)" includes the entry for the timestamp in "3. Last Refreshed"
    assert last_refreshed_value in time_series, f"Timestamp {last_refreshed_value} should be in the Time Series (5min)"
    
    expected_time_series_entry = test_config.TIME_SERIES_FIELDS
    # Verify the fields within the time series entry for the "3. Last Refreshed" timestamp
    if expected_time_series_entry:
        for field in expected_time_series_entry:
            assert field in time_series[last_refreshed_value], f"{field} should be in the time series data for {last_refreshed_value}"

