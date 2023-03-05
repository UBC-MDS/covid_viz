# COVID Visualization Dashboard

## Authors

-   Jenit Jain
-   Ashwin Babu
-   Bruce Wu
-   Lennon Au-Yeung

## Welcome!

Thank you for visiting our repository! This document (README.md) will have all the general information you need to know about our dashboard. You can either scroll down or click from the links below to jump to a specific section:

-   [Overview](#overview)
-   [Project Motivation](#project-motivation)
-   [Dashboard Sketch](#dashboard-sketch)
-   [Getting Involved](#get-involved)
-   [Contributing](#contributing)
-   [License](#license)

## Overview {#overview}

This repository hosts the dasbhaord for COVID-19 data released by [*Our World in Data*](https://ourworldindata.org/coronavirus) which is present in the this [repository](https://github.com/owid/covid-19-data/tree/master/public/data) and are completely open access under the [Creative Commons BY license](https://creativecommons.org/licenses/by/4.0/). The motivation, purpose, description of data and research question can be found in our [proposal](reports/proposal.md).

## Project Motivation {#project-motivation}

This R-based dashboard is designed to provide travelers with COVID-19 information for them to assess their risk of contacting the disease while traveling to different countries. We have designed our dashboard to give the user flexibility to compare the number of cases, deaths and vaccinations percentage from different countries using the drop-down menus on the left. If users are interested to know if countries with similar characteristics have similar COVID-19 statistics, they can used the slider to filter countries based on their GDP and population density. There is also a date slider in the bottom of the dashboard to allow users to select a date interval if they are interested in knowing the progress of the pandemic in its earlier stages.

We are aiming to create 3 types of visualizations for within the dashboard. The first type is line graphs showing the progression of COVID-19 cases, deaths and vaccinations percentages according to the filters applied. The second type is a heatmap of the world map showing the travel stringency index of the world which reflects the strictness of government response due to the pandemic. The last type of visualization is number boxes showing the number of COVID-19 cases, deaths and vaccinations percentages according to the filters applied.

*The brief questions answered by this dashboard would be:* - As a traveler one would want to know the current COVID stringency situation at the destination country. - Study the impact of COVID on different countries based on GDP and population density. - Study a particular country based on timeline to see how it was impacted over the months due to COVID.


<br>

## Dashboard Sketch {#dashboard-sketch}

<img src="img/dashboard_sketch.png"/>

## Get involved {#get-involved}

**How to run the app locally and make contributions**

If you would like to contribute to our project, please read the
CONTRIBUTING.md file and then follow these steps: - Ensure that you have
R and Rstudio installed on your computer - Fork our repository and [clone](https://github.com/UBC-MDS/covid_viz.git)
it onto your computer - Create a new branch (named according to the
specifications in the CONTRIBUTING.md file)

*To run the app locally:* - Open the project (i.e., the app.R file) in
Rstudio - Ensure all the necessary packages are installed

    install.packages(c("shiny", "bslib", "shinythemes", "shinydashboard", "ggplot2", "leaflet", "jsonlite", "thematic", "showtext", "readr", "lubridate", "dplyr"))

-   Click "Run App"

*To propose new changes:* - Make your changes to the code in Rstudio -
Commit your changes (with an informative commit message) - Push your
changes to your fork - Submit a pull request

**Places for improvement** - Build upon the current map plot and add interactive elements to the plot. -
Help in accumulating the missing data on country level and add text box widget for the cases, vaccination percentage and deaths according to the user selection.


## Contributing{#contributing}

Interested in contributing? Check out the [contributing guidelines](CONTRIBUTING.md). Please note that this project is released with a Code of Conduct. By contributing to this project, you agree to abide by its terms.

# License{#license}

`covid_viz` was created by Jenit Jain, Ashwin Babu, Bruce Wu and Lennon Au-Yeung. It is licensed under the terms of the [MIT license](LICENSE).
