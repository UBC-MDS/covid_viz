library(shiny)
library(shinythemes)
library(leaflet)
library(jsonlite)
library(showtext)
library(readr)
library(RColorBrewer)
library(lubridate)
library(dplyr)

my_theme <-
  bslib::bs_theme(bootswatch = "darkly", base_font = font_add_google("Righteous"))
thematic::thematic_shiny(font = "auto")
data <- readr::read_csv("data/raw/owid-covid-data.csv")
data$date <- ymd(data$date)
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
                   bins = seq(0,100,10))
min_gdp <- min(data$gdp_per_capita, na.rm = TRUE)
max_gdp <- max(data$gdp_per_capita, na.rm = TRUE)
max_pop_density <- max(data$population_density, na.rm = TRUE)
min_pop_density <- min(data$population_density, na.rm = TRUE)
min_date <- min(data$date)
max_date <- max(data$date)

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
  colors(100-value)
}


get_countries <- function(popden, gdp){
  data |> 
    filter(population_density <= popden & gdp_per_capita <= gdp) |>
    select(location) |>
    unique() |> pull()
}

ui <- shinyUI(fluidPage(
  theme = my_theme,
  titlePanel("Covid-19 Tracker Dashboard"),
  
  fluidRow(
    column(
      2,
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
        value = 1000
      ),
      sliderInput(
        inputId = "popdenslider",
        label = "Population Density slider",
        min = min_pop_density,
        max = max_pop_density,
        value = 1000
      ),
      style = "overflow-x: scroll; overflow-y: scroll"
    ),
    column(
      6,
      leaflet::leafletOutput("travelindexPlot", height = "550px"),
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
      plotOutput("casesPlot", width = "100%"),
      plotOutput("deathPlot"),
      plotOutput("vaccinePlot"),
      style = "overflow-x: scroll; overflow-y: scroll"
    )
  )
))

server <- function(input, output) {
  thematic::thematic_shiny()

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
            break
          }
        }
      }
    }
    map
  })
  
  output$casesPlot <- renderPlot({
    x    <- faithful[, 2]
    bins <- seq(min(x), max(x), length.out = 20 + 1)
    
    hist(
      x,
      breaks = bins,
      col = 'darkgray',
      border = 'white',
      main = "Number of Cases"
    )
  })
  
  output$deathPlot <- renderPlot({
    x    <- faithful[, 2]
    bins <- seq(min(x), max(x), length.out = 20 + 1)
    
    hist(
      x,
      breaks = bins,
      col = 'darkgray',
      border = 'white',
      main = "Number of Deaths"
    )
  })
  
  output$vaccinePlot <- renderPlot({
    x    <- faithful[, 2]
    bins <- seq(min(x), max(x), length.out = 20 + 1)
    
    hist(
      x,
      breaks = bins,
      col = 'darkgray',
      border = 'white',
      main = "Number of Vaccinations %"
    )
  })
}

shinyApp(ui = ui, server = server)
