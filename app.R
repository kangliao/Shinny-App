library(shiny)

# Define UI for slider demo app ----
ui <- fluidPage(
  
  ### the rest of your code
  tags$head(
    tags$style(HTML("
                    @import url('//fonts.googleapis.com/css?family=Lobster|Cabin:400,700');
                    
                    h1 {
                    font-family: 'Lobster', cursive;
                    font-weight: 600;
                    line-height: 1.5;
                    color: #cc0000;
                    }
                    
                    "))
    ),
  headerPanel("Find Your Traveling Destination"),
  
  tags$img(src = " http://www.bestfive.in/wp-content/uploads/2017/04/cropped-T0328COVERILLO2_HR.jpg", 
           width = "300px", height = "180px",align="right" ),
  # App title ----
  titlePanel("Filters"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar to demonstrate various slider options ----
    sidebarPanel(
      
      # Input: Simple integer interval ----
      sliderInput(inputId = "AQ",
                  label = "How important is the air quality of the place you visit(1 is very important, 3 not important?", 
                  min = 1, 
                  max = 3,
                  value = 2),
      sliderInput(inputId = "cost",
                  label = "To what extent that Buget is your concern (4:not a concern at all; 1: a big concern)", 
                  min = 1, 
                  max = 4,
                  value = 2), 
      sliderInput(inputId = "Transport",
                  label = "How convenient you think the public tansportation of the place would be (2: I don't care, 4: very convenient)?", 
                  min=2, max=4,
                  value=2),
      sliderInput(inputId = "VISA",
                  label = "How much time do you have for visa application?(2: Paper application required, 1:online application, 0: no visa required or visa upon arrival)",
                  min=0, max=2,
                  value=1),
      sliderInput(inputId ="flight",
                  label = "How much time maximum do you like to spend on flight?",
                  min = 0, max=24,
                  value=12),
      sliderInput(inputId ="temp",
                  label= "How do you like the temperature of the place",
                  min=40, max=86,
                  value=70)),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      # Output: Table summarizing the values entered ----
      titlePanel("Results"),
      tableOutput("table")
      
    )
  )
    )

# Define server logic for slider examples ----
server <- function(input, output) {
  
  output$table <- renderTable({
    d <- data %>% filter(data$AIrQualityLevel<=input$AQ &
                           data$CostofLivingLevel<=input$cost &
                           data$Public_Transit_Supply >= input$Transport&
                           data$Visa <= input$VISA &
                           data$FlightDurationInHour <= input$flight &
                           data$AverageTemp <= input$temp)
    d <- d[,c(2:3,5,7,9,12,15)]
  })
}  


# Create Shiny app ----
shinyApp(ui=ui, server=server)

