library(shinytest2)

test_that("{shinytest2} recording: popdens_date_slider", {
  app <- AppDriver$new(name = "popdens_date_slider", height = 882, width = 1619)
  app$set_inputs(popdenslider = c(0.137, 1000))
  app$set_inputs(dateslider = c("2020-01-01", "2021-09-27"))
  app$expect_values()
})


test_that("{shinytest2} recording: country_date_dropdown", {
  app <- AppDriver$new(name = "country_date_dropdown", height = 882, width = 1619)
  app$set_inputs(countrydropdown = "Afghanistan")
  app$set_inputs(dateslider = c("2020-01-01", "2021-07-25"))
  app$expect_values()
})

test_that("{shinytest2} recording: GDP_slider", {
  app <- AppDriver$new(name = "GDP_slider", height = 882, width = 1619)
  app$set_inputs(gdpslider = c(662, 55661))
  app$expect_values()
})

test_that("{shinytest2} recording: covid_viz_test_1", {
  app <- AppDriver$new(name = "covid_viz_test_1", height = 944, width = 1619)
  app$set_inputs(popdenslider = c(0.137, 1000))
  app$expect_values()
})



test_that("{shinytest2} recording: argentina", {
  app <- AppDriver$new(variant = platform_variant(), name = "argentina", height = 963, 
      width = 1407)
  app$set_inputs(countrydropdown = "Argentina")
  app$set_inputs(dateslider = c("2020-12-20", "2023-02-12"))
  app$expect_screenshot()
})



test_that("{shinytest2} recording: covid_viz", {
  app <- AppDriver$new(variant = platform_variant(), name = "covid_viz", height = 963, 
      width = 1407)
  app$set_inputs(gdpslider = c(662, 74661))
  app$set_inputs(popdenslider = c(200, 15400))
  app$set_inputs(dateslider = c("2021-07-30", "2023-02-12"))
  app$expect_screenshot()
})

