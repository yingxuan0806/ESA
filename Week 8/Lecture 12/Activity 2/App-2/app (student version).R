
# Load the shiny package
library(shiny)

# Load the ggplot2 package, which we'll need for the plot
library(ggplot2)


# 1. Define UI for app that draws a histogram ----
ui <- fluidPage(
  
  # App title ----
  titlePanel("Choosing your protein bar"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      # Input: Slider for protein content ---- FILL-IN THE MISSING PARTS (...)
      sliderInput(inputId = "weight_protein",
                  label = "Weight 1 (high protein content):",
                  min = 0,
                  max = 100,
                  value = 13.81),
      sliderInput(inputId = "weight_sodium",
                  label = "Weight 2 (low sodium content):",
                  min = 0,
                  max = 100,
                  value = 1.62),
      sliderInput(inputId = "weight_cholesterol",
                  label = "Weight 3 (low cholesterol content):",
                  min = 0,
                  max = 100,
                  value = 8.12),
      sliderInput(inputId = "weight_total_fat",
                  label = "Weight 4 (low total fat content):",
                  min = 0,
                  max = 100,
                  value = 1.62),
      sliderInput(inputId = "weight_saturated_fat",
                  label = "Weight 5 (low saturated fat content):",
                  min = 0,
                  max = 100,
                  value = 1.62),
      sliderInput(inputId = "weight_net_carbs",
                  label = "Weight 6 (low net carbs content):",
                  min = 0,
                  max = 100,
                  value = 73.20)
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      # Add a brief description of the app functionalities
      p("Use the sliderbars on the left to indicate your weight requirement (0 = not important; 100 = very important) for each category.
        The app calculates the score associated to each protein bar."),
      
      # Output: Barchart ---- FILL-IN THE LINES BELOW
      plotOutput(outputId = "barChart")
      
    )
  )
)


# 2. Define server logic required to draw a histogram ----
server <- function(input, output) {
  
    # The function renderPlot() generates a plot that is visualized by plotOutput()
    output$barChart <- renderPlot({
    
    # Load data
    data <- read.csv("protein_bars.csv")
    
    # Get weights (input from the ui)
    weights <- c(input$weight_protein, input$weight_sodium, input$weight_cholesterol, 
                 input$weight_total_fat, input$weight_saturated_fat, input$weight_net_carbs)
    
    # Normalize the weights
    if (sum(weights>0)) {
      w <- weights/sum(weights)
    } else {
      w <- c(0,0,0,0,0,0)
    }
    
    # Calculate the score associated to each protein bar and store the information in a dataframe
    score <- data.frame(name=c("Snickers_Marathon","Power_CARB_Select","GenSoy"), value=c(t(data) %*% w)) 

    # Create plot
    # barchart 
    p <- ggplot(data = score, 
      mapping = aes(x=name,y=value)) + 
      geom_bar(stat = "identity", color="blue", fill="white") +
      xlab("") + ylab("Value") 
    # Change fontsize and ticks of x and y axes
    p + theme( axis.title.y = element_text(color="Black", size=16, face="bold"),
               axis.text.y  = element_text(vjust=0.5, size=14),
               axis.text.x  = element_text(vjust=0.5, size=14)) + 
      scale_x_discrete(breaks=c("Snickers_Marathon","Power_CARB_Select","GenSoy"), 
                       labels=c("Snickers Marathon", "Power CARB", "GenSoy"))
    
  })
  
}


# 3. Call the shinyApp function
shinyApp(ui = ui, server = server)

