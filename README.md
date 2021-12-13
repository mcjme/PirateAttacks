# Attacks on Maritime Vessels

**Attacks on Maritime Vessels** is an interactive map built on shiny, allowing you to customize the time range and attack types to filter pirate attack reports. The interactive plot reflects pirate attacks by month for the filter selections. 

**Attacks on Maritime Vessels** is built with Shiny and ShinyDashboard. 

# Data

The Crime at Sea: A Global Database of Maritime Pirate Attacks contains  7,391 documented attacks collected from the International Maritime Bureau (IMB) between January 1994 and December 2020, as well as country indicator data for the same time period. The pirate attack data was augmented with geospatial data. The country indicator data was sourced from a variety of sources, to include the World Bank. The data is contained in Comma Separated Values (CSV) files. The data was obtained from: 

Benden, P., Feng, A., Howell, C., & Dalla Riva G. V. (2021). Crime at Sea: A Global Database of Maritime Pirate Attacks (1993–2020). Journal of Open Humanities Data, 7: 19, pp. 1–6. DOI: https://doi.org/10.5334/johd.39

# Codebook

**Pirate Attacks**
* Date [Key] - Date of Attack. Used as a key with the Country Matrix data frame.
* Time - Time the attack took place, either in UTC or Local Time.
* Longitude - Longitude where the attack took place.
* Latitude - Latitude where the attack took place.
* Attack Type - Either NA (Missing), Attempted, Boarding, or Hijacked.
* Location Description - A text description of the location. With attacks taking place at sea, it is not as simple as just naming a city or town.
* Nearest Country [Key] - The country code whose shore is closest to the attack. The resolution is around 1 km, it can be much better depending on how detailed the mapping of the coast is in the vicinity.
* EEZ Country [Key] - The Exclusive Economic Zone country code in which the attack took place, if it took place within an EEZ.
* Shore Distance - Distance in kilometres to the shore from the attack location. This is the true geographic distance over the surface of the earth.
* Shore Longitude - The longitude of the closest point on the shore to the attack.
* Shore Latitude - The latitude of the closest point on the shore to the attack.
* Attack Description - The text description of the attack if it exists.
* Vessel Name - The name of the ship which was attacked if it is known.
* Vessel Type - The type of vessel attacked if known.
* Vessel Status - The status of the ship at the time it was attacked. Either NA (Missing), Berthed (Tied to a berth), Anchored (anchored at sea or in a harbour), or Steaming (ship underway).

**Country Indicators** 
* Country [Key] - The country in ISO3 country code format.
* Corruption Index - Corruption Perceptions Index.
* Homicide Rate - Total Intentional Homicides per 100,000 people.
* GPD - Gross Domestic Product (US Dollars).
* Total Fisheries Per Ton - Total Fisheries Production (metric tons).
* Total Military - Total Number of Armed Forces personnel.
* Population - Country Population.
* Unemployment Rate - Percentage of the Country Unemployed.
* Total GR - Total Government Revenue. An indication of how well the country collects taxes.
* Industry - Industrial contribution to total GDP.
