####################################
# Data Professor                   #
# http://youtube.com/dataprofessor #
# http://github.com/dataprofessor  #
####################################

install.packages("randomForest", dependencies = T)

# Import libraries
library(shiny)
library(shinythemes)
library(data.table)
library(RCurl)
library(randomForest)

# Read data
Attend <- read.csv()

# Build model
model <- randomForest(play ~ ., data = Attend, ntree = 500, mtry = 4, importance = TRUE)

# Save model to RDS file
# saveRDS(model, "model.rds")

# Read in the RF model
#model <- readRDS("model.rds")

####################################
# User interface                   #
####################################

ui <- fluidPage(theme = shinytheme("united"),
  
  # Page header
  headerPanel('Play Golf?'),
  
  # Input values
  sidebarPanel(
    HTML("<h3>Input parameters</h3>"),
    
    selectInput("outlook", label = "Outlook:", 
                choices = list("Visa" = "VISA", "Mastercard" = "MASTERCARD", "Space" = "SPACE"), 
                selected = "SPACE"),
    sliderInput("money", "Money:",
                min = 11, max = 375,
                value = 70),
    sliderInput("quantity", "Quantity:",
                min = 0, max = 96,
                value = 90),
    selectInput("interest", label = "Interest:", 
                choices = list("Yes" = "TRUE", "No" = "FALSE"), 
                selected = "TRUE"),
    
    actionButton("submitbutton", "Submit", class = "btn btn-primary")
  ),
  
  mainPanel(
    tags$label(h3('Status/Output')), # Status/Output Text Box
    verbatimTextOutput('contents'),
    tableOutput('tabledata') # Prediction results table
    
  )
)

####################################
# Server                           #
####################################

server <- function(input, output, session) {

  # Input Data
  datasetInput <- reactive({  
    
  # outlook,temperature,humidity,windy,play
  df <- data.frame(
    Name = c("interest",
             "money",
             "quantity",
             "interest"),
    Value = as.character(c(input$interest,
                           input$money,
                           input$quantity,
                           input$interest)),
    stringsAsFactors = FALSE)
  
  Attandance <- "Attandance"
  df <- rbind(df, Attandance)
  input <- transpose(df)
  write.table(input,"input.csv", sep=",", quote = FALSE, row.names = FALSE, col.names = FALSE)
  
  test <- read.csv(paste("input", ".csv", sep=""), header = TRUE)
  
  test$interest <- factor(test$interest, levels = c("Mastercard", "Space", "Visa"))
  
  
  Output <- data.frame(Prediction=predict(model,test), round(predict(model,test,type="prob"), 3))
  print(Output)
  
  })
  
  # Status/Output Text Box
  output$contents <- renderPrint({
    if (input$submitbutton>0) { 
      isolate("Calculation complete.") 
    } else {
      return("Server is ready for calculation.")
    }
  })
  
  # Prediction results table
  output$tabledata <- renderTable({
    if (input$submitbutton>0) { 
      isolate(datasetInput()) 
    } 
  })
  
}

####################################
# Create the shiny app             #
####################################
shinyApp(ui = ui, server = server)
