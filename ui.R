library(shiny)

shinyUI(fluidPage(
  
  titlePanel("Conditional panels"),
  
  column(4, wellPanel(
    sliderInput("n", "Number of points:",
                min = 10, max = 550, value = 10, step = 10)
  )),
  
  column(5,
         "PCA Plot for Cancer Data",
         
         # With the conditionalPanel, the condition is a JavaScript
         # expression. In these expressions, input values like
         # input$n are accessed with dots, as in input.n
         conditionalPanel("input.n >= 10",
                          plotOutput("scatterPlot", height = 640, width=640)
         )
  )
))