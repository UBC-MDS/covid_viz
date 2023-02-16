# Description of the data

In this project, we are visualizing the COVID-19 dataset that is maintained by [_Our World in Data_](https://ourworldindata.org/coronavirus) which is present in the this [repository](https://github.com/owid/covid-19-data/tree/master/public/data). This dataset contains 59 columns corresponding to COVID-19 statistics such number of `vaccinations`, `confirmed cases`, `deaths`, `hospitalizations`, `reproduction rate`, `government policies in effect`, and other country specific information for over _219 countries_. These statistics are being updated constantly hence we restrict ourselves to the data collected from the start of the pandemic to **13-02-2023**. The main aim of the project is to give an overview of the ever changing COVID-19 situation in different countries to avid travelers so that they can arm themselves with the information required to plan their future travels safely. We have selected a subset of metrics of interest for our visualizations:

| Variable                         | Description
|:---------------------------------|:-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `location`                   | Geographical location|
| `date`                       | Date of observation|
| `total_cases`                    | Total confirmed cases of COVID-19. Counts can include probable cases, where reported.|
| `total_deaths`                    | Total deaths attributed to COVID-19. Counts can include probable deaths, where reported.|
| `stringency_index` | Government Response Stringency Index: composite measure based on 9 response indicators including school closures, workplace closures, and travel bans, rescaled to a value from 0 to 100 (100 = strictest response)|
| `people_vaccinated`                          | Total number of people who received at least one vaccine dose|
| `people_fully_vaccinated`                    | Total number of people who received all doses prescribed by the initial vaccination protocol|

All visualizations, data, and code produced by _Our World in Data_ are completely open access under the [Creative Commons BY license](https://creativecommons.org/licenses/by/4.0/).

