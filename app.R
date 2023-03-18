suppressPackageStartupMessages({
  library(shiny)
  library(shinythemes)
  library(leaflet)
  library(jsonlite)
  library(showtext)
  library(readr)
  library(lubridate)
  library(dplyr)
  library(ggplot2)
  library(curl)
  })
  
my_theme <-
  bslib::bs_theme(bootswatch = "darkly", base_font = font_add_google("Righteous"))
thematic::thematic_shiny(font = "auto")
#Reading covid data and setting it as a global variable to access it inside all functions
data <- readr::read_csv("data/raw/owid-covid-data.csv")
data$date <- ymd(data$date)
#Reading GeoJSON data to get country boundaries
geojson <-
  readLines(
    "https://raw.githubusercontent.com/datasets/geo-countries/master/data/countries.geojson",
    warn = FALSE
  ) |>
  paste(collapse = "\n") |>
  jsonlite::fromJSON(simplifyVector = FALSE)
# Finding values to populate the data input widgets
countries <- c("Worldwide")
for (feature_num in seq(length(geojson[[2]]))) {
  countries <- append(countries, geojson[[2]][[feature_num]]$properties$ADMIN)
}

colors <- colorBin("RdYlGn", 
                   domain = list(0,100), 
                   bins = seq(0,100,10),
                   reverse = TRUE)
min_gdp <- min(data$gdp_per_capita, na.rm = TRUE)
max_gdp <- max(data$gdp_per_capita, na.rm = TRUE)
max_pop_density <- max(data$population_density, na.rm = TRUE)
min_pop_density <- min(data$population_density, na.rm = TRUE)
min_date <- min(data$date)
max_date <- max(data$date)

#' Get color corresponding to stringency index
#'
#' @param country Name of the country.
#' @param start_date Start Date of the interval.
#' @param end_date End Date of the interval.
#'
#' @return Return the color that corresponds to the stringency index at end_data.
#'         Very Stringent Country: Red
#'         Very Lenient Country: Green
get_color <- function(country,
                      start_date,
                      end_date) {
  filtered_df <- data |>
    filter(location == country) |> 
    filter(date %within% interval(start = ymd(start_date), end = ymd(end_date))) |> 
    filter(!is.na(stringency_index))
  
  if(nrow(filtered_df) == 0){
    value <- 0
  }
  else{
    value <-filtered_df[["stringency_index"]][[nrow(filtered_df)]]
    if(is.null(value)){
      value <- 0
    }
  }
  colors(value)
}


#' Get a list of countries
#'
#' @param popden The range of Population density
#' @param gdp The range of GDP per capita
#'
#' @return A unique list of countries whose population density and GDP lie in the above range
get_countries <- function(popden, gdp){
  data |> 
    filter(((population_density <= popden[2] & population_density >= popden[1]) & !is.na(population_density)) & 
             ((gdp_per_capita <= gdp[2] & gdp_per_capita >= gdp[1]) & !is.na(gdp_per_capita))) |>
    select(location) |>
    unique() |> pull()
}

#' get_cases - Get daily COVID-19 cases 
#' 
#' @param country The name of the country 
#' @param start_date The start date of the date range to filter
#' @param end_date The end date of the date range to filter 
#' @param gdp A numeric vector of length 2 specifying the range of GDP per capita to filter
#' @param popden A numeric vector of length 2 specifying the range of population density to filter 
#' @return A dataframe with the total cases grouped by date

get_cases <- function(country, start_date, end_date, gdp, popden) {
  filtered_df <- data %>%
    filter(location == country &
             date >= ymd(start_date) &
             date <= ymd(end_date) &
             (!is.na(gdp_per_capita) & gdp_per_capita >= gdp[1] & gdp_per_capita <= gdp[2]) &
             (!is.na(population_density) & population_density >= popden[1] & population_density <= popden[2])) %>%
    group_by(date) %>%
    summarise(total_cases = sum(total_cases, na.rm = TRUE))
  
  return(filtered_df)
}

#' get_deaths - Get daily COVID-19 deaths 
#' 
#' @param country The name of the country 
#' @param start_date The start date of the date range to filter
#' @param end_date The end date of the date range to filter 
#' @param gdp A numeric vector of length 2 specifying the range of GDP per capita to filter
#' @param popden A numeric vector of length 2 specifying the range of population density to filter 
#' @return A dataframe with the total deaths grouped by date

get_deaths <- function(country, start_date, end_date, gdp, popden) {
  filtered_df <- data %>%
    filter(location == country &
             date > ymd(start_date) &
             date < ymd(end_date) &
             (gdp_per_capita >= gdp[1] & gdp_per_capita <= gdp[2]) &
             (population_density >= popden[1] & population_density <= popden[2])) %>%
    select(date,total_deaths)
  
  return(filtered_df)
}

