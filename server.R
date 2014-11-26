library(shiny)

load("miEset.Rda")
#miEset is an object called ExpressionSet which stores expression and information about data
#download this package called affy (ExpressionSet is from package affy)
library(affy)
exp = t(exprs(miEset))
#rows are different cell lines and columns are miRNAs (they are like genes)
#cell lines are from different cancer types
# exp is expression value of miRNAs in these cell lines

#PCA, but will have to play with it a little, not very good right now
p = prcomp(exp)
pc=p
names(p)
#change rownames of x from names of cell lines to names of tissues 
rownames(p$x) = pData(miEset)$tissue.name
as.fumeric <- function(x,levels=unique(x)) as.numeric(factor(x,levels=levels))
group = as.fumeric(rownames(p$x))
#all data

library(calibrate)

shinyServer(function(input, output) {
  
  output$scatterPlot <- renderPlot({
    numpoints <- input$n
    plot(pc$x[0:numpoints,1], pc$x[0:numpoints,2], main = "PCA", xlab = "PC1", ylab = "PC2", col=group)
    if (numpoints <= 50)
    {
      textxy(pc$x[0:numpoints, 1], pc$x[0:numpoints, 2],rownames(p$x)[51:100])
    }
  })
  
})