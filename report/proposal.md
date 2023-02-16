# Covid Visulization Proposal


Group 12 members: Lennon Au-Yeung, Jenit Jain, Ashwin Babu, Bruce Wu  
In this proposal, we will explore the "Covid-19 World Vaccination Progress" dataset that monitors the global progress of Covid-19 vaccination efforts. The proposal will include a discussion of the motivation behind the project, a description of the data, and the research questions that will be explored using the dataset.  
 


## Motivation and Purpose


Stepping in 2023, Covid-19 is still a heated topic around the world. Despite the availability of vaccines, many parts of the world are still struggling to control the spread of the virus, and new variants continue to emerge. Furthermore, the pandemic has had far-reaching social, economic, and political influences that will continue to be felt for people from all walks of life. Since vaccination is a key strategy in combating the virus, we are interesting in creating a dashboard to monitor the global progress of Covid-19 vaccination efforts and finding the relationship among several indicators to inform public health policy and decision-making. The motivation behind this project is to provide real-time information about the global vaccination progress to researchers, policymakers, and individuals. The dashboard will offer insightful data that can be used to pinpoint areas and nations in need of more funding, encourage openness and accountability in the vaccination drive, and gain a better understanding of how vaccines are affecting the epidemic. 


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
* 2.What is the relationship between the number of vaccines used and the number of people fully vaccinated, and how does this vary by country and vaccine manufacturer?
* 3.How has the vaccination progress changed over time, and what are the trends in global vaccination efforts against Covid-19?
* 4.What is the effect of different vaccine brands on the global range, and which vaccines are being used most widely around the world?


For example, policymakers with our application can use the data to evaluate the effectiveness of different interventions, such as banning and accepting certain vaccinations, and make evidence-based decisions about when and how to implement these interventions.


Bruce is a concerned citizen who wants to stay informed about the COVID-19 pandemic in his country, he is not fully vaccinated and he wants to know which vaccination is the most effective one in his country. With the assistance of our application, he can immediately find his answer by reading the plot displayed in the dashboard.  

```R

```
