library(shiny)
library(shinythemes)
library(leaflet)
library(jsonlite)
library(showtext)
library(readr)

my_theme <-
  bslib::bs_theme(bootswatch = "darkly", base_font = font_add_google("Righteous"))
thematic::thematic_shiny(font = "auto")
data <- readr::read_csv("data/raw/owid-covid-data.csv")
data$date <- as.Date(data$date, format = "%Y/%m/%d")
geojson <- readLines("https://raw.githubusercontent.com/datasets/geo-countries/master/data/countries.geojson", warn = FALSE) |>
  paste(collapse = "\n") |>
  jsonlite::fromJSON(simplifyVector = FALSE)
# Finding values to populate the data input widgets
countries <- c("Worldwide")
for(feature_num in seq(length(geojson[[2]]))){
  countries <- append(countries, geojson[[2]][[feature_num]]$properties$ADMIN)
}
min_gdp <- min(data$gdp_per_capita, na.rm = TRUE)
max_gdp <- max(data$gdp_per_capita, na.rm = TRUE)
max_pop_density <- max(data$population_density, na.rm = TRUE)
min_pop_density <- min(data$population_density, na.rm = TRUE)
min_date <- min(data$date)
max_date <- max(data$date)

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
    worldwide <- TRUE
    lng <- 0
    lat <- 0
    zoom <- 2
    # if(input$countrydropdown != "Worldwide"){
    #   worldwide <- FALSE
    #   for(num in seq(length(countries)-1)){
    #     if(countries[num] == input$countrydropdown){
    #           lng <- 93.85532
    #           zoom <- 5
    #           lat<-7.214179
    #           break
    #     }
    #   }
    # }

    # geojson$style = list(
    #   weight = 1,
    #   color = "#555555",
    #   opacity = 1,
    #   fillOpacity = 0.8
    # )

    leaflet() |>
      setView(lng = lng, lat = lat, zoom = zoom) |>
      addTiles() |>
      addGeoJSON(geojson)

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
