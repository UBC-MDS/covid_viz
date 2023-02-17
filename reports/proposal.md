# Covid Visulization Proposal


Group 12 members: Lennon Au-Yeung, Jenit Jain, Ashwin Babu, Bruce Wu  
In this proposal, we will explore the "Covid-19 World Vaccination Progress" dataset that monitors the global progress of Covid-19 vaccination efforts. The proposal will include a discussion of the motivation behind the project, a description of the data, and the research questions that will be explored using the dataset.  
 


## Motivation and Purpose


Stepping in 2023, Covid-19 is still a heated topic around the world. Despite the availability of vaccines, many parts of the world are still struggling to control the spread of the virus, and new variants continue to emerge. Furthermore, the pandemic has had far-reaching social, economic, and political influences that will continue to be felt for people from all walks of life. Since vaccination is a key strategy in combating the virus, we are interesting in creating a dashboard to monitor the global progress of Covid-19 vaccination efforts and finding the relationship among several indicators to inform public health policy and decision-making. The motivation behind this project is to provide real-time information about the global vaccination progress to researchers, policymakers, and individuals. The dashboard will offer insightful data that can be used to pinpoint areas and nations in need of more funding, encourage openness and accountability in the vaccination drive, and gain a better understanding of how vaccines are affecting the epidemic. Besides, travellers who are interested in assessing their risk of contacting the disease while travelling can access up-to-date information from the dashboard on the number of cases, deaths, and vaccination rates in different countries, and use this information to make informed decisions about their travels.  


## Description of the data
In this project, we are visualizing the COVID-19 dataset that is maintained by [_Our World in Data_](https://ourworldindata.org/coronavirus) which is present in the this [repository](https://github.com/owid/covid-19-data/tree/master/public/data). This dataset contains 59 columns corresponding to COVID-19 statistics such number of `vaccinations`, `confirmed cases`, `deaths`, `hospitalizations`, `reproduction rate`, `government policies in effect`, and other country specific information for over _219 countries_, which provides a comprehensive record of the global vaccination effort against Covid-19. These statistics are being updated constantly hence we restrict ourselves to the data collected from the start of the pandemic to **13-02-2023**. The main aim of the project is to give an overview of the ever changing COVID-19 situation in different countries to avid travelers so that they can arm themselves with the information required to plan their future travels safely. We have selected a subset of metrics of interest for our visualizations:

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


## Research questions and usage scenarios


* 1.How does vaccination progress vary by region and country, and what factors contribute to the variation?
* 2.What factors are associated with higher COVID-19 mortality rates in different countries, such as population density or GDP?
* 3.How has the vaccination progress changed over time, and what are the trends in global vaccination efforts against Covid-19?
* 4.What is the relationship between vaccination rates and the number of COVID-19 cases and deaths in different countries?
* 5.How has the travel stringency index varied over time, and how has this affected the spread of COVID-19 in different countries?


For example, policymakers with our application can use the data to evaluate the effectiveness of different interventions, such as banning and accepting certain vaccinations, and make evidence-based decisions about when and how to implement these interventions.


Emma is a traveller who is planning a business trip to several countries in Europe and wants to know the risk of contacting COVID-19 during her travels. She decides to use the dashboard to help her make informed decisions. From the dashboard, Emma can get an overview of the number of cases, deaths, and vaccination rates globally. This will allow her to see which countries have higher or lower numbers of cases, deaths, and vaccination rates. Besides, the dashboard allows Emma to see whether the global situation is improving or worsening and to identify any patterns or changes over time. Finally, Emma can use the dashboard to plan her travels by identifying countries with lower numbers of cases, deaths, and higher vaccination rates. This will allow her to make informed decisions about where to travel and to take necessary precautions to minimize the risk of contacting COVID-19.

```R

```
