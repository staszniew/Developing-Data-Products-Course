require(markdown)


titanic <- as.data.frame(Titanic)
titanic <- titanic[titanic$Freq!=0,]
tita <- titanic[rep(1:nrow(titanic), times = titanic$Freq),c(1:4)]

shinyUI(
  
  navbarPage("Titanic Survival Chance Calculation",
  tabPanel("Application",
  pageWithSidebar(
  headerPanel(h3("Would you have survived the Titanic catastrophe?")),
  sidebarPanel(
    radioButtons(inputId="input_class", label = "Pick your passenger class", choices = levels(tita$Class),inline = T),
    radioButtons(inputId="input_sex", label = "Pick you sex", choices = setNames(as.list(unique(tita$Sex)),unique(tita$Sex)),inline = T),
    selectInput(inputId = "input_age", label = "Pick your age", choices = setNames(as.list(unique(tita$Age)),unique(tita$Age)),
                selected = unique(tita$Age)[[1]], selectize = T, width = '200px'),
    actionButton("goButton", "Calculate your chance of surviving!"), width = 3
  ),
  mainPanel(
    h4('Your selection:'),
    textOutput('text3'),
    h4('Percentage of survival chance:'),
    textOutput('text4')
  )
)
)
,tabPanel("About", includeHTML("about.html"))
)
)