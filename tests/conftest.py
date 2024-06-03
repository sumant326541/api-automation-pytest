
"""
utility functions and fixture for test cases
"""
import pytest
import requests
import os
from dataclasses import dataclass, field
from typing import Sequence, Mapping


# constants
@dataclass()
class Config():
    """
       A configuration class to manage all the settings and data required for test execution.
    """
    BASE_URL: str = "https://www.alphavantage.co"
    INTRADAY_FUNCTION: str = "TIME_SERIES_INTRADAY"
    DAILY_FUNCTION: str = "TIME_SERIES_DAILY"
    SYMBOL_VALUE: str= "IBM"
    INTERVAL: Mapping[str, str] = field(default_factory=lambda : { "intraday":"5min", "daily":"Daily"})
    APIKEY: str = os.getenv("APIKEY", "demo")  # Read from environment, defaulting to "demo" if not found
    META_DATA_KEY: str = "Meta Data"
    LAST_REFRESHED_KEY: str = "3. Last Refreshed"
    LAST_REFRESHED_DAILY_TIME_FORMATE: str = "%Y-%m-%d"
    LAST_REFRESHED_INTRADAY_TIME_FORMATE: str = "%Y-%m-%d %H:%M:%S"
    INFORMATION_KEY:str = "1. Information"
    TIME_ZONE_VALUE: str = "US/Eastern"
    TIME_SERIES_KEY = "Time Series ({})"
    TIME_SERIES_FIELDS: Sequence[str]= field(default_factory=lambda: ["1. open", "2. high", "3. low", "4. close", "5. volume"])

    @property
    def META_DATA_FIELDS_DAILY(self)-> Mapping[str, str]:
        """
        This function returns the expected metadata for daily time-series data to be used in test case assertions.
        """
        return { 
        self.INFORMATION_KEY: self.INTERVAL["daily"].lower(),
        "2. Symbol": self.SYMBOL_VALUE,
        self.LAST_REFRESHED_KEY: "%Y-%m-%d",
        "4. Output Size": "Compact",
        "5. Time Zone": self.TIME_ZONE_VALUE
    }

    @property
    def META_DATA_FIELDS_INTRADAY(self) -> Mapping[str, str]:
        """
        This function returns the expected metadata for intraday time-series for use in testcase assertions.
        """
        return {
        self.INFORMATION_KEY: self.INTERVAL["intraday"],
        "2. Symbol": self.SYMBOL_VALUE,
        self.LAST_REFRESHED_KEY: "%Y-%m-%d %H:%M:%S",
        "4. Interval": self.INTERVAL["intraday"],
        "5. Output Size": "Compact",
        "6. Time Zone": self.TIME_ZONE_VALUE
    }

def _retrive_time_series_data(function: str):
    """
    Retrieves the API response for the specified function.

    Args:
        function (str): The type of function for which the API should be called. 
                        Valid values are 'daily' and 'intraday'.
    """
    test_config = Config()
    api_url = f"{test_config.BASE_URL}/query?function={function}&symbol={test_config.SYMBOL_VALUE}&apikey={test_config.APIKEY}"   
    if function.lower().__contains__("intraday"):
        api_url += f"&interval={test_config.INTERVAL['intraday']}"
    if function not in [test_config.INTRADAY_FUNCTION, test_config.DAILY_FUNCTION]:
        raise AttributeError(f"provided functin type {function} is invalid. valid function types are : {['intraday', 'daily']}")
    return requests.get(api_url)  


# Fixture for retrive daily data
@pytest.fixture(scope="session")
def fetch_daily_data(): 
    """
        fixture to retrive daily data
    """
    test_config = Config()
    response=_retrive_time_series_data(function= test_config.DAILY_FUNCTION)
    return response  

# Fixture for retrive intraday data
@pytest.fixture(scope="session")
def fetch_intraday_data():
    """
       fixture to retrive intraday data
    """
    test_config = Config()
    response=_retrive_time_series_data(function= test_config.INTRADAY_FUNCTION)
    return response 

@pytest.fixture(scope="session")
def test_config():
    """
       fixture to retrive all configuration data
    """
    return Config()

