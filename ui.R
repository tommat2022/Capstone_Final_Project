library(shiny)


shinyUI(fluidPage(
  
  # Application title
  titlePanel("Capstone Final Project"),

  sidebarLayout(
    sidebarPanel(
      helpText("Enter a sentence"),
      textInput("input_text", "sentence:",value = "How to find"),
      submitButton("Update View", icon("refresh")),
      h4('How to use it'),
      helpText("This application guess the next word you input."),
      h3(helpText("It takes some time to predict. Sorry for this inconvenience"))
    ),
    
    mainPanel(
      h2("Prediction of the next word"),
      #verbatimTextOutput("Guessing..."),
      h2(strong(code(textOutput('next_word')))),
      h5(tags$b('Bi-gram:')),
      textOutput('bigram'),
      h5(tags$b('Tri-gram:')),
      textOutput('trigram'),
      h5(tags$b('Quanti-gram:')),
      textOutput('quagram'),
    )
  )
))