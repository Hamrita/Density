
library(shinysky)
library(shiny)
library(plotly)
library(ggplot2)
library(ggfortify)

shinyUI(fluidPage(
  
  titlePanel("Distribution Viewer"),
  
  sidebarLayout(
    
    sidebarPanel(
      selectInput("dist",label=h4("Distribution"),
                  choices=c("Normal"="dnorm", "Student t" = "dt","Chi-Squared" = "dchisq",
                            "Exponential" = "dexp","Fisher" = "df"),selected="dnorm"),       
      
      conditionalPanel(condition = "input.dist=='dnorm'",
                       numericInput("p1.norm","Mean",0)),
      conditionalPanel(condition = "input.dist=='dnorm'",
                       numericInput("p2.norm","Standard Deviation",1,min = 0)),
      conditionalPanel(condition = "input.dist=='dt'",
                       numericInput("p1.t","DF",5,min=1)),
      conditionalPanel(condition = "input.dist=='dchisq'",
                       numericInput("p1.chisq","DF",5,min=1)),    
      conditionalPanel(condition = "input.dist=='dexp'",
                       numericInput("p1.exp","Rate",1,min=0)),
      conditionalPanel(condition = "input.dist=='df'",
                       numericInput("p1.f","Num DF",20,min=1)),
      conditionalPanel(condition = "input.dist=='df'",
                       numericInput("p2.f","Denom DF",20,min=1)),
      
      actionButton("go","Submit"),
      
      div(a(href="https://github.com/Hamrita",target="_blank", 
            "Mohamed Essaied Hamrita"),align="left", style = "font-size: 8pt"),
      
      div( a(href="https://github.com/Hamrita/Density.git",
             target="_blank","View Code"),align="leftt", style = "font-size: 10pt")
      
    ),
    
    mainPanel(
      plotlyOutput("distPlot")
      
      
    )
    
  )
))