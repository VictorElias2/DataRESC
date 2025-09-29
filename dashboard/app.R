library(shiny)
library(shinydashboard)
library(dplyr)
library(readxl)

ui <- dashboardPage(skin = "green",
  
  dashboardHeader(title = "Dataresc"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Início", tabName = "inicio", icon = icon("dashboard")),
      menuItem("Auditoria", tabName = "auditoria", icon = icon("hammer")),
      menuItem("Sobre", tabName = "sobre", icon = icon("info"))
    )
  ),
  dashboardBody(
    h1("Dataresc - Dados de redes de comunicação das escolas públicas brasileiras"),
    
    
    tabItems(
      
      # Conteúdo inicial do site, home
      tabItem(tabName = "inicio",
              fluidPage(
                h1("Análise inicial"),
                
                # ValueBoxes
                
                valueBoxOutput("totalEscolas", width = 4),
                valueBoxOutput("totalAlunos", width = 4),
                valueBoxOutput("totalAparelhos", width = 4),
                valueBoxOutput("mediaDownloadEntorno", width = 4),
                valueBoxOutput("mediaUploadEntorno", width = 4),
                valueBoxOutput("mediaKbytesAluno", width = 4),
                
                
                # Gráficos
                
                plotOutput("totalAlunosRegiao")
                
                
              )
      ),
      
      # Seção de auditoria do sistema, auditoria
      tabItem(tabName = "auditoria",
              fluidPage(
                h1("Auditoria")
              )
      ),
      
      
      # Seção sobre o sistema, sobre
      tabItem(tabName = "sobre",
              fluidPage(
                h1("Sobre o dashboard")
              )
      )
    )
    
    
  )
  
)

server <- function(input, output) {
  
  
  # Output dos ValueBoxes -----------------------------------------------------
  
  output$totalEscolas <- renderValueBox({
    valueBox(
      value = dbGetQuery(conn, "select count(escolar_co_entidade) from dados;"),
      subtitle = "Quantidade de escolas públicas",
      icon = icon("school"),
      color = "green"
    )
  })
  
  output$totalAlunos <- renderValueBox({
    valueBox(
      value = dbGetQuery(conn, "select sum(escolar_qtematriculas) from dados;"),
      subtitle = "Quantidade de alunos",
      icon = icon("users"),
      color = "green"
    )
  })
  
  output$totalAparelhos <- renderValueBox({
    valueBox(
      value = dbGetQuery(conn, "select sum(escolar_qt_desktop_aluno+escolar_qt_comp_portatil_aluno+escolar_qt_tablet_aluno) from dados;"),
      subtitle = "Quantidade aparelhos eletrônicos",
      icon = icon("computer"),
      color = "green"
    )
  })
  
  output$mediaDownloadEntorno <- renderValueBox({
    valueBox(
      value = dbGetQuery(conn, "select round(avg(simet_mean_tcp_down_mbps), 2) from dados;"),
      subtitle = "Média de TCP/Download no entorno das escolas",
      icon = icon("download"),
      color = "green"
    )
  })
  
  output$mediaUploadEntorno <- renderValueBox({
    valueBox(
      value = dbGetQuery(conn, "select round(avg(simet_mean_tcp_up_mbps), 2) from dados;"),
      subtitle = "Média de TCP/Upload no entorno das escolas",
      icon = icon("upload"),
      color = "green"
    )
  })
  
  output$mediaKbytesAluno <- renderValueBox({
    valueBox(
      value = dbGetQuery(conn, "select round(avg(simet_num_measures), 0) from dados
                                where simet_num_measures is not null;"),
      subtitle = "Média de medidas ao ano nas escolas",
      icon = icon("download"),
      color = "green"
    )
  })
  
  # GRÁFICOS --------------------------------------------------------------------
  
  output$totalAlunosRegiao <- renderPlot({
    temp <- dbGetQuery(conn, "SELECT nm_regiao, sum(escolar_qtematriculas) as matriculas 
                              from dados GROUP by nm_regiao;")
    plot(temp)
  })
  
}


shinyApp(ui, server)