#' get_cases - Get daily COVID-19 vaccination rate 
#' 
#' @param country The name of the country 
#' @param start_date The start date of the date range to filter
#' @param end_date The end date of the date range to filter 
#' @param gdp A numeric vector of length 2 specifying the range of GDP per capita to filter
#' @param popden A numeric vector of length 2 specifying the range of population density to filter 
#' @return A dataframe with the vaccination rate by date

get_vaccinate_rate <- function(country, start_date, end_date, gdp, popden) {
  filtered_df <- data %>%
    filter(location == country &
             date > ymd(start_date) &
             date < ymd(end_date) &
             (gdp_per_capita >= gdp[1] & gdp_per_capita <= gdp[2]) &
             (population_density >= popden[1] & population_density <= popden[2])) %>%
    select(people_vaccinated_per_hundred) %>%
    mutate(people_vaccinated_per_hundred = 
             if_else(is.na(people_vaccinated_per_hundred) 
                     | people_vaccinated_per_hundred == 0, 
                     0, people_vaccinated_per_hundred))
  
  return(date,filtered_df)
}





ui <- shinyUI(fluidPage(
  theme = my_theme,
  titlePanel("Covid-19 Tracker Dashboard"),
  
  fluidRow(
    column(
      3,
      selectInput(
        inputId = "countrydropdown",
        label = "Country Dropdown",
        choices = countries
      ),
      sliderInput(
        inputId = "gdpslider",
        label = "GDP Slider",
        min = min_gdp,
        max = max_gdp,
        width = '90%',
        value = c(662, 2600)
      ),
      sliderInput(
        inputId = "popdenslider",
        label = "Population Density slider",
        min = min_pop_density,
        max = max_pop_density,
        width = '90%',
        value = c(200, 1000)
      ),
      style = "overflow-x: scroll; overflow-y: scroll"
    ),
    column(
      5,
      shinycssloaders::withSpinner(
      leaflet::leafletOutput("travelindexPlot", height = "650px")),
      sliderInput(
        inputId = "dateslider",
        label = "Date Slider",
        min = min_date,
        max = max_date,
        value =  c(min_date, max_date),
        width = '100%'
      ),
    ),
    column(
      4,
      shinycssloaders::withSpinner(plotOutput("casesPlot", width = "100%", height="300px")),
      shinycssloaders::withSpinner(plotOutput("deathPlot", height="300px")),
      shinycssloaders::withSpinner(plotOutput("vaccinePlot", height="300px")),
      downloadButton("downloadData", "Download Data"),
      # style = "overflow-x: scroll; overflow-y: scroll"
    )
  )
))

