# Covid Visulization Proposal


Group 12 members: Lennon Au-Yeung, Jenit Jain, Ashwin Babu, Bruce Wu  
In this proposal, we will explore the "Covid-19 World Vaccination Progress" dataset that monitors the global progress of Covid-19 vaccination efforts. The proposal will include a discussion of the motivation behind the project, a description of the data, and the research questions that will be explored using the dataset.  
 


## Motivation and Purpose


Stepping in 2023, Covid-19 is still a heated topic around the world. Despite the availability of vaccines, many parts of the world are still struggling to control the spread of the virus, and new variants continue to emerge. Furthermore, the pandemic has had far-reaching social, economic, and political influences that will continue to be felt for people from all walks of life. Since vaccination is a key strategy in combating the virus, we are interesting in creating a dashboard to monitor the global progress of Covid-19 vaccination efforts and finding the relationship among several indicators to inform public health policy and decision-making. The motivation behind this project is to provide real-time information about the global vaccination progress to researchers, policymakers, and individuals. The dashboard will offer insightful data that can be used to pinpoint areas and nations in need of more funding, encourage openness and accountability in the vaccination drive, and gain a better understanding of how vaccines are affecting the epidemic. Besides, travellers who are interested in assessing their risk of contacting the disease while travelling can access up-to-date information from the dashboard on the number of cases, deaths, and vaccination rates in different countries, and use this information to make informed decisions about their travels.  


## Description of the data


The "Covid-19 World Vaccination Progress" dataset we pick comes from the Github repository Our World in Data, which can be obtained [here](https://github.com/owid/covid-19-data/tree/master/public/data). 
The dataset contains daily time series data for various COVID-19 related indicators for countries all over the world. The dataset is updated regularly and provides a comprehensive record of the global vaccination effort against Covid-19. The variables we are interested are listed here:  
* 1.Location, which contained countries from all over the world  
* 2.Date, which is the date for the data entry  
* 3.Confirmed COVID-19 cases with levels such as total_cases and new_cases
* 4.Confirmed COVID-19 deaths with levels such as total_deaths and new_deaths
* 5.Vaccinations with levels such as people_vaccinated and people_fully_vaccinated
* 6.gdp_per_capita, which is the Gross domestic product at purchasing power parity
* 7.population_density, which is the number of people divided by land area


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
