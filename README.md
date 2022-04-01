# GeoFRED 

This library helps to parse out the series titles into topics, locations, and levels of aggregations (i.e. geography types) and returns `pandas.DataFrame` objects.

It has the following main function groups:
1. **Search**. Input topics and some optional constraints (e.g. seasonal adjustment, frequency, geography type) and receive a dataframe with the relevant FRED series IDs along with their metadata, including parsed location information. 
1. **Data**. Get a panel dataframe of all relevant data series from FRED. This has the following columns: series ID, date, topic, value, location, aggregation. This can take as input either the dataframe result of a previous "search" call, or the raw topics and constraints that you would otherwise pass to "search". 
1. **Locations**. Input an array of zip codes (as strings), and return a dataframe of the corresponding counties, MSA regions, and state identifies. 

### Interface 

#### Search 

- `search(topic, **kwargs): -> pandas.DataFrame`. Search for a topic with various optional filters and get the relevant FRED series IDs. 
  - Input
    - `topic: Union[str, List[str]]`. A topic (or topics) to search against FRED's database (e.g. "Unemployment Rate")
    - Additional filters currently include: 
      - `"api_key"`: your assigned FRED api key. 
      - `"locations"`: specific locations you want to 
      - `"sa"`
      - `"agg"`
      - `"freq"`
      - `"topic"`
  - Output 
    - A `pandas.DataFrame` with the following columns: 
      - `id`: the FRED series ID. 
      - ... 

#### Data 

- `data(topics: List[str], **kwargs)`
- `data(id_df: pandas.DataFrame, **kwargs)`

#### Locations

- `locations(zips: List[str])`