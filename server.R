#####################################################
# Shiny app for Some continuous Distribution Viewer #
#           Author: Mohamed Essaied Hamrita         #
#####################################################



library(shiny)


shinyServer(function(input, output, session) {
  output$distPlot <- renderPlotly({
    input$go
    
    isolate({
      # each distribution has its owen parameters
      # so I create lists that contain them based on the distribution.
      params = switch(input$dist,
                      "dnorm" = list(input$p1.norm,input$p2.norm,min=-4,max=4),
                      "dt" = list(input$p1.t,min=-3,max=3),
                      "dchisq"=list(input$p1.chisq,min=0,max=40),
                      "dexp" = list(input$p1.exp,min=0,max=20),
                      "df"=list(input$p1.f,input$p2.f,min=0,max=20)             
                      )
      # title of the plot
      TITLE=switch(input$dist,
                   "dnorm" = "Normal",
                   "dt" = "Student t",
                   "dchisq"="Chi-Squared",
                   "dexp" = "Exponential",
                   "df"="Fisher"             
      )
      # sequence applied 
      xindex=seq(params$min,params$max,len=500)
      # apply a "func" to obtain y vector using sapply() function
      if(input$dist=="dnorm"){
        xx=sapply(xindex, "dnorm", mean=params[[1]], sd=params[[2]])
      }else if(input$dist=="df") {
        xx=sapply(xindex, "df",df1=params[[1]], df2=params[[2]])
      }else{
        xx=sapply(xindex,input$dist,params[[1]])
      }
      # ggplotly
      gg=ggplot(data.frame(xx), aes(x=xindex, y=xx))+
          geom_line(colour="blue")+
          labs(title=paste(TITLE, "Density Distribution", sep=" "), x="",y="")
      ggplotly(gg)
      
 
      
    })
  })
  
})