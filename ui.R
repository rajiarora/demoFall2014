library(shiny)

shinyUI(fluidPage(
  
  titlePanel("Interactive PCA Analysis of Sanger miRNA Data"),
  
  column(4, wellPanel(
    sliderInput("n", "Number of cell lines(sorted by number of samples):",
                min = 1, max = 20, value = 10, step = 1)
  )),
  
  column(5,
         "",
         
         # With the conditionalPanel, the condition is a JavaScript
         # expression. In these expressions, input values like
         # input$n are accessed with dots, as in input.n
         conditionalPanel("input.n >= 1",
                          plotOutput("scatterPlot", height = 640, width=640)
         )
  )
))