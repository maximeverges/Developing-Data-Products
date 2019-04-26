library(caret)
library(randomForest)

data("mtcars")

dataStructure <- capture.output(str(mtcars))

#Reproducible data
set.seed(12345)

training_control <- trainControl(method = "cv", number = 10)


random_forest_model <- function() {
  
  return(
    train(
      mpg ~ ., 
      data = mtcars,
      method = "rf",
      trControl = training_control
    )
  )
  
}


random_forest_predicition <- function(model, parameters) {
  
  prediction <- predict(
    model,
    newdata = parameters
  )
  
  return(prediction)
  
}