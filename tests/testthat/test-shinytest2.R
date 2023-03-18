library(shinytest2)

test_that("{shinytest2} recording: popdens_date_slider", {
  app <- AppDriver$new(name = "popdens_date_slider", height = 882, width = 1619
                       ,load_timeout = 2e+05)
  app$set_inputs(popdenslider = c(0.137, 1000))
  app$set_inputs(dateslider = c("2020-01-01", "2021-09-27"))
  app$expect_values()
})


test_that("{shinytest2} recording: country_date_dropdown", {
  app <- AppDriver$new(name = "country_date_dropdown", height = 882, width = 1619
                       ,load_timeout = 2e+05)
  app$set_inputs(countrydropdown = "Afghanistan")
  app$set_inputs(dateslider = c("2020-01-01", "2021-07-25"))
  app$expect_values()
})

test_that("{shinytest2} recording: GDP_slider", {
  app <- AppDriver$new(name = "GDP_slider", height = 882, width = 1619
                       ,load_timeout = 2e+05)
  app$set_inputs(gdpslider = c(662, 55661))
  app$expect_values()
})