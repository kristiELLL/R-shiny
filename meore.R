library(shiny)



# Define UI ----
ui <- fluidPage(
  titlePanel("My Shiny App"),
  sidebarLayout(
    position = "left",
    sidebarPanel(
      h1(strong("Installation")),
      p("Shiny is available on CRAN, so you can install it in the usual way from R console"),
      code("install.packages(\"shiny\")"),
      img(src = "rstudio.png", height = 70, width = 200),
      br(),
      "Shiny is a product of ", 
      span("RStudio", style = "color:blue")
    ),
    mainPanel(
      p("p creates a paragraph of text."),
      p("A new p() command starts a new paragraph. Supply a style attribute to change the format of the entire paragraph.", style = "font-family: 'times'; font-si16pt"),
      strong("strong() makes bold text."),
      em("em() creates italicized (i.e, emphasized) text."),
      br(),
      code("code displays your text similar to computer code"),
      div("div creates segments of text with a similar style. This division of text is all blue because I passed the argument 'style = color:blue' to div", style = "color:blue"),
      br(),
      p("span does the same thing as div, but it works with",
        span("groups of words", style = "color:blue"),
        "that appear inside a paragraph."),
    )
  )
)
# 

# ფლუიდფეიჯი ყველაზე ხშირად გამოყენებადი ფუნქციაა და ui-ს შესაქმნელად გამოიყენება, 
# ჩვენ მას დავამატეთ ახლა თაითლი და საიდბარ ლეიაუთი. ფლიდფეიჯის გარდა ასევე არსებობს 
# navbarPage და fluidRow, column და სხვ.

# ფოტო ვერ ჩავსვი, ვერ გავახსნევინე.

# Define server logic ----
server <- function(input, output) {
  
}

# Run the app ----
shinyApp(ui = ui, server = server)


