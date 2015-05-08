library(shiny)

load("miEset.Rda")
#miEset is an object called ExpressionSet which stores expression and information about data
#download this package called affy (ExpressionSet is from package affy)
library(affy)
exp = t(exprs(miEset))
#rows are different cell lines and columns are miRNAs (they are like genes)
#cell lines are from different cancer types
# exp is expression value of miRNAs in these cell lines
rownames(exp)<-pData(miEset)$tissue.name
sortedgroup<-names(sort(table(pData(miEset)$tissue.name),dec=TRUE))
as.fumeric <- function(x,levels=unique(x)) as.numeric(factor(x,levels=levels))

#all data

library(calibrate)

shinyServer(function(input, output) {
  
  output$scatterPlot <- renderPlot({
    numpoints <- input$n
    topnames<-head((sortedgroup),numpoints)
  
    #PCA, but will have to play with it a little, not very good right now
    sexp<-exp[rownames(exp) %in% topnames,]
  
    psexp<-prcomp(sexp)
  
    #change rownames of x from names of cell lines to names of tissues 
    rownames(psexp$x)<-rownames(sexp)
  
     plotpointsx<-psexp$x[,1]
    plotpointsy<-psexp$x[,2]
    print(length(plotpointsx))
    colorsgroup=as.fumeric(topnames)
    plot(plotpointsx, plotpointsy, main = "PCA", xlab = "PC1", ylab = "PC2", pch=16,col=colorsgroup)
    legend("topright",topnames,col=colorsgroup,pch=16)
  })
  
})