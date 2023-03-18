# Reflections: 2023-03-04 (Updated 2023-03-04)

## Things that we have implemented 
- The app utilizes interactive widgets, such as sliders and date range input, that enable enthusiastic travelers (who want to check the status of countries they want to visit) to filter data based on their interests. This allows the travelers to select the date range, GDP of countries they are interested in, population density of countries they are interested in and also have an option to look at a specific country if needed by selecting from the list.
- The app offers multiple visualization options based on user selections. For instance, travelers can visualize the stringency index of countries, given a date range the color coded map would show how risky it would be to travel based on the max date the user provides, the app will also show the graphs for number of cases, vaccination percentage and number of deaths in the user provided date range. 
- The app also provides map representation (the stringency index) for visualization. In addition, we use thematic to enhance the aesthetics of the dashboard, resulting in a more professional and visually appealing interface.
- The user has the leverage to visualize all of the countries at once by changing the GDP, population density and selecting the Worldwide option if they want to look at the overall world scenario.
- Dashboard layout is simple and doesn't overwhelm the user.

## Weakness in our Dashboard
- One weakness of our dashboard is that it can be difficult to differentiate/read the name between countries on the map as their size is not immediately visible. Users need to hover their mouse over each country to see its size and name or zoom into map. To address this, we could consider making the countries static so that their sizes are visible at all times.
- Another weakness is the time taken to render the worlwide data, since the dataset is huge we have made the default values when you open the app such that it wouldn't take much time for the default render, but once you change the sliders and options it will get reflected on the map plot as well as the other plots but might take a little time to render because of the size of dataset.


## Future Improvements
- Initially we wanted to as give the user a text box which would give you the exact number of cases, vaccination percent and deaths depending on your selection apart from the graphs. But the dataset has a lot of missing values hence providing this feature would be not useful unless we manipulate the data using various imputation methods and then add this text box feature for the end user. This is something we can definitely work on in the future enhancements of the Dashboard.
- Currently our map plot is non-interactive, you can definitely zoom in to check the country names and scroll, but in future an interactive map plot for the travelers would be a very useful tool.
- Currently we have a few data missing at the country level and collecting this data in future would enhance the reliability to accurately represent the situation on country level.