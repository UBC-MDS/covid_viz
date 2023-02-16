library(shiny)
library(shinythemes)
library(showtext)

my_theme <- bslib::bs_theme(bootswatch = "darkly",base_font = font_add_google("Righteous"))
thematic::thematic_shiny(font = "auto")

ui <- shinyUI(fluidPage(
  theme = my_theme,
  titlePanel("Covid-19 Tracker Dashboard"),
  
  fluidRow(
    column(2,
           selectInput(
             inputId = "countrydropdown",
             label = "Country Dropdown",
             choices = list(1,2,3,4,5,6,7,8)
           ),
           sliderInput(
             inputId = "gdpslider",
             label = "GDP Slider",
             min = 0,
             max = 10,
             value = 5
           ),
           sliderInput(
             inputId = "popdenslider",
             label = "Population Density slider",
             min = 0,
             max = 10,
             value = 5
           ),
           style="overflow-x: scroll; overflow-y: scroll"),
    column(6,
           plotOutput("travelindexPlot"),
           sliderInput(
             inputId = "dateslider",
             label = "Date Slider",
             min = 0,
             max = 100,
             value =  c(40, 60),
             width = '100%'),
           ),
    column(4,
           plotOutput("casesPlot", width = "100%"),
           plotOutput("deathPlot"),
           plotOutput("vaccinePlot"),
           style="overflow-x: scroll; overflow-y: scroll")
  )
))

server <- shinyServer(function(input, output) {
  
  thematic::thematic_shiny()
  
  output$travelindexPlot <- renderPlot({
    x    <- faithful[, 2] 
    bins <- seq(min(x), max(x), length.out = 20 + 1)
    
    hist(x, breaks = bins, col = 'darkgray', border = 'white', main = "Travel Stringency Index")
  })
  
  output$casesPlot <- renderPlot({
    x    <- faithful[, 2] 
    bins <- seq(min(x), max(x), length.out = 20 + 1)
    
    hist(x, breaks = bins, col = 'darkgray', border = 'white', main = "Number of Cases")
  })
  
  output$deathPlot <- renderPlot({
    x    <- faithful[, 2] 
    bins <- seq(min(x), max(x), length.out = 20 + 1)
    
    hist(x, breaks = bins, col = 'darkgray', border = 'white', main = "Number of Deaths")
  })
  
  output$vaccinePlot <- renderPlot({
    x    <- faithful[, 2] 
    bins <- seq(min(x), max(x), length.out = 20 + 1)
    
    hist(x, breaks = bins, col = 'darkgray', border = 'white', main = "Number of Vaccinations %")
  })
})

