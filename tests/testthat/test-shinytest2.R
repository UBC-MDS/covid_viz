library(shinytest2)

test_that("{shinytest2} recording: covid_viz_slider", {
  app <- AppDriver$new(variant = platform_variant(), name = "covid_viz", height = 782, 
      width = 1211)
  app$set_inputs(gdpslider = c(662, 116935.6))
  app$set_inputs(popdenslider = c(662, 20546.766))
  app$set_inputs(popdenslider = c(0.137, 20546.766))
  app$set_inputs(dateslider = c("2020-08-12", "2023-02-12"))
  app$set_inputs(countrydropdown = "Hong Kong S.A.R.")
  app$expect_values()
  app$expect_screenshot()
})
