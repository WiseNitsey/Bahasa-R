library(shiny)
library(ggplot2)
library(datasets)

data(iris)
iris

data(mtcars)
mtcars

data(CO2)
CO2

ui=fluidPage(
  titlePanel("plotting in shiny"),
  sidebarLayout(
    sidebarPanel(
      selectInput('datanya','pilih dataset yang diinginkan', choices = c('iris','mtcars','CO2'))
    ), 
    mainPanel(
      plotOutput('hasil')
    )
  )
)

server = function(input,output){
  selectedData= reactive({
    switch( input$datanya, 'iris'=iris,'mtcars'=mtcars,'CO2'=CO2)
  })
  plotData=reactive({
    data=selectedData()
    if(input$datanya=='iris'){
      x_col= 'Sepal.Length'
      y_col= 'Sepal.Width'
    } else if (input$datanya=='mtcars'){
      x_col='mpg'
      y_col='disp'
    } else {
      x_col='uptake'
      y_col='conc'
    }
      return(data.frame(x=data[,x_col],y=data[,y_col]))
  })
  output$hasil=renderPlot({
    ggplot(plotData(), aes(x,y))+
      geom_point()+
      labs(title=paste('ini adalah hasil plot'), input$datanya)
  })
}

shinyApp(ui=ui, server=server)
