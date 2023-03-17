library(shinytest2)

test_that("{shinytest2} recording: gdpslider", {
  app <- AppDriver$new(variant = platform_variant(), name = "covid_viz", height = 782, 
      width = 1211)
  app$set_inputs(gdpslider = c(662, 116935.6))
  app$expect_values()
  app$expect_screenshot()
})

test_that("{shinytest2} recording: popdenslider", {
  app <- AppDriver$new(variant = platform_variant(), name = "covid_viz", height = 782, 
      width = 1211)
  app$set_inputs(popdenslider = c(0.137, 20546.766))
  app$expect_values()
  app$expect_screenshot()
})

test_that("{shinytest2} recording: dateslider", {
  app <- AppDriver$new(variant = platform_variant(), name = "covid_viz", height = 782, 
      width = 1211)
  app$set_inputs(dateslider = c("2020-08-12", "2023-02-12"))
  app$expect_values()
  app$expect_screenshot()
})

test_that("{shinytest2} recording: countrydropdown", {
  app <- AppDriver$new(variant = platform_variant(), name = "covid_viz", height = 782, 
      width = 1211)
  app$set_inputs(countrydropdown = "Hong Kong S.A.R.")
  app$expect_values()
  app$expect_screenshot()
})
