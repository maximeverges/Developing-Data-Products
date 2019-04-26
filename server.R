library(shiny)
library(ggplot2)
library(caret)
library(randomForest)

####################################################################
#                                                                  #
# We choose the Random Forest model prediction and the predictors  #
# for _miles per gallon_ from the _mtcars_ dataset                 #
#                                                                  #
####################################################################

source(file = "RD_model.R")

####################################################################
#                                                                  #
#                    SETTING THE SHINY SERVER                      #
#                                                                  #
####################################################################
shinyServer(
  
  function(input, output, session) {
    
    # To show new lines in the browser
    decoratedDataStructure <- paste0(dataStructure, collapse = "<br/>")
    output$dataStructure <- renderText({decoratedDataStructure})
    
    # Builds "reactively" the prediction.
    predictMpg <- reactive({
      
      carToPredict <- data.frame(
        cyl = input$cyl, 
        disp = input$disp, 
        hp = input$hp, 
        drat = input$drat, 
        wt = input$wt, 
        qsec = input$qsec, 
        vs = as.numeric(input$vs), 
        am = as.numeric(input$am), 
        gear = input$gear, 
        carb = input$carb)
      
      random_forest_predicition(random_forest_model(), carToPredict)
      
    })
    
    output$prediction <- renderTable({
      predictMpg()
    })
    
  }
  
)