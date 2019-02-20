shinyUI(
  
  pageWithSidebar(
    headerPanel("My Course Assignment Shiny App"),
    
    sidebarPanel(
      
      selectInput("Data_Distribution", "Please select the Intended Distribution Type",
                  choices = c("Normal", "Exponential")),
      
      sliderInput("sampleSize", "Please select sample size: ",
                  min = 50, max =10000, value = 500, step= 50),
      
      conditionalPanel(condition = "input.Data_Distribution == 'Normal'",
                       textInput("Mean", "Please choose the mean", 10),
                       textInput("SD", "Please choose the Standard Deviation",4)),
      
      conditionalPanel(condition = "input.Data_Distribution == 'Exponential'",
                       textInput("Lambda", "Please choose the Lambda value", 1))
    ),
    mainPanel(
      
      plotOutput("myPlot")
      
    )
    
    
  )
  
  
)