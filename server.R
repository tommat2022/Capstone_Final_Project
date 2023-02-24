library(shiny)
library(dplyr)
#library(tm)
#library(NLP)
library(shinycssloaders)
library(quanteda)
library(stringr)

#setwd("~/ドキュメント/Coursera勉強/Johns_Hopkins DATA SCIENCE/Data_Science_Capstone/Week7_final_project/Predict_Next_Words")
my_ngram1 <- readRDS("my_ngram1.RData")
my_ngram2 <- readRDS("my_ngram2.RData")
my_ngram3 <- readRDS("my_ngram3.RData")
my_ngram4 <- readRDS("my_ngram4.RData")
#my_ngram5 <- readRDS("my_ngram5.RData")


nextWord <- function(sentence, ngram=2){
  sentence_token <- tokens(sentence, remove_numbers = TRUE, remove_punct = TRUE,
                           remove_symbols = TRUE, remove_separators = TRUE,
                           remove_url = TRUE)
  sentence_last <- tail(last(sentence_token),1)
  sentence_last2 <- tail(last(sentence_token),2)
  sentence_last3 <- tail(last(sentence_token),3)
  qwords <- length(sentence)

  if(qwords > 0 & ngram==2){
    doc_kwic <- kwic(my_ngram1, pattern=sentence_last, window=1)
    doc_dfm <- dfm(tokens(doc_kwic$post))
    doc_top <- topfeatures(doc_dfm, n=1, decreasing=T)
    doc_table <- data.frame(doc_top)
    only_top <- row.names.data.frame(doc_table)
    return(only_top)
  }
  
  if(qwords > 0 & ngram==3){
    doc_kwic <- kwic(my_ngram3, pattern=sentence_last2, window=1,valuetype="regex")
    doc_dfm <- dfm(tokens(doc_kwic$post))
    doc_top <- topfeatures(doc_dfm, n=1, decreasing=T)
    doc_table <- data.frame(doc_top)
#    only_top <- row.names.data.frame(doc_table)
    doc_name <- row.names(doc_table)
    only_top <- str_split(doc_name, pattern = "_")
    only_top <- only_top[[1]][3]
    return(only_top)
  }
  
  if(qwords > 0 & ngram==4){
    doc_kwic <- kwic(my_ngram4, pattern=sentence_last3, window=1,valuetype="regex")
    doc_dfm <- dfm(tokens(doc_kwic$post))
    doc_top <- topfeatures(doc_dfm, n=1, decreasing=T)
    doc_table <- data.frame(doc_top)
    doc_name <- row.names(doc_table)
    only_top <- str_split(doc_name, pattern = "_")
    only_top <- only_top[[1]][4]
    return(only_top)
  }
}


# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  output$next_word <- renderText({
    word <- as.character(input$input_text)
    paste0(input$input_text," ",nextWord(word))
  })
  
  output$bigram <- renderText({
    word <- as.character(input$input_text)
    nextWord(word,2)
  })
  
  output$trigram <- renderText({
    word <- as.character(input$input_text)
    nextWord(word,3)
  })
  
  output$quagram <- renderText({
    word <- as.character(input$input_text)
    nextWord(word,4)
  })
  
})