
library(shiny)
source(file = "helpers.R")
# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("IzItOpen? "),
   
     selectInput("selectedLocation", 
                 "Location:",c()),
     
     actionButton("button", "IzItOpen" ),
     verbatimTextOutput("result",placeholder = T),
   helpText("This is an example datatable"),  
   tableOutput("example")

   )


# Define server logic required to draw a histogram
server <- function(input, output, session) {
   
  updateSelectInput(
    session, 
    inputId = "selectedLocation", 
    choices = locList )
  
   observeEvent(input$button, {
    loc <- input$selectedLocation
    x <-izitopen(loc)
    cat("x for ", loc, " is " , x, "\n")
    if(isTRUE(x)){
      text <- paste("Yay the location, ", loc, ", is open!!")
    }
    else{
      text <- paste("Opps the location, ", loc, ", is not open :(")
    }
    output$result <- renderText(text)
   })
   
   output$example <- renderTable(read.csv("data/TimingDB.csv", stringsAsFactors = F))

}

# Run the application 
shinyApp(ui = ui, server = server)

