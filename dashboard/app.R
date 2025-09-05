library(shiny)
library(shinydashboard)

ui <- dashboardPage(skin = "green",
  
  dashboardHeader(title = "Dataresc"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Início", tabName = "inicio", icon = icon("dashboard")),
      menuItem("Auditoria", tabName = "auditoria", icon = icon("hammer"))
    )
  ),
  dashboardBody(
    h1("Dataresc - Dados de redes de comunicação das escolas públicas brasileiras"),
    
    
    tabItems(
      tabItem(tabName = "inicio",
              fluidPage(
                h1("Análise inicial")
              )
      ),
      tabItem(tabName = "auditoria",
              fluidPage(
                h1("Auditoria")
              )
      )
    )
    
    
  )
  
)

server <- function(input, output) {
  
}


shinyApp(ui, server)