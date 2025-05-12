{% docs region_id %}
This field is from Zillow's [for-sale inventory](https://www.zillow.com/research/data/). Not clear what this means-probably internal to Zillow. 

{% enddocs %}

{% docs size_rank %}
This field is from Zillow's [for-sale inventory](https://www.zillow.com/research/data/). Most likely ranking the regions (cities, usually) by how densely populated they are, but Zillow doesn't have a great data dictionary. 

{% enddocs %}

{% docs region_name %}
This field is from Zillow's [for-sale inventory](https://www.zillow.com/research/data/). Usually lists a city and a state.

{% enddocs %}

{% docs region_type %}
This field is from Zillow's [for-sale inventory](https://www.zillow.com/research/data/). Unclear what it means--no great data dictionary from Zillow.

{% enddocs %}

{% docs state_name %}
This field is from Zillow's [for-sale inventory](https://www.zillow.com/research/data/). Two-letter abbreviation for a US state.

{% enddocs %}

{% docs year_month %}
This field is derived from Zillow's [for-sale inventory](https://www.zillow.com/research/data/). In this table, individual column entries are a 4 digit year, a dash, and a 2 digit month. In Zillow's original data, there are a gazillion columns and each column corresponds to monthly or weekly housing inventory updates. I think that's a batshit crazy way to store data so I pivoted it. 

{% enddocs %}

{% docs no_homes_for_sale %}
This field is derived from Zillow's [for-sale inventory](https://www.zillow.com/research/data/). In Zillow's original data, this column doesn't exist--it's individual values underneath columns corresponding to dates. I pivoted it and called the column something a bit more sensical. 

{% enddocs %}