titanic <- as.data.frame(Titanic)
titanic <- titanic[titanic$Freq!=0,]
tita <- titanic[rep(1:nrow(titanic), times = titanic$Freq),c(1:4)]
newdataa <- unique(titanic[,1:3])
model <- glm(Survived~Sex+Age+Class, data = tita, family = "binomial")
titaPred <- function (class,sex,age) {
  Chujci <- newdataa[which(newdataa$Class==as.character(class)&newdataa$Sex==as.character(sex)&newdataa$Age==as.character(age)),]
  pred <- predict.glm(model,newdata=Chujci,type="response")
  pred[[1]]
}


shinyServer(
  function(input, output) {
    output$text1 <- renderText({input$input_class})
    output$text2 <- renderText({input$input_sex})
    output$text3 <- renderText({
      input$goButton
      if (input$goButton == 0) ""
      else
      isolate(paste(input$input_class,"class, ", input$input_sex,", ", input$input_age))
    })
    output$text4 <- renderText({
        input$goButton
        if (input$goButton == 0) ""
        else
          isolate(if (as.character(input$input_class)=="Crew"&as.character(input$input_age)=="Child") "Children do not work as crew members"
          else
          paste(round(titaPred(input$input_class,input$input_sex,input$input_age)*100,digits=1),"%",sep=""))})
    }
  
)