server <- function(input, output) {
  thematic::thematic_shiny()
  
  filtered_data <- reactive({
    
    # Filter data by country dropdown
    if (input$countrydropdown == "Worldwide") {
      filtered_df <- data %>%
        filter(date >= ymd(input$dateslider[1]) &
                 date <= ymd(input$dateslider[2]) &
                 (!is.na(gdp_per_capita) & (gdp_per_capita >= input$gdpslider[1] & gdp_per_capita <= input$gdpslider[2])) &
                 (!is.na(population_density) & (population_density >= input$popdenslider[1] & population_density <= input$popdenslider[2]))) %>%
        group_by(date) %>%
        summarise(total_cases = sum(total_cases, na.rm = TRUE),
                  total_deaths = sum(total_deaths, na.rm = TRUE),
                  vaccination_rate = unique(weighted.mean(people_vaccinated_per_hundred, population, na.rm = TRUE)))
    } else {
      filtered_df <- data %>%
        filter(location == input$countrydropdown &
                 date >= ymd(input$dateslider[1]) &
                 date <= ymd(input$dateslider[2])) %>%
        group_by(date) %>%
        summarise(total_cases = sum(total_cases, na.rm = TRUE),
                  total_deaths = sum(total_deaths, na.rm = TRUE),
                  vaccination_rate = ifelse(all(is.na(people_vaccinated_per_hundred)), NA, 
                                            max(people_vaccinated_per_hundred, na.rm = TRUE)))
    }
    
    return(filtered_df)
    
  })
  
  output$travelindexPlot <- renderLeaflet({
    map <- leaflet() |>
      setView(lng = 0,
              lat = 0,
              zoom = 1.5) |> 
      addTiles()
    
    if (input$countrydropdown != "Worldwide") {
      for (num in seq(2, length(countries))) {
        if (countries[num] == input$countrydropdown) {
          break
        }
      }
      country_json <- list(type = geojson[[1]],
                           features = list(geojson[[2]][[num - 1]]))
      country_json$style = list(
        weight = 1,
        fill = TRUE,
        fillColor = get_color(countries[num],
                              input$dateslider[[1]],
                              input$dateslider[[2]]),
        color = "black",
        opacity = 0.8,
        fillOpacity = 0.8
      )
      map <- map |> addGeoJSON(geojson = country_json)
    }
    else{
      filtered_countries <- get_countries(input$popdenslider, input$gdpslider)
      all_features <- list()
      final_countries = list()
      for(country in filtered_countries){
        for (num in seq(2, length(countries))) {
          if (countries[num] == country) {
            country_json <- list(type = geojson[[1]],
                                 features = list(geojson[[2]][[num - 1]]))
            country_json$style = list(
              weight = 1,
              fill = TRUE,
              fillColor = get_color(country,
                                    input$dateslider[[1]],
                                    input$dateslider[[2]]),
              color = "black",
              opacity = 0.8,
              fillOpacity = 0.8
            )
            map <- map |> addGeoJSON(geojson = country_json)
          }
        }
      }
    }
    map |>
      addLegend(pal = colors, 
                values = c(0,100), 
                opacity = 1.0, 
                title = "Stringency Index")
    
  })
  
  
  # Plot filtered cases data
  output$casesPlot <- renderPlot({
    data <- filtered_data()
    data$rolling_avg <- zoo::rollmean(data$total_cases, k = 120, fill = NA, align = "right")
    # add a rolling mean quarterly to the plot
    ggplot(data, aes(x=date)) +
      geom_line(aes(y=total_cases, color="Daily Cases")) +
      geom_line(aes(y=rolling_avg, color="Rolling Mean"), size=1.5) +
      ggtitle("Total Confirmed Cases") +
      xlab("Date") +
      ylab("Total Cases")+
      theme_minimal() +
      theme(plot.title = element_text(size = 20, hjust = 0.5, color = "white"),
            axis.title.x = element_text(size = 16,color = "white"),
            axis.title.y = element_text(size = 16, color = "white"),
            axis.text = element_text(size = 14, color = "white"),
            legend.title = element_blank(),
            legend.text = element_text(size = 8,color="white"),
            legend.position = c(0.9, 0.85),
            legend.background = element_rect(fill = "transparent", color = NA),
            legend.box.background = element_rect(fill = "transparent", color = NA),
            legend.direction = "vertical")
  })
  
  # Plot filtered death data
  output$deathPlot <- renderPlot({
    data <- filtered_data()
    data$rolling_mean <- zoo::rollmean(data$total_deaths, 120, na.pad = TRUE)
    # add a rolling mean quarterly to the plot
    ggplot(data, aes(x = date)) +
      geom_line(aes(y=total_deaths, color="Daily Deaths")) +
      geom_line(aes(y=rolling_mean, color="Rolling Mean"), size=1.5) +
      ggtitle("Total Confirmed Deaths") +
      xlab("Date") +
      ylab("Total Deaths") +
      theme_minimal() +
      theme(plot.title = element_text(size = 20, hjust = 0.5, color = "white"),
            axis.title.x = element_text(size = 16,color = "white"),
            axis.title.y = element_text(size = 16, color = "white"),
            axis.text = element_text(size = 14, color = "white"),
            legend.title = element_blank(),
            legend.text = element_text(size = 8,color="white"),
            legend.position = c(0.9, 0.85),
            legend.background = element_rect(fill = "transparent", color = NA),
            legend.box.background = element_rect(fill = "transparent", color = NA),
            legend.direction = "vertical")
  })
  
  # Plot filtered Vaccination rate data
  
  output$vaccinePlot <- renderPlot({
    ggplot(filtered_data(), aes(x=date, y=vaccination_rate)) +
      geom_line() +
      ggtitle("Vaccination rate") +
      xlab("Date") +
      ylab("Vaccination rate")+
      theme_minimal() +
      theme(plot.title = element_text(size = 20, hjust = 0.5,color = "white"),
            axis.title.x = element_text(size = 16,color = "white"),
            axis.title.y = element_text(size = 16,color = "white"),
            axis.text = element_text(size = 14, color = "white"),
            legend.title = element_blank(),
            legend.text = element_text(size = 14))
  })
  # Add download button
  output$downloadData <- downloadHandler(
    filename = function() {
      paste("filtered_data_", Sys.Date(), ".csv", sep="")
    },
    content = function(file) {
      write.csv(filtered_data(), file, row.names=FALSE)
    }
  )
}

shinyApp(ui = ui, server = server)

