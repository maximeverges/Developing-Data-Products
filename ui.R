library(shiny)
library(ggplot2)
library(shinyBS)
library(shinythemes)
library(datasets)

data("mtcars")
min_cylinders = min(mtcars$cyl)
max_cylinders = max(mtcars$cyl)

min_displacement = min(mtcars$disp)
max_displacement = max(mtcars$disp)

min_horse_power = min(mtcars$hp)
max_horse_power = max(mtcars$hp)

min_drat = min(mtcars$drat)
max_drat = max(mtcars$drat)

min_weight = min(mtcars$wt)
max_weight = max(mtcars$wt)

min_qsec = min(mtcars$qsec)
max_qsec = max(mtcars$qsec)

min_forward_gears = min(mtcars$gear)
max_forward_gears = max(mtcars$gear)

min_carb = min(mtcars$carb)
max_carb = max(mtcars$carb)


# Default hypothetical car, in order to initialize th UI widgets.
default_values <- data.frame(
  cyl = 4, 
  disp = 71.1, 
  hp = 52, 
  drat = 2.76, 
  wt = 1.513, 
  qsec = 14.5, 
  vs = 0, 
  am = 0, 
  gear = 3, 
  carb = 1)

shinyUI(
  
  navbarPage(
    
    "MPG Prediction",
    
    theme = shinytheme("superhero"),
    
    tabPanel(
      
      "Prediction",
      
      sidebarPanel(
        
        width = 4,
        
        sliderInput("cyl", "Cylinders", min = min_cylinders, max = max_cylinders, value = default_values$cyl, step = 1),
        bsTooltip(id = "cyl", title = "Number of cylinders", placement = "right", options = list(container = "body")),
        
        sliderInput("disp", "Displacement", min = min_displacement, max = max_displacement, value = default_values$disp, step = 1),
        bsTooltip(id = "disp", title = "Displacement (cu.in.)", placement = "right", options = list(container = "body")),
        
        sliderInput("hp", "Gross horsepower", min = min_horse_power, max = max_horse_power, value = default_values$hp, step = 1),
        bsTooltip(id = "hp", title = "Gross horsepower", placement = "right", options = list(container = "body")),
        
        sliderInput("drat", "Rear axle ratio", min = min_drat, max = max_drat, value = default_values$drat, step = 0.01),
        bsTooltip(id = "drat", title = "Rear axle ratio", placement = "right", options = list(container = "body")),
        
        sliderInput("wt", "Weight", min = min_weight, max = max_weight, value = default_values$wt, step = 1),
        bsTooltip(id = "wt", title = "Weight (1000 lbs)", placement = "right", options = list(container = "body")),
        
        sliderInput("qsec", "1/4 mile time", min = min_qsec, max = max_qsec, value = default_values$qsec, step = 0.1),
        bsTooltip(id = "qsec", title = "1/4 mile time (seconds)", placement = "right", options = list(container = "body")),
        
        radioButtons("vs", label = "Cylinder configuration", choices = list("V-shape" = 0, "Straight" = 1), selected = 1, inline = TRUE),
        bsTooltip(id = "vs", title = "Cylinder configuration (V-shape or straight)", placement = "right", options = list(container = "body")),
        
        radioButtons("am", label = "Transmission type", choices = list("Automatic" = 0, "Manual" = 1), selected = 1, inline = TRUE),
        bsTooltip(id = "am", title = "Transmission type (automatic or manual)", placement = "right", options = list(container = "body")),
        
        sliderInput("gear", "Number of forward gears", min = min_forward_gears, max = max_forward_gears, value = default_values$gear, step = 1),
        bsTooltip(id = "gear", title = "Number of forward gears in the transmission", placement = "right", options = list(container = "body")),
        
        sliderInput("carb", "Number of carburetors", min = min_carb, max = max_carb, value = default_values$carb, step = 1),
        bsTooltip(id = "carb", title = "Number of carburetors", placement = "right", options = list(container = "body"))
        
      ),
      
      mainPanel(
        
        width = 8,
        
        h3("MPG Prediction"),
        
        br(),
        
        p("Your consumption will be: "),
        
        tableOutput("prediction")
        
      )
      
    ),
    
    tabPanel(
      
      "Help",
      
      p("A Random Forest prediction model is used for the mtcars dataset to predict the consumption"),
      
      p("Build your own car!"),
      
      p("Dataset used by the application is available ",
        a(href = "https://stat.ethz.ch/R-manual/R-devel/library/datasets/html/mtcars.html", "here"),
        "The dataset has been extracted from the 1974 Motor Trend US magazine. It highlights the fuel consumption regarding 10 parameters for 32 automobiles."
      ),
      
      tags$div("Next is the dataset structure:",
               tags$ul(
                 tags$li(strong("mpg"), "Miles/(US) gallon"),
                 tags$li(strong("cyl"), "Number of cylinders"),
                 tags$li(strong("disp"), "Displacement (cu.in.)"),
                 tags$li(strong("hp"), "Gross horsepower"),
                 tags$li(strong("drat"), "Rear axle ratio"),
                 tags$li(strong("drat", "Rear axle ratio"),
                 tags$li(strong("wt"), "Weight (1000 lbs)"),
                 tags$li(strong("qsec"), "1/4 mile time"),
                 tags$li(strong("vs"), "V/S (V-shape or straight)"),
                 tags$li(strong("am"), "Transmission (0 = automatic, 1 = manual)"),
                 tags$li(strong("gear"), "Number of forward gears"),
                 tags$li(strong("carb"), "Number of carburetors"))
               ),
               
               tableOutput("dataStructure")
               
      )
      
    ),
    
    tabPanel(
      
      "About",
      
      h3("Developing Data Products: Assignment 3 (the last but not at least)"),
      
      h3("Author: Maxime Verges - 25th of April, 2019"),
      
      br(),
      
      p("This application is a web application using R and ",
        a(href = "https://shiny.rstudio.com/", "Shiny library"),
        "corresponding to the last assignment from,",
        a(href = "https://www.coursera.org/learn/data-products", "Developing Data Products from Coursera")
      ),
      
      p("Source code is available at",
        a(href = "https://github.com/maximeverges/Developing-Data-Products",
          "https://github.com/maximeverges/Developing-Data-Products")
      )
      
    )
    
    
  )
  
)