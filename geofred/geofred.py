import os, logging
from typing import Union, List

import pandas as pd
import fred

from geofred.utils import (
    do_search,
    parse_fred_title, 
    get_locations_df, 
    make_valid_zip
)


def search(term: Union[str, List[str]], **kwargs): 
    df_search_results = do_search(term, **kwargs) 

    # apply filters
    if "locations" in kwargs.keys(): 
        locations = kwargs.pop("locations")
        df_search_results = df_search_results.loc[df_search_results["location"].isin(locations), :]
    if "sa" in kwargs.keys(): 
        sa = kwargs.pop("sa")
        df_search_results = df_search_results.loc[df_search_results["seasonal_adjustment_short"] == sa, :]
    if "agg" in kwargs.keys(): 
        agg = kwargs.pop("agg")
        df_search_results = df_search_results.loc[df_search_results["aggregation"] == agg, :]
    if "topic" in kwargs.keys(): 
        topics = kwargs.pop("topic")
        df_search_results = df_search_results.loc[df_search_results["topic"] == topics, :]
    return df_search_results.reset_index()


def locations(zips): 
    """Return a dataframe of relevant location information. 
    
    :param zips: a pandas Series object of zipcodes. 
    """
    zips = zips.apply(make_valid_zip).drop_duplicates().sort_values().values
    loc_df = get_locations_df()
    idxs = loc_df['zip'].isin(zips)
    return loc_df.loc[idxs, :].reset_index(drop=True)


def join_data(*args): 
    return pd.concat(args, axis=1)
